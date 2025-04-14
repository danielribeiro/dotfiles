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

#################
# Personal
#################
export BASH_SILENCE_DEPRECATION_WARNING=1

shopt -s histappend
PROMPT_COMMAND='history -a'

###### PATHS env Variables ######
# Autojump-like for current dir only with percol
export DEV_HOME="$HOME/projects"
export MY_RUBY_VERSION="ruby-3.4.2"

export BIN_HOME="$HOME/bin/files"
export RUBY_BIN_HOME="$HOME/bin/ruby"

# export CLOJURESCRIPT_HOME="$BIN_HOME/clojurescript"
export JAVA_HOME=`/usr/libexec/java_home`
# export CLASSPATH="/home/daniel/bin/files/clojure.jar"
#export JDK_HOME=$JAVA_HOME
#export JAVAC="$JAVA_HOME/bin/javac"
# export M2_HOME="$BIN_HOME/apache-maven"
# export M2="$M2_HOME/bin"
export INPUTRC=~/.inputrc
export CDPATH=.:..:~
export LIXEIRAPATH=~/.Lixeira
export DOWNLOADPATH=~/downloads
# Old shells:
# export GREP_COLOR='01;36'
export GREP_COLORS='mt=01;36:ms=01;36:mc=01;36:fn=01;35:ln=01;32:bn=01;32:se=01;36'
export GREP_OPTIONS=--color=always
export RUBYOPT=rubygems
export PYTHONSTARTUP=~/.pythonrc
export EC2_HOME="$BIN_HOME/ec2-api-tools"
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SAGE_ROOT/local/lib
export HOMEBREWPATH="/opt/homebrew/bin"

# because of homebrew, my bin path is added at the end of the file
export PATH=$RUBY_BIN_HOME:$PATH


# less with color and binary support
export LESS=-MisRf

##### Home Specific #####
if [ $HOSTNAME == fnord ]
    then alias su="su -"
# C-s should not lock the terminal
    stty stop undef
fi

###### SSHs config ######
if [[ -z $SSH_CONNECTION ]];
    then PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\]$(__git_ps1 " (%s)") \W \$ \[\033[00m\]'
    #then PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W \$ \[\033[00m\]'
else
    PS1='\[\033[01;33m\]\u@\h\[\033[01;34m\] \W \$ \[\033[00m\]'
fi

###### General aliases ######
alias em="/usr/local/bin/code"
# alias em="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"
alias cdo='cd ~/downloads'
alias cdd="cd $DEV_HOME"
alias clr="unalias -a; reset && source ~/.bash_profile"
alias lrt="ls -lrth"
alias lss="/bin/ls"
alias ls="ls -G -F"
alias l="ll -lrth"
alias ll="ls -lh"
alias lt="ls -lth"
alias lat="ls -lhat"
alias la="ls -a"
alias g="git"
alias .="cd .."
alias c-="cd -"
alias aliased="em ~/.bash_profile"
alias gited="em ~/.gitconfig"
alias op="open"
alias untar="tar xvf"
alias untarz="tar xvfz"
alias c="pbcopy"

alias serve="python -m SimpleHTTPServer"
alias serveit="python -m SimpleHTTPServer 8001"

# Solving bad bundler
alias brake="bundle exec rake"
alias be="bundle exec"

alias gself="cd; export GIT_DIR=$HOME/tmp/dotfiles/.git"
alias gcd='cd `git rev-parse --show-toplevel`'

# See $HOME/bin/extractlsline
alias j='cd "`/bin/ls -ldt */ | percol --auto-fail | extractlsline`"'
alias jj='cd $DEV_HOME/`(cd $DEV_HOME/ && /bin/ls -ldt *) | percol --auto-fail | extractlsline`'
alias nn='pwd ; navigate ; cd "`cat ~/.navigate.out`"; pwd'
alias ediff='/Applications/p4merge.app/Contents/Resources/launchp4merge'


# Golang:
# alias jo='cd $DEV_HOME/go/src/$((cd $DEV_HOME/go/src && ls -ldth $(find . -type d -name ".git" -exec dirname {} ";")) | percol --auto-fail | trline " +" "\t" | cut -f 9)'




###### Shell Functions ######

# efonte:  Edit the file found by 'which'.
efonte() {
    em $(which "$@")
}

# grepa:  Case-insensitive grep with line numbers in the current directory.
grepa () {
    egrep -in "$@" *
}

# grepi:  Case-insensitive grep.
grepi () {
    egrep -i "$@"
}

# lsgrep: List files and filter with case-insensitive grep.
lsgrep () {
    ls -1l | egrep -i "$@"
}

# sgrep: Grep without color output.
sgrep () {
    egrep --colour=never "$@"
}

# bak:  Create a backup of a file.
bak () {
    cp "$1" "$1.bak"
}

# ubak:  Restore a file from its backup.
ubak () {
    cp "$1.bak" "$1"
}

# busca: Find files in the current directory, case-insensitive.
busca () {
    find . -iname "$@"
}

# buscag: Find files in the current directory, case-insensitive, with wildcard.
buscag () {
    find . -iname '*'"$@"'*'
}

# lsfonte: List details of the file found by 'which'.
lsfonte() {
    ls -l $(which "$@")
}

# fonte:  Display the contents of the file found by 'which'.
fonte() {
    cat $(which "$@")
}



###### Trashcan utilities for command line ######
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


# Initialize trashcan
if [[ ! -d $LIXEIRAPATH ]]; then mkdir $LIXEIRAPATH; fi

source ~/.git-completion.sh

GIT_PS1_SHOWSTASHSTATE=true
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
        || complete -o default -o nospace -F _git gexport

source /opt/homebrew/share/chruby/chruby.sh
source /opt/homebrew/share/chruby/auto.sh
# default ruby:
chruby "$MY_RUBY_VERSION"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv
eval "$(pyenv init -)"

# My bin files take priority. In particular, gs for me is a 'git status' tool. Sorry ghostcript
export PATH="$HOME/bin":$PATH