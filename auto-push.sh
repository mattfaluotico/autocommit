find ~/Development/Alfred-Workflows -name '.git' -print0 | xargs -0 -n1 dirname | while read line; do
    echo "\nProcessing file '$line'"
    BRANCH="$(cd $line && git rev-parse --symbolic-full-name --abbrev-ref HEAD)"

    echo "\ncurrent banch: $BRANCH"

    # Stash

    echo "\nAttempting to create branch 'autocommit'..."
    eval "(cd $line && git checkout -b autocommit)"

    echo "\nSwitching to branch 'autocommit'..."
    eval "(cd $line && git checkout autocommit)"

    # Stash Apply 

    echo "\nAdding all files..."
    eval "(cd $line && git add .)"

    echo "\nCommitting files..."
    eval "(cd $line && git commit -m 'autocommit on $(date)')"

	echo "\nPushing files to branch"
    eval "(cd $line && git push origin autocommit)"


    echo "\nReturning to origin branch..."
    eval "(cd $line && git checkout $BRANCH)"

    # Stash pop

    echo "\n-----------------------------------"
done