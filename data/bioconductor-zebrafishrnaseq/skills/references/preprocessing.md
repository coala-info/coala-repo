# Pre-Processing for the Zebrafish RNA-Seq Gene-Level Counts

Davide Risso

#### Last modified: June 7, 2024; Compiled: November 04, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Sample preparation and sequencing](#sample-preparation-and-sequencing)
* [3 Read alignment and expression quantitation](#read-alignment-and-expression-quantitation)
* [4 Loading the zebrafish data into R](#loading-the-zebrafish-data-into-r)
* [5 Session info](#session-info)
* [References](#references)

# 1 Introduction

This vignette describes the pre-processing steps that were followed for
the generation of the gene-level read counts contained in the Bioconductor package
*zebrafishRNASeq*.

# 2 Sample preparation and sequencing

Olfactory sensory neurons were isolated from three pairs of
gallein-treated and control embryonic zebrafish pools and purified by
fluorescence activated cell sorting (FACS)
(Ferreira et al. [2014](#ref-ferreira2014silencing)). Each RNA sample was enriched in
poly(A)+ RNA from 10–30 ng total RNA and 1 \(\mu\)L (1:1000 dilution) of Ambion ERCC ExFold RNA Spike-in Control Mix 1 was added to 30 ng of total RNA before mRNA isolation. cDNA libraries were prepared
according to manufacturer’s protocol.
The six libraries were sequenced in two multiplex runs on an Illumina HiSeq2000 sequencer,
yielding approximately 50 million 100bp paired-end reads per
library.

# 3 Read alignment and expression quantitation

We made use of a custom reference sequence,
defined as the union of the zebrafish reference genome (Zv9,
downloaded from Ensembl (Flicek et al. [2012](#ref-flicek2012ensembl)), v. 67) and the [ERCC
spike-in sequences](https://www.thermofisher.com/order/catalog/product/4456739). Reads were
mapped with TopHat (Trapnell, Pachter, and Salzberg [2009](#ref-trapnell2009tophat)) (v. 2.0.4), with the
following parameters,

```
--library-type=fr-unstranded -G ensembl.gtf --transcriptome-index=transcript --no-novel-juncs
```

where *ensembl.gtf* is a GTF file containing Ensembl gene
annotation.

Gene-level read counts were obtained using the htseq-count python script (Anders, Pyl, and Huber [2014](#ref-htseq)) in the “union” mode and Ensembl (v. 67) gene annotation.

After verifying that there were no run-specific biases, we used the sums of the counts of the two runs as the expression measures for each library.

# 4 Loading the zebrafish data into R

To load the gene-level read counts into R, simply type

```
library(zebrafishRNASeq)
data(zfGenes)

head(zfGenes)
```

```
##                    Ctl1 Ctl3 Ctl5 Trt9 Trt11 Trt13
## ENSDARG00000000001  304  129  339  102    16   617
## ENSDARG00000000002  605  637  406   82   230  1245
## ENSDARG00000000018  391  235  217  554   451   565
## ENSDARG00000000019 2979 4729 7002 7309  9395  3349
## ENSDARG00000000068   89  356   41  149    45    44
## ENSDARG00000000069  312  184  844  269   513   243
```

The ERCC spike-in read counts are in the last rows of the same matrix
and can be retrieved in the following way.

```
spikes <- zfGenes[grep("^ERCC", rownames(zfGenes)),]
head(spikes)
```

```
##              Ctl1   Ctl3   Ctl5   Trt9  Trt11  Trt13
## ERCC-00002  97227  38556  68367 148331 169360 100974
## ERCC-00003  10925   6240  11156  36652  21184  21841
## ERCC-00004 379182 179870 256130 679783 529085 311169
## ERCC-00009   2452   1183   1042   1895   3520   1252
## ERCC-00012      0      0      0      0      0      0
## ERCC-00013     89      8      0    205     21      3
```

The typical use of this dataset is the indentification of differentially expressed genes between control (Ctl) and treated (Trt) samples. For additional details, exploratory analysis, and normalization of the zebrafish data see Risso et al. ([2014](#ref-risso2014ruv)[a](#ref-risso2014ruv)) and Risso et al. ([2014](#ref-risso2014role)[b](#ref-risso2014role)). The data are used as a case study for the Bioconductor package
*RUVSeq*.

# 5 Session info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] zebrafishRNASeq_1.30.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.54           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```

# References

Anders, S., P. T. Pyl, and W. Huber. 2014. “HTSeq – A Python Framework to Work with High-Throughput Sequencing Data.” *bioRxiv Preprint*.

Ferreira, T., S. R. Wilson, Y. G. Choi, D. Risso, S. Dudoit, T. P. Speed, and J. Ngai. 2014. “Silencing of Odorant Receptor Genes by G Protein \(\beta\gamma\) Signaling Ensures the Expression of One Odorant Receptor Per Olfactory Sensory Neuron.” *Neuron* 81: 847–59.

Flicek, P., M. R. Amode, D. Barrell, K. Beal, S. Brent, D. Carvalho-Silva, P. Clapham, et al. 2012. “Ensembl 2012.” *Nucleic Acids Research* 40 (D1): D84–D90.

Risso, D., J. Ngai, T. P. Speed, and S. Dudoit. 2014a. “Normalization of RNA-seq Data Using Factor Analysis of Control Genes or Samples.” *Nature Biotechnology* 32 (9): 896–902.

———. 2014b. “The Role of Spike-in Standards in the Normalization of RNA-seq.” In *Statistical Analysis of Next Generation Sequence Data*, edited by D. Nettleton and S. Datta. Springer.

Trapnell, C., L. Pachter, and S. L. Salzberg. 2009. “TopHat: Discovering Splice Junctions with RNA-Seq.” *Bioinformatics* 25 (9): 1105–11.