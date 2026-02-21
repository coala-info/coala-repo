# HubPub: Help with publication of Hub packages

Kayla Interdonato1 and Martin Morgan1

1Roswell Park Comprehensive Cancer Center, Buffalo, NY

#### 2025-10-30

#### Package

HubPub 1.18.0

# 1 Introduction

`HubPub` provides users with functionality to help with the *Bioconductor* Hub
structures. The package provides the ability to create a skeleton of a Hub
style package that the user can then populate with the necessary information.
There are also functions to help add resources to the Hub pacakge metadata
files as well as publish data to the *Bioconductor* S3 bucket.

# 2 Installation

Install the most recent version from Bioconductor:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("HubPub")
```

Then load `HubPub`:

```
library(HubPub)
```

# 3 HubPub

## 3.1 Creating a Hub styled package

The `create_pkg()` function creates the skeleton of a package that follows the
guidelines for a *Bioconductor* Hub type package. More information about what
are the requirements and content for a Hub style package the developer can look
at the “Creating A Hub Package” vignette from this package.

`create_pkg()` requires a path to where the packages is to be created and the type
of package that should be created (“AnnotationHub” or “ExperimentHub”). There is
also a variable `use_git` that indicates if the package should be set up with
git (default is `TRUE`).

NOTE: This function is intended for a developer that has not created the package
yet. If the package has already been created, then this function will not
benefit the developer. There are a couple other functions in this package that
deal with resources that might be helpful, more on these later in the vignette.

```
fl <- tempdir()
create_pkg(file.path(fl, "examplePkg"), "ExperimentHub")
#> ✔ Creating '/tmp/Rtmpvz34km/examplePkg/'.
#> ✔ Setting active project to "/tmp/Rtmpvz34km/examplePkg".
#> ✔ Creating 'R/'.
#> ✔ Writing 'DESCRIPTION'.
#> Package: examplePkg
#> Title: What the Package Does (One Line, Title Case)
#> Version: 0.99.0
#> Date: 2025-10-30
#> Authors@R (parsed):
#>     * First Last <first.last@example.com> [aut, cre]
#> Description: What the package does (one paragraph).
#> License: Artistic-2.0
#> BugReports: https://support.bioconductor.org/t/examplePkg
#> Imports:
#>     ExperimentHub
#> Suggests:
#>     ExperimentHubData
#> Encoding: UTF-8
#> Roxygen: list(markdown = TRUE)
#> RoxygenNote: 7.3.3
#> biocViews: ExperimentHub
#> ✔ Writing 'NAMESPACE'.
#> ✔ Setting active project to "<no active project>".
#> ✔ Setting active project to "/tmp/Rtmpvz34km/examplePkg".
#> ✔ Initialising Git repo.
#> ✔ Adding ".Rproj.user", ".Rhistory", ".RData", ".httr-oauth", ".DS_Store", and
#>   ".quarto" to '.gitignore'.
#> ✔ Writing 'R/examplePkg-package.R'.
#> ✔ Writing 'NEWS.md'.
#> ✔ Creating 'man/'.
#> ✔ Creating 'inst/scripts/'.
#> ✔ Writing 'inst/scripts/make-data.R'.
#> ✔ Writing 'inst/scripts/make-metadata.R'.
#> ✔ Writing 'R/zzz.R'.
#> ✔ Creating 'inst/extdata/'.
#> ✔ Adding testthat to 'Suggests' field in DESCRIPTION.
#> ✔ Adding "3" to 'Config/testthat/edition'.
#> ✔ Creating 'tests/testthat/'.
#> ✔ Writing 'tests/testthat.R'.
#> ☐ Call `usethis::use_test()` to initialize a basic test file and open it for
#>   editing.
#> ✔ Writing 'tests/testthat/test_metadata.R'.
#> [1] "/tmp/Rtmpvz34km/examplePkg"
```

Once the package is created the developer can go through and make any changes to
the package. For example, the DESCRIPTON file contains very basic
requirements but the developer should go back and fill in the ‘Title:’ and
‘Description:’ fields.

## 3.2 Adding a resource to the metadata file

Another useful function in `HubPub` is `add_resource()`. This function can be
useful for developers who are creating a new Hub related package or for
developers who want to add a new resource to an existing Hub package. The
purpose of this function is to add a hub resource to the package metadata.csv
file. The function requires the name of the package (or the path to the newly
created package) and a named list with the data to be added to the resource. To
get the elements and content for this list look at `?hub_metadata`. There is
also information in the “Creating A Hub Package” vignette from this package.

```
metadata <- hub_metadata(
    Title = "ENCODE",
    Description = "a test entry",
    BiocVersion = "4.1",
    Genome = NA_character_,
    SourceType = "JSON",
    SourceUrl = "http://www.encodeproject.org",
    SourceVersion = "x.y.z",
    Species = NA_character_,
    TaxonomyId = as.integer(9606),
    Coordinate_1_based = NA,
    DataProvider = "ENCODE Project",
    Maintainer = "tst person <tst@email.com>",
    RDataClass = "Rda",
    DispatchClass = "Rda",
    Location_Prefix = "s3://experimenthub/",
    RDataPath = "ENCODExplorerData/encode_df_lite.rda",
    Tags = "ENCODE:Homo sapiens"
)

