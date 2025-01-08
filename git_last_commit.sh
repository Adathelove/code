git_url=$(git config --get remote.origin.url)

if [[ "$git_url" =~ git@([^:]+):(.+)\.git ]]; then
  https_url="https://${BASH_REMATCH[1]}/${BASH_REMATCH[2]}"
else
  https_url=$(echo "$git_url" | sed -e 's/\.git$//')
fi

last_commit=$(git log origin/$(git rev-parse --abbrev-ref HEAD) -1 --pretty=format:%H)

commit_url="${https_url}/commit/${last_commit}"

echo "$commit_url"

