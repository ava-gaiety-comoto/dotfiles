# dotfiles
For Codespaces
https://docs.github.com/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#dotfiles

See also:
`.gitconfig`

`.git/hooks/prepare-commit-message` (`sudo chmod 755`)
```sh
#!/bin/bash
# https://overflow.canine.tools/questions/5894946/how-to-add-gits-branch-name-to-the-commit-message#17270862

branchPath=$(git symbolic-ref -q HEAD) #Somthing like refs/heads/myBranchName
branchName=${branchPath##*/}      #Get text behind the last / of the branch path

firstLine=$(head -n1 $1)

if [ -z "$firstLine"  ] ;then #Check that this is not an amend by checking that the first line is empty
    sed -i "1s/^/$branchName: \n/" $1 #Insert branch name at the start of the commit message file
fi
```
