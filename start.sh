#!/bin/sh
set -e

INPUT_BRANCH=${INPUT_BRANCH:-master}
INPUT_FORCE=${INPUT_FORCE:-false}
INPUT_TAGS=${INPUT_TAGS:-false}
INPUT_DIRECTORY=${INPUT_DIRECTORY:-'.'}
INPUT_FOLLOW_TAGS=${INPUT_FOLLOW_TAGS}
_FOLLOW_TAGS_OPTION=''
_FORCE_OPTION=''
REPOSITORY=${INPUT_REPOSITORY:-$GITHUB_REPOSITORY}

echo "follow_tags: $INPUT_FOLLOW_TAGS";
echo "Push to branch $INPUT_BRANCH";
[ -z "${INPUT_GITHUB_TOKEN}" ] && {
    echo 'Missing input "github_token: ${{ secrets.GITHUB_TOKEN }}".';
    exit 1;
};

# if ${INPUT_FOLLOW_TAGS}; then
#     _FOLLOW_TAGS_OPTION='--follow-tags'
# fi

if ${INPUT_FORCE}; then
    _FORCE_OPTION='--force'
fi

if ${TAGS}; then
    _TAGS='--tags'
fi

cd ${INPUT_DIRECTORY}

remote_repo="https://${GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${REPOSITORY}.git"

git push "${remote_repo}" HEAD:${INPUT_BRANCH} $_FOLLOW_TAGS_OPTION $_FORCE_OPTION $_TAGS;
