set -e

docker stop ws-bridge-fe-prod
docker stop ws-bridge-datasource-prod
docker stop ws-bridge-gate-prod

docker rmi --force ws-bridge/fe:prod
docker rmi --force ws-bridge/datasource:prod
docker rmi --force ws-bridge/gate:prod

npx lerna run --concurrency 1 --stream buildImageProd

docker container rm ws-bridge-fe-prod
docker container rm ws-bridge-datasource-prod
docker container rm ws-bridge-gate-prod

docker run --name ws-bridge-fe-prod --publish 8080:80 ws-bridge/fe:prod > /dev/null &
docker run --name ws-bridge-datasource-prod --publish 4082:80 ws-bridge/datasource:prod > /dev/null &
docker run --name ws-bridge-gate-prod --publish 4080:80 ws-bridge/gate:prod > /dev/null &

HEALTH_CHECK_URL=http://localhost:8080 node devexp/src/checkHealth.js
HEALTH_CHECK_URL=http://localhost:4080/health node devexp/src/checkHealth.js
HEALTH_CHECK_URL=http://localhost:4082/health node devexp/src/checkHealth.js

docker stop ws-bridge-fe-prod
docker stop ws-bridge-datasource-prod
docker stop ws-bridge-gate-prod

echo "Pre push hook went good"
