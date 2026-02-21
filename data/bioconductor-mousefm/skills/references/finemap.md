# Finemapping of genetic regions in inbred mice

Matthias Munz

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Loading package](#loading-package)
* [4 Example function calls](#example-function-calls)
* [5 Output of Session Info](#output-of-session-info)

# 1 Introduction

This **R** package provides methods for **genetic finemapping** in **inbred mice**
by taking advantage of their **very high homozygosity rate** (>95%).

For one ore more chromosomal regions (**GRCm38**), method `finemap` extracts homozygous SNVs for which the allele differs between two sets of strains (e.g. case vs controls) and outputs respective causal SNV/gene candidates.

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

Call finemap to finemap a specific region

```
res = finemap(chr="chr7",
              strain1=c("C57BL_6J","C57L_J","CBA_J","NZB_B1NJ"),
              strain2=c("C3H_HEJ","MOLF_EiJ","NZW_LacJ","WSB_EiJ","SPRET_EiJ"),
              impact=c("HIGH", "MODERATE", "LOW"))
#> Query chr7

res[1:10,]
#>    chr      pos        rsid ref alt
#> 1    7 45666192  rs51324364   A   G
#> 2    7 45853238  rs47469186   T   C
#> 3    7 45858570  rs47348864   A   C
#> 4    7 45977282  rs32753716   A   G
#> 5    7 45996764  rs32757904   T   C
#> 6    7 45996772  rs51886013   A   G
#> 7    7 45998716  rs32753986   A   G
#> 8    7 46029114  rs46389823   A   G
#> 9    7 46068710  rs32761224   A   C
#> 10   7 46081400 rs108318096   T   C
#>                                                                                             consequences
#> 1  non_coding_transcript_exon_variant,non_coding_transcript_variant,intron_variant,splice_region_variant
#> 2                                                                                     synonymous_variant
#> 3                                                                   intron_variant,splice_region_variant
#> 4    upstream_gene_variant,non_coding_transcript_exon_variant,downstream_gene_variant,synonymous_variant
#> 5                                                    non_coding_transcript_exon_variant,missense_variant
#> 6                                                  non_coding_transcript_exon_variant,synonymous_variant
#> 7                                                  non_coding_transcript_exon_variant,synonymous_variant
#> 8                                                               upstream_gene_variant,synonymous_variant
#> 9                                                                                       missense_variant
#> 10                                                              upstream_gene_variant,synonymous_variant
#>    C57BL_6J C3H_HeJ C57L_J CBA_J MOLF_EiJ NZB_B1NJ NZW_LacJ SPRET_EiJ WSB_EiJ
#> 1         0       1      0     0        1        0        1         1       1
#> 2         0       1      0     0        1        0        1         1       1
#> 3         0       1      0     0        1        0        1         1       1
#> 4         0       1      0     0        1        0        1         1       1
#> 5         0       1      0     0        1        0        1         1       1
#> 6         0       1      0     0        1        0        1         1       1
#> 7         0       1      0     0        1        0        1         1       1
#> 8         0       1      0     0        1        0        1         1       1
#> 9         0       1      0     0        1        0        1         1       1
#> 10        0       1      0     0        1        0        1         1       1
```

View meta information

```
comment(res)
#> [1] "#Alleles of strain C57BL_6J represent the reference (ref) alleles"
#> [2] "#reference_version=GRCm38"
```

Annotate with consequences (Not recommended for large queries!)

```
cons = annotate_consequences(res, "mouse")
```

Annotate with genes

```
genes = annotate_mouse_genes(res, flanking = 50000)
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