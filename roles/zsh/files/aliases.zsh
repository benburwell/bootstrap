# navigation shortcuts
alias c="cd"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
if [[ $(uname) == "Darwin" || $(uname) == "FreeBSD" ]]; then
  alias l="ls -lAhG"
  alias la="ls -lAGh"
  alias ll="ls -lGh"
  alias ls="ls -Gh"
else
  alias l="ls -lah --color"
  alias la="ls -la --color"
  alias ll="ls -l --color"
  alias ls="ls --color"
fi

# git
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gbs="git-branches"
alias gc="git commit"
alias gcb="git checkout -b"
alias gco="git checkout"
alias gd="git diff"
alias gds="git diff --staged"
alias gf="git fetch"
alias gl="git pull"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%aN>%Creset' --abbrev-commit"
alias gm="git merge"
alias gp="git push"
alias gs="git status"
alias gsl="git stash list"
alias gsp="git stash pop"
alias gss="git stash save"
alias gt="git tag"

# docker-compose
alias dc="docker-compose"
alias dcd="docker-compose down"
alias dcl="docker-compose pull"
alias dcu="docker-compose up"
alias dcud="docker-compose up -d"

# docker
alias d="docker"

# edit
alias e="nvim"
alias ee="nvim -u NONE"
alias es="nvim -S Session.vim"

# make
alias m="make"

# pass
alias p="pass"
alias pc="pass --clip"
alias pgp="pass git push"
alias pgl="pass git pull"
alias poc="pass otp --clip"

# kubernetes
alias k="kubectl"

# hub
alias hb="hub browse"
alias hbl="hub browse -- pulls"
alias hbc="hub browse -- commits"

alias x="extract"
