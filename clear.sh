#!/bin/bash

sync;
echo 1 | sudo tee /proc/sys/vm/drop_caches;
sudo swapoff -a;
sudo swapon -a; 
