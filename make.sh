#!/bin/bash

git submodule init
git submodule update
fcpp/src/make.sh "$@"
