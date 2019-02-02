export PROJECTS=~/code
export VIRTYX_DIR="$PROJECTS/src/github.com/virtyx-technologies"
export GITHUB_TOKEN=
export PASSWORD_STORE_GENERATED_LENGTH=
export GOPATH="$PROJECTS"
export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true
export EDITOR=nvim
export LICENSE_FULL_NAME="Ben Burwell"
export WWW_HOME="https://duckduckgo.com/"
export LYNX_LSS="$HOME/.lynx.lss"
export LYNX_CFG="$HOME/.lynx.cfg"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export NVM_DIR="$HOME/.nvm"
export CDPATH=$(find "$PROJECTS/src" -maxdepth 1 -type d -print0 | tr '\0' ':')$HOME
export SSLKEYLOGFILE="$HOME/.mitmproxy/sslkeylogfile.txt"
export PROMPT="%F{black}%~%f "
