#! /bin/bash

set -o xtrace

MEASUREMENTS=10
INITIAL_SIZE=16
SIZE_ITERATIONS=10
INITIAL_NUM_THREADS=1
THREAD_ITERATIONS=6

SIZE=$INITIAL_SIZE
NUM_THREADS=$INITIAL_NUM_THREADS

NAMES=('mandelbrot_seq' 'mandelbrot_pth' 'mandelbrot_omp')

make
mkdir results

for NAME in ${NAMES[@]}; do
    mkdir results/$NAME

    for ((j=1; j<=$THREAD_ITERATIONS; j++)) do
        for ((i=1; i<=$SIZE_ITERATIONS; i++)); do
                perf stat -r $MEASUREMENTS ./$NAME -2.5 1.5 -2.0 2.0 $SIZE $NUM_THREADS>> full.log 2>&1
                perf stat -r $MEASUREMENTS ./$NAME -0.8 -0.7 0.05 0.15 $SIZE $NUM_THREADS>> seahorse.log 2>&1
                perf stat -r $MEASUREMENTS ./$NAME 0.175 0.375 -0.1 0.1 $SIZE $NUM_THREADS>> elephant.log 2>&1
                perf stat -r $MEASUREMENTS ./$NAME -0.188 -0.012 0.554 0.754 $SIZE $NUM_THREADS>> triple_spiral.log 2>&1
                SIZE=$(($SIZE * 2))
        done
        SIZE=$INITIAL_SIZE
        NUM_THREADS=$(($NUM_THREADS * 2))

        if [ $NAME == "mandelbrot_seq" ]; then
                break
        fi
    done

    NUM_THREADS=$INITIAL_NUM_THREADS

    mv *.log results/$NAME
    rm output.ppm
done
