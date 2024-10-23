#!/bin/bash

sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-power xorg-x11-drv-nvidia-xorg-libs xorg-x11-drv-nvidia-cuda-libs
sudo akmods --force
sudo dracut --force