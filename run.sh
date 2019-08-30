CONTAINER_NAME='mitmproxy'
IMAGE_NAME='brunowdev/mitmproxy-local:latest'

CID=$(docker ps -q -f status=running -f name=^/${CONTAINER_NAME}$)
if [ "${CID}" ]; then
  echo "stoping container..."
  docker stop ${CONTAINER_NAME}
  echo "done"
fi
unset CID

echo "starting container"
docker run --network host --name ${CONTAINER_NAME} --rm -d \
    -v $(pwd):/data ${IMAGE_NAME} mitmweb --web-iface 0.0.0.0 -s /data/scripts/redirect.py

echo "done"
docker logs mitmproxy -f