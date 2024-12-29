pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
require("awful.autofocus")
require("logging")


-- Handle startup errors
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Startup error",
		text = awesome.startup_errors
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		if in_error then return end
		in_error = true
		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Error",
			text = tostring(err)
		})
		in_error = false
	end)
end

-- Copyright Pavel Makhov
-- MIT
-- https://github.com/streetturtle/awesome-wm-widgets
local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")

-- theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

terminal = "kitty"
editor = "nvim"
modkey = "Mod4"
altkey = "Mod1"

naughty.config.defaults["icon_size"] = 25
awful.mouse.snap.default_distance = 64

-- layouts
awful.layout.layouts = {
	awful.layout.suit.max,
	awful.layout.suit.tile.right,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.fair
}

-- create and add a wibox for each screen
awful.screen.connect_for_each_screen(function(s)
	gears.wallpaper.set("#2E3440")

	awful.tag({"○", "○", "○", "○", "○"}, s, awful.layout.layouts[1])

	s.tag_list = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = gears.table.join(
			awful.button({}, 1,
				function(t)
					t:view_only()
				end
			),
			awful.button({modkey, "Control"}, 1,
				function(t)
					if client.focus then
						client.focus:move_to_tag(t)
						tag.emit_signal("property::selected", t, t.selected)
					end
				end
			),
			awful.button({modkey, altkey}, 1,
				awful.tag.viewtoggle
			),
			awful.button({modkey, "Shift"}, 1,
				function(t)
					if client.focus then
						client.focus:toggle_tag(t)
						tag.emit_signal("property::selected", t, t.selected)
					end
				end
			),
			awful.button({}, 4,
				function(t)
					awful.tag.viewprev(t.screen)
				end
			),
			awful.button({}, 5,
				function(t)
					awful.tag.viewnext(t.screen)
				end
			)
		)
	}

	s.task_list = awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = gears.table.join(
			awful.button({}, 1,
				function(c)
					if c == client.focus then
						c.minimized = true
					else
						c:emit_signal(
							"request::activate",
							"tasklist",
							{raise = true}
						)
					end
				end
			),
			awful.button({}, 2,
				function(c)
					c:kill()
				end
			),
			awful.button({}, 4,
				function()
					awful.client.focus.byidx(-1)
				end
			),
			awful.button({}, 5,
				function()
					awful.client.focus.byidx(1)
				end
			)
		)
	}

	witextclock = wibox.widget.textclock("%F %T (%a)", 1)

	-- spawn gsimplecal on click
	witextclock:connect_signal("button::press", function(_, _, _, button)
		if button == 1 then
			awful.spawn("gsimplecal")

			-- remove gsimplecal on focus loss
			client.connect_signal("unfocus", function(c)
				if c.name == "gsimplecal" then
					c:kill()
				end
			end)
		end
	end)

	s.mywibox = awful.wibar({
		position = "top",
		screen = s
	})

	-- wibox add widgets
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		s.tag_list,
		s.task_list,
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = 4,
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = 4,
			},
			witextclock,
			battery_widget(),
			volume_widget {
				widget_type = "icon_and_text",
			},
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = 4,
			}
		},
	}
end)

function change_brightness(mult)
	awful.spawn.easy_async("xbacklight -get", function(stdout)
		local brightness = math.floor(stdout + 0.5)
		awful.util.spawn("xbacklight -set " .. tostring(brightness + (brightness+mult <= 5 and 1 or 5) * mult) .. " -time 0", false)

		awful.spawn.easy_async("xbacklight -get", function(stdout)
			naughty.destroy(brightness_notification)
			brightness_notification = naughty.notify({
				title = "Brightness",
				text = tostring(math.floor(stdout + 0.5)),
				timeout = 0.5
			})
		end)
	end)
end

