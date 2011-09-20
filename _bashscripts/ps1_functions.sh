#!/usr/bin/env bash

#
# Source this file in your ~/.bash_profile or interactive startup file.
# This is done like so:
#
#    [[ -s "$HOME/.rvm/contrib/ps1_functions" ]] &&
#      source "$HOME/.rvm/contrib/ps1_functions"
#
# Then in order to set your prompt you simply do the following for example
#
# Examples:
#
#   ps1_set --prompt ∫
#
#   or
#
#   ps1_set --prompt ∴
#
# This will yield a prompt like the following, for example,
#
# 00:00:50 wayneeseguin@GeniusAir:~/projects/db0/rvm/rvm  (git:master:156d0b4)  ruby-1.8.7-p334@rvm
# ∴
#

ps1_identity()
{
  if [[ $UID -eq 0 ]]  ; then
    printf "\[\033[31m\]\\\u\[\033[0m\]@\[\033[36m\]\\h\[\033[35m\]:\w\[\033[0m\] "
  else
    printf "\[\033[32m\]\\\u\[\033[0m\]@\[\033[36m\]\\h\[\033[35m\]:\w\[\033[0m\] "
  fi
}

ps1_git()
{
  local branch="" sha1="" line="" attr="" color=0

  shopt -s extglob # Important, for our nice matchers :)

  if ! command -v git >/dev/null 2>&1 ; then
    printf " \033[1;37m\033[41m[git not found]\033[m "
    return 0
  fi

  branch=$(git symbolic-ref -q HEAD 2>/dev/null)
  if [[ $? -gt 0 ]] ; then
    return 0 # Not in a git repo, no need to continue.
  fi
  branch=${branch##refs/heads/}

  # Now we display the branch.
  sha1=($(git log --no-color -1 2>/dev/null))
  sha1=${sha1[1]}
  sha1=${sha1:0:7}

  case "${branch:-"(no branch)"}" in
   production|prod) attr="1;37m\033[" ; color=41 ;; # red
   master|deploy)   color=31                     ;; # red
   stage|staging)   color=33                     ;; # yellow
   dev|development) color=34                     ;; # blue
   next)            color=36                     ;; # gray
   *)
     if [[ -n "${branch}" ]] ; then # Feature Branch :)
       color=32 # green
     else
       color=0 # reset
     fi
     ;;
  esac

  if [[ $color -gt 0 ]] ; then
    printf "\[\033[${attr}${color}m\](git:${branch}:$sha1)\[\033[0m\] "
  fi
}


ps1_rvm()
{
  if command -v rvm-prompt >/dev/null 2>/dev/null ; then
    printf " $(rvm-prompt) "
  fi
}

ps1_update()
{
  local prompt_char='$'
  local separator="\n"
  local notime=0
  local screen_id=""
  local in_screen=""

  if [[ $UID -eq 0 ]] ; then
    prompt_char='#'
  fi

  while [[ $# -gt 0 ]] ; do
    local token="$1" ; shift

    case "$token" in
      --trace)
        export PS4="+ \${BASH_SOURCE##\${rvm_path:-}} : \${FUNCNAME[0]:+\${FUNCNAME[0]}()}  \${LINENO} > "
        set -o xtrace
        ;;
      --prompt)
        prompt_char="$1"
        shift
        ;;
      --noseparator)
        separator=""
        ;;
      --separator)
        separator="$1"
        shift
        ;;
      --screen_identifer)
        screen_id="$1"
        shift
        ;;
      --notime)
        notime=1
        ;;
      *)
        true # Ignore everything else.
        ;;
    esac
  done

  if [[ "$TERM" == "screen" ]] ; then
      in_screen="$screen_id"
  fi

  if [[ $notime -gt 0 ]] ; then
      PS1="${in_screen}$(ps1_identity)$(ps1_git)$(ps1_rvm)${separator}${prompt_char} "
  else
      PS1="\D{%H:%M:%S} ${screen}$(ps1_identity)$(ps1_git)$(ps1_rvm)${separator}${prompt_char} "
  fi
}

ps2_set()
{
  PS2="  \[\033[0;40m\]\[\033[0;33m\]> \[\033[1;37m\]\[\033[1m\]"
}

ps4_set()
{
  export PS4="+ \${BASH_SOURCE##\${rvm_path:-}} : \${FUNCNAME[0]:+\${FUNCNAME[0]}()}  \${LINENO} > "
}

# WARNING: This clobbers your PROMPT_COMMAND so if you need to write your own, call 
#           ps1_update within your PROMPT_COMMAND
#
# The Prompt Callback is used to help the prompt work if the separator is not a new line.
# In the event that the separtor is not present, the prompt will be messed up because 
# of the escaped characters for setting the prompt color. As a simple work around, the 
# PROMPT_COMMAND can be set to update the prompt with a new PS1 after each command so
# that the prompts width is properly calculated and your prompt will not be messed up by
# variable length values, such as the results of the ps1_git
#
ps1_set()
{
    # This test is to see if your using Lion, it has a special command to keep the terminal
    # up to date on which directory you where last in when you close the terminal.
    if [[ $(type -t update_terminal_cwd) ]]; then
        PROMPT_COMMAND="update_terminal_cwd; ps1_update $@"
    else
        PROMPT_COMMAND="ps1_update $@"
    fi
}

