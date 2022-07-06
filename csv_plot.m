1;

data_seq_full =           csvread('./src/data/mandelbrot_seq/full.csv');
data_seq_seahorse =       csvread('./src/data/mandelbrot_seq/seahorse.csv');
data_seq_elephant =       csvread('./src/data/mandelbrot_seq/elephant.csv');
data_seq_triple_spiral =  csvread('./src/data/mandelbrot_seq/triple_spiral.csv');

data_omp_full =           csvread('./src/data/mandelbrot_omp/full.csv');
data_omp_seahorse =       csvread('./src/data/mandelbrot_omp/seahorse.csv');
data_omp_elephant =       csvread('./src/data/mandelbrot_omp/elephant.csv');
data_omp_triple_spiral =  csvread('./src/data/mandelbrot_omp/triple_spiral.csv');

data_pth_full =           csvread('./src/data/mandelbrot_pth/full.csv');
data_pth_seahorse =       csvread('./src/data/mandelbrot_pth/seahorse.csv');
data_pth_elephant =       csvread('./src/data/mandelbrot_pth/elephant.csv');
data_pth_triple_spiral =  csvread('./src/data/mandelbrot_pth/triple_spiral.csv');

global yrange = [0 0.2];

global SIZE = 6;
global THREADS = 6;
global colors=['r', 'b', 'y', 'g', 'c', 'm'];

function plot_sequential(data)
  global yrange;

  ylim(yrange);

  line(data(1:end, 2),
       data(1:end, 3),
       "color", 'r',
       "marker", "x",
       "clipping", "on");
endfunction

function plot_size_threads(data)
  global THREADS;
  global SIZE;
  global colors;
  global yrange;

  ylim(yrange);

  row = 1;
  for i = 1:THREADS
    line(data(row:row + SIZE - 1, 2),
      data(row:row + SIZE - 1, 3),
      "color", colors(i),
      "marker", "x",
      "clipping", "on");

    legend("1 thread", "2 threads", "4 threads", "8 threads", "16 threads", "32 threads",
           "location", "eastoutside");
    row += SIZE;
  end
endfunction

figure(1);
title("Pthreads: Elephant");
plot_size_threads(data_pth_elephant);

figure(2);
title("OpenMP: Elephant");
plot_size_threads(data_omp_elephant);

figure(3);
title("Sequencial: Elephant");
plot_sequential(data_seq_elephant);
