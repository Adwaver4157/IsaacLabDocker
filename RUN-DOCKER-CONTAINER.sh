
docker volume create isaac-cache-kit
docker volume create isaac-cache-ov
docker volume create isaac-cache-pip
docker volume create isaac-cache-gl
docker volume create isaac-cache-compute
docker volume create isaac-logs
docker volume create isaac-carb-logs
docker volume create isaac-data
docker volume create isaac-docs
docker volume create isaac-lab-docs
docker volume create isaac-lab-logs
docker volume create isaac-lab-data

# Accept the NVIDIA Omniverse EULA by default
ACCEPT_EULA=Y
# NVIDIA Isaac Sim base image
ISAACSIM_BASE_IMAGE=nvcr.io/nvidia/isaac-sim
# NVIDIA Isaac Sim version to use (e.g. 4.5.0)
ISAACSIM_VERSION=4.5.0
# Derived from the default path in the NVIDIA provided Isaac Sim container
DOCKER_ISAACSIM_ROOT_PATH=/isaac-sim
# The Isaac Lab path in the container
DOCKER_ISAACLAB_PATH=/root/isaaclab
# Docker user directory - by default this is the root user's home directory
DOCKER_USER_HOME=/root

docker run --gpus all --rm -it \
  --env="ACCEPT_EULA=Y" \
  --env="DISPLAY=$DISPLAY" \
  --env="QT_X11_NO_MITSHM=1" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:ro" \
  --network=host \
  -e ISAACSIM_PATH=${DOCKER_ISAACLAB_PATH}/_isaac_sim \
  -e OMNI_KIT_ALLOW_ROOT=1 \
  --volume isaac-cache-kit:${DOCKER_ISAACSIM_ROOT_PATH}/kit/cache \
  --volume isaac-cache-ov:${DOCKER_USER_HOME}/.cache/ov \
  --volume isaac-cache-pip:${DOCKER_USER_HOME}/.cache/pip \
  --volume isaac-cache-gl:${DOCKER_USER_HOME}/.cache/nvidia/GLCache \
  --volume isaac-cache-compute:${DOCKER_USER_HOME}/.nv/ComputeCache \
  --volume isaac-logs:${DOCKER_USER_HOME}/.nvidia-omniverse/logs \
  --volume isaac-carb-logs:${DOCKER_ISAACSIM_ROOT_PATH}/kit/logs/Kit/Isaac-Sim \
  --volume isaac-data:${DOCKER_USER_HOME}/.local/share/ov/data \
  --volume isaac-docs:${DOCKER_USER_HOME}/Documents \
  --volume isaac-lab-docs:${DOCKER_ISAACLAB_PATH}/docs/_build \
  --volume isaac-lab-logs:${DOCKER_ISAACLAB_PATH}/logs \
  --volume isaac-lab-data:${DOCKER_ISAACLAB_PATH}/data_storage \
  --volume ./:/app \
  --name isaac-lab-base \
  isaac-lab-base:test \
  bash

