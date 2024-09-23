[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

shopt -s histappend
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export EDITOR="nano"
export TERM="kitty"
export NNN_TRASH=1

nnn() {
	export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

	command nnn "$@"

	[ ! -f "$NNN_TMPFILE" ] || {
		. "$NNN_TMPFILE"
		rm -f -- "$NNN_TMPFILE" > /dev/null
	}
}

spf() {
	export SPF_LAST_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/superfile/lastdir"

	command spf "$@"

	[ ! -f "$SPF_LAST_DIR" ] || {
		. "$SPF_LAST_DIR"
		rm -f -- "$SPF_LAST_DIR" > /dev/null
	}
}

cclear() {
	cd
	clear
}

date-dir() {
	mkdir $(date --iso)
	cd $(date --iso)
}

gclone() {
	git clone "$1"
	cd "$(basename "$1" .git)"
}

alias ..="cd .."
alias df="df -T -H"
alias dot-sync="~/scripts/dot-sync.sh"
alias download="yt-dlp --embed-thumbnail --add-metadata --sub-langs all,-live_chat --convert-subs srt --embed-subs --download-archive '~/.yt-dlp/archive.txt' --"
alias duf="duf --si --hide special --hide-mp /boot"
alias feh="feh --scale-down --image-bg '#2E3440'"
alias gallery-dl="gallery-dl --config ~/.config/gallery-dl/config.conf"
alias grep="grep --color=auto"
alias http-server="python -m http.server 8080"
alias icat="kitten icat --align left"
alias journalctl="journalctl -b --no-pager -u"
alias ls="ls -l -G -h --si --color=auto"
alias lsblk="lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL,UUID"
alias nano="nano -i"
alias off="sudo shutdown -h now"
alias rm="trash-put"
alias room-temp="ssh rpi.local python room-temp/main.py"
alias spf="spf ."
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias watch="watch -c -n 0.1"
alias yay="yay --answerdiff None --answerclean None --removemake"