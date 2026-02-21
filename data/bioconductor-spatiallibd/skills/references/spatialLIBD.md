# Introduction to spatialLIBD

Leonardo Collado-Torres1,2\*, Kristen R. Maynard1\*\* and Andrew E. Jaffe1\*\*\*

1Lieber Institute for Brain Development, Johns Hopkins Medical Campus
2Center for Computational Biology, Johns Hopkins University

\*lcolladotor@gmail.com
\*\*Kristen.Maynard@libd.org
\*\*\*andrew.jaffe@libd.org

#### 4 November 2025

#### Package

spatialLIBD 1.22.0

# Contents

* [1 Welcome](#welcome)
  + [1.1 Study design](#study-design)
  + [1.2 Shiny website mirrors](#shiny-website-mirrors)
* [2 Basics](#basics)
  + [2.1 Install `spatialLIBD`](#install-spatiallibd)
  + [2.2 Required knowledge](#required-knowledge)
  + [2.3 Asking for help](#asking-for-help)
  + [2.4 Citing `spatialLIBD`](#citing-spatiallibd)
* [3 Overview](#overview)
* [4 Human DLPFC Visium dataset](#human-dlpfc-visium-dataset)
  + [4.1 Data specifics](#data-specifics)
  + [4.2 Downloading the data with `spatialLIBD`](#downloading-the-data-with-spatiallibd)
* [5 Interactively explore the `spatialLIBD` data](#interactively-explore-the-spatiallibd-data)
* [6 `spatialLIBD` functions](#spatiallibd-functions)
  + [6.1 Spot-level clusters and discrete variables](#spot-level-clusters-and-discrete-variables)
  + [6.2 Spot-level genes and continuous variables](#spot-level-genes-and-continuous-variables)
  + [6.3 Extract significant genes](#extract-significant-genes)
  + [6.4 Visualize modeling results](#visualize-modeling-results)
  + [6.5 Correlation of layer-level statistics](#correlation-of-layer-level-statistics)
  + [6.6 Gene set enrichment](#gene-set-enrichment)
* [7 Re-shaping your data to our structure](#re-shaping-your-data-to-our-structure)
  + [7.1 SpatialExperiment support](#spatialexperiment-support)
  + [7.2 Using spatialLIBD with your own data](#using-spatiallibd-with-your-own-data)
  + [7.3 Expected characteristics of the data](#expected-characteristics-of-the-data)
  + [7.4 Generating our data (legacy)](#generating-our-data-legacy)
* [8 More spatially-resolved LIBD datasets](#more-spatially-resolved-libd-datasets)
  + [8.1 spatialDLPFC](#spatialdlpfc)
  + [8.2 Visium\_SPG\_AD](#visium_spg_ad)
  + [8.3 LIBD data outside `spatialLIBD`](#libd-data-outside-spatiallibd)
    - [8.3.1 locus-c](#locus-c)
* [9 Reproducibility](#reproducibility)
* [10 Bibliography](#bibliography)

# 1 Welcome

Welcome to the `spatialLIBD` project! It is composed of:

* a [shiny](https://shiny.rstudio.com/) web application that we are hosting at [spatial.libd.org/spatialLIBD/](http://spatial.libd.org/spatialLIBD/) that can handle a [limited](https://github.com/LieberInstitute/spatialLIBD/issues/2) set of concurrent users,
* a Bioconductor package at [bioconductor.org/packages/spatialLIBD](http://bioconductor.org/packages/spatialLIBD) (or from [here](http://research.libd.org/spatialLIBD/)) that lets you analyze the data and run a local version of our web application (with our data or yours),
* and a [research article](https://doi.org/10.1038/s41593-020-00787-0) with the scientific knowledge we drew from this dataset. The analysis code for our project is available [here](https://github.com/LieberInstitute/HumanPilot/) and the high quality figures for the manuscript are available through [Figshare](https://doi.org/10.6084/m9.figshare.13623902.v1).

The web application allows you to browse the LIBD human dorsolateral pre-frontal cortex (DLPFC) spatial transcriptomics data generated with the 10x Genomics Visium platform. Through the [R/Bioconductor package](https://bioconductor.org/packages/spatialLIBD) you can also download the data as well as visualize your own datasets using this web application. Please check the [manuscript](https://doi.org/10.1038/s41593-020-00787-0) or [bioRxiv pre-print](https://www.biorxiv.org/content/10.1101/2020.02.28.969931v1) for more details about this project.

If you tweet about this website, the data or the R package please use the `#spatialLIBD` hashtag. You can find previous tweets that way as shown [here](https://twitter.com/search?q=%23spatialLIBD&src=typed_query). Thank you!

## 1.1 Study design

As a quick overview, the data presented here is from portion of the DLPFC that spans six neuronal layers plus white matter (**A**) for a total of three subjects with two pairs of spatially adjacent replicates (**B**). Each dissection of DLPFC was designed to span all six layers plus white matter (**C**). Using this web application you can explore the expression of known genes such as *SNAP25* (**D**, a neuronal gene), *MOBP* (**E**, an oligodendrocyte gene), and known layer markers from mouse studies such as *PCP4* (**F**, a known layer 5 marker gene).

![](data:image/jpeg;base64...)

## 1.2 Shiny website mirrors

* [Main shiny application website](http://spatial.libd.org/spatialLIBD)
* [Shinyapps](https://libd.shinyapps.io/spatialLIBD/)

# 2 Basics

## 2.1 Install `spatialLIBD`

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages. *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* is a `R` package available via Bioconductor. `R` can be installed on any operating system from [CRAN](https://cran.r-project.org/) after which you can install *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("spatialLIBD")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

To run all the code in this vignette, you might need to install other R/Bioconductor packages, which you can do with:

```
BiocManager::install("spatialLIBD", dependencies = TRUE, force = TRUE)
```

If you want to use the development version of `spatialLIBD`, you will need to use the R version corresponding to the current Bioconductor-devel branch as described in more detail on the [Bioconductor website](http://bioconductor.org/developers/how-to/useDevel/). Then you can install `spatialLIBD` from GitHub using the following command.

```
BiocManager::install("LieberInstitute/spatialLIBD")
```

## 2.2 Required knowledge

*[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* (Pardo, Spangler, Weber et al., 2022) is based on many other packages and in particular in those that have implemented the infrastructure needed for dealing with single cell RNA sequencing data, visualization functions, and interactive data exploration. That is, packages like *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* that allow you to store the data, *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* and *[plotly](https://CRAN.R-project.org/package%3Dplotly)* for visualizing the data, and *[shiny](https://CRAN.R-project.org/package%3Dshiny)* for building an interactive interface. A *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* user who only accesses the web application is not expected to deal with those packages directly. A *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* user will need to be familiar with *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* and *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* to understand the data provided by *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* or the graphical results *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* provides. Furthermore, it’ll be useful for the user to know about *[shiny](https://CRAN.R-project.org/package%3Dshiny)* and *[plotly](https://CRAN.R-project.org/package%3Dplotly)* if you wish to adapt the web application provided by *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)*.

If you are asking yourself the question “Where do I start using Bioconductor?” you might be interested in [this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).

## 2.3 Asking for help

As package developers, we try to explain clearly how to use our packages and in which order to use the functions. But `R` and `Bioconductor` have a steep learning curve so it is critical to learn where to ask for help. The blog post quoted above mentions some but we would like to highlight the [Bioconductor support site](https://support.bioconductor.org/) as the main resource for getting help regarding Bioconductor. Other alternatives are available such as creating GitHub issues and tweeting. However, please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

## 2.4 Citing `spatialLIBD`

We hope that *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* will be useful for your research. Please use the following information to cite the package and the research article describing the data provided by *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)*. Thank you!

```
## Citation info
citation("spatialLIBD")
#> To cite package 'spatialLIBD' in publications use:
#>
#>   Pardo B, Spangler A, Weber LM, Hicks SC, Jaffe AE, Martinowich K, Maynard KR, Collado-Torres L (2022).
#>   "spatialLIBD: an R/Bioconductor package to visualize spatially-resolved transcriptomics data." _BMC
#>   Genomics_. doi:10.1186/s12864-022-08601-w <https://doi.org/10.1186/s12864-022-08601-w>,
#>   <https://doi.org/10.1186/s12864-022-08601-w>.
#>
#>   Maynard KR, Collado-Torres L, Weber LM, Uytingco C, Barry BK, Williams SR, II JLC, Tran MN, Besich Z,
#>   Tippani M, Chew J, Yin Y, Kleinman JE, Hyde TM, Rao N, Hicks SC, Martinowich K, Jaffe AE (2021).
#>   "Transcriptome-scale spatial gene expression in the human dorsolateral prefrontal cortex." _Nature
#>   Neuroscience_. doi:10.1038/s41593-020-00787-0 <https://doi.org/10.1038/s41593-020-00787-0>,
#>   <https://www.nature.com/articles/s41593-020-00787-0>.
#>
#>   Huuki-Myers LA, Spangler A, Eagles NJ, Montgomergy KD, Kwon SH, Guo B, Grant-Peters M, Divecha HR,
#>   Tippani M, Sriworarat C, Nguyen AB, Ravichandran P, Tran MN, Seyedian A, Consortium P, Hyde TM, Kleinman
#>   JE, Battle A, Page SC, Ryten M, Hicks SC, Martinowich K, Collado-Torres L, Maynard KR (2024). "A
#>   data-driven single-cell and spatial transcriptomic map of the human prefrontal cortex." _Science_.
#>   doi:10.1126/science.adh1938 <https://doi.org/10.1126/science.adh1938>,
#>   <https://doi.org/10.1126/science.adh1938>.
#>
#>   Kwon SH, Parthiban S, Tippani M, Divecha HR, Eagles NJ, Lobana JS, Williams SR, Mark M, Bharadwaj RA,
#>   Kleinman JE, Hyde TM, Page SC, Hicks SC, Martinowich K, Maynard KR, Collado-Torres L (2023). "Influence
#>   of Alzheimer’s disease related neuropathology on local microenvironment gene expression in the human
#>   inferior temporal cortex." _GEN Biotechnology_. doi:10.1089/genbio.2023.0019
#>   <https://doi.org/10.1089/genbio.2023.0019>, <https://doi.org/10.1089/genbio.2023.0019>.
#>
#> To see these entries in BibTeX format, use 'print(<citation>, bibtex=TRUE)', 'toBibtex(.)', or set
#> 'options(citation.bibtex.max=999)'.
```

# 3 Overview

The *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* (Pardo, Spangler, Weber et al., 2022) package was developed for analyzing the human dorsolateral prefrontal cortex (DLPFC) spatial transcriptomics data generated with the 10x Genomics Visium technology by researchers at the Lieber Institute for Brain Development (LIBD) (Maynard, Collado-Torres, Weber et al., 2021). An initial *[shiny](https://CRAN.R-project.org/package%3Dshiny)* application was developed for interactively exploring this data and for assigning human brain layer labels to the each spot for each sample generated. While this was useful enough for our project, we made this [Bioconductor](http://bioconductor.org/) package in case you want to:

* access our Visium data to get some data from this new technology and develop methods or infrastructure for other Visium datasets.
* re-shape your data into what ours is structured as, then re-use the visualization functions and/or the shiny app itself.
* want to explore our data in more detail. This can range from launching the *[shiny](https://CRAN.R-project.org/package%3Dshiny)* application locally to diving into the specifics of the data from our project (Maynard, Collado-Torres, Weber et al., 2021).

In this vignette we’ll showcase how you can access the Human DLPFC LIBD Visium dataset (Maynard, Collado-Torres, Weber et al., 2021), the R functions provided by *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* (Pardo, Spangler, Weber et al., 2022), and an overview of how you can re-shape your own Visium dataset to match the structure we used.

To get started, please load the *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* package.

```
library("spatialLIBD")
```

# 4 Human DLPFC Visium dataset

The human DLPFC 10x Genomics Visium dataset analyzed by LIBD researchers and colleagues is described in detail by Maynard, Collado-Torres et al (Maynard, Collado-Torres, Weber et al., 2021). However, briefly, this dataset is composed of:

* Three brain subjects (all controls; two males, one female; ages 30-46; [details](https://github.com/LieberInstitute/HumanPilot/blob/master/Analysis/visium_dlpfc_pilot_sample_metrics.tsv)).
* Four images per subject: two spatially adjacent replicates at position 0, then two more spatially adjacent replicates 300 micrometers away.
* Slices designed to cover layers 1 through 6 and the white matter (WM) of the dorsolateral prefrontal cortex (DLPFC).

## 4.1 Data specifics

We combined all the Visium data into a single *[SpatialExperiment](https://bioconductor.org/packages/3.22/SpatialExperiment)* (Righelli, Weber, Crowell et al., 2022) object that we typically refer to as **`spe`** 111 Check [this code](https://github.com/LieberInstitute/HumanPilot/tree/master/Analysis) for details on how we built the `spe` object. In particular check `convert_sce.R` and `sce_scran.R`.. It has 33,538 genes (rows) and 47,681 spots (columns). This is the initial point for most of our analyses ([code available on GitHub](https://github.com/LieberInstitute/HumanPilot)). Using *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* (Pardo, Spangler, Weber et al., 2022) we manually assigned each spot across all 12 images to a layer (L1 through L6 or WM). We then compressed the spot-level data at the layer-level using a pseudo-bulking approach resulting in the *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* object we typically refer to as **`sce_layer`** 222 Check [this code](https://github.com/LieberInstitute/HumanPilot/tree/master/Analysis/Layer_Guesses) for details on how we built the `sce_layer` object. In particular check `spots_per_layer.R` and `layer_enrichment.R`.. We then computed for each gene t or F statistics assessing whether the gene had higher expression in a given layer compared to the rest (`enrichment`; t-stat), between one layer and another layer (`pairwise`; t-stat), or had any expression variability across all layers (`anova`; F-stat). The results from the models are stored in what we refer to as **`modeling_results`** 333 Check [this code](https://github.com/LieberInstitute/HumanPilot/tree/master/Analysis/Layer_Guesses) for details on how we built the `modeling_results` object. In particular check `layer_specificity_fstats.R`, `layer_specificity.R`, and `misc_numbers.R`..

In summary,

* `spe` is the *[SpatialExperiment](https://bioconductor.org/packages/3.22/SpatialExperiment)* object with all the spot-level data and the histology information for visualization of the data.
* `sce_layer` is the *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* object with the layer-level data.
* `modeling_results` contains the layer-level `enrichment`, `pairwise` and `anova` statistics.

## 4.2 Downloading the data with `spatialLIBD`

Using *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* (Pardo, Spangler, Weber et al., 2022) you can download all of these R objects. They are hosted by [Bioconductor](http://bioconductor.org/)’s *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)* (Morgan and Shepherd, 2025) resource and you can download them using `spatialLIBD::fetch_data()`. `fetch_data()` will query *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)* which in turn will download the data and cache it so you don’t have to download it again. If *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)* is unavailable, then `fetch_data()` has a backup option that does not cache the files 444 You can change the `destdir` argument and specific a specific location that you will use and re-use. However the default value of `destdir` is a temporary directory that will be wiped out once you close your R session. Below we obtain all of these objects.

```
## Connect to ExperimentHub
ehub <- ExperimentHub::ExperimentHub()
```

```
## Download the small example sce data
sce <- fetch_data(type = "sce_example", eh = ehub)
#> 2025-11-04 11:48:40.060477 loading file /home/biocbuild/.cache/R/BiocFileCache/195c817c6b539a_sce_sub_for_vignette.Rdata%3Fdl%3D1

## Convert to a SpatialExperiment object
spe <- sce_to_spe(sce)

## If you want to download the full real data (about 2.1 GB in RAM) use:
if (FALSE) {
    if (!exists("spe")) spe <- fetch_data(type = "spe", eh = ehub)
}

## Query ExperimentHub and download the data
if (!exists("sce_layer")) sce_layer <- fetch_data(type = "sce_layer", eh = ehub)
modeling_results <- fetch_data("modeling_results", eh = ehub)
#> 2025-11-04 11:48:44.585086 loading file /home/biocbuild/.cache/R/BiocFileCache/195c812bb20746_Human_DLPFC_Visium_modeling_results.Rdata%3Fdl%3D1
```

Once you have downloaded the objects, we can explore them a little bit

```
## spot-level data
spe
#> class: SpatialExperiment
#> dim: 33538 47681
#> metadata(0):
#> assays(2): counts logcounts
#> rownames(33538): ENSG00000243485 ENSG00000237613 ... ENSG00000277475 ENSG00000268674
#> rowData names(9): source type ... gene_search is_top_hvg
#> colnames(47681): AAACAACGAATAGTTC-1 AAACAAGTATCTCCCA-1 ... TTGTTTCCATACAACT-1 TTGTTTGTGTAAATTC-1
#> colData names(69): sample_id Cluster ... array_row array_col
#> reducedDimNames(6): PCA TSNE_perplexity50 ... TSNE_perplexity80 UMAP_neighbors15
#> mainExpName: NULL
#> altExpNames(0):
#> spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
#> imgData names(4): sample_id image_id data scaleFactor

## layer-level data
sce_layer
#> class: SingleCellExperiment
#> dim: 22331 76
#> metadata(0):
#> assays(2): counts logcounts
#> rownames(22331): ENSG00000243485 ENSG00000238009 ... ENSG00000278384 ENSG00000271254
#> rowData names(10): source type ... is_top_hvg is_top_hvg_sce_layer
#> colnames(76): 151507_Layer1 151507_Layer2 ... 151676_Layer6 151676_WM
#> colData names(13): sample_name layer_guess ... layer_guess_reordered_short spatialLIBD
#> reducedDimNames(6): PCA TSNE_perplexity5 ... UMAP_neighbors15 PCAsub
#> mainExpName: NULL
#> altExpNames(0):

## list of modeling result tables
sapply(modeling_results, class)
#>        anova   enrichment     pairwise
#> "data.frame" "data.frame" "data.frame"
sapply(modeling_results, dim)
#>      anova enrichment pairwise
#> [1,] 22331      22331    22331
#> [2,]    10         23       65
sapply(modeling_results, function(x) {
    head(colnames(x))
})
#>      anova          enrichment      pairwise
#> [1,] "f_stat_full"  "t_stat_WM"     "t_stat_WM-Layer1"
#> [2,] "p_value_full" "t_stat_Layer1" "t_stat_WM-Layer2"
#> [3,] "fdr_full"     "t_stat_Layer2" "t_stat_WM-Layer3"
#> [4,] "full_AveExpr" "t_stat_Layer3" "t_stat_WM-Layer4"
#> [5,] "f_stat_noWM"  "t_stat_Layer4" "t_stat_WM-Layer5"
#> [6,] "p_value_noWM" "t_stat_Layer5" "t_stat_WM-Layer6"
```

The modeling statistics are in wide format, which can make some visualizations complicated. The function `sig_genes_extract_all()` provides a way to convert them into long format and add some useful information. Let’s do so below.

```
## Convert to a long format the modeling results
## This takes a few seconds to run
system.time(
    sig_genes <-
        sig_genes_extract_all(
            n = nrow(sce_layer),
            modeling_results = modeling_results,
            sce_layer = sce_layer
        )
)
#>    user  system elapsed
#>   6.946   0.417   7.364

## Explore the result
class(sig_genes)
#> [1] "DFrame"
#> attr(,"package")
#> [1] "S4Vectors"
dim(sig_genes)
#> [1] 1138881      12
```

# 5 Interactively explore the `spatialLIBD` data

Now that you have downloaded the data, you can interactively explore the data using a *[shiny](https://CRAN.R-project.org/package%3Dshiny)* (Chang, Cheng, Allaire, Sievert, Schloerke, Xie, Allen, McPherson, Dipert, and Borges, 2025) web application contained within *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* (Pardo, Spangler, Weber et al., 2022). To do so, use the `run_app()` function as shown below:

```
if (interactive()) {
    run_app(
        spe = spe,
        sce_layer = sce_layer,
        modeling_results = modeling_results,
        sig_genes = sig_genes
    )
}
```

The *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* *[shiny](https://CRAN.R-project.org/package%3Dshiny)* application allows you to browse the spot-level data and interactively label spots, as well as explore the layer-level results. Once you launch it, check the *Documentation* tab for each view for more details. In order to avoid duplicating the documentation, we provide all the details on the *[shiny](https://CRAN.R-project.org/package%3Dshiny)* application itself.

Though overall, this application allows you to export all static visualizations as PDF files or all interactive visualizations as PNG files, as well as all result table as CSV files. This is what produces the version you can access without any R use from your side at [spatial.libd.org/spatialLIBD/](http://spatial.libd.org/spatialLIBD/).

# 6 `spatialLIBD` functions

We already covered `fetch_data()` which allows you to download the Human DLPFC Visium data from LIBD researchers and colleagues (Maynard, Collado-Torres, Weber et al., 2021).

## 6.1 Spot-level clusters and discrete variables

With the `spe` object that contains the spot-level data, we can visualize any discrete variable such as the layers using `vis_clus()` and related functions. These functions know where to extract and how to visualize the histology information.

```
## View our LIBD layers for one sample
vis_clus(
    spe = spe,
    clustervar = "layer_guess_reordered",
    sampleid = "151673",
    colors = libd_layer_colors,
    ... = " LIBD Layers"
)
```

![](data:image/png;base64...)

Most of the variables stored in `spe` are discrete variables and as such, you can visualize them using `vis_clus()` and `vis_grid_clus()` for one or more than one sample respectively.

```
## This is not fully precise, but gives you a rough idea
## Some integer columns are actually continuous variables
table(sapply(colData(spe), class) %in% c("factor", "integer"))
#>
#> FALSE  TRUE
#>    12    57

## This is more precise (one cluster has 28 unique values)
table(sapply(colData(spe), function(x) length(unique(x))) < 29)
#>
#> FALSE  TRUE
#>     7    62
```

Notably, `vis_clus()` has a `spatial` `logical(1)` argument which is useful if you want to visualize the data without the histology information provided by `geom_spatial()` (a custom `ggplot2::layer()`). In particular, this is useful if you then want to use `plotly::ggplotly()` or other similar functions on the resulting `ggplot2::ggplot()` object.

```
## View our LIBD layers for one sample
## without spatial information
vis_clus(
    spe = spe,
    clustervar = "layer_guess_reordered",
    sampleid = "151673",
    colors = libd_layer_colors,
    ... = " LIBD Layers",
    spatial = FALSE
)
```

![](data:image/png;base64...)

Some helper functions include `get_colors()` and `sort_clusters()` as well as the `libd_layer_colors` object included in *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* (Pardo, Spangler, Weber et al., 2022).

```
## Color palette designed by Lukas M. Weber with feedback from the team.
libd_layer_colors
#>        Layer1        Layer2        Layer3        Layer4        Layer5        Layer6            WM            NA
#>     "#F0027F"     "#377EB8"     "#4DAF4A"     "#984EA3"     "#FFD700"     "#FF7F00"     "#1A1A1A" "transparent"
#>           WM2
#>     "#666666"
```

## 6.2 Spot-level genes and continuous variables

Similar to `vis_clus()`, the `vis_gene()` family of functions use the `spe` spot-level object to visualize the gene expression or any continuous variable such as the number of cells per spots. That is, `vis_gene()` can visualize any of the `assays(spe)` or any of the continuous variables stored in `colData(spe)`. If you want to visualize more than one sample at a time, use `vis_grid_gene()` instead. And just like `vis_clus()`, `vis_gene()` has a `spatial` `logical(1)` argument to turn off the custom spatial `ggplot2::layer()` produced by `geom_spatial()`.

```
## Available gene expression assays
assayNames(spe)
#> [1] "counts"    "logcounts"

## Not all of these make sense to visualize
## In particular, the key is not useful to visualize.
colnames(colData(spe))
#>  [1] "sample_id"                   "Cluster"                     "sum_umi"
#>  [4] "sum_gene"                    "subject"                     "position"
#>  [7] "replicate"                   "subject_position"            "discard"
#> [10] "key"                         "cell_count"                  "SNN_k50_k4"
#> [13] "SNN_k50_k5"                  "SNN_k50_k6"                  "SNN_k50_k7"
#> [16] "SNN_k50_k8"                  "SNN_k50_k9"                  "SNN_k50_k10"
#> [19] "SNN_k50_k11"                 "SNN_k50_k12"                 "SNN_k50_k13"
#> [22] "SNN_k50_k14"                 "SNN_k50_k15"                 "SNN_k50_k16"
#> [25] "SNN_k50_k17"                 "SNN_k50_k18"                 "SNN_k50_k19"
#> [28] "SNN_k50_k20"                 "SNN_k50_k21"                 "SNN_k50_k22"
#> [31] "SNN_k50_k23"                 "SNN_k50_k24"                 "SNN_k50_k25"
#> [34] "SNN_k50_k26"                 "SNN_k50_k27"                 "SNN_k50_k28"
#> [37] "GraphBased"                  "Maynard"                     "Martinowich"
#> [40] "layer_guess"                 "layer_guess_reordered"       "layer_guess_reordered_short"
#> [43] "expr_chrM"                   "expr_chrM_ratio"             "SpatialDE_PCA"
#> [46] "SpatialDE_pool_PCA"          "HVG_PCA"                     "pseudobulk_PCA"
#> [49] "markers_PCA"                 "SpatialDE_UMAP"              "SpatialDE_pool_UMAP"
#> [52] "HVG_UMAP"                    "pseudobulk_UMAP"             "markers_UMAP"
#> [55] "SpatialDE_PCA_spatial"       "SpatialDE_pool_PCA_spatial"  "HVG_PCA_spatial"
#> [58] "pseudobulk_PCA_spatial"      "markers_PCA_spatial"         "SpatialDE_UMAP_spatial"
#> [61] "SpatialDE_pool_UMAP_spatial" "HVG_UMAP_spatial"            "pseudobulk_UMAP_spatial"
#> [64] "markers_UMAP_spatial"        "spatialLIBD"                 "ManualAnnotation"
#> [67] "in_tissue"                   "array_row"                   "array_col"

## Visualize a gene
vis_gene(
    spe = spe,
    sampleid = "151673",
    viridis = FALSE
)
```

![](data:image/png;base64...)

```
## Visualize the estimated number of cells per spot
vis_gene(
    spe = spe,
    sampleid = "151673",
    geneid = "cell_count"
)
```

![](data:image/png;base64...)

```
## Visualize the fraction of chrM expression per spot
## without the spatial layer
vis_gene(
    spe = spe,
    sampleid = "151673",
    geneid = "expr_chrM_ratio",
    spatial = FALSE
)
```

![](data:image/png;base64...)

As for the color palette, you can either use the color blind friendly palette when `viridis = TRUE` or a custom palette we determined. Note that if you design your own palette, you have to take into account that values it can be hard to distinguish some colors from the histology set of purple tones that are noticeable when the continuous variable is below or equal to the `minCount` (in our palettes such points have a `'transparent'` color). For more details, check the internal code of `vis_gene_p()`.

## 6.3 Extract significant genes

Earlier we also ran `sig_genes_extract_all()` in order to run the *[shiny](https://CRAN.R-project.org/package%3Dshiny)* web application. However, we didn’t explain the output. If you explore it, you’ll notice that it’s a very long table with several columns.

```
head(sig_genes)
#> DataFrame with 6 rows and 12 columns
#>         top  model_type        test        gene      stat        pval         fdr gene_index         ensembl
#>   <integer> <character> <character> <character> <numeric>   <numeric>   <numeric>  <integer>     <character>
#> 1         1  enrichment          WM       NDRG1   16.3053 1.25896e-26 2.51372e-22      10404 ENSG00000104419
#> 2         2  enrichment          WM      PTP4A2   16.1469 2.25133e-26 2.51372e-22        487 ENSG00000184007
#> 3         3  enrichment          WM        AQP1   15.9927 3.97849e-26 2.96145e-22       8201 ENSG00000240583
#> 4         4  enrichment          WM       PAQR6   15.1971 7.86258e-25 4.38948e-21       1501 ENSG00000160781
#> 5         5  enrichment          WM      ANP32B   14.9798 1.80183e-24 8.04735e-21      10962 ENSG00000136938
#> 6         6  enrichment          WM        JAM3   14.7413 4.50756e-24 1.67295e-20      12600 ENSG00000166086
#>             in_rows       in_rows_top20                                     results
#>       <IntegerList>       <IntegerList>                             <CharacterList>
#> 1 1,40215,65023,... 1,156337,223320,... WM_top1,WM-Layer1_top20,WM-Layer4_top10,...
#> 2 2,40531,64532,... 2,223323,245661,... WM_top2,WM-Layer4_top13,WM-Layer5_top20,...
#> 3 3,32241,65062,... 3,223314,245643,...   WM_top3,WM-Layer4_top4,WM-Layer5_top2,...
#> 4 4,34318,65863,...     4,245654,267982     WM_top4,WM-Layer5_top13,WM-Layer6_top10
#> 5 5,28964,63931,...     5,223329,267975      WM_top5,WM-Layer4_top19,WM-Layer6_top3
#> 6 6,40868,65917,... 6,156334,223324,... WM_top6,WM-Layer1_top17,WM-Layer4_top14,...
```

The output of `sig_genes_extract_all()` contains the following columns:

* `top`: the rank of the gene for the given `test`.
* `model_type`: either `enrichment`, `pairwise` or `anova`.
* `test`: the short notation for the test performed. For example, `WM` is white matter versus the other layers while `WM-Layer1` is white matter greater than layer 1.
* `gene`: the gene symbol.
* `stat`: the corresponding F or t-statistic.
* `pval`: the corresponding p-value (two-sided for t-stats).
* `fdr`: the FDR adjusted p-value.
* `gene_index`: the row of `sce_layer` and the original tables in `modeling_results` to join the tables if necessary.
* `ensembl`: Ensembl gene ID.
* `in_rows`: an `IntegerList()` specifying all the rows where that gene is present.
* `in_rows_top20`: an `IntegerList()` specifying all the rows where that gene is present and where its rank (`top`) is less than or equal to 20. This information is only included for the first occurrence of each gene if that gene is on the top 20 rank for any of the models.
* `results`: an `CharacterList()` specifying all the `test` results where the gene is ranked (`top`) among the top 20 genes.

`sig_genes_extract_all()` uses `sig_genes_extract()` as it’s workhorse and as such has a very similar output.

## 6.4 Visualize modeling results

After extracting the table of modeling results in long format with `sig_genes_extract_all()`, we can then use `layer_boxplot()` to visualize any gene of interest for any of the model types and tests we performed. Below we explore the first one (by default). We also show the color palettes used in the *[shiny](https://CRAN.R-project.org/package%3Dshiny)* application provided by *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* (Pardo, Spangler, Weber et al., 2022). The last example has the long title version that uses more information from the `sig_genes` object we created earlier.

```
## Note that we recommend setting the random seed so the jittering of the
## points will be reproducible. Given the requirements by BiocCheck this
## cannot be done inside the layer_boxplot() function.

## Create a boxplot of the first gene in `sig_genes`.
set.seed(20200206)
layer_boxplot(sig_genes = sig_genes, sce_layer = sce_layer)
```

![](data:image/png;base64...)

```
## Viridis colors displayed in the shiny app
## showing the first pairwise model result
## (which illustrates the background colors used for the layers not
## involved in the pairwise comparison)
set.seed(20200206)
layer_boxplot(
    i = which(sig_genes$model_type == "pairwise")[1],
    sig_genes = sig_genes,
    sce_layer = sce_layer,
    col_low_box = viridisLite::viridis(4)[2],
    col_low_point = viridisLite::viridis(4)[1],
    col_high_box = viridisLite::viridis(4)[3],
    col_high_point = viridisLite::viridis(4)[4]
)
```

![](data:image/png;base64...)

```
## Paper colors displayed in the shiny app
set.seed(20200206)
layer_boxplot(
    sig_genes = sig_genes,
    sce_layer = sce_layer,
    short_title = FALSE,
    col_low_box = "palegreen3",
    col_low_point = "springgreen2",
    col_high_box = "darkorange2",
    col_high_point = "orange1"
)
```

![](data:image/png;base64...)

## 6.5 Correlation of layer-level statistics

Just like we compressed our `spe` object into `sce_layer` by pseudo-bulking 555 For more details, check [this script](https://github.com/LieberInstitute/HumanPilot/blob/ab52559957624538f8dc08b0533e4106fab4066b/Analysis/Layer_Guesses/layer_specificity.R)., we can do the same for other single nucleus or single cell RNA sequencing datasets (snRNA-seq, scRNA-seq) and then compute enrichment t-statistics (one group vs the rest; could be one cell type vs the rest or one cluster of cells vs the rest). In our analysis (Maynard, Collado-Torres, Weber et al., 2021), we did this for several datasets including one of our LIBD Human DLPFC snRNA-seq data generated by Matthew N Tran et al 666 For more details, check [this script](https://github.com/LieberInstitute/HumanPilot/blob/ab52559957624538f8dc08b0533e4106fab4066b/Analysis/Layer_Guesses/dlpfc_snRNAseq_annotation.R).. In *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* (Pardo, Spangler, Weber et al., 2022) we include a small set of these statistics for the 31 cell clusters identified by Matthew N Tran et al.

```
## Explore the enrichment t-statistics derived from Tran et al's snRNA-seq
## DLPFC data
dim(tstats_Human_DLPFC_snRNAseq_Nguyen_topLayer)
#> [1] 692  31
tstats_Human_DLPFC_snRNAseq_Nguyen_topLayer[seq_len(3), seq_len(6)]
#>                      2 (1)       4 (1)      6 (1)      8 (1)     10 (1)     12 (1)
#> ENSG00000104419 -0.6720726  0.30024609  0.5854130  0.1358497  0.3981996 -0.9731938
#> ENSG00000184007  0.2535838 -0.28998049 -1.8106052 -0.2096309 -0.4521719 -0.1840286
#> ENSG00000240583 -0.2015831 -0.04053423 -0.5120807  0.1688405 -0.3969257 -0.2086954
```

The function `layer_stat_cor()` will take as input one such matrix of statistics and correlate them against our layer enrichment results (or other model types) using the subset of Ensembl gene IDs that are observed in both tables.

```
## Compute the correlation matrix of enrichment t-statistics between our data
## and Tran et al's snRNA-seq data
cor_stats_layer <- layer_stat_cor(
    tstats_Human_DLPFC_snRNAseq_Nguyen_topLayer,
    modeling_results,
    "enrichment"
)

## Explore the correlation matrix
head(cor_stats_layer[, seq_len(3)])
#>               WM       Layer6     Layer5
#> 22 (3) 0.6824669 -0.009192291 -0.1934265
#> 3 (3)  0.7154122 -0.070042729 -0.2290574
#> 23 (3) 0.6637885 -0.031467704 -0.2018306
#> 17 (3) 0.6364983 -0.094216046 -0.2026147
#> 21 (3) 0.6281443 -0.050336358 -0.1988774
#> 7 (4)  0.1850724 -0.197283175 -0.2716890
```

Once we have computed this correlation matrix, we can then visualize it using `layer_stat_cor_plot()` as shown below.

```
## Visualize the correlation matrix
layer_stat_cor_plot(cor_stats_layer)
```

![](data:image/png;base64...)

In order to fully interpret the resulting heatmap you need to know what each of the cell clusters labels mean. In this case, the syntax is `xx (Y)` where `xx` is the cluster number and `Y` is:

1. `Excit`: excitatory neurons.
2. `Inhib`: inhibitory neurons.
3. `Oligo`: oligodendrocytes.
4. `Astro`: astrocytes.
5. `OPC`: oligodendrocyte progenitor cells.
6. `Drop`: an ambiguous cluster of cells that potentially should be dropped.

You can find the version with the full names [here](https://github.com/LieberInstitute/HumanPilot/blob/master/Analysis/Layer_Guesses/pdf/snRNAseq_overlap_heatmap.pdf) if you are interested in it.

The *[shiny](https://CRAN.R-project.org/package%3Dshiny)* application provided by *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* (Pardo, Spangler, Weber et al., 2022) allows users to upload CSV file with these t-statistics, view the correlation heatmaps, download them, and download the correlation matrix. An example CSV file is provided [here](https://github.com/LieberInstitute/spatialLIBD/blob/devel/data-raw/tstats_Human_DLPFC_snRNAseq_Nguyen_topLayer.csv).

## 6.6 Gene set enrichment

Many researchers have identified lists of genes that increase the risk of a given disorder or disease, are differentially expressed in a given experiment or set of conditions, have been described in a several research papers, among other collections. We can ask for any of our modeling results whether a list of genes is enriched among our significant results.

For illustration purposes, we included in *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* (Pardo, Spangler, Weber et al., 2022) a set of genes from the Simons Foundation Autism Research Initiative [SFARI](https://www.sfari.org/). In our analysis (Maynard, Collado-Torres, Weber et al., 2021) we used more gene lists. Below, we read in the data and create a `list()` object with the Ensembl gene IDs that SFARI has provided that are related to autism.

```
## Read in the SFARI gene sets included in the package
asd_sfari <- utils::read.csv(
    system.file(
        "extdata",
        "SFARI-Gene_genes_01-03-2020release_02-04-2020export.csv",
        package = "spatialLIBD"
    ),
    as.is = TRUE
)

## Format them appropriately
asd_sfari_geneList <- list(
    Gene_SFARI_all = asd_sfari$ensembl.id,
    Gene_SFARI_high = asd_sfari$ensembl.id[asd_sfari$gene.score < 3],
    Gene_SFARI_syndromic = asd_sfari$ensembl.id[asd_sfari$syndromic == 1]
)
```

After reading the list of genes, we can then compute the enrichment odds ratios and p-values for a given FDR threshold in our statistics.

```
## Compute the gene set enrichment results
asd_sfari_enrichment <- gene_set_enrichment(
    gene_list = asd_sfari_geneList,
    modeling_results = modeling_results,
    model_type = "enrichment"
)

## Explore the results
head(asd_sfari_enrichment)
#>          OR        Pval   test NumSig SetSize                   ID model_type fdr_cut
#> 1 1.2659915 0.001761332     WM    231     869       Gene_SFARI_all enrichment     0.1
#> 2 1.1819109 0.098959488     WM     90     355      Gene_SFARI_high enrichment     0.1
#> 3 1.2333378 0.185302060     WM     31     118 Gene_SFARI_syndromic enrichment     0.1
#> 4 0.9702022 0.613080610 Layer1     71     869       Gene_SFARI_all enrichment     0.1
#> 5 0.7192630 0.949332765 Layer1     22     355      Gene_SFARI_high enrichment     0.1
#> 6 1.1216176 0.405453216 Layer1     11     118 Gene_SFARI_syndromic enrichment     0.1
```

Using the above enrichment table, we can then visualize the odds ratios on a heatmap as shown below. Note that we use the thresholded p-values at `-log10(p) = 12` for visualization purposes and only show the odds ratios for `-log10(p) > 3` by default.

```
## Visualize gene set enrichment results
gene_set_enrichment_plot(
    asd_sfari_enrichment,
    xlabs = gsub(".*_", "", unique(asd_sfari_enrichment$ID)),
    plot_SetSize_bar = TRUE,
    model_colors = get_colors(
        spatialLIBD::libd_layer_colors,
        clusters = unique(asd_sfari_enrichment$test)
    )
)
```

![](data:image/png;base64...)

The *[shiny](https://CRAN.R-project.org/package%3Dshiny)* application provided by *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* (Pardo, Spangler, Weber et al., 2022) allows users to upload CSV file their gene lists, compute the enrichment statistics, visualize them, download the PDF, and download the enrichment table. An example CSV file is provided [here](https://github.com/LieberInstitute/spatialLIBD/blob/devel/data-raw/asd_sfari_geneList.csv).

# 7 Re-shaping your data to our structure

This section gets into the details of how we generated the data (Maynard, Collado-Torres, Weber et al., 2021) behind *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* (Pardo, Spangler, Weber et al., 2022). This could be useful if you are a Bioconductor developer or a user very familiar with packages such as *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)*.

## 7.1 SpatialExperiment support

As of version 1.3.3, *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* supports the `SpatialExperiment` class from *[SpatialExperiment](https://bioconductor.org/packages/3.22/SpatialExperiment)*. The functions `vis_gene_p()`, `vis_gene()`, `vis_grid_clus()`, `vis_grid_gene()`, `vis_clus()`, `vis_clus_p()`, `geom_spatial()` now work with `SpatialExperiment` objects thanks to the updates in *[SpatialExperiment](https://bioconductor.org/packages/3.22/SpatialExperiment)*. If you have spot-level data formatted in the older `SingleCellExperiment` objects that were heavily modified for `spatialLIBD`, you can use `sce_to_spe()` to convert the objects.

This work was done by [Brenda Pardo](https://twitter.com/PardoBree) and Leonardo.

## 7.2 Using spatialLIBD with your own data

Please check the second vignette on how to use *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* with your own data as exemplified with a public 10x Genomics dataset or go directly to the `read10xVisiumWrapper()` documentation.

## 7.3 Expected characteristics of the data

If you want to check the key characteristics required by *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)*’s functions or the *[shiny](https://CRAN.R-project.org/package%3Dshiny)* application, use the `check_*` family of functions.

```
check_spe(spe)
#> class: SpatialExperiment
#> dim: 33538 47681
#> metadata(0):
#> assays(2): counts logcounts
#> rownames(33538): ENSG00000243485 ENSG00000237613 ... ENSG00000277475 ENSG00000268674
#> rowData names(9): source type ... gene_search is_top_hvg
#> colnames(47681): AAACAACGAATAGTTC-1 AAACAAGTATCTCCCA-1 ... TTGTTTCCATACAACT-1 TTGTTTGTGTAAATTC-1
#> colData names(69): sample_id Cluster ... array_row array_col
#> reducedDimNames(6): PCA TSNE_perplexity50 ... TSNE_perplexity80 UMAP_neighbors15
#> mainExpName: NULL
#> altExpNames(0):
#> spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
#> imgData names(4): sample_id image_id data scaleFactor
check_sce_layer(sce_layer)
#> class: SingleCellExperiment
#> dim: 22331 76
#> metadata(0):
#> assays(2): counts logcounts
#> rownames(22331): ENSG00000243485 ENSG00000238009 ... ENSG00000278384 ENSG00000271254
#> rowData names(10): source type ... is_top_hvg is_top_hvg_sce_layer
#> colnames(76): 151507_Layer1 151507_Layer2 ... 151676_Layer6 151676_WM
#> colData names(13): sample_name layer_guess ... layer_guess_reordered_short spatialLIBD
#> reducedDimNames(6): PCA TSNE_perplexity5 ... UMAP_neighbors15 PCAsub
#> mainExpName: NULL
#> altExpNames(0):
## The output here is too long to print
xx <- check_modeling_results(modeling_results)
identical(xx, modeling_results)
#> [1] TRUE
```

## 7.4 Generating our data (legacy)

If you are interested in reshaping your data to fit our structure, we do not provide a quick function to do so. That is intentional given the active development by the Bioconductor community for determining the best way to deal with spatial transcriptomics data in general and the 10x Visium data in particular. Having said that, we do have all the steps and reproducibility information documented across several of our analysis (Maynard, Collado-Torres, Weber et al., 2021) scripts.

* `reorganize_folder.R` available [here](https://github.com/LieberInstitute/HumanPilot/blob/master/reorganize_folder.R) re-organizes the raw data we were sent by 10x Genomics.
* `Layer_Notebook.R` available [here](https://github.com/LieberInstitute/HumanPilot/blob/master/Analysis/Layer_Notebook.R) reads in the Visium data and builds a list of `RangeSummarizedExperiment()` objects from *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*, one per sample (image) that is eventually saved as `Human_DLPFC_Visium_processedData_rseList.rda`.
* `convert_sce.R` available [here](https://github.com/LieberInstitute/HumanPilot/blob/master/Analysis/convert_sce.R) reads in `Human_DLPFC_Visium_processedData_rseList.rda` and builds an initial `sce` object with image data under `metadata(sce)$image` which is a single data.frame. Subsetting doesn’t automatically subset the image, so you have to do it yourself when plotting as is done by `vis_clus_p()` and `vis_gene_p()`. Having the data from all images in a single object allows you to use the spot-level data from all images to compute clusters and do other similar analyses to the ones you would do with sc/snRNA-seq data. The script creates the `Human_DLPFC_Visium_processedData_sce.Rdata` file.
* `sce_scran.R` available [here](https://github.com/LieberInstitute/HumanPilot/blob/master/Analysis/sce_scran.R) then uses *[scran](https://bioconductor.org/packages/3.22/scran)* to read in `Human_DLPFC_Visium_processedData_sce.Rdata`, compute the highly variable genes (stored in our final `sce` object at `rowData(sce)$is_top_hvg`), perform dimensionality reduction (PCA, TSNE, UMAP) and identify clusters using the data from all images. The resulting data is then stored as `Human_DLPFC_Visium_processedData_sce_scran.Rdata` and is the main object used throughout our analysis code (Maynard, Collado-Torres, Weber et al., 2021).
* `make-data_spatialLIBD.R` available in the source version of `spatialLIBD` and [online here](https://github.com/LieberInstitute/spatialLIBD/blob/devel/inst/scripts/make-data_spatialLIBD.R) is the script that reads in `Human_DLPFC_Visium_processedData_sce_scran.Rdata` as well as some other outputs from our analysis and combines them into the final `sce` and `sce_layer` objects provided by *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* (Pardo, Spangler, Weber et al., 2022). This script simplifies some operations in order to simplify the code behind the *[shiny](https://CRAN.R-project.org/package%3Dshiny)* application provided by *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)*.

You don’t necessarily need to do all of this to use the functions provided by *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)*. Note that external to the R objects, for the *[shiny](https://CRAN.R-project.org/package%3Dshiny)* application provided by *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* you will need to have the `tissue_lowres_image.png` image files in a directory structure by sample as shown [here](https://github.com/LieberInstitute/spatialLIBD/tree/devel/inst/app/www/data) in order for the interactive visualizations made with *[plotly](https://CRAN.R-project.org/package%3Dplotly)* to work.

# 8 More spatially-resolved LIBD datasets

Over time `spatialLIBD::fetch_data()` has been expanded to provide access to other datasets generated by our teams at the Lieber Institute for Brain Development ([LIBD](libd.org)) that have also been analyzed with `spatialLIBD`.

## 8.1 spatialDLPFC

Through `spatialLIBD::fetch_data()` you can also download the data from the [*Integrated single cell and unsupervised spatial transcriptomic analysis defines molecular anatomy of the human dorsolateral prefrontal cortex*](https://www.biorxiv.org/content/10.1101/2023.02.15.528722v1) project, also known as `spatialDLPFC` (Huuki-Myers, Spangler, Eagles et al., 2024). See <http://research.libd.org/spatialDLPFC/> for more information about this project.

See the Twitter thread 🧵 below for a brief overview of the [`#spatialDLPFC`](https://twitter.com/search?q=%23spatialDLPFC&src=typed_query) project.

> Hot of the pre-print press! 🔥 Our latest work [#spatialDLPFC](https://twitter.com/hashtag/spatialDLPFC?src=hash&ref_src=twsrc%5Etfw) pairs [#snRNAseq](https://twitter.com/hashtag/snRNAseq?src=hash&ref_src=twsrc%5Etfw) and [#Visium](https://twitter.com/hashtag/Visium?src=hash&ref_src=twsrc%5Etfw) spatial transcriptomic data in the human [#DLPFC](https://twitter.com/hashtag/DLPFC?src=hash&ref_src=twsrc%5Etfw) building a neuroanatomical atlas of this critical brain region 🧠[@LieberInstitute](https://twitter.com/LieberInstitute?ref_src=twsrc%5Etfw) [@10xGenomics](https://twitter.com/10xGenomics?ref_src=twsrc%5Etfw) [#scitwitter](https://twitter.com/hashtag/scitwitter?src=hash&ref_src=twsrc%5Etfw)
> 📰 <https://t.co/NJWJ1mwB9J> [pic.twitter.com/l8W154XZ50](https://t.co/l8W154XZ50)
>
> — Louise Huuki-Myers (@lahuuki) [February 17, 2023](https://twitter.com/lahuuki/status/1626686409313763328?ref_src=twsrc%5Etfw)

\*/var r;r=function(){"use strict";function t(t){return"function"==typeof t}var e=Array.isArray?Array.isArray:function(t){return"[object Array]"===Object.prototype.toString.call(t)},n=0,r=void 0,i=void 0,o=function(t,e){l[n]=t,l[n+1]=e,2===(n+=2)&&(i?i(h):w())},s="undefined"!=typeof window?window:void 0,a=s||{},u=a.MutationObserver||a.WebKitMutationObserver,c="undefined"==typeof self&&"undefined"!=typeof process&&"[object process]"==={}.toString.call(process),d="undefined"!=typeof Uint8ClampedArray&&"undefined"!=typeof importScripts&&"undefined"!=typeof MessageChannel;function f(){var t=setTimeout;return function(){return t(h,1)}}var l=new Array(1e3);function h(){for(var t=0;t=0&&this.\_handlers[t].splice(n,1):this.\_handlers[t]=[])},trigger:function(t,e){var n=this.\_handlers&&this.\_handlers[t];(e=e||{}).type=t,n&&n.forEach(function(t){r.async(i(t,this,e))})}};t.exports={Emitter:o,makeEmitter:function(){return r.aug(function(){},o)}}},function(t,e,n){var r=n(89),i=n(91),o=n(6),s=n(23),a=n(7),u=n(0),c=new i(function(t){var e=function(t){return t.reduce(function(t,e){return t[e.\_className]=t[e.\_className]||[],t[e.\_className].push(e),t},{})}(t.map(r.fromRawTask));u.forIn(e,function(t,e){s.allSettled(e.map(function(t){return t.initialize()})).then(function(){e.forEach(function(t){o.all([t.hydrate(),t.insertIntoDom()]).then(a(t.render,t)).then(a(t.success,t),a(t.fail,t))})})})});t.exports={addWidget:function(t){return c.add(t)}}},function(t,e,n){var r=n(17);t.exports=function(t){return r.write(function(){t&&t.parentNode&&t.parentNode.removeChild(t)})}},function(t,e,n){var r=n(93),i=n(71),o=new(n(103))(function(t){(!function(t){return 1===t.length&&i.canFlushOneItem(t[0])}(t)?function(t){r.init(),t.forEach(function(t){var e=t.input.namespace,n=t.input.data,i=t.input.offsite,o=t.input.version;r.clientEvent(e,n,i,o)}),r.flush().then(function(){t.forEach(function(t){t.taskDoneDeferred.resolve()})},function(){t.forEach(function(t){t.taskDoneDeferred.reject()})})}:function(t){t.forEach(function(t){var e=t.input.namespace,n=t.input.data,r=t.input.offsite,o=t.input.version;i.clientEvent(e,n,r,o),t.taskDoneDeferred.resolve()})})(t)});t.exports={scribe:function(t,e,n,r){return o.add({namespace:t,data:e,offsite:n,version:r})},pause:function(){o.pause()},resume:function(){o.resume()}}},function(t,e,n){n(18),t.exports={log:function(t,e){}}},function(t,e,n){var r=n(1);function i(t){return(t=t||r).getSelection&&t.getSelection()}t.exports={getSelection:i,getSelectedText:function(t){var e=i(t);return e?e.toString():""}}},function(t,e,n){var r=n(4),i=n(1),o=n(3),s=2e4;t.exports=function(t){var e=new o,n=r.createElement("img");return n.onload=n.onerror=function(){i.setTimeout(e.resolve,50)},n.src=t,i.setTimeout(e.reject,s),e.promise}},function(t,e,n){var r,i=n(10),o=n(4),s=n(1),a=n(33),u=n(51),c=n(5),d=n(21),f="csptest";t.exports={inlineStyle:function(){var t=f+d.generate(),e=o.createElement("div"),n=o.createElement("style"),l="."+t+" { visibility: hidden; }";return!!o.body&&(c.asBoolean(a.val("widgets:csp"))&&(r=!1),void 0!==r?r:(e.style.display="none",i.add(e,t),n.type="text/css",n.appendChild(o.createTextNode(l)),o.body.appendChild(n),o.body.appendChild(e),r="hidden"===s.getComputedStyle(e).visibility,u(e),u(n),r))}}},function(t,e){t.exports=function(t){var e=t.getBoundingClientRect();return{width:e.width,height:e.height}}},function(t,e,n){var r=n(101);t.exports=function(t){t.define("createElement",r),t.define("createFragment",r),t.define("htmlToElement",r),t.define("hasSelectedText",r),t.define("addRootClass",r),t.define("removeRootClass",r),t.define("hasRootClass",r),t.define("prependStyleSheet",r),t.define("appendStyleSheet",r),t.define("prependCss",r),t.define("appendCss",r),t.define("makeVisible",r),t.define("injectWidgetEl",r),t.define("matchHeightToContent",r),t.define("matchWidthToContent",r)}},function(t,e){t.exports=function(t){var e,n=!1;return function(){return n?e:(n=!0,e=t.apply(this,arguments))}}},function(t,e,n){var r=n(13),i=n(110),o=n(111),s=n(14);t.exports=function(t,e,n){return new r(i,o,s.DM\_BUTTON,t,e,n)}},function(t,e,n){var r=n(25),i=n(112);t.exports=r.build([i])},function(t,e,n){var r=n(13),i=n(115),o=n(30),s=n(14);t.exports=function(t,e,n){return new r(i,o,s.FOLLOW\_BUTTON,t,e,n)}},function(t,e,n){var r=n(13),i=n(123),o=n(29),s=n(14);t.exports=function(t,e,n){return new r(i,o,s.MOMENT,t,e,n)}},function(t,e,n){var r=n(13),i=n(125),o=n(29),s=n(14);t.exports=function(t,e,n){return new r(i,o,s.PERISCOPE,t,e,n)}},function(t,e,n){var r=n(127),i=n(128),o=n(132),s=n(134),a=n(136),u={collection:i,likes:o,list:s,profile:a,url:d},c=[a,o,i,s];function d(t){return r(c,function(e){try{return new e(t)}catch(t){}})}t.exports=function(t){return t?function(t){var e,n;return e=(t.sourceType+"").toLowerCase(),(n=u[e])?new n(t):null}(t)||d(t):null}},function(t,e,n){var r=n(4),i=n(13),o=n(30),s=n(138),a=n(14);t.exports=function(t,e,n){var u=r.createElement("div");return new i(s,o,a.TIMELINE,t,e,n,{sandboxWrapperEl:u})}},function(t,e,n){var r=n(4),i=n(13),o=n(30),s=n(140),a=n(14);t.exports=function(t,e,n){return new i(s,o,a.TWEET,t,e,n,{sandboxWrapperEl:r.createElement("div")})}},function(t,e,n){var r=n(13),i=n(142),o=n(30),s=n(14);t.exports=function(t,e,n){var a=t&&t.type||"share",u="hashtag"==a?s.HASHTAG\_BUTTON:"mention"==a?s.MENTION\_BUTTON:s.SHARE\_BUTTON;return new r(i,o,u,t,e,n)}},function(t,e,n){var r=n(52),i=n(38),o=n(0);t.exports=function(t){var e={widget\_origin:i.rootDocumentLocation(),widget\_frame:i.isFramed()?i.currentDocumentLocation():null,duration\_ms:t.duration,item\_ids:t.widgetIds||[]},n=o.aug(t.namespace,{page:"page",component:"performance"});r.scribe(n,e)}},function(t,e,n){var r=n(0),i=n(129),o=["ar","fa","he","ur"];t.exports={isRtlLang:function(t){return t=String(t).toLowerCase(),r.contains(o,t)},matchLanguage:function(t){return t=(t=(t||"").toLowerCase()).replace("\_","-"),i(t)?t:(t=t.replace(/-.\*/,""),i(t)?t:"en")}}},function(t,e,n){var r=n(53),i=n(16),o=n(37),s=n(27),a=n(0),u=n(9),c=n(6),d=u.get("scribeCallback"),f=2083,l=[],h=i.url(o.CLIENT\_EVENT\_ENDPOINT,{dnt:0,l:""}),p=encodeURIComponent(h).length;function m(t,e,n,r,i){var u=!a.isObject(t),f=!!e&&!a.isObject(e);if(!u&&!f)return d&&d(arguments),e=e||{},c.resolve(v(o.formatClientEventNamespace(t),o.formatClientEventData(e,n,r),s.settingsScribe(),i))}function v(t,e,n,s){var u;n&&a.isObject(t)&&a.isObject(e)&&(r.log(t,e),u=o.flattenClientEventPayload(t,e),s=a.aug({},s,{l:o.stringify(u)}),u.dnt&&(s.dnt=1),w(i.url(n,s)))}function g(t){return l.push(t),l}function w(t){return(new Image).src=t}t.exports={canFlushOneItem:function(t){var e=o.stringify(t),n=encodeURIComponent(e).length+3;return p+n")}).then(function(){t.close(),a.resolve(c)})}),c.src=["javascript:",'document.write("");',"try { window.parent.document; }",'catch (e) { document.domain="'+r.domain+'"; }',"window.parent."+g.fullPath(["sandbox",u])+"();"].join(""),c.addEventListener("error",a.reject,!1),o.write(function(){i.parentNode.replaceChild(c,i)}),a.promise}t.exports=a.couple(n(58),function(t){t.overrideProperty("id",{get:function(){return this.sandboxEl&&this.sandboxEl.id}}),t.overrideProperty("initialized",{get:function(){return!!this.win}}),t.overrideProperty("width",{get:function(){return this.\_width}}),t.overrideProperty("height",{get:function(){return this.\_height}}),t.overrideProperty("sandboxEl",{get:function(){return this.iframeEl}}),t.defineProperty("iframeEl",{get:function(){return this.\_iframe}}),t.defineProperty("rootEl",{get:function(){return this.doc&&this.doc.documentElement}}),t.defineProperty("widgetEl",{get:function(){return this.doc&&this.doc.body.firstElementChild}}),t.defineProperty("win",{get:function(){return this.iframeEl&&this.iframeEl.contentWindow}}),t.defineProperty("doc",{get:function(){return this.win&&this.win.document}}),t.define("\_updateCachedDimensions",function(){var t=this;return o.read(function(){var e,n=h(t.sandboxEl);"visible"==t.sandboxEl.style.visibility?t.\_width=n.width:(e=h(t.sandboxEl.parentElement).width,t.\_width=Math.min(n.width,e)),t.\_height=n.height})}),t.define("\_setTargetToBlank",function(){var t=this.createElement("base");t.target="\_blank",this.doc.head.appendChild(t)}),t.define("\_didResize",function(){var t=this,e=this.\_resizeHandlers.slice(0);return this.\_updateCachedDimensions().then(function(){e.forEach(function(e){e(t)})})}),t.define("setTitle",function(t){this.iframeEl.title=t}),t.override("createElement",function(t){return this.doc.createElement(t)}),t.override("createFragment",function(){return this.doc.createDocumentFragment()}),t.override("htmlToElement",function(t){var e;return(e=this.createElement("div")).innerHTML=t,e.firstElementChild}),t.override("hasSelectedText",function(){return!!s.getSelectedText(this.win)}),t.override("addRootClass",function(t){var e=this.rootEl;return t=Array.isArray(t)?t:[t],this.initialized?o.write(function(){t.forEach(function(t){i.add(e,t)})}):m.reject(new Error("sandbox not initialized"))}),t.override("removeRootClass",function(t){var e=this.rootEl;return t=Array.isArray(t)?t:[t],this.initialized?o.write(function(){t.forEach(function(t){i.remove(e,t)})}):m.reject(new Error("sandbox not initialized"))}),t.override("hasRootClass",function(t){return i.present(this.rootEl,t)}),t.define("addStyleSheet",function(t,e){var n,r=new p;return this.initialized?((n=this.createElement("link")).type="text/css",n.rel="stylesheet",n.href=t,n.addEventListener("load",r.resolve,!1),n.addEventListener("error",r.reject,!1),o.write(y(e,null,n)).then(function(){return u(t).then(r.resolve,r.reject),r.promise})):m.reject(new Error("sandbox not initialized"))}),t.override("prependStyleSheet",function(t){var e=this.doc;return this.addStyleSheet(t,function(t){var n=e.head.firstElementChild;return n?e.head.insertBefore(t,n):e.head.appendChild(t)})}),t.override("appendStyleSheet",function(t){var e=this.doc;return this.addStyleSheet(t,function(t){return e.head.appendChild(t)})}),t.define("addCss",function(t,e){var n;return c.inlineStyle()?((n=this.createElement("style")).type="text/css",n.appendChild(this.doc.createTextNode(t)),o.write(y(e,null,n))):(l.devError("CSP enabled; cannot embed inline styles"),m.resolve())}),t.override("prependCss",function(t){var e=this.doc;return this.addCss(t,function(t){var n=e.head.firstElementChild;return n?e.head.insertBefore(t,n):e.head.appendChild(t)})}),t.override("appendCss",function(t){var e=this.doc;return this.addCss(t,function(t){return e.head.appendChild(t)})}),t.override("makeVisible",function(){var t=this;return this.styleSelf(E).then(function(){t.\_updateCachedDimensions()})}),t.override("injectWidgetEl",function(t){var e=this;return this.initialized?this.widgetEl?m.reject(new Error("widget already injected")):o.write(function(){e.doc.body.appendChild(t)}):m.reject(new Error("sandbox not initialized"))}),t.override("matchHeightToContent",function(){var t,e=this;return o.read(function(){t=e.widgetEl?h(e.widgetEl).height:0}),o.write(function(){e.sandboxEl.style.height=t+"px"}).then(function(){return e.\_updateCachedDimensions()})}),t.override("matchWidthToContent",function(){var t,e=this;return o.read(function(){t=e.widgetEl?h(e.widgetEl).width:0}),o.write(function(){e.sandboxEl.style.width=t+"px"}).then(function(){return e.\_updateCachedDimensions()})}),t.after("initialize",function(){this.\_iframe=null,this.\_width=this.\_height=0,this.\_resizeHandlers=[]}),t.override("insert",function(t,e,n,r){var i=this,s=new p,a=this.targetGlobal.document,u=S(t,e,n,a);return o.write(y(r,null,u)),u.addEventListener("load",function(){(function(t){try{t.contentWindow.document}catch(t){return m.reject(t)}return m.resolve(t)})(u).then(null,y(R,null,t,e,n,u,a)).then(s.resolve,s.reject)},!1),u.addEventListener("error",s.reject,!1),s.promise.then(function(t){var e=d(i.\_didResize,A,i);return i.\_iframe=t,i.win.addEventListener("resize",e,!1),m.all([i.\_setTargetToBlank(),i.addRootClass(x),i.prependCss(T)])})}),t.override("onResize",function(t){this.\_resizeHandlers.push(t)}),t.after("styleSelf",function(){return this.\_updateCachedDimensions()})})},function(t,e){t.exports=function(){throw new Error("unimplemented method")}},function(t,e){t.exports={getBaseURLPath:function(t){switch(t&&t.tfw\_team\_holdback\_11929&&t.tfw\_team\_holdback\_11929.bucket){case"control":return"embed-holdback";case"holdback\_prod":return"embed-holdback-prod";default:return"embed"}}}},function(t,e,n){var r=n(3),i=n(7),o=100,s=3e3;function a(t,e){this.\_inputsQueue=[],this.\_task=t,this.\_isPaused=!1,this.\_flushDelay=e&&e.flushDelay||o,this.\_pauseLength=e&&e.pauseLength||s,this.\_flushTimeout=void 0}a.prototype.add=function(t){var e=new r;return this.\_inputsQueue.push({input:t,taskDoneDeferred:e}),this.\_scheduleFlush(),e.promise},a.prototype.\_scheduleFlush=function(){this.\_isPaused||(clearTimeout(this.\_flushTimeout),this.\_flushTimeout=setTimeout(i(this.\_flush,this),this.\_flushDelay))},a.prototype.\_flush=function(){try{this.\_task.call(null,this.\_inputsQueue)}catch(t){this.\_inputsQueue.forEach(function(e){e.taskDoneDeferred.reject(t)})}this.\_inputsQueue=[],this.\_flushTimeout=void 0},a.prototype.pause=function(t){clearTimeout(this.\_flushTimeout),this.\_isPaused=!0,!t&&this.\_pauseLength&&setTimeout(i(this.resume,this),this.\_pauseLength)},a.prototype.resume=function(){this.\_isPaused=!1,this.\_scheduleFlush()},t.exports=a},function(t,e,n){var r=n(72),i=n(28),o=n(3),s=n(4),a=n(27),u=n(20),c=n(24),d=n(8),f=n(18),l=n(105),h=n(59),p=n(9),m=n(16),v=n(2),g=n(0),w=n(1),y=h(function(){return new o}),b={shouldObtainCookieConsent:!1,features:{}};t.exports={load:function(){var t,e,n,o;if(u.ie9()||u.ie10()||"http:"!==d.protocol&&"https:"!==d.protocol)return f.devError("Using default settings due to unsupported browser or protocol."),void y().resolve();t={origin:d.origin},a.settings().indexOf("localhost")>-1&&(t.localSettings=!0),e=m.url(r.resourceBaseUrl+r.widgetIframeHtmlPath,t),n=function(t){var n,r,i,o;if(r=v.isTwitterURL(t.origin),i=e.substr(0,t.origin.length)===t.origin,o=v.isTwimgURL(t.origin),i&&r||o)try{(n="string"==typeof t.data?c.parse(t.data):t.data).namespace===l.settings&&(b=g.aug(b,{features:n.settings.features,sessionId:n.sessionId}),y().resolve())}catch(t){f.devError(t)}},w.addEventListener("message",n),o=i({src:e,title:"Twitter settings iframe"},{display:"none"}),s.body.appendChild(o)},settingsLoaded:function(){var t,e;return t=p.get("experimentOverride"),y().promise.then(function(){return t&&t.name&&t.assignment&&((e={})[t.name]={bucket:t.assignment},b.features=g.aug(b.features,e)),b})}}},function(t,e){t.exports={settings:"twttr.settings"}},function(t,e,n){t.exports=[n(107),n(114),n(122),n(124),n(126),n(139),n(141)]},function(t,e,n){var r=n(16),i=n(5),o=n(0),s=n(11),a=n(12)(),u=n(60),c="a.twitter-dm-button";t.exports=function(t){return a(t,c).map(function(t){return u(function(t){var e=t.getAttribute("data-show-screen-name"),n=s(t),a=t.getAttribute("href"),u=t.getAttribute("data-screen-name"),c=e?i.asBoolean(e):null,d=t.getAttribute("data-size"),f=r.decodeURL(a),l=f.recipient\_id,h=t.getAttribute("data-text")||f.text,p=t.getAttribute("data-welcome-message-id")||f.welcomeMessageId;return o.aug(n,{screenName:u,showScreenName:c,size:d,text:h,userId:l,welcomeMessageId:p})}(t),t.parentNode,t)})}},function(t,e,n){var r=n(0);t.exports=function t(e){var n;if(e)return n=e.lang||e.getAttribute("data-lang"),r.isType("string",n)?n:t(e.parentElement)}},function(t,e,n){var r=n(0),i=n(48);t.exports=function(t,e){return i(t,e)?[t]:r.toRealArray(t.querySelectorAll(e))}},function(t,e,n){var r=n(3);t.exports=function(t,e){var i=new r;return n.e(1).then(function(r){var o;try{o=n(75),i.resolve(new o(t,e))}catch(t){i.reject(t)}}.bind(null,n)).catch(function(t){i.reject(t)}),i.promise}},function(t,e,n){var r=n(61),i=n(29);t.exports=r.isSupported()?r:i},function(t,e,n){var r=n(113),i=n(1),o=n(10),s=n(35),a=n(17),u=n(54),c=n(25),d=n(55),f=n(56),l=n(57),h=n(7),p=n(43),m=n(6),v=n(0),g=50,w={position:"absolute",visibility:"hidden",display:"block",transform:"rotate(0deg)"},y={position:"static",visibility:"visible"},b="twitter-widget",\_="open",E="SandboxRoot",x=".SandboxRoot { display: none; max-height: 10000px; }";t.exports=c.couple(n(58),function(t){t.defineStatic("isSupported",function(){return!!i.HTMLElement.prototype.attachShadow&&f.inlineStyle()}),t.overrideProperty("id",{get:function(){return this.sandboxEl&&this.sandboxEl.id}}),t.overrideProperty("initialized",{get:function(){return!!this.\_shadowHost}}),t.overrideProperty("width",{get:function(){return this.\_width}}),t.overrideProperty("height",{get:function(){return this.\_height}}),t.overrideProperty("sandboxEl",{get:function(){return this.\_shadowHost}}),t.define("\_updateCachedDimensions",function(){var t=this;return a.read(function(){var e,n=l(t.sandboxEl);"visible"==t.sandboxEl.style.visibility?t.\_width=n.width:(e=l(t.sandboxEl.parentElement).width,t.\_width=Math.min(n.width,e)),t.\_height=n.height})}),t.define("\_didResize",function(){var t=this,e=this.\_resizeHandlers.slice(0);return this.\_updateCachedDimensions().then(function(){e.forEach(function(e){e(t)})})}),t.override("createElement",function(t){return this.targetGlobal.document.createElement(t)}),t.override("createFragment",function(){return this.targetGlobal.document.createDocumentFragment()}),t.override("htmlToElement",function(t){var e;return(e=this.createElement("div")).innerHTML=t,e.firstElementChild}),t.override("hasSelectedText",function(){return!!u.getSelectedText(this.targetGlobal)}),t.override("addRootClass",function(t){var e=this.\_shadowRootBody;return t=Array.isArray(t)?t:[t],this.initialized?a.write(function(){t.forEach(function(t){o.add(e,t)})}):m.reject(new Error("sandbox not initialized"))}),t.override("removeRootClass",function(t){var e=this.\_shadowRootBody;return t=Array.isArray(t)?t:[t],this.initialized?a.write(function(){t.forEach(function(t){o.remove(e,t)})}):m.reject(new Error("sandbox not initialized"))}),t.override("hasRootClass",function(t){return o.present(this.\_shadowRootBody,t)}),t.override("addStyleSheet",function(t,e){return this.addCss('@import url("'+t+'");',e).then(function(){return d(t)})}),t.override("prependStyleSheet",function(t){var e=this.\_shadowRoot;return this.addStyleSheet(t,function(t){var n=e.firstElementChild;return n?e.insertBefore(t,n):e.appendChild(t)})}),t.override("appendStyleSheet",function(t){var e=this.\_shadowRoot;return this.addStyleSheet(t,function(t){return e.appendChild(t)})}),t.override("addCss",function(t,e){var n;return this.initialized?f.inlineStyle()?((n=this.createElement("style")).type="text/css",n.appendChild(this.targetGlobal.document.createTextNode(t)),a.write(h(e,null,n))):m.resolve():m.reject(new Error("sandbox not initialized"))}),t.override("prependCss",function(t){var e=this.\_shadowRoot;return this.addCss(t,function(t){var n=e.firstElementChild;return n?e.insertBefore(t,n):e.appendChild(t)})}),t.override("appendCss",function(t){var e=this.\_shadowRoot;return this.addCss(t,function(t){return e.appendChild(t)})}),t.override("makeVisible",function(){return this.styleSelf(y)}),t.override("injectWidgetEl",function(t){var e=this;return this.initialized?this.\_shadowRootBody.firstElementChild?m.reject(new Error("widget already injected")):a.write(function(){e.\_shadowRootBody.appendChild(t)}).then(function(){return e.\_updateCachedDimensions()}).then(function(){var t=p(e.\_didResize,g,e);new r(e.\_shadowRootBody,t)}):m.reject(new Error("sandbox not initialized"))}),t.override("matchHeightToContent",function(){return m.resolve()}),t.override("matchWidthToContent",function(){return m.resolve()}),t.override("insert",function(t,e,n,r){var i=this.targetGlobal.document,o=this.\_shadowHost=i.createElement(b),u=this.\_shadowRoot=o.attachShadow({mode:\_}),c=this.\_shadowRootBody=i.createElement("div");return v.forIn(e||{},function(t,e){o.setAttribute(t,e)}),o.id=t,u.appendChild(c),s.delegate(c,"click","A",function(t,e){e.hasAttribute("target")||e.setAttribute("target","\_blank")}),m.all([this.styleSelf(w),this.addRootClass(E),this.prependCss(x),a.write(r.bind(null,o))])}),t.override("onResize",function(t){this.\_resizeHandlers.push(t)}),t.after("initialize",function(){this.\_shadowHost=this.\_shadowRoot=this.\_shadowRootBody=null,this.\_width=this.\_height=0,this.\_resizeHandlers=[]}),t.after("styleSelf",function(){return this.\_updateCachedDimensions()})})},function(t,e){var n;(n=function(t,e){function r(t,e){if(t.resizedAttached){if(t.resizedAttached)return void t.resizedAttached.add(e)}else t.resizedAttached=new function(){var t,e;this.q=[],this.add=function(t){this.q.push(t)},this.call=function(){for(t=0,e=this.q.length;t

',t.appendChild(t.resizeSensor),{fixed:1,absolute:1}[function(t,e){return t.currentStyle?t.currentStyle[e]:window.getComputedStyle?window.getComputedStyle(t,null).getPropertyValue(e):t.style[e]}(t,"position")]||(t.style.position="relative");var i,o,s=t.resizeSensor.childNodes[0],a=s.childNodes[0],u=t.resizeSensor.childNodes[1],c=(u.childNodes[0],function(){a.style.width=s.offsetWidth+10+"px",a.style.height=s.offsetHeight+10+"px",s.scrollLeft=s.scrollWidth,s.scrollTop=s.scrollHeight,u.scrollLeft=u.scrollWidth,u.scrollTop=u.scrollHeight,i=t.offsetWidth,o=t.offsetHeight});c();var d=function(t,e,n){t.attachEvent?t.attachEvent("on"+e,n):t.addEventListener(e,n)},f=function(){t.offsetWidth==i&&t.offsetHeight==o||t.resizedAttached&&t.resizedAttached.call(),c()};d(s,"scroll",f),d(u,"scroll",f)}var i=Object.prototype.toString.call(t),o="[object Array]"===i||"[object NodeList]"===i||"[object HTMLCollection]"===i||"undefined"!=typeof jQuery&&t instanceof jQuery||"undefined"!=typeof Elements&&t instanceof Elements;if(o)for(var s=0,a=t.length;s0;return this.updateCachedDimensions().then(function(){e&&t.\_resizeHandlers.forEach(function(e){e(t)})})}),t.define("loadDocument",function(t){var e=new a;return this.initialized?this.iframeEl.src?u.reject(new Error("widget already loaded")):(this.iframeEl.addEventListener("load",e.resolve,!1),this.iframeEl.addEventListener("error",e.reject,!1),this.iframeEl.src=t,e.promise):u.reject(new Error("sandbox not initialized"))}),t.after("initialize",function(){var t=new a,e=new a;this.\_iframe=null,this.\_iframeVersion=null,this.\_width=this.\_height=0,this.\_resizeHandlers=[],this.\_rendered=t,this.\_results=e,this.\_waitToSwapUntilRendered=!1}),t.override("insert",function(t,e,n,i){var a=this;return e=d.aug({id:t},f,e),n=d.aug({},l,n),this.\_iframe=s(e,n),p[t]=this,a.\_waitToSwapUntilRendered||this.onResize(o(function(){a.makeVisible()})),r.write(c(i,null,this.\_iframe))}),t.override("onResize",function(t){this.\_resizeHandlers.push(t)}),t.after("styleSelf",function(){return this.updateCachedDimensions()})}},function(t,e,n){var r=n(1),i=n(118),o=n(120),s=n(22),a=n(5),u=n(121);t.exports=function(t,e,n,c,d){function f(t){var e=u(this);s.trigger(t.type,{target:e,region:t.region,type:t.type,data:t.data||{}})}function l(e){var n=u(this),r=n&&n.id,i=a.asInt(e.width),o=a.asInt(e.height);r&&void 0!==i&&void 0!==o&&t(r,i,o)}(new i).attachReceiver(new o.Receiver(r,"twttr.button")).bind("twttr.private.trigger",f).bind("twttr.private.resizeButton",l),(new i).attachReceiver(new o.Receiver(r,"twttr.embed")).bind("twttr.private.initialized",function(t){var e=u(this),n=e&&e.id,r=t.iframe\_version;n&&r&&c&&c(n,r)}).bind("twttr.private.trigger",f).bind("twttr.private.results",function(){var t=u(this),n=t&&t.idn&&e&&e(n)}).bind("twttr.private.rendered",function(){var t=u(this),e=t&&t.ide&&n&&n(e)}).bind("twttr.private.no\_results",function(){var t=u(this),e=t&&t.ide&&d&&d(e)}).bind("twttr.private.resize",l)}},function(t,e,n){var r=n(24),i=n(119),o=n(0),s=n(6),a=n(23),u="2.0";function c(t){this.registry=t||{}}function d(t){var e,n;return e=o.isType("string",t),n=o.isType("number",t),e||n||null===t}function f(t,e){return{jsonrpc:u,id:d(t)?t:null,error:e}}c.prototype.\_invoke=function(t,e){var n,r,i;n=this.registry[t.method],r=t.params||[],r=o.isType("array",r)?r:[r];try{i=n.apply(e.source||null,r)}catch(t){i=s.reject(t.message)}return a.isPromise(i)?i:s.resolve(i)},c.prototype.\_processRequest=function(t,e){var n,r;return function(t){var e,n,r;return!!o.isObject(t)&&(e=t.jsonrpc===u,n=o.isType("string",t.method),r=!("id"in t)||d(t.id),e&&n&&r)}(t)?(n="params"in t&&(r=t.params,!o.isObject(r)||o.isType("function",r))?s.resolve(f(t.id,i.INVALID\_PARAMS)):this.registry[t.method]?this.\_invoke(t,{source:e}).then(function(e){return n=t.id,{jsonrpc:u,id:n,result:e};var n},function(){return f(t.id,i.INTERNAL\_ERROR)}):s.resolve(f(t.id,i.METHOD\_NOT\_FOUND)),null!=t.id?n:s.resolve()):s.resolve(f(t.id,i.INVALID\_REQUEST))},c.prototype.attachReceiver=function(t){return t.attachTo(this),this},c.prototype.bind=function(t,e){return this.registry[t]=e,this},c.prototype.receive=function(t,e){var n,a,u,c=this;try{u=t,t=o.isType("string",u)?r.parse(u):u}catch(t){return s.resolve(f(null,i.PARSE\_ERROR))}return e=e||null,a=((n=o.isType("array",t))?t:[t]).map(function(t){return c.\_processRequest(t,e)}),n?function(t){return s.all(t).then(function(t){return(t=t.filter(function(t){return void 0!==t})).length?t:void 0})}(a):a[0]},t.exports=c},function(t){t.exports={PARSE\_ERROR:{code:-32700,message:"Parse error"},INVALID\_REQUEST:{code:-32600,message:"Invalid Request"},INVALID\_PARAMS:{code:-32602,message:"Invalid params"},METHOD\_NOT\_FOUND:{code:-32601,message:"Method not found"},INTERNAL\_ERROR:{code:-32603,message:"Internal error"}}},function(t,e,n){var r=n(8),i=n(1),o=n(24),s=n(3),a=n(20),u=n(0),c=n(2),d=n(7),f=a.ie9();function l(t,e,n){var r;t&&t.postMessage&&(f?r=(n||"")+o.stringify(e):n?(r={})[n]=e:r=e,t.postMessage(r,"\*"))}function h(t){return u.isType("string",t)?t:"JSONRPC"}function p(t,e){return e?u.isType("string",t)&&0===t.indexOf(e)?t.substring(e.length):t&&t[e]?t[e]:void 0:t}function m(t,e){var n=t.document;this.filter=h(e),this.server=null,this.isTwitterFrame=c.isTwitterURL(n.location.href),t.addEventListener("message",d(this.\_onMessage,this),!1)}function v(t,e){this.pending={},this.target=t,this.isTwitterHost=c.isTwitterURL(r.href),this.filter=h(e),i.addEventListener("message",d(this.\_onMessage,this),!1)}u.aug(m.prototype,{\_onMessage:function(t){var e,n=this;this.server&&(this.isTwitterFrame&&!c.isTwitterURL(t.origin)||(e=p(t.data,this.filter))&&this.server.receive(e,t.source).then(function(e){e&&l(t.source,e,n.filter)}))},attachTo:function(t){this.server=t},detach:function(){this.server=null}}),u.aug(v.prototype,{\_processResponse:function(t){var e=this.pending[t.id];e&&(e.resolve(t),delete this.pending[t.id])},\_onMessage:function(t){var e;if((!this.isTwitterHost||c.isTwitterURL(t.origin))&&(e=p(t.data,this.filter))){if(u.isType("string",e))try{e=o.parse(e)}catch(t){return}(e=u.isType("array",e)?e:[e]).forEach(d(this.\_processResponse,this))}},send:function(t){var e=new s;return t.id?this.pending[t.id]=e:e.resolve(),l(this.target,t,this.filter),e.promise}}),t.exports={Receiver:m,Dispatcher:v,\_stringifyPayload:function(t){return arguments.length>0&&(f=!!t),f}}},function(t,e,n){var r=n(4);t.exports=function(t){for(var e,n=r.getElementsByTagName("iframe"),i=0;n[i];i++)if((e=n[i]).contentWindow===t)return e}},function(t,e,n){var r=n(5),i=n(0),o=n(2),s=n(11),a=n(12)(),u=n(63),c="a.twitter-moment";t.exports=function(t){return a(t,c).map(function(t){return u(function(t){var e=s(t),n={momentId:o.momentId(t.href),chrome:t.getAttribute("data-chrome"),limit:t.getAttribute("data-limit")};return i.forIn(n,function(t,n){var i=e[t];e[t]=r.hasValue(i)?i:n}),e}(t),t.parentNode,t)})}},function(t,e,n){var r=n(3);t.exports=function(t,e){var i=new r;return n.e(3).then(function(r){var o;try{o=n(77),i.resolve(new o(t,e))}catch(t){i.reject(t)}}.bind(null,n)).catch(function(t){i.reject(t)}),i.promise}},function(t,e,n){var r=n(0),i=n(11),o=n(12)(),s=n(64),a="a.periscope-on-air",u=/^https?:\/\/(?:www\.)?(?:periscope|pscp)\.tv\/@?([a-zA-Z0-9\_]+)\/?$/i;t.exports=function(t){return o(t,a).map(function(t){return s(function(t){var e=i(t),n=t.getAttribute("href"),o=t.getAttribute("data-size"),s=u.exec(n)[1];return r.aug(e,{username:s,size:o})}(t),t.parentNode,t)})}},function(t,e,n){var r=n(3);t.exports=function(t,e){var i=new r;return n.e(4).then(function(r){var o;try{o=n(78),i.resolve(new o(t,e))}catch(t){i.reject(t)}}.bind(null,n)).catch(function(t){i.reject(t)}),i.promise}},function(t,e,n){var r=n(5),i=n(0),o=n(65),s=n(11),a=n(12)(),u=n(66),c=n(2),d=n(18),f="a.twitter-timeline,div.twitter-timeline,a.twitter-grid",l="Embedded Search timelines have been deprecated. See https://twittercommunity.com/t/deprecating-widget-settings/102295.",h="You may have been affected by an update to settings in embedded timelines. See https://twittercommunity.com/t/deprecating-widget-settings/102295.",p="Embedded grids have been deprecated and will now render as timelines. Please update your embed code to use the twitter-timeline class. More info: https://twittercommunity.com/t/update-on-the-embedded-grid-display-type/119564.";t.exports=function(t,e){return a(t,f).map(function(t){return u(function(t){var e=s(t),n=t.getAttribute("data-show-replies"),a={isPreconfigured:!!t.getAttribute("data-widget-id"),chrome:t.getAttribute("data-chrome"),tweetLimit:t.getAttribute("data-tweet-limit")||t.getAttribute("data-limit"),ariaLive:t.getAttribute("data-aria-polite"),theme:t.getAttribute("data-theme"),borderColor:t.getAttribute("data-border-color"),showReplies:n?r.asBoolean(n):null,profileScreenName:t.getAttribute("data-screen-name"),profileUserId:t.getAttribute("data-user-id"),favoritesScreenName:t.getAttribute("data-favorites-screen-name"),favoritesUserId:t.getAttribute("data-favorites-user-id"),likesScreenName:t.getAttribute("data-likes-screen-name"),likesUserId:t.getAttribute("data-likes-user-id"),listOwnerScreenName:t.getAttribute("data-list-owner-screen-name"),listOwnerUserId:t.getAttribute("data-list-owner-id"),listId:t.getAttribute("data-list-id"),listSlug:t.getAttribute("data-list-slug"),customTimelineId:t.getAttribute("data-custom-timeline-id"),staticContent:t.getAttribute("data-static-content"),url:t.href};return a.isPreconfigured&&(c.isSearchUrl(a.url)?d.publicError(l,t):d.publicLog(h,t)),"twitter-grid"===t.className&&d.publicLog(p,t),(a=i.aug(a,e)).dataSource=o(a),a.id=a.dataSource&&a.dataSource.id,a}(t),t.parentNode,t,e)})}},function(t,e){t.exports=function(t,e,n){for(var r,i=0;i

## 8.2 Visium\_SPG\_AD

Through `spatialLIBD::fetch_data()` you can also download the data from the [*Influence of Alzheimer’s disease related neuropathology on local microenvironment gene expression in the human inferior temporal cortex*](https://www.biorxiv.org/content/10.1101/2023.04.TODO)  project, also known as `Visium_SPG_AD` (Kwon, Parthiban, Tippani, Divecha, Eagles, Lobana, Williams, Mark, Bharadwaj, Kleinman, Hyde, Page, Hicks, Martinowich, Maynard, and Collado-Torres, 2023). See <http://research.libd.org/Visium_SPG_AD/> for more information about this project.

See the Twitter thread 🧵 below for a brief overview of the [`#Visium_SPG_AD`](https://twitter.com/search?q=%23Visium_SPG_AD&src=typed_query) project.

TODO

## 8.3 LIBD data outside `spatialLIBD`

Sometimes our collaborators have shared data through other venues. So not all LIBD spatially-resolved transcriptomics data from the [Keri Martinowich](https://www.libd.org/team/keri-martinowich-phd/), [Kristen Maynard](https://www.libd.org/team/kristen-maynard-phd/), and [Leonardo Collado-Torres](http://lcolladotor.github.io/) teams has been released through `spatialLIBD`. However, it is very much compatible with `spatialLIBD` and can be analyzed or visualized with `spatialLIBD` functions.

### 8.3.1 locus-c

[*The gene expression landscape of the human locus coeruleus revealed by single-nucleus and spatially-resolved transcriptomics*](https://www.biorxiv.org/content/10.1101/2022.10.28.514241v1), also known as `locus-c`, is not available through `spatialLIBD`, but you might be interested in checking out the excellent *[WeberDivechaLCdata](https://bioconductor.org/packages/3.22/WeberDivechaLCdata)* package for more details. See <https://github.com/lmweber/locus-c> for more details about the `locus-c` project.

See the Twitter thread 🧵 below for a brief overview of the `locus-c` project.

> Very happy to share our preprint on spatially-resolved transcriptomics and single-nucleus RNA-sequencing in the human locus coeruleus! 🎉🧠🔵 <https://t.co/L69G2P9PO6>
>
> — Lukas Weber ☀️ (@lmwebr) [October 31, 2022](https://twitter.com/lmwebr/status/1587123044660699141?ref_src=twsrc%5Etfw)

# 9 Reproducibility

The *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* package (Pardo, Spangler, Weber et al., 2022) was made possible thanks to:

* R (R Core Team, 2025)
* *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* (Morgan and Shepherd, 2025)
* *[benchmarkme](https://CRAN.R-project.org/package%3Dbenchmarkme)* (Gillespie, 2022)
* *[BiocFileCache](https://bioconductor.org/packages/3.22/BiocFileCache)* (Shepherd and Morgan, 2025)
* *[BiocGenerics](https://bioconductor.org/packages/3.22/BiocGenerics)* (Huber, W., Carey, J., Gentleman, R., Anders, S., Carlson, M., Carvalho, S., Bravo, C., Davis, S., Gatto, L., Girke, T., Gottardo, R., Hahne, F., Hansen, D., Irizarry, A., Lawrence, M., Love, I., MacDonald, J., Obenchain, V., {Ole’s}, K., {Pag`es}, H., Reyes, A., Shannon, P., Smyth, K., Tenenbaum, D., Waldron, L., Morgan, and M., 2015)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[circlize](https://CRAN.R-project.org/package%3Dcirclize)* (Gu, Gu, Eils, Schlesner, and Brors, 2014)
* *[ComplexHeatmap](https://bioconductor.org/packages/3.22/ComplexHeatmap)* (Gu, Eils, and Schlesner, 2016)
* *[cowplot](https://CRAN.R-project.org/package%3Dcowplot)* (Wilke, 2025)
* *[DT](https://CRAN.R-project.org/package%3DDT)* (Xie, Cheng, Tan, and Aden-Buie, 2025)
* *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* (Chen, Chen, Lun, Baldoni, and Smyth, 2025)
* *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)* (Morgan and Shepherd, 2025)
* *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* (Lawrence, Huber, Pagès, Aboyoun, Carlson, Gentleman, Morgan, and Carey, 2013)
* *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* (Wickham, 2016)
* *[golem](https://CRAN.R-project.org/package%3Dgolem)* (Fay, Guyader, Rochette, and Girard, 2024)
* *[IRanges](https://bioconductor.org/packages/3.22/IRanges)* (Lawrence, Huber, Pagès et al., 2013)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2014)
* *[limma](https://bioconductor.org/packages/3.22/limma)* (Ritchie, Phipson, Wu, Hu, Law, Shi, and Smyth, 2015)
* *[magick](https://CRAN.R-project.org/package%3Dmagick)* (Ooms, 2025)
* *[Matrix](https://CRAN.R-project.org/package%3DMatrix)* (Bates, Maechler, and Jagan, 2025)
* *[paletteer](https://CRAN.R-project.org/package%3Dpaletteer)* (Hvitfeldt, 2021)
* *[plotly](https://CRAN.R-project.org/package%3Dplotly)* (Sievert, 2020)
* *[RColorBrewer](https://CRAN.R-project.org/package%3DRColorBrewer)* (Neuwirth, 2022)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025)
* *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* (Lawrence, Gentleman, and Carey, 2009)
* *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* (Pagès, Lawrence, and Aboyoun, 2025)
* *[scater](https://bioconductor.org/packages/3.22/scater)* (McCarthy, Campbell, Lun, and Willis, 2017)
* *[scuttle](https://bioconductor.org/packages/3.22/scuttle)* (McCarthy, Campbell, Lun et al., 2017)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight et al., 2025)
* *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* (Amezquita, Lun, Becht, Carey, Carpp, Geistlinger, Marini, Rue-Albrecht, Risso, Soneson, Waldron, Pages, Smith, Huber, Morgan, Gottardo, and Hicks, 2020)
* *[shiny](https://CRAN.R-project.org/package%3Dshiny)* (Chang, Cheng, Allaire et al., 2025)
* *[SpatialExperiment](https://bioconductor.org/packages/3.22/SpatialExperiment)* (Righelli, Weber, Crowell et al., 2022)
* *[statmod](https://CRAN.R-project.org/package%3Dstatmod)* (Chen, Chen, Lun et al., 2025)
* *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* (Morgan, Obenchain, Hester, and Pagès, 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)
* *[viridisLite](https://CRAN.R-project.org/package%3DviridisLite)* (Garnier, Simon, Ross, Noam, Rudis, Robert, Camargo, Pedro, Sciaini, Marco, Scherer, and Cédric, 2023)

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("spatialLIBD.Rmd"))

## Extract the R code
library("knitr")
knit("spatialLIBD.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-11-04 11:49:03 EST"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 25.24 secs
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-11-04
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package              * version   date (UTC) lib source
#>  abind                  1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
#>  AnnotationDbi          1.72.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationHub          4.0.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  attempt                0.3.1     2020-05-03 [2] CRAN (R 4.5.1)
#>  backports              1.5.0     2024-05-23 [2] CRAN (R 4.5.1)
#>  beachmat               2.26.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  beeswarm               0.4.0     2021-06-01 [2] CRAN (R 4.5.1)
#>  benchmarkme            1.0.8     2022-06-12 [2] CRAN (R 4.5.1)
#>  benchmarkmeData        1.0.4     2020-04-23 [2] CRAN (R 4.5.1)
#>  bibtex                 0.5.1     2023-01-26 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.70.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocFileCache        * 3.0.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocIO                 1.20.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocNeighbors          2.4.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocParallel           1.44.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocSingular           1.26.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle            * 2.38.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocVersion            3.22.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.78.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
#>  bitops                 1.0-9     2024-10-03 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown               0.45      2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
#>  Cairo                  1.7-0     2025-10-29 [2] CRAN (R 4.5.1)
#>  cigarillo              1.0.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  circlize               0.4.16    2024-02-20 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
#>  clue                   0.3-66    2024-11-13 [2] CRAN (R 4.5.1)
#>  cluster                2.1.8.1   2025-03-12 [3] CRAN (R 4.5.1)
#>  codetools              0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
#>  colorspace             2.1-2     2025-09-22 [2] CRAN (R 4.5.1)
#>  ComplexHeatmap         2.26.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  config                 0.3.2     2023-08-30 [2] CRAN (R 4.5.1)
#>  cowplot                1.2.0     2025-07-07 [2] CRAN (R 4.5.1)
#>  crayon                 1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
#>  curl                   7.0.0     2025-08-19 [2] CRAN (R 4.5.1)
#>  data.table             1.17.8    2025-07-10 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
#>  dbplyr               * 2.5.1     2025-09-10 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  DelayedMatrixStats     1.32.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  dichromat              2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
#>  doParallel             1.0.17    2022-02-07 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  dqrng                  0.4.1     2024-05-28 [2] CRAN (R 4.5.1)
#>  DropletUtils           1.30.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  DT                     0.34.0    2025-09-02 [2] CRAN (R 4.5.1)
#>  edgeR                  4.8.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  evaluate               1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
#>  ExperimentHub          3.0.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  farver                 2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  filelock               1.0.3     2023-12-11 [2] CRAN (R 4.5.1)
#>  foreach                1.5.2     2022-02-02 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicAlignments      1.46.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicRanges        * 1.62.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  GetoptLong             1.0.5     2020-12-15 [2] CRAN (R 4.5.1)
#>  ggbeeswarm             0.7.2     2023-04-29 [2] CRAN (R 4.5.1)
#>  ggplot2                4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
#>  ggrepel                0.9.6     2024-09-07 [2] CRAN (R 4.5.1)
#>  GlobalOptions          0.1.2     2020-06-10 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
#>  golem                  0.5.1     2024-08-27 [2] CRAN (R 4.5.1)
#>  gridExtra              2.3       2017-09-09 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
#>  h5mread                1.2.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  HDF5Array              1.38.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  htmltools              0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets            1.6.4     2023-12-06 [2] CRAN (R 4.5.1)
#>  httpuv                 1.6.16    2025-04-16 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2                  1.2.1     2025-07-22 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  irlba                  2.3.5.1   2022-10-03 [2] CRAN (R 4.5.1)
#>  iterators              1.0.14    2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.50.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling               0.4.3     2023-08-29 [2] CRAN (R 4.5.1)
#>  later                  1.4.4     2025-08-27 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  lazyeval               0.2.2     2019-03-15 [2] CRAN (R 4.5.1)
#>  lifecycle              1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  limma                  3.66.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  lobstr               * 1.1.2     2022-06-22 [2] CRAN (R 4.5.1)
#>  locfit                 1.5-9.12  2025-03-05 [2] CRAN (R 4.5.1)
#>  lubridate              1.9.4     2024-12-08 [2] CRAN (R 4.5.1)
#>  magick                 2.9.0     2025-09-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
#>  mime                   0.13      2025-03-17 [2] CRAN (R 4.5.1)
#>  otel                   0.2.0     2025-08-29 [2] CRAN (R 4.5.1)
#>  paletteer              1.6.0     2024-01-21 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
#>  plotly                 4.11.0    2025-06-19 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
#>  png                    0.1-8     2022-11-29 [2] CRAN (R 4.5.1)
#>  prettyunits            1.2.0     2023-09-24 [2] CRAN (R 4.5.1)
#>  prismatic              1.1.2     2024-04-10 [2] CRAN (R 4.5.1)
#>  promises               1.5.0     2025-11-01 [2] CRAN (R 4.5.1)
#>  purrr                  1.1.0     2025-07-10 [2] CRAN (R 4.5.1)
#>  R.methodsS3            1.8.2     2022-06-13 [2] CRAN (R 4.5.1)
#>  R.oo                   1.27.1    2025-05-02 [2] CRAN (R 4.5.1)
#>  R.utils                2.13.0    2025-02-24 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs               0.3.3     2021-01-31 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  RCurl                  1.98-1.17 2025-03-22 [2] CRAN (R 4.5.1)
#>  RefManageR           * 1.4.0     2022-09-30 [2] CRAN (R 4.5.1)
#>  rematch2               2.1.2     2020-05-01 [2] CRAN (R 4.5.1)
#>  restfulr               0.0.16    2025-06-27 [2] CRAN (R 4.5.1)
#>  rhdf5                  2.54.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  rhdf5filters           1.22.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  Rhdf5lib               1.32.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  rjson                  0.2.23    2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30      2025-09-28 [2] CRAN (R 4.5.1)
#>  Rsamtools              2.26.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  RSQLite                2.4.3     2025-08-20 [2] CRAN (R 4.5.1)
#>  rsvd                   1.0.5     2021-04-16 [2] CRAN (R 4.5.1)
#>  rtracklayer          * 1.70.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Arrays               1.10.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
#>  ScaledMatrix           1.18.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  scales                 1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
#>  scater                 1.38.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  scuttle                1.20.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  Seqinfo              * 1.0.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo          * 1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
#>  shape                  1.4.6.1   2024-02-23 [2] CRAN (R 4.5.1)
#>  shiny                  1.11.1    2025-07-03 [2] CRAN (R 4.5.1)
#>  shinyWidgets           0.9.0     2025-02-21 [2] CRAN (R 4.5.1)
#>  SingleCellExperiment * 1.32.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  SparseArray            1.10.1    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  sparseMatrixStats      1.22.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  SpatialExperiment    * 1.20.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  spatialLIBD          * 1.22.0    2025-11-04 [1] Bioconductor 3.22 (R 4.5.1)
#>  statmod                1.5.1     2025-10-09 [2] CRAN (R 4.5.1)
#>  stringi                1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment * 1.40.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr                  1.3.1     2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange             0.3.0     2024-01-18 [2] CRAN (R 4.5.1)
#>  tinytex                0.57      2025-04-15 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  vipor                  0.4.7     2023-12-18 [2] CRAN (R 4.5.1)
#>  viridis                0.6.5     2024-01-29 [2] CRAN (R 4.5.1)
#>  viridisLite            0.4.2     2023-05-02 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.54      2025-10-30 [2] CRAN (R 4.5.1)
#>  XML                    3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
#>  xml2                   1.4.1     2025-10-27 [2] CRAN (R 4.5.1)
#>  xtable                 1.8-4     2019-04-21 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpBXD2ka/Rinst8a4186f8154c0
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 10 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025), *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2014) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-amezquita2020orchestrating)
R. Amezquita, A. Lun, E. Becht, et al.
“Orchestrating single-cell analysis with Bioconductor”.
In: *Nature Methods* 17 (2020), pp. 137–145.
URL: <https://www.nature.com/articles/s41592-019-0654-x>.

[[3]](#cite-bates2025matrix)
D. Bates, M. Maechler, and M. Jagan.
*Matrix: Sparse and Dense Matrix Classes and Methods*.
R package version 1.7-4.
2025.
DOI: [10.32614/CRAN.package.Matrix](https://doi.org/10.32614/CRAN.package.Matrix).
URL: [https://CRAN.R-project.org/package=Matrix](https://CRAN.R-project.org/package%3DMatrix).

[[4]](#cite-chang2025shiny)
W. Chang, J. Cheng, J. Allaire, et al.
*shiny: Web Application Framework for R*.
R package version 1.11.1.
2025.
DOI: [10.32614/CRAN.package.shiny](https://doi.org/10.32614/CRAN.package.shiny).
URL: [https://CRAN.R-project.org/package=shiny](https://CRAN.R-project.org/package%3Dshiny).

[[5]](#cite-chen2025edger)
Y. Chen, L. Chen, A. T. L. Lun, et al.
“edgeR v4: powerful differential analysis of sequencing data with expanded functionality and improved support for small counts and larger datasets”.
In: *Nucleic Acids Research* 53.2 (2025), p. gkaf018.
DOI: [10.1093/nar/gkaf018](https://doi.org/10.1093/nar/gkaf018).

[[6]](#cite-fay2024golem)
C. Fay, V. Guyader, S. Rochette, et al.
*golem: A Framework for Robust Shiny Applications*.
R package version 0.5.1.
2024.
DOI: [10.32614/CRAN.package.golem](https://doi.org/10.32614/CRAN.package.golem).
URL: [https://CRAN.R-project.org/package=golem](https://CRAN.R-project.org/package%3Dgolem).

[[7]](#cite-garnier2023viridis)
Garnier, Simon, Ross, et al.
*viridis(Lite) - Colorblind-Friendly Color Maps for R*.
viridisLite package version 0.4.2.
2023.
DOI: [10.5281/zenodo.4678327](https://doi.org/10.5281/zenodo.4678327).
URL: <https://sjmgarnier.github.io/viridis/>.

[[8]](#cite-gillespie2022benchmarkme)
C. Gillespie.
*benchmarkme: Crowd Sourced System Benchmarks*.
R package version 1.0.8.
2022.
DOI: [10.32614/CRAN.package.benchmarkme](https://doi.org/10.32614/CRAN.package.benchmarkme).
URL: [https://CRAN.R-project.org/package=benchmarkme](https://CRAN.R-project.org/package%3Dbenchmarkme).

[[9]](#cite-gu2016complex)
Z. Gu, R. Eils, and M. Schlesner.
“Complex heatmaps reveal patterns and correlations in multidimensional genomic data”.
In: *Bioinformatics* (2016).
DOI: [10.1093/bioinformatics/btw313](https://doi.org/10.1093/bioinformatics/btw313).

[[10]](#cite-gu2014circlize)
Z. Gu, L. Gu, R. Eils, et al.
“circlize implements and enhances circular visualization in R”.
In: *Bioinformatics* 30 (19 2014), pp. 2811-2812.

[[11]](#cite-huber2015rchestrating)
Huber, W., Carey, et al.
“Orchestrating high-throughput genomic analysis with Bioconductor”.
In: *Nature Methods* 12.2 (2015), pp. 115–121.
URL: <http://www.nature.com/nmeth/journal/v12/n2/full/nmeth.3252.html>.

[[12]](#cite-huukimyers2024data)
L. A. Huuki-Myers, A. Spangler, N. J. Eagles, et al.
“A data-driven single-cell and spatial transcriptomic map of the human prefrontal cortex”.
In: *Science* (2024).
DOI: [10.1126/science.adh1938](https://doi.org/10.1126/science.adh1938).
URL: <https://doi.org/10.1126/science.adh1938>.

[[13]](#cite-hvitfeldt2021paletteer)
E. Hvitfeldt.
*paletteer: Comprehensive Collection of Color Palettes*.
R package version 1.3.0.
2021.
URL: <https://github.com/EmilHvitfeldt/paletteer>.

[[14]](#cite-kwon2023influence)
S. H. Kwon, S. Parthiban, M. Tippani, et al.
“Influence of Alzheimer’s disease related neuropathology on local microenvironment gene expression in the human inferior temporal cortex”.
In: *GEN Biotechnology* (2023).
DOI: [10.1089/genbio.2023.0019](https://doi.org/10.1089/genbio.2023.0019).
URL: <https://doi.org/10.1089/genbio.2023.0019>.

[[15]](#cite-lawrence2009rtracklayer)
M. Lawrence, R. Gentleman, and V. Carey.
“rtracklayer: an R package for interfacing with
genome browsers”.
In: *Bioinformatics* 25 (2009), pp. 1841-1842.
DOI: [10.1093/bioinformatics/btp328](https://doi.org/10.1093/bioinformatics/btp328).
URL: <http://bioinformatics.oxfordjournals.org/content/25/14/1841.abstract>.

[[16]](#cite-lawrence2013software)
M. Lawrence, W. Huber, H. Pagès, et al.
“Software for Computing and Annotating Genomic Ranges”.
In: *PLoS Computational Biology* 9 (8 2013).
DOI: [10.1371/journal.pcbi.1003118](https://doi.org/10.1371/journal.pcbi.1003118).
URL: [[http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1003118](http://www.ploscompbiol.org/article/info%3Adoi/10.1371/journal.pcbi.1003118)}.](http://www.ploscompbiol.org/article/info%3Adoi/10.1371/journal.pcbi.1003118%7D.)

[[17]](#cite-maynard2021transcriptome)
K. R. Maynard, L. Collado-Torres, L. M. Weber, et al.
“Transcriptome-scale spatial gene expression in the human dorsolateral prefrontal cortex”.
In: *Nature Neuroscience* (2021).
DOI: [10.1038/s41593-020-00787-0](https://doi.org/10.1038/s41593-020-00787-0).
URL: <https://www.nature.com/articles/s41593-020-00787-0>.

[[18]](#cite-mccarthy2017scater)
D. J. McCarthy, K. R. Campbell, A. T. L. Lun, et al.
“Scater: pre-processing, quality control, normalisation and visualisation of single-cell RNA-seq data in R”.
In: *Bioinformatics* 33 (8 2017), pp. 1179-1186.
DOI: [10.1093/bioinformatics/btw777](https://doi.org/10.1093/bioinformatics/btw777).

[[19]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[20]](#cite-morgan2025summarizedexperiment)
M. Morgan, V. Obenchain, J. Hester, et al.
*SummarizedExperiment: A container (S4 class) for matrix-like assays*.
R package version 1.40.0.
2025.
DOI: [10.18129/B9.bioc.SummarizedExperiment](https://doi.org/10.18129/B9.bioc.SummarizedExperiment).
URL: <https://bioconductor.org/packages/SummarizedExperiment>.

[[21]](#cite-morgan2025annotationhub)
M. Morgan and L. Shepherd.
*AnnotationHub: Client to access AnnotationHub resources*.
R package version 4.0.0.
2025.
DOI: [10.18129/B9.bioc.AnnotationHub](https://doi.org/10.18129/B9.bioc.AnnotationHub).
URL: <https://bioconductor.org/packages/AnnotationHub>.

[[22]](#cite-morgan2025experimenthub)
M. Morgan and L. Shepherd.
*ExperimentHub: Client to access ExperimentHub resources*.
R package version 3.0.0.
2025.
DOI: [10.18129/B9.bioc.ExperimentHub](https://doi.org/10.18129/B9.bioc.ExperimentHub).
URL: <https://bioconductor.org/packages/ExperimentHub>.

[[23]](#cite-neuwirth2022rcolorbrewer)
E. Neuwirth.
*RColorBrewer: ColorBrewer Palettes*.
R package version 1.1-3.
2022.
DOI: [10.32614/CRAN.package.RColorBrewer](https://doi.org/10.32614/CRAN.package.RColorBrewer).
URL: [https://CRAN.R-project.org/package=RColorBrewer](https://CRAN.R-project.org/package%3DRColorBrewer).

[[24]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[25]](#cite-ooms2025magick)
J. Ooms.
*magick: Advanced Graphics and Image-Processing in R*.
R package version 2.9.0.
2025.
DOI: [10.32614/CRAN.package.magick](https://doi.org/10.32614/CRAN.package.magick).
URL: [https://CRAN.R-project.org/package=magick](https://CRAN.R-project.org/package%3Dmagick).

[[26]](#cite-pags2025s4vectors)
H. Pagès, M. Lawrence, and P. Aboyoun.
*S4Vectors: Foundation of vector-like and list-like containers in Bioconductor*.
R package version 0.48.0.
2025.
DOI: [10.18129/B9.bioc.S4Vectors](https://doi.org/10.18129/B9.bioc.S4Vectors).
URL: <https://bioconductor.org/packages/S4Vectors>.

[[27]](#cite-pardo2022spatiallibd)
B. Pardo, A. Spangler, L. M. Weber, et al.
“spatialLIBD: an R/Bioconductor package to visualize spatially-resolved transcriptomics data”.
In: *BMC Genomics* (2022).
DOI: [10.1186/s12864-022-08601-w](https://doi.org/10.1186/s12864-022-08601-w).
URL: <https://doi.org/10.1186/s12864-022-08601-w>.

[[28]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[29]](#cite-righelli2022spatialexperiment)
D. Righelli, L. M. Weber, H. L. Crowell, et al.
“SpatialExperiment: infrastructure for spatially-resolved transcriptomics data in R using Bioconductor”.
In: *Bioinformatics* 38.11 (2022), pp. -3.
DOI: [https://doi.org/10.1093/bioinformatics/btac299](https://doi.org/https%3A//doi.org/10.1093/bioinformatics/btac299).

[[30]](#cite-ritchie2015limma)
M. E. Ritchie, B. Phipson, D. Wu, et al.
“limma powers differential expression analyses for RNA-sequencing and microarray studies”.
In: *Nucleic Acids Research* 43.7 (2015), p. e47.
DOI: [10.1093/nar/gkv007](https://doi.org/10.1093/nar/gkv007).

[[31]](#cite-shepherd2025biocfilecache)
L. Shepherd and M. Morgan.
*BiocFileCache: Manage Files Across Sessions*.
R package version 3.0.0.
2025.
DOI: [10.18129/B9.bioc.BiocFileCache](https://doi.org/10.18129/B9.bioc.BiocFileCache).
URL: <https://bioconductor.org/packages/BiocFileCache>.

[[32]](#cite-sievert2020interactive)
C. Sievert.
*Interactive Web-Based Data Visualization with R, plotly, and shiny*.
Chapman and Hall/CRC, 2020.
ISBN: 9781138331457.
URL: <https://plotly-r.com>.

[[33]](#cite-wickham2016ggplot2)
H. Wickham.
*ggplot2: Elegant Graphics for Data Analysis*.
Springer-Verlag New York, 2016.
ISBN: 978-3-319-24277-4.
URL: <https://ggplot2.tidyverse.org>.

[[34]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[35]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[36]](#cite-wilke2025cowplot)
C. Wilke.
*cowplot: Streamlined Plot Theme and Plot Annotations for ‘ggplot2’*.
R package version 1.2.0.
2025.
DOI: [10.32614/CRAN.package.cowplot](https://doi.org/10.32614/CRAN.package.cowplot).
URL: [https://CRAN.R-project.org/package=cowplot](https://CRAN.R-project.org/package%3Dcowplot).

[[37]](#cite-xie2014knitr)
Y. Xie.
“knitr: A Comprehensive Tool for Reproducible Research in R”.
In:
*Implementing Reproducible Computational Research*.
Ed. by V. Stodden, F. Leisch and R. D. Peng.
ISBN 978-1466561595.
Chapman and Hall/CRC, 2014.

[[38]](#cite-xie2025wrapper)
Y. Xie, J. Cheng, X. Tan, et al.
*DT: A Wrapper of the JavaScript Library ‘DataTables’*.
R package version 0.34.0.
2025.
DOI: [10.32614/CRAN.package.DT](https://doi.org/10.32614/CRAN.package.DT).
URL: [https://CRAN.R-project.org/package=DT](https://CRAN.R-project.org/package%3DDT).