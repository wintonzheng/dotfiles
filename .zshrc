alias grbo="git rebase origin/master"
alias amend="git add --all; git commit --amend --no-edit"
alias gp="git push origin HEAD"
alias gpf="git push origin HEAD --force-with-lease"
alias pull="git pull --rebase origin"
alias cpr="gh pr create"
alias pcpr="git pull --rebase origin & hub pull-request -m \"\""

# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
plugins=(zsh-autosuggestions)
