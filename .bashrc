#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export TERM=screen-256color
export EDITOR=vim

alias ls='ls --color=auto'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

export WORKON_HOME=~/.virtualenvs
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export GOPATH=$HOME/go
export PATH=$PATH:$HOME/.cargo/bin:$GOPATH/bin
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