-- global key bindings
global_keys = gears.table.join(
	-- help
	awful.key({modkey}, "s",
		hotkeys_popup.show_help,
		{description="show help", group="awesome"}
	),

	-- reload
	awful.key({modkey, "Control"}, "r",
		awesome.restart,
		{description="reload awesome", group="awesome"}
	),

	-- fullscreen
	awful.key({modkey}, "f",
		function()
			local screen = awful.screen.focused()
			screen.mywibox.visible = not screen.mywibox.visible
		end,
		{description = "toggle fullscreen", group="client"}
	),

	-- change tag
	awful.key({modkey}, "Left",
		function()
			awful.tag.viewprev()
		end,
		{description="view previous", group="tag"}
	),
	awful.key({modkey}, "Right",
		function()
			awful.tag.viewnext()
		end,
		{description="view next", group="tag"}
	),

	-- focus master
	awful.key({"Control", altkey}, "Return",
		function()
			local master = awful.client.getmaster()
			if client.focus then
				client.focus = master
				master:raise()
			end
		end,
		{description="focus to master", group="client"}
	),

	-- change tag order
	awful.key({modkey, "Shift"}, "Left",
		function()
			awful.tag.move(awful.screen.focused().selected_tag.index - 1, awful.screen.focused().selected_tag)
		end,
		{description="swap with previous tag", group="tag"}
	),
	awful.key({modkey, "Shift"}, "Right",
		function()
			awful.tag.move(awful.screen.focused().selected_tag.index + 1, awful.screen.focused().selected_tag)
		end,
		{description="swap with next tag", group="tag"}
	),

	-- change layout
	awful.key({modkey}, "l",
		function()
			awful.layout.inc(1)
		end,
		{description="select next", group="layout"}
	),
	awful.key({modkey, "Shift"}, "l",
		function()
			awful.layout.inc(-1)
		end,
		{description="select previous", group="layout"}
	),

	-- launchers
	awful.key({modkey}, "Return",
		function()
			awful.spawn(terminal)
		end,
		{description="open terminal", group="launcher"}
	),
	awful.key({modkey, "Control", altkey, "Shift"}, "l",
		function()
			awful.spawn(terminal .. " sptlrx")
		end,
		{description="open sptlrx", group="launcher"}
	),
	awful.key({"Control", altkey}, "f",
		function()
			awful.spawn("nemo")
		end,
		{description="open nemo", group="launcher"}
	),
	awful.key({modkey, altkey}, "d",
		function()
			awful.spawn("gromit-mpx")
		end,
		{description="open gromit-mpx", group="launcher"}
	),
	awful.key({modkey, "Control", altkey, "Shift"}, "s",
		function()
			awful.spawn.with_shell("pkill screenkey || screenkey -g 400x200+1200+700")
		end,
		{description="toggle screenkey", group="launcher"}
	),

	-- rofi
	awful.key({modkey}, "space",
		function()
			awful.spawn("rofi -show drun")
		end,
		{description="show rofi", group="launcher"}
	),
	awful.key({modkey, "Control"}, "space",
		function()
			awful.spawn("rofi -show calc -modi calc -no-show-match -no-sort -no-persist-history")
		end,
		{description="show calculator", group="launcher"}
	),
	awful.key({modkey, altkey}, "space",
		function()
			awful.spawn("clipton")
		end,
		{description="show clipton", group="launcher"}
	),

	-- screenshot
	awful.key({}, "Print",
		function()
			awful.spawn("scrot -z -e 'mv $f ~/screenshots/%Y-%m-%dT%T.png'")
		end,
		{description="screenshot", group="screenshot"}
	),
	awful.key({"Shift"}, "Print",
		function()
			awful.spawn("scrot -z -f -s -e 'mv $f ~/screenshots/%Y-%m-%dT%T.png'")
		end,
		{description="screenshot with selection", group="screenshot"}
	),
	awful.key({"Control"}, "Print",
		function()
			awful.spawn("scrot -z -e 'xclip -selection clipboard -t image/png -i $f && mv $f ~/screenshots/%Y-%m-%dT%T.png'")
		end,
		{description="screenshot copy", group="screenshot"}
	),
	awful.key({"Control", "Shift"}, "Print",
		function()
			awful.spawn("scrot -z -f -s -e 'xclip -selection clipboard -t image/png -i $f && mv $f ~/screenshots/%Y-%m-%dT%T.png'")
		end,
		{description="screenshot copy with selection", group="screenshot"}
	),

	-- volume
	awful.key({}, "XF86AudioRaiseVolume",
		function()
			awful.util.spawn("amixer set Master 5%+", false)
		end,
		{description = "volume up", group="volume"}
	),
	awful.key({}, "XF86AudioLowerVolume",
		function()
			awful.util.spawn("amixer set Master 5%-", false)
		end,
		{description = "volume down", group="volume"}
	),
	awful.key({}, "XF86AudioMute",
		function()
			awful.util.spawn("amixer set Master toggle", false)
		end,
		{description = "toggle mute", group="volume"}
	),

	-- brightness
	awful.key({}, "XF86MonBrightnessUp",
		function()
			change_brightness(1)
		end,
		{description = "brightness up", group="brightness"}
	),
	awful.key({}, "XF86MonBrightnessDown",
		function()
			change_brightness(-1)
		end,
		{description = "brightness down", group="brightness"}
	),

	-- awesome config
	awful.key({modkey}, "XF86Tools",
		function()
			awful.util.spawn(terminal .. " spf " .. awful.util.getdir("config"))
		end,
		{description="awesome config", group="awesome"}
	)
)

