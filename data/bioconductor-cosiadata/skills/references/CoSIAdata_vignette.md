# CoSIAdata, an Experimental Hub Package of VST Stabilized RNA-Seq Data that accompanies the CoSIA Package

Anisha Haldar, Vishal H. Oza, Amanda D. Clark, Nathaniel S. DeVoss, Brittany N. Lasseigne

#### 2023-02-13

---

# 1 CoSIAdata Introduction

VST Stabilized RNA-Seq Expression Data from Bgee across six species and more
than 132 tissues are made available through the CoSIAdata package.
The six species available through the package are *Homo sapiens*,
*Mus musculus*, *Rattus norvegicus*, *Danio rerio*, *Drosophila melanogaster*,
and *Caenorhabditis elegans*. Each species is found in an individualized Rdata
file from ExperimentHub and can be used in conjunction with CoSIA, a
visualization tool for comparing across species using gene expression metrics.
CoSIAdata’s individualized datasets provide the Anatomical Entity Name,
Anatomical Entity Id, Ensembl Id, and Experimental Id to accompany the
VST Stabilized RNA-Seq Expression Data allowing for species, tissue, and
gene-specific analysis to be conducted.

The example below demonstrates the process of downloading these
datasets from Experimental Hub.

##Installation of CoSIAdata
In R:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("CoSIAdata")
library(CoSIAdata)
```

## 1.1 Using CoSIAdata

CoSIAdata has species-specific helper functions for accessing expression data

```
c_elegans_vst_counts <- CoSIAdata::Caenorhabditis_elegans()
```

## 1.2 Behind the Scenes of CoSIAdata

CoSIAdata retrieves from `ExperimentHub` using the query functions

```
eh <- ExperimentHub()
query(eh, "CoSIAdata")
head(eh[["EH7863"]])
```

## 1.3 Accessing CoSIAdata Metadata

To get a list of species in CoSIAdata and other information about the datasets, query `ExperimentHub` as below

```
eh <- ExperimentHub::ExperimentHub()
AnnotationHub::query(eh, "CoSIAdata")
#> ExperimentHub with 6 records
#> # snapshotDate(): 2025-10-29
#> # $dataprovider: Bgee
#> # $species: Rattus norvegicus, Mus musculus, Homo sapiens, Drosophila melano...
#> # $rdataclass: data.frame
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["EH7858"]]'
#>
#>            title
#>   EH7858 | VST normalized RNA-Sequencing data with annotations for 362,533,...
#>   EH7859 | VST normalized RNA-Sequencing data with annotations for 31,405,6...
#>   EH7860 | VST normalized RNA-Sequencing data with annotations for 3,814,42...
#>   EH7861 | VST normalized RNA-Sequencing data with annotations for 5,235,72...
#>   EH7862 | VST normalized RNA-Sequencing data with annotations for 4,576,39...
#>   EH7863 | VST normalized RNA-Sequencing data with annotations for 1,923,06...
```

Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] rappdirs_0.3.3       sass_0.4.10          generics_0.1.4
#>  [4] BiocVersion_3.22.0   RSQLite_2.4.3        digest_0.6.37
#>  [7] magrittr_2.0.4       evaluate_1.0.5       bookdown_0.45
#> [10] fastmap_1.2.0        blob_1.2.4           AnnotationHub_4.0.0
#> [13] jsonlite_2.0.0       AnnotationDbi_1.72.0 DBI_1.2.3
#> [16] BiocManager_1.30.26  httr_1.4.7           purrr_1.1.0
#> [19] Biostrings_2.78.0    httr2_1.2.1          jquerylib_0.1.4
#> [22] cli_3.6.5            crayon_1.5.3         rlang_1.1.6
#> [25] XVector_0.50.0       dbplyr_2.5.1         Biobase_2.70.0
#> [28] bit64_4.6.0-1        withr_3.0.2          cachem_1.1.0
#> [31] yaml_2.3.10          tools_4.5.1          memoise_2.0.1
#> [34] dplyr_1.1.4          filelock_1.0.3       ExperimentHub_3.0.0
#> [37] BiocGenerics_0.56.0  curl_7.0.0           vctrs_0.6.5
#> [40] R6_2.6.1             png_0.1-8            stats4_4.5.1
#> [43] BiocFileCache_3.0.0  lifecycle_1.0.4      Seqinfo_1.0.0
#> [46] KEGGREST_1.50.0      S4Vectors_0.48.0     IRanges_2.44.0
#> [49] bit_4.6.0            pkgconfig_2.0.3      pillar_1.11.1
#> [52] bslib_0.9.0          glue_1.8.0           xfun_0.54
#> [55] tibble_3.3.0         tidyselect_1.2.1     knitr_1.50
#> [58] htmltools_0.5.8.1    rmarkdown_2.30       compiler_4.5.1
```