#!/bin/bash

GREEN="\033[0;32m"
RED="\033[0;31m"
RESET="\033[0m"

check_ahead_behind() {
  git fetch origin
  local branch=$(git rev-parse --abbrev-ref HEAD)
  ahead_behind=$(git rev-list --left-right --count origin/"$branch"...HEAD)
  local ahead=$(echo "$ahead_behind" | awk '{print $1}')
  local behind=$(echo "$ahead_behind" | awk '{print $2}')
  if [[ "$ahead" -ne 0 || "$behind" -ne 0 ]]; then
    echo "$ahead $behind"
    return 1
  else
    return 0
  fi
}

get_commit_url() {
  git_url=$(git config --get remote.origin.url)
  if [[ "$git_url" =~ git@([^:]+):(.+)\.git ]]; then
    https_url="https://${BASH_REMATCH[1]}/${BASH_REMATCH[2]}"
  else
    https_url=$(echo "$git_url" | sed -e 's/\.git$//')
  fi
  last_commit=$(git log origin/$(git rev-parse --abbrev-ref HEAD) -1 --pretty=format:%H)
  commit_url="${https_url}/commit/${last_commit}"
  echo "$commit_url"
}

ahead_behind_result=$(check_ahead_behind)
status=$?

if [[ $status -eq 0 ]]; then
  echo -e "${GREEN}We are on track${RESET}"
else
  ahead=$(echo "$ahead_behind_result" | awk '{print $1}')
  behind=$(echo "$ahead_behind_result" | awk '{print $2}')
  echo -e "${RED}Not on track${RESET}"
  echo -e "Ahead: ${GREEN}$ahead${RESET}, Behind: ${RED}$behind${RESET}"

  if [[ "$behind" -ne 0 ]]; then
    echo -e "\nShowing the git log for the $behind commit(s) behind:"
    git log --oneline --graph --abbrev-commit -n "$behind"
    read -p "You are behind, would you like to pull changes from origin? (y/n): " pull_response
    if [[ "$pull_response" =~ ^[Yy]$ ]]; then
      git pull
    fi
  fi

  if [[ "$ahead" -ne 0 ]]; then
    echo -e "\nShowing the git log for the $ahead commit(s) ahead:"
    git log --oneline --graph --abbrev-commit -n "$ahead"
    read -p "You are ahead, would you like to push your changes to origin? (y/n): " push_response
    if [[ "$push_response" =~ ^[Yy]$ ]]; then
      git push
    fi
  fi
fi

commit_url=$(get_commit_url)
echo "Last pushed commit URL: $commit_url"

