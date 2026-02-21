# diffcyt workflow

Lukas M. Weber1,2, Malgorzata Nowicka1,2,3, Charlotte Soneson1,2,4 and Mark. D. Robinson1,2

1Institute of Molecular Life Sciences, University of Zurich, Zurich, Switzerland
2SIB Swiss Institute of Bioinformatics, University of Zurich, Zurich, Switzerland
3Current address: F. Hoffmann-La Roche AG, Basel, Switzerland
4Current address: Friedrich Miescher Institute for Biomedical Research and SIB Swiss Institute of Bioinformatics, Basel, Switzerland

#### 29 October 2025

#### Package

diffcyt 1.30.0

# Contents

* [1 Introduction](#introduction)
* [2 Overview of ‘diffcyt’ methodology](#overview-of-diffcyt-methodology)
  + [2.1 Summary](#summary)
  + [2.2 Differential abundance (DA) and differential states (DS)](#differential-abundance-da-and-differential-states-ds)
  + [2.3 Flexible experimental designs and contrasts](#flexible-experimental-designs-and-contrasts)
  + [2.4 More details](#more-details)
* [3 Installation](#installation)
* [4 ‘diffcyt’ pipeline](#diffcyt-pipeline)
  + [4.1 Dataset](#dataset)
  + [4.2 Load data from ‘HDCytoData’ package](#load-data-from-hdcytodata-package)
  + [4.3 Alternatively: load data from ‘.fcs’ files](#alternatively-load-data-from-.fcs-files)
  + [4.4 Set up meta-data](#set-up-meta-data)
  + [4.5 Set up design matrix (or model formula)](#set-up-design-matrix-or-model-formula)
  + [4.6 Set up contrast matrix](#set-up-contrast-matrix)
  + [4.7 Differential testing](#differential-testing)
    - [4.7.1 Option 1: Wrapper function using input data from ‘.fcs’ files](#option-1-wrapper-function-using-input-data-from-.fcs-files)
    - [4.7.2 Option 2: Wrapper function using CATALYST ‘daFrame’ object](#option-2-wrapper-function-using-catalyst-daframe-object)
    - [4.7.3 Option 3: Individual functions](#option-3-individual-functions)
* [5 Exporting data](#exporting-data)
* [6 Visualizations using ‘CATALYST’ package](#visualizations-using-catalyst-package)
  + [6.1 Overview](#overview)
  + [6.2 Heatmap: DA test results](#heatmap-da-test-results)
  + [6.3 Heatmap: DS test results](#heatmap-ds-test-results)
* [7 References](#references)
* **Appendix**

# 1 Introduction

The `diffcyt` package implements statistical methods for differential discovery analyses in high-dimensional cytometry data, based on a combination of high-resolution clustering and empirical Bayes moderated tests adapted from transcriptomics.

High-dimensional cytometry includes multi-color flow cytometry, mass cytometry (CyTOF), and oligonucleotide-tagged cytometry. These technologies use antibodies to measure expression levels of dozens (around 10 to 100) of marker proteins in thousands of cells. In many experiments, the aim is to detect differential abundance (DA) of cell populations, or differential states (DS) within cell populations, between groups of samples in different conditions (e.g. diseased vs. healthy, or treated vs. untreated).

This vignette provides a complete example workflow for running the `diffcyt` pipeline, using either the wrapper function `diffcyt()`, or the individual functions for each step.

The input to the `diffcyt` pipeline can either be raw data loaded from `.fcs` files, or a pre-prepared `daFrame` object from the [CATALYST](http://bioconductor.org/packages/CATALYST) Bioconductor package (Chevrier, Crowell, Zanotelli et al., 2018). The `CATALYST` package contains extensive functions for preprocessing, exploratory analysis, and visualization of mass cytometry (CyTOF) data. If this option is used, preprocessing and clustering are done using `CATALYST`. This is particularly useful when `CATALYST` has already been used for exploratory analyses and visualizations; the `diffcyt` package can then be used for differential testing. For more details on how to use `CATALYST` together with `diffcyt`, see the `CATALYST` [Bioconductor vignette](http://bioconductor.org/packages/release/bioc/vignettes/CATALYST/inst/doc/differential_analysis.html), or our extended [CyTOF workflow](http://bioconductor.org/packages/cytofWorkflow) (Nowicka et al., 2019) available from Bioconductor.

![](data:image/png;base64...)

# 2 Overview of ‘diffcyt’ methodology

## 2.1 Summary

The `diffcyt` methodology consists of two main components: (i) high-resolution clustering and (ii) empirical Bayes moderated tests adapted from transcriptomics.

We use high-resolution clustering to define a large number of small clusters representing cell populations. By default, we use the [FlowSOM](http://bioconductor.org/packages/FlowSOM) clustering algorithm (Van Gassen et al., 2015) to generate the high-resolution clusters, since we previously showed that this clustering algorithm gives excellent clustering performance together with fast runtimes for high-dimensional cytometry data (Weber and Robinson, 2016). However, in principle, other algorithms that can generate high-resolution clusters could also be used.

For the differential analyses, we use methods from the [edgeR](http://bioconductor.org/packages/edgeR) package (Robinson et al., 2010; McCarthy et al., 2012), [limma](http://bioconductor.org/packages/limma) package (Ritchie et al., 2015), and `voom` method (Law et al., 2014). These methods are widely used in the transcriptomics field, and have been adapted here for analyzing high-dimensional cytometry data. In addition, we provide alternative methods based on generalized linear mixed models (GLMMs), linear mixed models (LMMs), and linear models (LMs), originally implemented by Nowicka et al. (2017).

## 2.2 Differential abundance (DA) and differential states (DS)

The `diffcyt` methods can be used to test for differential abundance (DA) of cell populations, and differential states (DS) within cell populations.

To do this, the methodology requires the set of protein markers to be grouped into ‘cell type’ and ‘cell state’ markers. Cell type markers are used to define clusters representing cell populations, which are tested for differential abundance; and median cell state marker signals per cluster are used to test for differential states within populations.

The conceptual split into cell type and cell state markers facilitates biological interpretability, since it allows the results to be linked back to known cell types or populations of interest.

## 2.3 Flexible experimental designs and contrasts

The `diffcyt` model setup enables the user to specify flexible experimental designs, including batch effects, paired designs, and continuous covariates. Linear contrasts are used to specify the comparison of interest.

## 2.4 More details

A complete description of the statistical methodology and comparisons with existing approaches are provided in our paper introducing the `diffcyt` framework ([Weber et al., 2019](https://www.biorxiv.org/content/10.1101/349738v3)).

# 3 Installation

The stable release version of the `diffcyt` package can be installed using the Bioconductor installer. Note that this requires R version 3.4.0 or later.

```
# Install Bioconductor installer from CRAN
install.packages("BiocManager")

# Install 'diffcyt' package from Bioconductor
BiocManager::install("diffcyt")
```

To run all examples in this vignette, you will also need the `HDCytoData` and `CATALYST` packages from Bioconductor.

```
BiocManager::install("HDCytoData")
BiocManager::install("CATALYST")
```

# 4 ‘diffcyt’ pipeline

## 4.1 Dataset

For the example workflow in this vignette, we use the `Bodenmiller_BCR_XL` dataset, originally from Bodenmiller et al. (2012).

This is a publicly available mass cytometry (CyTOF) dataset, consisting of paired samples of healthy peripheral blood mononuclear cells (PBMCs), where one sample from each pair was stimulated with B cell receptor / Fc receptor cross-linker (BCR-XL). The dataset contains 16 samples (8 paired samples); a total of 172,791 cells; and a total of 24 protein markers. The markers consist of 10 ‘cell type’ markers (which can be used to define cell populations or clusters), and 14 ‘cell state’ or signaling markers.

This dataset contains known strong differential expression signals for several signaling markers in several cell populations, especially B cells. In particular, the strongest observed differential signal is for the signaling marker phosphorylated S6 (pS6) in B cells (see Nowicka et al., 2017, Figure 29). In this workflow, we will show how to perform differential tests to recover this signal.

## 4.2 Load data from ‘HDCytoData’ package

The `Bodenmiller_BCR_XL` dataset can be downloaded and loaded conveniently from the [HDCytoData](http://bioconductor.org/packages/HDCytoData) Bioconductor ‘experiment data’ package. It can be loaded in either `SummarizedExperiment` or `flowSet` format. Here, we use the `flowSet` format, which is standard in the flow and mass cytometry community. For some alternative analysis pipelines, the `SummarizedExperiment` format may be more convenient. For more details, see the help file for this dataset in the `HDCytoData` package (`library(HDCytoData)`; `?Bodenmiller_BCR_XL`).

```
suppressPackageStartupMessages(library(HDCytoData))

# Download and load 'Bodenmiller_BCR_XL' dataset in 'flowSet' format
d_flowSet <- Bodenmiller_BCR_XL_flowSet()
```

```
## see ?HDCytoData and browseVignettes('HDCytoData') for documentation
```

```
## loading from cache
```

```
## Warning in updateObjectFromSlots(object, ..., verbose = verbose): dropping
## slot(s) 'colnames' from object = 'flowSet'
```

```
suppressPackageStartupMessages(library(flowCore))

# check data format
d_flowSet
```

```
## A flowSet with 16 experiments.
##
## column names(39): Time Cell_length ... sample_id population_id
```

```
# sample names
pData(d_flowSet)
```

```
##                                                                  name
## PBMC8_30min_patient1_BCR-XL.fcs       PBMC8_30min_patient1_BCR-XL.fcs
## PBMC8_30min_patient1_Reference.fcs PBMC8_30min_patient1_Reference.fcs
## PBMC8_30min_patient2_BCR-XL.fcs       PBMC8_30min_patient2_BCR-XL.fcs
## PBMC8_30min_patient2_Reference.fcs PBMC8_30min_patient2_Reference.fcs
## PBMC8_30min_patient3_BCR-XL.fcs       PBMC8_30min_patient3_BCR-XL.fcs
## PBMC8_30min_patient3_Reference.fcs PBMC8_30min_patient3_Reference.fcs
## PBMC8_30min_patient4_BCR-XL.fcs       PBMC8_30min_patient4_BCR-XL.fcs
## PBMC8_30min_patient4_Reference.fcs PBMC8_30min_patient4_Reference.fcs
## PBMC8_30min_patient5_BCR-XL.fcs       PBMC8_30min_patient5_BCR-XL.fcs
## PBMC8_30min_patient5_Reference.fcs PBMC8_30min_patient5_Reference.fcs
## PBMC8_30min_patient6_BCR-XL.fcs       PBMC8_30min_patient6_BCR-XL.fcs
## PBMC8_30min_patient6_Reference.fcs PBMC8_30min_patient6_Reference.fcs
## PBMC8_30min_patient7_BCR-XL.fcs       PBMC8_30min_patient7_BCR-XL.fcs
## PBMC8_30min_patient7_Reference.fcs PBMC8_30min_patient7_Reference.fcs
## PBMC8_30min_patient8_BCR-XL.fcs       PBMC8_30min_patient8_BCR-XL.fcs
## PBMC8_30min_patient8_Reference.fcs PBMC8_30min_patient8_Reference.fcs
```

```
# number of cells
fsApply(d_flowSet, nrow)
```

```
##                                     [,1]
## PBMC8_30min_patient1_BCR-XL.fcs     2838
## PBMC8_30min_patient1_Reference.fcs  2739
## PBMC8_30min_patient2_BCR-XL.fcs    16675
## PBMC8_30min_patient2_Reference.fcs 16725
## PBMC8_30min_patient3_BCR-XL.fcs    12252
## PBMC8_30min_patient3_Reference.fcs  9434
## PBMC8_30min_patient4_BCR-XL.fcs     8990
## PBMC8_30min_patient4_Reference.fcs  6906
## PBMC8_30min_patient5_BCR-XL.fcs     8543
## PBMC8_30min_patient5_Reference.fcs 11962
## PBMC8_30min_patient6_BCR-XL.fcs     8622
## PBMC8_30min_patient6_Reference.fcs 11038
## PBMC8_30min_patient7_BCR-XL.fcs    14770
## PBMC8_30min_patient7_Reference.fcs 15974
## PBMC8_30min_patient8_BCR-XL.fcs    11653
## PBMC8_30min_patient8_Reference.fcs 13670
```

```
# dimensions
dim(exprs(d_flowSet[[1]]))
```

```
## [1] 2838   39
```

```
# expression values
exprs(d_flowSet[[1]])[1:6, 1:5]
```

```
##       Time Cell_length CD3(110:114)Dd CD45(In115)Dd BC1(La139)Dd
## [1,] 33073          30     120.823265      454.6009     576.8983
## [2,] 36963          35     135.106171      624.6824     564.6299
## [3,] 37892          30      -1.664619      601.0125    3077.2668
## [4,] 41345          58     115.290245      820.7125    6088.5967
## [5,] 42475          35      14.373802      326.6405    4606.6929
## [6,] 44620          31      37.737877      557.0137    4854.1519
```

## 4.3 Alternatively: load data from ‘.fcs’ files

Alternatively, you can load data directly from a set of `.fcs` files using the following code. Note that we use the options `transformation = FALSE` and `truncate_max_range = FALSE` to disable automatic transformations and data truncation performed by the `flowCore` package. (The automatic options in the `flowCore` package are optimized for flow cytometry instead of mass cytometry data, so these options should be disabled for mass cytometry data.)

```
# Alternatively: load data from '.fcs' files
files <- list.files(
  path = "path/to/files", pattern = "\\.fcs$", full.names = TRUE
)
d_flowSet <- read.flowSet(
  files, transformation = FALSE, truncate_max_range = FALSE
)
```

## 4.4 Set up meta-data

Next, we set up the ‘meta-data’ required for the `diffcyt` pipeline. The meta-data describes the samples and protein markers for this experiment or dataset. The meta-data should be saved in two data frames: `experiment_info` and `marker_info`.

The `experiment_info` data frame contains information about each sample, including sample IDs, group IDs, batch IDs or patient IDs (if relevant), continuous covariates such as age (if relevant), and any other factors or covariates. In many experiments, the main comparison of interest will be between levels of the group IDs factor (which may also be referred to as condition or treatment; e.g. diseased vs. healthy, or treated vs. untreated).

The `marker_info` data frame contains information about the protein markers, including channel names, marker names, and the class of each marker (cell type or cell state).

Below, we create these data frames manually. Depending on your experiment, it may be more convenient to save the meta-data in spreadsheets in `.csv` format, which can then be loaded using `read.csv`.

Extra care should be taken here to ensure that all samples and markers are in the correct order. In the code below, we display the final data frames to check them.

```
# Meta-data: experiment information

# check sample order
filenames <- as.character(pData(d_flowSet)$name)

# sample information
sample_id <- gsub("^PBMC8_30min_", "", gsub("\\.fcs$", "", filenames))
group_id <- factor(
  gsub("^patient[0-9]+_", "", sample_id), levels = c("Reference", "BCR-XL")
)
patient_id <- factor(gsub("_.*$", "", sample_id))

experiment_info <- data.frame(
  group_id, patient_id, sample_id, stringsAsFactors = FALSE
)
experiment_info
```

```
##     group_id patient_id          sample_id
## 1     BCR-XL   patient1    patient1_BCR-XL
## 2  Reference   patient1 patient1_Reference
## 3     BCR-XL   patient2    patient2_BCR-XL
## 4  Reference   patient2 patient2_Reference
## 5     BCR-XL   patient3    patient3_BCR-XL
## 6  Reference   patient3 patient3_Reference
## 7     BCR-XL   patient4    patient4_BCR-XL
## 8  Reference   patient4 patient4_Reference
## 9     BCR-XL   patient5    patient5_BCR-XL
## 10 Reference   patient5 patient5_Reference
## 11    BCR-XL   patient6    patient6_BCR-XL
## 12 Reference   patient6 patient6_Reference
## 13    BCR-XL   patient7    patient7_BCR-XL
## 14 Reference   patient7 patient7_Reference
## 15    BCR-XL   patient8    patient8_BCR-XL
## 16 Reference   patient8 patient8_Reference
```

```
# Meta-data: marker information

# source: Bruggner et al. (2014), Table 1

# column indices of all markers, lineage markers, and functional markers
cols_markers <- c(3:4, 7:9, 11:19, 21:22, 24:26, 28:31, 33)
cols_lineage <- c(3:4, 9, 11, 12, 14, 21, 29, 31, 33)
cols_func <- setdiff(cols_markers, cols_lineage)

# channel and marker names
channel_name <- colnames(d_flowSet)
marker_name <- gsub("\\(.*$", "", channel_name)

# marker classes
# note: using lineage markers for 'cell type', and functional markers for
# 'cell state'
marker_class <- rep("none", ncol(d_flowSet[[1]]))
marker_class[cols_lineage] <- "type"
marker_class[cols_func] <- "state"
marker_class <- factor(marker_class, levels = c("type", "state", "none"))

marker_info <- data.frame(
  channel_name, marker_name, marker_class, stringsAsFactors = FALSE
)
marker_info
```

```
##       channel_name   marker_name marker_class
## 1             Time          Time         none
## 2      Cell_length   Cell_length         none
## 3   CD3(110:114)Dd           CD3         type
## 4    CD45(In115)Dd          CD45         type
## 5     BC1(La139)Dd           BC1         none
## 6     BC2(Pr141)Dd           BC2         none
## 7   pNFkB(Nd142)Dd         pNFkB        state
## 8    pp38(Nd144)Dd          pp38        state
## 9     CD4(Nd145)Dd           CD4         type
## 10    BC3(Nd146)Dd           BC3         none
## 11   CD20(Sm147)Dd          CD20         type
## 12   CD33(Nd148)Dd          CD33         type
## 13 pStat5(Nd150)Dd        pStat5        state
## 14  CD123(Eu151)Dd         CD123         type
## 15   pAkt(Sm152)Dd          pAkt        state
## 16 pStat1(Eu153)Dd        pStat1        state
## 17  pSHP2(Sm154)Dd         pSHP2        state
## 18 pZap70(Gd156)Dd        pZap70        state
## 19 pStat3(Gd158)Dd        pStat3        state
## 20    BC4(Tb159)Dd           BC4         none
## 21   CD14(Gd160)Dd          CD14         type
## 22 pSlp76(Dy164)Dd        pSlp76        state
## 23    BC5(Ho165)Dd           BC5         none
## 24   pBtk(Er166)Dd          pBtk        state
## 25 pPlcg2(Er167)Dd        pPlcg2        state
## 26   pErk(Er168)Dd          pErk        state
## 27    BC6(Tm169)Dd           BC6         none
## 28   pLat(Er170)Dd          pLat        state
## 29    IgM(Yb171)Dd           IgM         type
## 30    pS6(Yb172)Dd           pS6        state
## 31 HLA-DR(Yb174)Dd        HLA-DR         type
## 32    BC7(Lu175)Dd           BC7         none
## 33    CD7(Yb176)Dd           CD7         type
## 34  DNA-1(Ir191)Dd         DNA-1         none
## 35  DNA-2(Ir193)Dd         DNA-2         none
## 36        group_id      group_id         none
## 37      patient_id    patient_id         none
## 38       sample_id     sample_id         none
## 39   population_id population_id         none
```

## 4.5 Set up design matrix (or model formula)

To calculate differential tests, the `diffcyt` functions require a design matrix (or model formula) describing the experimental design. (The choice between design matrix and model formula depends on the differential testing method used; see help files for the differential testing methods for details.)

Design matrices can be created in the required format using the function `createDesignMatrix()`. Design matrices are required for methods `diffcyt-DA-edgeR` (default method for DA testing), `diffcyt-DA-voom`, and `diffcyt-DS-limma` (default method for DS testing).

Similarly, model formulas can be created with the function `createFormula()`. Model formulas are required for the alternative methods `diffcyt-DA-GLMM` (DA testing) and `diffcyt-DS-LMM` (DS testing).

In both cases, flexible experimental designs are possible, including blocking (e.g. batch effects or paired designs) and continuous covariates. See `?createDesignMatrix` or `?createFormula` for more details and examples.

Note that in the example shown here, we include terms for `group_id` and `patient_id` in the design matrix: `group_id` is the factor of interest for the differential tests, and `patient_id` is included because this dataset contains paired samples from each patient. (For an unpaired dataset, only `group_id` would be included.)

```
suppressPackageStartupMessages(library(diffcyt))

# Create design matrix
# note: selecting columns containing group IDs and patient IDs (for an
# unpaired dataset, only group IDs would be included)
design <- createDesignMatrix(
  experiment_info, cols_design = c("group_id", "patient_id")
)
```

## 4.6 Set up contrast matrix

A contrast matrix is also required in order to calculate differential tests. The contrast matrix specifies the comparison of interest, i.e. the combination of model parameters assumed to equal zero under the null hypothesis.

Contrast matrices can be created in the required format using the function `createContrast()`. This function requires a single argument: a numeric vector defining the contrast. In many cases, this will simply be a vector of zeros and a single entry equal to one, which will test whether a single parameter is equal to zero. If a design matrix has been used, the entries correspond to the columns of the design matrix; if a model formula has been used, the entries correspond to the levels of the fixed effect terms.

See `?createContrast` for more details.

Here, we are interested in comparing condition `BCR-XL` against `Reference`, i.e. comparing the `BCR-XL` level against the `Reference` level for the `group_id` factor in the `experiment_info` data frame. This corresponds to testing whether the coefficient for column `group_idBCR-XL` in the design matrix `design` is equal to zero. This contrast can be specified as follows. (Note that there is one value per coefficient, including the intercept term; and rows in the final contrast matrix correspond to columns in the design matrix.)

```
# Create contrast matrix
contrast <- createContrast(c(0, 1, rep(0, 7)))

# check
nrow(contrast) == ncol(design)
```

```
## [1] TRUE
```

```
data.frame(parameters = colnames(design), contrast)
```

```
##           parameters contrast
## 1        (Intercept)        0
## 2     group_idBCR-XL        1
## 3 patient_idpatient2        0
## 4 patient_idpatient3        0
## 5 patient_idpatient4        0
## 6 patient_idpatient5        0
## 7 patient_idpatient6        0
## 8 patient_idpatient7        0
## 9 patient_idpatient8        0
```

## 4.7 Differential testing

The steps above show how to load the data, set up the meta-data, set up the design matrix, and set up the contrast matrix. Now, we can begin calculating differential tests.

Several alternative options are available for running the `diffcyt` differential testing functions. Which of these is most convenient will depend on the types of analyses or pipeline that you are running. The options are:

* Option 1: Run wrapper function using input data loaded from `.fcs` files. The input data can be provided as a `flowSet`, or a `list` of `flowFrames`, `DataFrames`, or `data.frames`.
* Option 2: Run wrapper function using previously created `CATALYST` `daFrame` object.
* Option 3: Run individual functions for the pipeline.

The following sections demonstrate these options using the `Bodenmiller_BCR_XL` example dataset described above.

### 4.7.1 Option 1: Wrapper function using input data from ‘.fcs’ files

The `diffcyt` package includes a ‘wrapper function’ called `diffcyt()`, which accepts input data in various formats and runs all the steps in the `diffcyt` pipeline in the correct sequence.

In this section, we show how to run the wrapper function using input data loaded from `.fcs` files as a `flowSet` object. The procedure is identical for data loaded from `.fcs` files as a `list` of `flowFrames`, `DataFrames`, or `data.frames`. See `?diffcyt` for more details.

The main inputs required by the `diffcyt()` wrapper function for this option are:

* `d_input` (input data)
* `experiment_info` (meta-data describing samples)
* `marker_info` (meta-data describing markers)
* `design` (design matrix)
* `contrast` (contrast matrix)

In addition, we require arguments to specify the type of analysis and (optionally) the method to use.

* `analysis_type` (type of analysis: DA or DS)
* `method_DA` (optional: method for DA testing; default is `diffcyt-DA-edgeR`)
* `method_DS` (optional: method for DS testing; default is `diffcyt-DS-limma`)

A number of additional arguments for optional parameter choices are also available; e.g. to specify the markers to use for differential testing, the markers to use for clustering, subsampling, transformation options, clustering options, filtering, and normalization. For complete details, see the help file for the wrapper function (`?diffcyt`).

Below, we run the wrapper function twice: once to test for differential abundance (DA) of clusters, and again to test for differential states (DS) within clusters. Note that in the `Bodenmiller_BCR_XL` dataset, the main differential signal of interest (the signal we are trying to recover) is differential expression of phosphorylated S6 (pS6) within B cells (i.e. DS testing). Therefore, the DA tests are not particularly meaningful in biological terms in this case; but we include them here for demonstration purposes in order to show how to run the methods.

The main results from the differential tests consist of adjusted p-values for each cluster (for DA tests) or each cluster-marker combination (for DS tests), which can be used to rank the clusters or cluster-marker combinations by the strength of their differential evidence. The function `topTable()` can be used to display a table of results for the top (most highly significant) detected clusters or cluster-marker combinations. We also use the output from `topTable()` to generate a summary table of the number of detected clusters or cluster-marker combinations at a given adjusted p-value threshold. See `?diffcyt` and `?topTable` for more details.

```
# Test for differential abundance (DA) of clusters

# note: using default method 'diffcyt-DA-edgeR' and default parameters
# note: include random seed for reproducible clustering
out_DA <- diffcyt(
  d_input = d_flowSet,
  experiment_info = experiment_info,
  marker_info = marker_info,
  design = design,
  contrast = contrast,
  analysis_type = "DA",
  seed_clustering = 123
)
```

```
## preparing data...
```

```
## transforming data...
```

```
## generating clusters...
```

```
## FlowSOM clustering completed in 7 seconds
```

```
## calculating features...
```

```
## calculating DA tests using method 'diffcyt-DA-edgeR'...
```

```
# display table of results for top DA clusters
topTable(out_DA, format_vals = TRUE)
```

```
## DataFrame with 20 rows and 3 columns
##     cluster_id     p_val     p_adj
##       <factor> <numeric> <numeric>
## 97          97  5.60e-51  5.60e-49
## 3           3   3.50e-40  1.75e-38
## 8           8   8.04e-36  2.68e-34
## 43          43  1.76e-33  4.40e-32
## 9           9   7.69e-32  1.54e-30
## ...        ...       ...       ...
## 26          26  9.00e-22  5.62e-21
## 73          73  1.19e-20  7.00e-20
## 6           6   1.43e-20  7.97e-20
## 31          31  5.30e-19  2.79e-18
## 89          89  9.55e-18  4.77e-17
```

```
# calculate number of significant detected DA clusters at 10% false discovery
# rate (FDR)
threshold <- 0.1
res_DA_all <- topTable(out_DA, all = TRUE)
table(res_DA_all$p_adj <= threshold)
```

```
##
## FALSE  TRUE
##    25    75
```

```
# Test for differential states (DS) within clusters

# note: using default method 'diffcyt-DS-limma' and default parameters
# note: include random seed for reproducible clustering
out_DS <- diffcyt(
  d_input = d_flowSet,
  experiment_info = experiment_info,
  marker_info = marker_info,
  design = design,
  contrast = contrast,
  analysis_type = "DS",
  seed_clustering = 123,
  plot = FALSE
)
```

```
## preparing data...
```

```
## transforming data...
```

```
## generating clusters...
```

```
## FlowSOM clustering completed in 7.2 seconds
```

```
## calculating features...
```

```
## calculating DS tests using method 'diffcyt-DS-limma'...
```

```
## Warning: Partial NA coefficients for 14 probe(s)
```

```
# display table of results for top DS cluster-marker combinations
topTable(out_DS, format_vals = TRUE)
```

```
## DataFrame with 20 rows and 4 columns
##     cluster_id marker_id     p_val     p_adj
##       <factor>  <factor> <numeric> <numeric>
## 30          30    pS6     5.20e-11  7.28e-08
## 19          19    pS6     5.17e-10  3.62e-07
## 19          19    pPlcg2  2.27e-09  9.26e-07
## 10          10    pS6     2.65e-09  9.26e-07
## 20          20    pS6     4.37e-09  1.22e-06
## ...        ...       ...       ...       ...
## 7           7     pBtk    4.59e-07  3.78e-05
## 11          11    pBtk    4.59e-07  3.78e-05
## 19          19    pAkt    6.36e-07  4.87e-05
## 19          19    pZap70  6.87e-07  4.87e-05
## 1           1     pBtk    6.96e-07  4.87e-05
```

```
# calculate number of significant detected DS cluster-marker combinations at
# 10% false discovery rate (FDR)
threshold <- 0.1
res_DS_all <- topTable(out_DS, all = TRUE)
table(res_DS_all$p_adj <= threshold)
```

```
##
## FALSE  TRUE
##   568   832
```

### 4.7.2 Option 2: Wrapper function using CATALYST ‘daFrame’ object

The second option for running the `diffcyt` pipeline is to provide a previously created [CATALYST](http://bioconductor.org/packages/CATALYST) `daFrame` object as the input to the `diffcyt()` wrapper function. As mentioned above, the `CATALYST` package contains extensive functions for preprocessing, exploratory analysis, and visualization of mass cytometry (CyTOF) data. This option is particularly useful when `CATALYST` has already been used for exploratory analyses (including clustering) and visualizations. The `diffcyt` methods can then be used to calculate differential tests using the existing `daFrame` object (in particular, re-using existing cluster labels stored in the `daFrame` object).

As above for option 1, the `diffcyt()` wrapper function requires several arguments to specify the inputs and analysis type, and provides additional arguments to specify optional parameter choices. Note that the arguments `experiment_info` and `marker_info` are not required in this case, since this information is already contained within the `CATALYST` `daFrame` object. An additional argument `clustering_to_use` is also provided, which allows the user to choose from one of several columns of cluster labels stored within the `daFrame` object; this set of cluster labels will then be used for the differential tests. See `?diffcyt` for more details.

For further details on how to use `CATALYST` together with `diffcyt`, see the `CATALYST` [Bioconductor vignette](http://bioconductor.org/packages/release/bioc/vignettes/CATALYST/inst/doc/differential_analysis.html), or our extended [CyTOF workflow](http://bioconductor.org/packages/cytofWorkflow) (Nowicka et al., 2019) available from Bioconductor.

### 4.7.3 Option 3: Individual functions

To provide additional flexibility, it is also possible to run the functions for the individual steps in the `diffcyt` pipeline, instead of using the wrapper function. This may be useful if you wish to customize or modify certain parts of the pipeline; for example, to adjust the data transformation, or to substitute a different clustering algorithm. Running the individual steps can also provide additional insight into the methodology.

#### 4.7.3.1 Prepare data into required format

The first step is to prepare the input data into the required format for subsequent functions in the `diffcyt` pipeline. The data object `d_se` contains cells in rows, and markers in columns. See `?prepareData` for more details.

```
# Prepare data
d_se <- prepareData(d_flowSet, experiment_info, marker_info)
```

#### 4.7.3.2 Transform data

Next, transform the data using an `arcsinh` transform with `cofactor = 5`. This is a standard transform used for mass cytometry (CyTOF) data, which brings the data closer to a normal distribution, improving clustering performance and visualizations. See `?transformData` for more details.

```
# Transform data
d_se <- transformData(d_se)
```

#### 4.7.3.3 Generate clusters

By default, we use the [FlowSOM](http://bioconductor.org/packages/FlowSOM) clustering algorithm (Van Gassen et al., 2015) to generate the high-resolution clustering. In principle, other clustering algorithms that can generate large numbers of clusters could also be substituted. See `?generateClusters` for more details.

```
# Generate clusters
# note: include random seed for reproducible clustering
d_se <- generateClusters(d_se, seed_clustering = 123)
```

```
## FlowSOM clustering completed in 7.6 seconds
```

#### 4.7.3.4 Calculate features

Next, calculate data features: cluster cell counts and cluster medians (median marker expression for each cluster and sample). These objects are required to calculate the differential tests. See `?calcCounts` and `?calcMedians` for more details.

```
# Calculate cluster cell counts
d_counts <- calcCounts(d_se)

# Calculate cluster medians
d_medians <- calcMedians(d_se)
```

#### 4.7.3.5 Test for differential abundance (DA) of cell populations

Calculate tests for differential abundance (DA) of clusters, using one of the DA testing methods (`diffcyt-DA-edgeR`, `diffcyt-DA-voom`, or `diffcyt-DA-GLMM`). This also requires a design matrix (or model formula) and contrast matrix, as previously. We re-use the design matrix and contrast matrix created above, together with the default method for DA testing (`diffcyt-DA-edgeR`).

The main results consist of adjusted p-values for each cluster, which can be used to rank the clusters by their evidence for differential abundance. The raw p-values and adjusted p-values are stored in the `rowData` of the `SummarizedExperiment` output object. For more details, see `?testDA_edgeR`, `?testDA_voom`, or `?testDA_GLMM`.

As previously, we can also use the function `topTable()` to display a table of results for the top (most highly significant) detected DA clusters, and to generate a summary table of the number of detected DA clusters at a given adjusted p-value threshold. See `?topTable` for more details.

```
# Test for differential abundance (DA) of clusters
res_DA <- testDA_edgeR(d_counts, design, contrast)

# display table of results for top DA clusters
topTable(res_DA, format_vals = TRUE)
```

```
## DataFrame with 20 rows and 3 columns
##     cluster_id     p_val     p_adj
##       <factor> <numeric> <numeric>
## 97          97  5.60e-51  5.60e-49
## 3           3   3.50e-40  1.75e-38
## 8           8   8.04e-36  2.68e-34
## 43          43  1.76e-33  4.40e-32
## 9           9   7.69e-32  1.54e-30
## ...        ...       ...       ...
## 26          26  9.00e-22  5.62e-21
## 73          73  1.19e-20  7.00e-20
## 6           6   1.43e-20  7.97e-20
## 31          31  5.30e-19  2.79e-18
## 89          89  9.55e-18  4.77e-17
```

```
# calculate number of significant detected DA clusters at 10% false discovery
# rate (FDR)
threshold <- 0.1
table(topTable(res_DA, all = TRUE)$p_adj <= threshold)
```

```
##
## FALSE  TRUE
##    25    75
```

#### 4.7.3.6 Test for differential states (DS) within cell populations

Calculate tests for differential states (DS) within clusters, using one of the DS testing methods (`diffcyt-DS-limma` or `diffcyt-DS-LMM`). This also requires a design matrix (or model formula) and contrast matrix, as previously. We re-use the design matrix and contrast matrix created above, together with the default method for DS testing (`diffcyt-DS-limma`).

We test all ‘cell state’ markers for differential expression. The set of markers to test can also be adjusted with the optional argument `markers_to_test` (for example, if you wish to also calculate tests for the ‘cell type’ markers).

The main results consist of adjusted p-values for each cluster-marker combination (cell state markers only), which can be used to rank the cluster-marker combinations by their evidence for differential states. The raw p-values and adjusted p-values are stored in the `rowData` of the `SummarizedExperiment` output object. For more details, see `?diffcyt-DS-limma` or `?diffcyt-DS-LMM`.

As previously, we can also use the function `topTable()` to display a table of results for the top (most highly significant) detected DS cluster-marker combinations (note that there is one test result for each cluster-marker combination), and to generate a summary table of the number of detected DS cluster-marker combinations at a given adjusted p-value threshold. See `?topTable` for more details.

```
# Test for differential states (DS) within clusters
res_DS <- testDS_limma(d_counts, d_medians, design, contrast, plot = FALSE)
```

```
## Warning: Partial NA coefficients for 14 probe(s)
```

```
# display table of results for top DS cluster-marker combinations
topTable(res_DS, format_vals = TRUE)
```

```
## DataFrame with 20 rows and 4 columns
##     cluster_id marker_id     p_val     p_adj
##       <factor>  <factor> <numeric> <numeric>
## 30          30    pS6     5.20e-11  7.28e-08
## 19          19    pS6     5.17e-10  3.62e-07
## 19          19    pPlcg2  2.27e-09  9.26e-07
## 10          10    pS6     2.65e-09  9.26e-07
## 20          20    pS6     4.37e-09  1.22e-06
## ...        ...       ...       ...       ...
## 7           7     pBtk    4.59e-07  3.78e-05
## 11          11    pBtk    4.59e-07  3.78e-05
## 19          19    pAkt    6.36e-07  4.87e-05
## 19          19    pZap70  6.87e-07  4.87e-05
## 1           1     pBtk    6.96e-07  4.87e-05
```

```
# calculate number of significant detected DS cluster-marker combinations at
# 10% false discovery rate (FDR)
threshold <- 0.1
table(topTable(res_DS, all = TRUE)$p_adj <= threshold)
```

```
##
## FALSE  TRUE
##   568   832
```

# 5 Exporting data

Depending on the type of analysis, it may be useful to export data to `.fcs` files or other formats; e.g. to enable further analysis using other software. This can be done at any stage of the `diffcyt` pipeline using standard functions from the `flowCore` package.

The following code provides an example demonstrating how to export `.fcs` files containing group IDs, patient IDs, sample IDs, and cluster labels for each cell. For example, this may be useful for users who wish to further analyze the same clustering within external software.

For this example, we use the output object `out_DA` from running the wrapper function `diffcyt()` above (Option 1) to test for differential abundance (DA) of clusters.

```
# Output object from 'diffcyt()' wrapper function
names(out_DA)
```

```
## [1] "res"      "d_se"     "d_counts"
```

```
dim(out_DA$d_se)
```

```
## [1] 172791     39
```

```
rowData(out_DA$d_se)
```

```
## DataFrame with 172791 rows and 4 columns
##         group_id patient_id          sample_id cluster_id
##         <factor>   <factor>           <factor>   <factor>
## 1         BCR-XL   patient1    patient1_BCR-XL         95
## 2         BCR-XL   patient1    patient1_BCR-XL         72
## 3         BCR-XL   patient1    patient1_BCR-XL         11
## 4         BCR-XL   patient1    patient1_BCR-XL         51
## 5         BCR-XL   patient1    patient1_BCR-XL         22
## ...          ...        ...                ...        ...
## 172787 Reference   patient8 patient8_Reference         47
## 172788 Reference   patient8 patient8_Reference         96
## 172789 Reference   patient8 patient8_Reference         92
## 172790 Reference   patient8 patient8_Reference         91
## 172791 Reference   patient8 patient8_Reference         21
```

```
str(assay(out_DA$d_se))
```

```
##  num [1:172791, 1:39] 33073 36963 37892 41345 42475 ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : NULL
##   ..$ : chr [1:39] "Time" "Cell_length" "CD3" "CD45" ...
```

```
head(assay(out_DA$d_se), 2)
```

```
##       Time Cell_length      CD3     CD45      BC1       BC2    pNFkB       pp38
## [1,] 33073          30 3.878466 5.203159 576.8983 10.005730 2.968545  0.5486397
## [2,] 36963          35 3.990112 5.520969 564.6299  5.599113 2.609338 -0.1434845
##           CD4       BC3        CD20        CD33   pStat5      CD123     pAkt
## [1,] 4.576125 11.514709 -0.04275126 -0.02280228 1.208487 -0.1050299 2.796846
## [2,] 4.952275  5.004433 -0.13478894 -0.18088905 2.345715  1.0839967 4.474955
##        pStat1      pSHP2      pZap70     pStat3      BC4       CD14     pSlp76
## [1,] 2.678996  0.5499532  2.76941084 -0.1362253 3.152275 -0.1077868  0.3665146
## [2,] 0.735040 -0.1516414 -0.04327872  1.7984042 6.868416 -0.1010137 -0.0946994
##             BC5       pBtk    pPlcg2       pErk        BC6        pLat
## [1,] -0.2847748 -0.1933098 1.5554296  0.6218593 -0.4900131  2.76203120
## [2,]  5.2941360  0.5914230 0.6249868 -0.1375994  0.2871704 -0.05392741
##              IgM         pS6      HLA-DR      BC7      CD7    DNA-1    DNA-2
## [1,] -0.11722553 0.003981008 -0.07016641 119.4165 3.274793 268.2261 497.0998
## [2,] -0.04462325 0.403973545  0.31650319 198.4307 4.957091 659.0508 763.4751
##      group_id patient_id sample_id population_id
## [1,]        2          1         1             3
## [2,]        2          1         1             3
```

```
# Extract cell-level table for export as .fcs file
# note: including group IDs, patient IDs, sample IDs, and cluster labels for
# each cell
# note: table must be a numeric matrix (to save as .fcs file)
d_fcs <- assay(out_DA$d_se)
class(d_fcs)
```

```
## [1] "matrix" "array"
```

```
# Save as .fcs file
filename_fcs <- "exported_data.fcs"
write.FCS(
  flowFrame(d_fcs), filename = filename_fcs
)

# Alternatively, save as tab-delimited .txt file
filename_txt <- "exported_data.txt"
write.table(
  d_fcs, file = filename_txt, quote = FALSE, sep = "\t", row.names = FALSE
)
```

# 6 Visualizations using ‘CATALYST’ package

## 6.1 Overview

As described in our paper introducing the `diffcyt` framework ([Weber et al., 2019](https://www.biorxiv.org/content/10.1101/349738v3)), the results from a `diffcyt` differential analysis are provided to the user in the form of adjusted p-values, allowing the identification of sets of significant detected clusters (for DA tests) or cluster-marker combinations (for DS tests). The detected clusters or cluster-marker combinations can then be interpreted using visualizations; for example, to interpret the marker expression profiles in order to match detected clusters to known cell populations, or to group the high-resolution clusters into larger cell populations with a consistent phenotype.

Extensive plotting functions to generate both exploratory visualizations and visualizations of results from differential testing are available in the [CATALYST](http://bioconductor.org/packages/CATALYST) package (Chevrier, Crowell, Zanotelli et al., 2018). These plotting functions are used in our [CyTOF workflow](http://bioconductor.org/packages/cytofWorkflow) (Nowicka et al., 2019) available from Bioconductor. For more details, including further examples of visualizations, see the [CyTOF workflow](http://bioconductor.org/packages/cytofWorkflow) or the `CATALYST` [Bioconductor vignette](http://bioconductor.org/packages/release/bioc/vignettes/CATALYST/inst/doc/differential_analysis.html). (Heatmaps are generated using the [ComplexHeatmap](https://bioconductor.org/packages/ComplexHeatmap) Bioconductor package; Gu et al., 2016.)

Here, we generate heatmaps to illustrate the results from the differential analyses performed above. Note that the `CATALYST` plotting functions can accept `diffcyt` results objects in either `SummarizedExperiment` format (from options 1 and 3 above) or `CATALYST` `daFrame` format (option 2).

## 6.2 Heatmap: DA test results

This heatmap illustrates the phenotypes (marker expression profiles) and signals of interest (cluster abundances by sample) for the top (most highly significant) detected clusters from the DA tests.

Rows represent clusters, and columns represent protein markers (left panel) or samples (right panel). The left panel displays median (arcsinh-transformed) expression values across all samples for cell type markers, i.e. cluster phenotypes. The right panel displays the signal of interest: cluster abundances by sample (for the DA tests). The right annotation bar indicates clusters detected as significantly differential at an adjusted p-value threshold of 10%.

As mentioned previously, the DA tests are not particularly meaningful for the `Bodenmiller_BCR_XL` dataset, since the main signals of interest in this dataset are differential expression of pS6 and other signaling markers in B cells and several other cell populations. However, we include the plot here for illustrative purposes, to show how to use the functions.

(Note: For the example below, we use an earlier version of the heatmap plotting function included in the `diffcyt` package, instead of using `CATALYST`. This is done to reduce dependencies, in order to streamline installation and compilation of the `diffcyt` package and vignette. Alternative code to generate the heatmap using `CATALYST` is also shown; this version includes additional formatting, and will usually be preferred.)

See `?plotDiffHeatmap` (`CATALYST`) or `?plotHeatmap` (`diffcyt`) for more details.

```
# Heatmap for top detected DA clusters

# note: use optional argument 'sample_order' to group samples by condition
sample_order <- c(seq(2, 16, by = 2), seq(1, 16, by = 2))

plotHeatmap(out_DA, analysis_type = "DA", sample_order = sample_order)
```

![](data:image/png;base64...)

```
# Heatmap for top detected DA clusters (alternative code using 'CATALYST')

suppressPackageStartupMessages(library(CATALYST))

plotDiffHeatmap(out_DA$d_se, out_DA$res)
```

## 6.3 Heatmap: DS test results

This heatmap illustrates the phenotypes (marker expression profiles) and signals of interest (median expression of cell state markers by sample) for the top (most highly significant) detected cluster-marker combinations from the DS tests.

Rows represent cluster-marker combinations, and columns represent protein markers (left panel) or samples (right panel). The left panel displays median (arcsinh-transformed) expression values across all samples for cell type markers, i.e. cluster phenotypes. The right panel displays the signal of interest: median expression of cell state markers by sample (for the DS tests). The right annotation bar indicates cluster-marker combinations detected as significantly differential at an adjusted p-value threshold of 10%.

The heatmap shows that the `diffcyt` pipeline has successfully recovered the main differential signal of interest in this dataset. As discussed above, the `Bodenmiller_BCR_XL` dataset contains known strong differential expression of several signaling markers (cell state markers) in several cell populations. In particular, the strongest signal is for differential expression of pS6 in B cells.

As expected, several of the top (most highly significant) detected cluster-marker combinations represent differential expression of pS6 (labels in right annotation bar) in B cells (identified by high expression of CD20, left panel). Similarly, the other top detected cluster-marker combinations shown in the heatmap correspond to other known strong differential signals in this dataset (see Nowicka et al., 2017, Figure 29; or the description of the results for dataset `BCR-XL` in our paper introducing the `diffcyt` framework ([Weber et al., 2019](https://www.biorxiv.org/content/10.1101/349738v3)).

(Note: For the example below, we use an earlier version of the heatmap plotting function included in the `diffcyt` package, instead of using `CATALYST`. This is done to reduce dependencies, in order to streamline installation and compilation of the `diffcyt` package and vignette. Alternative code to generate the heatmap using `CATALYST` is also shown; this version includes additional formatting, and will usually be preferred.)

See `?plotDiffHeatmap` (`CATALYST`) or `?plotHeatmap` (`diffcyt`) for more details.

```
# Heatmap for top detected DS cluster-marker combinations

# note: use optional argument 'sample_order' to group samples by condition
sample_order <- c(seq(2, 16, by = 2), seq(1, 16, by = 2))

plotHeatmap(out_DS, analysis_type = "DS", sample_order = sample_order)
```

![](data:image/png;base64...)

```
# Heatmap for top detected DA clusters (alternative code using 'CATALYST')

suppressPackageStartupMessages(library(CATALYST))

plotDiffHeatmap(out_DS$d_se, out_DS$res)
```

# 7 References

# Appendix

Bodenmiller, B., Zunder, E. R., Finck, R., Chen, T. J., Savig, E. S., Bruggner, R. V., Simonds, E. F., Bendall, S. C., Sachs, K., Krutzik, P. O., and Nolan, G. P. (2012). [*Multiplexed mass cytometry profiling of cellular states perturbed by small-molecule regulators.*](https://www.ncbi.nlm.nih.gov/pubmed/22902532) Nature Biotechnology, 30(9):858–867.

Chevrier, S., Crowell, H. L., Zanotelli, V. R. T., Engler, S., Robinson, M. D., and Bodenmiller, B. (2018). [*Compensation of Signal Spillover in Suspension and Imaging Mass Cytometry.*](https://www.ncbi.nlm.nih.gov/pubmed/29605184) Cell Systems, 6:1–9.

Gu, Z., Eils, R., and Schlesner, M. (2016). [*Complex heatmaps reveal patterns and correlations in multidimensional genomic data.*](https://www.ncbi.nlm.nih.gov/pubmed/27207943) Bioinformatics, 32(18):2847–2849.

Law, C. W., Chen, Y., Shi, W., and Smyth, G. K. (2014). [*voom: precision weights unlock linear model analysis tools for RNA-seq read counts.*](https://www.ncbi.nlm.nih.gov/pubmed/24485249) Genome Biology 2014, 15:R29.

McCarthy, D. J., Chen, Y., and Smyth, G. K. (2012). [*Differential expression analysis of multifactor RNA-Seq experiments with respect to biological variation.*](https://www.ncbi.nlm.nih.gov/pubmed/22287627) Nucleic Acids Research, 40(10):4288–4297.

Nowicka, M., Krieg, C., Weber, L. M., Hartmann, F. J., Guglietta, S., Becher, B., Levesque, M. P., and Robinson, M. D. (2017). [*CyTOF workflow: differential discovery in high-throughput high-dimensional cytometry datasets.*](https://www.ncbi.nlm.nih.gov/pubmed/28663787) F1000Research, version 2.

Nowicka, M., Krieg, C., Crowell, H. L., Weber, L. M., Hartmann, F. J., Guglietta, S., Becher, B., Levesque, M. P., and Robinson, M. D. (2019). [*CyTOF workflow: differential discovery in high-throughput high-dimensional cytometry datasets.*](https://www.ncbi.nlm.nih.gov/pubmed/28663787) F1000Research, version 3.

Ritchie, M. E., Phipson, B., Wu, D., Hu, Y., Law, C. W., Shi, W., and Smyth, G. K. (2015). [*limma powers differential expression analyses for RNA-sequencing and microarray studies.*](https://www.ncbi.nlm.nih.gov/pubmed/25605792) Nucleic Acids Research, 43(7):e47.

Robinson, M. D., McCarthy, D. J., and Smyth, G. K. (2010). [*edgeR: a Bioconductor package for differential expression analysis of digital gene expression data.*](https://www.ncbi.nlm.nih.gov/pubmed/19910308) Bioinformatics, 26(1):139–140.

Van Gassen, S., Callebaut, B., Van Helden, M. J., Lambrecht, B. N., Demeester, P., Dhaene, T., and Saeys, Y. (2015). [*FlowSOM: Using Self-Organizing Maps for Visualization and Interpretation of Cytometry Data.*](https://www.ncbi.nlm.nih.gov/pubmed/25573116) Cytometry Part A, 87A:636–645.

Weber, L. M. and Robinson, M. D. (2016). [*Comparison of Clustering Methods for High-Dimensional Single-Cell Flow and Mass Cytometry Data.*](https://www.ncbi.nlm.nih.gov/pubmed/27992111) Cytometry Part A, 89A:1084–1096.

Weber, L. M., Nowicka, M., Soneson, C., and Robinson, M. D. (2019). [*diffcyt: Differential discovery in high-dimensional cytometry via high-resolution clustering.*](https://www.biorxiv.org/content/10.1101/349738v3) bioRxiv.