#!/bin/bash

set -o errexit -o nounset

mkdir -p Output
cp *.pdf ./Output/
cd Output

echo "Initializing."

git init
git config user.name "Jenkins CI"
git config user.email "jenkins@asmlab.org"

echo "Adding upstream."
git remote add upstream "git@github.com:thanatosmin/CV.git"

echo "Fetching upstream."
git fetch upstream
git reset upstream/gh-pages

touch .

git add -A .
git status
git commit -m "Lastest site built on successful jenkins build $BUILD_NUMBER auto-pushed to github"

echo "Pushing now."

git push -q upstream HEAD:gh-pages
