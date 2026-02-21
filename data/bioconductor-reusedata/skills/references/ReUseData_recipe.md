# ReUseData: Workflow-based Data Recipes for Management of Reusable and Reproducible Data Resources

Qian Liu

#### 2025-10-30

# 1 Introduction

The growth in the volume and complexity of genomic data resources over
the past few decades poses both opportunities and challenges for data
reuse. Presently, reuse of data often involves similar preprocessing
steps in different research projects. Lack of a standardized
annotation strategy can lead to difficult-to-find and even duplicated
datasets, resulting in substantial inefficiencies and wasted computing
resources, especially for research collaborations and bioinformatics
core facilities. Tools such as `GoGetData` and `AnnotationHub` have
been developed to mitigate common problems in managing and accessing
curated genomic datasets. However, their use can be limited due to
software requirements (e.g., Conda <https://conda.io>), forms of data
representation or scope of data resources.
To respond to the FAIR (findability, accessibility, interoperability,
and reusability) data principles that are being widely adopted and
organizational requirements for Data Management Plans (DMPs), here, we
introduce `ReUseData`, an *R/Bioconductor* software tool to provide a
systematic and versatile approach for standardized and reproducible
data management. `ReUseData` facilitates transformation of shell or
other ad hoc scripts for data preprocessing into workflow-based data
recipes. Evaluation of data recipes generate curated data files in
their generic formats (e.g., VCF, bed) with full annotations for
subsequent reuse.

This package focuses on the management of genomic data resources and
uses classes and functions from existing *Bioconductor* packages. So
we think it should be a good fit for the *Bioconductor*.

# 2 Installation

1. Install the package from *Bioconductor*.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ReUseData")
```

Use the development version:

```
BiocManager::install("ReUseData", version = "devel")
```

2. Load the package and other packages used in this vignette into the
   R session.

```
suppressPackageStartupMessages(library(Rcwl))
library(ReUseData)
```

# 3 Project resources

## 3.1 `ReUseData` recipe landing pages

The project website <https://rcwl.org/dataRecipes/> contains all
prebuilt data recipes for public data downloading and curation. They
are available for direct use with convenient webpage searching. Each
data recipe has a landing page including recipe description (inputs,
outputs, etc.) and user instructions. **Make sure to check the
instructions of eligible input parameter values before recipe
evaluation.** These prebuilt data recipes demonstrate the use of
software and can be taken as templates for users to create their own
recipes for protected datasets.

There are many other *R* resources available on this main website
<https://rcwl.org/>, including package vignettes for `Rcwl`
and`RcwlPipelines`, `Rcwl` tutorial e-book, case studies of using
`RcwlPipelines` in preprocessing single-cell RNA-seq data, etc.

# 4 `ReUseData` recipe scripts

The prebuilt data recipe scripts are included in the package, and are
physically residing in a dedicated [GitHub
repository](https://github.com/rworkflow/ReUseDataRecipes), which
demonstrates the recipe construction for different situations. The
most common case is that a data recipe can manage multiple data
resources with different input parameters (species, versions,
etc.). For example, the `gencode_transcripts` recipe download from
GENCODE, unzip and index the transcript fasta file for human or mouse
with different versions. A simple data downloading (using `wget`) for
a specific file can be written as a data recipe without any input
parameter. For example, the data recipe
`gcp_broad_gatk_hg38_1000G_omni2.5`) downloads the
`1000G_omni2.5.hg38.vcf.gz` and the `tbi` index files from Google
Cloud Platform bucket for Broad reference data GATK hg38.

If the data curation gets more complicated, say, multiple command-line
tools are to be involved, and `conda` can be used to install required
packages, or some secondary files are to be generated and collected,
the raw way of building a `ReUseData` recipe using `Rcwl` functions is
recommended, which gives more flexibility and power to accommodate
different situations. An example recipe is the `reference_genome`
which downloads, formats, and index reference genome data using tools
of `samtools`, `picard` and `bwa`, and manages multiple secondary
files besides the main fasta file for later reuse.

# 5 `ReUseData` core functions

Here we show the usage of 4 core functions `recipeMake`,
`recipeUpdate`, `recipeSearch`, `recipeLoad` for constructing,
updating, searching and loading `ReUseData` recipes in *R*.

## 5.1 Recipe construction and evaluation

One can construct a data recipe from scratch or convert existing
shell scripts for data processing into data recipes, by specifying
input parameters, and output globbing patterns using `recipeMake`
function. Then the data recipe is represented in *R* as an S4 class
`cwlProcess`. Upon assigning values to the input parameters, the
recipe is ready to be evaluated to generate data of interest. Here
are two examples:

```
script <- '
input=$1
outfile=$2
echo "Print the input: $input" > $outfile.txt
'
```

Equivalently, we can load the shell script directly:

```
script <- system.file("extdata", "echo_out.sh", package = "ReUseData")
```

```
rcp <- recipeMake(shscript = script,
                  paramID = c("input", "outfile"),
                  paramType = c("string", "string"),
                  outputID = "echoout",
                  outputGlob = "*.txt")
inputs(rcp)
#> inputs:
#>   input (string):
#>   outfile (string):
outputs(rcp)
#> outputs:
#> echoout:
#>   type: File[]
#>   outputBinding:
#>     glob: '*.txt'
```

Evaluation of the data recipes are internally submitted as CWL
workflow tasks, which requires the latest version of `cwltool`. Here
we have used `basilisk` to initiate a conda environment and install
the `cwltool` in that environment if it is not available (or only
older versions are available) in the computer system.

We can install cwltool first to make sure a cwl-runner is available.

```
invisible(Rcwl::install_cwltool())
```

```
rcp$input <- "Hello World!"
rcp$outfile <- "outfile"
outdir <- file.path(tempdir(), "SharedData")
res <- getData(rcp,
               outdir = outdir,
               notes = c("echo", "hello", "world", "txt"))
#> }[1;30mINFO[0m Final process status is success
```

Let’s take a look at the output file, which is successfully generated
in user-specified directory and grabbed through the `outputGlob`
argument. For more details of the `getData` function for recipe
evaluation, check the other vignette for [reusable data management](ReUseData_data.html).

```
res$out
#> [1] "/tmp/RtmpIAiCac/SharedData/outfile.txt"
readLines(res$out)
#> [1] "Print the input: Hello World!"
```

Here we show a more complex example where the shell script has
required command line tools. When specific tools are needed for the
data processing, users just need to add their names in the
`requireTools` argument in `recipeMake` function, and then add `conda = TRUE` when evaluating the recipe with `getData` function. Then these
tools will be automatically installed by initiating a conda
environment and the script can be successfully run in that
environment.

This function promotes data reproducibility across different computing
platforms, and removes barrier of using sophisticated bioinformatics
tools by less experienced users.

The following code chunk is not evaluated for time-limit of package
building but can be evaluated by users.

```
shfile <- system.file("extdata", "gencode_transcripts.sh",
                      package = "ReUseData")
readLines(shfile)
rcp <- recipeMake(shscript = shfile,
                  paramID = c("species", "version"),
                  paramType = c("string", "string"),
                  outputID = "transcripts",
                  outputGlob = "*.transcripts.fa*",
                  requireTools = c("wget", "gzip", "samtools")
                  )
rcp$species <- "human"
rcp$version <- "42"
res <- getData(rcp,
        outdir = outdir,
        notes = c("gencode", "transcripts", "human", "42"),
        conda = TRUE)
res$output
```

## 5.2 Recipe caching and updating

`recipeUpdate()` creates a local cache for data recipes that are saved
in specified GitHub repository (if first time use), syncs and updates
data recipes from the GitHub repo to local caching system, so any
newly added recipes can be readily accessed and loaded directly in
*R*.

**NOTE:**

* The `cachePath` argument need to match between `recipeUpdate`,
  `recipeLoad` and `recipeSearch` functions.
* use `force=TRUE` when any old recipes that are previously cached are
  updated.
* use `remote = TRUE`to sync with remote GitHub repositories. By
  default, it syncs with `ReUseDataRecipe` GitHub
  repository](<https://github.com/rworkflow/ReUseDataRecipe>) for
  public, prebuilt data recipes. `repo` can also be a private GitHub
  repository.

```
## First time use
recipeUpdate(cachePath = "ReUseDataRecipe",
             force = TRUE)
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
#>   BFC31 | STAR_index
#>   BFC32 | bowtie2_index
#>   BFC33 | echo_out
#>   BFC34 | ensembl_liftover
#>   BFC35 | gcp_broad_gatk_hg19
#>   ...     ...
#>   BFC41 | gencode_transcripts
#>   BFC42 | hisat2_index
#>   BFC43 | reference_genome
#>   BFC44 | salmon_index
#>   BFC45 | ucsc_database
```

To sync the local recipe cache with remote GitHub
repository. Currently the remote data recipes on GitHub are the same
as the recipes in package (so not evaluted here to avoid duplicate
messages). We will do our best to keep current of the data recipes in
package development version with the remote GitHub repository.

```
recipeUpdate(remote = TRUE,
             repos = "rworkflow/ReUseDataRecipe")  ## can be private repo
```

`recipeUpdate` returns a `recipeHub` object with a list of all
available recipes. One can subset the list with `[` and use getter
functions `recipeNames()` to get the recipe names which can then be
passed to the `recipeSearch()` or `recipeLoad()`.

```
rh <- recipeUpdate()
#> Updating recipes...
#>
is(rh)
#> [1] "recipeHub"             "cwlHub"                "BiocFileCacheReadOnly"
#> [4] "BiocFileCacheBase"
rh[1]
#> recipeHub with 1 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseDataRecipe
#> # recipeSearch() to query specific recipes using multipe keywords
#> # recipeUpdate() to update the local recipe cache
#>
#>           name
#>   BFC31 | STAR_index
recipeNames(rh)
#>  [1] "STAR_index"            "bowtie2_index"         "echo_out"
#>  [4] "ensembl_liftover"      "gcp_broad_gatk_hg19"   "gcp_broad_gatk_hg38"
#>  [7] "gcp_gatk_mutect2_b37"  "gcp_gatk_mutect2_hg38" "gencode_annotation"
#> [10] "gencode_genome_grch38" "gencode_transcripts"   "hisat2_index"
#> [13] "reference_genome"      "salmon_index"          "ucsc_database"
```

## 5.3 Recipe searching and loading

Cached data recipes can be searched using multiple keywords to match
the recipe name. It returns a `recipeHub` object with a list of
recipes available.

```
recipeSearch()
#> recipeHub with 15 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseDataRecipe
#> # recipeSearch() to query specific recipes using multipe keywords
#> # recipeUpdate() to update the local recipe cache
#>
#>           name
#>   BFC31 | STAR_index
#>   BFC32 | bowtie2_index
#>   BFC33 | echo_out
#>   BFC34 | ensembl_liftover
#>   BFC35 | gcp_broad_gatk_hg19
#>   ...     ...
#>   BFC41 | gencode_transcripts
#>   BFC42 | hisat2_index
#>   BFC43 | reference_genome
#>   BFC44 | salmon_index
#>   BFC45 | ucsc_database
recipeSearch("gencode")
#> recipeHub with 3 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseDataRecipe
#> # recipeSearch() to query specific recipes using multipe keywords
#> # recipeUpdate() to update the local recipe cache
#>
#>           name
#>   BFC39 | gencode_annotation
#>   BFC40 | gencode_genome_grch38
#>   BFC41 | gencode_transcripts
recipeSearch(c("STAR", "index"))
#> recipeHub with 1 records
#> cache path:  /tmp/RtmpIAiCac/cache/ReUseDataRecipe
#> # recipeSearch() to query specific recipes using multipe keywords
#> # recipeUpdate() to update the local recipe cache
#>
#>           name
#>   BFC31 | STAR_index
```

Recipes can be directly loaded into *R* using `recipeLoad` function
with user assigned name or the original recipe name. Once the recipe
is successfully loaded, a message will be returned with recipe
instructions.

```
rcp <- recipeLoad("STAR_index")
#> Note: you need to assign a name for the recipe: rcpName <- recipeLoad('xx')
#> Data recipe loaded!
#> Use inputs() to check required input parameters before evaluation.
#> Check here: https://rcwl.org/dataRecipes/STAR_index.html
#> for user instructions (e.g., eligible input values, data source, etc.)
```

**NOTE** Use `return=FALSE` if you want to keep the original recipe
name, or if multiple recipes are to be loaded.

```
recipeLoad("STAR_index", return = FALSE)
#> Data recipe loaded!
#> Use inputs(STAR_index) to check required input parameters before evaluation.
#> Check here: https://rcwl.org/dataRecipes/STAR_index.html
#> for user instructions (e.g., eligible input values, data source, etc.)
```

```
identical(rcp, STAR_index)
#> [1] TRUE
```

```
recipeLoad(c("ensembl_liftover", "gencode_annotation"), return=FALSE)
#> Data recipe loaded!
#> Use inputs(ensembl_liftover) to check required input parameters before evaluation.
#> Check here: https://rcwl.org/dataRecipes/ensembl_liftover.html
#> for user instructions (e.g., eligible input values, data source, etc.)
#> Data recipe loaded!
#> Use inputs(gencode_annotation) to check required input parameters before evaluation.
#> Check here: https://rcwl.org/dataRecipes/gencode_annotation.html
#> for user instructions (e.g., eligible input values, data source, etc.)
```

It’s important to check the required `inputs()` of the recipe and the
recipe landing page for eligible input parameter values before
evaluating the recipe to generate data of interest.

```
inputs(STAR_index)
#> inputs:
#>   ref (reference genome)   ( string|File ):
#>   gtf (GTF)   ( string|File ):
#>   genomeDir (genomeDir)  (string):
#>   threads (threads)  (int):
#>   sjdb (sjdbOverhang)  (int):  100
inputs(ensembl_liftover)
#> inputs:
#>   species (species)  (string):
#>   from (from)  (string):
#>   to (to)  (string):
inputs(gencode_annotation)
#> inputs:
#>   species (species)  (string):
#>   version (version)  (string):
```

# 6 SessionInfo

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