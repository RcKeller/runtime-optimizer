#!/usr/bin/env bash
# https://circleci.com/docs/2.0/using-shell-scripts/#set-error-flags
# # Use the error status of the first failure, rather than that of the last item in a pipeline.
set -o pipefail

range() {
    echo "$1" | rev | cut -d/ -f1 | rev
}

last_run_commit() {
    echo "$1" | cut -d. -f 1 | cut -d^ -f 1
}

current_commit() {
    echo "$1" | cut -d. -f 4
}

compare_range=$(range $1)
first=$(current_commit $compare_range)
last=$(last_run_commit $compare_range)

echo "Comparing changes for range ${last} to ${first} from URL ${1}:"

output=$(git diff $last^ $first -- $2 2>&1)

if [ $? -gt 0 ]; then
  echo "Error looking for changes!"
  exit 0
elif [ -n "$output" ]; then
  echo "Changes detected - proceeding"
  exit 0
else
  echo "No changes detected - halting job"
  exit 1
fi