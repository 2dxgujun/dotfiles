# Unzips
alias -s tar="tar -xvf"
alias -s gz="tar -xzvf"
alias -s tgz="tar -xzvf"
alias -s zip="unzip"

alias cls="clear"

alias zshrc="$EDITOR ~/.zshrc && source ~/.zshrc"

# Tell grep to highlight matches
GREP_OPTIONS="--color=auto"
alias grep="grep $GREP_OPTIONS"

alias lg="lazygit"
alias adbtop="adb shell dumpsys window windows | grep -E 'mCurrentFocus|mFocusedApp'"
alias typora="open -a typora"
