# RcwlPipelines: Bioinformatics tools and pipelines based on Rcwl

Qiang Hu, Qian Liu

#### 2025-10-30

`RcwlPipelines` is a *Bioconductor* package that manages a collection
of commonly used bioinformatics tools and pipeline based on
`Rcwl`. These pre-built and pre-tested tools and pipelines are highly
modularized with easy customization to meet different bioinformatics
data analysis needs.

`Rcwl` and `RcwlPipelines` together forms a *Bioconductor* toolchain
for use and development of reproducible bioinformatics pipelines in
Common Workflow Language (CWL). The project also aims to develop a
community-driven platform for open source, open development, and open
review of best-practice CWL bioinformatics pipelines.

# 1 Installation

1. Install the package from *Bioconductor*.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RcwlPipelines")
```

The development version is also available to download from GitHub.

```
BiocManager::install("rworkflow/RcwlPipelines")
```

2. Load the package into the R session.

```
library(RcwlPipelines)
```

# 2 Project resources

The project website <https://rcwl.org/> serves as a central hub for all
related resources. It provides guidance for new users and tutorials
for both users and developers. Specific resources are listed below.

## 2.1 The *R* recipes and cwl scripts

The *R* scripts to build the CWL tools and pipelines are now residing
in a dedicated [GitHub
repository](https://github.com/rworkflow/RcwlRecipes), which is
intended to be a community effort to collect and contribute
Bioinformatics tools and pipelines using `Rcwl` and CWL.

## 2.2 Tutorial book

The [tutorial book](https://rcwl.org/RcwlBook/) provides detailed
instructions for developing `Rcwl` tools/pipelines, and also includes
examples of some commonly-used tools and pipelines that covers a wide
range of Bioinformatics data analysis needs.

# 3 `RcwlPipelines` core functions

Here we show the usage of 3 core functions: `cwlUpdate`, `cwlSearch`
and `cwlLoad` for updating, searching, and loading the needed tools
or pipelines in *R*.

## 3.1 `cwlUpdate`

The `cwlUpdate` function syncs the current `Rcwl` recipes and returns
a `cwlHub` object which contains the most updated `Rcwl` recipes. The
`mcols()` function returns all related information about each
available tool or pipeline.

The recipes will be locally cached, so users don’t need to call
`cwlUpdate` every time unless they want to use a tool/pipeline that is
newly added to `RcwlPipelines`. Here we are using the recipes from
*Bioconductor* devel version.

```
## For vignette use only. users don't need to do this step.
Sys.setenv(cachePath = tempdir())
```

```
atls <- cwlUpdate(branch = "dev") ## sync the tools/pipelines.
atls
#> cwlHub with 196 records
#> cache path:  /tmp/RtmpkRnFWr/Rcwl
#> # last modified date:  2022-02-11
#> # cwlSearch() to query scripts
#> # cwlLoad('title') to load the script
#> # additional mcols(): rid, rpath, Type, Container, mtime, ...
#>
#>            title
#>   BFC1   | pl_AnnPhaseVcf
#>   BFC2   | pl_BaseRecal
#>   BFC3   | pl_BwaAlign
#>   BFC4   | pl_COMPSRA_rn
#>   BFC5   | pl_CombineGenotypeGVCFs
#>   ...      ...
#>   BFC192 | tl_vcf_expression_annotator
#>   BFC193 | tl_vcf_readcount_annotator
#>   BFC194 | tl_vep
#>   BFC195 | tl_vep_plugin
#>   BFC196 | tl_vt_decompose
#>          Command
#>   BFC1   VCFvep+dVCFcoverage+rVCFcoverage+VCFexpression+PhaseVcf
#>   BFC2   BaseRecalibrator+ApplyBQSR+samtools_index+samtools_flagstat+samt...
#>   BFC3   bwa+sam2bam+sortBam+idxBam
#>   BFC4   copy+compsra
#>   BFC5   CombineGVCFs+GenotypeGVCFs
#>   ...    ...
#>   BFC192 vcf-expression-annotator
#>   BFC193 vcf-readcount-annotator
#>   BFC194 vep
#>   BFC195 vep
#>   BFC196 vt decompose
table(mcols(atls)$Type)
#>
#> pipeline     tool
#>       43      153
```

Currently, we have integrated 153 command
line tools and 43 pipelines.

## 3.2 `cwlSearch`

We can use (multiple) keywords to search for specific tools/pipelines
of interest, which internally search the `mcols` of “rname”, “rpath”,
“fpath”, “Command” and “Containers”. Here we show how to search the
alignment tool `bwa mem`.

```
t1 <- cwlSearch(c("bwa", "mem"))
t1
#> cwlHub with 1 records
#> cache path:  /tmp/RtmpkRnFWr/Rcwl
#> # last modified date:  2021-10-25
#> # cwlSearch() to query scripts
#> # cwlLoad('title') to load the script
#> # additional mcols(): rid, rpath, Type, Container, mtime, ...
#>
#>            title  Command
#>   BFC118 | tl_bwa bwa mem
mcols(t1)
#> DataFrame with 1 row and 14 columns
#>           rid       rname         create_time         access_time
#>   <character> <character>         <character>         <character>
#> 1      BFC118      tl_bwa 2025-10-30 05:58:49 2025-10-30 05:58:49
#>                    rpath       rtype                  fpath last_modified_time
#>              <character> <character>            <character>          <numeric>
#> 1 /tmp/RtmpkRnFWr/Rcwl..       local /tmp/RtmpkRnFWr/Rcwl..                 NA
#>          etag   expires        Type     Command              Container
#>   <character> <numeric> <character> <character>            <character>
#> 1          NA        NA        tool     bwa mem biocontainers/bwa:v0..
#>                 mtime
#>           <character>
#> 1 2021-10-25 12:58:45
```

## 3.3 `cwlLoad`

The last core function `cwlLoad` loads the `Rcwl` tool/pipeline into
the *R* working environment. The code below loads the tool with a
user-defined name `bwa` to do the read alignment.

```
bwa <- cwlLoad(title(t1)[1])  ## "tl_bwa"
bwa <- cwlLoad(mcols(t1)$fpath[1]) ## equivalent to the above.
bwa
#> class: cwlProcess
#>  cwlClass: CommandLineTool
#>  cwlVersion: v1.0
#>  baseCommand: bwa mem
#> requirements:
#> - class: DockerRequirement
#>   dockerPull: biocontainers/bwa:v0.7.17-3-deb_cv1
#> inputs:
#>   threads (int): -t
#>   RG (string?): -R
#>   Ref (File):
#>   FQ1 (File):
#>   FQ2 (File?):
#> outputs:
#> sam:
#>   type: File
#>   outputBinding:
#>     glob: '*.sam'
#> stdout: bwaOutput.sam
```

Now the *R* tool of `bwa` is ready to use.

# 4 Customize a tool or pipeline

To fit users’ specific needs，the existing tool or pipline can be
easily customized. Here we use the `rnaseq_Sf` pipeline to demonstrate
how to access and change the arguments of a specific tool inside a
pipeline. This pipeline covers RNA-seq reads quality summary by
`fastQC`, alignment by `STAR`, quantification by `featureCounts` and
quality control by `RSeQC`.

```
rnaseq_Sf <- cwlLoad("pl_rnaseq_Sf")
#> fastqc loaded
#> STAR loaded
#> sortBam loaded
#> samtools_index loaded
#> samtools_flagstat loaded
#> featureCounts loaded
#> gtfToGenePred loaded
#> genePredToBed loaded
#> read_distribution loaded
#> geneBody_coverage loaded
#> STAR loaded
#> gCoverage loaded
plotCWL(rnaseq_Sf)
```

There are many default arguments defined for the tool of `STAR` inside
the pipeline. Users might want to change some of them. For example, we
can change the value for `--outFilterMismatchNmax` argument from 2 to
5 for longer reads.

```
arguments(rnaseq_Sf, "STAR")[5:6]
#> [[1]]
#> [1] "--readFilesCommand"
#>
#> [[2]]
#> [1] "zcat"
arguments(rnaseq_Sf, "STAR")[[6]] <- 5
arguments(rnaseq_Sf, "STAR")[5:6]
#> [[1]]
#> [1] "--readFilesCommand"
#>
#> [[2]]
#> [1] "5"
```

We can also change the docker image for a specific tool (e.g., to a
specific version). First, we search for all available docker images
for `STAR` in biocontainers repository. The Source server could be
[quay](https://quay.io/) or [dockerhub](https://hub.docker.com).

```
searchContainer("STAR", repo = "biocontainers", source = "quay")
#> DataFrame with 0 rows and 0 columns
```

Then, we can change the `STAR` version into 2.7.8a (tag name: 2.7.8a–0).

```
requirements(rnaseq_Sf, "STAR")[[1]]
#> $class
#> [1] "DockerRequirement"
#>
#> $dockerPull
#> [1] "quay.io/biocontainers/star:2.7.9a--h9ee0642_0"
requirements(rnaseq_Sf, "STAR")[[1]] <- requireDocker(
    docker = "quay.io/biocontainers/star:2.7.8a--0")
