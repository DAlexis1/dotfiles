#!/bin/sh
clamscan / --recursive >"/home/sandor/log_vir/$(date +'%d-%m-%Y_%H:%M:%S').log"
