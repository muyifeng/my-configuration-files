export ALTERNATE_EDITOR=""
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/share/npm/bin:/usr/local/sbin:~/bin:$PATH
export LC_ALL="en_US.UTF-8"
export LANG=en_US.UTF-8

# Finished adapting your PATH environment variable for use with MacPorts.

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

alias e="emacsclient"
alias es="emacs"
alias l="ls"
alias la="ls -a"
alias lg="ls -g"

alias js="jumpstat"

alias ga="git add"
alias gb="git branch"
alias gc="git checkout"
alias gd="git diff"
alias gl="git log --pretty"
alias gh="git log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short"
alias gs="git status"
alias gcm="git commit -m"
alias gps="git push"
alias gpl="git pull"

alias rdc="rake db:create"
alias rdm="rake db:migrate"
alias rc="rails c"
alias rs="rails s"
alias rgmi="rails g migration"
alias rgs="rails g scaffold"
alias rgc="rails g controller"
alias rgmo="rails g model"

alias ..="cd .."

alias mysql-start="sudo /Library/StartupItems/MySQLCOM/MySQLCOM start"
alias mysql-stop="sudo /Library/StartupItems/MySQLCOM/MySQLCOM stop"
alias mysql-restart="sudo /Library/StartupItems/MySQLCOM/MySQLCOM restart"

#PS1='\n'$'\[\033[0m\033[33m\]\\t\[\033[0m\] '$'\[\033[0m\033[31m\]\u\[\033[0m\]'$':\[\033[0m\033[32m\]\w\[\033[0m\]$ '
#PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

#autojump
_autojump()
{
        local cur
        cur=${COMP_WORDS[*]:1}
        while read i
        do
            COMPREPLY=("${COMPREPLY[@]}" "${i}")
        done  < <(autojump --bash --completion $cur)
}
#complete -F _autojump j

if [ -n "$XDG_DATA_HOME" ]
then
    export AUTOJUMP_DATA_DIR="$XDG_DATA_HOME/autojump"
else
    export AUTOJUMP_DATA_DIR=~/.local/share/autojump
fi

if [ ! -e "${AUTOJUMP_DATA_DIR}" ]
then
    mkdir -p "${AUTOJUMP_DATA_DIR}"
    mv ~/.autojump_py "${AUTOJUMP_DATA_DIR}/autojump_py" 2>>/dev/null #migration
    mv ~/.autojump_py.bak "${AUTOJUMP_DATA_DIR}/autojump_py.bak" 2>>/dev/null
    mv ~/.autojump_errors "${AUTOJUMP_DATA_DIR}/autojump_errors" 2>>/dev/null
fi

export AUTOJUMP_HOME=${HOME}
AUTOJUMP='{ [[ "$AUTOJUMP_HOME" == "$HOME" ]] && (autojump -a "$(pwd -P)"&)>/dev/null 2>>${AUTOJUMP_DATA_DIR}/.autojump_errors;} 2>/dev/null'
if [[ ! $PROMPT_COMMAND =~ autojump ]]; then
  export PROMPT_COMMAND="$AUTOJUMP ; ${PROMPT_COMMAND:-:}"
fi
alias jumpstat="autojump --stat"
function j { new_path="$(autojump $@)";if [ -n "$new_path" ]; then echo -e "\\033[31m${new_path}\\033[0m"; cd "$new_path";else false; fi }

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
