# git
alias ga='git add'
alias gb='git blame'
alias gd='git diff'
alias gdc='git diff --cached'
alias gg='git grep -n'
alias ggi='git grep -ni'
alias ggr='git log --graph --full-history --all --color --pretty=tformat:\"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s%x20%x1b[33m\(%an,%x20%ar\)%x1b[0m\"'
alias gs='git status'
alias gsi='git status --ignored'

# vim
alias v='vim'

# navi
alias ..='cd ..'

# grep wrapper
mk_grep()
{
  if [ -z "$1" ]; then
    echo "g <pattern> [where]"
    return 1
  fi
  if [ -n "$2" ]; then
    where="$2"
  else
    where="."
  fi
  echo grep "$1" "$where" -Rns
  grep "$1" "$where" -Rns
}
alias g=mk_grep

# secret stuff
if [ -f ~/.bash_aliases_local ]; then
  . ~/.bash_aliases_local
fi

