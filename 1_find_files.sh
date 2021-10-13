#!/bin/bash

find . -name '*16chTS*.ar' > files.16ch
cp $(find . -name '*.std' | head -n 1)  initial.std
cp $(find . -name '*.par' | head -n 1)  initial.par
