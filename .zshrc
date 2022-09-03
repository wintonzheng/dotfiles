alias grbo="git rebase origin/master"
alias amend="git add --all; git commit --amend --no-edit"
alias gp="git push origin HEAD"
alias gpf="git push origin HEAD --force-with-lease"
alias pull="git pull --rebase origin"
alias cpr="gh pr create"
alias pcpr="git pull --rebase origin & hub pull-request -m \"\""
alias x="exit"

export PYTHONPATH="$PWD"

# run pipenv shell automatically
function auto_pipenv_shell {
    if [ ! -n "${PIPENV_ACTIVE+1}" ]; then
        if [ -f "Pipfile" ] ; then
            pipenv shell
        fi
    fi
}

function cd {
    builtin cd "$@"
    auto_pipenv_shell
}

auto_pipenv_shell

# automatic poetry shell
function auto_poetry_shell {
    if [ ! -n "${POETRY_ACTIVE+1}" ]; then
        if [ -f "pyproject.toml" ] ; then
            poetry shell
        fi
    fi
}

function cd {
    builtin cd "$@"
    auto_poetry_shell
}

auto_poetry_shell

# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
plugins=(zsh-autosuggestions)

