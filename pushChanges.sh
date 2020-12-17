set -e

git push origin dev
git checkout main
git merge dev
git push origin main
git checkout dev
