# Environment Necessary Exports
export TERM=vt100 # Ensure terminal is connected properly (fixes several potential bugs with some terminal emulators)
export COMOTO_PROJECT_ROOT="/workspaces" # Required by bash_functions.sh

# Run setup.sh, at least once `sh /workspaces/dev-hub/setup.sh`
if [ ! -f ~/.setup_has_run ]
then
  echo "⌛ Running setup.sh"
  sh /workspaces/dev-hub/setup.sh
  touch ~/.setup_has_run
fi

# bash_functions.sh
echo "👌 Sourcing bash_functions.sh"
source /workspaces/monorepo/zlaverse/support/bash_functions.sh # allows us to call things like `cg-load-test-schema`

# Colors fixes
export LS_COLORS='fi=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:'
LS_COLORS+='pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;35:sg=01;35:ca=0'

# Move to directory most used (for me, that is monorepo)
cd /workspaces/monorepo/

# oh my zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gnzh" # set by `omz`
MAGIC_ENTER_GIT_COMMAND='git status -u . | bat --style=plain -l=sh'
MAGIC_ENTER_OTHER_COMMAND='ls -lh . | bat --paging=never -l=ls'
plugins=(git gh rake zsh-autosuggestions rails ssh mise mix bun docker docker-compose magic-enter sudo)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true

# Mise activate
export MISE_SHELL=zsh
export __MISE_ORIG_PATH="$PATH"

mise() {
  local command
  command="${1:-}"
  if [ "$#" = 0 ]; then
    command mise
    return
  fi
  shift

  case "$command" in
  deactivate|shell|sh)
    # if argv doesn't contains -h,--help
    if [[ ! " $@ " =~ " --help " ]] && [[ ! " $@ " =~ " -h " ]]; then
      eval "$(command mise "$command" "$@")"
      return $?
    fi
    ;;
  esac
  command mise "$command" "$@"
}

_mise_hook() {
  eval "$(mise hook-env -s zsh)";
}
typeset -ag precmd_functions;
if [[ -z "${precmd_functions[(r)_mise_hook]+1}" ]]; then
  precmd_functions=( _mise_hook ${precmd_functions[@]} )
fi
typeset -ag chpwd_functions;
if [[ -z "${chpwd_functions[(r)_mise_hook]+1}" ]]; then
  chpwd_functions=( _mise_hook ${chpwd_functions[@]} )
fi

if [ -z "${_mise_cmd_not_found:-}" ]; then
    _mise_cmd_not_found=1
    [ -n "$(declare -f command_not_found_handler)" ] && eval "${$(declare -f command_not_found_handler)/command_not_found_handler/_command_not_found_handler}"

    function command_not_found_handler() {
        if mise hook-not-found -s zsh -- "$1"; then
          _mise_hook
          "$@"
        elif [ -n "$(declare -f _command_not_found_handler)" ]; then
            _command_not_found_handler "$@"
        else
            echo "zsh: command not found: $1" >&2
            return 127
        fi
    }
fi
