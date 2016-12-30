#!/bin/bash

scriptName=`basename $0` #Set Script Name variable
scriptBasename="$(basename ${scriptName} .sh)" # Strips '.sh' from scriptName
version="1.0.0"

logFile="$HOME/Library/Logs/${scriptBasename}.log"

scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Default flags
args=()

# Ensure cleanup even if script fails
trapCleanup() {
  if is_dir "${tmpDir}"; then
    rm -r "${tmpDir}"
  fi
  die "Install not completed successfully."

}

safeExit() {
  # Delete temp files, if any
  if is_dir "${tmpDir}"; then
    rm -r "${tmpDir}"
  fi
  trap - INT TERM EXIT
  exit
}

# create a tmp directory for storing temporary files
tmpDir="/tmp/${scriptName}.$RANDOM.$RANDOM.$RANDOM.$$"
(umask 077 && mkdir "${tmpDir}") || {
  die "Could not create temporary directory! Exiting."
}

usage() {
  echo -n "${scriptName} [OPTION]... [FILE]...

MacOS Sierra initialization (https://github.com/dcondrey/init)
Version ${version}

 Options:
  -h, --help        Display this help and exit
"
}

optstring=h
unset options
while (($#)); do
  case $1 in
    # If option is of type -ab
    -[!-]?*)
      # Loop over each character starting with the second
      for ((i=1; i < ${#1}; i++)); do
        c=${1:i:1}

        # Add current char to options
        options+=("-$c")

        # If option takes a required argument, and it's not the last char make
        # the rest of the string its argument
        if [[ $optstring = *"$c:"* && ${1:i+1} ]]; then
          options+=("${1:i+1}")
          break
        fi
      done
      ;;

    # If option is of type --foo=bar
    --?*=*) options+=("${1%%=*}" "${1#*=}") ;;
    # add --endopts for --
    --) options+=(--endopts) ;;
    # Otherwise, nothing special
    *) options+=("$1") ;;
  esac
  shift
done
set -- "${options[@]}"
unset options


# Read the options and set stuff
while [[ $1 = -?* ]]; do
  case $1 in
    -f|--force) force=1 ;;
    -q|--quiet) quiet=1 ;;
    -l|--log) printLog=1 ;;
    -v|--verbose) verbose=1 ;;
    -d|--debug) debug=1;;
    -h|--help) usage >&2; safeExit ;;
    --endopts) shift; break ;;
    *) die "invalid option: '$1'." ;;
  esac
  shift
done

confirm() {
  # echo ""
  input "$@"
  if "${force}"; then
    notice "Forcing confirmation with '--force' flag set"
  else
    read -p " (y/n) " -n 1
    echo ""
  fi
}

# Test whether the result of an 'ask' is a confirmation
is_confirmed() {
  if "${force}"; then
    return 0
  else
    if [[ "${REPLY}" =~ ^[Yy]$ ]]; then
      return 0
    fi
    return 1
  fi
}

is_not_confirmed() {
  if "${force}"; then
    return 1
  else
    if [[ "${REPLY}" =~ ^[Nn]$ ]]; then
      return 0
    fi
    return 1
  fi
}




# Check if application is already installed
installed() {
    type "$1" >/dev/null
}

# Convert string to hexadecimal
ascii2hex(){
    a="$@";
    s=0000000;
    printf "$a" | hexdump | grep "^$s" | sed s/' '//g | sed s/^$s//;
}


# Colors
bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)
purple=$(tput setaf 171)
red=$(tput setaf 1)
green=$(tput setaf 76)
tan=$(tput setaf 3)
blue=$(tput setaf 38)

# Resets the style
reset=`tput sgr0`

die ()       { local _message="${*} Exiting."; echo "$(_alert emergency)"; safeExit;}
error ()     { local _message="${*}"; echo "$(_alert error)"; }
warning ()   { local _message="${*}"; echo "$(_alert warning)"; }
notice ()    { local _message="${*}"; echo "$(_alert notice)"; }
info ()      { local _message="${*}"; echo "$(_alert info)"; }
debug ()     { local _message="${*}"; echo "$(_alert debug)"; }
success ()   { local _message="${*}"; echo "$(_alert success)"; }
input()      { local _message="${*}"; echo -n "$(_alert input)"; }
header()     { local _message="========== ${*} ==========  "; echo "$(_alert header)"; }

trap trapCleanup EXIT INT TERM
set -o errexit
set -o pipefail
