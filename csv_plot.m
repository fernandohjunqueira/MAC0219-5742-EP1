1;

data_seq_full =           csvread('./src/data/mandelbrot_seq/full.csv');
data_seq_seahorse =       csvread('./src/data/mandelbrot_seq/seahorse.csv');
data_seq_elephant =       csvread('./src/data/mandelbrot_seq/elephant.csv');
data_seq_triple_spiral =  csvread('./src/data/mandelbrot_seq/triple_spiral.csv');

data_seq_mod_full =           csvread('./src/data/mandelbrot_seq_mod/full.csv');
data_seq_mod_seahorse =       csvread('./src/data/mandelbrot_seq_mod/seahorse.csv');
data_seq_mod_elephant =       csvread('./src/data/mandelbrot_seq_mod/elephant.csv');
data_seq_mod_triple_spiral =  csvread('./src/data/mandelbrot_seq_mod/triple_spiral.csv');

data_omp_full =           csvread('./src/data/mandelbrot_omp/full.csv');
data_omp_seahorse =       csvread('./src/data/mandelbrot_omp/seahorse.csv');
data_omp_elephant =       csvread('./src/data/mandelbrot_omp/elephant.csv');
data_omp_triple_spiral =  csvread('./src/data/mandelbrot_omp/triple_spiral.csv');

data_pth_full =           csvread('./src/data/mandelbrot_pth/full.csv');
data_pth_seahorse =       csvread('./src/data/mandelbrot_pth/seahorse.csv');
data_pth_elephant =       csvread('./src/data/mandelbrot_pth/elephant.csv');
data_pth_triple_spiral =  csvread('./src/data/mandelbrot_pth/triple_spiral.csv');

global yrange = [0 0.2];

global SIZE = 10;
global THREADS = 6;
global colors=['r', 'b', 'y', 'g', 'c', 'm'];

function plot_sequential(data)
  global yrange;

  #ylim(yrange);

  line(data(1:end, 2),
       data(1:end, 3),
       "linewidth", 1,
       "color", 'r',
       "marker", ".",
       "markersize", 8,
       "clipping", "on");

  xlabel("Entry Size");
  ylabel("Time Elapsed (seconds)");
  box on;
  grid on;

endfunction

function plot_size_threads(data)
  global THREADS;
  global SIZE;
  global colors;
  global yrange;

  #ylim(yrange);

  row = 1;
  for i = 1:THREADS
    line(data(row:row + SIZE - 1, 2),
      data(row:row + SIZE - 1, 3),
      "linewidth", 1,
      "color", colors(i),
      "marker", ".",
      "markersize", 8,
      "clipping", "on");

    row += SIZE;
  end

  xlabel("Entry Size");
  ylabel("Time Elapsed (seconds)");
  legend("1 thread", "2 threads", "4 threads", "8 threads", "16 threads", "32 threads",
         "location", "eastoutside");
  box on;
  grid on;

endfunction

# CLEARING
close all

# SEQUENTIAL
figure(1);
title("Sequential: Full", "FontSize", 22, 'FontName', 'SansSerif');
plot_sequential(data_seq_full);
saveas(1, "seq_full", "jpg");
close;

figure(2);
title("Sequential: Seahorse", "FontSize", 22, 'FontName', 'SansSerif');
plot_sequential(data_seq_seahorse);
saveas(2, "seq_seahorse", "jpg");
close;

figure(3);
title("Sequential: Elephant", "FontSize", 22, 'FontName', 'SansSerif');
plot_sequential(data_seq_elephant);
saveas(3, "seq_elephant", "jpg");
close;

figure(4);
title("Sequential: Triple Spiral", "FontSize", 22, 'FontName', 'SansSerif');
plot_sequential(data_seq_triple_spiral);
saveas(4, "seq_triple_spiral", "jpg");
close;

# SEQUENTIAL (MOD)
figure(5);
title("Sequential (mod): Full", "FontSize", 22, 'FontName', 'SansSerif');
plot_sequential(data_seq_mod_full);
saveas(5, "seq_mod_full", "jpg");
close;

figure(6);
title("Sequential (mod): Seahorse", "FontSize", 22, 'FontName', 'SansSerif');
plot_sequential(data_seq_mod_seahorse);
saveas(6, "seq_mod_seahorse", "jpg");
close;

figure(7);
title("Sequential (mod): Elephant", "FontSize", 22, 'FontName', 'SansSerif');
plot_sequential(data_seq_mod_elephant);
saveas(7, "seq_mod_elephant", "jpg");
close;

figure(8);
title("Sequential (mod): Triple Spiral", "FontSize", 22, 'FontName', 'SansSerif');
plot_sequential(data_seq_mod_triple_spiral);
saveas(8, "seq_mod_triple_spiral", "jpg");
close;

# PTHREADS
figure(9);
title("Pthreads: Full", "FontSize", 22, 'FontName', 'SansSerif');
plot_size_threads(data_pth_full);
saveas(9, "pth_full", "jpg");
close;

figure(10);
title("Pthreads: Seahorse", "FontSize", 22, 'FontName', 'SansSerif');
plot_size_threads(data_pth_seahorse);
saveas(10, "pth_seahorse", "jpg");
close;

figure(11);
title("Pthreads: Elephant", "FontSize", 22, 'FontName', 'SansSerif');
plot_size_threads(data_pth_elephant);
saveas(11, "pth_elephant", "jpg");
close;

figure(12);
title("Pthreads: Triple Spiral", "FontSize", 22, 'FontName', 'SansSerif');
plot_size_threads(data_pth_triple_spiral);
saveas(12, "pth_triple_spiral", "jpg");
close;

# OPENMP
figure(13);
title("OpenMP: Full", "FontSize", 22, 'FontName', 'SansSerif');
plot_size_threads(data_omp_full);
saveas(13, "omp_full", "jpg");
close;

figure(14);
title("OpenMP: Seahorse", "FontSize", 22, 'FontName', 'SansSerif');
plot_size_threads(data_omp_seahorse);
saveas(14, "omp_seahorse", "jpg");
close;

figure(15);
title("OpenMP: Elephant", "FontSize", 22, 'FontName', 'SansSerif');
plot_size_threads(data_omp_elephant);
saveas(15, "omp_elephant", "jpg");
close;

figure(16);
title("OpenMP: Triple Spiral", "FontSize", 22, 'FontName', 'SansSerif');
plot_size_threads(data_omp_triple_spiral);
saveas(16, "omp_triple_spiral", "jpg");
close;
