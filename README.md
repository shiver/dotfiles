Set this up under a new profile:

```bash
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/shiver/dotfiles $HOME/dotfiles-tmp
cp -r $HOME/dotfiles-tmp $HOME
rm -r $HOME/dotfiles-tmp
```

WARNING: This will destroy any existing dotfiles you have in your $HOME.
