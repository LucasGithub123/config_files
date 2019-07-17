# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='\[\033[38;5;161m\]\w\[\033[00m\]\$ '
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1='\w\$ '
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
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

if [[ $# -eq 0 || $1 != "plain" ]]; then
    #from https://askubuntu.com/questions/809590/automatically-get-different-terminal-colors-each-time-i-open-terminal
    #Change color according to the number of Bash shells opened
    #Creates the .Bash_Color_Changer file if it's not present
    if ! [ -f ~/.Bash_Color_Changer ]; then
        echo ORIGINAL > ~/.Bash_Color_Changer
    fi

    #Array holding the name of the profiles: Substitute it for the names you're using
    Color_counter=(Profile1 Profile2 Profile3 Profile4)
    #Finds out the number of opened bashs counting the lines containing "bash"
    #in the pstree function. (-c deactivates compact display to avoid it showing
    #lines with "2*[bash]" instead of one for each bash)
    Number_of_bashs=$(($(($(pstree -c | grep "bash" | wc -l)-1))%${#Color_counter[@]}))
    #Checks if the terminal being opened was opened by the user or by
    #the script, and act according to it
    if [ $(cat ~/.Bash_Color_Changer) = ORIGINAL ]; then
        if ((Number_of_bashs < ${#Color_counter[*]})); then
            echo COPY > ~/.Bash_Color_Changer
            gnome-terminal --window-with-profile=${Color_counter[${Number_of_bashs}]}
            exit
        fi
    else
        echo ORIGINAL > ~/.Bash_Color_Changer
    fi
fi


mcd(){
    # make a directory and cd to it
    test -d "$1" || mkdir "$1" && cd "$1"
}

# Make common commands shorter:
gdiff(){
    if [ $# -gt 0 ]; then git diff "$1"; else git diff; fi
}
gstatus(){
    git status
}
gad(){
    if [ $# -gt 0 ]; then git add "$1"; else git add -A; fi
}
glola(){
    git lola
}
gloc(){
    git ls-files | xargs wc -l
}

srch(){
    grep -rnw '.' -e "$1"
}

usb() {
    ls /dev --color=always | grep USB
}

lines(){
    # Convert unix line endings to windows line endings.
    if [ $# -gt 0 ]; then
        if [[ "$1" = "-r" && $# -gt 1 ]]; then
            # For each file that matches your pattern, 
            # overwrite the file with the version with windows line endings.
            ls $2 | sort | while read -r line; do
                awk 'sub("$", "\r")' $line > tmp && mv tmp $line && echo "Processed $line"
            done
        elif [ "$1" != "-r" ]; then
            # Just one file, and output to stdout.
            awk 'sub("$", "\r")' $1
        else
            echo "Usage: lines <filename> OR lines -r \"<pattern>\" (quotes are necessary)"
        fi
    else
        echo "Usage: lines <filename> OR lines -r \"<pattern>\" (quotes are necessary)"
    fi
}

reload(){
    if [[ $# -eq 0 || $1 != "-p" ]]; then
        source ~/.bashrc $1
    else
        source ~/.bashrc plain
    fi
    echo "Reloading bashrc."
}

bind '"\e[1;5D" backward-word' 
bind '"\e[1;5C" forward-word'

export PATH="/usr/lib/ccache:$PATH"
export PATH="/usr/lib/ccache:$PATH"
export EDITOR=vim
