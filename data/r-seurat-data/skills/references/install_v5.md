Toggle navigation

[Seurat](/seurat/)
5.2.0

* [Install](/seurat/articles/install_v5)
* [Get started](/seurat/articles/get_started_v5_new)
* Vignettes
  + Introductory Vignettes
  + [PBMC 3K guided tutorial](/seurat/articles/pbmc3k_tutorial)
  + [Data visualization vignette](/seurat/articles/visualization_vignette)
  + [SCTransform, v2 regularization](/seurat/articles/sctransform_vignette)
  + [Using Seurat with multi-modal data](/seurat/articles/multimodal_vignette)
  + [Seurat v5 Command Cheat Sheet](/seurat/articles/essential_commands)
  + Data Integration
  + [Introduction to scRNA-seq integration](/seurat/articles/integration_introduction)
  + [Integrative analysis in Seurat v5](/seurat/articles/seurat5_integration)
  + [Mapping and annotating query datasets](/seurat/articles/integration_mapping)
  + Multi-assay data
  + [Dictionary Learning for cross-modality integration](/seurat/articles/seurat5_integration_bridge)
  + [Weighted Nearest Neighbor Analysis](/seurat/articles/weighted_nearest_neighbor_analysis)
  + [Integrating scRNA-seq and scATAC-seq data](/seurat/articles/seurat5_atacseq_integration_vignette)
  + [Multimodal reference mapping](/seurat/articles/multimodal_reference_mapping)
  + [Mixscape Vignette](/seurat/articles/mixscape_vignette)
  + Massively scalable analysis
  + [Sketch-based analysis in Seurat v5](/seurat/articles/seurat5_sketch_analysis)
  + [Sketch integration using a 1 million cell dataset from Parse Biosciences](/seurat/articles/parsebio_sketch_integration)
  + [Map COVID PBMC datasets to a healthy reference](/seurat/articles/covid_sctmapping)
  + [BPCells Interaction](/seurat/articles/seurat5_bpcells_interaction_vignette)
  + Spatial analysis
  + [Analysis of spatial datasets (Imaging-based)](/seurat/articles/seurat5_spatial_vignette_2)
  + [Analysis of spatial datasets (Sequencing-based)](/seurat/articles/spatial_vignette)
  + [Analysis of Visium HD spatial datasets](../articles/visiumhd_analysis_vignette)
  + Other
  + [Cell-cycle scoring and regression](/seurat/articles/cell_cycle_vignette)
  + [Differential expression testing](/seurat/articles/de_vignette)
  + [Demultiplexing with hashtag oligos (HTOs)](/seurat/articles/hashing_vignette)
* [Extensions](/seurat/articles/extensions)
* [FAQ](https://github.com/satijalab/seurat/discussions)
* [News](/seurat/articles/announcements)
* [Reference](/seurat/reference/)
* [Archive](/seurat/articles/archive)

# Installation Instructions for Seurat

Source: [`vignettes/install_v5.Rmd`](https://github.com/satijalab/seurat/blob/HEAD/vignettes/install_v5.Rmd)

`install_v5.Rmd`

To install Seurat, [R](https://www.r-project.org/) version 4.0 or greater is required. We also recommend installing [R Studio](https://www.rstudio.com/).

## ![Seurat v5:](../output/images/SeuratV5.png) Seurat 5: Install from CRAN

Seurat is available on [CRAN](https://cran.r-project.org/package%3DSeurat) for all platforms. To install, run:

```
# Enter commands in R (or R studio, if installed)
install.packages('Seurat')
library(Seurat)
```

Seurat does not require, but makes use of, packages developed by other labs that can substantially enhance speed and performance. These include [presto](https://github.com/immunogenomics/presto) (Korunsky/Raychaudhari labs), [BPCells](https://github.com/bnprks/BPCells) (Greenleaf Lab), and [glmGamPoi](https://github.com/const-ae/glmGamPoi) (Huber Lab). We recommend users install these along with Seurat:

```
setRepositories(ind = 1:3, addURLs = c('https://satijalab.r-universe.dev', 'https://bnprks.r-universe.dev/'))
install.packages(c("BPCells", "presto", "glmGamPoi"))
```

We also recommend installing these additional packages, which are used in our vignettes, and enhance the functionality of Seurat:

* [Signac](https://github.com/stuart-lab/signac): analysis of single-cell chromatin data
* [SeuratData](https://github.com/satijalab/seurat-data): automatically load datasets pre-packaged as Seurat objects
* [Azimuth](https://github.com/satijalab/azimuth): local annotation of scRNA-seq and scATAC-seq queries across multiple organs and tissues
* [SeuratWrappers](https://github.com/satijalab/seurat-wrappers): enables use of additional integration and differential expression methods

```
# Install the remotes package
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}
install.packages('Signac')
remotes::install_github("satijalab/seurat-data", quiet = TRUE)
remotes::install_github("satijalab/azimuth", quiet = TRUE)
remotes::install_github("satijalab/seurat-wrappers", quiet = TRUE)
```

## Install previous versions of Seurat

### Install Seurat v4

Seurat v4.4.0 can be installed with the following commands:

```
remotes::install_version("SeuratObject", "4.1.4", repos = c("https://satijalab.r-universe.dev", getOption("repos")))
remotes::install_version("Seurat", "4.4.0", repos = c("https://satijalab.r-universe.dev", getOption("repos")))
```

### Older versions of Seurat

Old versions of Seurat, from Seurat v2.0.1 and up, are hosted in CRAN’s archive. To install an old version of Seurat, run:

```
# Install the remotes package
install.packages('remotes')
# Replace 'X.X.X' with your desired version
remotes::install_version(package = 'Seurat', version = package_version('X.X.X'))
```

For versions of Seurat older than those not hosted on CRAN (versions 1.3.0 and 1.4.0), please download the packaged source code from our [releases page](https://github.com/satijalab/seurat/releases) and [install from the tarball](https://stackoverflow.com/questions/4739837/how-do-i-install-an-r-package-from-the-source-tarball-on-windows).

## Install the development version of Seurat

Install the development version of Seurat - directly from [GitHub](https://github.com/satijalab/seurat/tree/develop).

```
# Enter commands in R (or R studio, if installed)
# Install the remotes package
install.packages('remotes')
remotes::install_github(repo = 'satijalab/seurat', ref = 'develop')
library(Seurat)
```

## Docker

We provide docker images for Seurat via [dockerhub](https://hub.docker.com/r/satijalab/seurat).

To pull the latest image from the command line:

```
docker pull satijalab/seurat:latest
```

To use as a base image in a new Dockerfile:

```
FROM satijalab/seurat:latest
```

## Contents

Developed by Rahul Satija, Satija Lab and Collaborators.

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.0.7.