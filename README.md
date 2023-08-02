# Command for Migrating/New System
```sh
echo ".dotfiles" >> .gitignore
alias dotfiles='/usr/bin/git --git-dir=/Users/<USERNAME>/.dotfiles/ --work-tree=/Users/<USERNAME>'
git clone --bare https://github.com/tlgserageldin/dotifles $HOME/.dotfiles
dotfiles checkout
```

#Font
JetBrainsMono Nerd Font

