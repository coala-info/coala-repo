# HiContactsData

Jacques Serizay

#### 2025-11-04

# Contents

* [0.1 Introduction to HiContactsData](#introduction-to-hicontactsdata)
* [0.2 HiContacts and HiContactsData](#hicontacts-and-hicontactsdata)
* [0.3 Session info](#session-info)

## 0.1 Introduction to HiContactsData

HiContactsData is a companion data package giving programmatic access to
several processed Hi-C files for demonstration, such as cool, mcool and
pairs files. It is meant to be used with `HiContacts`.

```
library(HiContactsData)
```

The only function provided by HiContactsData package is `HiContactsData()`.
Several files are available using this function, namely:

* S288C fastq files (R1 & R2) (`sample`: `yeast_wt`, `format` = `fastq_R{12}`)
* S288C HiCool processing log (`sample`: `yeast_wt`, `format` = `HiCool_log`)
* S288C.cool (`sample`: `yeast_wt`, `format` = `cool`)
* S288C.mcool (`sample`: `yeast_wt`, `format` = `mcool`)
* S288C\_G1.mcool (`sample`: `yeast_g1`, `format` = `mcool`)
* S288C\_G2M.mcool (`sample`: `yeast_g1`, `format` = `mcool`)
* S288C\_G1.pairs (`sample`: `yeast_g2m`, `format` = `pairs`)
* S288C\_G2M.pairs (`sample`: `yeast_g2m`, `format` = `pairs`)
* S288C.hic (`sample`: `yeast_wt`, `format` = `hic`)
* S288C.hicpro.matrix (`sample`: `yeast_wt`, `format` = `hicpro_matrix`)
* S288C.hicpro.bed (`sample`: `yeast_wt`, `format` = `hicpro_bed`)
* S288C.pairs.gz for chrII only (`sample`: `yeast_wt`, `format` = `pairs`)
* S288C\_Eco1-AID.mcool (`sample`: `yeast_Eco1`, `format` = `mcool`)
* S288C\_Eco1-AID.pairs.gz for chrII only (`sample`: `yeast_Eco1`, `format` = `pairs`)
* mESCs.mcool (`sample`: `mESCs`, `format` = `mcool`)
* mESCs.pairs.gz for chr13 only (`sample`: `mESCs`, `format` = `pairs`)
* microC\_HFFc6\_chr17.mcool (`sample`: `microC`, `format` = `mcool`)

Yeast data comes from [Bastie, Chapard et al., Nature Structural & Molecular Biology 2022](https://doi.org/10.1038/s41594-022-00780-0)
and mouse ESC data comes from [Bonev et al., Cell 2017](https://doi.org/10.1016/j.cell.2017.09.043).
Human HcFF6 micro-C data comes from [Krietenstein et al., Mol. Cell 2020](https://doi.org/10.1016/j.molcel.2020.03.003).

To download one of these files, one can specify a `sample` and a file `format`:

```
cool_file <- HiContactsData()
#> Available files:
#>        sample        format genome    condition
#> 1    yeast_wt      fastq_R1  S288C    wild-type
#> 2    yeast_wt      fastq_R2  S288C    wild-type
#> 3    yeast_wt    HiCool_log  S288C    wild-type
#> 4    yeast_wt      pairs.gz  S288C    wild-type
#> 5    yeast_wt          cool  S288C    wild-type
#> 6    yeast_wt         mcool  S288C    wild-type
#> 7    yeast_g1         mcool  S288C    wild-type
#> 8    yeast_g1         pairs  S288C    wild-type
#> 9   yeast_g2m         mcool  S288C    wild-type
#> 10  yeast_g2m         pairs  S288C    wild-type
#> 11   yeast_wt           hic  S288C    wild-type
#> 12   yeast_wt hicpro_matrix  S288C    wild-type
#> 13   yeast_wt    hicpro_bed  S288C    wild-type
#> 14   yeast_wt  hicpro_pairs  S288C    wild-type
#> 15 yeast_eco1         mcool  S288C Eco1-AID+IAA
#> 16 yeast_eco1      pairs.gz  S288C Eco1-AID+IAA
#> 17      mESCs         mcool   mm10        mESCs
#> 18      mESCs      pairs.gz   mm10        mESCs
#> 19     microC         mcool GRCh38        HFFc6
#>                                            notes   EHID
#> 1                                     fastq (R1) EH7783
#> 2                                     fastq (R2) EH7784
#> 3                                HiCool log file EH7785
#> 4             only pairs from chrII are provided EH7703
#> 5                 .cool file @ resolution of 1kb EH7701
#> 6                          multi-res .mcool file EH7702
#> 7                          multi-res .mcool file EH8562
#> 8                    filtered pairs are provided EH8564
#> 9                          multi-res .mcool file EH8563
#> 10                   filtered pairs are provided EH8565
#> 11                           multi-res .hic file EH7786
#> 12                     HiC-Pro matrix file @ 1kb EH7787
#> 13                        HiC-Pro bed file @ 1kb EH7788
#> 14                   HiC-Pro .allValidPairs file EH7789
#> 15                         multi-res .mcool file EH7704
#> 16            only pairs from chrII are provided EH7705
#> 17                         multi-res .mcool file EH7706
#> 18            only pairs from chr13 are provided EH7707
#> 19 multi-res .mcool file, only chr17 is provided EH8535
#>
cool_file <- HiContactsData(sample = 'yeast_wt', format = 'cool')
#> see ?HiContactsData and browseVignettes('HiContactsData') for documentation
#> loading from cache
cool_file
#>                                                      EH7701
#> "/home/biocbuild/.cache/R/ExperimentHub/a0be55a53b247_7751"
```

## 0.2 HiContacts and HiContactsData

`HiCExperiment` package can be used to import data provided by `HiContactsData`.
Refer to `HiCExperiment` package documentation for further information.

## 0.3 Session info

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
#> [1] HiContactsData_1.12.0 ExperimentHub_3.0.0   AnnotationHub_4.0.0
#> [4] BiocFileCache_3.0.0   dbplyr_2.5.1          BiocGenerics_0.56.0
#> [7] generics_0.1.4        BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] rappdirs_0.3.3       sass_0.4.10          BiocVersion_3.22.0
#>  [4] RSQLite_2.4.3        digest_0.6.37        magrittr_2.0.4
#>  [7] evaluate_1.0.5       bookdown_0.45        fastmap_1.2.0
#> [10] blob_1.2.4           jsonlite_2.0.0       AnnotationDbi_1.72.0
#> [13] DBI_1.2.3            BiocManager_1.30.26  httr_1.4.7
#> [16] purrr_1.1.0          Biostrings_2.78.0    httr2_1.2.1
#> [19] jquerylib_0.1.4      cli_3.6.5            crayon_1.5.3
#> [22] rlang_1.1.6          XVector_0.50.0       Biobase_2.70.0
#> [25] bit64_4.6.0-1        withr_3.0.2          cachem_1.1.0
#> [28] yaml_2.3.10          tools_4.5.1          memoise_2.0.1
#> [31] dplyr_1.1.4          filelock_1.0.3       curl_7.0.0
#> [34] vctrs_0.6.5          R6_2.6.1             png_0.1-8
#> [37] stats4_4.5.1         lifecycle_1.0.4      Seqinfo_1.0.0
#> [40] KEGGREST_1.50.0      S4Vectors_0.48.0     IRanges_2.44.0
#> [43] bit_4.6.0            pkgconfig_2.0.3      pillar_1.11.1
#> [46] bslib_0.9.0          glue_1.8.0           xfun_0.54
#> [49] tibble_3.3.0         tidyselect_1.2.1     knitr_1.50
#> [52] htmltools_0.5.8.1    rmarkdown_2.30       compiler_4.5.1
```