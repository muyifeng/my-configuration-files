# Grab the current version of ruby in use (via RVM): [ruby-1.8.7]
if [ -e ~/.rvm/bin/rvm-prompt ]; then
  JARIN_CURRENT_RUBY_="
%{$fg[blue]%}\$(~/.rvm/bin/rvm-prompt i v g)%{$reset_color%} %{$fg[red]%}❯%{$fg[yellow]%}❯%{$fg[green]%}❯ %{$fg_bold[green]%}%~\$(git_prompt_info)%{$reset_color%}
%{$fg_bold[yellow]%}☂%{$reset_color%} "
else
  if which rbenv &> /dev/null; then
    JARIN_CURRENT_RUBY_="
%{$fg[red]%}%T %{$fg[white]%}<%{$fg[green]%}\$(rbenv version | sed -e 's/ (set.*$//')%{$fg[white]%}>
%{$fg_bold[yellow]%} %{$reset_color%}"
  fi
fi

# Grab the current filepath, use shortcuts: ~/Desktop
# Append the current git branch, if in a git repository
JARIN_CURRENT_LOCA_="%{$fg[red]%}%T%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%} <%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[white]%}"

# Do nothing if the branch is clean (no changes).
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[white]%}>"

# Add a yellow ✗ if the branch is dirty
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[white]%}> %{$fg[yellow]%}✗"

# Put it all together!
PROMPT="$JARIN_CURRENT_RUBY_ "
RPROMPT=" $JARIN_CURRENT_LOCA_"
