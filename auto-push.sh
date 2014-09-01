find ~/Development -name '.autocommit' -print0 | xargs -0 -n1 dirname | while read line; do
    
    echo "\nProcessing file '$line'"
    BRANCH="$(cd $line && git rev-parse --symbolic-full-name --abbrev-ref HEAD)"

    HASGIT=$(find . -name '.git')
    if [ -n "$HASGIT" ]; then
        echo "\ncurrent banch: $BRANCH"

        # Adds all files for stashing
        echo "\n***Adding all files***"
        eval "(cd $line && git add .)"

        # Stash current branch so the files are not lost
        echo "\n***Stashing Changes***"
        eval "(cd $line && git stash)"

        # Switching to the autocommit branch
        echo "\n***Attempting to create branch 'autocommit'***"
        eval "(cd $line && git checkout -b autocommit)"

        echo "\n***Switching to branch 'autocommit'***"
        eval "(cd $line && git checkout autocommit)"

        # Stash Apply 
        echo "\n***Apply stashed files to autocommit***"
        eval "(cd $line && git stash apply)"

        # Commit files to autocommit
        echo "\n***Adding all files***"
        eval "(cd $line && git add .)"

        echo "\n***Committing files***"
        eval "(cd $line && git commit -m 'autocommit on $(date)')"

        echo "\n***Pushing files to branch***"
        eval "(cd $line && git push origin autocommit)"

        # Return to initial branch
        echo "\n***Returning to origin branch***"
        eval "(cd $line && git checkout $BRANCH)"

        # Stash pop
        echo "\n***Returning files to branch***"
        eval "(cd $line && git stash pop)"

        echo "\n-----------------------------------"
    else
        echo "$line contains no .git file"
    fi
done