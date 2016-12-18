#!/bin/bash

scriptName=`basename $0` #Set Script Name variable
scriptBasename="$(basename ${scriptName} .sh)" # Strips '.sh' from scriptName
version="1.0.0"

logFile="$HOME/Library/Logs/${scriptBasename}.log"

scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Default flags
force=0
quiet=0
printLog=0
verbose=0

strict=0
debug=0
args=()

# Ensure cleanup even if script fails
trapCleanup() {
  if is_dir "${tmpDir}"; then
    rm -r "${tmpDir}"
  fi
  die "Install not completed successfully."

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
  -f, --force           Skip all user interaction.  Implied 'Yes' to all actions.
  -q, --quiet       Quiet (no output)
  -l, --log         Print log to file
  -v, --verbose     Output more information. (Items echoed to 'verbose')
  -d, --debug       Runs script in BASH debug mode (set -x)
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
black='\033[0;30m'
white='\033[0;37m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'

# Resets the style
reset=`tput sgr0`

# Color-echo
# arg $1 = message
# arg $2 = Color
_echo() {
  echo "${2}${1}${reset}"
  return
}

trap trapCleanup EXIT INT TERM
set -o errexit
set -o pipefail

# Run in debug mode, if set
if ${debug}; then set -x ; fi

verbose() {
  if [[ "${verbose}" = "true" ]] || [ "${verbose}" == "1" ]; then
    debug "$@"
  fi
}