add_resource(file.path(fl, "examplePkg"), metadata)
#> Warning: replacing previous import 'utils::findMatches' by
#> 'S4Vectors::findMatches' when loading 'ExperimentHubData'
#> No methods found in package 'rtracklayer' for request: 'trackName<-' when loading 'AnnotationHubData'
#> [1] "/tmp/Rtmpvz34km/examplePkg/inst/extdata/metadata.csv"
```

Then if you want to see what the metadata file looks like you can read in the
csv file like the following.

```
resource <- file.path(fl, "examplePkg", "inst", "extdata", "metadata.csv")
tst <- read.csv(resource)
tst
#>    Title  Description BiocVersion Genome SourceType
#> 1 ENCODE a test entry         4.1     NA       JSON
#>                      SourceUrl SourceVersion Species TaxonomyId
#> 1 http://www.encodeproject.org         x.y.z      NA       9606
#>   Coordinate_1_based   DataProvider                 Maintainer RDataClass
#> 1                 NA ENCODE Project tst person <tst@email.com>        Rda
#>   DispatchClass     Location_Prefix                            RDataPath
#> 1           Rda s3://experimenthub/ ENCODExplorerData/encode_df_lite.rda
#>                  Tags
#> 1 ENCODE:Homo sapiens
```

## 3.3 Publishing the resource to AWS S3

The final function in `HubPub` helps the developer with publishing data resources
to an Bioconductor AWS S3. The function utilizes functions for the `aws.s3`
package to place files or directories on S3. The developer should have already
contacted the Bioconductor hubs maintainers to get the necessary credentials to
access the bucket. Once the credentials are received the developer should
declare them in the system environment before running this function. The
function requires a path to the file or name of the directory to be added to the
bucket and a name for how the object should be named on the bucket. If adding a
directory be sure there are no nested directories and only files.

The below code chunk demonstrates the use of the function using a dummy dataset.
It will only work if the necessary global environments have been declared with
the hub credentials.

```
## For publishing directories with multiple files
fl <- tempdir()
utils::write.csv(mtcars, file = file.path(fl, "mtcars1.csv"))
utils::write.csv(mtcars, file = file.path(fl, "mtcars2.csv"))
publish_resource(fl, "test_dir")
#> Warning in publish_resource(fl, "test_dir"): Not all system environment
#> variables are set, do so and rerun function.
#> copy '/tmp/Rtmpvz34km/BiocStyle' to 's3://annotation-contributor/test_dir/BiocStyle'
#> copy '/tmp/Rtmpvz34km/examplePkg' to 's3://annotation-contributor/test_dir/examplePkg'
#> copy '/tmp/Rtmpvz34km/filee169f2420af53' to 's3://annotation-contributor/test_dir/filee169f2420af53'
#> copy '/tmp/Rtmpvz34km/mtcars1.csv' to 's3://annotation-contributor/test_dir/mtcars1.csv'
#> copy '/tmp/Rtmpvz34km/mtcars2.csv' to 's3://annotation-contributor/test_dir/mtcars2.csv'
#> copy '/tmp/Rtmpvz34km/repos_https%3A%2F%2Fbioconductor.org%2Fpackages%2F3.22%2Fbioc%2Fsrc%2Fcontrib.rds' to 's3://annotation-contributor/test_dir/repos_https%3A%2F%2Fbioconductor.org%2Fpackages%2F3.22%2Fbioc%2Fsrc%2Fcontrib.rds'
#> copy '/tmp/Rtmpvz34km/repos_https%3A%2F%2Fbioconductor.org%2Fpackages%2F3.22%2Fbooks%2Fsrc%2Fcontrib.rds' to 's3://annotation-contributor/test_dir/repos_https%3A%2F%2Fbioconductor.org%2Fpackages%2F3.22%2Fbooks%2Fsrc%2Fcontrib.rds'
#> copy '/tmp/Rtmpvz34km/repos_https%3A%2F%2Fbioconductor.org%2Fpackages%2F3.22%2Fdata%2Fannotation%2Fsrc%2Fcontrib.rds' to 's3://annotation-contributor/test_dir/repos_https%3A%2F%2Fbioconductor.org%2Fpackages%2F3.22%2Fdata%2Fannotation%2Fsrc%2Fcontrib.rds'
#> copy '/tmp/Rtmpvz34km/repos_https%3A%2F%2Fbioconductor.org%2Fpackages%2F3.22%2Fdata%2Fexperiment%2Fsrc%2Fcontrib.rds' to 's3://annotation-contributor/test_dir/repos_https%3A%2F%2Fbioconductor.org%2Fpackages%2F3.22%2Fdata%2Fexperiment%2Fsrc%2Fcontrib.rds'
#> copy '/tmp/Rtmpvz34km/repos_https%3A%2F%2Fbioconductor.org%2Fpackages%2F3.22%2Fworkflows%2Fsrc%2Fcontrib.rds' to 's3://annotation-contributor/test_dir/repos_https%3A%2F%2Fbioconductor.org%2Fpackages%2F3.22%2Fworkflows%2Fsrc%2Fcontrib.rds'
#> copy '/tmp/Rtmpvz34km/repos_https%3A%2F%2Fcloud.r-project.org%2Fsrc%2Fcontrib.rds' to 's3://annotation-contributor/test_dir/repos_https%3A%2F%2Fcloud.r-project.org%2Fsrc%2Fcontrib.rds'
#> $`/tmp/Rtmpvz34km/BiocStyle`
#> NULL
#>
#> $`/tmp/Rtmpvz34km/examplePkg`
#> NULL
#>
#> $`/tmp/Rtmpvz34km/filee169f2420af53`
#> NULL
#>
#> $`/tmp/Rtmpvz34km/mtcars1.csv`
#> NULL
#>
#> $`/tmp/Rtmpvz34km/mtcars2.csv`
#> NULL
#>
#> $`/tmp/Rtmpvz34km/repos_https%3A%2F%2Fbioconductor.org%2Fpackages%2F3.22%2Fbioc%2Fsrc%2Fcontrib.rds`
#> NULL
#>
#> $`/tmp/Rtmpvz34km/repos_https%3A%2F%2Fbioconductor.org%2Fpackages%2F3.22%2Fbooks%2Fsrc%2Fcontrib.rds`
#> NULL
#>
#> $`/tmp/Rtmpvz34km/repos_https%3A%2F%2Fbioconductor.org%2Fpackages%2F3.22%2Fdata%2Fannotation%2Fsrc%2Fcontrib.rds`
#> NULL
#>
#> $`/tmp/Rtmpvz34km/repos_https%3A%2F%2Fbioconductor.org%2Fpackages%2F3.22%2Fdata%2Fexperiment%2Fsrc%2Fcontrib.rds`
#> NULL
#>
#> $`/tmp/Rtmpvz34km/repos_https%3A%2F%2Fbioconductor.org%2Fpackages%2F3.22%2Fworkflows%2Fsrc%2Fcontrib.rds`
#> NULL
#>
#> $`/tmp/Rtmpvz34km/repos_https%3A%2F%2Fcloud.r-project.org%2Fsrc%2Fcontrib.rds`
#> NULL

