Set this up under a new profile:

```bash
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/shiver/dotfiles $HOME/dotfiles-tmp
cp -r $HOME/dotfiles-tmp/. $HOME
rm -r $HOME/dotfiles-tmp
```

Restart your terminal and then from this point on you interact with configuration using `config`.
At minimum you should run `config config status.showUntrackedFiles no` to stop git from showing untracked files.

```bash
config status
config add new.file
config commit -m "message"
config push
```

WARNING: This will destroy any existing dotfiles you have in your $HOME.
