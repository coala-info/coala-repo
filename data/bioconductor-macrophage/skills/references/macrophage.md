# Experiment and sample description

This package provides the output of running Salmon on a set of 24
RNA-seq samples from Alasoo, et al. “Shared genetic effects on
chromatin and gene expression indicate a role for enhancer priming in
immune response”, published in Nature Genetics, January 2018
[doi: 10.1038/s41588-018-0046-7](https://doi.org/10.1038/s41588-018-0046-7).

6 donors were selected from those that had publicly available reads in
ENA. The selection procress is recorded in the file
`inst/scripts/ena_download.R`, the donors were chosen as all female,
the sample having been received as frozen, and then the top 6 were
chosen based on mean purity as recorded by the study authors.

# Salmon quantification

[Salmon](https://combine-lab.github.io/salmon/)
version 0.12.0 was run using
[Gencode](https://www.gencodegenes.org/)
human reference transcripts v29, with a
[snakemake](https://snakemake.readthedocs.io/en/stable/)
script that can be seen in `inst/scripts/Snakemake` and with
log output in `inst/scripts/snakemake.log`.

The quantification output is in the `inst/extdata/quant`
directory. The `quant.sf` files have been gzipped to preserve space,
so they are stored as `quant.sf.gz`. There are 20 Gibbs inferential
replicates for each sample.

# Sample information

The `inst/scripts/ena_downloads.R` R script also shows how the column
data file `coldata.csv` was generated. This file contains the
phenotypic information about the 24 samples:

```
dir <- system.file("extdata", package="macrophage")
coldata <- read.csv(file.path(dir,"coldata.csv"))
coldata <- coldata[,c(1,2,3,5)]
coldata
```

```
##             names sample_id line_id condition_name
## 1  SAMEA103885102    diku_A  diku_1          naive
## 2  SAMEA103885347    diku_B  diku_1           IFNg
## 3  SAMEA103885043    diku_C  diku_1         SL1344
## 4  SAMEA103885392    diku_D  diku_1    IFNg_SL1344
## 5  SAMEA103885182    eiwy_A  eiwy_1          naive
## 6  SAMEA103885136    eiwy_B  eiwy_1           IFNg
## 7  SAMEA103885413    eiwy_C  eiwy_1         SL1344
## 8  SAMEA103884967    eiwy_D  eiwy_1    IFNg_SL1344
## 9  SAMEA103885368    fikt_A  fikt_3          naive
## 10 SAMEA103885218    fikt_B  fikt_3           IFNg
## 11 SAMEA103885319    fikt_C  fikt_3         SL1344
## 12 SAMEA103885004    fikt_D  fikt_3    IFNg_SL1344
## 13 SAMEA103885284    ieki_A  ieki_2          naive
## 14 SAMEA103885059    ieki_B  ieki_2           IFNg
## 15 SAMEA103884898    ieki_C  ieki_2         SL1344
## 16 SAMEA103885157    ieki_D  ieki_2    IFNg_SL1344
## 17 SAMEA103885111    podx_A  podx_1          naive
## 18 SAMEA103884919    podx_B  podx_1           IFNg
## 19 SAMEA103885276    podx_C  podx_1         SL1344
## 20 SAMEA103885021    podx_D  podx_1    IFNg_SL1344
## 21 SAMEA103885262    qaqx_A  qaqx_1          naive
## 22 SAMEA103885228    qaqx_B  qaqx_1           IFNg
## 23 SAMEA103885308    qaqx_C  qaqx_1         SL1344
## 24 SAMEA103884949    qaqx_D  qaqx_1    IFNg_SL1344
```

# SummarizedExperiment

The package also contains a summarized experiment object created
using the script in `inst/scripts/gse_create.R`. This object can be
loaded with `data("gse")`.

# Acknowledgments

Thanks to the study authors for posting their data publicly and
clearly labelling their data.

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