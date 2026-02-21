# ReUseData: Reusable and Reproducible Data Management - quick start

Qian Liu, Qiang Hu, Song Liu, Alan Hutson, Martin Morgan1

1Roswell Park Comprehensive Cancer Center

#### 2025-10-30

# 1 Introduction

ReUseData is an *R/Bioconductor* software tool to provide a systematic
and versatile approach for standardized and reproducible data
management. ReUseData facilitates transformation of shell or other ad
hoc scripts for data preprocessing into workflow-based data
recipes. Evaluation of data recipes generate curated data files in
their generic formats (e.g., VCF, bed). Both recipes and data are
cached using database infrastructure for easy data management and
reuse. Prebuilt data recipes are available through ReUseData portal
(“<https://rcwl.org/dataRecipes/>”) with full annotation and user
instructions. Pregenerated data are available through ReUseData cloud
bucket that is directly downloadable through “getCloudData()”.

This quick start shows the basic use of package functions in 2 major
categories for managing:

* Data recipes
* Reusable data

Details for each section can be found in the companion vignettes for
[data recipes](ReUseData_recipe.html) and [reusable data](ReUseData_data.html).

# 2 Package installation and loading

```
BiocManager::install(c("ReUseData", "Rcwl"))
```

```
library(ReUseData)
```

# 3 Data recipes

All pre-built data recipes are included in the package and can be
easily updated (`recipeUpdate`), searched (`recipeSearch`) and loaded
(`recipeLoad`). Details about data recipes can be found in the
vignette `ReUseData_recipe.html`.

## 3.1 Search and load a data recipe

```
recipeUpdate(cachePath = "ReUseDataRecipe", force = TRUE)
#> NOTE: existing caches will be removed and regenerated!
#> Updating recipes...
#> STAR_index.R added
#> bowtie2_index.R added
#> echo_out.R added
#> ensembl_liftover.R added
#> gcp_broad_gatk_hg19.R added
#> gcp_broad_gatk_hg38.R added
#> gcp_gatk_mutect2_b37.R added
#> gcp_gatk_mutect2_hg38.R added
#> gencode_annotation.R added
#> gencode_genome_grch38.R added
#> gencode_transcripts.R added
#> hisat2_index.R added
#> reference_genome.R added
#> salmon_index.R added
#> ucsc_database.R added
#>
#> recipeHub with 15 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseDataRecipe
#> # recipeSearch() to query specific recipes using multipe keywords
#> # recipeUpdate() to update the local recipe cache
#>
#>           name
#>   BFC16 | STAR_index
#>   BFC17 | bowtie2_index
#>   BFC18 | echo_out
#>   BFC19 | ensembl_liftover
#>   BFC20 | gcp_broad_gatk_hg19
#>   ...     ...
#>   BFC26 | gencode_transcripts
#>   BFC27 | hisat2_index
#>   BFC28 | reference_genome
#>   BFC29 | salmon_index
#>   BFC30 | ucsc_database
recipeSearch("echo")
#> recipeHub with 1 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseDataRecipe
#> # recipeSearch() to query specific recipes using multipe keywords
#> # recipeUpdate() to update the local recipe cache
#>
#>           name
#>   BFC18 | echo_out
echo_out <- recipeLoad("echo_out")
#> Note: you need to assign a name for the recipe: rcpName <- recipeLoad('xx')
#> Data recipe loaded!
#> Use inputs() to check required input parameters before evaluation.
#> Check here: https://rcwl.org/dataRecipes/echo_out.html
#> for user instructions (e.g., eligible input values, data source, etc.)
```

## 3.2 Evaluate a data recipe

We can install cwltool first to make sure a cwl-runner is available.

```
invisible(Rcwl::install_cwltool())
```

A data recipe can be evaluated by assigning values to the recipe
parameters. `getData` runs the recipe as a CWL scripts internally, and
generates the data of interest with annotation files for future reuse.

```
Rcwl::inputs(echo_out)
#> inputs:
#>   input (input)  (string):
#>   outfile (outfile)  (string):
echo_out$input <- "Hello World!"
echo_out$outfile <- "outfile"
outdir <- file.path(tempdir(), "SharedData")
res <- getData(echo_out,
               outdir = outdir,
               notes = c("echo", "hello", "world", "txt"))
#> }[1;30mINFO[0m Final process status is success
res$out
#> [1] "/tmp/RtmpIAiCac/SharedData/outfile.txt"
readLines(res$out)
#> [1] "Print the input: Hello World!"
```

## 3.3 Create your own data recipes

One can create a data recipe from scratch or by converting an existing
shell script for data processing, by specifying input parameters,
output globbing patterns using `recipeMake` function.

```
script <- system.file("extdata", "echo_out.sh", package = "ReUseData")
rcp <- recipeMake(shscript = script,
                  paramID = c("input", "outfile"),
                  paramType = c("string", "string"),
                  outputID = "echoout",
                  outputGlob = "*.txt")
Rcwl::inputs(rcp)
#> inputs:
#>   input (string):
#>   outfile (string):
Rcwl::outputs(rcp)
#> outputs:
#> echoout:
#>   type: File[]
#>   outputBinding:
#>     glob: '*.txt'
```

# 4 Reusable data

The data that are generated from evaluating data recipes are
automatically annotated and tracked with user-specified keywords and
time/date tags. It uses a similar cache system as for recipes for
users to easily update (`dataUpdate`), search (`dataSearch`) and use
(`toList`).

Pre-generated data files from existing data recipes are saved in
Google Cloud Bucket, that are ready to be queried
(`dataSearch(cloud=TRUE)`) and downloaded (`getCloudData`) to local
cache system with annotations.

## 4.1 Update data files that are generated using `ReUseData`

```
dh <- dataUpdate(dir = outdir)
dataSearch(c("echo", "hello"))
dataNames(dh)
dataParams(dh)
dataNotes(dh)
```

## 4.2 Export data into workflow-ready files

```
toList(dh, format="json", file = file.path(outdir, "data.json"))
```

## 4.3 Download pregenerated data from Google Cloud

```
dh <- dataUpdate(dir = outdir, cloud = TRUE)
getCloudData(dh[2], outdir = outdir)
```

# 5 SessionInfo

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#> [1] ReUseData_1.10.0    Rcwl_1.26.0         S4Vectors_0.48.0
#> [4] BiocGenerics_0.56.0 generics_0.1.4      yaml_2.3.10
#> [7] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1     dplyr_1.1.4          blob_1.2.4
#>  [4] filelock_1.0.3       R.utils_2.13.0       fastmap_1.2.0
#>  [7] BiocFileCache_3.0.0  promises_1.4.0       digest_0.6.37
#> [10] base64url_1.4        mime_0.13            lifecycle_1.0.4
#> [13] RSQLite_2.4.3        magrittr_2.0.4       compiler_4.5.1
#> [16] rlang_1.1.6          sass_0.4.10          progress_1.2.3
#> [19] tools_4.5.1          data.table_1.17.8    knitr_1.50
#> [22] prettyunits_1.2.0    brew_1.0-10          htmlwidgets_1.6.4
#> [25] bit_4.6.0            curl_7.0.0           reticulate_1.44.0
#> [28] RColorBrewer_1.1-3   batchtools_0.9.18    BiocParallel_1.44.0
#> [31] withr_3.0.2          purrr_1.1.0          R.oo_1.27.1
#> [34] grid_4.5.1           git2r_0.36.2         xtable_1.8-4
#> [37] debugme_1.2.0        cli_3.6.5            rmarkdown_2.30
#> [40] DiagrammeR_1.0.11    crayon_1.5.3         otel_0.2.0
#> [43] httr_1.4.7           visNetwork_2.1.4     DBI_1.2.3
#> [46] cachem_1.1.0         parallel_4.5.1       BiocManager_1.30.26
#> [49] basilisk_1.22.0      vctrs_0.6.5          Matrix_1.7-4
#> [52] jsonlite_2.0.0       dir.expiry_1.18.0    bookdown_0.45
#> [55] hms_1.1.4            bit64_4.6.0-1        jquerylib_0.1.4
#> [58] RcwlPipelines_1.26.0 glue_1.8.0           codetools_0.2-20
#> [61] stringi_1.8.7        later_1.4.4          tibble_3.3.0
#> [64] pillar_1.11.1        rappdirs_0.3.3       htmltools_0.5.8.1
#> [67] R6_2.6.1             dbplyr_2.5.1         httr2_1.2.1
#> [70] evaluate_1.0.5       shiny_1.11.1         lattice_0.22-7
#> [73] R.methodsS3_1.8.2    png_0.1-8            backports_1.5.0
#> [76] memoise_2.0.1        httpuv_1.6.16        bslib_0.9.0
#> [79] Rcpp_1.1.0           checkmate_2.3.3      xfun_0.53
#> [82] pkgconfig_2.0.3
```