function conf { git.exe --git-dir="$HOME\.conf.git\" --work-tree=$HOME $args }

function restore {
    # git restore items staged for deletion to the work-tree
    # mainly for newly cloned bare repository with git-dir=*.git
    $gitdir = (Get-ChildItem -Directory -Filter "*.git").Name
    $status_D = $(git --git-dir=$gitdir --work-tree=. status --short | grep 'D  ').substring(3)
    foreach ($file in $status_D) {
        git --git-dir=$gitdir  --work-tree=. restore $file --staged --worktree
    }
}
function mtime {
    param (
        [ScriptBlock]$Command
    )
    
    $executionTime = [math]::round((Measure-Command {
        & $Command
    }).TotalSeconds, 2)
    
    Write-Output "`t`t`t$executionTime s"
}
