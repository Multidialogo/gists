#!/usr/bin/env bash

git fetch --tags

last_tag=$(git describe --abbrev=0)
next_tag="${last_tag%.*}.$((${last_tag##*.}+1))"

echo "Last tag was: ${last_tag}"
echo "Next tag will be: ${next_tag}"

while true; do
    read -p "Do you confirm next tag? (y\n)" confirm_answer
    case $confirm_answer in
        [Yy]* )
          echo "Enter commit message":
          read commit_message

          git fetch --tags --force
          git tag -a "${next_tag}" -m "${commit_message}"
          git push --follow-tags
          break;;
        [Nn]* ) exit 0;;
        * ) echo "Please answer yes or no.";;
    esac
done
