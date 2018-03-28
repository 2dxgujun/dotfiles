if [ -n "$TMUX" ]; then
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  	STATUS_BG='blue'
  else
  	STATUS_BG='green'
	fi
	tmux set -g status-bg $STATUS_BG
fi