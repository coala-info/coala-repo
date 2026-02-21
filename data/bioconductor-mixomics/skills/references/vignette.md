# mixOmics vignette

Kim-Anh Le Cao1\*

1Melbourne Integrative Genomics & School of Mathematics and Statistics, The University of Melbourne, Australia

\*kimanh.lecao@unimelb.edu.au

#### 30 October 2025

#### Package

mixOmics 6.32.0

# Contents

* [Preamble](#preamble)
* [1 Introduction {#01}](#introduction-01)
  + [1.1 Input data {#01:datatypes}](#input-data-01datatypes)
  + [1.2 Methods](#methods)
    - [1.2.1 Some background knowledge {#01:methods}](#some-background-knowledge-01methods)
    - [1.2.2 Overview {#01:overview}](#overview-01overview)
    - [1.2.3 Key publications {#01:pubs}](#key-publications-01pubs)
  + [1.3 Outline of this Vignette {#01:outline}](#outline-of-this-vignette-01outline)
  + [1.4 Other methods not covered in this vignette](#other-methods-not-covered-in-this-vignette)
* [2 Let’s get started {#02}](#lets-get-started-02)
  + [2.1 Installation {#02:install}](#installation-02install)
  + [2.2 Load the package {#02:load-data}](#load-the-package-02load-data)
  + [2.3 Upload data](#upload-data)
  + [2.4 Quick start in `mixOmics` {#02:quick-start}](#quick-start-in-mixomics-02quick-start)
* [3 PCA on the `multidrug` study {#03}](#pca-on-the-multidrug-study-03)
  + [3.1 Load the data {#03:load-data}](#load-the-data-03load-data)
  + [3.2 Example: PCA {#03:pca}](#example-pca-03pca)
    - [3.2.1 Choose the number of components {#03:pca-ncomp}](#choose-the-number-of-components-03pca-ncomp)
    - [3.2.2 PCA with fewer components {#03:pca-final}](#pca-with-fewer-components-03pca-final)
    - [3.2.3 Identify the informative variables {#03:pca-vars}](#identify-the-informative-variables-03pca-vars)
    - [3.2.4 Sample plots {#03:pca-sample-plot}](#sample-plots-03pca-sample-plot)
    - [3.2.5 Variable plot: correlation circle plot {#03:pca-variable-plot}](#variable-plot-correlation-circle-plot-03pca-variable-plot)
    - [3.2.6 Biplot: samples and variables {#03:pca-biplot}](#biplot-samples-and-variables-03pca-biplot)
  + [3.3 Example: sparse PCA {#03:spca}](#example-sparse-pca-03spca)
    - [3.3.1 Choose the number of variables to select {#03:spca-vars}](#choose-the-number-of-variables-to-select-03spca-vars)
    - [3.3.2 Final sparse PCA {#03:spca-final}](#final-sparse-pca-03spca-final)
    - [3.3.3 Sample and variable plots {#03:spca-plots}](#sample-and-variable-plots-03spca-plots)
* [4 PLS on the liver toxicity study {#04}](#pls-on-the-liver-toxicity-study-04)
  + [4.1 Load the data {#04:load-data}](#load-the-data-04load-data)
  + [4.2 Example: sPLS1 regression {#04:spls1}](#example-spls1-regression-04spls1)
    - [4.2.1 Number of dimensions using the \(Q^2\) criterion {#04:spls1-ncomp}](#number-of-dimensions-using-the-q2-criterion-04spls1-ncomp)
    - [4.2.2 Number of variables to select in \(\boldsymbol X\) {#04:spls1-tuning}](#number-of-variables-to-select-in-boldsymbol-x-04spls1-tuning)
    - [4.2.3 Final sPLS1 model {#04:spls1-final}](#final-spls1-model-04spls1-final)
    - [4.2.4 Sample plots {#04:spls1-sample-plots}](#sample-plots-04spls1-sample-plots)
    - [4.2.5 Performance assessment of sPLS1 {#04:spls1-perf}](#performance-assessment-of-spls1-04spls1-perf)
  + [4.3 Example: PLS2 regression {#04:spls2}](#example-pls2-regression-04spls2)
    - [4.3.1 Number of dimensions using the \(Q^2\) criterion {#04:spls2-ncomp}](#number-of-dimensions-using-the-q2-criterion-04spls2-ncomp)
    - [4.3.2 Number of variables to select in both \(\boldsymbol X\) and \(\boldsymbol Y\) {#04:spls2-tuning}](#number-of-variables-to-select-in-both-boldsymbol-x-and-boldsymbol-y-04spls2-tuning)
    - [4.3.3 Final sPLS2 model {#04:spls2-final}](#final-spls2-model-04spls2-final)
* [5 PLS-DA on the SRBCT case study {#05}](#pls-da-on-the-srbct-case-study-05)
  + [5.1 Load the data {#05:load-data}](#load-the-data-05load-data)
  + [5.2 Example: PLS-DA {#05:plsda}](#example-pls-da-05plsda)
    - [5.2.1 Initial exploration with PCA {#05:plsda-pca}](#initial-exploration-with-pca-05plsda-pca)
    - [5.2.2 Number of components in PLS-DA {#05:plsda-ncomp}](#number-of-components-in-pls-da-05plsda-ncomp)
    - [5.2.3 Final PLS-DA model {#05:plsda-final}](#final-pls-da-model-05plsda-final)
    - [5.2.4 Classification performance {#05:plsda-perf}](#classification-performance-05plsda-perf)
    - [5.2.5 Background prediction {#05:plsda-bgp}](#background-prediction-05plsda-bgp)
  + [5.3 Example: sPLS-DA {#05:splsda}](#example-spls-da-05splsda)
    - [5.3.1 Number of variables to select {#05:splsda-keepX}](#number-of-variables-to-select-05splsda-keepx)
    - [5.3.2 Final model and performance](#final-splsda-perf)
    - [5.3.3 Variable selection and stability {#05:stab}](#variable-selection-and-stability-05stab)
    - [5.3.4 Sample visualisation](#sample-visualisation)
    - [5.3.5 Variable visualisation {#05:varplot}](#variable-visualisation-05varplot)
  + [5.4 Take a detour: prediction {#05:splsda-predict}](#take-a-detour-prediction-05splsda-predict)
  + [5.5 AUROC outputs complement performance evaluation {#05:splsda-auroc}](#auroc-outputs-complement-performance-evaluation-05splsda-auroc)
* [6 N-Integration {#06}](#n-integration-06)
  + [6.1 Block sPLS-DA on the TCGA case study {#06:diablo}](#block-spls-da-on-the-tcga-case-study-06diablo)
  + [6.2 Load the data {#06:diablo-load-data}](#load-the-data-06diablo-load-data)
  + [6.3 Parameter choice {#06:diablo-params}](#parameter-choice-06diablo-params)
    - [6.3.1 Design matrix {#06:diablo-design}](#design-matrix-06diablo-design)
    - [6.3.2 Number of components {#06:diablo-ncomp}](#number-of-components-06diablo-ncomp)
    - [6.3.3 Number of variables to select {#06:diablo-tuning}](#number-of-variables-to-select-06diablo-tuning)
  + [6.4 Final model {#06:diablo-final}](#final-model-06diablo-final)
  + [6.5 Sample plots {#06:diablo-sample-plots}](#sample-plots-06diablo-sample-plots)
    - [6.5.1 `plotDiablo`](#plotdiablo)
    - [6.5.2 `plotIndiv`](#plotindiv)
    - [6.5.3 `plotArrow`](#plotarrow)
  + [6.6 Variable plots {#06:diablo-variable-plots}](#variable-plots-06diablo-variable-plots)
    - [6.6.1 `plotVar`](#plotvar)
    - [6.6.2 `circosPlot`](#circosplot)
    - [6.6.3 `network`](#network)
    - [6.6.4 `plotLoadings`](#plotloadings)
    - [6.6.5 `cimDiablo`](#cimdiablo)
  + [6.7 Model performance and prediction {#06:diablo-perf}](#model-performance-and-prediction-06diablo-perf)
* [7 P-Integration {#07}](#p-integration-07)
  + [7.1 MINT on the stem cell case study {#07:mint}](#mint-on-the-stem-cell-case-study-07mint)
  + [7.2 Load the data {#07:load-data}](#load-the-data-07load-data)
  + [7.3 Example: MINT PLS-DA {#07:plsda}](#example-mint-pls-da-07plsda)
  + [7.4 Example: MINT sPLS-DA {#07:splsda}](#example-mint-spls-da-07splsda)
    - [7.4.1 Number of variables to select {#07:splsda-tuning}](#number-of-variables-to-select-07splsda-tuning)
    - [7.4.2 Final MINT sPLS-DA model {#07:splsda-final}](#final-mint-spls-da-model-07splsda-final)
    - [7.4.3 Sample plots {#07:splsda-sample-plots}](#sample-plots-07splsda-sample-plots)
    - [7.4.4 Variable plots {#07:splsda-variable-plots}](#variable-plots-07splsda-variable-plots)
    - [7.4.5 Classification performance {#07:splsda-perf}](#classification-performance-07splsda-perf)
  + [7.5 Take a detour {#07:splsda-auroc}](#take-a-detour-07splsda-auroc)
    - [7.5.1 AUC](#auc)
    - [7.5.2 Prediction on an external study {#07:splsda-predict}](#prediction-on-an-external-study-07splsda-predict)
* [8 Session Information {#08}](#session-information-08)
  + [8.1 mixOmics version {#08:mixomics-ver}](#mixomics-version-08mixomics-ver)
  + [8.2 Session info {#08:session-info}](#session-info-08session-info)
* [References](#references)

```
library(BiocParallel)
```

# Preamble

If you are following our [online course](https://study.unimelb.edu.au/find/short-courses/mixomics-r-essentials-for-biological-data-integration/#course-specifics), the following vignette will be useful as a complementary learning tool. This vignette also covers the essential use cases of various methods in this package for the general `mixOmcis` user. The below methods will be covered:

* (s)PCA,
* PLS1 and PLS2,
* (s)PLS-DA,
* N-integration (multi-block sPLS-DA, aka. “DIABLO”), and
* P-integration (multi-group sPLS-DA, aka “MINT”).

As outlined in [1.3](#01:outline), this is not an exhaustive list of all the methods found within `mixOmics`. More information can be found at [our website](http://mixomics.org/) and you can ask questions via our [discourse forum](https://mixomics-users.discourse.group/).

![**Different types of analyses with mixOmics** [@mixomics].The biological questions, the number of data sets to integrate, and the type of response variable, whether qualitative (classification), quantitative (regression), one (PLS1) or several (PLS) responses, all drive the choice of analytical method. All methods featured in this diagram include variable selection except rCCA. In N-integration, rCCA and PLS enable the integration of two quantitative data sets, whilst the block PLS methods (that derive from the methods from @Ten11) can integrate more than two data sets. In P-integration, our method MINT is based on multi-group PLS [@Esl14b].The following activities cover some of these methods.](data:image/png;base64...)

Figure 1: **Different types of analyses with mixOmics** (Rohart, Gautier, Singh, and Le Cao [2017](#ref-mixomics)).The biological questions, the number of data sets to integrate, and the type of response variable, whether qualitative (classification), quantitative (regression), one (PLS1) or several (PLS) responses, all drive the choice of analytical method
All methods featured in this diagram include variable selection except rCCA. In N-integration, rCCA and PLS enable the integration of two quantitative data sets, whilst the block PLS methods (that derive from the methods from Tenenhaus and Tenenhaus ([2011](#ref-Ten11))) can integrate more than two data sets. In P-integration, our method MINT is based on multi-group PLS (Eslami et al. [2014](#ref-Esl14b)).The following activities cover some of these methods.

# 1 Introduction {#01}

`mixOmics` is an R toolkit dedicated to the exploration and integration of biological data sets with a specific focus on variable selection. The package currently includes more than twenty multivariate methodologies, mostly developed by the `mixOmics` team (see some of our references in [1.2.3](#01:pubs)). Originally, all methods were designed for omics data, however, their application is not limited to biological data only. Other applications where integration is required can be considered, but mostly for the case where the predictor variables are continuous (see also [1.1](#01:datatypes)).

In `mixOmics`, a strong focus is given to graphical representation to better translate and understand the relationships between the different data types and visualize the correlation structure at both sample and variable levels.

## 1.1 Input data {#01:datatypes}

Note the data pre-processing requirements before analysing data with `mixOmics`:

* **Types of data**. Different types of biological data can be explored and integrated with `mixOmics`. Our methods can handle molecular features measured on a continuous scale (e.g. microarray, mass spectrometry-based proteomics and metabolomics) or sequenced-based count data (RNA-seq, 16S, shotgun metagenomics) that become `continuous’ data after pre-processing and normalisation.
* **Normalisation**. The package does not handle normalisation as it is platform-specific and we cover a too wide variety of data! Prior to the analysis, we assume the data sets have been normalised using appropriate normalisation methods and pre-processed when applicable.
* **Prefiltering**. While `mixOmics` methods can handle large data sets (several tens of thousands of predictors), we recommend pre-filtering the data to less than 10K predictor variables per data set, for example by using Median Absolute Deviation (Teng et al. [2016](#ref-Ten16)) for RNA-seq data, by removing consistently low counts in microbiome data sets (Lê Cao et al. [2016](#ref-Lec16)) or by removing near-zero variance predictors. Such step aims to lessen the computational time during the parameter tuning process.
* **Data format**.
  Our methods use matrix decomposition techniques. Therefore, the numeric data matrix or data frames have \(n\) observations or samples in rows and \(p\) predictors or variables (e.g. genes, proteins, OTUs) in columns.
* **Covariates**. In the current version of `mixOmics`, covariates that may confound the analysis are not included in the methods. We recommend correcting for those covariates beforehand using appropriate univariate or multivariate methods for batch effect removal. Contact us for more details as we are currently working on this aspect.

## 1.2 Methods

### 1.2.1 Some background knowledge {#01:methods}

We list here the main methodological or theoretical concepts you need to know to be able to efficiently apply `mixOmics`:

* **Individuals, observations or samples**: the experimental units on which information are collected, e.g. patients, cell lines, cells, faecal samples etc.
* **Variables, predictors**: read-out measured on each sample, e.g. gene (expression), protein or OTU (abundance), weight etc.
* **Variance**: measures the spread of one variable. In our methods, we estimate the variance of components rather that variable read-outs. A high variance indicates that the data points are very spread out from the mean, and from one another (scattered).
* **Covariance**: measures the strength of the relationship between two variables, i.e. whether they co-vary. A high covariance value indicates a strong relationship, e.g. weight and height in individuals frequently vary roughly in the same way; roughly, the heaviest are the tallest. A covariance value has no lower or upper bound.
* **Correlation**: a standardized version of the covariance that is bounded by -1 and 1.
* **Linear combination**: variables are combined by multiplying each of them by a coefficient and adding the results. A linear combination of height and weight could be \(2 \* weight - 1.5 \* height\) with the coefficients \(2\) and \(-1.5\) assigned with weight and height respectively.
* **Component**: an artificial variable built from a linear combination of the observed variables in a given data set. Variable coefficients are optimally defined based on some statistical criterion. For example in Principal Component Analysis, the coefficients of a (principal) component are defined so as to maximise the variance of the component.
* **Loadings**: variable coefficients used to define a component.
* **Sample plot**: representation of the samples projected in a small space spanned (defined) by the components. Samples coordinates are determined by their components values or scores.
* **Correlation circle plot**: representation of the variables in a space spanned by the components. Each variable coordinate is defined as the correlation between the original variable value and each component. A correlation circle plot enables to visualise the correlation between variables - negative or positive correlation, defined by the cosine angle between the centre of the circle and each variable point) and the contribution of each variable to each component - defined by the absolute value of the coordinate on each component. For this interpretation, data need to be centred and scaled (by default in most of our methods except PCA). For more details on this insightful graphic, see Figure 1 in (González et al. [2012](#ref-Gon12)).
* **Unsupervised analysis**: the method does not take into account any known sample groups and the analysis is exploratory. Examples of unsupervised methods covered in this vignette are Principal Component Analysis (PCA, Chapter [3](#03)), Projection to Latent Structures (PLS, Chapter [4](#04)), and also Canonical Correlation Analysis (CCA, not covered here but see [the website page](http://mixomics.org/methods/rcca/)).
* **Supervised analysis**: the method includes a vector indicating the class membership of each sample. The aim is to discriminate sample groups and perform sample class prediction. Examples of supervised methods covered in this vignette are PLS Discriminant Analysis (PLS-DA, Chapter [5](#05)), DIABLO (Chapter [6](#06)) and also MINT (Chapter [7](#07)).

If the above descriptions were not comprehensive enough and you have some more questions, feel free to explore the [glossary](http://mixomics.org/faq/glossary/) on our website.

### 1.2.2 Overview {#01:overview}

Here is an overview of the most widely used methods in `mixOmics` that will be further detailed in this vignette, with the exception of rCCA. We depict them along with the type of data set they can handle.

![newplot](data:image/png;base64...)

FIGURE 1: An overview of what quantity and type of dataset each method within mixOmics requires. Thin columns represent a single variable, while the larger blocks represent datasets of multiple samples and variables.

![List of methods in mixOmics, sparse indicates methods that perform variable selection](data:image/png;base64...)

Figure 2: List of methods in mixOmics, sparse indicates methods that perform variable selection

![Main functions and parameters of each method](data:image/png;base64...)

Figure 3: Main functions and parameters of each method

### 1.2.3 Key publications {#01:pubs}

The methods implemented in `mixOmics` are described in detail in the following publications. A more extensive list can be found at this [link](http://mixomics.org/a-propos/publications/).

* **Overview and recent integrative methods**: Rohart F., Gautier, B, Singh, A, Le Cao, K. A. mixOmics: an [R package for ’omics feature selection and multiple data integration](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005752). *PLoS Comput Biol* 13(11): e1005752.
* **Graphical outputs for integrative methods**: (González et al. [2012](#ref-Gon12)) Gonzalez I., Le Cao K.-A., Davis, M.D. and Dejean S. (2012) [Insightful graphical outputs to explore relationships between two omics data sets](https://biodatamining.biomedcentral.com/articles/10.1186/1756-0381-5-19). *BioData Mining* 5:19.
* **DIABLO**: Singh A, Gautier B, Shannon C, Vacher M, Rohart F, Tebbutt S, K-A. Le Cao. [DIABLO - multi-omics data integration for biomarker discovery](https://www.biorxiv.org/content/early/2018/03/20/067611).
* **sparse PLS**: Le Cao K.-A., Martin P.G.P, Robert-Granie C. and Besse, P. (2009) [Sparse Canonical Methods for Biological Data Integration: application to a cross-platform study](http://www.biomedcentral.com/1471-2105/10/34/). *BMC Bioinformatics*, 10:34.
* **sparse PLS-DA**: Le Cao K.-A., Boitard S. and Besse P. (2011) [Sparse PLS Discriminant Analysis: biologically relevant feature selection and graphical displays for multiclass problems](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-12-253). *BMC Bioinformatics*, 22:253.
* **Multilevel approach for repeated measurements**: Liquet B, Le Cao K-A, Hocini H, Thiebaut R (2012). [A novel approach for biomarker selection and the integration of repeated measures experiments from two assays](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-13-325). *BMC Bioinformatics*, 13:325
* **sPLS-DA for microbiome data**: Le Cao K-A\(^\*\), Costello ME \(^\*\), Lakis VA , Bartolo F, Chua XY, Brazeilles R and Rondeau P. (2016) [MixMC: Multivariate insights into Microbial Communities](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0160169).PLoS ONE 11(8): e0160169

## 1.3 Outline of this Vignette {#01:outline}

* **[Chapter 2](#02)**: details some practical aspects to get started
* **[Chapter 3](#03)**: Principal Components Analysis (PCA)
* **[Chapter 4](#04)**: Projection to Latent Structures (PLS)
* **[Chapter 5](#05)**: Projection to Latent Structure - Discriminant Analysis (PLS-DA)
* **[Chapter 6](#06)**: Integrative analysis for multiple data sets, across samples (namely DIABLO)
* **[Chapter 7](#07)**: Integrative analysis for multiple data, across features (namely MINT)

Each methods chapter has the following outline:

1. Type of biological question to be answered
2. Brief description of an illustrative data set
3. Principle of the method
4. Quick start of the method with the main functions and arguments
5. To go further: customized plots, additional graphical outputs, and tuning parameters
6. FAQ

## 1.4 Other methods not covered in this vignette

Other methods not covered in this document are described on our website and the following references:

* [regularised Canonical Correlation Analysis](http://www.mixOmics.org), see the **Methods** and **Case study** tabs, and (González et al. [2008](#ref-Gon08)) that describes CCA for large data sets.
* [Microbiome (16S, shotgun metagenomics) data analysis](http://www.mixOmics.org/mixmc), see also (Lê Cao et al. [2016](#ref-Lec16)) and [kernel integration for microbiome data](http://mixomics.org/mixkernel). The latter is in collaboration with Drs J Mariette and Nathalie Villa-Vialaneix (INRA Toulouse, France), an example is provided for the Tara ocean metagenomics and environmental data.

# 2 Let’s get started {#02}

## 2.1 Installation {#02:install}

First, download the latest version from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
 BiocManager::install("mixOmics")
```

Alternatively, you can install the latest GitHub version of the package:

```
BiocManager::install("mixOmicsTeam/mixOmics")
```

The `mixOmics` package should directly import the following packages:
`igraph, rgl, ellipse, corpcor, RColorBrewer, plyr, parallel, dplyr, tidyr, reshape2, methods, matrixStats, rARPACK, gridExtra`.
**For Apple mac users:** if you are unable to install the imported package `rgl`, you will need to install the [XQuartz software](https://www.xquartz.org) first.

## 2.2 Load the package {#02:load-data}

```
library(mixOmics)
```

Check that there is no error when loading the package, especially for the `rgl` library (see above).

## 2.3 Upload data

The examples we give in this vignette use data that are already part of the package. To upload your own data, check first that your working directory is set, then read your data from a `.txt` or `.csv` format, either by using **File > Import Dataset** in RStudio or via one of these command lines:

```
# from csv file
data <- read.csv("your_data.csv", row.names = 1, header = TRUE)

# from txt file
data <- read.table("your_data.txt", header = TRUE)
```

For more details about the arguments used to modify those functions, type `?read.csv` or `?read.table` in the R console.

## 2.4 Quick start in `mixOmics` {#02:quick-start}

Each analysis should follow this workflow:

1. Run the method
2. Graphical representation of the samples
3. Graphical representation of the variables

Then use your critical thinking and additional functions and visual tools to make sense of your data! (some of which are listed in [1.2.2](#01:overview)) and will be described in the next Chapters.

For instance, for Principal Components Analysis, we first load the data:

```
data(nutrimouse)
X <- nutrimouse$gene
```

Then use the following steps:

```
MyResult.pca <- pca(X)  # 1 Run the method
plotIndiv(MyResult.pca) # 2 Plot the samples
```

![](data:image/png;base64...)

```
plotVar(MyResult.pca)   # 3 Plot the variables
```

![](data:image/png;base64...)

This is only a first quick-start, there will be many avenues you can take to deepen your exploratory and integrative analyses. The package proposes several methods to perform variable, or feature selection to identify the relevant information from rather large omics data sets. The sparse methods are listed in the Table in [1.2.2](#01:overview).

Following our example here, sparse PCA can be applied to select the top 5 variables contributing to each of the two components in PCA. The user specifies the number of variables to selected on each component, for example, here 5 variables are selected on each of the first two components (`keepX=c(5,5)`):

```
MyResult.spca <- spca(X, keepX=c(5,5)) # 1 Run the method
plotIndiv(MyResult.spca)               # 2 Plot the samples
```

![](data:image/png;base64...)

```
plotVar(MyResult.spca)                 # 3 Plot the variables
```

![](data:image/png;base64...)

You can see know that we have considerably reduced the number of genes in the `plotVar` correlation circle plot.

Do not stop here! We are not done yet. You can enhance your analyses with the following:

* Have a look at our manual and each of the functions and their examples, e.g. `?pca`, `?plotIndiv`, `?sPCA`, …
* Run the examples from the help file using the `example` function: `example(pca)`, `example(plotIndiv)`, …
* Have a look at our [website](http://www.mixomics.org) that features many tutorials and case studies,
* Keep reading this vignette, this is *just the beginning!*

# 3 PCA on the `multidrug` study {#03}

To illustrate PCA and is variants, we will analyse the `multidrug` case study available in the package. This pharmacogenomic study investigates the patterns of drug activity in cancer cell lines (Szakács et al. [2004](#ref-Sza04)). These cell lines come from the [NCI-60 Human Tumor Cell Lines](https://dtp.cancer.gov/discovery_development/nci-60/) established by the Developmental Therapeutics Program of the National Cancer Institute (NCI) to screen for the toxicity of chemical compound repositories in diverse cancer cell lines. NCI-60 includes cell lines derived from cancers of colorectal (7 cell lines), renal (8), ovarian (6), breast (8), prostate (2), lung (9) and central nervous system origin (6), as well as leukemia (6) and melanoma (8).

Two separate data sets (representing two types of measurements) on the same NCI-60 cancer cell lines are available in `multidrug` (see also `?multidrug`):

* `$ABC.trans`: Contains the expression of 48 human ABC transporters measured by quantitative real-time PCR (RT-PCR) for each cell line.
* `$compound`: Contains the activity of 1,429 drugs expressed as GI50, which is the drug concentration that induces 50% inhibition of cellular growth for the tested cell line.

Additional information will also be used in the outputs:

* `$comp.name`: The names of the 1,429 compounds.
* `$cell.line`: Information on the cell line names (`$Sample`) and the cell line types (`$Class`).

In this activity, we illustrate PCA performed on the human ABC transporters `ABC.trans`, and sparse PCA on the compound data `compound`.

## 3.1 Load the data {#03:load-data}

The input data matrix \(\boldsymbol{X}\) is of size \(N\) samples in rows and \(P\) variables (e.g. genes) in columns. We start with the `ABC.trans` data.

```
library(mixOmics)
data(multidrug)
X <- multidrug$ABC.trans
dim(X) # Check dimensions of data
```

```
## [1] 60 48
```

## 3.2 Example: PCA {#03:pca}

### 3.2.1 Choose the number of components {#03:pca-ncomp}

Contrary to the minimal code example, here we choose to also scale the variables for the reasons detailed earlier. The function `tune.pca()` calculates the cumulative proportion of explained variance for a large number of principal components (here we set `ncomp = 10`). A screeplot of the proportion of explained variance relative to the total amount of variance in the data for each principal component is output (Fig. [4](#fig:03-screeplot)):

```
tune.pca.multi <- tune.pca(X, ncomp = 10, scale = TRUE)
plot(tune.pca.multi)
```

![Screeplot from the PCA performed on the ABC.trans data: Amount of explained variance for each principal component on the ABC transporter data.](data:image/png;base64...)

Figure 4: **Screeplot from the PCA performed on the `ABC.trans` data**: Amount of explained variance for each principal component on the ABC transporter data.

```
# tune.pca.multidrug$cum.var       # Outputs cumulative proportion of variance
```

From the numerical output (not shown here), we observe that the first two principal components explain 22.87% of the total variance, and the first three principal components explain 29.88% of the total variance. The rule of thumb for choosing the number of components is not so much to set a hard threshold based on the cumulative proportion of explained variance (as this is data-dependent), but to observe when a drop, or elbow, appears on the screeplot. The elbow indicates that the remaining variance is spread over many principal components and is not relevant in obtaining a low dimensional ‘snapshot’ of the data. This is an empirical way of choosing the number of principal components to retain in the analysis. In this specific example we could choose between 2 to 3 components for the final PCA, however these criteria are highly subjective and the reader must keep in mind that visualisation becomes difficult above three dimensions.

### 3.2.2 PCA with fewer components {#03:pca-final}

Based on the preliminary analysis above, we run a PCA with three components. Here we show additional input, such as whether to center or scale the variables.

```
final.pca.multi <- pca(X, ncomp = 3, center = TRUE, scale = TRUE)
# final.pca.multi  # Lists possible outputs
```

The output is similar to the tuning step above. Here the total variance in the data is:

```
final.pca.multi$var.tot
```

```
## [1] 47.98305
```

By summing the variance explained from all possible components, we would achieve the same amount of explained variance. The proportion of explained variance per component is:

```
final.pca.multi$prop_expl_var$X
```

```
##        PC1        PC2        PC3
## 0.12677541 0.10194929 0.07011818
```

The cumulative proportion of variance explained can also be extracted (as displayed in Figure [4](#fig:03-screeplot)):

```
final.pca.multi$cum.var
```

```
##       PC1       PC2       PC3
## 0.1267754 0.2287247 0.2988429
```

### 3.2.3 Identify the informative variables {#03:pca-vars}

To calculate components, we use the variable coefficient weights indicated in the loading vectors. Therefore, the absolute value of the coefficients in the loading vectors inform us about the importance of each variable in contributing to the definition of each component. We can extract this information through the `selectVar()` function which ranks the most important variables in decreasing order according to their absolute loading weight value for each principal component.

```
# Top variables on the first component only:
head(selectVar(final.pca.multi, comp = 1)$value)
```

```
##        value.var
## ABCE1  0.3242162
## ABCD3  0.2647565
## ABCF3  0.2613074
## ABCA8 -0.2609394
## ABCB7  0.2493680
## ABCF1  0.2424253
```

Note:

* *Here the variables are not selected (all are included), but ranked according to their importance in defining each component.*

### 3.2.4 Sample plots {#03:pca-sample-plot}

We project the samples into the space spanned by the principal components to visualise how the samples cluster and assess for biological or technical variation in the data. We colour the samples according to the cell line information available in `multidrug$cell.line$Class` by specifying the argument `group` (Fig. [5](#fig:03-pca-sample-plot)).

```
plotIndiv(final.pca.multi,
          comp = c(1, 2),   # Specify components to plot
          ind.names = TRUE, # Show row names of samples
          group = multidrug$cell.line$Class,
          title = 'ABC transporters, PCA comp 1 - 2',
          legend = TRUE, legend.title = 'Cell line')
```

![Sample plot from the PCA performed on the ABC.trans data. Samples are projected into the space spanned by the first two principal components, and coloured according to cell line type. Numbers indicate the rownames of the data.](data:image/png;base64...)

Figure 5: **Sample plot from the PCA performed on the `ABC.trans` data**. Samples are projected into the space spanned by the first two principal components, and coloured according to cell line type. Numbers indicate the rownames of the data.

Because we have run PCA on three components, we can examine the third component, either by plotting the samples onto the principal components 1 and 3 (PC1 and PC3) in the code above (`comp = c(1, 3)`) or by using the 3D interactive plot (code shown below). The addition of the third principal component only seems to highlight a potential outlier (sample 8, not shown). Potentially, this sample could be removed from the analysis, or, noted when doing further downstream analysis. The removal of outliers should be exercised with great caution and backed up with several other types of analyses (e.g. clustering) or graphical outputs (e.g. boxplots, heatmaps, etc).

```
# Interactive 3D plot will load the rgl library.
plotIndiv(final.pca.multi, style = '3d',
           group = multidrug$cell.line$Class,
          title = 'ABC transporters, PCA comp 1 - 3')
```

These plots suggest that the largest source of variation explained by the first two components can be attributed to the melanoma cell line, while the third component highlights a single outlier sample. Hence, the interpretation of the following outputs should primarily focus on the first two components.

Note:

* *Had we not scaled the data, the separation of the melanoma cell lines would have been more obvious with the addition of the third component, while PC1 and PC2 would have also highlighted the sample outliers 4 and 8. Thus, centering and scaling are important steps to take into account in PCA.*

### 3.2.5 Variable plot: correlation circle plot {#03:pca-variable-plot}

Correlation circle plots indicate the contribution of each variable to each component using the `plotVar()` function, as well as the correlation between variables (indicated by a ‘cluster’ of variables). Note that to interpret the latter, the variables need to be centered and scaled in PCA:

```
plotVar(final.pca.multi, comp = c(1, 2),
        var.names = TRUE,
        cex = 3,         # To change the font size
        # cutoff = 0.5,  # For further cutoff
        title = 'Multidrug transporter, PCA comp 1 - 2')
```

![Correlation Circle plot from the PCA performed on the ABC.trans data. The plot shows groups of transporters that are highly correlated, and also contribute to PC1 - near the big circle on the right hand side of the plot (transporters grouped with those in orange), or PC1 and PC2 - top left and top bottom corner of the plot, transporters grouped with those in pink and yellow.](data:image/png;base64...)

Figure 6: **Correlation Circle plot from the PCA performed on the `ABC.trans` data**. The plot shows groups of transporters that are highly correlated, and also contribute to PC1 - near the big circle on the right hand side of the plot (transporters grouped with those in orange), or PC1 and PC2 - top left and top bottom corner of the plot, transporters grouped with those in pink and yellow.

The plot in Figure [6](#fig:03-pca-variable-plot) highlights a group of ABC transporters that contribute to PC1: ABCE1, and to some extent the group clustered with ABCB8 that contributes positively to PC1, while ABCA8 contributes negatively. We also observe a group of transporters that contribute to both PC1 and PC2: the group clustered with ABCC2 contributes negatively both to PC1 and PC2, and a cluster of ABCC12 and ABCD2 that contributes negatively to PC1 and positively to PC2. We observe that several transporters are inside the small circle. However, examining the third component (argument `comp = c(1, 3)`) does not appear to reveal further transporters that contribute to this third component. The additional argument `cutoff = 0.5` could further simplify this plot.

### 3.2.6 Biplot: samples and variables {#03:pca-biplot}

A biplot allows us to display both samples and variables simultaneously to further understand their relationships. Samples are displayed as dots while variables are displayed at the tips of the arrows. Similar to correlation circle plots, data must be centered and scaled to interpret the correlation between variables (as a cosine angle between variable arrows).

```
biplot(final.pca.multi, group = multidrug$cell.line$Class,
       legend.title = 'Cell line')
```

![Biplot from the PCA performed on the ABS.trans data. The plot highlights which transporter expression levels may be related to specific cell lines, such as melanoma.](data:image/png;base64...)

Figure 7: **Biplot from the PCA performed on the `ABS.trans` data**. The plot highlights which transporter expression levels may be related to specific cell lines, such as melanoma.

The biplot in Figure [7](#fig:03-pca-biplot) shows that the melanoma cell lines seem to be characterised by a subset of transporters such as the cluster around ABCC2 as highlighted previously in Figure [6](#fig:03-pca-variable-plot). Further examination of the data, such as boxplots (as shown in Fig. [8](#fig:03-pca-boxplot)), can further elucidate the transporter expression levels for these specific samples.

```
ABCC2.scale <- scale(X[, 'ABCC2'], center = TRUE, scale = TRUE)

boxplot(ABCC2.scale ~
        multidrug$cell.line$Class, col = color.mixo(1:9),
        xlab = 'Cell lines', ylab = 'Expression levels, scaled',
        par(cex.axis = 0.5), # Font size
        main = 'ABCC2 transporter')
```

![Boxplots of the transporter ABCC2 identified from the PCA correlation circle plot (Fig. 6) and the biplot (Fig. 7) show the level of ABCC2 expression related to cell line types. The expression level of ABCC2 was centered and scaled in the PCA, but similar patterns are also observed in the original data.](data:image/png;base64...)

Figure 8: **Boxplots of the transporter ABCC2** identified from the PCA correlation circle plot (Fig. [6](#fig:03-pca-variable-plot)) and the biplot (Fig. [7](#fig:03-pca-biplot)) show the level of ABCC2 expression related to cell line types. The expression level of ABCC2 was centered and scaled in the PCA, but similar patterns are also observed in the original data.

## 3.3 Example: sparse PCA {#03:spca}

In the `ABC.trans` data, there is only one missing value. Missing values can be handled by sPCA via the NIPALS algorithm . However, if the number of missing values is large, we recommend imputing them with NIPALS, as we describe in our website in www.mixOmics.org.

### 3.3.1 Choose the number of variables to select {#03:spca-vars}

First, we must decide on the number of components to evaluate. The previous tuning step indicated that `ncomp = 3` was sufficient to explain most of the variation in the data, which is the value we choose in this example. We then set up a grid of `keepX` values to test, which can be thin or coarse depending on the total number of variables. We set up the grid to be thin at the start, and coarse as the number of variables increases. The `ABC.trans` data includes a sufficient number of samples to perform repeated 5-fold cross-validation to define the number of folds and repeats (leave-one-out CV is also possible if the number of samples \(N\) is small by specifying `folds =` \(N\)). The computation may take a while if you are not using parallelisation (see additional parameters in `tune.spca()`), here we use a small number of repeats for illustrative purposes. We then plot the output of the tuning function.

```
grid.keepX <- c(seq(5, 30, 5))
# grid.keepX  # To see the grid

set.seed(30) # For reproducibility with this handbook, remove otherwise
tune.spca.result <- tune.spca(X, ncomp = 3,
                              folds = 5,
                              test.keepX = grid.keepX, nrepeat = 10)

# Consider adding up to 50 repeats for more stable results
tune.spca.result$choice.keepX
```

```
## comp1 comp2 comp3
##    25    25    30
```

```
plot(tune.spca.result)
```

![Tuning the number of variables to select with sPCA on the ABC.trans data. For a grid of number of variables to select indicated on the x-axis, the average correlation between predicted and actual components based on cross-validation is calculated and shown on the y-axis for each component. The optimal number of variables to select per component is assessed via one-sided \(t-\)tests and is indicated with a diamond.](data:image/png;base64...)

Figure 9: **Tuning the number of variables to select with sPCA on the `ABC.trans` data**. For a grid of number of variables to select indicated on the x-axis, the average correlation between predicted and actual components based on cross-validation is calculated and shown on the y-axis for each component. The optimal number of variables to select per component is assessed via one-sided \(t-\)tests and is indicated with a diamond.

The tuning function outputs the averaged correlation between predicted and actual components per `keepX` value for each component. It indicates the optimal number of variables to select for which the averaged correlation is maximised on each component. Figure [9](#fig:03-spca-tuning) shows that this is achieved when selecting 25 transporters on the first component, and 25 on the second. Given the drop in values in the averaged correlations for the third component, we decide to only retain two components.

Note:

* *If the tuning results suggest a large number of variables to select that is close to the total number of variables, we can arbitrarily choose a much smaller selection size.*

### 3.3.2 Final sparse PCA {#03:spca-final}

Based on the tuning above, we perform the final sPCA where the number of variables to select on each component is specified with the argument `keepX`. Arbitrary values can also be input if you would like to skip the tuning step for more exploratory analyses:

```
# By default center = TRUE, scale = TRUE
keepX.select <- tune.spca.result$choice.keepX[1:2]

final.spca.multi <- spca(X, ncomp = 2, keepX = keepX.select)

# Proportion of explained variance:
final.spca.multi$prop_expl_var$X
```

```
##       PC1       PC2
## 0.1201529 0.1023172
```

Overall when considering two components, we lose approximately 0.6 % of explained variance compared to a full PCA, but the aim of this analysis is to identify key transporters driving the variation in the data, as we show below.

### 3.3.3 Sample and variable plots {#03:spca-plots}

We first examine the sPCA sample plot:

```
plotIndiv(final.spca.multi,
          comp = c(1, 2),   # Specify components to plot
          ind.names = TRUE, # Show row names of samples
          group = multidrug$cell.line$Class,
          title = 'ABC transporters, sPCA comp 1 - 2',
          legend = TRUE, legend.title = 'Cell line')
```

![Sample plot from the sPCA performed on the ABC.trans data. Samples are projected onto the space spanned by the first two sparse principal components that are calculated based on a subset of selected variables. Samples are coloured by cell line type and numbers indicate the sample IDs.](data:image/png;base64...)

Figure 10: **Sample plot from the sPCA performed on the `ABC.trans` data**. Samples are projected onto the space spanned by the first two sparse principal components that are calculated based on a subset of selected variables. Samples are coloured by cell line type and numbers indicate the sample IDs.

In Figure [10](#fig:03-spca-sample-plot), component 2 in sPCA shows clearer separation of the melanoma samples compared to the full PCA. Component 1 is similar to the full PCA. Overall, this sample plot shows that little information is lost compared to a full PCA.

A biplot can also be plotted that only shows the selected transporters (Figure [11](#fig:03-spca-biplot)):

```
biplot(final.spca.multi, group = multidrug$cell.line$Class,
       legend =FALSE)
```

![Biplot from the sPCA performed on the ABS.trans data after variable selection. The plot highlights in more detail which transporter expression levels may be related to specific cell lines, such as melanoma, compared to a classical PCA.](data:image/png;base64...)

Figure 11: **Biplot from the sPCA performed on the `ABS.trans` data after variable selection**. The plot highlights in more detail which transporter expression levels may be related to specific cell lines, such as melanoma, compared to a classical PCA.

The correlation circle plot highlights variables that contribute to component 1 and component 2 (Fig. [12](#fig:03-spca-variable-plot)):

```
plotVar(final.spca.multi, comp = c(1, 2), var.names = TRUE,
        cex = 3, # To change the font size
        title = 'Multidrug transporter, sPCA comp 1 - 2')
```

![Correlation Circle plot from the sPCA performed on the ABC.trans data. Only the transporters selected by the sPCA are shown on this plot. Transporters coloured in green are discussed in the text.](data:image/png;base64...)

Figure 12: **Correlation Circle plot from the sPCA performed on the `ABC.trans` data**. Only the transporters selected by the sPCA are shown on this plot. Transporters coloured in green are discussed in the text.

The transporters selected by sPCA are amongst the most important ones in PCA. Those coloured in green in Figure [6](#fig:03-pca-variable-plot) (ABCA9, ABCB5, ABCC2 and ABCD1) show an example of variables that contribute positively to component 2, but with a larger weight than in PCA. Thus, they appear as a clearer cluster in the top part of the correlation circle plot compared to PCA. As shown in the biplot in Figure [11](#fig:03-spca-biplot), they contribute in explaining the variation in the melanoma samples.

We can extract the variable names and their positive or negative contribution to a given component (here 2), using the `selectVar()` function:

```
# On the first component, just a head
head(selectVar(final.spca.multi, comp = 2)$value)
```

```
##        value.var
## ABCA9  0.4004229
## ABCB5  0.3843246
## ABCC2  0.3825435
## ABCD1  0.3615743
## ABCA3 -0.2655910
## ABCD2 -0.2614975
```

The loading weights can also be visualised with `plotLoading()`, where variables are ranked from the least important (top) to the most important (bottom) in Figure [13](#fig:03-spca-loading-plot)). Here on component 2:

```
plotLoadings(final.spca.multi, comp = 2)
```

![sPCA loading plot of the ABS.trans data for component 2. Only the transporters selected by sPCA on component 2 are shown, and are ranked from least important (top) to most important. Bar length indicates the loading weight in PC2.](data:image/png;base64...)

Figure 13: **sPCA loading plot of the `ABS.trans` data for component 2**. Only the transporters selected by sPCA on component 2 are shown, and are ranked from least important (top) to most important. Bar length indicates the loading weight in PC2.

# 4 PLS on the liver toxicity study {#04}

The data come from a liver toxicity study in which 64 male rats were exposed to non-toxic (50 or 150 mg/kg), moderately toxic (1500 mg/kg) or severely toxic (2000 mg/kg) doses of acetaminophen (paracetamol) (Bushel, Wolfinger, and Gibson [2007](#ref-Bus07)). Necropsy was performed at 6, 18, 24 and 48 hours after exposure and the mRNA was extracted from the liver. Ten clinical measurements of markers for liver injury are available for each subject. The microarray data contain expression levels of 3,116 genes. The data were normalised and preprocessed by Bushel, Wolfinger, and Gibson ([2007](#ref-Bus07)).

`liver toxicity` contains the following:

* `$gene`: A data frame with 64 rows (rats) and 3116 columns (gene expression levels),
* `$clinic`: A data frame with 64 rows (same rats) and 10 columns (10 clinical variables),
* `$treatment`: A data frame with 64 rows and 4 columns, describe the different treatments, such as doses of acetaminophen and times of necropsy.

We can analyse these two data sets (genes and clinical measurements) using sPLS1, then sPLS2 with a regression mode to explain or predict the clinical variables with respect to the gene expression levels.

## 4.1 Load the data {#04:load-data}

```
## ── R CMD build ─────────────────────────────────────────────────────────────────
## * checking for file ‘/tmp/Rtmptuun6k/remotes1a2c7b1266a5c5/mixOmicsTeam-mixOmics-ad47493/DESCRIPTION’ ... OK
## * preparing ‘mixOmics’:
## * checking DESCRIPTION meta-information ... OK
## * checking for LF line-endings in source and make files and shell scripts
## * checking for empty or unneeded directories
## * looking to see if a ‘data/datalist’ file should be added
## * building ‘mixOmics_6.32.0.tar.gz’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pca/pca-plot-coloured-by-primary-groups-custom-cols-reordered-groups.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pca/pca-plot-coloured-by-primary-groups-custom-cols-with-set-pch-circle-for-all-samples.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pca/pca-plot-coloured-by-primary-groups-custom-cols-with-set-pch-triangle-for-all-samples.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pca/pca-plot-coloured-by-primary-groups-with-pch-for-secondary-groups-reordered.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pca/pca-plot-coloured-by-primary-groups-with-pch-for-secondary-groups.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pca/pca-plot-coloured-by-primary-groups-with-set-pch-for-each-group.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pca/pca-plot-sample-names-coloured-by-primary-groups-custom-cols.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pca/pca-plot-with-centroids-coloured-by-primary-groups-custom-cols.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pca/pca-plot-with-ellipse-coloured-by-primary-groups-custom-cols-ellipse-level-0-5.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pca/pca-plot-with-ellipse-coloured-by-primary-groups-custom-cols-sample-names.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pca/pca-plot-with-ellipse-coloured-by-primary-groups-custom-cols.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pls/pca-plot-sample-names-coloured-by-primary-groups-custom-cols.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pls/rcca-plot-coloured-by-primary-groups-custom-cols-reordered-groups.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pls/rcca-plot-coloured-by-primary-groups-custom-cols-with-set-pch-circle-for-all-samples.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pls/rcca-plot-coloured-by-primary-groups-with-pch-for-secondary-groups.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pls/rcca-plot-coloured-by-primary-groups-with-set-pch-for-each-group.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pls/rcca-plot-with-ellipse-coloured-by-primary-groups-ellipse-level-0-5.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pls/rcca-plot-with-pch-for-primary-groups-col-consistent.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pls/spls-plot-with-centroids-and-stars-coloured-by-primary-groups.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotIndiv.pls/splsda-plot-with-centroids-and-stars-custom-cols-pch-on-second-grouping.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.mint.pls/loadings-plot-mint-pls-change-cols-and-borders-ggplot2.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.mint.pls/loadings-plot-mint-pls-change-cols-and-borders-graphics.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.mint.pls/loadings-plot-mint-pls-change-gene-names-ggplot2.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.mint.pls/loadings-plot-mint-pls-change-gene-names-graphics.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.mint.pls/loadings-plot-mint-pls-change-labels-and-label-sizes-ggplot2.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.mint.pls/loadings-plot-mint-pls-change-labels-and-label-sizes-graphics.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.mint.pls/loadings-plot-mint-pls-change-layout-ggplot2.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.mint.pls/loadings-plot-mint-pls-change-layout-graphics.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.mint.pls/loadings-plot-mint-pls-specific-study-ggplot2.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.mint.pls/loadings-plot-mint-pls-specific-study-graphics.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.mint.plsda/mint-plsda-loadings-ggplot2-specific-study.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.pca/loadings-plot-change-gene-names-and-plot-top-3-ggplot2.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.pca/loadings-plot-change-gene-names-and-plot-top-3-graphics.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.pca/loadings-plot-change-labels-and-label-sizes-ggplot2.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.pca/loadings-plot-change-labels-and-label-sizes-graphics.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.pls/loadings-plot-spls-change-cols-and-borders-ggplot2.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.pls/loadings-plot-spls-change-cols-and-borders-graphics.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.pls/loadings-plot-spls-change-gene-names-and-plot-top-3-ggplot2.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.pls/loadings-plot-spls-change-gene-names-and-plot-top-3-graphics.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.pls/loadings-plot-spls-change-labels-and-label-sizes-ggplot2.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.pls/loadings-plot-spls-change-labels-and-label-sizes-graphics.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.plsda/loadings-plot-splsda-with-custom-legend-ggplot2.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.plsda/loadings-plot-splsda-with-custom-legend-graphics.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.plsda/loadings-plot-splsda-with-custom-names-graphics.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.plsda/loadings-plot-splsda-with-custom-title-and-labels-ggplot2.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.plsda/loadings-plot-splsda-with-custom-title-and-labels-graphics.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.sgccda/loadings-plot-diablo-block-specific-with-contrib-ggplot2.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.sgccda/loadings-plot-diablo-block-specific-with-contrib-graphics.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.sgccda/loadings-plot-diablo-change-labels-and-label-sizes-ggplot2.svg’
## Warning in utils::tar(filepath, pkgname, compression = compression, compression_level = 9L,  :
##   storing paths of more than 100 bytes is not portable:
##   ‘mixOmics/tests/testthat/_snaps/plotLoadings.sgccda/loadings-plot-diablo-change-labels-and-label-sizes-graphics.svg’
```

```
library(mixOmics)
data(liver.toxicity)
X <- liver.toxicity$gene
Y <- liver.toxicity$clinic
```

As we have discussed previously for integrative analysis, we need to ensure that the samples in the two data sets are in the same order, or matching, as we are performing data integration:

```
head(data.frame(rownames(X), rownames(Y)))
```

```
##   rownames.X. rownames.Y.
## 1       ID202       ID202
## 2       ID203       ID203
## 3       ID204       ID204
## 4       ID206       ID206
## 5       ID208       ID208
## 6       ID209       ID209
```

## 4.2 Example: sPLS1 regression {#04:spls1}

We first start with a simple case scenario where we wish to explain one \(\boldsymbol Y\) variable with a combination of selected \(\boldsymbol X\) variables (transcripts). We choose the following clinical measurement which we denote as the \(\boldsymbol y\) single response variable:

```
y <- liver.toxicity$clinic[, "ALB.g.dL."]
```

### 4.2.1 Number of dimensions using the \(Q^2\) criterion {#04:spls1-ncomp}

Defining the ‘best’ number of dimensions to explain the data requires we first launch a PLS1 model with a large number of components. Some of the outputs from the PLS1 object are then retrieved in the `perf()` function to calculate the \(Q^2\) criterion using repeated 10-fold cross-validation.

```
tune.pls1.liver <- pls(X = X, Y = y, ncomp = 4, mode = 'regression')
set.seed(33)  # For reproducibility with this handbook, remove otherwise
Q2.pls1.liver <- perf(tune.pls1.liver, validation = 'Mfold',
                      folds = 10, nrepeat = 5)
plot(Q2.pls1.liver, criterion = 'Q2')
```

![\(Q^2\) criterion to choose the number of components in PLS1. For each dimension added to the PLS model, the \(Q^2\) value is shown. The horizontal line of 0.0975 indicates the threshold below which adding a dimension may not be beneficial to improve accuracy in PLS.](data:image/png;base64...)

Figure 14: **\(Q^2\) criterion to choose the number of components in PLS1**. For each dimension added to the PLS model, the \(Q^2\) value is shown. The horizontal line of 0.0975 indicates the threshold below which adding a dimension may not be beneficial to improve accuracy in PLS.

The plot in Figure [14](#fig:04-spls1-ncomp) shows that the \(Q^2\) value varies with the number of dimensions added to PLS1, with a decrease to negative values from 2 dimensions. Based on this plot we would choose only one dimension, but we will still add a second dimension for the graphical outputs.

Note:

* *One dimension is not unusual given that we only include one \(\boldsymbol y\) variable in PLS1.*

### 4.2.2 Number of variables to select in \(\boldsymbol X\) {#04:spls1-tuning}

We now set a grid of values - thin at the start, but also restricted to a small number of genes for a parsimonious model, which we will test for each of the two components in the `tune.spls()` function, using the MAE criterion.

```
# Set up a grid of values:
list.keepX <- c(5:10, seq(15, 50, 5))

# list.keepX  # Inspect the keepX grid
set.seed(33)  # For reproducibility with this handbook, remove otherwise
tune.spls1.MAE <- tune.spls(X, y, ncomp= 2,
                            test.keepX = list.keepX,
                            validation = 'Mfold',
                            folds = 10,
                            nrepeat = 5,
                            progressBar = FALSE,
                            measure = 'MAE')
plot(tune.spls1.MAE)
```

![Mean Absolute Error criterion to choose the number of variables to select in PLS1, using repeated CV times for a grid of variables to select. The MAE increases with the addition of a second dimension comp 1 to 2, suggesting that only one dimension is sufficient. The optimal keepX is indicated with a diamond.](data:image/png;base64...)

Figure 15: **Mean Absolute Error criterion to choose the number of variables to select in PLS1**, using repeated CV times for a grid of variables to select. The MAE increases with the addition of a second dimension comp 1 to 2, suggesting that only one dimension is sufficient. The optimal `keepX` is indicated with a diamond.

Figure [15](#fig:04-spls1-tuning) confirms that one dimension is sufficient to reach minimal MAE. Based on the `tune.spls()` function we extract the final parameters:

```
choice.ncomp <- tune.spls1.MAE$choice.ncomp$ncomp
# Optimal number of variables to select in X based on the MAE criterion
# We stop at choice.ncomp
choice.keepX <- tune.spls1.MAE$choice.keepX[1:choice.ncomp]

choice.ncomp
```

```
## [1] 1
```

```
choice.keepX
```

```
## comp1
##    20
```

Note:

* *Other criterion could have been used and may bring different results. For example, when using `measure = 'MSE`, the optimal `keepX` was rather unstable, and is often smaller than when using the MAE criterion. As we have highlighted before, there is some back and forth in the analyses to choose the criterion and parameters that best fit our biological question and interpretation.*

### 4.2.3 Final sPLS1 model {#04:spls1-final}

Here is our final model with the tuned parameters:

```
spls1.liver <- spls(X, y, ncomp = choice.ncomp, keepX = choice.keepX,
                    mode = "regression")
```

The list of genes selected on component 1 can be extracted with the command line (not output here):

```
selectVar(spls1.liver, comp = 1)$X$name
```

We can compare the amount of explained variance for the \(\boldsymbol X\) data set based on the sPLS1 (on 1 component) versus PLS1 (that was run on 4 components during the tuning step):

```
spls1.liver$prop_expl_var$X
```

```
##      comp1
## 0.08150917
```

```
tune.pls1.liver$prop_expl_var$X
```

```
##      comp1      comp2      comp3      comp4
## 0.11079101 0.14010577 0.21714518 0.06433377
```

The amount of explained variance in \(\boldsymbol X\) is lower in sPLS1 than PLS1 for the first component. However, we will see in this case study that the Mean Squared Error Prediction is also lower (better) in sPLS1 compared to PLS1.

### 4.2.4 Sample plots {#04:spls1-sample-plots}

For further graphical outputs, we need to add a second dimension in the model, which can include the same number of `keepX` variables as in the first dimension. However, the interpretation should primarily focus on the first dimension. In Figure [16](#fig:04-spls1-sample-plot) we colour the samples according to the time of treatment and add symbols to represent the treatment dose. Recall however that such information was not included in the sPLS1 analysis.

```
spls1.liver.c2 <- spls(X, y, ncomp = 2, keepX = c(rep(choice.keepX, 2)),
                   mode = "regression")

plotIndiv(spls1.liver.c2,
          group = liver.toxicity$treatment$Time.Group,
          pch = as.factor(liver.toxicity$treatment$Dose.Group),
          legend = TRUE, legend.title = 'Time', legend.title.pch = 'Dose')
```

![Sample plot from the PLS1 performed on the liver.toxicity data with two dimensions. Components associated to each data set (or block) are shown. Focusing only on the projection of the sample on the first component shows that the genes selected in \(\boldsymbol X\) tend to explain the 48h length of treatment vs the earlier time points. This is somewhat in agreement with the levels of the \(\boldsymbol y\) variable. However, more insight can be obtained by plotting the first components only, as shown in Figure 17.](data:image/png;base64...)

Figure 16: **Sample plot from the PLS1 performed on the `liver.toxicity` data with two dimensions**. Components associated to each data set (or block) are shown. Focusing only on the projection of the sample on the first component shows that the genes selected in \(\boldsymbol X\) tend to explain the 48h length of treatment vs the earlier time points. This is somewhat in agreement with the levels of the \(\boldsymbol y\) variable. However, more insight can be obtained by plotting the first components only, as shown in Figure [17](#fig:04-spls1-sample-plot2).

The alternative is to plot the component associated to the \(\boldsymbol X\) data set (here corresponding to a linear combination of the selected genes) vs. the component associated to the \(\boldsymbol y\) variable (corresponding to the scaled \(\boldsymbol y\) variable in PLS1 with one dimension), or calculate the correlation between both components:

```
# Define factors for colours matching plotIndiv above
time.liver <- factor(liver.toxicity$treatment$Time.Group,
                     levels = c('18', '24', '48', '6'))
dose.liver <- factor(liver.toxicity$treatment$Dose.Group,
                     levels = c('50', '150', '1500', '2000'))
# Set up colours and symbols
col.liver <- color.mixo(time.liver)
pch.liver <- as.numeric(dose.liver)

plot(spls1.liver$variates$X, spls1.liver$variates$Y,
     xlab = 'X component', ylab = 'y component / scaled y',
     col = col.liver, pch = pch.liver)
legend('topleft', col = color.mixo(1:4), legend = levels(time.liver),
       lty = 1, title = 'Time')
legend('bottomright', legend = levels(dose.liver), pch = 1:4,
       title = 'Dose')
```

![Sample plot from the sPLS1 performed on the liver.toxicity data on one dimension. A reduced representation of the 20 genes selected and combined in the \(\boldsymbol X\) component on the \(x-\)axis with respect to the \(\boldsymbol y\) component value (equivalent to the scaled values of \(\boldsymbol y\)) on the \(y-\)axis. We observe a separation between the high doses 1500 and 2000 mg/kg (symbols \(+\) and \(\times\)) at 48h and 18h while low and medium doses cluster in the middle of the plot. High doses for 6h and 18h have high scores for both components.](data:image/png;base64...)

Figure 17: **Sample plot from the sPLS1 performed on the `liver.toxicity` data on one dimension**. A reduced representation of the 20 genes selected and combined in the \(\boldsymbol X\) component on the \(x-\)axis with respect to the \(\boldsymbol y\) component value (equivalent to the scaled values of \(\boldsymbol y\)) on the \(y-\)axis. We observe a separation between the high doses 1500 and 2000 mg/kg (symbols \(+\) and \(\times\)) at 48h and 18h while low and medium doses cluster in the middle of the plot. High doses for 6h and 18h have high scores for both components.

```
cor(spls1.liver$variates$X, spls1.liver$variates$Y)
```

```
##           comp1
## comp1 0.7515489
```

Figure [17](#fig:04-spls1-sample-plot2) is a reduced representation of a multivariate regression with PLS1. It shows that PLS1 effectively models a linear relationship between \(\boldsymbol y\) and the combination of the 20 genes selected in \(\boldsymbol X\).

### 4.2.5 Performance assessment of sPLS1 {#04:spls1-perf}

The performance of the final model can be assessed with the `perf()` function, using repeated cross-validation (CV). Because a single performance value has little meaning, we propose to compare the performances of a full PLS1 model (with no variable selection) with our sPLS1 model based on the MSEP (other criteria can be used):

```
set.seed(33)  # For reproducibility with this handbook, remove otherwise

# PLS1 model and performance
pls1.liver <- pls(X, y, ncomp = choice.ncomp, mode = "regression")
perf.pls1.liver <- perf(pls1.liver, validation = "Mfold", folds =10,
                   nrepeat = 5, progressBar = FALSE)
perf.pls1.liver$measures$MSEP$summary
```

```
##   feature comp      mean         sd
## 1       Y    1 0.7128988 0.04786608
```

```
# To extract values across all repeats:
# perf.pls1.liver$measures$MSEP$values

# sPLS1 performance
perf.spls1.liver <- perf(spls1.liver, validation = "Mfold", folds = 10,
                   nrepeat = 5, progressBar = FALSE)
perf.spls1.liver$measures$MSEP$summary
```

```
##   feature comp     mean         sd
## 1       Y    1 0.576395 0.03274004
```

The MSEP is lower with sPLS1 compared to PLS1, indicating that the \(\boldsymbol{X}\) variables selected (listed above with `selectVar()`) can be considered as a good linear combination of predictors to explain \(\boldsymbol y\).

## 4.3 Example: PLS2 regression {#04:spls2}

PLS2 is a more complex problem than PLS1, as we are attempting to fit a linear combination of a subset of \(\boldsymbol{Y}\) variables that are maximally covariant with a combination of \(\boldsymbol{X}\) variables. The sparse variant allows for the selection of variables from both data sets.

As a reminder, here are the dimensions of the \(\boldsymbol{Y}\) matrix that includes clinical parameters associated with liver failure.

```
dim(Y)
```

```
## [1] 64 10
```

### 4.3.1 Number of dimensions using the \(Q^2\) criterion {#04:spls2-ncomp}

Similar to PLS1, we first start by tuning the number of components to select by using the `perf()` function and the \(Q^2\) criterion using repeated cross-validation.

```
tune.pls2.liver <- pls(X = X, Y = Y, ncomp = 5, mode = 'regression')

set.seed(33)  # For reproducibility with this handbook, remove otherwise
Q2.pls2.liver <- perf(tune.pls2.liver, validation = 'Mfold', folds = 10,
                      nrepeat = 5)
plot(Q2.pls2.liver, criterion = 'Q2.total')
```

![\(Q^2\) criterion to choose the number of components in PLS2. For each component added to the PLS2 model, the averaged \(Q^2\) across repeated cross-validation is shown, with the horizontal line of 0.0975 indicating the threshold below which the addition of a dimension may not be beneficial to improve accuracy.](data:image/png;base64...)

Figure 18: **\(Q^2\) criterion to choose the number of components in PLS2**. For each component added to the PLS2 model, the averaged \(Q^2\) across repeated cross-validation is shown, with the horizontal line of 0.0975 indicating the threshold below which the addition of a dimension may not be beneficial to improve accuracy.

Figure [18](#fig:04-spls2-ncomp) shows that one dimension should be sufficient in PLS2. We will include a second dimension in the graphical outputs, whilst focusing our interpretation on the first dimension.

Note:

* *Here we chose repeated cross-validation, however, the conclusions were similar for `nrepeat = 1`.*

### 4.3.2 Number of variables to select in both \(\boldsymbol X\) and \(\boldsymbol Y\) {#04:spls2-tuning}

Using the `tune.spls()` function, we can perform repeated cross-validation to obtain some indication of the number of variables to select. We show an example of code below which may take some time to run (see `?tune.spls()` to use parallel computing). We had refined the grid of tested values as the tuning function tended to favour a very small signature. Hence we decided to constrain the start of the grid to 3 for a more insightful signature. Both `measure = 'cor` and `RSS` gave similar signature sizes, but this observation might differ for other case studies.

The optimal parameters can be output, along with a plot showing the tuning results, as shown in Figure [19](#fig:04-spls2-tuning):

```
# This code may take several min to run, parallelisation option is possible
list.keepX <- c(seq(5, 50, 5))
list.keepY <- c(3:10)

set.seed(33)  # For reproducibility with this handbook, remove otherwise
tune.spls.liver <- tune.spls(X, Y, test.keepX = list.keepX,
                             test.keepY = list.keepY, ncomp = 2,
                             nrepeat = 1, folds = 10, mode = 'regression',
                             measure = 'cor',
                            #   the following uses two CPUs for faster computation
                            # it can be commented out
                            BPPARAM = BiocParallel::SnowParam(workers = 2)
                            )

plot(tune.spls.liver)
```

![Tuning plot for sPLS2. For every grid value of keepX and keepY, the averaged correlation coefficients between the \(\boldsymbol t\) and \(\boldsymbol u\) components are shown across repeated CV, with optimal values (here corresponding to the highest mean correlation) indicated in a green square for each dimension and data set.](data:image/png;base64...)

Figure 19: **Tuning plot for sPLS2**. For every grid value of `keepX` and `keepY`, the averaged correlation coefficients between the \(\boldsymbol t\) and \(\boldsymbol u\) components are shown across repeated CV, with optimal values (here corresponding to the highest mean correlation) indicated in a green square for each dimension and data set.

### 4.3.3 Final sPLS2 model {#04:spls2-final}

Here is our final model with the tuned parameters for our sPLS2 regression analysis. Note that if you choose to not run the tuning step, you can still decide to set the parameters of your choice here.

```
#Optimal parameters
choice.keepX <- tune.spls.liver$choice.keepX
choice.keepY <- tune.spls.liver$choice.keepY
choice.ncomp <- length(choice.keepX)

spls2.liver <- spls(X, Y, ncomp = choice.ncomp,
                   keepX = choice.keepX,
                   keepY = choice.keepY,
                   mode = "regression")
```

#### 4.3.3.1 Numerical outputs {#04:spls2-variance}

The amount of explained variance can be extracted for each dimension and each data set:

```
spls2.liver$prop_expl_var
```

```
## $X
##      comp1      comp2
## 0.18571719 0.08498846
##
## $Y
##     comp1     comp2
## 0.3649885 0.2191518
```

#### 4.3.3.2 Importance variables {#04:spls2-variables}

The selected variables can be extracted from the `selectVar()` function, for example for the \(\boldsymbol X\) data set, with either their `$name` or the loading `$value` (not output here):

```
selectVar(spls2.liver, comp = 1)$X$value
```

The VIP measure is exported for all variables in \(\boldsymbol X\), here we only subset those that were selected (non null loading value) for component 1:

```
vip.spls2.liver <- vip(spls2.liver)
# just a head
head(vip.spls2.liver[selectVar(spls2.liver, comp = 1)$X$name,1])
```

```
## A_42_P620915  A_43_P14131 A_42_P578246  A_43_P11724 A_42_P840776 A_42_P675890
##     32.00310     28.04314     15.89302     14.50512     12.48658     10.94458
```

The (full) output shows that most \(\boldsymbol X\) variables that were selected are important for explaining \(\boldsymbol Y\), since their VIP is greater than 1.

We can examine how frequently each variable is selected when we subsample the data using the `perf()` function to measure how stable the signature is (Table [1](#tab:04-spls2-stab-table)). The same could be output for other components and the \(\boldsymbol Y\) data set.

```
perf.spls2.liver <- perf(spls2.liver, validation = 'Mfold', folds = 10, nrepeat = 5)
# Extract stability
stab.spls2.liver.comp1 <- perf.spls2.liver$features$stability.X$comp1
# Averaged stability of the X selected features across CV runs, as shown in Table
stab.spls2.liver.comp1[1:choice.keepX[1]]

# We extract the stability measures of only the variables selected in spls2.liver
extr.stab.spls2.liver.comp1 <- stab.spls2.liver.comp1[selectVar(spls2.liver,
                                                                  comp =1)$X$name]
```

Table 1: Stability measure (occurence of selection) of the bottom 20 variables from X selected with sPLS2 across repeated 10-fold subsampling on component 1.

| x |
| --- |
| NA |
| NA |
| NA |
| NA |
| NA |
| NA |
| NA |
| NA |
| NA |
| NA |
| NA |
| NA |
| NA |
| NA |
| NA |
| NA |
| NA |
| NA |
| NA |
| NA |

We recommend to mainly focus on the interpretation of the most stable selected variables (with a frequency of occurrence greater than 0.8).

#### 4.3.3.3 Graphical outputs {#04:spls2-plots}

Using the `plotIndiv()` function, we display the sample and metadata information using the arguments `group` (colour) and `pch` (symbol) to better understand the similarities between samples modelled with sPLS2.

The plot on the left hand side corresponds to the projection of the samples from the \(\boldsymbol X\) data set (gene expression) and the plot on the right hand side the \(\boldsymbol Y\) data set (clinical variables).

```
plotIndiv(spls2.liver, ind.names = FALSE,
          group = liver.toxicity$treatment$Time.Group,
          pch = as.factor(liver.toxicity$treatment$Dose.Group),
          col.per.group = color.mixo(1:4),
          legend = TRUE, legend.title = 'Time',
          legend.title.pch = 'Dose')
```

![Sample plot for sPLS2 performed on the liver.toxicity data. Samples are projected into the space spanned by the components associated to each data set (or block). We observe some agreement between the data sets, and a separation of the 1500 and 2000 mg doses (\(+\) and \(\times\)) in the 18h, 24h time points, and the 48h time point.](data:image/png;base64...)

Figure 20: **Sample plot for sPLS2 performed on the `liver.toxicity` data**. Samples are projected into the space spanned by the components associated to each data set (or block). We observe some agreement between the data sets, and a separation of the 1500 and 2000 mg doses (\(+\) and \(\times\)) in the 18h, 24h time points, and the 48h time point.

From Figure [20](#fig:04-spls2-sample-plot) we observe an effect of low vs. high doses of acetaminophen (component 1) as well as time of necropsy (component 2). There is some level of agreement between the two data sets, but it is not perfect!

If you run an sPLS with three dimensions, you can consider the 3D `plotIndiv()` by specifying `style = '3d` in the function.

The `plotArrow()` option is useful in this context to visualise the level of agreement between data sets. Recall that in this plot:

* The start of the arrow indicates the location of the sample in the \(\boldsymbol X\) projection space,
* The end of the arrow indicates the location of the (same) sample in the \(\boldsymbol Y\) projection space,
* Long arrows indicate a disagreement between the two projected spaces.

```
plotArrow(spls2.liver, ind.names = FALSE,
          group = liver.toxicity$treatment$Time.Group,
          col.per.group = color.mixo(1:4),
          legend.title = 'Time.Group')
```

![Arrow plot from the sPLS2 performed on the liver.toxicity data. The start of the arrow indicates the location of a given sample in the space spanned by the components associated to the gene data set, and the tip of the arrow the location of that same sample in the space spanned by the components associated to the clinical data set. We observe large shifts for 18h, 24 and 48h samples for the high doses, however the clusters of samples remain the same, as we observed in Figure 20.](data:image/png;base64...)

Figure 21: **Arrow plot from the sPLS2 performed on the `liver.toxicity` data**. The start of the arrow indicates the location of a given sample in the space spanned by the components associated to the gene data set, and the tip of the arrow the location of that same sample in the space spanned by the components associated to the clinical data set. We observe large shifts for 18h, 24 and 48h samples for the high doses, however the clusters of samples remain the same, as we observed in Figure [20](#fig:04-spls2-sample-plot).

In Figure [21](#fig:04-spls2-arrow-plot) we observe that specific groups of samples seem to be located far apart from one data set to the other, indicating a potential discrepancy between the information extracted. However the groups of samples according to either dose or treatment remains similar.

Correlation circle plots illustrate the correlation structure between the two types of variables. To display only the name of the variables from the \(\boldsymbol{Y}\) data set, we use the argument `var.names = c(FALSE, TRUE)` where each boolean indicates whether the variable names should be output for each data set. We also modify the size of the font, as shown in Figure [22](#fig:04-spls2-variable-plot):

```
plotVar(spls2.liver, cex = c(3,4), var.names = c(FALSE, TRUE))
```

![Correlation circle plot from the sPLS2 performed on the liver.toxicity data. The plot highlights correlations within selected genes (their names are not indicated here), within selected clinical parameters, and correlations between genes and clinical parameters on each dimension of sPLS2. This plot should be interpreted in relation to Figure 20 to better understand how the expression levels of these molecules may characterise specific sample groups.](data:image/png;base64...)

Figure 22: **Correlation circle plot from the sPLS2 performed on the `liver.toxicity` data**. The plot highlights correlations *within* selected genes (their names are not indicated here), *within* selected clinical parameters, and correlations *between* genes and clinical parameters on each dimension of sPLS2. This plot should be interpreted in relation to Figure [20](#fig:04-spls2-sample-plot) to better understand how the expression levels of these molecules may characterise specific sample groups.

To display variable names that are different from the original data matrix (e.g. gene ID), we set the argument `var.names` as a list for each type of label, with geneBank ID for the \(\boldsymbol X\) data set, and `TRUE` for the \(\boldsymbol Y\) data set:

```
plotVar(spls2.liver,
        var.names = list(X.label = liver.toxicity$gene.ID[,'geneBank'],
        Y.label = TRUE), cex = c(3,4))
```

![Correlation circle plot from the sPLS2 performed on the liver.toxicity data. A variant of Figure 22 with gene names that are available in $gene.ID (Note: some gene names are missing).](data:image/png;base64...)

Figure 23: **Correlation circle plot from the sPLS2 performed on the `liver.toxicity` data**. A variant of Figure [22](#fig:04-spls2-variable-plot) with gene names that are available in `$gene.ID` (Note: some gene names are missing).

The correlation circle plots highlight the contributing variables that, together, explain the covariance between the two data sets. In addition, specific subsets of molecules can be further investigated, and in relation with the sample group they may characterise. The latter can be examined with additional plots (for example boxplots with respect to known sample groups and expression levels of specific variables, as we showed in the PCA case study previously. The next step would be to examine the validity of the biological relationship between the clusters of genes with some of the clinical variables that we observe in this plot.

A 3D plot is also available in `plotVar()` with the argument `style = '3d`. It requires an sPLS2 model with at least three dimensions.

Other plots are available to complement the information from the correlation circle plots, such as Relevance networks and Clustered Image Maps (CIMs), as described in Module 2.

The network in sPLS2 displays only the variables selected by sPLS, with an additional `cutoff` similarity value argument (absolute value between 0 and 1) to improve interpretation. Because Rstudio sometimes struggles with the margin size of this plot, we can either launch `X11()` prior to plotting the network, or use the arguments `save` and `name.save` as shown below:

```
# Define red and green colours for the edges
color.edge <- color.GreenRed(50)

# X11()  # To open a new window for Rstudio
network(spls2.liver, comp = 1:2,
        cutoff = 0.7,
        shape.node = c("rectangle", "circle"),
        color.node = c("cyan", "pink"),
        color.edge = color.edge,
        # To save the plot, unotherwise:
        # save = 'pdf', name.save = 'network_liver'
        )
```

![Network representation from the sPLS2 performed on the liver.toxicity data. The networks are bipartite, where each edge links a gene (rectangle) to a clinical variable (circle) node, according to a similarity matrix described in Module 2. Only variables selected by sPLS2 on the two dimensions are represented and are further filtered here according to a cutoff argument (optional).](data:image/png;base64...)

Figure 24: **Network representation from the sPLS2 performed on the `liver.toxicity` data**. The networks are bipartite, where each edge links a gene (rectangle) to a clinical variable (circle) node, according to a similarity matrix described in Module 2. Only variables selected by sPLS2 on the two dimensions are represented and are further filtered here according to a `cutoff` argument (optional).

Figure [24](#fig:04-spls2-network) shows two distinct groups of variables. The first cluster groups four clinical parameters that are mostly positively associated with selected genes. The second group includes one clinical parameter negatively associated with other selected genes. These observations are similar to what was observed in the correlation circle plot in Figure [22](#fig:04-spls2-variable-plot).

Note:

* *Whilst the edges and nodes in the network do not change, the appearance might be different from one run to another as it relies on a random process to use the space as best as possible (using the `igraph` R package Csardi, Nepusz, and others ([2006](#ref-csa06))).*

The Clustered Image Map also allows us to visualise correlations between variables. Here we choose to represent the variables selected on the two dimensions and we save the plot as a pdf figure.

```
# X11()  # To open a new window if the graphic is too large
cim(spls2.liver, comp = 1:2, xlab = "clinic", ylab = "genes",
    # To save the plot, uncomment:
    # save = 'pdf', name.save = 'cim_liver'
    )
```

![Clustered Image Map from the sPLS2 performed on the liver.toxicity data. The plot displays the similarity values (as described in Module 2) between the \(\boldsymbol X\) and \(\boldsymbol Y\) variables selected across two dimensions, and clustered with a complete Euclidean distance method.](data:image/png;base64...)

Figure 25: **Clustered Image Map from the sPLS2 performed on the `liver.toxicity` data**. The plot displays the similarity values (as described in Module 2) between the \(\boldsymbol X\) and \(\boldsymbol Y\) variables selected across two dimensions, and clustered with a complete Euclidean distance method.

The CIM in Figure [25](#fig:04-spls2-cim) shows that the clinical variables can be separated into three clusters, each of them either positively or negatively associated with two groups of genes. This is similar to what we have observed in Figure [22](#fig:04-spls2-variable-plot). We would give a similar interpretation to the relevance network, had we also used a `cutoff` threshold in `cim()`.

Note:

* *A biplot for PLS objects is also available.*

#### 4.3.3.4 Performance {#04:spls2-perf}

To finish, we assess the performance of sPLS2. As an element of comparison, we consider sPLS2 and PLS2 that includes all variables, to give insights into the different methods.

```
# Comparisons of final models (PLS, sPLS)

## PLS
pls.liver <- pls(X, Y, mode = 'regression', ncomp = 2)
perf.pls.liver <-  perf(pls.liver, validation = 'Mfold', folds = 10,
                        nrepeat = 5)

## Performance for the sPLS model ran earlier
perf.spls.liver <-  perf(spls2.liver, validation = 'Mfold', folds = 10,
                         nrepeat = 5)
```

```
plot(c(1,2), perf.pls.liver$measures$cor.upred$summary$mean,
     col = 'blue', pch = 16,
     ylim = c(0.6,1), xaxt = 'n',
     xlab = 'Component', ylab = 't or u Cor',
     main = 's/PLS performance based on Correlation')
axis(1, 1:2)  # X-axis label
points(perf.pls.liver$measures$cor.tpred$summary$mean, col = 'red', pch = 16)
points(perf.spls.liver$measures$cor.upred$summary$mean, col = 'blue', pch = 17)
points(perf.spls.liver$measures$cor.tpred$summary$mean, col = 'red', pch = 17)
legend('bottomleft', col = c('blue', 'red', 'blue', 'red'),
       pch = c(16, 16, 17, 17), c('u PLS', 't PLS', 'u sPLS', 't sPLS'))
```

![Comparison of the performance of PLS2 and sPLS2, based on the correlation between the actual and predicted components \(\boldsymbol{t,u}\) associated to each data set for each component.](data:image/png;base64...)

Figure 26: **Comparison of the performance of PLS2 and sPLS2**, based on the correlation between the actual and predicted components \(\boldsymbol{t,u}\) associated to each data set for each component.

We extract the correlation between the actual and predicted components \(\boldsymbol{t,u}\) associated to each data set in Figure [26](#fig:04-spls2-perf2). The correlation remains high on the first dimension, even when variables are selected. On the second dimension the correlation coefficients are equivalent or slightly lower in sPLS compared to PLS. Overall this performance comparison indicates that the variable selection in sPLS still retains relevant information compared to a model that includes all variables.

Note:

* *Had we run a similar procedure but based on the RSS, we would have observed a lower RSS for sPLS compared to PLS.*

# 5 PLS-DA on the SRBCT case study {#05}

The Small Round Blue Cell Tumours (SRBCT) data set from (Khan et al. [2001](#ref-Kha01)) includes the expression levels of 2,308 genes measured on 63 samples. The samples are divided into four classes: 8 Burkitt Lymphoma (BL), 23 Ewing Sarcoma (EWS), 12 neuroblastoma (NB), and 20 rhabdomyosarcoma (RMS). The data are directly available in a processed and normalised format from the `mixOmics` package and contains the following:

* `$gene`: A data frame with 63 rows and 2,308 columns. These are the expression levels of 2,308 genes in 63 subjects,
* `$class`: A vector containing the class of tumour for each individual (4 classes in total),
* `$gene.name`: A data frame with 2,308 rows and 2 columns containing further information on the genes.

More details can be found in `?srbct`. We will illustrate PLS-DA and sPLS-DA which are suited for large biological data sets where the aim is to identify molecular signatures, as well as classify samples. We will analyse the gene expression levels of `srbct$gene` to discover which genes may best discriminate the 4 groups of tumours.

## 5.1 Load the data {#05:load-data}

We first load the data from the package. We then set up the data so that \(\boldsymbol X\) is the gene expression matrix and \(\boldsymbol y\) is the factor indicating sample class membership. \(\boldsymbol y\) will be transformed into a dummy matrix \(\boldsymbol Y\) inside the function. We also check that the dimensions are correct and match both \(\boldsymbol X\) and \(\boldsymbol y\):

```
library(mixOmics)
data(srbct)
X <- srbct$gene

# Outcome y that will be internally coded as dummy:
Y <- srbct$class
dim(X); length(Y)
```

```
## [1]   63 2308
## [1] 63
```

```
summary(Y)
```

```
## EWS  BL  NB RMS
##  23   8  12  20
```

## 5.2 Example: PLS-DA {#05:plsda}

### 5.2.1 Initial exploration with PCA {#05:plsda-pca}

As covered in Module 3, PCA is a useful tool to explore the gene expression data and to assess for sample similarities between tumour types. Remember that PCA is an unsupervised approach, but we can colour the samples by their class to assist in interpreting the PCA (Figure [27](#fig:05-plsda-pca)). Here we center (default argument) and scale the data:

```
pca.srbct <- pca(X, ncomp = 3, scale = TRUE)

plotIndiv(pca.srbct, group = srbct$class, ind.names = FALSE,
          legend = TRUE,
          title = 'SRBCT, PCA comp 1 - 2')
```

![Preliminary (unsupervised) analysis with PCA on the SRBCT gene expression data. Samples are projected into the space spanned by the principal components 1 and 2. The tumour types are not clustered, meaning that the major source of variation cannot be explained by tumour types. Instead, samples seem to cluster according to an unknown source of variation.](data:image/png;base64...)

Figure 27: **Preliminary (unsupervised) analysis with PCA on the `SRBCT` gene expression data**. Samples are projected into the space spanned by the principal components 1 and 2. The tumour types are not clustered, meaning that the major source of variation cannot be explained by tumour types. Instead, samples seem to cluster according to an unknown source of variation.

We observe almost no separation between the different tumour types in the PCA sample plot, with perhaps the exception of the NB samples that tend to cluster with other samples. This preliminary exploration teaches us two important findings:

* The major source of variation is not attributable to tumour type, but an unknown source (we tend to observe clusters of samples but those are not explained by tumour type).
* We need a more ‘directed’ (supervised) analysis to separate the tumour types, and we should expect that the amount of variance explained by the dimensions in PLS-DA analysis will be small.

### 5.2.2 Number of components in PLS-DA {#05:plsda-ncomp}

The `perf()` function evaluates the performance of PLS-DA - i.e., its ability to rightly classify ‘new’ samples into their tumour category using repeated cross-validation. We initially choose a large number of components (here `ncomp = 10`) and assess the model as we gradually increase the number of components. Here we use 3-fold CV repeated 10 times. In Module 2, we provided further guidelines on how to choose the `folds` and `nrepeat` parameters:

```
plsda.srbct <- plsda(X,Y, ncomp = 10)

set.seed(30) # For reproducibility with this handbook, remove otherwise
perf.plsda.srbct <- perf(plsda.srbct, validation = 'Mfold', folds = 3,
                  progressBar = FALSE,  # Set to TRUE to track progress
                  nrepeat = 10)         # We suggest nrepeat = 50

plot(perf.plsda.srbct, sd = TRUE, legend.position = 'horizontal')
```

![Tuning the number of components in PLS-DA on the SRBCT gene expression data. For each component, repeated cross-validation (10 \(\times 3-\)fold CV) is used to evaluate the PLS-DA classification performance (overall and balanced error rate BER), for each type of prediction distance; max.dist, centroids.dist and mahalanobis.dist. Bars show the standard deviation across the repeated folds. The plot shows that the error rate reaches a minimum from 3 components.](data:image/png;base64...)

Figure 28: **Tuning the number of components in PLS-DA on the `SRBCT` gene expression data.** For each component, repeated cross-validation (10 \(\times 3-\)fold CV) is used to evaluate the PLS-DA classification performance (overall and balanced error rate BER), for each type of prediction distance; `max.dist`, `centroids.dist` and `mahalanobis.dist`. Bars show the standard deviation across the repeated folds. The plot shows that the error rate reaches a minimum from 3 components.

From the classification performance output presented in Figure [28](#fig:plsda-ncomp), we observe that:

* There are some slight differences between the overall and balanced error rates (BER) with BER > overall, suggesting that minority classes might be ignored from the classification task when considering the overall performance (`summary(Y)` shows that BL only includes 8 samples). In general the trend is the same, however, and for further tuning with sPLS-DA we will consider the BER.
* The error rate decreases and reaches a minimum for `ncomp = 3` for the `max.dist` distance. These parameters will be included in further analyses.

Notes:

* *PLS-DA is an iterative model, where each component is orthogonal to the previous and gradually aims to build more discrimination between sample classes. We should always regard a final PLS-DA (with specified `ncomp`) as a ‘compounding’ model (i.e. PLS-DA with component 3 includes the trained model on the previous two components).*
* *We advise to use at least 50 repeats, and choose the number of folds that are appropriate for the sample size of the data set, as shown in Figure [28](#fig:plsda-ncomp)).*

Additional numerical outputs from the performance results are listed and can be reported as performance measures (not output here):

```
perf.plsda.srbct
```

### 5.2.3 Final PLS-DA model {#05:plsda-final}

We now run our final PLS-DA model that includes three components:

```
final.plsda.srbct <- plsda(X,Y, ncomp = 3)
```

We output the sample plots for the dimensions of interest (up to three). By default, the samples are coloured according to their class membership. We also add confidence ellipses (`ellipse = TRUE`, confidence level set to 95% by default, see the argument `ellipse.level`) in Figure [29](#fig:05-plsda-sample-plots). A 3D plot could also be insightful (use the argument `type = '3D'`).

```
plotIndiv(final.plsda.srbct, ind.names = FALSE, legend=TRUE,
          comp=c(1,2), ellipse = TRUE,
          title = 'PLS-DA on SRBCT comp 1-2',
          X.label = 'PLS-DA comp 1', Y.label = 'PLS-DA comp 2')
```

```
plotIndiv(final.plsda.srbct, ind.names = FALSE, legend=TRUE,
          comp=c(2,3), ellipse = TRUE,
          title = 'PLS-DA on SRBCT comp 2-3',
          X.label = 'PLS-DA comp 2', Y.label = 'PLS-DA comp 3')
```

![Sample plots from PLS-DA performed on the SRBCT gene expression data. Samples are projected into the space spanned by the first three components. (a) Components 1 and 2 and (b) Components 1 and 3. Samples are coloured by their tumour subtypes. Component 1 discriminates RMS + EWS vs. NB + BL, component 2 discriminates RMS + NB vs. EWS + BL, while component 3 discriminates further the NB and BL groups. It is the combination of all three components that enables us to discriminate all classes.](data:image/png;base64...)![Sample plots from PLS-DA performed on the SRBCT gene expression data. Samples are projected into the space spanned by the first three components. (a) Components 1 and 2 and (b) Components 1 and 3. Samples are coloured by their tumour subtypes. Component 1 discriminates RMS + EWS vs. NB + BL, component 2 discriminates RMS + NB vs. EWS + BL, while component 3 discriminates further the NB and BL groups. It is the combination of all three components that enables us to discriminate all classes.](data:image/png;base64...)

Figure 29: **Sample plots from PLS-DA performed on the `SRBCT` gene expression data**. Samples are projected into the space spanned by the first three components. (a) Components 1 and 2 and (b) Components 1 and 3. Samples are coloured by their tumour subtypes. Component 1 discriminates RMS + EWS vs. NB + BL, component 2 discriminates RMS + NB vs. EWS + BL, while component 3 discriminates further the NB and BL groups. It is the combination of all three components that enables us to discriminate all classes.

We can observe improved clustering according to tumour subtypes, compared with PCA. This is to be expected since the PLS-DA model includes the class information of each sample. We observe some discrimination between the NB and BL samples vs. the others on the first component (x-axis), and EWS and RMS vs. the others on the second component (y-axis). From the `plotIndiv()` function, the axis labels indicate the amount of variation explained per component. However, the interpretation of this amount is *not as important* as in PCA, as PLS-DA aims to maximise the covariance between components associated to \(\boldsymbol X\) and \(\boldsymbol Y\), rather than the variance \(\boldsymbol X\).

### 5.2.4 Classification performance {#05:plsda-perf}

We can rerun a more extensive performance evaluation with more repeats for our final model:

```
set.seed(30) # For reproducibility with this handbook, remove otherwise
perf.final.plsda.srbct <- perf(final.plsda.srbct, validation = 'Mfold',
                               folds = 3,
                               progressBar = FALSE, # TRUE to track progress
                               nrepeat = 10) # we recommend 50
```

Retaining only the BER and the `max.dist`, numerical outputs of interest include the final overall performance for 3 components:

```
perf.final.plsda.srbct$error.rate$BER[, 'max.dist']
```

```
##      comp1      comp2      comp3
## 0.56032609 0.27953804 0.05282609
```

As well as the error rate per class across each component:

```
perf.final.plsda.srbct$error.rate.class$max.dist
```

```
##         comp1      comp2      comp3
## EWS 0.2913043 0.09565217 0.09130435
## BL  0.7500000 0.51250000 0.00000000
## NB  0.5000000 0.40000000 0.05000000
## RMS 0.7000000 0.11000000 0.07000000
```

From this output, we can see that the first component tends to classify EWS and NB better than the other classes. As components 2 and then 3 are added, the classification improves for all classes. However we see a slight increase in classification error in component 3 for EWS and RMS while BL is perfectly classified. A permutation test could also be conducted to conclude about the significance of the differences between sample groups, but is not currently implemented in the package.

### 5.2.5 Background prediction {#05:plsda-bgp}

A prediction background can be added to the sample plot by calculating a background surface first, before overlaying the sample plot (Figure [30](#fig:05-plsda-bgp), see Extra Reading material, or `?background.predict`). We give an example of the code below based on the maximum prediction distance:

```
background.max <- background.predict(final.plsda.srbct,
                                     comp.predicted = 2,
                                     dist = 'max.dist')

plotIndiv(final.plsda.srbct, comp = 1:2, group = srbct$class,
          ind.names = FALSE, title = 'Maximum distance',
          legend = TRUE,  background = background.max)
```

![Sample plots from PLS-DA on the SRBCT gene expression data and prediction areas based on prediction distances. From our usual sample plot, we overlay a background prediction area based on permutations from the first two PLS-DA components using the three different types of prediction distances. The outputs show how the prediction distance can influence the quality of the prediction, with samples projected into a wrong class area, and hence resulting in predicted misclassification. (Currently, the prediction area background can only be calculated for the first two components).](data:image/png;base64...)![Sample plots from PLS-DA on the SRBCT gene expression data and prediction areas based on prediction distances. From our usual sample plot, we overlay a background prediction area based on permutations from the first two PLS-DA components using the three different types of prediction distances. The outputs show how the prediction distance can influence the quality of the prediction, with samples projected into a wrong class area, and hence resulting in predicted misclassification. (Currently, the prediction area background can only be calculated for the first two components).](data:image/png;base64...)![Sample plots from PLS-DA on the SRBCT gene expression data and prediction areas based on prediction distances. From our usual sample plot, we overlay a background prediction area based on permutations from the first two PLS-DA components using the three different types of prediction distances. The outputs show how the prediction distance can influence the quality of the prediction, with samples projected into a wrong class area, and hence resulting in predicted misclassification. (Currently, the prediction area background can only be calculated for the first two components).](data:image/png;base64...)

Figure 30: **Sample plots from PLS-DA on the `SRBCT` gene expression data and prediction areas based on prediction distances**. From our usual sample plot, we overlay a background prediction area based on permutations from the first two PLS-DA components using the three different types of prediction distances. The outputs show how the prediction distance can influence the quality of the prediction, with samples projected into a wrong class area, and hence resulting in predicted misclassification. (Currently, the prediction area background can only be calculated for the first two components).

Figure [30](#fig:05-plsda-bgp) shows the differences in prediction according to the prediction distance, and can be used as a further diagnostic tool for distance choice. It also highlights the characteristics of the distances. For example the `max.dist` is a linear distance, whereas both `centroids.dist` and `mahalanobis.dist` are non linear. Our experience has shown that as discrimination of the classes becomes more challenging, the complexity of the distances (from maximum to Mahalanobis distance) should increase, see details in the Extra reading material.

## 5.3 Example: sPLS-DA {#05:splsda}

In high-throughput experiments, we expect that many of the 2308 genes in \(\boldsymbol X\) are noisy or uninformative to characterise the different classes. An sPLS-DA analysis will help refine the sample clusters and select a small subset of variables relevant to discriminate each class.

### 5.3.1 Number of variables to select {#05:splsda-keepX}

We estimate the classification error rate with respect to the number of selected variables in the model with the function `tune.splsda()`. The tuning is being performed one component at a time inside the function and the optimal number of variables to select is automatically retrieved after each component run, as described in Module 2.

Previously, we determined the number of components to be `ncomp = 3` with PLS-DA. Here we set `ncomp = 4` to further assess if this would be the case for a sparse model, and use 5-fold cross validation repeated 10 times. We also choose the maximum prediction distance.

Note:

* *For a thorough tuning step, the following code should be repeated 10 - 50 times and the error rate is averaged across the runs. You may obtain slightly different results below for this reason.*

We first define a grid of `keepX` values. For example here, we define a fine grid at the start, and then specify a coarser, larger sequence of values:

```
# Grid of possible keepX values that will be tested for each comp
list.keepX <- c(1:10,  seq(20, 100, 10))
list.keepX
```

```
##  [1]   1   2   3   4   5   6   7   8   9  10  20  30  40  50  60  70  80  90 100
```

```
# This chunk takes ~ 2 min to run
# Some convergence issues may arise but it is ok as this is run on CV folds
tune.splsda.srbct <- tune.splsda(X, Y, ncomp = 4, validation = 'Mfold',
                                 folds = 5, dist = 'max.dist',
                                 test.keepX = list.keepX, nrepeat = 10)
```

The following command line will output the mean error rate for each component and each tested `keepX` value given the past (tuned) components.

```
# Just a head of the classification error rate per keepX (in rows) and comp
head(tune.splsda.srbct$error.rate)
```

```
##       comp1     comp2      comp3       comp4
## 1 0.6124094 0.3239040 0.05635870 0.006684783
## 2 0.5737953 0.3101812 0.03772645 0.010018116
## 3 0.5598370 0.2957609 0.03105978 0.008931159
## 4 0.5438315 0.2912228 0.02714674 0.011105072
## 5 0.5389946 0.2887228 0.02698370 0.011105072
## 6 0.5337409 0.2837228 0.02573370 0.011105072
```

When we examine each individual row, this output globally shows that the classification error rate continues to decrease after the third component in sparse PLS-DA.

We display the mean classification error rate on each component, bearing in mind that each component is conditional on the previous components calculated with the optimal number of selected variables. The diamond in Figure [31](#fig:05-splsda-tuning-plot) indicates the best `keepX` value to achieve the lowest error rate per component.

```
# To show the error bars across the repeats:
plot(tune.splsda.srbct, sd = TRUE)
```

![Tuning keepX for the sPLS-DA performed on the SRBCT gene expression data. Each coloured line represents the balanced error rate (y-axis) per component across all tested keepX values (x-axis) with the standard deviation based on the repeated cross-validation folds. The diamond indicates the optimal keepX value on a particular component which achieves the lowest classification error rate as determined with a one-sided \(t-\)test. As sPLS-DA is an iterative algorithm, values represented for a given component (e.g. comp 1 to 2) include the optimal keepX value chosen for the previous component (comp 1).](data:image/png;base64...)

Figure 31: **Tuning `keepX` for the sPLS-DA performed on the `SRBCT` gene expression data.** Each coloured line represents the balanced error rate (y-axis) per component across all tested `keepX` values (x-axis) with the standard deviation based on the repeated cross-validation folds. The diamond indicates the optimal `keepX` value on a particular component which achieves the lowest classification error rate as determined with a one-sided \(t-\)test. As sPLS-DA is an iterative algorithm, values represented for a given component (e.g. comp 1 to 2) include the optimal `keepX` value chosen for the previous component (comp 1).

The tuning results depend on the tuning grid `list.keepX`, as well as the values chosen for `folds` and `nrepeat`. Therefore, we recommend assessing the performance of the *final* model, as well as examining the stability of the selected variables across the different folds, as detailed in the next section.

Figure [31](#fig:05-splsda-tuning-plot) shows that the error rate decreases when more components are included in sPLS-DA. To obtain a more reliable estimation of the error rate, the number of repeats should be increased (between 50 to 100). This type of graph helps not only to choose the ‘optimal’ number of variables to select, but also to confirm the number of components `ncomp`. From the code below, we can assess that in fact, the addition of a fourth component does not improve the classification (no statistically significant improvement according to a one-sided \(t-\)test), hence we can choose `ncomp = 3`.

```
# The optimal number of components according to our one-sided t-tests
tune.splsda.srbct$choice.ncomp$ncomp
```

```
## [1] 3
```

```
# The optimal keepX parameter according to minimal error rate
tune.splsda.srbct$choice.keepX
```

```
## comp1 comp2 comp3 comp4
##    60    20    90    50
```

### 5.3.2 Final model and performance

Here is our final sPLS-DA model with three components and the optimal `keepX` obtained from our tuning step.

You can choose to skip the tuning step, and input your arbitrarily chosen parameters in the following code (simply specify your own `ncomp` and `keepX` values):

```
# Optimal number of components based on t-tests on the error rate
ncomp <- tune.splsda.srbct$choice.ncomp$ncomp
ncomp
```

```
## [1] 3
```

```
# Optimal number of variables to select
select.keepX <- tune.splsda.srbct$choice.keepX[1:ncomp]
select.keepX
```

```
## comp1 comp2 comp3
##    60    20    90
```

```
splsda.srbct <- splsda(X, Y, ncomp = ncomp, keepX = select.keepX)
```

The performance of the model with the `ncomp` and `keepX` parameters is assessed with the `perf()` function. We use 5-fold validation (`folds = 5`), repeated 10 times (`nrepeat = 10`) for illustrative purposes, but we recommend increasing to `nrepeat = 50`. Here we choose the `max.dist` prediction distance, based on our results obtained with PLS-DA.

The classification error rates that are output include both the overall error rate, as well as the balanced error rate (BER) when the number of samples per group is not balanced - as is the case in this study.

```
set.seed(34)  # For reproducibility with this handbook, remove otherwise

perf.splsda.srbct <- perf(splsda.srbct, folds = 5, validation = "Mfold",
                  dist = "max.dist", progressBar = FALSE, nrepeat = 10)

# perf.splsda.srbct  # Lists the different outputs
perf.splsda.srbct$error.rate
```

```
## $overall
##          max.dist
## comp1 0.423809524
## comp2 0.198412698
## comp3 0.007936508
##
## $BER
##          max.dist
## comp1 0.517961957
## comp2 0.271250000
## comp3 0.005434783
```

We can also examine the error rate per class:

```
perf.splsda.srbct$error.rate.class
```

```
## $max.dist
##           comp1 comp2      comp3
## EWS 0.004347826 0.000 0.02173913
## BL  0.562500000 0.450 0.00000000
## NB  1.000000000 0.475 0.00000000
## RMS 0.505000000 0.160 0.00000000
```

These results can be compared with the performance of PLS-DA and show the benefits of variable selection to not only obtain a parsimonious model, but also to improve the classification error rate (overall and per class).

### 5.3.3 Variable selection and stability {#05:stab}

During the repeated cross-validation process in `perf()` we can record how often the same variables are selected across the folds. This information is important to answer the question: *How reproducible is my gene signature when the training set is perturbed via cross-validation?*.

```
par(mfrow=c(1,2))
# For component 1
stable.comp1 <- perf.splsda.srbct$features$stable$comp1
barplot(stable.comp1, xlab = 'variables selected across CV folds',
        ylab = 'Stability frequency',
        main = 'Feature stability for comp = 1')

# For component 2
stable.comp2 <- perf.splsda.srbct$features$stable$comp2
barplot(stable.comp2, xlab = 'variables selected across CV folds',
        ylab = 'Stability frequency',
        main = 'Feature stability for comp = 2')
par(mfrow=c(1,1))
```

![Stability of variable selection from the sPLS-DA on the SRBCT gene expression data. We use a by-product from perf() to assess how often the same variables are selected for a given keepX value in the final sPLS-DA model. The barplot represents the frequency of selection across repeated CV folds for each selected gene for component 1 and 2. The genes are ranked according to decreasing frequency.](data:image/png;base64...)

Figure 32: **Stability of variable selection from the sPLS-DA on the SRBCT gene expression data.** We use a by-product from `perf()` to assess how often the same variables are selected for a given `keepX` value in the final sPLS-DA model. The barplot represents the frequency of selection across repeated CV folds for each selected gene for component 1 and 2. The genes are ranked according to decreasing frequency.

Figure [32](#fig:05-splsda-stab) shows that the genes selected on component 1 are moderately stable (frequency < 0.5) whereas those selected on component 2 are more stable (frequency < 0.7). This can be explained as there are various combinations of genes that are discriminative on component 1, whereas the number of combinations decreases as we move to component 2 which attempts to refine the classification.

The function `selectVar()` outputs the variables selected for a given component and their loading values (ranked in decreasing absolute value). We concatenate those results with the feature stability, as shown here for variables selected on component 1:

```
# First extract the name of selected var:
select.name <- selectVar(splsda.srbct, comp = 1)$name

# Then extract the stability values from perf:
stability <- perf.splsda.srbct$features$stable$comp1[select.name]

# Just the head of the stability of the selected var:
head(cbind(selectVar(splsda.srbct, comp = 1)$value, stability))
```

```
##       value.var  Var1 Freq
## g123  0.2780186  g123  0.5
## g846  0.2474806  g846  0.5
## g758  0.2260973  g758  0.5
## g1606 0.2222979 g1606  0.5
## g836  0.2221555  g836  0.5
## g335  0.2201126  g335  0.5
```

As we hinted previously, the genes selected on the first component are not necessarily the most stable, suggesting that different combinations can lead to the same discriminative ability of the model. The stability increases in the following components, as the classification task becomes more refined.

Note:

* *You can also apply the `vip()` function on `splsda.srbct`.*

### 5.3.4 Sample visualisation

Previously, we showed the ellipse plots displayed for each class. Here we also use the star argument (`star = TRUE`), which displays arrows starting from each group centroid towards each individual sample (Figure [33](#fig:05-splsda-sample-plots)).

```
plotIndiv(splsda.srbct, comp = c(1,2),
          ind.names = FALSE,
          ellipse = TRUE, legend = TRUE,
          star = TRUE,
          title = 'SRBCT, sPLS-DA comp 1 - 2')
```

```
plotIndiv(splsda.srbct, comp = c(2,3),
          ind.names = FALSE,
          ellipse = TRUE, legend = TRUE,
          star = TRUE,
          title = 'SRBCT, sPLS-DA comp 2 - 3')
```

![Sample plots from the sPLS-DA performed on the SRBCT gene expression data. Samples are projected into the space spanned by the first three components. The plots represent 95% ellipse confidence intervals around each sample class. The start of each arrow represents the centroid of each class in the space spanned by the components. (a) Components 1 and 2 and (b) Components 2 and 3. Samples are coloured by their tumour subtype. Component 1 discriminates BL vs. the rest, component 2 discriminates EWS vs. the rest, while component 3 further discriminates NB vs. RMS vs. the rest. The combination of all three components enables us to discriminate all classes.](data:image/png;base64...)![Sample plots from the sPLS-DA performed on the SRBCT gene expression data. Samples are projected into the space spanned by the first three components. The plots represent 95% ellipse confidence intervals around each sample class. The start of each arrow represents the centroid of each class in the space spanned by the components. (a) Components 1 and 2 and (b) Components 2 and 3. Samples are coloured by their tumour subtype. Component 1 discriminates BL vs. the rest, component 2 discriminates EWS vs. the rest, while component 3 further discriminates NB vs. RMS vs. the rest. The combination of all three components enables us to discriminate all classes.](data:image/png;base64...)

Figure 33: **Sample plots from the sPLS-DA performed on the `SRBCT` gene expression data**. Samples are projected into the space spanned by the first three components. The plots represent 95% ellipse confidence intervals around each sample class. The start of each arrow represents the centroid of each class in the space spanned by the components. (a) Components 1 and 2 and (b) Components 2 and 3. Samples are coloured by their tumour subtype. Component 1 discriminates BL vs. the rest, component 2 discriminates EWS vs. the rest, while component 3 further discriminates NB vs. RMS vs. the rest. The combination of all three components enables us to discriminate all classes.

The sample plots are different from PLS-DA (Figure [29](#fig:05-plsda-sample-plots)) with an overlap of specific classes (i.e. NB + RMS on component 1 and 2), that are then further separated on component 3, thus showing how the genes selected on each component discriminate particular sets of sample groups.

### 5.3.5 Variable visualisation {#05:varplot}

We represent the genes selected with sPLS-DA on the correlation circle plot. Here to increase interpretation, we specify the argument `var.names` as the first 10 characters of the gene names (Figure [34](#fig:05-splsda-variable-plot)). We also reduce the size of the font with the argument `cex`.

Note:

* *We can store the `plotvar()` as an object to output the coordinates and variable names if the plot is too cluttered.*

```
var.name.short <- substr(srbct$gene.name[, 2], 1, 10)
plotVar(splsda.srbct, comp = c(1,2),
        var.names = list(var.name.short), cex = 3)
```

![Correlation circle plot representing the genes selected by sPLS-DA performed on the SRBCT gene expression data. Gene names are truncated to the first 10 characters. Only the genes selected by sPLS-DA are shown in components 1 and 2. We observe three groups of genes (positively associated with component 1, and positively or negatively associated with component 2). This graphic should be interpreted in conjunction with the sample plot.](data:image/png;base64...)

Figure 34: **Correlation circle plot representing the genes selected by sPLS-DA performed on the `SRBCT` gene expression data**. Gene names are truncated to the first 10 characters. Only the genes selected by sPLS-DA are shown in components 1 and 2. We observe three groups of genes (positively associated with component 1, and positively or negatively associated with component 2). This graphic should be interpreted in conjunction with the sample plot.

By considering both the correlation circle plot (Figure [34](#fig:05-splsda-variable-plot)) and the sample plot in Figure [33](#fig:05-splsda-sample-plots), we observe that a group of genes with a positive correlation with component 1 (‘EH domain’, ‘proteasome’ etc.) are associated with the BL samples. We also observe two groups of genes either positively or negatively correlated with component 2. These genes are likely to characterise either the NB + RMS classes, or the EWS class. This interpretation can be further examined with the `plotLoadings()` function.

In this plot, the loading weights of each selected variable on each component are represented (see Module 2). The colours indicate the group in which the expression of the selected gene is maximal based on the mean (`method = 'median'` is also available for skewed data). For example on component 1:

```
plotLoadings(splsda.srbct, comp = 1, method = 'mean', contrib = 'max',
             name.var = var.name.short)
```

![Loading plot of the genes selected by sPLS-DA on component 1 on the SRBCT gene expression data. Genes are ranked according to their loading weight (most important at the bottom to least important at the top), represented as a barplot. Colours indicate the class for which a particular gene is maximally expressed, on average, in this particular class. The plot helps to further characterise the gene signature and should be interpreted jointly with the sample plot (Figure 33).](data:image/png;base64...)

Figure 35: **Loading plot of the genes selected by sPLS-DA on component 1 on the `SRBCT` gene expression data**. Genes are ranked according to their loading weight (most important at the bottom to least important at the top), represented as a barplot. Colours indicate the class for which a particular gene is maximally expressed, on average, in this particular class. The plot helps to further characterise the gene signature and should be interpreted jointly with the sample plot (Figure [33](#fig:05-splsda-sample-plots)).

Here all genes are associated with BL (on average, their expression levels are higher in this class than in the other classes).

Notes:

* *Consider using the argument `ndisplay` to only display the top selected genes if the signature is too large.*
* *Consider using the argument `contrib = 'min'` to interpret the inverse trend of the signature (i.e. which genes have the smallest expression in which class, here a mix of NB and RMS samples).*

To complete the visualisation, the CIM in this special case is a simple hierarchical heatmap (see `?cim`) representing the expression levels of the genes selected across all three components with respect to each sample. Here we use an Euclidean distance with Complete agglomeration method, and we specify the argument `row.sideColors` to colour the samples according to their tumour type (Figure [36](#fig:05-splsda-cim)).

```
cim(splsda.srbct, row.sideColors = color.mixo(Y))
```

![Clustered Image Map of the genes selected by sPLS-DA on the SRBCT gene expression data across all 3 components. A hierarchical clustering based on the gene expression levels of the selected genes, with samples in rows coloured according to their tumour subtype (using Euclidean distance with Complete agglomeration method). As expected, we observe a separation of all different tumour types, which are characterised by different levels of expression.](data:image/png;base64...)

Figure 36: **Clustered Image Map of the genes selected by sPLS-DA on the `SRBCT` gene expression data across all 3 components**. A hierarchical clustering based on the gene expression levels of the selected genes, with samples in rows coloured according to their tumour subtype (using Euclidean distance with Complete agglomeration method). As expected, we observe a separation of all different tumour types, which are characterised by different levels of expression.

The heatmap shows the level of expression of the genes selected by sPLS-DA across all three components, and the overall ability of the gene signature to discriminate the tumour subtypes.

Note:

* *You can change the argument `comp` if you wish to visualise a specific set of components in `cim()`.*

## 5.4 Take a detour: prediction {#05:splsda-predict}

In this section, we artificially create an ‘external’ test set on which we want to predict the class membership to illustrate the prediction process in sPLS-DA (see Extra Reading material). We randomly select 50 samples from the `srbct` study as part of the training set, and the remainder as part of the test set:

```
set.seed(33) # For reproducibility with this handbook, remove otherwise
train <- sample(1:nrow(X), 50)    # Randomly select 50 samples in training
test <- setdiff(1:nrow(X), train) # Rest is part of the test set

# Store matrices into training and test set:
X.train <- X[train, ]
X.test <- X[test,]
Y.train <- Y[train]
Y.test <- Y[test]

# Check dimensions are OK:
dim(X.train); dim(X.test)
```

```
## [1]   50 2308
## [1]   13 2308
```

Here we assume that the tuning step was performed on the training set *only* (it is *really important* to tune only on the training step to avoid overfitting), and that the optimal `keepX` values are, for example, `keepX = c(20,30,40)` on three components. The final model on the training data is:

```
train.splsda.srbct <- splsda(X.train, Y.train, ncomp = 3, keepX = c(20,30,40))
```

We now apply the trained model on the test set `X.test` and we specify the prediction distance, for example `mahalanobis.dist` (see also `?predict.splsda`):

```
predict.splsda.srbct <- predict(train.splsda.srbct, X.test,
                                dist = "mahalanobis.dist")
```

The `$class` output of our object `predict.splsda.srbct` gives the predicted classes of the test samples.

First we concatenate the prediction for each of the three components (conditionally on the previous component) and the real class - in a real application case you may not know the true class.

```
# Just the head:
head(data.frame(predict.splsda.srbct$class, Truth = Y.test))
```

```
##         mahalanobis.dist.comp1 mahalanobis.dist.comp2 mahalanobis.dist.comp3
## EWS.T7                     EWS                    EWS                    EWS
## EWS.T15                    EWS                    EWS                    EWS
## EWS.C8                     EWS                    EWS                    EWS
## EWS.C10                    EWS                    EWS                    EWS
## BL.C8                       BL                     BL                     BL
## NB.C6                       NB                     NB                     NB
##         Truth
## EWS.T7    EWS
## EWS.T15   EWS
## EWS.C8    EWS
## EWS.C10   EWS
## BL.C8      BL
## NB.C6      NB
```

If we only look at the final prediction on component 2, compared to the real class:

```
# Compare prediction on the second component and change as factor
predict.comp2 <- predict.splsda.srbct$class$mahalanobis.dist[,2]
table(factor(predict.comp2, levels = levels(Y)), Y.test)
```

```
##      Y.test
##       EWS BL NB RMS
##   EWS   4  0  0   0
##   BL    0  1  0   0
##   NB    0  0  1   1
##   RMS   0  0  0   6
```

And on the third compnent:

```
# Compare prediction on the third component and change as factor
predict.comp3 <- predict.splsda.srbct$class$mahalanobis.dist[,3]
table(factor(predict.comp3, levels = levels(Y)), Y.test)
```

```
##      Y.test
##       EWS BL NB RMS
##   EWS   4  0  0   0
##   BL    0  1  0   0
##   NB    0  0  1   0
##   RMS   0  0  0   7
```

The prediction is better on the third component, compared to a 2-component model.

Next, we look at the output `$predict`, which gives the predicted dummy scores assigned for each test sample and each class level for a given component (as explained in Extra Reading material). Each column represents a class category:

```
# On component 3, just the head:
head(predict.splsda.srbct$predict[, , 3])
```

```
##                EWS          BL          NB          RMS
## EWS.T7  1.26848551 -0.05273773 -0.24070902  0.024961232
## EWS.T15 1.15058424 -0.02222145 -0.11877994 -0.009582845
## EWS.C8  1.25628411  0.05481026 -0.16500118 -0.146093198
## EWS.C10 0.83995956  0.10871106  0.16452934 -0.113199949
## BL.C8   0.02431262  0.90877176  0.01775304  0.049162580
## NB.C6   0.06738230  0.05086884  0.86247360  0.019275265
```

In PLS-DA and sPLS-DA, the final prediction call is given based on this matrix on which a pre-specified distance (such as `mahalanobis.dist` here) is applied. From this output, we can understand the link between the dummy matrix \(\boldsymbol Y\), the prediction, and the importance of choosing the prediction distance. More details are provided in Extra Reading material.

## 5.5 AUROC outputs complement performance evaluation {#05:splsda-auroc}

As PLS-DA acts as a classifier, we can plot the AUC (Area Under The Curve) ROC (Receiver Operating Characteristics) to complement the sPLS-DA classification performance results. The AUC is calculated from training cross-validation sets and averaged. The ROC curve is displayed in Figure [37](#fig:05-splsda-auroc). In a multiclass setting, each curve represents one class vs. the others and the AUC is indicated in the legend, and also in the numerical output:

```
auc.srbct <- auroc(splsda.srbct)
```

![ROC curve and AUC from sPLS-DA on the SRBCT gene expression data on component 1 averaged across one-vs.-all comparisons. Numerical outputs include the AUC and a Wilcoxon test p-value for each ‘one vs. other’ class comparisons that are performed per component. This output complements the sPLS-DA performance evaluation but should not be used for tuning (as the prediction process in sPLS-DA is based on prediction distances, not a cutoff that maximises specificity and sensitivity as in ROC). The plot suggests that the sPLS-DA model can distinguish BL subjects from the other groups with a high true positive and low false positive rate, while the model is less well able to distinguish samples from other classes on component 1.](data:image/png;base64...)

Figure 37: **ROC curve and AUC from sPLS-DA on the `SRBCT` gene expression data on component 1** averaged across one-vs.-all comparisons. Numerical outputs include the AUC and a Wilcoxon test p-value for each ‘one vs. other’ class comparisons that are performed per component. This output complements the sPLS-DA performance evaluation but *should not be used for tuning* (as the prediction process in sPLS-DA is based on prediction distances, not a cutoff that maximises specificity and sensitivity as in ROC). The plot suggests that the sPLS-DA model can distinguish BL subjects from the other groups with a high true positive and low false positive rate, while the model is less well able to distinguish samples from other classes on component 1.

```
## $Comp1
##                    AUC   p-value
## EWS vs Other(s) 0.5750 3.246e-01
## BL vs Other(s)  1.0000 5.586e-06
## NB vs Other(s)  0.4542 6.241e-01
## RMS vs Other(s) 0.7081 8.216e-03
##
## $Comp2
##                    AUC   p-value
## EWS vs Other(s) 1.0000 5.135e-11
## BL vs Other(s)  1.0000 5.586e-06
## NB vs Other(s)  0.8154 7.297e-04
## RMS vs Other(s) 0.8581 5.421e-06
##
## $Comp3
##                 AUC   p-value
## EWS vs Other(s)   1 5.135e-11
## BL vs Other(s)    1 5.586e-06
## NB vs Other(s)    1 8.505e-08
## RMS vs Other(s)   1 2.164e-10
```

The ideal ROC curve should be along the top left corner, indicating a high true positive rate (sensitivity on the y-axis) and a high true negative rate (or low 100 - specificity on the x-axis), with an AUC close to 1. This is the case for BL vs. the others on component 1. The numerical output shows a perfect classification on component 3.

*Note:*

* *A word of caution when using the ROC and AUC in s/PLS-DA: these criteria may not be particularly insightful, or may not be in full agreement with the s/PLS-DA performance, as the prediction threshold in PLS-DA is based on a specified distance as we described earlier in this section and in Extra Reading material related to PLS-DA. Thus, such a result complements the sPLS-DA performance we have calculated earlier.*

# 6 N-Integration {#06}

N-Integration is the framework of having multiple datasets which measure different aspects of the same samples. For example, you may have transcriptomic, genetic and proteomic data for the same set of cells. N-integrative methods are built to use the information in all three of these dataframes simultaenously.

DIABLO is a novel `mixOmics` framework for the integration of multiple data sets while explaining their relationship with a categorical outcome variable. DIABLO stands for **D**ata **I**ntegration **A**nalysis for **B**iomarker discovery using **L**atent variable approaches for **O**mics studies. It can also be referred to as Multiblock (s)PLS-DA.

## 6.1 Block sPLS-DA on the TCGA case study {#06:diablo}

Human breast cancer is a heterogeneous disease in terms of molecular alterations, cellular composition, and clinical outcome. Breast tumours can be classified into several subtypes, according to their levels of mRNA expression (Sørlie et al. [2001](#ref-Sor01)). Here we consider a subset of data generated by The Cancer Genome Atlas Network (Cancer Genome Atlas Network and others [2012](#ref-TCGA12)). For the package, data were normalised, and then drastically prefiltered for illustrative purposes.

The data were divided into a *training set* with a subset of 150 samples from the mRNA, miRNA and proteomics data, and a *test set* including 70 samples, but only with mRNA and miRNA data (the proteomics data are missing). The aim of this integrative analysis is to identify a highly correlated multi-omics signature discriminating the breast cancer subtypes Basal, Her2 and LumA.

The `breast.TCGA` (more details can be found in `?breast.TCGA`) is a list containing training and test sets of omics data `data.train` and `data.test` which include:

* `$miRNA`: A data frame with 150 (70) rows and 184 columns in the training (test) data set for the miRNA expression levels,
* `$mRNA`: A data frame with 150 (70) rows and 520 columns in the training (test) data set for the mRNA expression levels,
* `$protein`: A data frame with 150 rows and 142 columns in the training data set for the protein abundance (there are no proteomics in the test set),
* `$subtype`: A factor indicating the breast cancer subtypes in the training (for 150 samples) and test sets (for 70 samples).

This case study covers an interesting scenario where one omic data set is missing in the test set, but because the method generates a set of components per training data set, we can still assess the prediction or performance evaluation using majority or weighted prediction vote.

## 6.2 Load the data {#06:diablo-load-data}

To illustrate the multiblock sPLS-DA approach, we will integrate the expression levels of miRNA, mRNA and the abundance of proteins while discriminating the subtypes of breast cancer, then predict the subtypes of the samples in the test set.

The input data is first set up as a list of \(Q\) matrices \(\boldsymbol X\_1, \dots, \boldsymbol X\_Q\) and a factor indicating the class membership of each sample \(\boldsymbol Y\). Each data frame in \(\boldsymbol X\) *should be named* as we will match these names with the `keepX` parameter for the sparse method.

```
library(mixOmics)
data(breast.TCGA)

# Extract training data and name each data frame
# Store as list
X <- list(mRNA = breast.TCGA$data.train$mrna,
          miRNA = breast.TCGA$data.train$mirna,
          protein = breast.TCGA$data.train$protein)

# Outcome
Y <- breast.TCGA$data.train$subtype
summary(Y)
```

```
## Basal  Her2  LumA
##    45    30    75
```

## 6.3 Parameter choice {#06:diablo-params}

### 6.3.1 Design matrix {#06:diablo-design}

The choice of the design can be motivated by different aspects, including:

* Biological apriori knowledge: Should we expect `mRNA` and `miRNA` to be highly correlated?
* Analytical aims: As further developed in Singh et al. ([2019](#ref-Sin19)), a compromise needs to be achieved between a classification and prediction task, and extracting the correlation structure of the data sets. A full design with weights = 1 will favour the latter, but at the expense of classification accuracy, whereas a design with small weights will lead to a highly predictive signature. This pertains to the complexity of the analytical task involved as several constraints are included in the optimisation procedure. For example, here we choose a 0.1 weighted model as we are interested in predicting test samples later in this case study.

```
design <- matrix(0.1, ncol = length(X), nrow = length(X),
                dimnames = list(names(X), names(X)))
diag(design) <- 0
design
```

```
##         mRNA miRNA protein
## mRNA     0.0   0.1     0.1
## miRNA    0.1   0.0     0.1
## protein  0.1   0.1     0.0
```

Note however that even with this design, we will still unravel a correlated signature as we require all data sets to explain the same outcome \(\boldsymbol y\), as well as maximising pairs of covariances between data sets.

* Data-driven option: we could perform regression analyses with PLS to further understand the correlation between data sets. Here for example, we run PLS with one component and calculate the cross-correlations between components associated to each data set:

```
res1.pls.tcga <- pls(X$mRNA, X$protein, ncomp = 1)
cor(res1.pls.tcga$variates$X, res1.pls.tcga$variates$Y)

res2.pls.tcga <- pls(X$mRNA, X$miRNA, ncomp = 1)
cor(res2.pls.tcga$variates$X, res2.pls.tcga$variates$Y)

res3.pls.tcga <- pls(X$protein, X$miRNA, ncomp = 1)
cor(res3.pls.tcga$variates$X, res3.pls.tcga$variates$Y)
```

```
##           comp1
## comp1 0.9031761
##           comp1
## comp1 0.8456299
##           comp1
## comp1 0.7982008
```

The data sets taken in a pairwise manner are highly correlated, indicating that a design with weights \(\sim 0.8 - 0.9\) could be chosen.

### 6.3.2 Number of components {#06:diablo-ncomp}

As in the PLS-DA framework presented in Module 3, we first fit a `block.plsda` model without variable selection to assess the global performance of the model and choose the number of components. We run `perf()` with 10-fold cross validation repeated 10 times for up to 5 components and with our specified design matrix. Similar to PLS-DA, we obtain the performance of the model with respect to the different prediction distances (Figure [38](#fig:06-ncomp)):

```
diablo.tcga <- block.plsda(X, Y, ncomp = 5, design = design)

set.seed(123) # For reproducibility, remove for your analyses
perf.diablo.tcga = perf(diablo.tcga, validation = 'Mfold', folds = 10, nrepeat = 10)

#perf.diablo.tcga$error.rate  # Lists the different types of error rates

# Plot of the error rates based on weighted vote
plot(perf.diablo.tcga)
```

![Choosing the number of components in block.plsda using perf() with 10 x 10-fold CV function in the breast.TCGA study. Classification error rates (overall and balanced, see Module 2) are represented on the y-axis with respect to the number of components on the x-axis for each prediction distance presented in PLS-DA in Seciton 3.4 and detailed in Extra reading material 3 from Module 3. Bars show the standard deviation across the 10 repeated folds. The plot shows that the error rate reaches a minimum from 2 to 3 dimensions.](data:image/png;base64...)

Figure 38: **Choosing the number of components in `block.plsda` using `perf()` with 10 x 10-fold CV function in the `breast.TCGA` study**. Classification error rates (overall and balanced, see Module 2) are represented on the y-axis with respect to the number of components on the x-axis for each prediction distance presented in PLS-DA in Seciton 3.4 and detailed in Extra reading material 3 from Module 3. Bars show the standard deviation across the 10 repeated folds. The plot shows that the error rate reaches a minimum from 2 to 3 dimensions.

The performance plot indicates that two components should be sufficient in the final model, and that the centroids distance might lead to better prediction. A balanced error rate (BER) should be considered for further analysis.

The following outputs the optimal number of components according to the prediction distance and type of error rate (overall or balanced), as well as a prediction weighting scheme illustrated further below.

```
perf.diablo.tcga$choice.ncomp$WeightedVote
```

```
##             max.dist centroids.dist mahalanobis.dist
## Overall.ER         3              3                3
## Overall.BER        3              3                3
```

Thus, here we choose our final `ncomp` value:

```
ncomp <- perf.diablo.tcga$choice.ncomp$WeightedVote["Overall.BER", "centroids.dist"]
```

### 6.3.3 Number of variables to select {#06:diablo-tuning}

We then choose the optimal number of variables to select in each data set using the `tune.block.splsda` function. The function `tune()` is run with 10-fold cross validation, but repeated only once (`nrepeat = 1`) for illustrative and computational reasons here. For a thorough tuning process, we advise increasing the `nrepeat` argument to 10-50, or more.

We choose a `keepX` grid that is relatively fine at the start, then coarse. If the data sets are easy to classify, the tuning step may indicate the smallest number of variables to separate the sample groups. Hence, we start our grid at the value `5` to avoid a too small signature that may preclude biological interpretation.

```
# chunk takes about 2 min to run
set.seed(123) # for reproducibility
test.keepX <- list(mRNA = c(5:9, seq(10, 25, 5)),
                   miRNA = c(5:9, seq(10, 20, 2)),
                   proteomics = c(seq(5, 25, 5)))

tune.diablo.tcga <- tune.block.splsda(X, Y, ncomp = 2,
                              test.keepX = test.keepX, design = design,
                              validation = 'Mfold', folds = 10, nrepeat = 1,
                              BPPARAM = BiocParallel::SnowParam(workers = 2),
                              dist = "centroids.dist")

list.keepX <- tune.diablo.tcga$choice.keepX
```

Note:

* *For fast computation, we can use parallel computing here - this option is also enabled on a laptop or workstation, see `?tune.block.splsda`.*

The number of features to select on each component is returned and stored for the final model:

```
list.keepX
```

```
## $mRNA
## [1]  8 25
##
## $miRNA
## [1] 14  5
##
## $protein
## [1] 10  5
```

Note:

* *You can skip any of the tuning steps above, and hard code your chosen `ncomp` and `keepX` parameters (as a list for the latter, as shown below).*

```
list.keepX <- list( mRNA = c(8, 25), miRNA = c(14,5), protein = c(10, 5))
```

## 6.4 Final model {#06:diablo-final}

The final multiblock sPLS-DA model includes the tuned parameters and is run as:

```
diablo.tcga <- block.splsda(X, Y, ncomp = ncomp,
                            keepX = list.keepX, design = design)
```

```
## Design matrix has changed to include Y; each block will be
##             linked to Y.
```

```
#06.tcga   # Lists the different functions of interest related to that object
```

A warning message informs us that the outcome \(\boldsymbol Y\) has been included automatically in the design, so that the covariance between each block’s component and the outcome is maximised, as shown in the final design output:

```
diablo.tcga$design
```

```
##         mRNA miRNA protein Y
## mRNA     0.0   0.1     0.1 1
## miRNA    0.1   0.0     0.1 1
## protein  0.1   0.1     0.0 1
## Y        1.0   1.0     1.0 0
```

The selected variables can be extracted with the function `selectVar()`, for example in the mRNA block, along with their loading weights (not output here):

```
# mRNA variables selected on component 1
selectVar(diablo.tcga, block = 'mRNA', comp = 1)
```

*Note:*

* *The stability of the selected variables can be extracted from the `perf()` function, similar to the example given in the PLS-DA analysis (Module 3).*

## 6.5 Sample plots {#06:diablo-sample-plots}

### 6.5.1 `plotDiablo`

`plotDiablo()` is a diagnostic plot to check whether the correlations between components from each data set were maximised as specified in the design matrix. We specify the dimension to be assessed with the `ncomp` argument (Figure [39](#fig:06-diablo-plot)).

```
plotDiablo(diablo.tcga, ncomp = 1)
```

![Diagnostic plot from multiblock sPLS-DA applied on the breast.TCGA study. Samples are represented based on the specified component (here ncomp = 1) for each data set (mRNA, miRNA and protein). Samples are coloured by breast cancer subtype (Basal, Her2 and LumA) and 95% confidence ellipse plots are represented. The bottom left numbers indicate the correlation coefficients between the first components from each data set. In this example, mRNA expression and protein concentration are highly correlated on the first dimension.](data:image/png;base64...)

Figure 39: **Diagnostic plot from multiblock sPLS-DA applied on the `breast.TCGA` study.** Samples are represented based on the specified component (here `ncomp = 1`) for each data set (mRNA, miRNA and protein). Samples are coloured by breast cancer subtype (Basal, Her2 and LumA) and 95% confidence ellipse plots are represented. The bottom left numbers indicate the correlation coefficients between the first components from each data set. In this example, mRNA expression and protein concentration are highly correlated on the first dimension.

The plot indicates that the first components from all data sets are highly correlated. The colours and ellipses represent the sample subtypes and indicate the discriminative power of each component to separate the different tumour subtypes. Thus, multiblock sPLS-DA is able to extract a strong correlation structure between data sets, as well as discriminate the breast cancer subtypes on the first component.

### 6.5.2 `plotIndiv`

The sample plot with the `plotIndiv()` function projects each sample into the space spanned by the components from *each* block, resulting in a series of graphs corresponding to each data set (Figure [40](#fig:06-sample-plot)). The optional argument `blocks` can output a specific data set. Ellipse plots are also available (argument `ellipse = TRUE`).

```
plotIndiv(diablo.tcga, ind.names = FALSE, legend = TRUE,
          title = 'TCGA, DIABLO comp 1 - 2')
```

![Sample plot from multiblock sPLS-DA performed on the breast.TCGA study. The samples are plotted according to their scores on the first 2 components for each data set. Samples are coloured by cancer subtype and are classified into three classes: Basal, Her2 and LumA. The plot shows the degree of agreement between the different data sets and the discriminative ability of each data set.](data:image/png;base64...)

Figure 40: **Sample plot from multiblock sPLS-DA performed on the `breast.TCGA` study.** The samples are plotted according to their scores on the first 2 components for each data set. Samples are coloured by cancer subtype and are classified into three classes: Basal, Her2 and LumA. The plot shows the degree of agreement between the different data sets and the discriminative ability of each data set.

This type of graphic allows us to better understand the information extracted from each data set and its discriminative ability. Here we can see that the LumA group can be difficult to classify in the miRNA data.

Note:

* *Additional variants include the argument `block = 'average'` that averages the components from all blocks to produce a single plot. The argument `block='weighted.average'` is a weighted average of the components according to their correlation with the components associated with the outcome*.

### 6.5.3 `plotArrow`

In the arrow plot in Figure [41](#fig:06-arrow-plot), the start of the arrow indicates the centroid between all data sets for a given sample and the tip of the arrow the location of that same sample but in each block. Such graphics highlight the agreement between all data sets at the sample level when modelled with multiblock sPLS-DA.

```
plotArrow(diablo.tcga, ind.names = FALSE, legend = TRUE,
          title = 'TCGA, DIABLO comp 1 - 2')
```

![Arrow plot from multiblock sPLS-DA performed on the breast.TCGA study. The samples are projected into the space spanned by the first two components for each data set then overlaid across data sets. The start of the arrow indicates the centroid between all data sets for a given sample and the tip of the arrow the location of the same sample in each block. Arrows further from their centroid indicate some disagreement between the data sets. Samples are coloured by cancer subtype (Basal, Her2 and LumA).](data:image/png;base64...)

Figure 41: **Arrow plot from multiblock sPLS-DA performed on the `breast.TCGA` study.** The samples are projected into the space spanned by the first two components for each data set then overlaid across data sets. The start of the arrow indicates the centroid between all data sets for a given sample and the tip of the arrow the location of the same sample in each block. Arrows further from their centroid indicate some disagreement between the data sets. Samples are coloured by cancer subtype (Basal, Her2 and LumA).

This plot shows that globally, the discrimination of all breast cancer subtypes can be extracted from all data sets, however, there are some dissimilarities at the samples level across data sets (the common information cannot be extracted in the same way across data sets).

## 6.6 Variable plots {#06:diablo-variable-plots}

The visualisation of the selected variables is crucial to mine their associations in multiblock sPLS-DA. Here we revisit existing outputs presented in Module 2 with further developments for multiple data set integration. All the plots presented provide complementary information for interpreting the results.

### 6.6.1 `plotVar`

The correlation circle plot highlights the contribution of each selected variable to each component. Important variables should be close to the large circle (see Module 2). Here, only the variables selected on components 1 and 2 are depicted (across all blocks), see Figure [42](#fig:06-correlation-plot). Clusters of points indicate a strong correlation between variables. For better visibility we chose to hide the variable names.

```
plotVar(diablo.tcga, var.names = FALSE, style = 'graphics', legend = TRUE,
        pch = c(16, 17, 15), cex = c(2,2,2),
        col = c('darkorchid', 'brown1', 'lightgreen'),
        title = 'TCGA, DIABLO comp 1 - 2')
```

![Correlation circle plot from multiblock sPLS-DA performed on the breast.TCGA study. The variable coordinates are defined according to their correlation with the first and second components for each data set. Variable types are indicated with different symbols and colours, and are overlaid on the same plot. The plot highlights the potential associations within and between different variable types when they are important in defining their own component.](data:image/png;base64...)

Figure 42: **Correlation circle plot from multiblock sPLS-DA performed on the `breast.TCGA` study.** The variable coordinates are defined according to their correlation with the first and second components for each data set. Variable types are indicated with different symbols and colours, and are overlaid on the same plot. The plot highlights the potential associations within and between different variable types when they are important in defining their own component.

The correlation circle plot shows some positive correlations (between selected miRNA and proteins, between selected proteins and mRNA) and negative correlations between mRNAand miRNA on component 1. The correlation structure is less obvious on component 2, but we observe some key selected features (proteins and miRNA) that seem to highly contribute to component 2.

Note:

* *These results can be further investigated by showing the variable names on this plot (or extracting their coordinates available from the plot saved into an object, see `?plotVar`), and looking at various outputs from `selectVar()` and `plotLoadings()`.*
* *You can choose to only show specific variable type names, e.g. `var.names = c(FALSE, FALSE, TRUE)` (where each argument is assigned to a data set in \(\boldsymbol X\)). Here for example, the protein names only would be output.*

### 6.6.2 `circosPlot`

The circos plot represents the correlations between variables of different types, represented on the side quadrants. Several display options are possible, to show within and between connections between blocks, and expression levels of each variable according to each class (argument `line = TRUE`). The circos plot is built based on a similarity matrix, which was extended to the case of multiple data sets from González et al. ([2012](#ref-Gon12)) (see also Module 2 and Extra Reading material from that module). A `cutoff` argument can be further included to visualise correlation coefficients above this threshold in the multi-omics signature (Figure [43](#fig:06-circos-plot)). The colours for the blocks and correlation lines can be chosen with `color.blocks` and `color.cor` respectively:

```
circosPlot(diablo.tcga, cutoff = 0.7, line = TRUE,
           color.blocks = c('darkorchid', 'brown1', 'lightgreen'),
           color.cor = c("chocolate3","grey20"), size.labels = 1.5)
```

![Circos plot from multiblock sPLS-DA performed on the breast.TCGA study. The plot represents the correlations greater than 0.7 between variables of different types, represented on the side quadrants. The internal connecting lines show the positive (negative) correlations. The outer lines show the expression levels of each variable in each sample group (Basal, Her2 and LumA).](data:image/png;base64...)

Figure 43: **Circos plot from multiblock sPLS-DA performed on the `breast.TCGA` study.** The plot represents the correlations greater than 0.7 between variables of different types, represented on the side quadrants. The internal connecting lines show the positive (negative) correlations. The outer lines show the expression levels of each variable in each sample group (Basal, Her2 and LumA).

The circos plot enables us to visualise cross-correlations between data types, and the nature of these correlations (positive or negative). Here we observe that correlations > 0.7 are between a few mRNAand some Proteins, whereas the majority of strong (negative) correlations are observed between miRNA and mRNAor Proteins. The lines indicating the average expression levels per breast cancer subtype indicate that the selected features are able to discriminate the sample groups.

### 6.6.3 `network`

Relevance networks, which are also built on the similarity matrix, can also visualise the correlations between the different types of variables. Each colour represents a type of variable. A threshold can also be set using the argument `cutoff` (Figure [44](#fig:06-network)). By default the network includes only variables selected on component 1, unless specified in `comp`.

Note that sometimes the output may not show with Rstudio due to margin issues. We can either use `X11()` to open a new window, or save the plot as an image using the arguments `save` and `name.save`, as we show below. An `interactive` argument is also available for the `cutoff` argument, see details in `?network`.

```
# X11()   # Opens a new window
network(diablo.tcga, blocks = c(1,2,3),
        cutoff = 0.4,
        color.node = c('darkorchid', 'brown1', 'lightgreen'),
        # To save the plot, uncomment below line
        #save = 'png', name.save = 'diablo-network'
        )
```

![Relevance network for the variables selected by multiblock sPLS-DA performed on the breast.TCGA study on component 1. Each node represents a selected variable with colours indicating their type. The colour of the edges represent positive or negative correlations. Further tweaking of this plot can be obtained, see the help file ?network.](data:image/png;base64...)

Figure 44: **Relevance network for the variables selected by multiblock sPLS-DA performed on the `breast.TCGA` study on component 1.** Each node represents a selected variable with colours indicating their type. The colour of the edges represent positive or negative correlations. Further tweaking of this plot can be obtained, see the help file `?network`.

The relevance network in Figure [44](#fig:06-network) shows two groups of features of different types. Within each group we observe positive and negative correlations. The visualisation of this plot could be further improved by changing the names of the original features.

Note that the network can be saved in a .gml format to be input into the software Cytoscape, using the R package `igraph` (Csardi, Nepusz, and others [2006](#ref-csa06)):

```
# Not run
library(igraph)
myNetwork <- network(diablo.tcga, blocks = c(1,2,3), cutoff = 0.4)
write.graph(myNetwork$gR, file = "myNetwork.gml", format = "gml")
```

### 6.6.4 `plotLoadings`

`plotLoadings()` visualises the loading weights of each selected variable on each component and each data set. The colour indicates the class in which the variable has the maximum level of expression (`contrib = 'max'`) or minimum (`contrib = 'min'`), on average (`method = 'mean'`) or using the median (`method = 'median'`).

```
plotLoadings(diablo.tcga, comp = 1, contrib = 'max', method = 'median')
```

![Loading plot for the variables selected by multiblock sPLS-DA performed on the breast.TCGA study on component 1. The most important variables (according to the absolute value of their coefficients) are ordered from bottom to top. As this is a supervised analysis, colours indicate the class for which the median expression value is the highest for each feature (variables selected characterise Basal and LumA).](data:image/png;base64...)

Figure 45: **Loading plot for the variables selected by multiblock sPLS-DA performed on the `breast.TCGA` study on component 1.** The most important variables (according to the absolute value of their coefficients) are ordered from bottom to top. As this is a supervised analysis, colours indicate the class for which the median expression value is the highest for each feature (variables selected characterise Basal and LumA).

The loading plot shows the multi-omics signature selected on component 1, where each panel represents one data type. The importance of each variable is visualised by the length of the bar (i.e. its loading coefficient value). The combination of the sign of the coefficient (positive / negative) and the colours indicate that component 1 discriminates primarily the Basal samples vs. the LumA samples (see the sample plots also). The features selected are highly expressed in one of these two subtypes. One could also plot the second component that discriminates the Her2 samples.

### 6.6.5 `cimDiablo`

The `cimDiablo()` function is a clustered image map specifically implemented to represent the multi-omics molecular signature expression for each sample. It is very similar to a classical hierarchical clustering (Figure [46](#fig:06-cim)).

```
cimDiablo(diablo.tcga, color.blocks = c('darkorchid', 'brown1', 'lightgreen'),
          comp = 1, margin=c(8,20), legend.position = "right")
```

```
##
## trimming values to [-3, 3] range for cim visualisation. See 'trim' arg in ?cimDiablo
```

![Clustered Image Map for the variables selected by multiblock sPLS-DA performed on the breast.TCGA study on component 1. By default, Euclidean distance and Complete linkage methods are used. The CIM represents samples in rows (indicated by their breast cancer subtype on the left hand side of the plot) and selected features in columns (indicated by their data type at the top of the plot).](data:image/png;base64...)

Figure 46: **Clustered Image Map for the variables selected by multiblock sPLS-DA performed on the `breast.TCGA` study on component 1.** By default, Euclidean distance and Complete linkage methods are used. The CIM represents samples in rows (indicated by their breast cancer subtype on the left hand side of the plot) and selected features in columns (indicated by their data type at the top of the plot).

According to the CIM, component 1 seems to primarily classify the Basal samples, with a group of overexpressed miRNA and underexpressed mRNAand proteins. A group of LumA samples can also be identified due to the overexpression of the same mRNAand proteins. Her2 samples remain quite mixed with the other LumA samples.

## 6.7 Model performance and prediction {#06:diablo-perf}

We assess the performance of the model using 10-fold cross-validation repeated 10 times with the function `perf()`. The method runs a `block.splsda()` model on the pre-specified arguments input from our final object `diablo.tcga` but on cross-validated samples. We then assess the accuracy of the prediction on the left out samples. Since the `tune()` function was used with the `centroid.dist` argument, we examine the outputs of the `perf()` function for that same distance:

```
set.seed(123) # For reproducibility with this handbook, remove otherwise
perf.diablo.tcga <- perf(diablo.tcga,  validation = 'Mfold', folds = 10,
                         nrepeat = 10, dist = 'centroids.dist')

#perf.diablo.tcga  # Lists the different outputs
```

We can extract the (balanced) classification error rates globally or overall with
`perf.diablo.tcga$error.rate.per.class`, the predicted components associated to \(\boldsymbol Y\), or the stability of the selected features with `perf.diablo.tcga$features`.

Here we look at the different performance assessment schemes specific to multiple data set integration.

First, we output the performance with the majority vote, that is, since the prediction is based on the components associated to their own data set, we can then weight those predictions across data sets according to a majority vote scheme. Based on the predicted classes, we then extract the classification error rate per class and per component:

```
# Performance with Majority vote
perf.diablo.tcga$MajorityVote.error.rate
```

```
## $centroids.dist
##                  comp1      comp2      comp3
## Basal       0.03333333 0.04666667 0.08444444
## Her2        0.23333333 0.15000000 0.16666667
## LumA        0.04533333 0.01066667 0.07466667
## Overall.ER  0.07933333 0.04933333 0.09600000
## Overall.BER 0.10400000 0.06911111 0.10859259
```

The output shows that with the exception of the Basal samples, the classification improves with the addition of the second component.

Another prediction scheme is to weight the classification error rate from each data set according to the correlation between the predicted components and the \(\boldsymbol Y\) outcome.

```
# Performance with Weighted vote
perf.diablo.tcga$WeightedVote.error.rate
```

```
## $centroids.dist
##                  comp1      comp2      comp3
## Basal       0.01111111 0.04444444 0.08000000
## Her2        0.16666667 0.12333333 0.11666667
## LumA        0.04533333 0.01066667 0.07466667
## Overall.ER  0.05933333 0.04333333 0.08466667
## Overall.BER 0.07437037 0.05948148 0.09044444
```

Compared to the previous majority vote output, we can see that the classification accuracy is slightly better on component 2 for the subtype Her2.

An AUC plot *per block* is plotted using the function `auroc()`. We have already mentioned in Module 3 for PLS-DA, the interpretation of this output may not be particularly insightful in relation to the performance evaluation of our methods, but can complement the statistical analysis. For example, here for the miRNA data set once we have reached component 2 (Figure [47](#fig:06-auroc)):

```
auc.diablo.tcga <- auroc(diablo.tcga, roc.block = "miRNA", roc.comp = 2,
                   print = FALSE)
```

![ROC and AUC based on multiblock sPLS-DA performed on the breast.TCGA study for the miRNA data set after 2 components. The function calculates the ROC curve and AUC for one class vs. the others. If we set print = TRUE, the Wilcoxon test p-value that assesses the differences between the predicted components from one class vs. the others is output.](data:image/png;base64...)

Figure 47: **ROC and AUC based on multiblock sPLS-DA performed on the `breast.TCGA` study for the miRNA data set after 2 components.** The function calculates the ROC curve and AUC for one class vs. the others. If we set `print = TRUE`, the Wilcoxon test p-value that assesses the differences between the predicted components from one class vs. the others is output.

Figure [47](#fig:06-auroc) shows that the Her2 subtype is the most difficult to classify with multiblock sPLS-DA compared to the other subtypes.

The `predict()` function associated with a `block.splsda()` object predicts the class of samples from an external test set. In our specific case, one data set is missing in the test set but the method can still be applied. We need to ensure the names of the blocks correspond exactly to those from the training set:

```
# Prepare test set data: here one block (proteins) is missing
data.test.tcga <- list(mRNA = breast.TCGA$data.test$mrna,
                      miRNA = breast.TCGA$data.test$mirna)

predict.diablo.tcga <- predict(diablo.tcga, newdata = data.test.tcga)
# The warning message will inform us that one block is missing

#predict.diablo # List the different outputs
```

The following output is a confusion matrix that compares the real subtypes with the predicted subtypes for a 2 component model, for the distance of interest `centroids.dist` and the prediction scheme `WeightedVote`:

```
confusion.mat.tcga <- get.confusion_matrix(truth = breast.TCGA$data.test$subtype,
                     predicted = predict.diablo.tcga$WeightedVote$centroids.dist[,2])
confusion.mat.tcga
```

```
##       predicted.as.Basal predicted.as.Her2 predicted.as.LumA
## Basal                 20                 1                 0
## Her2                   0                13                 1
## LumA                   0                 3                32
```

From this table, we see that one Basal and one Her2 sample are wrongly predicted as Her2 and Lum A respectively, and 3 LumA samples are wrongly predicted as Her2. The balanced prediction error rate can be obtained as:

```
get.BER(confusion.mat.tcga)
```

```
## [1] 0.06825397
```

It would be worthwhile at this stage to revisit the chosen design of the multiblock sPLS-DA model to assess the influence of the design on the prediction performance on this test set - even though this back and forth analysis is a biased criterion to choose the design!

# 7 P-Integration {#07}

## 7.1 MINT on the stem cell case study {#07:mint}

We integrate four transcriptomics studies of microarray stem cells (125 samples in total). The original data set from the Stemformatics database111 www.stemformatics.org (Wells et al. [2013](#ref-Well13)) was reduced to fit into the package, and includes a randomly-chosen subset of the expression levels of 400 genes. The aim is to classify three types of human cells: human fibroblasts (Fib) and human induced Pluripotent Stem Cells (hiPSC & hESC).

There is a biological hierarchy among the three cell types. On one hand, differences between pluripotent (hiPSC and hESC) and non-pluripotent cells (Fib) are well-characterised and are expected to contribute to the main biological variation. On the other hand, hiPSC are genetically reprogrammed to behave like hESC and both cell types are commonly assumed to be alike. However, differences have been reported in the literature (Chin et al. ([2009](#ref-Chi09)), Newman and Cooper ([2010](#ref-New10))). We illustrate the use of MINT to address sub-classification problems in a single analysis.

## 7.2 Load the data {#07:load-data}

We first load the data from the package and set up the categorical outcome \(\boldsymbol Y\) and the `study` membership:

```
library(mixOmics)
data(stemcells)

# The combined data set X
X <- stemcells$gene
dim(X)
```

```
## [1] 125 400
```

```
# The outcome vector Y:
Y <- stemcells$celltype
length(Y)
```

```
## [1] 125
```

```
summary(Y)
```

```
## Fibroblast       hESC      hiPSC
##         30         37         58
```

We then store the vector indicating the sample membership of each independent study:

```
study <- stemcells$study

# Number of samples per study:
summary(study)
```

```
##  1  2  3  4
## 38 51 21 15
```

```
# Experimental design
table(Y,study)
```

```
##             study
## Y             1  2  3  4
##   Fibroblast  6 18  3  3
##   hESC       20  3  8  6
##   hiPSC      12 30 10  6
```

## 7.3 Example: MINT PLS-DA {#07:plsda}

We first perform a MINT PLS-DA with all variables included in the model and `ncomp = 5` components. The `perf()` function is used to estimate the performance of the model using LOGOCV, and to choose the optimal number of components for our final model (see Fig [48](#fig:07-plsda-perf)).

```
mint.plsda.stem <- mint.plsda(X = X, Y = Y, study = study, ncomp = 5)

set.seed(2543) # For reproducible results here, remove for your own analyses
perf.mint.plsda.stem <- perf(mint.plsda.stem)

plot(perf.mint.plsda.stem)
```

![Choosing the number of components in mint.plsda using perf() with LOGOCV in the stemcells study. Classification error rates (overall and balanced, see Module 2) are represented on the y-axis with respect to the number of components on the x-axis for each prediction distance (see Module 3 and Extra Reading material ‘PLS-DA appendix’). The plot shows that the error rate reaches a minimum from 1 component with the BER and centroids distance.](data:image/png;base64...)

Figure 48: **Choosing the number of components in `mint.plsda` using `perf()` with LOGOCV in the `stemcells` study**. Classification error rates (overall and balanced, see Module 2) are represented on the y-axis with respect to the number of components on the x-axis for each prediction distance (see Module 3 and Extra Reading material ‘PLS-DA appendix’). The plot shows that the error rate reaches a minimum from 1 component with the BER and centroids distance.

Based on the performance plot (Figure [48](#fig:07-plsda-perf)), `ncomp = 2` seems to achieve the best performance for the centroid distance, and `ncomp = 1` for the Mahalanobis distance in terms of BER. Additional numerical outputs such as the BER and overall error rates per component, and the error rates per class and per prediction distance, can be output:

```
perf.mint.plsda.stem$global.error$BER
# Type also:
# perf.mint.plsda.stem$global.error
```

```
##        max.dist centroids.dist mahalanobis.dist
## comp1 0.3803556      0.3333333        0.3333333
## comp2 0.3519556      0.3320000        0.3725111
## comp3 0.3499556      0.3384000        0.3232889
## comp4 0.3541111      0.3427778        0.3898000
## comp5 0.3353778      0.3268667        0.3097111
```

While we may want to focus our interpretation on the first component, we run a final MINT PLS-DA model for `ncomp = 2` to obtain 2D graphical outputs (Figure [49](#fig:07-plsda-sample-plot1)):

```
final.mint.plsda.stem <- mint.plsda(X = X, Y = Y, study = study, ncomp = 2)

#final.mint.plsda.stem # Lists the different functions

plotIndiv(final.mint.plsda.stem, legend = TRUE, title = 'MINT PLS-DA',
          subtitle = 'stem cell study', ellipse = T)
```

![Sample plot from the MINT PLS-DA performed on the stemcells gene expression data. Samples are projected into the space spanned by the first two components. Samples are coloured by their cell types and symbols indicate the study membership. Component 1 discriminates fibroblast vs. the others, while component 2 discriminates some of the hiPSC vs. hESC.](data:image/png;base64...)

Figure 49: **Sample plot from the MINT PLS-DA performed on the `stemcells` gene expression data**. Samples are projected into the space spanned by the first two components. Samples are coloured by their cell types and symbols indicate the study membership. Component 1 discriminates fibroblast vs. the others, while component 2 discriminates some of the hiPSC vs. hESC.

The sample plot (Fig [49](#fig:07-plsda-sample-plot1)) shows that fibroblast are separated on the first component. We observe that while deemed not crucial for an optimal discrimination, the second component seems to help separate hESC and hiPSC further. The effect of study after MINT modelling is not strong.

We can compare this output to a classical PLS-DA to visualise the study effect (Figure [50](#fig:07-plsda-sample-plot2)):

```
plsda.stem <- plsda(X = X, Y = Y, ncomp = 2)

plotIndiv(plsda.stem, pch = study,
          legend = TRUE, title = 'Classic PLS-DA',
          legend.title = 'Cell type', legend.title.pch = 'Study')
```

![Sample plot from a classic PLS-DA performed on the stemcells gene expression data that highlights the study effect (indicated by symbols). Samples are projected into the space spanned by the first two components. We still do observe some discrimination between the cell types.](data:image/png;base64...)

Figure 50: **Sample plot from a classic PLS-DA performed on the `stemcells` gene expression data** that highlights the study effect (indicated by symbols). Samples are projected into the space spanned by the first two components. We still do observe some discrimination between the cell types.

## 7.4 Example: MINT sPLS-DA {#07:splsda}

The MINT PLS-DA model shown earlier is built on all 400 genes in \(\boldsymbol X\), many of which may be uninformative to characterise the different classes. Here we aim to identify a small subset of genes that best discriminate the classes.

### 7.4.1 Number of variables to select {#07:splsda-tuning}

We can choose the `keepX` parameter using the `tune()` function for a MINT object. The function performs LOGOCV for different values of `test.keepX` provided on each component, and no repeat argument is needed. Based on the mean classification error rate (overall error rate or BER) and a centroids distance, we output the optimal number of variables `keepX` to be included in the final model.

```
set.seed(2543)  # For a reproducible result here, remove for your own analyses
tune.mint.splsda.stem <- tune(X = X, Y = Y, study = study,
                 ncomp = 2, test.keepX = seq(1, 100, 1),
                 method = 'mint.splsda', #Specify the method
                 measure = 'BER',
                 dist = "centroids.dist",
                 nrepeat = 3)

#tune.mint.splsda.stem # Lists the different types of outputs

# Mean error rate per component and per tested keepX value:
#tune.mint.splsda.stem$error.rate[1:5,]
```

The optimal number of variables to select on each specified component:

```
tune.mint.splsda.stem$choice.keepX
```

```
## comp1 comp2
##    24     1
```

```
plot(tune.mint.splsda.stem)
```

![Tuning keepX in MINT sPLS-DA performed on the stemcells gene expression data. Each coloured line represents the balanced error rate (y-axis) per component across all tested keepX values (x-axis). The diamond indicates the optimal keepX value on a particular component which achieves the lowest classification error rate as determined with a one-sided \(t-\)test across the studies.](data:image/png;base64...)

Figure 51: **Tuning `keepX` in MINT sPLS-DA performed on the `stemcells` gene expression data.** Each coloured line represents the balanced error rate (y-axis) per component across all tested `keepX` values (x-axis). The diamond indicates the optimal `keepX` value on a particular component which achieves the lowest classification error rate as determined with a one-sided \(t-\)test across the studies.

The tuning plot in Figure [51](#fig:07-splsda-tuning-plot) indicates the optimal number of variables to select on component 1 (24) and on component 2 (1). In fact, whilst the BER decreases with the addition of component 2, the standard deviation remains large, and thus only one component is optimal. However, the addition of this second component is useful for the graphical outputs, and also to attempt to discriminate the hESC and hiPCS cell types.

Note:

* *As shown in the quick start example, the tuning step can be omitted if you prefer to set arbitrary `keepX` values.*

### 7.4.2 Final MINT sPLS-DA model {#07:splsda-final}

Following the tuning results, our final model is as follows (we still choose a model with two components in order to obtain 2D graphics):

```
final.mint.splsda.stem <- mint.splsda(X = X, Y = Y, study = study, ncomp = 2,
                              keepX = tune.mint.splsda.stem$choice.keepX)

#mint.splsda.stem.final # Lists useful functions that can be used with a MINT object
```

### 7.4.3 Sample plots {#07:splsda-sample-plots}

The samples can be projected on the global components or alternatively using the partial components from each study (Fig [52](#fig:07-splsda-sample-plots)).

```
plotIndiv(final.mint.splsda.stem, study = 'global', legend = TRUE,
          title = 'Stem cells, MINT sPLS-DA',
          subtitle = 'Global', ellipse = T)
```

```
plotIndiv(final.mint.splsda.stem, study = 'all.partial', legend = TRUE,
          title = 'Stem cells, MINT sPLS-DA',
          subtitle = paste("Study",1:4))
```

![Sample plots from the MINT sPLS-DA performed on the stemcells gene expression data. Samples are projected into the space spanned by the first two components. Samples are coloured by their cell types and symbols indicate study membership. (a) Global components from the model with 95% ellipse confidence intervals around each sample class. (b) Partial components per study show a good agreement across studies. Component 1 discriminates fibroblast vs. the rest, component 2 discriminates further hESC vs. hiPSC.](data:image/png;base64...)![Sample plots from the MINT sPLS-DA performed on the stemcells gene expression data. Samples are projected into the space spanned by the first two components. Samples are coloured by their cell types and symbols indicate study membership. (a) Global components from the model with 95% ellipse confidence intervals around each sample class. (b) Partial components per study show a good agreement across studies. Component 1 discriminates fibroblast vs. the rest, component 2 discriminates further hESC vs. hiPSC.](data:image/png;base64...)

Figure 52: **Sample plots from the MINT sPLS-DA performed on the `stemcells` gene expression data**. Samples are projected into the space spanned by the first two components. Samples are coloured by their cell types and symbols indicate study membership. (a) Global components from the model with 95% ellipse confidence intervals around each sample class. (b) Partial components per study show a good agreement across studies. Component 1 discriminates fibroblast vs. the rest, component 2 discriminates further hESC vs. hiPSC.

The visualisation of the partial components enables us to examine each study individually and check that the model is able to extract a good agreement between studies.

### 7.4.4 Variable plots {#07:splsda-variable-plots}

#### 7.4.4.1 Correlation circle plot {#07:splsda-correlation-plot}

We can examine our molecular signature selected with MINT sPLS-DA. The correlation circle plot, presented in Module 2, highlights the contribution of each selected transcript to each component (close to the large circle), and their correlation (clusters of variables) in Figure [53](#fig:07-splsda-correlation-plot2):

```
plotVar(final.mint.splsda.stem)
```

![](data:image/png;base64...)

![Correlation circle plot representing the genes selected by MINT sPLS-DA performed on the stemcells gene expression data to examine the association of the genes selected on the first two components. We mainly observe two groups of genes, either positively or negatively associated with component 1 along the x-axis. This graphic should be interpreted in conjunction with the sample plot.](data:image/png;base64...)

Figure 53: **Correlation circle plot representing the genes selected by MINT sPLS-DA performed on the `stemcells` gene expression data** to examine the association of the genes selected on the first two components. We mainly observe two groups of genes, either positively or negatively associated with component 1 along the x-axis. This graphic should be interpreted in conjunction with the sample plot.

We observe a subset of genes that are strongly correlated and negatively associated to component 1 (negative values on the x-axis), which are likely to characterise the groups of samples hiPSC and hESC, and a subset of genes positively associated to component 1 that may characterise the fibroblast samples (and are negatively correlated to the previous group of genes).

Note:

* *We can use the `var.name` argument to show gene name ID, as shown in Module 3 for PLS-DA.*

#### 7.4.4.2 Clustered Image Maps {#07:splsda-cim}

The Clustered Image Map represents the expression levels of the gene signature per sample, similar to a PLS-DA object (see Module 3). Here we use the default Euclidean distance and Complete linkage in Figure [54](#fig:07-splsda-cim) for a specific component (here 1):

```
# If facing margin issues, use either X11() or save the plot using the
# arguments save and name.save
cim(final.mint.splsda.stem, comp = 1, margins=c(10,5),
    row.sideColors = color.mixo(as.numeric(Y)), row.names = FALSE,
    title = "MINT sPLS-DA, component 1")
```

![Clustered Image Map of the genes selected by MINT sPLS-DA on the stemcells gene expression data for component 1 only. A hierarchical clustering based on the gene expression levels of the selected genes on component 1, with samples in rows coloured according to cell type showing a separation of the fibroblast vs. the other cell types.](data:image/png;base64...)

Figure 54: **Clustered Image Map of the genes selected by MINT sPLS-DA on the `stemcells` gene expression data for component 1 only**. A hierarchical clustering based on the gene expression levels of the selected genes on component 1, with samples in rows coloured according to cell type showing a separation of the fibroblast vs. the other cell types.

As expected and observed from the sample plot Figure [52](#fig:07-splsda-sample-plots), we observe in the CIM that the expression of the genes selected on component 1 discriminates primarily the fibroblast vs. the other cell types.

#### 7.4.4.3 Relevance networks {#07:splsda-network}

Relevance networks can also be plotted for a PLS-DA object, but would only show the association between the selected genes and the cell type (dummy variable in \(\boldsymbol Y\) as an outcome category) as shown in Figure [55](#fig:07-splsda-network). Only the variables selected on component 1 are shown (`comp = 1`):

```
# If facing margin issues, use either X11() or save the plot using the
# arguments save and name.save
network(final.mint.splsda.stem, comp = 1,
        color.node = c(color.mixo(1), color.mixo(2)),
        shape.node = c("rectangle", "circle"))
```

![Relevance network of the genes selected by MINT sPLS-DA performed on the stemcells gene expression data for component 1 only. Associations between variables from \(\boldsymbol X\) and the dummy matrix \(\boldsymbol Y\) are calculated as detailed in Extra Reading material from Module 2. Edges indicate high or low association between the genes and the different cell types.](data:image/png;base64...)

Figure 55: **Relevance network of the genes selected by MINT sPLS-DA performed on the `stemcells` gene expression data for component 1 only**. Associations between variables from \(\boldsymbol X\) and the dummy matrix \(\boldsymbol Y\) are calculated as detailed in Extra Reading material from Module 2. Edges indicate high or low association between the genes and the different cell types.

#### 7.4.4.4 Variable selection and loading plots {#07:splsda-loading-plot}

The `selectVar()` function outputs the selected transcripts on the first component along with their loading weight values. We consider variables as important in the model when their absolute loading weight value is high. In addition to this output, we can compare the stability of the selected features across studies using the `perf()` function, as shown in PLS-DA in Module 3.

```
# Just a head
head(selectVar(final.mint.plsda.stem, comp = 1)$value)
```

```
##                   value.var
## ENSG00000181449 -0.09764220
## ENSG00000123080  0.09606034
## ENSG00000110721 -0.09595070
## ENSG00000176485 -0.09457383
## ENSG00000184697 -0.09387322
## ENSG00000102935 -0.09370298
```

The `plotLoadings()` function displays the coefficient weight of each selected variable in each study and shows the agreement of the gene signature across studies (Figure [56](#fig:07-splsda-loading-plot)). Colours indicate the class in which the mean expression value of each selected gene is maximal. For component 1, we obtain:

```
plotLoadings(final.mint.splsda.stem, contrib = "max", method = 'mean', comp=1,
             study="all.partial", title="Contribution on comp 1",
             subtitle = paste("Study",1:4))
```

![Loading plots of the genes selected by the MINT sPLS-DA performed on the stemcells data, on component 1 per study. Each plot represents one study, and the variables are coloured according to the cell type they are maximally expressed in, on average. The length of the bars indicate the loading coefficient values that define the component. Several genes distinguish between fibroblast and the other cell types, and are consistently overexpressed in these samples across all studies. We observe slightly more variability in whether the expression levels of the other genes are more indicative of hiPSC or hESC cell types.](data:image/png;base64...)![Loading plots of the genes selected by the MINT sPLS-DA performed on the stemcells data, on component 1 per study. Each plot represents one study, and the variables are coloured according to the cell type they are maximally expressed in, on average. The length of the bars indicate the loading coefficient values that define the component. Several genes distinguish between fibroblast and the other cell types, and are consistently overexpressed in these samples across all studies. We observe slightly more variability in whether the expression levels of the other genes are more indicative of hiPSC or hESC cell types.](data:image/png;base64...)

Figure 56: **Loading plots of the genes selected by the MINT sPLS-DA performed on the `stemcells` data, on component 1 per study**. Each plot represents one study, and the variables are coloured according to the cell type they are maximally expressed in, on average. The length of the bars indicate the loading coefficient values that define the component. Several genes distinguish between fibroblast and the other cell types, and are consistently overexpressed in these samples across all studies. We observe slightly more variability in whether the expression levels of the other genes are more indicative of hiPSC or hESC cell types.

Several genes are consistently over-expressed on average in the fibroblast samples in each of the studies, however, we observe a less consistent pattern for the other genes that characterise hiPSC} and hESC. This can be explained as the discrimination between both classes is challenging on component 1 (see sample plot in Figure [52](#fig:07-splsda-sample-plots)).

### 7.4.5 Classification performance {#07:splsda-perf}

We assess the performance of the MINT sPLS-DA model with the `perf()` function. Since the previous tuning was conducted with the distance `centroids.dist`, the same distance is used to assess the performance of the final model. We do not need to specify the argument `nrepeat` as we use LOGOCV in the function.

```
set.seed(123)  # For reproducible results here, remove for your own study
perf.mint.splsda.stem.final <- perf(final.mint.plsda.stem, dist = 'centroids.dist')

perf.mint.splsda.stem.final$global.error
```

```
## $BER
##       centroids.dist
## comp1      0.3333333
## comp2      0.3320000
##
## $overall
##       centroids.dist
## comp1          0.456
## comp2          0.392
##
## $error.rate.class
## $error.rate.class$centroids.dist
##                comp1     comp2
## Fibroblast 0.0000000 0.0000000
## hESC       0.1891892 0.4594595
## hiPSC      0.8620690 0.5517241
```

The classification error rate per class is particularly insightful to understand which cell types are difficult to classify, hESC and hiPS - whose mixture can be explained for biological reasons.

## 7.5 Take a detour {#07:splsda-auroc}

### 7.5.1 AUC

An AUC plot for the integrated data can be obtained using the function `auroc()` (Fig [57](#fig:07-splsda-auroc-plots)).

Remember that the AUC incorporates measures of sensitivity and specificity for every possible cut-off of the predicted dummy variables. However, our PLS-based models rely on prediction distances, which can be seen as a determined optimal cut-off. Therefore, the ROC and AUC criteria may not be particularly insightful in relation to the performance evaluation of our supervised multivariate methods, but can complement the statistical analysis (from Rohart, Gautier, Singh, and Lê Cao ([2017](#ref-Roh17))).

```
auroc(final.mint.splsda.stem, roc.comp = 1)
```

We can also obtain an AUC plot per study by specifying the argument `roc.study`:

```
auroc(final.mint.splsda.stem, roc.comp = 1, roc.study = '2')
```

![ROC curve and AUC from the MINT sPLS-DA performed on the stemcells gene expression data for global and specific studies, averaged across one-vs-all comparisons. Numerical outputs include the AUC and a Wilcoxon test \(p-\)value for each ‘one vs. other’ class comparison that are performed per component. This output complements the sPLS-DA performance evaluation but should not be used for tuning (as the prediction process in sPLS-DA is based on prediction distances, not a cutoff that maximises specificity and sensitivity as in ROC). The plot suggests that the selected features are more accurate in classifying fibroblasts versus the other cell types, and less accurate in distinguishing hESC versus the other cell types or hiPSC versus the other cell types.](data:image/png;base64...)![ROC curve and AUC from the MINT sPLS-DA performed on the stemcells gene expression data for global and specific studies, averaged across one-vs-all comparisons. Numerical outputs include the AUC and a Wilcoxon test \(p-\)value for each ‘one vs. other’ class comparison that are performed per component. This output complements the sPLS-DA performance evaluation but should not be used for tuning (as the prediction process in sPLS-DA is based on prediction distances, not a cutoff that maximises specificity and sensitivity as in ROC). The plot suggests that the selected features are more accurate in classifying fibroblasts versus the other cell types, and less accurate in distinguishing hESC versus the other cell types or hiPSC versus the other cell types.](data:image/png;base64...)

Figure 57: **ROC curve and AUC from the MINT sPLS-DA performed on the `stemcells` gene expression data for global and specific studies**, averaged across one-vs-all comparisons. Numerical outputs include the AUC and a Wilcoxon test \(p-\)value for each ‘one vs. other’ class comparison that are performed per component. This output complements the sPLS-DA performance evaluation but *should not be used for tuning* (as the prediction process in sPLS-DA is based on prediction distances, not a cutoff that maximises specificity and sensitivity as in ROC). The plot suggests that the selected features are more accurate in classifying fibroblasts versus the other cell types, and less accurate in distinguishing hESC versus the other cell types or hiPSC versus the other cell types.

### 7.5.2 Prediction on an external study {#07:splsda-predict}

We use the `predict()` function to predict the class membership of new test samples from an external study. We provide an example where we set aside a particular study, train the MINT model on the remaining three studies, then predict on the test study. This process exactly reflects the inner workings of the `tune()` and `perf()` functions using LOGOCV.

Here during our model training on the three studies only, we assume we have performed the tuning steps described in this case study to choose `ncomp` and `keepX` (here set to arbitrary values to avoid overfitting):

```
# We predict on study 3
indiv.test <- which(study == "3")

# We train on the remaining studies, with pre-tuned parameters
mint.splsda.stem2 <- mint.splsda(X = X[-c(indiv.test), ],
                                Y = Y[-c(indiv.test)],
                                study = droplevels(study[-c(indiv.test)]),
                                ncomp = 1,
                                keepX = 30)

mint.predict.stem <- predict(mint.splsda.stem2, newdata = X[indiv.test, ],
                        dist = "centroids.dist",
                        study.test = factor(study[indiv.test]))

# Store class prediction with a model with 1 comp
indiv.prediction <- mint.predict.stem$class$centroids.dist[, 1]

# The confusion matrix compares the real subtypes with the predicted subtypes
conf.mat <- get.confusion_matrix(truth = Y[indiv.test],
                     predicted = indiv.prediction)

conf.mat
```

```
##            predicted.as.Fibroblast predicted.as.hESC predicted.as.hiPSC
## Fibroblast                       3                 0                  0
## hESC                             0                 4                  4
## hiPSC                            2                 2                  6
```

Here we have considered a trained model with one component, and compared the cell type prediction for the test study 3 with the known cell types. The classification error rate is relatively high, but potentially could be improved with a proper tuning, and a larger number of studies in the training set.

```
# Prediction error rate
(sum(conf.mat) - sum(diag(conf.mat)))/sum(conf.mat)
```

```
## [1] 0.3809524
```

# 8 Session Information {#08}

## 8.1 mixOmics version {#08:mixomics-ver}

```
## [1] '6.32.0'
```

## 8.2 Session info {#08:session-info}

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
## [1] mixOmics_6.32.0     ggplot2_4.0.0       lattice_0.22-7
## [4] MASS_7.3-65         kableExtra_1.4.0    knitr_1.50
## [7] BiocParallel_1.44.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1    viridisLite_0.4.2   dplyr_1.1.4
##  [4] farver_2.1.2        S7_0.2.0            fastmap_1.2.0
##  [7] digest_0.6.37       lifecycle_1.0.4     ellipsis_0.3.2
## [10] processx_3.8.6      magrittr_2.0.4      compiler_4.5.1
## [13] rlang_1.1.6         sass_0.4.10         tools_4.5.1
## [16] igraph_2.2.1        yaml_2.3.10         labeling_0.4.3
## [19] rARPACK_0.11-0      pkgbuild_1.4.8      curl_7.0.0
## [22] plyr_1.8.9          xml2_1.4.1          RColorBrewer_1.1-3
## [25] pkgload_1.4.1       withr_3.0.2         purrr_1.1.0
## [28] desc_1.4.3          grid_4.5.1          scales_1.4.0
## [31] dichromat_2.0-0.1   tinytex_0.57        cli_3.6.5
## [34] ellipse_0.5.0       rmarkdown_2.30      generics_0.1.4
## [37] remotes_2.5.0       rstudioapi_0.17.1   RSpectra_0.16-2
## [40] reshape2_1.4.4      sessioninfo_1.2.3   cachem_1.1.0
## [43] stringr_1.5.2       parallel_4.5.1      BiocManager_1.30.26
## [46] matrixStats_1.5.0   vctrs_0.6.5         devtools_2.4.6
## [49] Matrix_1.7-4        jsonlite_2.0.0      bookdown_0.45
## [52] callr_3.7.6         ggrepel_0.9.6       systemfonts_1.3.1
## [55] magick_2.9.0        tidyr_1.3.1         jquerylib_0.1.4
## [58] snow_0.4-4          glue_1.8.0          codetools_0.2-20
## [61] ps_1.9.1            stringi_1.8.7       gtable_0.3.6
## [64] tibble_3.3.0        pillar_1.11.1       htmltools_0.5.8.1
## [67] R6_2.6.1            textshaping_1.0.4   evaluate_1.0.5
## [70] memoise_2.0.1       corpcor_1.6.10      bslib_0.9.0
## [73] Rcpp_1.1.0          svglite_2.2.2       gridExtra_2.3
## [76] xfun_0.53           fs_1.6.6            usethis_3.2.1
## [79] pkgconfig_2.0.3
```

# References

Bushel, Pierre R, Russell D Wolfinger, and Greg Gibson. 2007. “Simultaneous Clustering of Gene Expression Data with Clinical Chemistry and Pathological Evaluatio Ns Reveals Phenotypic Prototypes.” *BMC Systems Biology* 1 (1): 15.

Cancer Genome Atlas Network, and others. 2012. “Comprehensive Molecular Portraits of Human Breast Tumours.” *Nature* 490 (7418): 61–70.

Chin, Mark H, Mike J Mason, Wei Xie, Stefano Volinia, Mike Singer, Cory Peterson, Gayane Ambartsumyan, et al. 2009. “Induced Pluripotent Stem Cells and Embryonic Stem Cells Are Distinguished by Gene Expression Signatures.” *Cell Stem Cell* 5 (1): 111–23.

Csardi, Gabor, Tamas Nepusz, and others. 2006. “The Igraph Software Package for Complex Network Research.” *InterJournal, Complex Systems* 1695 (5): 1–9.

Eslami, A, EM Qannari, A Kohler, and S Bougeard. 2014. “Two-Block Multi-Group Data Analysis. Application to Epidemiology.” In *New Perspectives in Partial Least Squares and Related Methods*. Springer Verlag.

González, Ignacio, Sébastien Déjean, Pascal GP Martin, and Alain Baccini. 2008. “CCA: An R Package to Extend Canonical Correlation Analysis.” *Journal of Statistical Software* 23 (12): 1–14.

González, Ignacio, Kim-Anh Lê Cao, Melissa J Davis, Sébastien Déjean, and others. 2012. “Visualising Associations Between Paired ’Omics’ Data Sets.” *BioData Mining* 5 (1): 19.

Khan, Javed, Jun S Wei, Markus Ringner, Lao H Saal, Marc Ladanyi, Frank Westermann, Frank Berthold, et al. 2001. “Classification and Diagnostic Prediction of Cancers Using Gene Expression Profiling and Artificial Neural Networks.” *Nature Medicine* 7 (6): 673–79.

Lê Cao, Kim-Anh, Mary-Ellen Costello, Xin-Yi Chua, Rémi Brazeilles, and Pascale Rondeau. 2016. “MixMC: Multivariate Insights into Microbial Communities.” *PloS One* 11 (8): e0160169.

Newman, Aaron M, and James B Cooper. 2010. “Lab-Specific Gene Expression Signatures in Pluripotent Stem Cells.” *Cell Stem Cell* 7 (2): 258–62.

Rohart, Florian, Benoit Gautier, Amrit Singh, and Kim-Anh Le Cao. 2017. “MixOmics: An R Package for ‘Omics Feature Selection and Multiple Data Integration.” *PLoS Computational Biology*.

Rohart, Florian, Benoit Gautier, Amrit Singh, and Kim-Anh Lê Cao. 2017. “MixOmics: An R Package for ‘Omics Feature Selection and Multiple Data Integration.” *PLoS Computational Biology* 13 (11): e1005752.

Singh, Amrit, Casey P Shannon, Benoı̂t Gautier, Florian Rohart, Michaël Vacher, Scott J Tebbutt, and Kim-Anh Lê Cao. 2019. “DIABLO: An Integrative Approach for Identifying Key Molecular Drivers from Multi-Omics Assays.” *Bioinformatics* 35 (17): 3055–62.

Szakács, Gergely, Jean-Philippe Annereau, Samir Lababidi, Uma Shankavaram, Angela Arciello, Kimberly J Bussey, William Reinhold, et al. 2004. “Predicting Drug Sensitivity and Resistance: Profiling Abc Transporter Genes in Cancer Cells.” *Cancer Cell* 6 (2): 129–37.

Sørlie, Therese, Charles M Perou, Robert Tibshirani, Turid Aas, Stephanie Geisler, Hilde Johnsen, Trevor Hastie, et al. 2001. “Gene Expression Patterns of Breast Carcinomas Distinguish Tumor Subclasses with Clinical Implications.” *Proceedings of the National Academy of Sciences* 98 (19): 10869–74.

Tenenhaus, Arthur, and Michel Tenenhaus. 2011. “Regularized Generalized Canonical Correlation Analysis.” *Psychometrika* 76 (2): 257–84.

Teng, Mingxiang, Michael I Love, Carrie A Davis, Sarah Djebali, Alexander Dobin, Brenton R Graveley, Sheng Li, et al. 2016. “A Benchmark for Rna-Seq Quantification Pipelines.” *Genome Biology* 17 (1): 74.

Wells, Christine A, Rowland Mosbergen, Othmar Korn, Jarny Choi, Nick Seidenman, Nicholas A Matigian, Alejandra M Vitale, and Jill Shepherd. 2013. “Stemformatics: Visualisation and Sharing of Stem Cell Gene Expression.” *Stem Cell Research* 10 (3): 387–95.