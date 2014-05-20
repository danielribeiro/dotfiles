# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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


#################
# Personal
#################

###### Legacy shell ######
# 1 colors
if [ -a ~/.DIR_COLORS ]; then eval `dircolors -b ~/.DIR_COLORS`; fi


# 2 append history
PROMPT_COMMAND='history -a'

###### PATHS E Evironment Variables ######
export BIN_HOME="$HOME/bin/files"
export ANDROID_HOME="$BIN_HOME/android-sdk"
export RUBY_BIN_HOME="$HOME/bin/ruby"
export ANDROID_BIN_HOME="$HOME/bin/android"

export CLOJURESCRIPT_HOME="$BIN_HOME/clojurescript"
export JAVA_HOME=`/usr/libexec/java_home`
export CLASSPATH="$BIN_HOME/clojure.jar"
#export JDK_HOME=$JAVA_HOME
#export JAVAC="$JAVA_HOME/bin/javac"
export M2_HOME="$BIN_HOME/apache-maven"
export M2="$M2_HOME/bin"
export INPUTRC=~/.inputrc
export CDPATH=.:..:~
export LIXEIRAPATH=~/.Lixeira
export DOWNLOADPATH=~/downloads
# Older shells:
# export GREP_COLOR='01;36'
export GREP_COLORS='mt=01;36:ms=01;36:mc=01;36:fn=01;35:ln=01;32:bn=01;32:se=01;36'
export GREP_OPTIONS=--color=always
export RUBYOPT=rubygems
export PYTHONSTARTUP=~/.pythonrc
export EC2_HOME="$BIN_HOME/ec2-api-tools"
# export SAGE_ROOT=/home/daniel/bin/files/sage
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SAGE_ROOT/local/lib
export PATH=.:$M2:~/bin:$RUBY_BIN_HOME:ANDROID_BIN_HOME:$ANDROID_HOME/tools:$PATH:$CLOJURESCRIPT_HOME/bin:$EC2_HOME/bin

# Collor support and binary files for less
export LESS=-MisRf


###### Shell Functions ######
function grepa () { egrep -in "$@" *; }

function grepi () { egrep -i "$@" ; }

function lsgrep () { ls -1l | egrep -i "$@" ; }

# Shell grep
function sgrep () { egrep --colour=never "$@" ; }


# backups the current file
function bak () {
    cp $1 $1.bak
}

# restores the backup file
function ubak () {
    cp $1.bak $1
}

# Bring from download path
function dvem () {
    mv "$@" .
}

function auxDvem () {
     COMPREPLY=($DOWNLOADPATH/*)
}

complete -o filenames -F auxDvem dvem

# busca: find on current directory, but using a pattern
function busca () { find . -iname "$@" ; }

function buscag () { find . -iname '*'"$@"'*' ; }

function oldcd () { cd "$@" ; }

# silent cd: necessary due to non empty CDPATH
function silentcd () { oldcd "$@" >/dev/null ; }



# destar: removes everything on the given 'tar'
function destar () {
    for i in `tar tf "$@"`
      do if [[ -d $i ]]
then /bin/rm -rf $i
      else if [[ -a $i ]]
then /bin/rm $i
      fi
      fi
    done
}

# destarz: removes everything on the given 'tar.gz'
function destarz () {
    for i in `tar tzf "$@"`
      do if [[ -d $i ]]
then /bin/rm -rf $i
      else if [[ -a $i ]]
then /bin/rm $i
      fi
      fi
    done
}

###### General aliases ######
alias g="git"
alias em="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"
alias disku='baobab'
alias ofice='ooffice'
alias cdo='cd ~/downloads'
alias cd='silentcd'
alias clr="unalias -a; reset && source ~/.bash_profile"
alias lrt="ls -lrth"
alias lss="/bin/ls"
alias ls="ls -G -F"
alias l="ll"
alias ll="ls -lh"
alias lt="ls -lth"
alias lat="ls -lhat"
alias la="ls -a"
alias .="cd .."
alias c-="cd -"
alias aliased="em ~/.bash_profile"
alias gited="em ~/.gitconfig"
alias op="open"
alias limpatex='limpa && rm -f *.{out,log,aux,dvi}'
alias untar="tar xvf"
alias untarz="tar xvfz"
alias c="pbcopy"

alias ak='ack -i'
alias serve="python -m SimpleHTTPServer"
alias gself="cd; export GIT_DIR=tmp/dotfiles/.git"
alias gcd='cd `git rev-parse --show-toplevel`'

# Solving bad bundler
alias brake="bundle exec rake"
alias be="bundle exec"

function lsfonte() {
    ls -l `which "$@"`
}

function fonte() {
    cat `which "$@"`
}

function efonte() {
    em `which "$@"`
}

###### SSHsisms ######
if [[ -z $SSH_CONNECTION ]];
    then PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\]$(__git_ps1 " (%s)") \W \$ \[\033[00m\]'
    #then PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W \$ \[\033[00m\]'
else
    PS1='\[\033[01;33m\]\u@\h\[\033[01;34m\] \W \$ \[\033[00m\]'
fi


###### Trashcan Framework ######
function removetrash () { mv "$@" $LIXEIRAPATH ; }


function auxLmv () {
     COMPREPLY=($LIXEIRAPATH/*)
}

function lmv () {
    TEMPOLDPWD=$OLDPWD
    cd "$LIXEIRAPATH" && mv "$1" "$OLDPWD"
    cd "$OLDPWD"
    if [ '.' != $2 ]; then mv "$1" "$2"; fi
    OLDPWD="$TEMPOLDPWD"
}
function lls () {
    TEMPOLDPWD="$OLDPWD"
    cd $LIXEIRAPATH
    ls $@
    cd "$OLDPWD"
    OLDPWD=$TEMPOLDPWD
}
function lvem () {
    lmv "$1" .
}

complete -o filenames -F auxLmv lvem lmv

alias lsize="du -hs $LIXEIRAPATH"
alias rrm="/bin/rm"
alias rm='removetrash'

# Initialize Trashcan if it is not there
if [[ ! -d $LIXEIRAPATH ]]; then mkdir $LIXEIRAPATH; fi


# Change the window title of X terminals
case $TERM in
xterm*|rxvt|Eterm|eterm)
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
;;
screen)
PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
;;
esac


# Setting PATH for JRuby 1.6.7
# The orginal version is saved in .bash_profile.jrubysave
source ~/.git-completion.sh
PATH="${PATH}:/Library/Frameworks/JRuby.framework/Versions/Current/bin"
export PATH

#GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
        || complete -o default -o nospace -F _git gexport

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
