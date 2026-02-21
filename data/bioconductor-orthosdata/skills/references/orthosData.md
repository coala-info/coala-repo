# The orthosData package

Panagiotis Papasaikas1,2\*, Charlotte Soneson1,2\*\* and Michael Stadler1,2\*\*\*

1Friedrich Miescher Institute for Biomedical Research, Basel, Switzerland
2SIB Swiss Institute of Bioinformatics

\*panagiotis.papasaikas@fmi.ch
\*\*charlotte.soneson@fmi.ch
\*\*\*michael.stadler@fmi.ch

#### 4 November 2025

#### Package

orthosData 1.8.0

# 1 Introduction

`orthosData` is the companion database to the `orthos` software for mechanistic studies
using differential gene expression experiments.

It currently encompasses data for over 100,000 differential gene expression mouse and human
experiments distilled and compiled from the [ARCHS4](https://maayanlab.cloud/archs4/)
database (Lachmann et al., 2018) of uniformly processed RNAseq experiments as well as associated pre-trained variational models.

Together with `orthos` it was developed to provide a better understanding of the effects
of experimental treatments on gene expression and to help map treatments to mechanisms of action.

This vignette provides information on the `orhosData` functions for retrieval from `ExperimentHub`
and local caching of the models and datasets used internally in `orthos`.

For more information on usage of these models and datasets for analysis purposes please refer to
the `orthos` package documentation.

# 2 Installation and overview

`orthosData` is automatically installed as a dependency during `orthos` installation.
`orthosData` can also be installed independently from Bioconductor using `BiocManager::install()`:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("orthosData")
# or also...
BiocManager::install("orthosData", dependencies = TRUE)
```

After installation, the package can be loaded with:

```
library(orthosData)
```

# 3 Caching orthosData models with `GetorthosModels()`

`GetorthosModels()` is the function for local caching of orthosData Keras models for a given organism.

These are the models required to perform inference in `orthos`.

For each organism they are of three types:

* **ContextEncoder**: The encoder component of a context Variational Autoencoder (VAE).
  Used to produce a latent encoding of a given gene expression profile (i.e context).

  + Input is a gene expression matrix (shape= M x N , where M is the number of condition and N is the number
    of `orthos` gene features) in the form of log2-transformed library normalized counts (log2 counts per million, log2CPMs).
  + Output is an M x d (where d=64) latent representation of the context.
* **DeltaEncoder**: The encoder component of a contrast conditional Variational Autoencoder (cVAE).
  Used to produce a latent encoding of a contrast between two conditions (i.e delta).

  + Input is a matrix of gene expression contrasts (shape= M x N ) in the form of gene log2 CPM ratios (log2 fold changes, log2FCs),
    concatenated with the corresponding context encoding.
  + Output is an M x d (where d=512) latent representation of the contrast, conditioned on the context.
* **DeltaDecoder**: The decoder component of the same cVAE as above. Used to produce the decoded version
  of the contrast between two conditions.

  + Input is the concatenated matrix (shape= M x (N+d) ) of the delta and context latent encodings.
  + Output is the decoded contrast matrix (shape= M x N), conditioned on the context.

For more details on model architecture and use of these models in `orthos` please refer to
the `orthos` package vignette.

When called for a specific organism, `GetorthosModels()` downloads the corresponding set of models
required for inference from `ExperimentHub` and caches them in the user ExperimentHub directory
(see `ExperimentHub::getExperimentHubOption("CACHE")`)

```
# Check the path to the user's ExperimentHub directory:
ExperimentHub::getExperimentHubOption("CACHE")
# Download and cache the models for a specific organism:
GetorthosModels(organism = "Mouse")
```

# 4 Cache an orthosData contrast DB with `GetorthosContrastDB()`

The orthosData contrast database contains differential gene expression experiments
compiled from the ARCHS4 database of publicly available expression data.
Each entry in the database corresponds to a pair of RNAseq samples contrasting a treatment versus a control condition.
A combination of metadata-semantic and quantitative analyses was used to
determine the proper assignment of samples to such pairs in `orthosData`.

The database includes assays with the original contrasts in the form of gene expression log2 CPM ratios (i.e log2 fold changes, log2FCs), precalculated, decoded and residual components of those contrasts using the orthosData models as well as
the gene expression context of those contrasts in the form of log2-transformed library normalized counts (i.e log2 counts per million, log2CPMs).
It also contains extensive annotation on both the `orthos` feature genes and the contrasted conditions.

For each organism the DB has been compiled as an HDF5SummarizedExperiment with an HDF5 component that contains the gene assays
and an rds component that contains gene annotation in the rowData and the contrast annotation in the colData.

Note that because of the way that HDF5 datasets and serialized SummarizedExperiments are linked
in an HDF5SummarizedExperiment, the two components -although relocatable- need to have the exact same filenames
as those used at creation time (see HDF5Array::saveHDF5SummarizedExperiment).
In other words the files can be moved (or copied) to a different directory or to a different machine and they
will retain functionality as long as both live in the same directory and are never renamed.

When `GetorthosContrastDB()` is called for a specific organism the corresponding HDF5SummarizedExperiment is downloaded from
`ExperimentHub` and cached in the user ExperimentHub directory
(see `ExperimentHub::getExperimentHubOption("CACHE")`).

```
# Check the path to the user's ExperimentHub directory:
ExperimentHub::getExperimentHubOption("CACHE")

# Download and cache the contrast database for a specific organism.
# Note: mode="DEMO" caches a small "toy" database for the queries for demonstration purposes
# To download the full db use mode = "ANALYSIS" (this is time and space consuming)
GetorthosContrastDB(organism = "Mouse", mode="DEMO")

# Load the HDF5SummarizedExperiment:
se <- HDF5Array::loadHDF5SummarizedExperiment(dir = ExperimentHub::getExperimentHubOption("CACHE"),
prefix = "mouse_v212_NDF_c100_DEMO")
```

# Session information

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
#> [1] orthosData_1.8.0 knitr_1.50       BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] SummarizedExperiment_1.40.0 KEGGREST_1.50.0
#>  [3] xfun_0.54                   bslib_0.9.0
#>  [5] httr2_1.2.1                 rhdf5_2.54.0
#>  [7] Biobase_2.70.0              lattice_0.22-7
#>  [9] rhdf5filters_1.22.0         vctrs_0.6.5
#> [11] tools_4.5.1                 generics_0.1.4
#> [13] stats4_4.5.1                curl_7.0.0
#> [15] tibble_3.3.0                AnnotationDbi_1.72.0
#> [17] RSQLite_2.4.3               blob_1.2.4
#> [19] pkgconfig_2.0.3             Matrix_1.7-4
#> [21] dbplyr_2.5.1                S4Vectors_0.48.0
#> [23] lifecycle_1.0.4             stringr_1.5.2
#> [25] compiler_4.5.1              Biostrings_2.78.0
#> [27] fontawesome_0.5.3           Seqinfo_1.0.0
#> [29] htmltools_0.5.8.1           sass_0.4.10
#> [31] yaml_2.3.10                 pillar_1.11.1
#> [33] crayon_1.5.3                jquerylib_0.1.4
#> [35] DelayedArray_0.36.0         cachem_1.1.0
#> [37] abind_1.4-8                 ExperimentHub_3.0.0
#> [39] AnnotationHub_4.0.0         tidyselect_1.2.1
#> [41] digest_0.6.37               stringi_1.8.7
#> [43] dplyr_1.1.4                 bookdown_0.45
#> [45] BiocVersion_3.22.0          fastmap_1.2.0
#> [47] grid_4.5.1                  cli_3.6.5
#> [49] SparseArray_1.10.1          magrittr_2.0.4
#> [51] S4Arrays_1.10.0             h5mread_1.2.0
#> [53] filelock_1.0.3              rappdirs_0.3.3
#> [55] bit64_4.6.0-1               rmarkdown_2.30
#> [57] XVector_0.50.0              httr_1.4.7
#> [59] matrixStats_1.5.0           bit_4.6.0
#> [61] png_0.1-8                   memoise_2.0.1
#> [63] HDF5Array_1.38.0            evaluate_1.0.5
#> [65] GenomicRanges_1.62.0        IRanges_2.44.0
#> [67] BiocFileCache_3.0.0         rlang_1.1.6
#> [69] glue_1.8.0                  DBI_1.2.3
#> [71] BiocManager_1.30.26         BiocGenerics_0.56.0
#> [73] jsonlite_2.0.0              Rhdf5lib_1.32.0
#> [75] R6_2.6.1                    MatrixGenerics_1.22.0
```

# 5 References

# Appendix

1. Lachmann, Alexander, et al. “Massive mining of publicly available RNA-seq data from human and mouse.” Nature communications 9.1 (2018): 1366