local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gfs = require("gears.filesystem")
local gears = require("gears")
local themes_path = gfs.get_themes_dir()


local theme = {}

theme.font = "sans 8"

theme.bg_normal = "#2E3440"
theme.bg_focus = "#4C566A"
theme.bg_urgent = "#BF616A"
theme.bg_minimize = "#232831"
theme.bg_systray = "#232831"
theme.fg_normal = "#AAAAAA"
theme.fg_focus = "#ECEFF4"
theme.fg_urgent = "#ECEFF4"
theme.fg_minimize = "#ECEFF4"

local dpi = xresources.apply_dpi
theme.useless_gap = dpi(0)
theme.border_width = dpi(0)
theme.border_normal = "#282828"
theme.border_focus = "#4C566A"
theme.border_marked = "#BF616A"

theme.taglist_font = "sans 10"

theme.icon_theme = nil

theme.snap_bg = "#4C566A"
theme.snap_shape = function(cr, width, height)
	gears.shape.rounded_rect(cr, width, height, dpi(6))
end

-- theme.hotkeys
theme.hotkeys_modifiers_fg = "#AAAAAA"

return theme
