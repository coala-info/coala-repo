# histoneHMM

histoneHMM moved to [GitHub](https://github.com/matthiasheinig/histoneHMM). Future updates will be available there.

histoneHMM is a software to analyse ChIP-seq data of histone modifications with broad genomic footprints like H3K27me3. It allows for calling modified regions in single samples as well as for calling differentially modified regions in a comparison of two samples.

## News

Version 1.6 fixes some smaller bugs and removes the dependency on the GNU scientific library

We released version 1.5 introduces a command line interface (see vignette), improved preprocessing and an updated vignette.

We have just released the new and improved version 1.4 with a high level interface for more convenience.

## Download

[Current version available at github](https://github.com/matthiasheinig/histoneHMM)

## Installation

The package was developed and tested using a linux system, so installation instructions are given for linux and unix like systems.

* Start a terminal
* Download the package using

  ```
  wget http://histonehmm.molgen.mpg.de/histoneHMM_1.6.tar.gz
  ```
* Install using

  ```
  R CMD INSTALL histoneHMM_1.6.tar.gz
  ```

## Usage

We provide a small test data set to try out the package:

* Preprocessed data:
  + [BN.txt](data/BN.txt)
  + [SHR.txt](data/SHR.txt)
* Raw data:
  + [BN.bam](data/BN.bam)
  + [BN.bam.bai](data/BN.bam.bai)
  + [SHR.bam](data/SHR.bam)
  + [SHR.bam.bai](data/SHR.bam.bai)
  + [chroms.txt](data/chroms.txt): table of chromosome lengths
  + [ensembl59-genes.gff](data/ensembl59-genes.gff): gene annotation in gff format (only gene bodies, no exon information)
  + [expression.txt](data/expression.txt): RNA-seq gene expression

We have a new and improved version with a high level interface for more convenience. Please check out the package vignette:

* [histoneHMM.pdf](v1.6/histoneHMM.pdf)
* [histoneHMM.R](v1.6/histoneHMM.R)

## Citation

Heinig M, Colome-Tatche M, Rintisch C, Schäfer S, Pravenec M, Hubner N, Vingron M, Johannes F. [histoneHMM: Differential analysis of histone modifications with broad genomic footprints.](http://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-015-0491-6) BMC Bioinformatics 2015; 16:60

## Contact

Matthias Heinig: heinig@molgen.mpg.de