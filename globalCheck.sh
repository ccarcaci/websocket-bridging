set -e

# Main project
npm run ncuUpdateMinor

printf '\nVerify Available Major Updates on workspace\n\n'
npm run ncuVerifyUpdateMajor
printf '\n\n'

# Apps folders
npx lerna run --concurrency 1 --stream ncuUpdateMinor

printf '\nVerify Available Major Updates on apps\n\n'
npx lerna run --concurrency 1 --stream ncuVerifyUpdateMajor
printf '\n\n'

git add '*package.json' '*package-lock.json'

npx lerna run --concurrency 1 --stream linter
set CI=true && npx lerna run --concurrency 1 --stream test
npx lerna run --concurrency 1 --stream build

echo "Global check went good"
