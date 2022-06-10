#!/usr/bin/env bash
set -e
COMMIT=$(git rev-parse --short HEAD)
BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
export TAG="${BRANCH}-${COMMIT}"
docker-compose up --build --detach
docker-compose exec web npm test
curl -s -i http://127.0.0.1:8081/ | grep "HTTP/1.1 200 OK" > /dev/null || (echo "Failed running health check test" && exit 1)
docker push juliashub/pizza-express:${TAG:-latest}

echo "Get your fresh pizza-express on port 8081"