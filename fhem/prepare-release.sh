#!/usr/bin/env bash
cd "$( dirname "${BASH_SOURCE[0]}" )"
./new-controls.pl > controls_smarter-coffee.txt
./new-changed.pl > CHANGED
