[INA Research Group](https://ina.kaist.ac.kr/)

Toggle navigation

* [About](/)
* [Members](/team/)
* [Projects](/projects/)
* [Publications](/publications/)
* [Join Us](/join-us)
* [Alumni](/alumni)

# BWA-MEME

BWA-MEM emulated with a machine learning approach

![](/assets/img/project/bwa-meme/system_overview.png "BWA-MEME")

BWA-MEME: Design Overview

[![](https://anaconda.org/bioconda/bwa-meme/badges/version.svg)](https://bioconda.github.io/recipes/bwa-meme/README.html)
[![](https://anaconda.org/bioconda/bwa-meme/badges/downloads.svg)](https://bioconda.github.io/recipes/bwa-meme/README.html)

### Summary

The growing use of next-generation sequencing and enlarged sequencing throughput require efficient
short-read alignment, where seeding is one of the major performance bottlenecks. The key challenge in the seeding
phase is searching for exact matches of substrings of short reads in the reference DNA sequence. Existing algorithms, however, present limitations in performance due to their frequent memory accesses.

BWA-MEME is the first full-fledged short read alignment software that leverages learned
indices for solving the exact match search problem for efficient seeding. BWA-MEME is a practical and efficient
seeding algorithm based on a suffix array search algorithm that solves the challenges in utilizing learned indices for
SMEM search which is extensively used in the seeding phase. Our evaluation shows that BWA-MEME achieves up
to 3.45 speedup in seeding throughput over BWA-MEM2 by reducing the number of instructions by 4.60, memory accesses by 8.77 and LLC misses by 2.21, while ensuring the identical SAM output to BWA-MEM2.

[Code](https://github.com/kaist-ina/BWA-MEME)

### Publications

1. Bioinformatics

   BWA-MEME: BWA-MEM emulated with a machine learning approach

   [Youngmok Jung](https://quito418.github.io/quito418/), and [Dongsu Han](/team/dongsuh)

   *Bioinformatics* Mar 2022

   [Paper](https://academic.oup.com/bioinformatics/advance-article/doi/10.1093/bioinformatics/btac137/6543607?searchresult=1)
   [Project](/projects/bwa-meme)
   [Code](https://github.com/kaist-ina/bwa-meme#citation)

### Members

[![YoungmokJung](/assets/img/profile/youngmok-jung.jpg)

##### Youngmok Jung

Alumni](https://quito418.github.io/quito418/)

[![DongsuHan](/assets/img/profile/dongsu-han.jpg)

##### Dongsu Han

Principal Investigator](/team/dongsuh)

© Copyright 2026 INA Research Group.