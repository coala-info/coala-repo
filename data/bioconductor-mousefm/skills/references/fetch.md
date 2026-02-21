# Fetch homozygous genotypes of inbred mouse strains

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

Method `fetch` allows to download homozygous genotypes of 37 inbred mouse strains for a given genetic region.

# 2 Installation

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MouseFM")
```

# 3 Loading package

```
library(MouseFM)
#>
#>   ---------
#>   For example usage please run: vignette('MouseFM')
#>
#>   Support me: http://matthiasmunz.de/support_me
#>
#>   Citation appreciated:
#>   Munz M, Khodaygani M, Aherrahrou Z, Busch H, Wohlers I (2021) In silico candidate variant and gene identification using inbred mouse strains. PeerJ. doi:10.7717/peerj.11017
#>
#>   Github Repo: https://github.com/matmu/MouseFM
#>   MouseFM Backend: https://github.com/matmu/MouseFM-Backend
#>   ---------
```

# 4 Example function calls

Fetch genotypes for region chr1:5000000-6000000.

```
df = fetch("chr1", start=5000000, end=6000000)
#> Query chr1:5,000,000-6,000,000

df[1:10,]
#>    chr     pos        rsid ref alt most_severe_consequence
#> 1    1 5000016  rs47088541   A   T          intron_variant
#> 2    1 5000029  rs48827827   G   A          intron_variant
#> 3    1 5000057  rs48099867   C   T          intron_variant
#> 4    1 5000062 rs246021564   G   C          intron_variant
#> 5    1 5000067 rs265132353   C   T          intron_variant
#> 6    1 5000068  rs51419610   A   G          intron_variant
#> 7    1 5000101 rs253320650   C   G          intron_variant
#> 8    1 5000156        <NA>   C   T          intron_variant
#> 9    1 5000157 rs216747169   G   A          intron_variant
#> 10   1 5000240        <NA>   T   G          intron_variant
#>                                                           consequences C57BL_6J
#> 1  non_coding_transcript_variant,intron_variant,NMD_transcript_variant        0
#> 2  non_coding_transcript_variant,intron_variant,NMD_transcript_variant        0
#> 3  non_coding_transcript_variant,intron_variant,NMD_transcript_variant        0
#> 4  non_coding_transcript_variant,intron_variant,NMD_transcript_variant        0
#> 5  non_coding_transcript_variant,intron_variant,NMD_transcript_variant        0
#> 6  non_coding_transcript_variant,intron_variant,NMD_transcript_variant        0
#> 7  non_coding_transcript_variant,intron_variant,NMD_transcript_variant        0
#> 8  non_coding_transcript_variant,intron_variant,NMD_transcript_variant        0
#> 9  non_coding_transcript_variant,intron_variant,NMD_transcript_variant        0
#> 10 non_coding_transcript_variant,intron_variant,NMD_transcript_variant        0
#>    129P2_OlaHsd 129S1_SvImJ 129S5SvEvBrd AKR_J A_J BALB_cJ BTBR BUB_BnJ C3H_HeH
#> 1             0           0            0     0   0       0    0       0       1
#> 2             0           0            0     0   0       0    0       0       1
#> 3             0           0            0     0   0       0    0       0       1
#> 4             0           0            0     0   0       0    0       0       1
#> 5             0           0            0     0   0       0    0       0       1
#> 6             0           0            0     0   0       0    0       0       1
#> 7             0           0            0     0   0       0    0       0       1
#> 8             0           0            0     0   0       0    0       0       0
#> 9             0           0            0     0   0       0    0       0       1
#> 10            0           0            0     0   0       0    0       0       0
#>    C3H_HeJ C57BL_10J C57BL_6NJ C57BR_cdJ C57L_J C58_J CAST_EiJ CBA_J DBA_1J
#> 1        1         0         0         0      0     0        1     1      1
#> 2        1         0         0         0      0     0        0     1      1
#> 3        1         0         0         0      0     0        0     1      1
#> 4        1         0         0         0      0     0        0     1      1
#> 5        1         0         0         0      0     0        0     1      1
#> 6        1         0         0         0      0     0        0     1      1
#> 7        1         0         0         0      0     0        0     1      1
#> 8        0         0         0         0      0     0        0     0      0
#> 9        1         0         0         0      0     0        0     1      0
#> 10       0         0         0         0      0     0        0     0      0
#>    DBA_2J FVB_NJ I_LnJ KK_HiJ LEWES_EiJ LP_J MOLF_EiJ NOD_ShiLtJ NZB_B1NJ
#> 1       1      0     0      0         1    0        0          0        1
#> 2       1      0     0      0         1    0        0          0        0
#> 3       1      0     0      0         1    0        0          0        0
#> 4       1      0     0      0         1    0        0          0        0
#> 5       1      0     0      0         1    0        0          0        0
#> 6       1      0     0      0         1    0        0          0        0
#> 7       1      0     0      0         1    0        0          0        0
#> 8       0      0     0      0         0    0        0          0        1
#> 9       0      0     0      0         1    0        0          0        0
#> 10      0      0     0      0         0    0        0          0        1
#>    NZO_HlLtJ NZW_LacJ PWK_PhJ RF_J SEA_GnJ SPRET_EiJ ST_bJ WSB_EiJ ZALENDE_EiJ
#> 1          0        0       1    1       0         1     0       1           1
#> 2          0        0       1    1       0         1     0       1           1
#> 3          0        0       1    1       0         1     0       1           1
#> 4          0        0       1    1       0         1     0       1           1
#> 5          0        0       1    1       0         0     0       1           1
#> 6          0        0       1    1       0         1     0       1           1
#> 7          0        0       1    1       0         1     0       1           1
#> 8          0        0       0    0       0         0     0       0           0
#> 9          0        0       0    1       0         0     0       1           1
#> 10         0        0       0    0       0         0     0       0           0
```

View meta information

```
comment(df)
#> [1] "#Alleles of strain C57BL_6J represent the reference (ref) alleles"
#> [2] "#reference_version=GRCm38"
```

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
#> [28] Biostrings_2.78.0    progress_1.2.3       Seqinfo_1.0.0
#> [31] htmltools_0.5.8.1    sass_0.4.10          yaml_2.3.10
#> [34] tidyr_1.3.1          pillar_1.11.1        crayon_1.5.3
#> [37] jquerylib_0.1.4      cachem_1.1.0         gtools_3.9.5
#> [40] tidyselect_1.2.1     digest_0.6.37        stringi_1.8.7
#> [43] purrr_1.1.0          reshape2_1.4.4       dplyr_1.1.4
#> [46] bookdown_0.45        biomaRt_2.66.0       fastmap_1.2.0
#> [49] grid_4.5.1           cli_3.6.5            magrittr_2.0.4
#> [52] dichromat_2.0-0.1    scales_1.4.0         prettyunits_1.2.0
#> [55] filelock_1.0.3       rappdirs_0.3.3       bit64_4.6.0-1
#> [58] rmarkdown_2.30       XVector_0.50.0       httr_1.4.7
#> [61] bit_4.6.0            png_0.1-8            hms_1.1.4
#> [64] memoise_2.0.1        evaluate_1.0.5       knitr_1.50
#> [67] GenomicRanges_1.62.0 IRanges_2.44.0       BiocFileCache_3.0.0
#> [70] rlang_1.1.6          Rcpp_1.1.0           glue_1.8.0
#> [73] DBI_1.2.3            BiocManager_1.30.26  BiocGenerics_0.56.0
#> [76] jsonlite_2.0.0       plyr_1.8.9           R6_2.6.1
```