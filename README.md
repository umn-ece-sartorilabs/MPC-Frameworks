# MPC-Frameworks
A base repo consisting of the State-of-Art MPC frameworks
- MOTION
- MP-SPDZ
- piranha

## Repository Setup

Run the following command to recusively update the different frameworks and their respective dependancies (submodules).

```
git submodule update --init --recursive
```

## Docker Setup
MOTION and MP-SPDZ cannot be run natively on RHEL machine due to unresolvable dependancies. The root folder will therefore be mounted onto a Docker container (running Ubuntu 22.04), with all the dependancies resolved.

```
./setup_docker.sh
```
This script will use the `Dockerfile` to build the image with the required packages, (or use the cached image) and then open a container.

**NOTE**: For Piranha setup, directly follow the README inside piranha root directory.