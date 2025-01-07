# https://hub.github.com
# brew install hub
# git config --global user.name "Ada Love"
# git config --global user.email "adathelove@gmail.com"
# create a repo to host a new project on GitHub
git init
git add .
git commit -m "And so, it begins."
HUB_VERBOSE=1 hub create # → (creates a new GitHub repository with the name of the current directory)
git push -u origin HEAD
# # git commit -m "Initial commit"
# git remote add origin git@github.com:adathelove/code.git
# git config --global init.defaultBranch main
# git push -u origin main