## For publishing a single file
utils::write.csv(mtcars, file = file.path(fl, "mtcars3.csv"))
publish_resource(file.path(fl, "mtcars3.csv"), "test_dir")
#> Warning in publish_resource(file.path(fl, "mtcars3.csv"), "test_dir"): Not all
#> system environment variables are set, do so and rerun function.
#> copy '/tmp/Rtmpvz34km/mtcars3.csv' to 's3://annotation-contributor/test_dir/mtcars3.csv'
#> $`/tmp/Rtmpvz34km/mtcars3.csv`
#> NULL
```

# 4 Session Information

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
#> [1] futile.logger_1.4.3 HubPub_1.18.0       BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] sys_3.4.3                   rstudioapi_0.17.1
#>   [3] jsonlite_2.0.0              magrittr_2.0.4
#>   [5] GenomicFeatures_1.62.0      rmarkdown_2.30
#>   [7] fs_1.6.6                    BiocIO_1.20.0
#>   [9] vctrs_0.6.5                 memoise_2.0.1
#>  [11] Rsamtools_2.26.0            RCurl_1.98-1.17
#>  [13] askpass_1.2.1               base64enc_0.1-3
#>  [15] htmltools_0.5.8.1           S4Arrays_1.10.0
#>  [17] BiocBaseUtils_1.12.0        usethis_3.2.1
#>  [19] AnnotationHub_4.0.0         lambda.r_1.2.4
#>  [21] curl_7.0.0                  SparseArray_1.10.0
#>  [23] sass_0.4.10                 bslib_0.9.0
#>  [25] desc_1.4.3                  testthat_3.2.3
#>  [27] httr2_1.2.1                 futile.options_1.0.1
#>  [29] cachem_1.1.0                available_1.1.0
#>  [31] GenomicAlignments_1.46.0    whisker_0.4.1
#>  [33] lifecycle_1.0.4             pkgconfig_2.0.3
#>  [35] Matrix_1.7-4                R6_2.6.1
#>  [37] fastmap_1.2.0               GenomeInfoDbData_1.2.15
#>  [39] BiocCheck_1.46.0            MatrixGenerics_1.22.0
#>  [41] digest_0.6.37               AnnotationDbi_1.72.0
#>  [43] S4Vectors_0.48.0            OrganismDbi_1.52.0
#>  [45] rprojroot_2.1.1             ExperimentHub_3.0.0
#>  [47] aws.signature_0.6.0         GenomicRanges_1.62.0
#>  [49] RSQLite_2.4.3               filelock_1.0.3
#>  [51] httr_1.4.7                  abind_1.4-8
#>  [53] compiler_4.5.1              bit64_4.6.0-1
#>  [55] withr_3.0.2                 biocViews_1.78.0
#>  [57] BiocParallel_1.44.0         DBI_1.2.3
#>  [59] R.utils_2.13.0              openssl_2.3.4
#>  [61] rappdirs_0.3.3              DelayedArray_0.36.0
#>  [63] rjson_0.2.23                tools_4.5.1
#>  [65] R.oo_1.27.1                 glue_1.8.0
#>  [67] restfulr_0.0.16             R.cache_0.17.0
#>  [69] grid_4.5.1                  stringdist_0.9.15
#>  [71] generics_0.1.4              R.methodsS3_1.8.2
#>  [73] xml2_1.4.1                  XVector_0.50.0
#>  [75] BiocGenerics_0.56.0         BiocVersion_3.22.0
#>  [77] pillar_1.11.1               stringr_1.5.2
#>  [79] dplyr_1.1.4                 BiocFileCache_3.0.0
#>  [81] lattice_0.22-7              AnnotationHubData_1.40.0
#>  [83] rtracklayer_1.70.0          bit_4.6.0
#>  [85] tidyselect_1.2.1            RBGL_1.86.0
#>  [87] Biostrings_2.78.0           knitr_1.50
#>  [89] biocthis_1.20.0             bookdown_0.45
#>  [91] IRanges_2.44.0              Seqinfo_1.0.0
#>  [93] SummarizedExperiment_1.40.0 stats4_4.5.1
#>  [95] xfun_0.53                   Biobase_2.70.0
#>  [97] credentials_2.0.3           brio_1.1.5
#>  [99] matrixStats_1.5.0           stringi_1.8.7
#> [101] UCSC.utils_1.6.0            yaml_2.3.10
#> [103] evaluate_1.0.5              codetools_0.2-20
#> [105] cigarillo_1.0.0             tibble_3.3.0
#> [107] BiocManager_1.30.26         graph_1.88.0
#> [109] cli_3.6.5                   jquerylib_0.1.4
#> [111] styler_1.11.0               roxygen2_7.3.3
#> [113] GenomeInfoDb_1.46.0         gert_2.1.5
#> [115] dbplyr_2.5.1                png_0.1-8
#> [117] XML_3.99-0.19               RUnit_0.4.33.1
#> [119] parallel_4.5.1              blob_1.2.4
#> [121] aws.s3_0.3.22               AnnotationForge_1.52.0
#> [123] bitops_1.0-9                ExperimentHubData_1.36.0
#> [125] purrr_1.1.0                 crayon_1.5.3
#> [127] rlang_1.1.6                 KEGGREST_1.50.0
#> [129] formatR_1.14
```