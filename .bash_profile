
#################################
# git bash prompt
# https://digitalfortress.tech/tutorial/setting-up-git-prompt-step-by-step/
# https://unix.stackexchange.com/questions/570419/python-venv-module-cannot-add-virtual-environment-name-to-ps1-when-using-prompt
#################################
# store colors
MAGENTA="\[\033[0;35m\]"
YELLOW="\[\033[01;33m\]"
BLUE="\[\033[00;34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[0;36m\]"
GREEN="\[\033[00;32m\]"
RED="\[\033[0;31m\]"
VIOLET='\[\033[01;35m\]'

function color_my_prompt {
  local __venv_ps1=""
    if [ -n "${VIRTUAL_ENV}" ] && [ -z "${VIRTUAL_ENV_DISABLE_PROMPT:-}" ]; then
      if [ "`basename \"$VIRTUAL_ENV\"`" = "__" ] ; then
         # special case for Aspen magic directories
         # see http://www.zetadev.com/software/aspen/
         __venv_ps1="[`basename \`dirname \"$VIRTUAL_ENV\"\``] "
      else
         __venv_ps1="(`basename \"$VIRTUAL_ENV\"`) "
      fi
   fi
  local __user_and_host="$GREEN\u@\h"
  local __cur_location="$BLUE\W"           # capital 'W': current directory, small 'w': full file path
  local __git_branch_color="$GREEN"
  local __prompt_tail="$VIOLET$"
  local __user_input_color="$LIGHT_GRAY"
  local __git_branch=$(__git_ps1);

  # colour branch name depending on state
  if [[ "${__git_branch}" =~ "*" ]]; then     # if repository is dirty
      __git_branch_color="$RED"
  elif [[ "${__git_branch}" =~ "$" ]]; then   # if there is something stashed
      __git_branch_color="$YELLOW"
  elif [[ "${__git_branch}" =~ "%" ]]; then   # if there are only untracked files
      __git_branch_color="$LIGHT_GRAY"
  elif [[ "${__git_branch}" =~ "+" ]]; then   # if there are staged files
      __git_branch_color="$CYAN"
  fi

  # Build the PS1 (Prompt String)
  PS1="$__venv_ps1$__user_and_host $__cur_location$__git_branch_color$__git_branch $__prompt_tail$__user_input_color "
}

# configure PROMPT_COMMAND which is executed each time before PS1
export PROMPT_COMMAND=color_my_prompt
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# if .git-prompt.sh exists, set options and execute it
if [ -f ~/.git-prompt.sh ]; then
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_HIDE_IF_PWD_IGNORED=true
  GIT_PS1_SHOWCOLORHINTS=true
  . ~/.git-prompt.sh
fi
