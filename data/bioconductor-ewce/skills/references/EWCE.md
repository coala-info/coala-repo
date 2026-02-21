# Contents

* [1 Introduction](#introduction)
* [2 Setup](#setup)
* [3 Run cell-type enrichment tests](#run-cell-type-enrichment-tests)
  + [3.1 1. Prepare input data](#prepare-input-data)
    - [3.1.1 CellTypeDataset](#celltypedataset)
    - [3.1.2 Gene list](#gene-list)
  + [3.2 2. Run cell type enrichment tests](#run-cell-type-enrichment-tests-1)
* [4 Docker](#docker)
  + [4.1 Installation](#installation)
  + [4.2 Method 1: via Docker](#method-1-via-docker)
  + [4.3 Method 2: via Singularity](#method-2-via-singularity)
  + [4.4 Usage](#usage)
* [5 Session Info](#session-info)
* [6 References](#references)

# 1 Introduction

The `EWCE` R package is designed to facilitate expression weighted cell type
enrichment analysis as described in our *Frontiers in Neuroscience*
paper (**???**). `EWCE` can be applied to any gene list.

Using `EWCE` essentially involves two steps:

1. Prepare a single-cell reference; i.e. CellTypeDataset (CTD). Alternatively,
   you can use one of the pre-generated CTDs we provide via the package `ewceData`
   (which comes with `EWCE`).
2. Run cell type enrichment on a gene list using the `bootstrap_enrichment_test` function.

**NOTE**: This documentation is for the development version of `EWCE`. See [Bioconductor](https://bioconductor.org/packages/release/bioc/html/EWCE.html) for documentation on the current release version.

# 2 Setup

```
library(EWCE)
```

```
## Loading required package: RNOmni
```

```
set.seed(1234)

#### Package name ####
pkg <- tolower("EWCE")
#### Username of DockerHub account ####
docker_user <- "neurogenomicslab"
```

# 3 Run cell-type enrichment tests

## 3.1 1. Prepare input data

### 3.1.1 CellTypeDataset

Load a CTD previously generated from mouse cortex and hypothalamus single-cell RNA-seq data (from the Karolinska Institute).

#### 3.1.1.1 CTD levels

Each level of a CTD corresponds to increasingly refined cell-type/-subtype annotations. For example, in the CTD `ewceData::ctd()` level 1 includes the cell-type “interneurons”, while level 2 breaks these this group into 16 different interneuron subtypes (“Int…”).

```
ctd <- ewceData::ctd()
```

```
## see ?ewceData and browseVignettes('ewceData') for documentation
```

```
## loading from cache
```

#### 3.1.1.2 Plot CTD mean\_exp

Plot the expression of four markers genes across all cell types in the CTD.

```
plt_exp <- EWCE::plot_ctd(ctd = ctd,
                        level = 1,
                        genes = c("Apoe","Gfap","Gapdh"),
                        metric = "mean_exp")
```

![](data:image/png;base64...)

```
plt_spec <- EWCE::plot_ctd(ctd = ctd,
                         level = 2,
                         genes = c("Apoe","Gfap","Gapdh"),
                         metric = "specificity")
```

![](data:image/png;base64...)

### 3.1.2 Gene list

Gene lists input into *EWCE* can comes from any source (e.g. GWAS, candidate genes, pathways).

Here, we provide an example gene list of Alzheimer’s disease-related nominated from a GWAS.

```
hits <- ewceData::example_genelist()
```

```
## see ?ewceData and browseVignettes('ewceData') for documentation
```

```
## loading from cache
```

```
print(hits)
```

```
##  [1] "APOE"     "BIN1"     "CLU"      "ABCA7"    "CR1"      "PICALM"
##  [7] "MS4A6A"   "CD33"     "MS4A4E"   "CD2AP"    "EOGA1"    "INPP5D"
## [13] "MEF2C"    "HLA-DRB5" "ZCWPW1"   "NME8"     "PTK2B"    "CELF1"
## [19] "SORL1"    "FERMT2"   "SLC24A4"  "CASS4"
```

## 3.2 2. Run cell type enrichment tests

We now run the cell type enrichment tests on the gene list. Since the CTD is from mouse data (and is annotated using mouse genes) we specify the argument `sctSpecies="mouse"`. `bootstrap_enrichment_test` will automaticlaly convert the mouse genes to human genes.

Since the gene list came from GWAS in humans, we set `genelistSpecies="human"`.

*Note*: We set the seed at the top of this vignette to
ensure reproducibility in the bootstrap sampling function.

#### 3.2.0.1 Hyperparameters

*Note*: We use 100 repetitions here for the purposes of a quick example, but in practice you would want to use `reps=10000` for publishable results.

#### 3.2.0.2 Parallelisation

You can now speed up the bootstrapping process by parallelising across
multiple cores with the parameter `no_cores` (`=1` by default).

```
reps <- 100
annotLevel <- 1
```

```
full_results <- EWCE::bootstrap_enrichment_test(sct_data = ctd,
                                                sctSpecies = "mouse",
                                                genelistSpecies = "human",
                                                hits = hits,
                                                reps = reps,
                                                annotLevel = annotLevel)
```

```
## 1 core(s) assigned as workers (71 reserved).
```

```
## Generating gene background for mouse x human ==> human
```

```
## Gathering ortholog reports.
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: human
```

```
## Common name mapping found for human
```

```
## 1 organism identified from search: 9606
```

```
## Gene table with 19,129 rows retrieved.
```

```
## Returning all 19,129 genes from human.
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: mouse
```

```
## Common name mapping found for mouse
```

```
## 1 organism identified from search: 10090
```

```
## Gene table with 21,207 rows retrieved.
```

```
## Returning all 21,207 genes from mouse.
```

```
## --
## --
```

```
## Preparing gene_df.
```

```
## data.frame format detected.
```

```
## Extracting genes from Gene.Symbol.
```

```
## 21,207 genes extracted.
```

```
## Converting mouse ==> human orthologs using: homologene
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: mouse
```

```
## Common name mapping found for mouse
```

```
## 1 organism identified from search: 10090
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: human
```

```
## Common name mapping found for human
```

```
## 1 organism identified from search: 9606
```

```
## Checking for genes without orthologs in human.
```

```
## Extracting genes from input_gene.
```

```
## 17,355 genes extracted.
```

```
## Extracting genes from ortholog_gene.
```

```
## 17,355 genes extracted.
```

```
## Checking for genes without 1:1 orthologs.
```

```
## Dropping 131 genes that have multiple input_gene per ortholog_gene (many:1).
```

```
## Dropping 498 genes that have multiple ortholog_gene per input_gene (1:many).
```

```
## Filtering gene_df with gene_map
```

```
## Adding input_gene col to gene_df.
```

```
## Adding ortholog_gene col to gene_df.
```

```
##
## =========== REPORT SUMMARY ===========
```

```
## Total genes dropped after convert_orthologs :
##    4,725 / 21,207 (22%)
```

```
## Total genes remaining after convert_orthologs :
##    16,482 / 21,207 (78%)
```

```
## --
```

```
##
## =========== REPORT SUMMARY ===========
```

```
## 16,482 / 21,207 (77.72%) target_species genes remain after ortholog conversion.
```

```
## 16,482 / 19,129 (86.16%) reference_species genes remain after ortholog conversion.
```

```
## Gathering ortholog reports.
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: human
```

```
## Common name mapping found for human
```

```
## 1 organism identified from search: 9606
```

```
## Gene table with 19,129 rows retrieved.
```

```
## Returning all 19,129 genes from human.
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: human
```

```
## Common name mapping found for human
```

```
## 1 organism identified from search: 9606
```

```
## Gene table with 19,129 rows retrieved.
```

```
## Returning all 19,129 genes from human.
```

```
## --
```

```
##
## =========== REPORT SUMMARY ===========
```

```
## 19,129 / 19,129 (100%) target_species genes remain after ortholog conversion.
```

```
## 19,129 / 19,129 (100%) reference_species genes remain after ortholog conversion.
```

```
## 16,482 intersect background genes used.
```

```
## Standardising CellTypeDataset
```

```
## Checking gene list inputs.
```

```
## Running without gene size control.
```

```
## 17 hit gene(s) remain after filtering.
```

```
## Computing gene scores.
```

```
## Using previously sampled genes.
```

```
## Computing gene counts.
```

```
## Testing for enrichment in 7 cell types...
```

```
## Sorting results by p-value.
```

```
## Computing BH-corrected q-values.
```

```
## 1 significant cell type enrichment results @ q<0.05 :
```

```
##    CellType annotLevel p fold_change sd_from_mean q
## 1 microglia          1 0    1.965915     3.938119 0
```

The main table of results is stored in `full_results$results`.

In this case, microglia were the only cell type that was significantly enriched in the Alzheimer’s disease gene list.

```
knitr::kable(full_results$results)
```

|  | CellType | annotLevel | p | fold\_change | sd\_from\_mean | q |
| --- | --- | --- | --- | --- | --- | --- |
| microglia | microglia | 1 | 0.00 | 1.9659148 | 3.9381188 | 0.000 |
| astrocytes\_ependymal | astrocytes\_ependymal | 1 | 0.13 | 1.2624889 | 1.1553910 | 0.455 |
| pyramidal\_SS | pyramidal\_SS | 1 | 0.80 | 0.8699242 | -0.8226268 | 1.000 |
| oligodendrocytes | oligodendrocytes | 1 | 0.87 | 0.7631149 | -1.0861761 | 1.000 |
| pyramidal\_CA1 | pyramidal\_CA1 | 1 | 0.89 | 0.8202496 | -1.1738063 | 1.000 |
| endothelial\_mural | endothelial\_mural | 1 | 0.90 | 0.7674534 | -1.1811797 | 1.000 |
| interneurons | interneurons | 1 | 1.00 | 0.4012954 | -3.4703413 | 1.000 |

The results can be visualised using another function, which shows for each cell type, the number of standard deviations from the mean the level of expression was found to be in the target gene list, relative to the bootstrapped mean.

The dendrogram at the top shows how the cell types are hierarchically clustered by transcriptional similarity.

```
plot_list <- EWCE::ewce_plot(total_res = full_results$results,
                           mtc_method = "BH",
                           ctd = ctd)
print(plot_list$withDendro)
```

```
## NULL
```

# 4 Docker

ewce is now available via
[DockerHub](https://hub.docker.com/repository/docker/neurogenomicslab/ewce)
as a containerised environment with Rstudio and
all necessary dependencies pre-installed.

## 4.1 Installation

## 4.2 Method 1: via Docker

First, [install Docker](https://docs.docker.com/get-docker/)
if you have not already.

Create an image of the [Docker](https://www.docker.com/) container
in command line:

```
docker pull neurogenomicslab/ewce
```

Once the image has been created, you can launch it with:

```
docker run \
  -d \
  -e ROOT=true \
  -e PASSWORD=bioc \
  -v ~/Desktop:/Desktop \
  -v /Volumes:/Volumes \
  -p 8787:8787 \
  neurogenomicslab/ewce
```

* The `-d` ensures the container will run in “detached” mode,
  which means it will persist even after you’ve closed your command line session.
* Optionally, you can also install the [Docker Desktop](https://www.docker.com/products/docker-desktop)
  to easily manage your containers.
* You can set the password to whatever you like by changing the
  `-e PASSWORD=...` flag.
* The username will be *“rstudio”* by default.

## 4.3 Method 2: via Singularity

If you are using a system that does not allow Docker
(as is the case for many institutional computing clusters),
you can instead [install Docker images via Singularity](https://sylabs.io/guides/2.6/user-guide/singularity_and_docker.html).

```
singularity pull docker://neurogenomicslab/ewce
```

## 4.4 Usage

Finally, launch the containerised Rstudio by entering the
following URL in any web browser:
*http://localhost:8787/*

Login using the credentials set during the Installation steps.

# 5 Session Info

```
utils::sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
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
##  [1] ewceData_1.17.0     ExperimentHub_3.0.0 AnnotationHub_4.0.0
##  [4] BiocFileCache_3.0.0 dbplyr_2.5.1        BiocGenerics_0.56.0
##  [7] generics_0.1.4      EWCE_1.18.0         RNOmni_1.0.1.2
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              magick_2.9.0
##   [5] farver_2.1.2                rmarkdown_2.30
##   [7] fs_1.6.6                    vctrs_0.6.5
##   [9] memoise_2.0.1               ggtree_4.0.0
##  [11] rstatix_0.7.3               tinytex_0.57
##  [13] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [15] curl_7.0.0                  broom_1.0.10
##  [17] SparseArray_1.10.0          Formula_1.2-5
##  [19] gridGraphics_0.5-1          sass_0.4.10
##  [21] bslib_0.9.0                 htmlwidgets_1.6.4
##  [23] HGNChelper_0.8.15           plyr_1.8.9
##  [25] httr2_1.2.1                 plotly_4.11.0
##  [27] cachem_1.1.0                lifecycle_1.0.4
##  [29] pkgconfig_2.0.3             Matrix_1.7-4
##  [31] R6_2.6.1                    fastmap_1.2.0
##  [33] MatrixGenerics_1.22.0       digest_0.6.37
##  [35] aplot_0.2.9                 patchwork_1.3.2
##  [37] AnnotationDbi_1.72.0        S4Vectors_0.48.0
##  [39] grr_0.9.5                   GenomicRanges_1.62.0
##  [41] RSQLite_2.4.3               ggpubr_0.6.2
##  [43] filelock_1.0.3              labeling_0.4.3
##  [45] httr_1.4.7                  abind_1.4-8
##  [47] compiler_4.5.1              bit64_4.6.0-1
##  [49] fontquiver_0.2.1            withr_3.0.2
##  [51] S7_0.2.0                    backports_1.5.0
##  [53] BiocParallel_1.44.0         orthogene_1.16.0
##  [55] carData_3.0-5               DBI_1.2.3
##  [57] homologene_1.4.68.19.3.27   ggsignif_0.6.4
##  [59] rappdirs_0.3.3              DelayedArray_0.36.0
##  [61] tools_4.5.1                 splitstackshape_1.4.8
##  [63] ape_5.8-1                   glue_1.8.0
##  [65] nlme_3.1-168                grid_4.5.1
##  [67] reshape2_1.4.4              gtable_0.3.6
##  [69] tidyr_1.3.1                 data.table_1.17.8
##  [71] car_3.1-3                   XVector_0.50.0
##  [73] BiocVersion_3.22.0          pillar_1.11.1
##  [75] stringr_1.5.2               yulab.utils_0.2.1
##  [77] babelgene_22.9              limma_3.66.0
##  [79] dplyr_1.1.4                 treeio_1.34.0
##  [81] lattice_0.22-7              bit_4.6.0
##  [83] tidyselect_1.2.1            fontLiberation_0.1.0
##  [85] SingleCellExperiment_1.32.0 Biostrings_2.78.0
##  [87] knitr_1.50                  fontBitstreamVera_0.1.1
##  [89] bookdown_0.45               IRanges_2.44.0
##  [91] Seqinfo_1.0.0               SummarizedExperiment_1.40.0
##  [93] stats4_4.5.1                xfun_0.53
##  [95] Biobase_2.70.0              statmod_1.5.1
##  [97] matrixStats_1.5.0           stringi_1.8.7
##  [99] lazyeval_0.2.2              ggfun_0.2.0
## [101] yaml_2.3.10                 codetools_0.2-20
## [103] evaluate_1.0.5              gdtools_0.4.4
## [105] tibble_3.3.0                BiocManager_1.30.26
## [107] ggplotify_0.1.3             cli_3.6.5
## [109] systemfonts_1.3.1           jquerylib_0.1.4
## [111] dichromat_2.0-0.1           Rcpp_1.1.0
## [113] gprofiler2_0.2.3            png_0.1-8
## [115] parallel_4.5.1              ggplot2_4.0.0
## [117] blob_1.2.4                  viridisLite_0.4.2
## [119] tidytree_0.4.6              ggiraph_0.9.2
## [121] scales_1.4.0                purrr_1.1.0
## [123] crayon_1.5.3                rlang_1.1.6
## [125] KEGGREST_1.50.0
```

# 6 References