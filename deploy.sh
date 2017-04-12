#!/bin/bash

set -o errexit -o nounset

mkdir -p Output
cp *.pdf ./Output/
cd Output

git init
git config user.name "Jenkins CI"
git config user.email "jenkins@asmlab.org"

git remote add upstream "https://$GH_TOKEN@github.com/meyer-lab/asmlab.org.git"
git fetch upstream
git reset upstream/gh-pages

touch .

git add -A .
git status
git commit -m "Lastest site built on successful jenkins build NUMBER auto-pushed to github"
git push -q upstream HEAD:gh-pages
