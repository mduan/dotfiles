#!/bin/bash

function rsync_repo {
  BASE_NAME=`basename "$PWD"`
  if [ -z ${BASE_NAME} ] || [ ${BASE_NAME} == '/' ]; then
    echo "Cannot be run from root directory"
    exit 1
  fi

  if [[ ${BASE_NAME} != 'insights' && ${BASE_NAME} != 'correlate' && ${BASE_NAME} != 'dashboard' && ${BASE_NAME} != 'lexicon' && ${BASE_NAME} != 'cohorts' ]]; then
    echo "Cannot rsync '${BASE_NAME}'"
    exit 1
  fi

  SYNC_TO_DIR="mack-dev:~/platform-apps/${BASE_NAME}"
  echo "Syncing to ${SYNC_TO_DIR}"
  rsync -rav --exclude="/.git/worktrees" --filter="dir-merge,- .gitignore" --delete . "${SYNC_TO_DIR}"
}
export -f rsync_repo

rsync_repo
fswatch -0 -o . | xargs -0 -n1 -I{} bash -c 'rsync_repo'
