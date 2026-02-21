# JASPAR2024

Damir Baranasic

Imperial College London, Faculty of Medicine, Institute of Clinical Sciences, Hammersmith Campus, Du Cane Road, W12 0NN, London

#### 13 November 2024

# Contents

* [1 Retrieveing data from JASPAR](#retrieveing-data-from-jaspar)
* [2 Session Info](#session-info)
* [3 Bibliography](#bibliography)

# 1 Retrieveing data from JASPAR

JASPAR (<https://jaspar.elixir.no/>) is a widely-used open-access database presenting manually curated high-quality and non-redundant DNA-binding profiles for transcription factors (TFs) across taxa. In this 10th release and 20th-anniversary update, the CORE collection has expanded with 329 new profiles. We updated three existing profiles and provided orthogonal support for 72 profiles from the previous release’s UNVALIDATED collection. Altogether, the JASPAR 2024 update provides a 20% increase in CORE profiles from the previous release. A trimming algorithm enhanced profiles by removing low information content flanking base pairs, which were likely uninformative (within the capacity of the PFM models) for TFBS predictions and modelling TF-DNA interactions. This release includes enhanced metadata, featuring a refined classification for plant TFs’ structural DNA-binding domains. The new JASPAR collections prompt updates to the genomic tracks of predicted TF-binding sites in 8 organisms, with human and mouse tracks available as native tracks in the UCSC Genome browser. All data are available through the JASPAR web interface and programmatically through its API and the updated Bioconductor and pyJASPAR packages. Finally, a new TFBS extraction tool enables users to retrieve predicted JASPAR TFBSs intersecting their genomic regions of interest.

You can easily access data in JASPAR using the RSQLite package as shown:

```
library(JASPAR2024)
#> Loading required package: BiocFileCache
#> Loading required package: dbplyr
library(RSQLite)

JASPAR2024 <- JASPAR2024()
#> adding rname 'https://jaspar2022.genereg.net/download/database/JASPAR2024.sqlite'
JASPARConnect <- RSQLite::dbConnect(RSQLite::SQLite(), db(JASPAR2024))
RSQLite::dbGetQuery(JASPARConnect, 'SELECT * FROM MATRIX LIMIT 5')
#>     ID COLLECTION BASE_ID VERSION   NAME
#> 1 9229       CORE  MA0001       1   AGL3
#> 2 9230       CORE  MA0002       1  RUNX1
#> 3 9231       CORE  MA0003       1 TFAP2A
#> 4 9232       CORE  MA0004       1   Arnt
#> 5 9233       CORE  MA0005       1     AG
dbDisconnect(JASPARConnect)
```

# 2 Session Info

Here is the output of `sessionInfo()` on the system on which this document was compiled:

```
#> R Under development (unstable) (2024-10-21 r87258)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.1 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.21-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
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
#> [1] RSQLite_2.3.7        JASPAR2024_0.99.7    BiocFileCache_2.15.0
#> [4] dbplyr_2.5.0         BiocStyle_2.35.0
#>
#> loaded via a namespace (and not attached):
#>  [1] bit_4.5.0           jsonlite_1.8.9      dplyr_1.1.4
#>  [4] compiler_4.5.0      BiocManager_1.30.25 filelock_1.0.3
#>  [7] tidyselect_1.2.1    blob_1.2.4          jquerylib_0.1.4
#> [10] yaml_2.3.10         fastmap_1.2.0       R6_2.5.1
#> [13] generics_0.1.3      curl_6.0.0          knitr_1.49
#> [16] tibble_3.2.1        bookdown_0.41       DBI_1.2.3
#> [19] bslib_0.8.0         pillar_1.9.0        rlang_1.1.4
#> [22] utf8_1.2.4          cachem_1.1.0        xfun_0.49
#> [25] sass_0.4.9          bit64_4.5.2         memoise_2.0.1
#> [28] cli_3.6.3           withr_3.0.2         magrittr_2.0.3
#> [31] digest_0.6.37       lifecycle_1.0.4     vctrs_0.6.5
#> [34] evaluate_1.0.1      glue_1.8.0          fansi_1.0.6
#> [37] purrr_1.0.2         httr_1.4.7          rmarkdown_2.29
#> [40] tools_4.5.0         pkgconfig_2.0.3     htmltools_0.5.8.1
```

# 3 Bibliography