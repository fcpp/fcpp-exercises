#!/bin/bash

git submodule init
git submodule update
mkdir -p plot
cp fcpp/src/extras/plotter/plot.asy plot/
fcpp/src/make.sh "$@"
