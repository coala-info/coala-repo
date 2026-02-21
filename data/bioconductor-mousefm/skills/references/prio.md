# Prioritization of inbred mouse strains for resolving genetic regions

Matthias Munz

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Loading package](#loading-package)
* [4 Example function calls](#example-function-calls)
* [5 Output of Session Info](#output-of-session-info)

# 1 Introduction

This **R** package provides methods for **genetic finemapping** in **inbred mice** by taking advantage of their **very high homozygosity rate** (>95%).

Method `prio` allows to select strain combinations which best refine a specified genetic region. E.g. if a crossing experiment with two inbred mouse strains ‘strain1’ and ‘strain2’ resulted in a QTL, the outputted strain combinations can be used to refine the respective region in further crossing experiments and to select candidate genes.

# 2 Installation

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MouseFM")
```

# 3 Loading package

```
library(MouseFM)
```

# 4 Example function calls

Available mouse strains

```
avail_strains()
#>              id        strain
#> 1  129P2_OlaHsd  129P2/OlaHsd
#> 2   129S1_SvImJ   129S1/SvImJ
#> 3  129S5SvEvBrd 129S5/SvEvBrd
#> 4           A_J           A/J
#> 5         AKR_J         AKR/J
#> 6       BALB_cJ       BALB/cJ
#> 7          BTBR          BTBR
#> 8       BUB_BnJ       BUB/BnJ
#> 9       C3H_HeH       C3H/HeH
#> 10      C3H_HeJ       C3H/HeJ
#> 11    C57BL_10J     C57BL/10J
#> 12     C57BL_6J      C57BL/6J
#> 13    C57BL_6NJ     C57BL/6NJ
#> 14    C57BR_cdJ     C57BR/cdJ
#> 15       C57L_J        C57L/J
#> 16        C58_J         C58/J
#> 17     CAST_EiJ      CAST/EiJ
#> 18        CBA_J         CBA/J
#> 19       DBA_1J        DBA/1J
#> 20       DBA_2J        DBA/2J
#> 21       FVB_NJ        FVB/NJ
#> 22        I_LnJ         I/LnJ
#> 23       KK_HiJ        KK/HiJ
#> 24    LEWES_EiJ     LEWES/EiJ
#> 25         LP_J          LP/J
#> 26     MOLF_EiJ      MOLF/EiJ
#> 27   NOD_ShiLtJ    NOD/ShiLtJ
#> 28     NZB_B1NJ      NZB/B1NJ
#> 29    NZO_HlLtJ     NZO/HlLtJ
#> 30     NZW_LacJ      NZW/LacJ
#> 31      PWK_PhJ       PWK/PhJ
#> 32         RF_J          RF/J
#> 33      SEA_GnJ       SEA/GnJ
#> 34    SPRET_EiJ     SPRET/EiJ
#> 35        ST_bJ         ST/bJ
#> 36      WSB_EiJ       WSB/EiJ
#> 37  ZALENDE_EiJ   ZALENDE/EiJ
```

Prioritize additional mouse strains for a given region which was identified in a crossing experiment with strain1 C57BL\_6J and strain2 AKR\_J.

```
df = prio("chr1", start=5000000, end=6000000, strain1="C57BL_6J", strain2="AKR_J")
#> Query chr1:5,000,000-6,000,000
#> Calculate reduction factors...
#> Set size 1: 35 combinations
#> Set size 1: continue with 20 of 35 strains
#> Set size 2: 190 combinations
#> Set size 3: 1,140 combinations
```

View meta information

```
comment(df)
#> NULL
```

Extract the combinations with the best refinement

```
get_top(df$reduction, n_top=3)
#>    strain1 strain2              combination      mean       min       max n
#> 8 C57BL_6J   AKR_J C3H_HeH,DBA_1J,SPRET_EiJ 0.8068057 0.7467057 0.9926794 3
#> 7 C57BL_6J   AKR_J C3H_HeH,DBA_2J,SPRET_EiJ 0.8068057 0.7467057 0.9926794 3
#> 6 C57BL_6J   AKR_J C3H_HeJ,DBA_1J,SPRET_EiJ 0.8068057 0.7467057 0.9926794 3
```

Create plots

```
plots = vis_reduction_factors(df$genotypes, df$reduction, 2)
plots[[1]]
```

![](data:image/png;base64...)

```
plots[[2]]
```

![](data:image/png;base64...)

# 5 Output of Session Info

The output of `sessionInfo()` on the system
on which this document was compiled:

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
#> [1] MouseFM_1.20.0   BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0      gtable_0.3.6         xfun_0.53
#>  [4] bslib_0.9.0          ggplot2_4.0.0        httr2_1.2.1
#>  [7] rlist_0.4.6.2        Biobase_2.70.0       vctrs_0.6.5
#> [10] tools_4.5.1          generics_0.1.4       stats4_4.5.1
#> [13] curl_7.0.0           tibble_3.3.0         AnnotationDbi_1.72.0
#> [16] RSQLite_2.4.3        blob_1.2.4           pkgconfig_2.0.3
#> [19] data.table_1.17.8    RColorBrewer_1.1-3   dbplyr_2.5.1
#> [22] S7_0.2.0             S4Vectors_0.48.0     lifecycle_1.0.4
#> [25] farver_2.1.2         compiler_4.5.1       stringr_1.5.2
#> [28] Biostrings_2.78.0    progress_1.2.3       tinytex_0.57
#> [31] Seqinfo_1.0.0        htmltools_0.5.8.1    sass_0.4.10
#> [34] yaml_2.3.10          tidyr_1.3.1          pillar_1.11.1
#> [37] crayon_1.5.3         jquerylib_0.1.4      cachem_1.1.0
#> [40] magick_2.9.0         gtools_3.9.5         tidyselect_1.2.1
#> [43] digest_0.6.37        stringi_1.8.7        purrr_1.1.0
#> [46] reshape2_1.4.4       dplyr_1.1.4          bookdown_0.45
#> [49] biomaRt_2.66.0       fastmap_1.2.0        grid_4.5.1
#> [52] cli_3.6.5            magrittr_2.0.4       dichromat_2.0-0.1
#> [55] withr_3.0.2          scales_1.4.0         prettyunits_1.2.0
#> [58] filelock_1.0.3       rappdirs_0.3.3       bit64_4.6.0-1
#> [61] rmarkdown_2.30       XVector_0.50.0       httr_1.4.7
#> [64] bit_4.6.0            png_0.1-8            hms_1.1.4
#> [67] memoise_2.0.1        evaluate_1.0.5       knitr_1.50
#> [70] GenomicRanges_1.62.0 IRanges_2.44.0       BiocFileCache_3.0.0
#> [73] rlang_1.1.6          Rcpp_1.1.0           glue_1.8.0
#> [76] DBI_1.2.3            BiocManager_1.30.26  BiocGenerics_0.56.0
#> [79] jsonlite_2.0.0       plyr_1.8.9           R6_2.6.1
```