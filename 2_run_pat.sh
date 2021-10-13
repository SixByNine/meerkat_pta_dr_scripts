#!/bin/bash


pat -A FDM -C chan -C snr -f "tempo2 IPTA" -s initial.std $(cat files.16ch) > initial.tim
