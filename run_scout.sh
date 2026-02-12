docker rm scout_nav2

xhost +local:root

docker run -it --name scout_nav2 \
  --net=host \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -e XAUTHORITY=/root/.Xauthority \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v "$XAUTHORITY":/root/.Xauthority:ro \
  -v ~/scout_nav2_docker/ws:/ws \
  scout_nav2_docker-scout:latest bash