-- client key bindings
client_keys = gears.table.join(
	-- close
	awful.key({modkey}, "w",
		function(c)
			c:kill()
		end,
		{description = "close", group="client"}
	),

	-- change client focus
	awful.key({"Control", altkey}, "Left",
		function()
			awful.client.focus.byidx(-1)
		end,
		{description="focus previous by index", group="client"}
	),
	awful.key({"Control", altkey}, "Right",
		function()
			awful.client.focus.byidx(1)
		end,
		{description="focus next by index", group="client"}
	),

	-- change client order
	awful.key({modkey, "Control"}, "Left",
		function()
			awful.client.swap.byidx(-1)
		end,
		{description="swap with next client", group="client"}
	),
	awful.key({modkey, "Control"}, "Right",
		function()
			awful.client.swap.byidx(1)
		end,
		{description="swap with previous client", group="client"}
	),

	-- move client to master
	awful.key({modkey, "Control"}, "Return",
		function(c)
			c:swap(awful.client.getmaster())
		end,
		{description = "move to master", group="client"}
	),

	-- move client to next tag
	awful.key({modkey, altkey}, "Right",
		function()
			local tag = client.focus.screen.tags[client.focus.screen.selected_tag.index + 1]
			if tag then
				client.focus:move_to_tag(tag)
				tag:emit_signal("property::selected", tag, tag.selected)
			end
		end,
		{description = "move focused client to next tag", group="client"}
	),
	awful.key({modkey, altkey}, "Left",
		function()
			local tag = client.focus.screen.tags[client.focus.screen.selected_tag.index - 1]
			if tag then
				client.focus:move_to_tag(tag)
				tag:emit_signal("property::selected", tag, tag.selected)
			end
		end,
		{description = "move focused client to previous tag", group="client"}
	),

	-- minimize
	awful.key({modkey}, "m",
		function(c)
			c.minimized = true
		end ,
		{description = "minimize", group="client"}
	),

	-- maximize
	awful.key({modkey, "Control"}, "m",
		function(c)
			c.maximized = not c.maximized
			c:raise()
		end ,
		{description = "toggle maximize", group="client"}
	),

	-- floating
	awful.key({modkey, "Control"}, "f",
		function(c)
			c.floating = not c.floating
		end,
		{description="toggle floating", group="client"}
	),

	-- fullscreen
	awful.key({modkey, "Control", "Shift"}, "f",
		function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{description="toggle fullscreen", group="client"}
	),

	-- ontop
	awful.key({modkey, "Control"}, "t",
		function(c)
			c.ontop = not c.ontop
		end,
		{description="toggle top", group="client"}
	),

	-- sticky
	awful.key({modkey, "Control"}, "s",
		function(c)
			c.sticky = not c.sticky
		end,
		{description="toggle sticky", group="client"}
	)
)

