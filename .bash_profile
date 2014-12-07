#!/bin/bash
#
# interactive alias and functions
source ~/.bashrc

# minimize bash prompt prefix
export PS1="$"
# search paths
export PATH=":/usr/bin:/usr/local:/sw/bin:$PATH"

# store 10,000 history entries
export HISTSIZE=10000
# don't store duplicates
export HISTCONTROL=erasedups

# reload .bash_profile after making changes
alias bash_profile='source ~/.bash_profile' # Reloads .bash_profile
