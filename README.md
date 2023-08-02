# Command for Migrating/New System
```sh
echo ".dotfiles" >> .gitignore
alias dotfiles='/usr/bin/git --git-dir=/Users/tariqs/.dotfiles/ --work-tree=/Users/tariqs'
git clone --bare https://github.com/tlgserageldin/dotifles $HOME/.dotfiles
dotfiles checkout
```

#Font
JetBrainsMono Nerd Font

