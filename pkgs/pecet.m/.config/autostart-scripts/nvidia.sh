#!/bin/sh

nvidia-settings -l
nvidia-settings -a "[gpu:0]/GpuPowerMizerMode=1"