requirements(rnaseq_Sf, "STAR")[[1]]
#> $class
#> [1] "DockerRequirement"
#>
#> $dockerPull
#> [1] "quay.io/biocontainers/star:2.7.8a--0"
```

# 5 Run a tool or pipeline

Once the tool or pipeline is ready, we only need to assign values for
each of the input parameters, and then submit using one of the
functions: `runCWL`, `runCWLBatch` and `cwlShiny`. More detailed Usage
and examples can be refer to the `Rcwl`
[vignette](https://bioconductor.org/packages/devel/bioc/vignettes/Rcwl/inst/doc/Rcwl.html).

To successfully run the tool or pipeline, users either need to have
all required command line tools pre-installed locally, or using the
docker/singularity runtime by specifying `docker = TRUE` or `docker = "singularity"` argument inside `runCWL` or `runCWLBatch`
function. Since the *Bioconductor* building machine doesn’t have all the
tools installed, nor does it support the docker runtime, here we use some
pseudo-code to demonstrate the tool/pipeline execution.

```
inputs(rnaseq_Sf)
rnaseq_Sf$in_seqfiles <- list("sample_R1.fq.gz",
                              "sample_R2.fq.gz")
rnaseq_Sf$in_prefix <- "sample"
rnaseq_Sf$in_genomeDir <- "genome_STAR_index_Dir"
rnaseq_Sf$in_GTFfile <- "GENCODE_version.gtf"

