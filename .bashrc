# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
source /etc/environment

# Enable git tab completion
source ~/.git-completion.bash
export GIT_PS1_SHOWDIRTYSTATE=1

# colors!
bold="\[\e[0;1m\]"
red="\[\e[0;31m\]"
lred="\[\e[0;91m\]"
green="\[\e[0;32m\]"
lgreen="\[\e[0;92m\]"
blue="\[\e[0;34m\]"
lblue="\[\e[0;94m\]"
cyan="\[\e[0;36m\]"
lcyan="\[\e[0;96m\]"
magneta="\[\e[0;35m\]"
lmagneta="\[\e[0;95m\]"
reset="\[\e[0m\]"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#export PS1="$blue\u$green\$(__git_ps1)$blue \W $ $reset"
if [ "$color_prompt" = yes ]; then
	 PS1="$blue\u$green\$(__git_ps1)$blue \W $ $reset"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#COSTUM COMMANDS
#list files
alias ll='ls -lh'
alias la='ls -lah'
alias l='ls -CF'

#find backup vim files 
alias fshit='find . -maxdepth 1 \( -type f -name "*~" -o -name "*.swp" \)'
#delete backup vim files
alias dshit='find . -maxdepth 1 \( -type f -name "*~" -o -name "*.swp" \) -delete'


#find all cpp and hpp files in current dir only
alias fc='find . -maxdepth 1  \( -type f -name "*.c" -o -name "*.h" \) -printf "%P\n"'
#find all cpp and hpp files in current dir and sort them alphabetically
alias fcs='find . -maxdepth 1  \( -type f -name "*.c" -o -name "*.h" \) -printf "%P\n" | sort '

#start gvim and open alphabetically in new tabs all cpp and hpp files in current directory [two differnt commands to do the same shit]
#alias gvimp='gvim -p $( find . -maxdepth 1  \( -type f -name "*.cpp" -o -name "*.hpp" \) -printf "%P\n" | sort )'
alias gvimc='find . -maxdepth 1  \( -type f -name "*.c" -o -name "*.h" \) | sed -e 's,^\./,,' | sort | xargs -d "\n" gvim -p'


#find all c and h files in current dir only
alias fcpp='find . -maxdepth 1  \( -type f -name "*.cpp" -o -name "*.hpp" \) -printf "%P\n"'
#find all cpp and hpp files in current dir and sort them alphabetically
alias fcpps='find . -maxdepth 1  \( -type f -name "*.cpp" -o -name "*.hpp" \) -printf "%P\n" | sort '

#start gvim and open alphabetically in new tabs all cpp and hpp files in current directory [two differnt commands to do the same shit]
#alias gvimp='gvim -p $( find . -maxdepth 1  \( -type f -name "*.cpp" -o -name "*.hpp" \) -printf "%P\n" | sort )'
alias gvimp='find . -maxdepth 1  \( -type f -name "*.cpp" -o -name "*.hpp" \) | sed -e 's,^\./,,' | sort | xargs -d "\n" gvim -p'
#start gvim and open alphabetically in new tabs all vhdl files in current directory [two differnt commands to do the same shit]
alias gvimh='find . -maxdepth 1  \( -type f -name "*.vhd" \) | sed -e 's,^\./,,' | sort | xargs -d "\n" gvim -p'
#Install and update
alias install='sudo apt-get install'

#mpi2
alias mpi='mpiexec -np 2'
#Xilinx Vivado
alias xilviv='source /tools/Xilinx/Vivado/2018.3/settings64.sh;vivado'
#Xilinx SDK
alias xilsdk='source /tools/Xilinx/SDK/2018.3/settings64.sh;xsdk'
#Python Environment
alias pyenv='source ~/py_env/def_env/bin/activate'
#Java Compiler
alias jc='javac -d .'
#Android Studio
alias androids='/opt/android-studio/bin/studio.sh'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
