# Import GWAS summary statistics from Open GWAS

##### *Authors*: Alan Murphy, Brian Schilder and Nathan Skene

#### *Updated*: Jan-08-2026

# Contents

* [1 Authenticate Access IEU OpenGWAS API](#authenticate-access-ieu-opengwas-api)
* [2 Find GWAS datasets](#find-gwas-datasets)
* [3 Import full results](#import-full-results)
  + [3.1 Summarise results](#summarise-results)
* [4 Import full results (parallel)](#import-full-results-parallel)
* [5 Further functionality](#further-functionality)
* [6 Session Info](#session-info)

```
library(MungeSumstats)
```

MungeSumstats now offers high throughput query and import functionality to data
from the MRC IEU [Open GWAS Project](https://gwas.mrcieu.ac.uk/).

This is made possible by the use the
[IEU OpwnGWAS R package](https://github.com/MRCIEU/ieugwasr): `ieugwasr`.

Before you can use this functionality however, please complete the following steps:

# 1 Authenticate Access IEU OpenGWAS API

To authenticate, you need to generate a token from the OpenGWAS website. The
token behaves like a password, and it will be used to authorise the requests
you make to the OpenGWAS API. Here are the steps to generate the token and then
have `ieugwasr` automatically use it for your queries:

1. Login to <https://api.opengwas.io/profile/>
2. Generate a new token
3. Add `OPENGWAS_JWT=<token>` to your .Renviron file, thi can be edited in R by
   running `usethis::edit_r_environ()`
4. Restart your R session
5. To check that your token is being recognised, run
   `ieugwasr::get_opengwas_jwt()`. If it returns a long random string then you are
   authenticated.
6. To check that your token is working, run `ieugwasr::user()`. It will make a
   request to the API for your user information using your token. It should return
   a list with your user information. If it returns an error, then your token is
   not working.
7. Make sure you have submitted user information to increasse you API limit at
   <https://api.opengwas.io/profile/>.

# 2 Find GWAS datasets

We can search by terms and with other filters like sample size:

```
#### Search for datasets ####
metagwas <- MungeSumstats::find_sumstats(traits = c("parkinson","alzheimer"),
                                         min_sample_size = 1000)
head(metagwas,3)
ids <- (dplyr::arrange(metagwas, nsnp))$id
```

```
##          id               trait group_name year    author
## 1 ieu-a-298 Alzheimer's disease     public 2013   Lambert
## 2   ieu-b-2 Alzheimer's disease     public 2019 Kunkle BW
## 3 ieu-a-297 Alzheimer's disease     public 2013   Lambert
##                                                                                                                                                                                                                                                                                                                    consortium
## 1                                                                                                                                                                                                                                                                                                                        IGAP
## 2 Alzheimer Disease Genetics Consortium (ADGC), European Alzheimer's Disease Initiative (EADI), Cohorts for Heart and Aging Research in Genomic Epidemiology Consortium (CHARGE), Genetic and Environmental Risk in AD/Defining Genetic, Polygenic and Environmental Risk for Alzheimer's Disease Consortium (GERAD/PERADES),
## 3                                                                                                                                                                                                                                                                                                                        IGAP
##                 sex population     unit     nsnp sample_size       build
## 1 Males and Females   European log odds    11633       74046 HG19/GRCh37
## 2 Males and Females   European       NA 10528610       63926 HG19/GRCh37
## 3 Males and Females   European log odds  7055882       54162 HG19/GRCh37
##   category                subcategory ontology mr priority     pmid sd
## 1  Disease Psychiatric / neurological       NA  1        1 24162737 NA
## 2   Binary Psychiatric / neurological       NA  1        0 30820047 NA
## 3  Disease Psychiatric / neurological       NA  1        2 24162737 NA
##                                                                      note ncase
## 1 Exposure only; Effect allele frequencies are missing; forward(+) strand 25580
## 2                                                                      NA 21982
## 3                Effect allele frequencies are missing; forward(+) strand 17008
##   ncontrol     N
## 1    48466 74046
## 2    41944 63926
## 3    37154 54162
```

You can also search by ID:

```
### By ID and sample size
metagwas <- find_sumstats(
  ids = c("ieu-b-4760", "prot-a-1725", "prot-a-664"),
  min_sample_size = 5000
)
```

# 3 Import full results

You can supply `import_sumstats()` with a list of as many OpenGWAS IDs as you
want, but we’ll just give one to save time.

```
datasets <- MungeSumstats::import_sumstats(ids = "ieu-a-298",
                                           ref_genome = "GRCH37")
```

## 3.1 Summarise results

By default, `import_sumstats` results a named list where the names are the Open
GWAS dataset IDs and the items are the respective paths to the formatted summary
statistics.

```
print(datasets)
```

```
## $`ieu-a-298`
## [1] "/tmp/RtmprWSUtv/ieu-a-298.tsv.gz"
```

You can easily turn this into a data.frame as well.

```
results_df <- data.frame(id=names(datasets),
                         path=unlist(datasets))
print(results_df)
```

```
##                  id                             path
## ieu-a-298 ieu-a-298 /tmp/RtmprWSUtv/ieu-a-298.tsv.gz
```

# 4 Import full results (parallel)

*Optional*: Speed up with multi-threaded download via [axel](https://github.com/axel-download-accelerator/axel).

```
datasets <- MungeSumstats::import_sumstats(ids = ids,
                                           vcf_download = TRUE,
                                           download_method = "axel",
                                           nThread = max(2,future::availableCores()-2))
```

# 5 Further functionality

See the [Getting started vignette](https://neurogenomics.github.io/MungeSumstats/articles/MungeSumstats.html)
for more information on how to use MungeSumstats and its functionality.

# 6 Session Info

```
utils::sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] MungeSumstats_1.18.1 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1
##  [2] dplyr_1.1.4
##  [3] blob_1.2.4
##  [4] R.utils_2.13.0
##  [5] Biostrings_2.78.0
##  [6] bitops_1.0-9
##  [7] fastmap_1.2.0
##  [8] RCurl_1.98-1.17
##  [9] VariantAnnotation_1.56.0
## [10] GenomicAlignments_1.46.0
## [11] XML_3.99-0.20
## [12] digest_0.6.39
## [13] lifecycle_1.0.5
## [14] KEGGREST_1.50.0
## [15] RSQLite_2.4.5
## [16] magrittr_2.0.4
## [17] compiler_4.5.2
## [18] rlang_1.1.6
## [19] sass_0.4.10
## [20] tools_4.5.2
## [21] yaml_2.3.12
## [22] data.table_1.18.0
## [23] rtracklayer_1.70.1
## [24] knitr_1.51
## [25] S4Arrays_1.10.1
## [26] bit_4.6.0
## [27] curl_7.0.0
## [28] DelayedArray_0.36.0
## [29] ieugwasr_1.1.0
## [30] abind_1.4-8
## [31] BiocParallel_1.44.0
## [32] BiocGenerics_0.56.0
## [33] R.oo_1.27.1
## [34] grid_4.5.2
## [35] stats4_4.5.2
## [36] SummarizedExperiment_1.40.0
## [37] cli_3.6.5
## [38] rmarkdown_2.30
## [39] crayon_1.5.3
## [40] generics_0.1.4
## [41] otel_0.2.0
## [42] BSgenome.Hsapiens.1000genomes.hs37d5_0.99.1
## [43] httr_1.4.7
## [44] rjson_0.2.23
## [45] DBI_1.2.3
## [46] cachem_1.1.0
## [47] stringr_1.6.0
## [48] parallel_4.5.2
## [49] AnnotationDbi_1.72.0
## [50] BiocManager_1.30.27
## [51] XVector_0.50.0
## [52] restfulr_0.0.16
## [53] matrixStats_1.5.0
## [54] vctrs_0.6.5
## [55] Matrix_1.7-4
## [56] jsonlite_2.0.0
## [57] bookdown_0.46
## [58] IRanges_2.44.0
## [59] S4Vectors_0.48.0
## [60] bit64_4.6.0-1
## [61] GenomicFiles_1.46.0
## [62] GenomicFeatures_1.62.0
## [63] jquerylib_0.1.4
## [64] glue_1.8.0
## [65] codetools_0.2-20
## [66] stringi_1.8.7
## [67] GenomeInfoDb_1.46.2
## [68] BiocIO_1.20.0
## [69] GenomicRanges_1.62.1
## [70] UCSC.utils_1.6.1
## [71] tibble_3.3.0
## [72] pillar_1.11.1
## [73] SNPlocs.Hsapiens.dbSNP155.GRCh37_0.99.24
## [74] htmltools_0.5.9
## [75] Seqinfo_1.0.0
## [76] BSgenome_1.78.0
## [77] R6_2.6.1
## [78] evaluate_1.0.5
## [79] lattice_0.22-7
## [80] Biobase_2.70.0
## [81] R.methodsS3_1.8.2
## [82] png_0.1-8
## [83] Rsamtools_2.26.0
## [84] cigarillo_1.0.0
## [85] memoise_2.0.1
## [86] bslib_0.9.0
## [87] SparseArray_1.10.8
## [88] xfun_0.55
## [89] MatrixGenerics_1.22.0
## [90] pkgconfig_2.0.3
```