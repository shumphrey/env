
# Parse the config into an associative array
# Could be made to pick up more info in the future
# Currently just takes the credentials line and extracts account_id
aws-config-reader() {
  typeset -gA aws_profiles
  aws_profiles = ()
  local profile='unknown'
  while read line; do
    if [[ $line =~ '^\[profile' ]]; then
      profile=$(echo "$line"| sed 's/\[profile \(.*\)\]/\1/g')
    elif [[ $line =~ '^credential_process' ]]; then
      local account_id=$(echo "$line" | grep -Eo '\d\d+')
      # try extracting from gobbc?
      if [[ "$account_id" == "" ]]; then
        account_id=$(gobbc list-aws-account-aliases 2>/dev/null| grep $profile | sed "s/.* //")
      fi
      if [[ "$account_id" == "" ]]; then
        account_id="..."
      fi
      aws_profiles[$profile]=$account_id
    fi
  done < ~/.aws/config
}

aws-get-profile-name-fzf() {
  aws-config-reader

  local prof=$(
    for key val in ${(kv)aws_profiles}; do
      printf "%-20s %s\n" $key $val
    done | sort | fzf --height=20% --prompt="profile: "
  )
  local profname=$(echo "$prof" | awk '{print $1}')

  echo "$profname"
}
