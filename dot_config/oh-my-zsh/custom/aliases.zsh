alias ls="eza"
alias realls="/usr/bin/ls"
alias cat="bat"
alias realcat="/usr/bin/cat"
alias git-clean='CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD) && git checkout main && git pull --prune && git branch -d "$CURRENT_BRANCH"'