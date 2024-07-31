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
alias sd='cd $(rg --hidden --sort-files --files --null 2> /dev/null | xargs -0 dirname 2> /dev/null | uniq | fzf)'

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Have less display colours
# from: https://wiki.archlinux.org/index.php/Color_output_in_console#man
export LESS="--RAW-CONTROL-CHARS"
export Pager='less'
export MANPAGER='less -s -M +Gg'
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal
