# FScanR: detect programmed ribosomal frameshifting events from various genomes

#### Xiao Chen Columbia University Medical Center

#### 2020-10-27

* [Abstract](#abstract)
* [Introduction](#introduction)
  + [Install FScanR](#install-fscanr)
  + [Load FScanR and test data](#load-fscanr-and-test-data)
  + [PRF events detection](#prf-events-detection)
  + [PRF event types plot](#prf-event-types-plot)
* [Citation](#citation)
* [Session Information](#session-information)

# Abstract

‘FScanR’ identifies Programmed Ribosomal Frameshifting (PRF) events from BLASTX homolog sequence alignment between targeted genomic/cDNA/mRNA sequences against the peptide library of the same species or a close relative. The output by BLASTX or diamond BLASTX will be used as input of ‘FScanR’ and should be in a tabular format with 14 columns.

For BLASTX, the output parameter should be:

```
-outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qframe sframe'
```

For diamond BLASTX, the output parameter should be:

```
-outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore qframe qframe
```

For details, please visit <https://doi.org/10.1111/1755-0998.13023>.

# Introduction

Ribosomal frameshifting, also known as translational frameshifting or translational recoding, is a biological phenomenon that occurs during translation that results in the production of multiple, unique proteins from a single mRNA. The process can be programmed by the nucleotide sequence of the mRNA and is sometimes affected by the secondary, 3-dimensional mRNA structure. It has been described mainly in viruses (especially retroviruses), retrotransposons and bacterial insertion elements, and also in some cellular genes.

For details, please visit [Ribosomal frameshift](https://en.wikipedia.org/wiki/Ribosomal_frameshift).

## Install FScanR

```
##  Install FScanR in R (>= 3.5.0)
if(!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")
BiocManager::install("FScanR")
```

## Load FScanR and test data

The dataset *test* in this vignettes was homolog sequence alignment between *Euplotes vannus* mRNA and protein sequences, output by BLASTX, from [*Chen et al., 2019*](https://doi.org/10.1111/1755-0998.13023).

```
## loading package
library(FScanR)
## loading test data
test_data <- read.table(system.file("extdata", "test.tab", package = "FScanR"), header=TRUE, sep="\t")
```

## PRF events detection

The default cutoffs for *E-value* and *frameDist* are *1e-05* and *10* (nt), respectively.

Low *E-value* cutoff ensures the fidelity of sequence alignment, but a too strict cutoff may also leads to false-negative detection.

Small *frameDist* cutoff avoids the false-positive PRF events introduced by introns, especially when using genomic sequences as query sequence. *frameDist* cutoff should be at least 4 nt.

Detected high PRF events will be output in tabular format with 7 columns. The column *FS\_type* contains the type information (-2, -1, +1, +2) of PRF events.

```
## loading packages
prf <- FScanR(test_data, evalue_cutoff = 1e-05, frameDist_cutoff = 10)
table(prf$FS_type)
```

```
##
##  -2  -1   1   2
##   6  97 295   6
```

## PRF event types plot

In this vignettes, the number of detected events of four PRF types are presented in a pie chart.

```
## plot the 4-type PRF events detected
mytable <- table(prf$FS_type)
lbls <- paste(names(mytable), " : ", mytable, sep="")
pie(mytable, labels = NA, main=paste0("PRF events"), cex=0.5, col=cm.colors(length(mytable)))
legend("right",legend=lbls[!is.na(lbls)], bty="n", cex=1,  fill=cm.colors(length(mytable))[!is.na(lbls)])
```

![](data:image/png;base64...)

# Citation

If you use [FScanR](https://github.com/seanchen607/FScanR) in published research, please cite the most appropriate paper(s) from this list:

1. **X Chen**, Y Jiang, F Gao\*, W Zheng, TJ Krock, NA Stover, C Lu, LA Katz & W Song (2019). Genome analyses of the new model protist Euplotes vannus focusing on genome rearrangement and resistance to environmental stressors. ***Molecular Ecology Resources***, 19(5):1292-1308. doi: [10.1111/1755-0998.13023](https://doi.org/10.1111/1755-0998.13023).

# Session Information

Here is the output of `sessionInfo()` on the system on which this document was compiled:

```
## R version 4.0.3 (2020-10-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.5 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.12-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.12-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] FScanR_1.0.0
##
## loaded via a namespace (and not attached):
##  [1] compiler_4.0.3  magrittr_1.5    htmltools_0.5.0 tools_4.0.3
##  [5] prettydoc_0.4.0 yaml_2.2.1      stringi_1.5.3   rmarkdown_2.5
##  [9] knitr_1.30      stringr_1.4.0   digest_0.6.27   xfun_0.18
## [13] rlang_0.4.8     evaluate_0.14
```