-- tag key bindings
for i = 1, 5 do
	global_keys = gears.table.join(
		global_keys,

		-- View tag only.
		awful.key({modkey}, "#" .. i + 9,
			function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			{description = "view tag " .. i, group="tag"}
		),

		-- Toggle tag display.
		awful.key({modkey, altkey}, "#" .. i + 9,
			function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end,
			{description = "toggle tag #" .. i, group="tag"}
		),

		-- Move client to tag.
		awful.key({modkey, "Control"}, "#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
						tag:emit_signal("property::selected", tag, tag.selected)
					end
				end
			end,
			{description = "move focused client to tag #" .. i, group="tag"}
		),

		-- Toggle tag on focused client.
		awful.key({modkey, "Shift"}, "#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
						tag:emit_signal("property::selected", tag, tag.selected)
					end
				end
			end,
			{description = "toggle focused client on tag #" .. i, group="tag"}
		)
	)
end

-- global button bindings
global_buttons = gears.table.join(
	awful.button({}, 4,
		awful.tag.viewprev
	),
	awful.button({}, 5,
		awful.tag.viewnext
	)
)

-- client button bindings
client_buttons = gears.table.join(
	awful.button({}, 1,
		function(c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
		end
	),
	awful.button({modkey, "Control"}, 1,
		function(c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.move(c)
		end
	),
	awful.button({modkey, "Control"}, 3,
		function(c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.resize(c)
		end
	)
)

root.keys(global_keys)
root.buttons(global_buttons)

-- rules
awful.rules.rules = {
	-- all clients
	{
		rule = {},
		properties = {
			focus = awful.client.focus.filter,
			raise = true,
			keys = client_keys,
			buttons = client_buttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			titlebars_enabled = false
		}
	},

	-- floating clients
	{
		rule_any = {
			instance = {
				"DTA",
				"copyq",
				"pinentry",
			},
			class = {
				"Gpick",
				"file-roller",
				"windowkill-vulkan.exe"
			},
			name = {
				"Event Tester",
				"Add a new game"
			},
			role = {
				"AlarmWindow",
				"ConfigManager",
				"pop-up"
			}
		},
		properties = {
			floating = true
		}
	},

	-- ontop clients
	{
		rule_any = {
			class = {
				"Gpick",
				"file_progress"
			}
		},
		properties = {
			ontop = true
		}
	},

	-- sptlrx
	{
		rule_any = {
			name = {
				"sptlrx"
			}
		},
		properties = {
			raise = false,
			floating = true,
			ontop = true,
			width = 400,
			height = 200,
			x = awful.screen.focused().geometry.width - 400,
			y = awful.screen.focused().geometry.height - 200
		}
	}
}

-- signals
client.connect_signal("manage", function(c)
	-- starts new clients as slaves (last in the client list)
	if not awesome.startup then
		awful.client.setslave(c)
	end

	-- prevent clients from being unreachable after screen count changes.
	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end
end)

-- change tag name depending on client count and focus
tag.connect_signal("property::selected", function(t)
	if t.selected then
		t.name = "◉"
	elseif t.urgent then
		t.name = "◉"
	elseif #t:clients() > 0 then
		t.name = "◉"
	else
		t.name = "○"
	end
end)

-- focus client on mouse enter
client.connect_signal("mouse::enter", function(c)
	client.focus = c
end)

-- reaply rules on name change
client.connect_signal("property::name", function(c)
	if c.name == "sptlrx" then
		awful.rules.apply(c)
	end
end)

-- set tag names after startup
gears.timer.delayed_call(function()
	for _, tag in pairs(awful.screen.focused().tags) do
		tag:emit_signal("property::selected", tag, tag.selected)
	end
end)
