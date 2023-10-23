#!/usr/bin/env bash

PRESERVE_FROM_MAJOR="${1}"
if ! [[ "${PRESERVE_FROM_MAJOR}" =~ ^[0-9]+$ ]] && [ "${PRESERVE_FROM_MAJOR}" != '' ]; then
  echo "error: Given major is not a number" >&2
  exit 1
fi

git fetch --tags
TAGS=$(git tag -l --sort=-refname)
readarray -t TAGS <<<"${TAGS}"

for TAG in "${TAGS[@]}"; do
  :
  if [ "${TAG:0:1}" == 'v' ]; then
    if [ "${PRESERVE_FROM_MAJOR}" == '' ]; then
      echo "Want to delete the following tag ${TAG} (y/n)?"
      read -r DELETE_TAG
      case "${DELETE_TAG}" in
      [yY][eE][sS] | [yY])
        git tag -d "${TAG}"
        git push --delete origin "${TAG}"
        echo "Tag ${TAG} deleted"
        ;;
      esac
    else
      TAG_MAJOR=$(echo "${TAG}" | cut -d'.' -f1)
      TAG_MAJOR="${TAG_MAJOR:1}"
      if [ "${TAG_MAJOR}" -lt "${PRESERVE_FROM_MAJOR}" ]; then
        git tag -d "${TAG}"
        git push --delete origin "${TAG}"
        echo "Tag ${TAG} deleted"
      else
        echo "Tag ${TAG} preserved"
      fi
    fi
  else
    echo "Warning found tag that does not starts with v found: ${TAG}"
  fi
done

git fetch --tags
git tag -l --sort=-refname