runCWL(rnaseq_Sf, outdir = "output/sample", docker = TRUE)
```

Users can also submit parallel jobs to HPC for multiple samples using
`runCWLBatch` function. Different cluster job managers, such as
“multicore”, “sge” and “slurm”, are supported using the
`BiocParallel::BatchtoolsParam`.

```
library(BioParallel)
bpparam <- BatchtoolsParam(workers = 2, cluster = "sge",
                           template = batchtoolsTemplate("sge"))

inputList <- list(in_seqfiles = list(sample1 = list("sample1_R1.fq.gz",
                                                    "sample1_R2.fq.gz"),
                                     sample2 = list("sample2_R1.fq.gz",
                                                    "sample2_R2.fq.gz")),
                  in_prefix = list(sample1 = "sample1",
                                   sample2 = "sample2"))

paramList <- list(in_genomeDir = "genome_STAR_index_Dir",
                  in_GTFfile = "GENCODE_version.gtf",
                  in_runThreadN = 16)

runCWLBatch(rnaseq_Sf, outdir = "output",
            inputList, paramList,
            BPPARAM = bpparam)
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
#> [1] RcwlPipelines_1.26.0 BiocFileCache_3.0.0  dbplyr_2.5.1
#> [4] Rcwl_1.26.0          S4Vectors_0.48.0     BiocGenerics_0.56.0
#> [7] generics_0.1.4       yaml_2.3.10          BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1    dplyr_1.1.4         blob_1.2.4
#>  [4] filelock_1.0.3      R.utils_2.13.0      fastmap_1.2.0
#>  [7] promises_1.4.0      digest_0.6.37       base64url_1.4
#> [10] mime_0.13           lifecycle_1.0.4     RSQLite_2.4.3
#> [13] magrittr_2.0.4      compiler_4.5.1      rlang_1.1.6
#> [16] sass_0.4.10         progress_1.2.3      tools_4.5.1
#> [19] igraph_2.2.1        data.table_1.17.8   knitr_1.50
#> [22] prettyunits_1.2.0   brew_1.0-10         htmlwidgets_1.6.4
#> [25] bit_4.6.0           curl_7.0.0          reticulate_1.44.0
#> [28] RColorBrewer_1.1-3  batchtools_0.9.18   BiocParallel_1.44.0
#> [31] withr_3.0.2         purrr_1.1.0         R.oo_1.27.1
#> [34] grid_4.5.1          git2r_0.36.2        xtable_1.8-4
#> [37] debugme_1.2.0       cli_3.6.5           rmarkdown_2.30
#> [40] DiagrammeR_1.0.11   crayon_1.5.3        otel_0.2.0
#> [43] rstudioapi_0.17.1   httr_1.4.7          visNetwork_2.1.4
#> [46] DBI_1.2.3           cachem_1.1.0        stringr_1.5.2
#> [49] parallel_4.5.1      BiocManager_1.30.26 basilisk_1.22.0
#> [52] vctrs_0.6.5         Matrix_1.7-4        jsonlite_2.0.0
#> [55] dir.expiry_1.18.0   bookdown_0.45       hms_1.1.4
#> [58] bit64_4.6.0-1       jquerylib_0.1.4     glue_1.8.0
#> [61] codetools_0.2-20    stringi_1.8.7       later_1.4.4
#> [64] tibble_3.3.0        pillar_1.11.1       rappdirs_0.3.3
#> [67] htmltools_0.5.8.1   R6_2.6.1            httr2_1.2.1
#> [70] evaluate_1.0.5      shiny_1.11.1        lattice_0.22-7
#> [73] R.methodsS3_1.8.2   png_0.1-8           backports_1.5.0
#> [76] memoise_2.0.1       httpuv_1.6.16       bslib_0.9.0
#> [79] Rcpp_1.1.0          checkmate_2.3.3     xfun_0.53
#> [82] pkgconfig_2.0.3
```