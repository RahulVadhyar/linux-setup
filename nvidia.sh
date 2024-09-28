#!/bin/bash

sudo dnf upgrade -y
sudo dnf install akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-libs.i686
sudo akmod --force
sudo dracut --force