#git_extra

#Open repo in Github
#gh - open the github origin repo (default branch)
alias gh='open `git remote -v | grep origin | grep fetch | head -1 | cut -f2 | cut -d'\'' '\'' -f1 | sed -e'\''s/git@/http:\/\//'\'' -e'\''s/\.git$//'\'' | sed -E '\''s/(\/\/[^:]*):/\1\//'\''`'

#ghu - open the github upstream repo (default branch)
alias ghu='open `git remote -v | grep upstream | grep fetch | head -1 | cut -f2 | cut -d'\'' '\'' -f1 | sed -e'\''s/git@/http:\/\//'\'' -e'\''s/\.git$//'\'' | sed -E '\''s/(\/\/[^:]*):/\1\//'\''`'

#ghb - open the github origin repo (current branch)
alias ghb='open `git remote -v | grep origin | grep fetch | head -1 | cut -f2 | cut -d'\'' '\'' -f1 | sed -e'\''s/git@/http:\/\//'\'' -e'\''s/\.git$//'\'' | sed -E '\''s/(\/\/[^:]*):/\1\//'\''`/tree/$(git symbolic-ref --quiet --short HEAD )'

#ghpr - create PR from current branch
alias ghpr='open `git remote -v | grep origin | grep fetch | head -1 | cut -f2 | cut -d'\'' '\'' -f1 | sed -e'\''s/git@/http:\/\//'\'' -e'\''s/\.git$//'\'' | sed -E '\''s/(\/\/[^:]*):/\1\//'\''`/pull/new/$(git symbolic-ref --quiet --short HEAD )'

alias gupull='git pull upstream $(git_current_branch)'
alias gupush='git push upstream $(git_current_branch)'
alias gmud='git fetch upstream && git merge upstream/develop'

alias gi="echo $* >> .gitignore"
alias ggi="echo $* >> ~/.gitignore_global"
