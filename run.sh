#!/bin/sh

git config --global user.email "$USER_EMAIL"
git config --global user.name "$USER_NAME"


cp -r /root/app_source/.[!.]* /app/
cp -r /root/app_source/* /app/


echo "HOST *" > ~/.ssh/config
echo "StrictHostKeyChecking no" >> ~/.ssh/config

git stash push --include-untracked -m "Stash .gitmodules changes"

if git show-ref --verify --quiet refs/heads/$TARGET_BRANCH; then
  git switch -f $TARGET_BRANCH
else
  git checkout -f -b $TARGET_BRANCH
fi

RecurseClone() {
  for submodule in $(git config --file .gitmodules --get-regexp path | awk '{ print $2 }'); do
    load_url="$(git config --file .gitmodules --get "submodule.$submodule.url")"
  
    git rm -rf $submodule
    git commit -m "Remove submodule $submodule"

    git clone --depth 1  --recurse-submodules -j8 $load_url "$submodule"
    cd "$submodule"
    RecurseClone | true
    cd ../

    rm -rf "$submodule/.git"

    git add "$submodule"
    git commit -m "Add submodule $submodule as a folder"
done
}

RecurseClone

git rm .gitmodules
git commit -m "Remove .gitmodules file"

git push -f origin $TARGET_BRANCH

