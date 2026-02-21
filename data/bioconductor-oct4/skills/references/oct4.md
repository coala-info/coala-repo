# Experiment and sample description

This package provides the output of running Salmon on a set of 12
RNA-seq samples from King & Klose, “The pioneer
factor OCT4 requires the chromatin remodeller BRG1 to support
gene regulatory element function in mouse embryonic stem cells”
published in eLIFE, March 2017
[doi: 10.7554/eLife.22631](https://doi.org/10.7554/eLife.22631).

All 12 samples from the experiment were re-quantified, which consists
of three replicates each of OCT4 conditional cells treated with 1
micrograms/mL doxycycline for 24 hr and controls (see paper Materials and
Methods), and Brg1 conditional cells treated with 4-hydroxytamoxifen
for 72 hr and controls (see paper Materials and Methods).

# Salmon quantification

[Salmon](https://combine-lab.github.io/salmon/)
version 0.12.0 was run using
[Gencode](https://www.gencodegenes.org/)
mouse reference transcripts M20, with a
[snakemake](https://snakemake.readthedocs.io/en/stable/)
script that can be seen in `inst/scripts/Snakemake` and with
log output in `inst/scripts/snakemake.log`.

The quantification output is in the `inst/extdata/quant`
directory. The `quant.sf` files have been gzipped to preserve space,
so they are stored as `quant.sf.gz`. There are 20 Gibbs inferential
replicates for each sample.

# Sample information

The `inst/extdata/coldata.csv` file was obtained from the
`SraRunTable.txt` downloaded directly from SRA. This file contains the
phenotypic information about the 12 samples:

```
dir <- system.file("extdata", package="oct4")
coldata <- read.csv(file.path(dir,"coldata.csv"))
coldata
```

```
##         names line condition
## 1  SRX2236945 OCT4     untrt
## 2  SRX2236946 OCT4     untrt
## 3  SRX2236947 OCT4     untrt
## 4  SRX2236948 OCT4       trt
## 5  SRX2236949 OCT4       trt
## 6  SRX2236950 OCT4       trt
## 7  SRX2236951 BRG1     untrt
## 8  SRX2236952 BRG1     untrt
## 9  SRX2236953 BRG1     untrt
## 10 SRX2236954 BRG1       trt
## 11 SRX2236955 BRG1       trt
## 12 SRX2236956 BRG1       trt
```

# Acknowledgments

Thanks to the study authors for posting their data publicly and
clearly labelling their data, and for James Ashmore for pointing me to
this dataset.

# Session info

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
## loaded via a namespace (and not attached):
## [1] compiler_4.5.1 tools_4.5.1    knitr_1.50     xfun_0.54      evaluate_1.0.5
```