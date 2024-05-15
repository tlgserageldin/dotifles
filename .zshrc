# extend path
export PATH=$HOME/.local/bin:$PATH

# colored output
export LS_COLORS="true"

# term
export TERM="xterm-256color"

# if ssh then use vim
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# fzf settings
export FZF_DEFAULT_OPTS='--layout=reverse --height 40%'
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
## add fzf to path
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi
## autocomp
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null
## keybindings
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# aliases
## ls
alias ls='ls -G'
alias l='ls -al'
alias ll='ls -l'
alias la='ls -a'
## gcc explicit call
alias gcc='gcc-13'
## neovim 
alias vim='nvim'
alias v='vim'
## reload
alias reload='source $HOME/.zshrc'
## dotfiles
alias dotfiles='/usr/bin/git --git-dir=/Users/tariqs/.dotfiles/ --work-tree=/Users/tariqs'
## change to a fuzzy found sub-directory
alias fd='cd $(rg --hidden --sort-files --files --null 2> /dev/null | xargs -0 dirname 2> /dev/null | uniq | fzf)'


