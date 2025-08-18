#!/bin/bash
. ./check.sh
. ./names.sh
. ./maker.sh

check $1 $2 $3 && {
    echo -n "" > log.log
    echo "start $(date "+%H:%M:%S")" | tee -a log.log
    make $1 $2 $3
    echo "end $(date "+%H:%M:%S")" | tee -a log.log
}
