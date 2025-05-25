# IsaacLabDocker

## Setup
1. build docker image
```bash
docker build ./docker -t isaac-lab-base:test
```
2. run docker container
```bash
./RUN-DOCKER-CONTAINER.sh
```


## Run training
Run default isaaclab tutorial
```bash
# ./isaaclab.sh -p scripts/reinforcement_learning/sb3/train.py --task Isaac-Cartpole-v0 --num_envs 64 --headless --video
./isaaclab.sh -p scripts/reinforcement_learning/skrl/train.py --task Isaac-Velocity-Rough-Unitree-Go2-v0 --num_envs 64 --headless --video
```

Run isaaclab extension tutorial
```bash
python -m pip install -e source/ext_template
python scripts/rsl_rl/train.py --task=Template-Isaac-Velocity-Rough-Anymal-D-v0 --headless --video
```

## Eval
```bash
./isaaclab.sh -p scripts/reinforcement_learning/skrl/play.py --task Isaac-Velocity-Rough-Unitree-Go2-v0 --num_envs 64 --headless --video --checkpoiont PATH
```