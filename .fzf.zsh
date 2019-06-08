# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/freeplusn251/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/freeplusn251/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/freeplusn251/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/freeplusn251/.fzf/shell/key-bindings.zsh"

