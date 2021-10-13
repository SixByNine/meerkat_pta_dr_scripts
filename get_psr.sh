#!/bin/bash
rsync --filter="merge filter" -avP ozstar.swin.edu.au:/fred/oz005/timing_processed/PTA/$1 .
