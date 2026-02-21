# pcaExplorer User Guide

Federico Marini1,2\* and Harald Binder1

1Institute of Medical Biostatistics, Epidemiology and Informatics (IMBEI), Mainz
2Center for Thrombosis and Hemostasis (CTH), Mainz

\*marinif@uni-mainz.de

#### 30 October 2025

#### Abstract

*[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* provides functionality for interactive visualization of RNA-seq datasets based on Principal Components Analysis. Such methods allow for quick information extraction and effective data exploration. A Shiny application encapsulates the whole analysis, and is developed to become a practical companion for any RNA-seq dataset. This app supports reproducible research with state saving and automated report generation.

#### Package

pcaExplorer 3.4.0

**Package**: *pcaExplorer*

![](data:image/png;base64...)

# 1 Getting started

*[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* is an R package distributed as part of the [Bioconductor](http://bioconductor.org) project.
To install the package, start R and enter:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("pcaExplorer")
```

To install *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* with all its dependencies (i.e. also the ones listed in the `Suggests:` field of the `DESCRIPTION` file, which include the dataset from the *[airway](https://bioconductor.org/packages/3.22/airway)* package used as a demo), use this command instead:

```
BiocManager::install("pcaExplorer", dependencies = TRUE)
```

If you prefer, you can install and use the development version, which can be retrieved via Github (<https://github.com/federicomarini/pcaExplorer>).
To do so, use:

```
library("devtools")
install_github("federicomarini/pcaExplorer")
```

Once *pcaExplorer* is installed, it can be loaded by the following command.

```
library("pcaExplorer")
```

# 2 Introduction

*[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* is a Bioconductor package containing a Shiny application for analyzing expression data in different conditions and experimental factors.

It is a general-purpose interactive companion tool for RNA-seq analysis, which guides the user in exploring the Principal Components of the data under inspection.

*[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* provides tools and functionality to detect outlier samples, genes that show particular patterns, and additionally provides a functional interpretation of the principal components for further quality assessment and hypothesis generation on the input data.

Moreover, a novel visualization approach is presented to simultaneously assess the effect of more than one experimental factor on the expression levels.

Thanks to its interactive/reactive design, it is designed to become a practical companion to any RNA-seq dataset analysis, making exploratory data analysis accessible also to the bench biologist, while providing additional insight also for the experienced data analyst.

Starting from development version 1.1.3, *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* supports reproducible research with state saving and automated report generation.
Each generated plot and table can be exported by simple mouse clicks on the dedicated buttons.

## 2.1 Citation info

If you use *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* for your analysis, please cite it as here below:

```
citation("pcaExplorer")
```

```
#> Please cite the articles below for the 'pcaExplorer' software itself,
#> or its usage in combined workflows with the 'ideal' or 'GeneTonic'
#> software packages:
#>
#>   Federico Marini, Harald Binder (2019). pcaExplorer: an R/Bioconductor
#>   package for interacting with RNA-seq principal components. BMC
#>   Bioinformatics, 20 (1), 331, <doi:10.1186/s12859-019-2879-1>,
#>   <doi:10.18129/B9.bioc.pcaExplorer>.
#>
#>   Annekathrin Ludt, Arsenij Ustjanzew, Harald Binder, Konstantin
#>   Strauch, Federico Marini (2022). Interactive and Reproducible
#>   Workflows for Exploring and Modeling RNA-seq Data with pcaExplorer,
#>   ideal, and GeneTonic. Current Protocols, 2 (4), e411,
#>   <doi:10.1002/cpz1.411>.
#>
#> To see these entries in BibTeX format, use 'print(<citation>,
#> bibtex=TRUE)', 'toBibtex(.)', or set
#> 'options(citation.bibtex.max=999)'.
```

# 3 Launching the application

After loading the package, the *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* app can be launched in different modes:

* `pcaExplorer(dds = dds, dst = dst)`, where `dds` is a `DESeqDataSet` object and `dst` is a `DESeqTransform` object, which were created during an existing session for the analysis of an RNA-seq dataset with the *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* package.
* `pcaExplorer(dds = dds)`, where `dds` is a `DESeqDataSet` object. The `dst` object can be automatically computed upon launch, choosing between rlog transformation, variance stabilizing transformations, or shifted logarithm transformation (with pseudocount = 1).
* `pcaExplorer(countmatrix = countmatrix, coldata = coldata)`, where `countmatrix` is a count matrix, generated after assigning reads to features such as genes via tools such as `HTSeq-count` or `featureCounts`, and `coldata` is a data frame containing the experimental covariates of the experiments, such as condition, tissue, cell line, run batch and so on.
  If the data is provided in this way, the user can click on the “Generate the dds and dst objects” button to complete the setup and enable the subsequent steps in the other panels.
* `pcaExplorer()`, and then subsequently uploading the count matrix and the covariates data frame through the user interface. These files need to be formatted as tab, semicolon, or comma separated text files, all of which are common formats for storing such count values.

Additional parameters and objects that can be provided to the main *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* function are:

* `pca2go`, which is an object created by the `pca2go` function, which scans the genes with high loadings in each principal component and each direction, and looks for functions (such as GO Biological Processes) that are enriched above the background.
  The offline `pca2go` function is based on the routines and algorithms of the *[topGO](https://bioconductor.org/packages/3.22/topGO)* package, but as an alternative, this object can be computed live during the execution of the app with `limmaquickpca2go` (which relies on the `goana` function provided by the *[limma](https://bioconductor.org/packages/3.22/limma)* package).
  Although this likely provides more general (and probably less informative) functions, it is a good compromise for quickly obtaining a further data interpretation.
* `annotation`, a data frame object, with `row.names` as gene identifiers (e.g. ENSEMBL ids) identical to the row names of the count matrix or `dds` object, and an extra column `gene_name`, containing e.g. HGNC-based gene symbols.
  This can be used for making information extraction easier, as ENSEMBL ids (a usual choice when assigning reads to features) do not provide an immediate readout for which gene they refer to.
  This can be either passed as a parameter when launching the app, or also uploaded as a text file (either tab, comma, or semicolon-separated).
  The package provides two functions, `get_annotation` and `get_annotation_orgdb`, as a convenient wrapper to obtain the updated annotation information, respectively from `biomaRt` or via the `org.XX.eg.db` packages.

## 3.1 How to provide your input data in *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)*

*[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* supports a number of file formats when uploading the data via the file input widgets.
Starting from version 2.9.5, we added functionality to select the separator character for each of the uploadable files.
An information box is also shown by clicking on the question mark icon in the Data upload panel, with detailed information (text, as well as screenshots of valid input files) on the format specification.

In general, *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* requires by default tab separated files:

* the `countmatrix`: contains the expression matrix, with one gene per row and one sample per column; the first column should contain the gene identifiers, and the header (first row) specifies the sample names.
* the `coldata`: one sample per row, and one experimental covariate per column.
  Row names should be specified in the first column, and have to match the column names of the `countmatrix`.
  Column names will contain the specific experimental covariates.
* the `annotation` (optional): one gene per row, and one identifier type per column.
  Gene identifiers in the first column are identical to the row names of the `countmatrix` or `dds` objects.
  At least an extra column `gene_name`, containing e.g. HGNC-based gene symbols, needs to be provided.

## 3.2 Up and running with *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)*

We recommend users to switch to the [dedicated vignette](https://bioconductor.org/packages/3.22/pcaExplorer/vignettes/upandrunning.html), entitled “Up and running with *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)*”.

This document describes a use case for *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)*, based on the dataset in the *[airway](https://bioconductor.org/packages/3.22/airway)* package.

# 4 The controls sidebar

Most of the input controls are located in the sidebar, some are as well in the individual tabs of the app.
By changing one or more of the input parameters, the user can get a fine control on what is displayed.

## 4.1 App settings

Here are the parameters that set input values for most of the tabs.
By hovering over with the mouse, the user can receive additional information on how to set the parameter, with tooltips powered by the *[shinyBS](https://CRAN.R-project.org/package%3DshinyBS)* package.

* **x-axis PC** - Select the principal component to display on the x axis
* **y-axis PC** - Select the principal component to display on the y axis
* **Group/color by** - Select the group of samples to stratify the analysis. Can also assume multiple values.
* **Nr of (most variable) genes** - Number of genes to select for computing the principal components. The top n genes are selected ranked by their variance inter-samples
* **Alpha** - Color transparency for the plots. Can assume values from 0 (transparent) to 1 (opaque)
* **Labels size** - Size of the labels for the samples in the principal components plots.
  This parameter also controls the size of the gene labels, which are displayed in the Genes View once the user has brushed an area in the main plot.
* **Points size** - Size of the points to be plotted in the principal components plots
* **Variable name size** - Size of the labels for the genes PCA - correspond to the samples names
* **Scaling factor** - Scale value for resizing the arrow corresponding to the variables in the PCA for the genes. It should be used for mere visualization purposes
* **Color palette** - Select the color palette to be used in the principal components plots. The number of colors is selected automatically according to the number of samples and to the levels of the factors of interest and their interactions
* **Plot style for gene counts** - Plot either boxplots or violin plots, with jittered points superimposed

## 4.2 Plot export settings

**Width** and **height** for the figures to export are input here in cm.

Additional controls available in the single tabs are also assisted by tooltips that show on hovering the mouse.
Normally they are tightly related to the plot/output they are placed nearby.

# 5 The task menu

The task menu, accessible by clicking on the cog icon in the upper right part of the application, provides two functionalities:

* `Exit pcaExplorer & save` will close the application and store the content of the `input` and `values` reactive objects in two list objects made available in the global environment, called `pcaExplorer_inputs_YYYYMMDD_HHMMSS` and `pcaExplorer_values_YYYYMMDD_HHMMSS`
* `Save State as .RData` will similarly store `LiveInputs` and `r_data` in a binary file named `pcaExplorerState_YYYYMMDD_HHMMSS.Rdata`, without closing the application

# 6 The app panels

The *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* app is structured in different panels, each focused on a different aspect of the data exploration.

Most of the panels work extensively with click-based and brush-based interactions, to gain additional depth in the explorations, for example by zooming, subsetting, selecting.
This is possible thanks to the recent developments in the *[shiny](https://CRAN.R-project.org/package%3Dshiny)* package/framework.

The available panels are described in the following subsections.

## 6.1 Data Upload

These **file input** controls are available when no `dds` or `countmatrix` + `coldata` are provided.
Additionally, it is possible to upload the `annotation` data frame.
If the objects are already passed as parameters, or after they have been successfully uploaded, a brief overview/summary for them can be displayed, by clicking on each respective action button.

![](data:image/png;base64...)

This panel is where you can perform the preprocessing steps on the data you uploaded/provided:

* compose the `dds` object (if you provided `countmatrix` and `coldata`)
* normalize the expression values (using the robust method proposed by Anders and Huber in the original DESeq manuscript)
* compute the variance stabilizing transformed expression values (stored in the `dst` object).

As a note regarding the normalization procedure: the normalization method (implemented in `estimateSizeFactors`) relies on the hypothesis that most of the genes are not differentially expressed across experimental groups, and this holds true for the majority of scenarios.
The `DESeqDataSet` object, which pcaExplorer takes as main data container, can still accommodate sample (and gene) specific normalization factors.
Should this assumption be violated, users can pre-compute these factors and store them in the input `dds` object.

## 6.2 Instructions

This is where you might be reading a version of the “Up and running with *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)*” vignette.
Additionally, you can easily reach the fully rendered vignettes, either installed locally, or directly from the Bioconductor package page.

![](data:image/png;base64...)

## 6.3 Counts Table

Interactive tables for the raw, normalized or transformed (rlog, variance stabilized, or shifted log) counts are shown in this tab.
The user can also generate a sample-to-sample correlation scatter plot with the selected data.

![](data:image/png;base64...)

## 6.4 Data Overview

This panel displays information on the objects in use, either passed as parameters or generated from the count matrix provided.
Displayed information comprise the design metadata, a sample to sample distance heatmap, the number of million of reads per sample and some basic summary for the counts.

![](data:image/png;base64...)

## 6.5 Samples View

This panel displays the PCA projections of sample expression profiles onto any pair of components, a scree plot, a zoomed PCA plot, a plot of the genes with top and bottom loadings.
Additionally, this section presents a PCA plot where it is possible to remove samples deemed to be outliers in the analysis, which is very useful to check the effect of excluding them.
If needed, an interactive 3D visualization of the principal components is also available.

![](data:image/png;base64...)

## 6.6 Genes View

This panel displays the PCA projections of genes abundances onto any pair of components, with samples as biplot variables, to identify interesting groups of genes.
Zooming is also possible, and clicking on single genes, a boxplot is returned, grouped by the factors of interest.
A static and an interactive heatmap are provided, including the subset of selected genes, also displayed as (standardized) expression profiles across the samples.
These are also reported in `datatable` objects, accessible in the bottom part of the tab.

![](data:image/png;base64...)

## 6.7 GeneFinder

The user can search and display the expression values of a gene of interest, either by ID or gene name, as provided in the `annotation`.
A handy panel for quick screening of shortlisted genes, again grouped by the factors of interest.
The graphic can be readily exported as it is, and this can be iterated on a shortlisted set of genes.
For each of them, the underlying data is displayed in an interactive table, also exportable with a click.

![](data:image/png;base64...)

## 6.8 PCA2GO

This panel shows the functional annotation of the principal components, with GO functions enriched in the genes with high loadings on the selected principal components.
It allows for the live computing of the object, that can otherwise provided as a parameter when launching the app.
The panel displays a PCA plot for the samples, surrounded on each side by the tables with the functions enriched in each component and direction.

![](data:image/png;base64...)

### 6.8.1 More on the `pca2go` parameter

A note on the functionality provided by the PCA2GO tab: if it is not provided in the `pca2go` parameter, the user can still compute this object while using the app, and this is done using `limma::goana`.
The implementation of this function supports a few organism packages, which cover many use cases (human, mouse, rat, fruit fly, or chimpanzee), but some use cases are not directly covered (e.g. if you are working with plants like Arabidopsis Thaliana).

For example, with a dataset from Arabidopsis where the genes are encoded as TAIR (The Arabidopsis Information Resource) identifiers, one would ideally call the following commands

```
BiocManager::install("org.At.tair.db")
library("org.At.tair.db")
# skipping the steps where you normally would generate your dds_at object...
dds_at
vst_at <- DESeq2::vst(dds_at)
anno_at <- get_annotation_orgdb(dds_at,"org.At.tair.db", idtype = "TAIR")
# subset the background to include only the expressed genes
bg_ids <- rownames(dds_at)[rowSums(counts(dds_at)) > 0]
library(topGO)
pca2go_at <- pca2go(vst_at,
                    annotation = anno_at,
                    annopkg = "org.At.tair.db",
                    ensToGeneSymbol = TRUE,
                    background_genes = bg_ids)
# and finally, with all the objects prepared...
pcaExplorer(dds = dds_at, dst = vst_at, annotation = anno_at, pca2go = pca2go_at)
```

## 6.9 Multifactor Exploration

This panel allows for the multifactor exploration of datasets with 2 or more experimental factors.
The user has to select first the two factors and the levels for each.
Then, it is possible to combine samples from Factor1-Level1 in the selected order by clicking on each sample name, one for each level available in the selected Factor2.
In order to build the matrix, an equal number of samples for each level of Factor 1 is required, to keep the design somehow balanced.
A typical case for choosing factors 1 and 2 is for example when different conditions and tissues are present.

Once constructed, a plot is returned that tries to represent simultaneously the effect of the two factors on the data.
Each gene is represented by a dot-line-dot structure, with the color that is indicating the tissue (factor 2) where the gene is mostly expressed.
Each gene has two dots, one for each condition level (factor 1), and the position of the points is dictated by the scores of the principal components calculated on the matrix object.
The line connecting the dots is darker when the tissue where the gene is mostly expressed varies throughout the conditions.

This representation is under active development, and it is promising for identifying interesting sets or clusters of genes according to their behavior on the Principal Components subspaces.
Zooming and exporting of the underlying genes is also allowed by brushing on the main plot.

![](data:image/png;base64...)

## 6.10 Report Editor

The report editor is the backbone for generating and editing the interactive report on the basis of the uploaded data and the current state of the application.
General `Markdown options` and `Editor options` are available, and the text editor, based on the `shinyAce` package, contains a comprehensive template report, that can be edited to the best convenience of the user.

The editor supports R code autocompletion, making it easy to add new code chunks for additional sections.
A preview is available in the tab itself, and the report can be generated, saved and subsequently shared with simple mouse clicks.

![](data:image/png;base64...)

The functionality to display the report preview is based on `knit2html`, and some elements such as `DataTable` objects might not render correctly.
To render them correctly, please install the PhantomJS executable before launching the app.
This can be done by using the *[webshot](https://CRAN.R-project.org/package%3Dwebshot)* package and calling `webshot::install_phantomjs()` - HTML widgets will be rendered automatically as screenshots.
Alternatively, the more recent *[webshot2](https://CRAN.R-project.org/package%3Dwebshot2)* package uses the headless Chrome browser (via the *[chromote](https://CRAN.R-project.org/package%3Dchromote)* package, requiring Google Chrome or other Chromium-based browser).
Keep in mind that the fully rendered report (the one you can obtain with the “Generate & Save” button) is not affected by this, since it uses `rmarkdown::render()`.

## 6.11 About

Contains general information on *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)*, including the developer’s contact, the link to the development version in Github, as well as the output of `sessionInfo`, to use for reproducibility sake - or bug reporting.
Information for citing *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* is also reported.

![](data:image/png;base64...)

# 7 Running `pcaExplorer` on published datasets

We can run *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* for demonstration purpose on published datasets that are available as SummarizedExperiment in a Bioconductor experiment package.

We will use the *[airway](https://bioconductor.org/packages/3.22/airway)* dataset, which can be installed with this command:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("airway")
```

The *[airway](https://bioconductor.org/packages/3.22/airway)* package provides a `RangedSummarizedExperiment` object of read counts in genes for an RNA-Seq experiment on four human airway smooth muscle cell lines treated with dexamethasone.
More details such as gene models and count quantifications can be found in the *[airway](https://bioconductor.org/packages/3.22/airway)* package vignette.

The easiest way to explore the *[airway](https://bioconductor.org/packages/3.22/airway)* dataset is by clicking on the dedicated button in the **Data Upload** panel.

 Load the demo airway data

Otherwise, to run *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* on this dataset from the terminal/RStudio IDE, the following commands are required.
First, prepare the objects to be passed as parameters of *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)*.

```
library("airway")
library("DESeq2")

data("airway", package = "airway")

dds_airway <- DESeqDataSet(airway,design= ~ cell + dex)
dds_airway
```

```
#> class: DESeqDataSet
#> dim: 63677 8
#> metadata(2): '' version
#> assays(1): counts
#> rownames(63677): ENSG00000000003 ENSG00000000005 ... ENSG00000273492
#>   ENSG00000273493
#> rowData names(10): gene_id gene_name ... seq_coord_system symbol
#> colnames(8): SRR1039508 SRR1039509 ... SRR1039520 SRR1039521
#> colData names(9): SampleName cell ... Sample BioSample
```

```
rld_airway <- rlogTransformation(dds_airway)
rld_airway
```

```
#> class: DESeqTransform
#> dim: 63677 8
#> metadata(2): '' version
#> assays(1): ''
#> rownames(63677): ENSG00000000003 ENSG00000000005 ... ENSG00000273492
#>   ENSG00000273493
#> rowData names(17): gene_id gene_name ... dispFit rlogIntercept
#> colnames(8): SRR1039508 SRR1039509 ... SRR1039520 SRR1039521
#> colData names(10): SampleName cell ... BioSample sizeFactor
```

Then launch the app itself.

```
pcaExplorer(dds = dds_airway,
            dst = rld_airway)
```

The `annotation` for this dataset can be built by exploiting the *[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)* package.

```
library(org.Hs.eg.db)
genenames_airway <- mapIds(org.Hs.eg.db,keys = rownames(dds_airway),column = "SYMBOL",keytype="ENSEMBL")
annotation_airway <- data.frame(gene_name = genenames_airway,
                                row.names = rownames(dds_airway),
                                stringsAsFactors = FALSE)
head(annotation_airway)
```

```
#>                 gene_name
#> ENSG00000000003    TSPAN6
#> ENSG00000000005      TNMD
#> ENSG00000000419      DPM1
#> ENSG00000000457     SCYL3
#> ENSG00000000460     FIRRM
#> ENSG00000000938       FGR
```

or alternatively, by using the `get_annotation` or `get_annotation_orgdb` wrappers.

```
anno_df_orgdb <- get_annotation_orgdb(dds = dds_airway,
                                      orgdb_species = "org.Hs.eg.db",
                                      idtype = "ENSEMBL")

anno_df_biomart <- get_annotation(dds = dds_airway,
                                  biomart_dataset = "hsapiens_gene_ensembl",
                                  idtype = "ensembl_gene_id")
```

```
#> 'select()' returned 1:many mapping between keys and columns
```

```
head(anno_df_orgdb)
```

```
#>                         gene_id gene_name
#> ENSG00000000003 ENSG00000000003    TSPAN6
#> ENSG00000000005 ENSG00000000005      TNMD
#> ENSG00000000419 ENSG00000000419      DPM1
#> ENSG00000000457 ENSG00000000457     SCYL3
#> ENSG00000000460 ENSG00000000460     FIRRM
#> ENSG00000000938 ENSG00000000938       FGR
```

Then again, the app can be launched with:

```
pcaExplorer(dds = dds_airway,
            dst = rld_airway,
            annotation = annotation_airway) # or anno_df_orgdb, or anno_df_biomart
```

If desired, alternatives can be used.
See the well written annotation workflow available at the Bioconductor site (<https://bioconductor.org/help/workflows/annotation/annotation/>).

# 8 Running `pcaExplorer` on synthetic datasets

For testing and demonstration purposes, a function is also available to generate synthetic datasets whose counts are generated based on two or more experimental factors.

This can be called with the command:

```
dds_multifac <- makeExampleDESeqDataSet_multifac(betaSD_condition = 3,betaSD_tissue = 1)
```

See all the available parameters by typing `?makeExampleDESeqDataSet_multifac`.
Credits are given to the initial implementation by Mike Love in the *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* package.

The following steps run the app with the synthetic dataset.

```
dds_multifac <- makeExampleDESeqDataSet_multifac(betaSD_condition = 1,betaSD_tissue = 3)
dds_multifac
```

```
#> class: DESeqDataSet
#> dim: 1000 12
#> metadata(1): version
#> assays(1): counts
#> rownames(1000): gene1 gene2 ... gene999 gene1000
#> rowData names(4): trueIntercept trueBeta_condition trueBeta_tissue
#>   trueDisp
#> colnames(12): sample1 sample2 ... sample11 sample12
#> colData names(2): condition tissue
```

```
rld_multifac <- rlogTransformation(dds_multifac)
rld_multifac
```

```
#> class: DESeqTransform
#> dim: 1000 12
#> metadata(1): version
#> assays(1): ''
#> rownames(1000): gene1 gene2 ... gene999 gene1000
#> rowData names(11): trueIntercept trueBeta_condition ... dispFit
#>   rlogIntercept
#> colnames(12): sample1 sample2 ... sample11 sample12
#> colData names(3): condition tissue sizeFactor
```

```
## checking how the samples cluster on the PCA plot
pcaplot(rld_multifac,intgroup = c("condition","tissue"))
```

![](data:image/png;base64...)

Launch the app for exploring this dataset with:

```
pcaExplorer(dds = dds_multifac,
            dst = rld_multifac)
```

When such a dataset is provided, the panel for multifactorial exploration is also usable at its best.

# 9 Functions exported by the package for standalone usage

The functions exported by the *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* package can be also used in a standalone scenario, provided the required objects are in the working environment.
They are listed here for an overview, but please refer to the documentation for additional details.
Where possible, for each function a code snippet will be provided for its typical usage.

## 9.1 `pcaplot`

`pcaplot` plots the sample PCA for `DESeqTransform` objects, such as rlog-transformed data.
This is the workhorse of the Samples View tab.

```
pcaplot(rld_airway,intgroup = c("cell","dex"),ntop = 1000,
        pcX = 1, pcY = 2, title = "airway dataset PCA on samples - PC1 vs PC2")
```

![](data:image/png;base64...)

```
# on a different set of principal components...
pcaplot(rld_airway,intgroup = c("dex"),ntop = 1000,
        pcX = 1, pcY = 4, title = "airway dataset PCA on samples - PC1 vs PC4",
        ellipse = TRUE)
```

![](data:image/png;base64...)

## 9.2 `pcaplot3d`

Same as for `pcaplot`, but it uses the `threejs` package for the 3d interactive view.

```
pcaplot3d(rld_airway,intgroup = c("cell","dex"),ntop = 1000,
        pcX = 1, pcY = 2, pcZ = 3)
# will open up in the viewer
```

## 9.3 `pcascree`

`pcascree` produces a scree plot of the PC computed on the samples.
A `prcomp` object needs to be passed as main argument.

```
pcaobj_airway <- prcomp(t(assay(rld_airway)))
pcascree(pcaobj_airway,type="pev",
         title="Proportion of explained proportion of variance - airway dataset")
```

![](data:image/png;base64...)

## 9.4 `correlatePCs` and `plotPCcorrs`

`correlatePCs` and `plotPCcorrs` respectively compute and plot significance of the (cor)relation of each covariate versus a principal component.
The input for `correlatePCs` is a `prcomp` object.

```
res_pcairway <- correlatePCs(pcaobj_airway,colData(dds_airway))

res_pcairway
```

```
#>      SampleName       cell        dex albut       Run avgLength Experiment
#> PC_1  0.4288799 0.68227033 0.02092134    NA 0.4288799 0.2554109  0.4288799
#> PC_2  0.4288799 0.11161023 0.56370286    NA 0.4288799 0.1993592  0.4288799
#> PC_3  0.4288799 0.10377716 0.38647623    NA 0.4288799 0.1864725  0.4288799
#> PC_4  0.4288799 0.08331631 0.56370286    NA 0.4288799 0.4635148  0.4288799
#>         Sample BioSample
#> PC_1 0.4288799 0.4288799
#> PC_2 0.4288799 0.4288799
#> PC_3 0.4288799 0.4288799
#> PC_4 0.4288799 0.4288799
```

```
plotPCcorrs(res_pcairway)
```

![](data:image/png;base64...)

## 9.5 `hi_loadings`

`hi_loadings` extracts and optionally plots the genes with the highest loadings.

```
# extract the table of the genes with high loadings
hi_loadings(pcaobj_airway,topN = 10,exprTable=counts(dds_airway))
```

```
#>                 SRR1039508 SRR1039509 SRR1039512 SRR1039513 SRR1039516
#> ENSG00000143127         11        108         24        485         41
#> ENSG00000168309         12        274         35        451          1
#> ENSG00000101347       1632      17126       2098      19694       1598
#> ENSG00000211445        916      15749       3142      24057       1627
#> ENSG00000096060        260       4652        381       3875        601
#> ENSG00000163884         70       1325         52        702         36
#> ENSG00000171819          4         50         19        543          1
#> ENSG00000127954         13        247         25        889          2
#> ENSG00000152583         62       2040         99       1172        100
#> ENSG00000109906          4        739          5        429          1
#> ENSG00000162692        914         62       1192         55       1359
#> ENSG00000178695       4746        830       4805        414       5321
#> ENSG00000214814        312         24        193         28        501
#> ENSG00000164742       1506        347        275         14        137
#> ENSG00000138316       1327        207       1521        118       1962
#> ENSG00000123610        444        136        303         36       1170
#> ENSG00000124766       2483        406       2057        185       2829
#> ENSG00000105989        562         47       1575        106        106
#> ENSG00000013293        268         23        435         56        558
#> ENSG00000146250        330         41        907         89        720
#>                 SRR1039517 SRR1039520 SRR1039521
#> ENSG00000143127        607         77        660
#> ENSG00000168309         65          4        193
#> ENSG00000101347      17697       1683      32036
#> ENSG00000211445      16274       1741      24883
#> ENSG00000096060       5493        154       4118
#> ENSG00000163884        487         34       1355
#> ENSG00000171819         10         14       1067
#> ENSG00000127954        199         20        462
#> ENSG00000152583       1924         79       2138
#> ENSG00000109906        581         12       1113
#> ENSG00000162692        171        646         31
#> ENSG00000178695       1391       4411        606
#> ENSG00000214814         65        789         76
#> ENSG00000164742         37        475         56
#> ENSG00000138316        618       1045        152
#> ENSG00000123610        195        473         37
#> ENSG00000124766        870       1851        301
#> ENSG00000105989         24        382         46
#> ENSG00000013293         75        562         74
#> ENSG00000146250        123        439         60
```

```
# or alternatively plot the values
hi_loadings(pcaobj_airway,topN = 10,annotation = annotation_airway)
```

![](data:image/png;base64...)

## 9.6 `genespca`

`genespca` computes and plots the principal components of the genes, eventually displaying the samples as in a typical biplot visualization.
This is the function in action for the Genes View tab.

```
groups_airway <- colData(dds_airway)$dex
cols_airway <- scales::hue_pal()(2)[groups_airway]
# with many genes, do not plot the labels of the genes
genespca(rld_airway,ntop=5000,
         choices = c(1,2),
         arrowColors=cols_airway,groupNames=groups_airway,
         alpha = 0.2,
         useRownamesAsLabels=FALSE,
         varname.size = 5
        )
```

![](data:image/png;base64...)

```
# with a smaller number of genes, plot gene names included in the annotation
genespca(rld_airway,ntop=100,
         choices = c(1,2),
         arrowColors=cols_airway,groupNames=groups_airway,
         alpha = 0.7,
         varname.size = 5,
         annotation = annotation_airway
        )
```

![](data:image/png;base64...)

## 9.7 `topGOtable`

`topGOtable` is a convenient wrapper for extracting functional GO terms enriched in a subset of genes (such as the differentially expressed genes), based on the algorithm and the implementation in the *[topGO](https://bioconductor.org/packages/3.22/topGO)* package.

```
# example not run due to quite long runtime
dds_airway <- DESeq(dds_airway)
res_airway <- results(dds_airway)
res_airway$symbol <- mapIds(org.Hs.eg.db,
                            keys=row.names(res_airway),
                            column="SYMBOL",
                            keytype="ENSEMBL",
                            multiVals="first")
res_airway$entrez <- mapIds(org.Hs.eg.db,
                            keys=row.names(res_airway),
                            column="ENTREZID",
                            keytype="ENSEMBL",
                            multiVals="first")
resOrdered <- as.data.frame(res_airway[order(res_airway$padj),])
head(resOrdered)
# extract DE genes
de_df <- resOrdered[resOrdered$padj < .05 & !is.na(resOrdered$padj),]
de_symbols <- de_df$symbol
# extract background genes
bg_ids <- rownames(dds_airway)[rowSums(counts(dds_airway)) > 0]
bg_symbols <- mapIds(org.Hs.eg.db,
                     keys=bg_ids,
                     column="SYMBOL",
                     keytype="ENSEMBL",
                     multiVals="first")
# run the function
topgoDE_airway <- topGOtable(de_symbols, bg_symbols,
                             ontology = "BP",
                             mapping = "org.Hs.eg.db",
                             geneID = "symbol")
```

From version 2.32.0 onwards, the `topGOtable()` function has been deprecated, in favor of the equivalent `mosdef::run_topGO()` function, which is more robust and flexible in its usage.

## 9.8 `pca2go`

`pca2go` provides a functional interpretation of the principal components, by extracting the genes with the highest loadings for each PC, and then runs internally `topGOtable` on them for efficient functional enrichment analysis.
This function requires a `DESeqTransform` object as main parameter.

```
pca2go_airway <- pca2go(rld_airway,
                        annotation = annotation_airway,
                        organism = "Hs",
                        ensToGeneSymbol = TRUE,
                        background_genes = bg_ids)
# for a smooth interactive exploration, use DT::datatable
datatable(pca2go_airway$PC1$posLoad)
# display it in the normal R session...
head(pca2go_airway$PC1$posLoad)
# ... or use it for running the app and display in the dedicated tab
pcaExplorer(dds_airway,rld_airway,
            pca2go = pca2go_airway,
            annotation = annotation_airway)
```

## 9.9 `limmaquickpca2go`

`limmaquickpca2go` is an alternative to `pca2go`, used in the live running app, thanks to its fast implementation based on the `limma::goana` function.

```
goquick_airway <- limmaquickpca2go(rld_airway,
                                   pca_ngenes = 10000,
                                   inputType = "ENSEMBL",
                                   organism = "Hs")
# display it in the normal R session...
head(goquick_airway$PC1$posLoad)
# ... or use it for running the app and display in the dedicated tab
pcaExplorer(dds_airway,rld_airway,
            pca2go = goquick_airway,
            annotation = annotation_airway)
```

## 9.10 `makeExampleDESeqDataSet_multifac`

`makeExampleDESeqDataSet_multifac` constructs a simulated `DESeqDataSet` of Negative Binomial dataset from different conditions.
The fold changes between the conditions can be adjusted with the `betaSD_condition` and `betaSD_tissue` arguments.

```
dds_simu <- makeExampleDESeqDataSet_multifac(betaSD_condition = 3,betaSD_tissue = 0.5)
dds_simu
```

```
#> class: DESeqDataSet
#> dim: 1000 12
#> metadata(1): version
#> assays(1): counts
#> rownames(1000): gene1 gene2 ... gene999 gene1000
#> rowData names(4): trueIntercept trueBeta_condition trueBeta_tissue
#>   trueDisp
#> colnames(12): sample1 sample2 ... sample11 sample12
#> colData names(2): condition tissue
```

```
dds2_simu <- makeExampleDESeqDataSet_multifac(betaSD_condition = 0.5,betaSD_tissue = 2)
dds2_simu
```

```
#> class: DESeqDataSet
#> dim: 1000 12
#> metadata(1): version
#> assays(1): counts
#> rownames(1000): gene1 gene2 ... gene999 gene1000
#> rowData names(4): trueIntercept trueBeta_condition trueBeta_tissue
#>   trueDisp
#> colnames(12): sample1 sample2 ... sample11 sample12
#> colData names(2): condition tissue
```

```
rld_simu <- rlogTransformation(dds_simu)
rld2_simu <- rlogTransformation(dds2_simu)
pcaplot(rld_simu,intgroup = c("condition","tissue")) +
  ggplot2::ggtitle("Simulated data - Big condition effect, small tissue effect")
```

![](data:image/png;base64...)

```
pcaplot(rld2_simu,intgroup = c("condition","tissue")) +
  ggplot2::ggtitle("Simulated data - Small condition effect, bigger tissue effect")
```

![](data:image/png;base64...)

## 9.11 `distro_expr`

Plots the distribution of expression values, either with density lines, boxplots or violin plots.

```
distro_expr(rld_airway,plot_type = "density")
distro_expr(rld_airway,plot_type = "violin")
```

```
distro_expr(rld_airway,plot_type = "boxplot")
```

![](data:image/png;base64...)

## 9.12 `geneprofiler`

Plots the profile expression of a subset of genes, optionally as standardized values.

```
dds <- makeExampleDESeqDataSet_multifac(betaSD_condition = 3,betaSD_tissue = 1)
dst <- DESeq2::rlogTransformation(dds)
set.seed(42)
geneprofiler(dst,paste0("gene",sample(1:1000,20)), plotZ = FALSE)
```

```
#> You provided 20 unique identifiers
```

```
#> 20 out of 20 provided genes were found in the data
```

![](data:image/png;base64...)

## 9.13 `get_annotation` and `get_annotation_orgdb`

These two wrapper functions retrieve the latest annotations for the `dds` object, to be used in the call to the `pcaExplorer` function.
They use respectively the `biomaRt` package and the `org.XX.eg.db` packages.

```
anno_df_biomart <- get_annotation(dds = dds_airway,
                                  biomart_dataset = "hsapiens_gene_ensembl",
                                  idtype = "ensembl_gene_id")
```

```
anno_df_orgdb <- get_annotation_orgdb(dds = dds_airway,
                                      orgdb_species = "org.Hs.eg.db",
                                      idtype = "ENSEMBL")
```

```
#> 'select()' returned 1:many mapping between keys and columns
```

```
head(anno_df_orgdb)
```

```
#>                         gene_id gene_name
#> ENSG00000000003 ENSG00000000003    TSPAN6
#> ENSG00000000005 ENSG00000000005      TNMD
#> ENSG00000000419 ENSG00000000419      DPM1
#> ENSG00000000457 ENSG00000000457     SCYL3
#> ENSG00000000460 ENSG00000000460     FIRRM
#> ENSG00000000938 ENSG00000000938       FGR
```

If using datasets and annotation packages for yeast samples (*Saccharomyces cerevisiae*, and the `org.Sc.sgd.db` package), remember to specify the `key_for_genenames` in the call to `get_annotation_orgdb` (an error message is thrown otherwise).

## 9.14 `pair_corr`

Plots the pairwise scatter plots and computes the correlation coefficient on the expression matrix provided.

```
# use a subset of the counts to reduce plotting time, it can be time consuming with many samples
pair_corr(counts(dds_airway)[1:100,])
```

![](data:image/png;base64...)

# 10 Further development

Additional functionality for the *[pcaExplorer](https://bioconductor.org/packages/3.22/pcaExplorer)* will be added in the future, as it is tightly related to a topic under current development research.

Improvements, suggestions, bugs, issues and feedback of any type can be sent to marinif@uni-mainz.de.

# Session info

```
sessionInfo()
```

```
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
#>  [1] org.Hs.eg.db_3.22.0         AnnotationDbi_1.72.0
#>  [3] DESeq2_1.50.0               airway_1.29.0
#>  [5] SummarizedExperiment_1.40.0 GenomicRanges_1.62.0
#>  [7] Seqinfo_1.0.0               IRanges_2.44.0
#>  [9] S4Vectors_0.48.0            MatrixGenerics_1.22.0
#> [11] matrixStats_1.5.0           pcaExplorer_3.4.0
#> [13] bigmemory_4.6.4             Biobase_2.70.0
#> [15] BiocGenerics_0.56.0         generics_0.1.4
#> [17] knitr_1.50                  BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] fs_1.6.6                 bitops_1.0-9             enrichplot_1.30.0
#>   [4] fontawesome_0.5.3        httr_1.4.7               webshot_0.5.5
#>   [7] RColorBrewer_1.1-3       doParallel_1.0.17        Rgraphviz_2.54.0
#>  [10] tools_4.5.1              R6_2.6.1                 DT_0.34.0
#>  [13] mgcv_1.9-3               lazyeval_0.2.2           withr_3.0.2
#>  [16] prettyunits_1.2.0        gridExtra_2.3            cli_3.6.5
#>  [19] TSP_1.2-5                labeling_0.4.3           sass_0.4.10
#>  [22] topGO_2.62.0             S7_0.2.0                 genefilter_1.92.0
#>  [25] goseq_1.62.0             Rsamtools_2.26.0         systemfonts_1.3.1
#>  [28] yulab.utils_0.2.1        gson_0.1.0               txdbmaker_1.6.0
#>  [31] DOSE_4.4.0               R.utils_2.13.0           AnnotationForge_1.52.0
#>  [34] dichromat_2.0-0.1        limma_3.66.0             RSQLite_2.4.3
#>  [37] GOstats_2.76.0           gridGraphics_0.5-1       BiocIO_1.20.0
#>  [40] crosstalk_1.2.2          dplyr_1.1.4              dendextend_1.19.1
#>  [43] GO.db_3.22.0             Matrix_1.7-4             abind_1.4-8
#>  [46] R.methodsS3_1.8.2        lifecycle_1.0.4          yaml_2.3.10
#>  [49] qvalue_2.42.0            SparseArray_1.10.0       BiocFileCache_3.0.0
#>  [52] grid_4.5.1               blob_1.2.4               promises_1.4.0
#>  [55] crayon_1.5.3             shinydashboard_0.7.3     ggtangle_0.0.7
#>  [58] lattice_0.22-7           cowplot_1.2.0            GenomicFeatures_1.62.0
#>  [61] cigarillo_1.0.0          annotate_1.88.0          KEGGREST_1.50.0
#>  [64] magick_2.9.0             pillar_1.11.1            fgsea_1.36.0
#>  [67] rjson_0.2.23             codetools_0.2-20         fastmatch_1.1-6
#>  [70] glue_1.8.0               ggiraph_0.9.2            ggfun_0.2.0
#>  [73] fontLiberation_0.1.0     data.table_1.17.8        vctrs_0.6.5
#>  [76] png_0.1-8                treeio_1.34.0            gtable_0.3.6
#>  [79] assertthat_0.2.1         cachem_1.1.0             xfun_0.53
#>  [82] S4Arrays_1.10.0          mime_0.13                survival_3.8-3
#>  [85] pheatmap_1.0.13          seriation_1.5.8          iterators_1.0.14
#>  [88] tinytex_0.57             statmod_1.5.1            Category_2.76.0
#>  [91] nlme_3.1-168             ggtree_4.0.0             bit64_4.6.0-1
#>  [94] fontquiver_0.2.1         threejs_0.3.4            progress_1.2.3
#>  [97] filelock_1.0.3           GenomeInfoDb_1.46.0      bslib_0.9.0
#> [100] otel_0.2.0               colorspace_2.1-2         DBI_1.2.3
#> [103] tidyselect_1.2.1         bit_4.6.0                compiler_4.5.1
#> [106] curl_7.0.0               httr2_1.2.1              graph_1.88.0
#> [109] BiasedUrn_2.0.12         SparseM_1.84-2           fontBitstreamVera_0.1.1
#> [112] DelayedArray_0.36.0      plotly_4.11.0            bookdown_0.45
#> [115] rtracklayer_1.70.0       scales_1.4.0             mosdef_1.6.0
#> [118] RBGL_1.86.0              NMF_0.28                 rappdirs_0.3.3
#> [121] stringr_1.5.2            digest_0.6.37            shinyBS_0.61.1
#> [124] rmarkdown_2.30           ca_0.71.1                XVector_0.50.0
#> [127] htmltools_0.5.8.1        pkgconfig_2.0.3          base64enc_0.1-3
#> [130] dbplyr_2.5.1             fastmap_1.2.0            UCSC.utils_1.6.0
#> [133] rlang_1.1.6              htmlwidgets_1.6.4        shiny_1.11.1
#> [136] farver_2.1.2             jquerylib_0.1.4          jsonlite_2.0.0
#> [139] BiocParallel_1.44.0      GOSemSim_2.36.0          R.oo_1.27.1
#> [142] RCurl_1.98-1.17          magrittr_2.0.4           ggplotify_0.1.3
#> [145] patchwork_1.3.2          Rcpp_1.1.0               ape_5.8-1
#> [148] viridis_0.6.5            gdtools_0.4.4            stringi_1.8.7
#> [151] MASS_7.3-65              plyr_1.8.9               parallel_4.5.1
#> [154] ggrepel_0.9.6            bigmemory.sri_0.1.8      Biostrings_2.78.0
#> [157] splines_4.5.1            hms_1.1.4                geneLenDataBase_1.45.0
#> [160] locfit_1.5-9.12          igraph_2.2.1             uuid_1.2-1
#> [163] rngtools_1.5.2           reshape2_1.4.4           biomaRt_2.66.0
#> [166] XML_3.99-0.19            evaluate_1.0.5           BiocManager_1.30.26
#> [169] foreach_1.5.2            tweenr_2.0.3             httpuv_1.6.16
#> [172] tidyr_1.3.1              purrr_1.1.0              polyclip_1.10-7
#> [175] heatmaply_1.6.0          ggplot2_4.0.0            gridBase_0.4-7
#> [178] ggforce_0.5.0            xtable_1.8-4             restfulr_0.0.16
#> [181] tidytree_0.4.6           later_1.4.4              viridisLite_0.4.2
#> [184] tibble_3.3.0             clusterProfiler_4.18.0   aplot_0.2.9
#> [187] memoise_2.0.1            registry_0.5-1           GenomicAlignments_1.46.0
#> [190] cluster_2.1.8.1          GSEABase_1.72.0          shinyAce_0.4.4
```