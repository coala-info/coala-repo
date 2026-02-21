# OMICsPCA: An R package for quantitative integration and analysis of multiple omics assays from heterogeneous samples

#### Subhadeep Das

#### 2025-10-30

* [1 Introduction](#introduction)
  + [1.1 Background:](#background)
  + [1.2 Illustration of the problem with example](#illustration-of-the-problem-with-example)
  + [1.3 Previous approaches/frameworks towards multi-omics data integration](#previous-approachesframeworks-towards-multi-omics-data-integration)
  + [1.4 OMICsPCA](#omicspca)
* [2 DATA](#data)
* [3 Example](#example)
  + [3.1 Preparation of data](#preparation-of-data)
  + [3.2 Reading data](#reading-data)
  + [3.3 Subsetting into groups](#subsetting-into-groups)
  + [3.4 Exploratory data analysis (EDA) on created groups](#exploratory-data-analysis-eda-on-created-groups)
    - [3.4.1 descriptor()](#descriptor)
    - [3.4.2 chart\_correlation()](#chart_correlation)
  + [3.5 Integration of Multiple Cell lines](#integration-of-multiple-cell-lines)
  + [3.6 Analysis of integrated data](#analysis-of-integrated-data)
    - [3.6.1 choice = 1](#choice-1)
    - [3.6.2 choice = 2](#choice-2)
    - [3.6.3 choice = 3](#choice-3)
    - [3.6.4 choice = 4](#choice-4)
    - [3.6.5 choice = 5](#choice-5)
    - [3.6.6 choice = 6](#choice-6)
  + [3.7 Analysis of individuals/annotations from integrated data](#analysis-of-individualsannotations-from-integrated-data)
    - [3.7.1 choice = 1](#choice-1-1)
    - [3.7.2 choice = 2](#choice-2-1)
  + [3.8 Density analysis](#density-analysis)
    - [3.8.1 1D plots](#d-plots)
    - [3.8.2 3D plots](#d-plots-1)
      * [3.8.2.1 static = FALSE](#static-false)
      * [3.8.2.2 static = TRUE](#static-true)
  + [3.9 Integration of multiple assays/ modalities](#integration-of-multiple-assays-modalities)
    - [3.9.1 Analyses of variables](#analyses-of-variables)
      * [3.9.1.1 choice = 1](#choice-1-2)
      * [3.9.1.2 choice = 2](#choice-2-2)
      * [3.9.1.3 choice = 3](#choice-3-1)
      * [3.9.1.4 choice = 4](#choice-4-1)
      * [3.9.1.5 choice = 5](#choice-5-1)
    - [3.9.2 Analysis of integrated individuals/annotations](#analysis-of-integrated-individualsannotations)
      * [3.9.2.1 choice 1: 2D scatter plot](#choice-1-2d-scatter-plot)
      * [3.9.2.2 choice 2: 3D scatter plot](#choice-2-3d-scatter-plot)
    - [3.9.3 Density analysis of integrated data](#density-analysis-of-integrated-data)
      * [3.9.3.1 1D plot](#d-plot)
      * [3.9.3.2 3D plot](#d-plot-1)
        + [3.9.3.2.1 static = TRUE](#static-true-1)
        + [3.9.3.2.2 static = FALSE](#static-false-1)
  + [3.10 Cluster Analysis](#cluster-analysis)
    - [3.10.1 Validation of clusters](#validation-of-clusters)
    - [3.10.2 Identification of misclassified points](#identification-of-misclassified-points)
    - [3.10.3 Exploration of clusters](#exploration-of-clusters)
* [4 Summary](#summary)
* [5 SessionInfo](#sessioninfo)
* [6 References](#references)

# 1 Introduction

## 1.1 Background:

OMICsPCA is a statistical framework designed to integrate and analyse multiple types of heterogeneous assays, factors, data types or modalities (e.g. ChIP-seq, RNA-seq) from different samples or sources ( e.g. multiple cell lines, time points etc.). Biological processes in eukaryotes are complicated molecular interactions, spanned over multiple layers of regulation. In order to understand the collective effects of the interactions of biological processes, they should be studied parallelly. High throughput sequencing has enabled genome-wide assays across several disease conditions, cell types, time points etc. at a much faster rate. On the other hand, replicated experiments on diverse samples (e.g. various cell lines) help us to understand the origin of variation (e.g. the genes, TSSs, exons etc) observed between the samples. Therefore, integrative multi-omics studies on heterogeneous samples are gaining their importance every day. As a consequence, a huge number of datasets are being produced and stored in public databases, allowing researchers to perform integrative analysis of multiple data modalities.

Unfortunately, most of such studies are limited to very few samples(e.g. cell lines) or data modalities (e.g.  various ChIP-seq assays) due to the huge cost, ethical issues, and scarcity of samples associated with the entire experimental process. And, most of the data integration methods rely on the condition of homogeneity of samples, i.e. the samples corresponding to each modality should be the same. As a result, integrative analysis on publicly available data sets is very much rare and extremely restricted to very few numbers of samples or modalities (or both).

## 1.2 Illustration of the problem with example

Let’s illustrate the problem with an example. Suppose our objective is to decipher the collective effect of CpG methylation and H3k4me3 histone modification on the gene expression, followed by clustering of the similar genes on the basis of the consolidated effect of these 2 data modalities. Consider we have the following datasets:

1. CpG methylation on 5 Cell lines A, B, C, D, and E
2. H3k4me3 histone modification on 10 Cell lines A,D,E,I,K,Q,P,Z,W and G.

Here, we can not calculate the collective effect directly, since the cell lines and the number of cell lines are different in the two experiments.

## 1.3 Previous approaches/frameworks towards multi-omics data integration

Several data integration frameworks have been designed over the past few years to overcome such difficulty. For example, Huang (1) proposed a regression-based joint modeling approach to integrate SNPs, DNA methylation, and gene expression; He et al. (2)developed a pattern matching method to integrated eQTL and GWAS data; Xiong et al. (3) developed a statistical framework to associate SNP and gene expression information etc. All such applications are designed to perform in a supervised manner, i.e. the integrated data modalities must be associated with labelled classes (e.g. disease and control class; pathway 1 and pathway 2 etc.). Such constraints impose a limitation on the algorithms to be used in varieties of applications (e.g., can’t be used in clustering). In contrast, Ha, et al. (4) developed an unsupervised Gaussian process model for qualitative (logical combination of binary values, e.g. 0/1 or TRUE/FALSE) integration of a large number of epigenetic factors and applied it to describe cell lineage-specific gene regulatory programs. Although this overcomes the limitation of class association to some extent, this process is only sufficient for the applications where qualitative integration is sufficient.

As mentioned earlier, there is another important application of data integration, which is associated with the disentanglement of the source of variation observed between the samples or the individuals. A common strategy used in such studies is to perform a large number of association tests between the features and the data modalities (5, 6). Alternatively, kernel or graph-based methods are also considered as methods of integration and the integrated data is then used to build common similarity networks between samples (7, 8). Although effective in accomplishing specific tasks, such approaches lack proper interpretability (9) and do not suffice to explain many other relevant queries applicable to integrated omics data. Such queries include identification of variably controlled genes, genes sharing similar epigenomic state across various samples and many more.

## 1.4 OMICsPCA

OMICsPCA is a multipurpose tool designed to overcome the difficulties associated with both the applications of data integration. It is designed to identify the source of variation among the samples/variables (the columns of a table, e.g. cell lines, patients etc.) or individuals (the rows of a table, e.g. genes, exons etc.) associated with each data modality (i.e. the tables, e.g. CpG\_methylation, ChIP-seq on a protein etc.). It guides the user through various analyses to decide on similar samples/variables (e.g.Cell lines). This is followed by selecting the data modalities (e.g. the assays) that can be included or excluded leading to data integration. The selected data modalities can be further integrated and analysed and the data points or individuals (e.g. genes, TSSs, exons) may be clustered on the basis of the integrated data coming from single or multiple modalities.

In short, OMICsPCA can be used in clustering genes, TSSs, exons on the basis of multiple types of heterogeneous experimental or theoretical data or vice-versa. Such kind of multivariate analyses is useful in identification of similar cell lines or assays prior to the integration process. In this vignette, we show an example of the entire analysis process done on human transcription start sites.

# 2 DATA

In the following example, we run our analyses on a subset of 3 epigenetic Assays and one expression assay. All the data are publicly available at **ENCODE** and **ROADMAP epigenomics project** portal. The data is stored in the **MultiAssayExperiment** object named **multi\_assay**, which is stored in the supporting data package **OMICsPCAdata**.

More detailed description of the datasets are provided at the man page of **multi\_assay**, which can be accessed by `?multi_assay`

# 3 Example

  In this section we demonstrate the functionality of OMICsPCA with an example. We divided the GENCODE annotated TSSs into 4 groups on the basis of their on-off state in 31 cell lines and mapped Histone ChIP-seq data with them in order to study the consolidated effect of these data modalities on their expression. Before calculating the consolidated effect, we filtered out the outlier samples and identified the data modalities that show discriminatory density pattern among the expression groups. Finally, we clustered the similar TSSs together on the basis of the consolidated effect of discriminatory factors.

## 3.1 Preparation of data

OMICsPCA has an inbuilt function **prepare\_dataset()** that aggregates the samples (e.g. cell lines) of each data modality (e.g. a histone modification ChIP-seq assay) corresponding to each feature of the genome (notably gene, TSS, exon etc.) and returns a dataframe.

The rows of this dataframe object contain the features (e.g. genes) and each column contains the values corresponding to a sample (e.g. Cell line).

The arguments taken by this function is described below:

1. `factdir`: full path of the directory containing files corresponding to various cell lines in .bed format. This directory should contain only the files of the same assay (modality) (e.g. H3k9ac) from different samples (e.g. cell lines).
2. `annofile`: full path of the file containing the annotation file (e.g exons, TSSs, genes etc) in .bed format.
3. `annolist`: name of full set or subset of the entries in the annotation file. The **.bed** files should have at least 4 columns. The first column is the chromosome name, the second and third is the start and end position of the feature (e.g. a gene or a ChIP-seq peak etc). The fourth column contains the value of the described feature (e.g. expression of a gene, the ChIP-seq intensity of a peak or name of a gene etc.).

The `.bed` files should have at least 4 columns. The first column is the chromosome name, the second and third is the start and end of the feature (e.g. a gene or a ChIP-seq peak etc) accordingly and the fourth column contains the value (e.g. expression of a gene, ChIP-seq intensity of a peak or name of a gene etc.).

Some examples of the input file formats are given below:

Intensity of demo peaks

| chromosome | start | end | intensity |
| --- | --- | --- | --- |
| chr1 | 29533 | 29590 | 3.665498 |
| chr1 | 53000 | 53010 | 3.798148 |
| chr1 | 160430 | 160467 | 4.294974 |
| chr1 | 893924 | 895151 | 3.160494 |
| chr1 | 895275 | 896888 | 3.881008 |

demo annotation file(`annofile`)

| chromosome | start | end | TSS ID |
| --- | --- | --- | --- |
| chr1 | 11858 | 11885 | TSS1 |
| chr1 | 11999 | 12021 | TSS2 |
| chr1 | 29543 | 29565 | TSS3 |
| chr1 | 30256 | 30278 | TSS4 |
| chr1 | 53038 | 53060 | TSS5 |

demo TSSs (`annolist`)

| TSS ID |
| --- |
| TSS1 |
| TSS2 |
| TSS3 |
| TSS4 |
| TSS5 |

Here we show the use of **prpareDataset()** by integrating demo peaks (.bed format) from 2 files into a data frame named. The example data sets are packaged inside the `OMICsPCAdata` package

```
anno <- system.file("extdata/annotation2/TSS_groups.bed",
                    package = "OMICsPCAdata")

list <- system.file("extdata/annotation2/TSS_list",
                    package = "OMICsPCAdata")

fact <- system.file("extdata/factors2/demofactor",
                    package = "OMICsPCAdata")

list.files(path = fact)
# [1] "Cell1.bed" "Cell2.bed"
```

prepare\_dataset() will combine these 2 bed files into a dataframe. The rows of the dataframe will correspond to the entries in file entered through the variable named `list` and the columns will correspond to the 2 files shown above.

```
all_cells <- prepare_dataset(factdir = fact,
annofile = anno, annolist = list)
# [1] "Running intersect... This may take some time"
# [1] "Merging cell lines... This may take some time"
# [1] "Total time taken is: 0.398070573806763"
# [1] "time taken to run intersect() is: 0.392868518829346"
# [1] "time taken to run merge_cells() is: 0.00520205497741699"

head(all_cells[c(1,14,15,16,20),])
# # A tibble: 5 × 2
#   Cell1.bed Cell2.bed
#       <dbl>     <dbl>
# 1      0         0
# 2      3.67      0
# 3      0         1.86
# 4      0         0
# 5      4.29      0
```

For a different assay type repeat the process:

```
factor_x  <- prepare_dataset(factdir = fact,
                            annofile = anno, annolist = list)

# where `fact` is the directory of the samples corresponding to factor_x

For example,

fact <- system.file("path to cpg")
cpg <- prepare_dataset(factdir = fact, annofile=anno, annolist = list)
```

## 3.2 Reading data

OMICsPCA is designed to read various assays done on various cell lines into an **MultiAssayExperiment** class object and then run various analyses on this object.

```
library(MultiAssayExperiment)

datalist <- data(package = "OMICsPCAdata")
datanames <- datalist$results[,3]
data(list = datanames)

assaylist <- list("demofactor"  = all_cells)

demoMultiAssay <- MultiAssayExperiment(experiments = assaylist)
# Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
#   potential for errors with mixed data types
# Warning: 'ExperimentList' contains 'data.frame' or 'DataFrame',
#   potential for errors with mixed data types
```

For ease of analysis, we compiled some preloaded data into an **MultiAssayExperiment** object named **multi\_assay**.

## 3.3 Subsetting into groups

Once the dataframes corresponding to the assays/modalities is prepared and stored in the “MultiAssayExperiment” object", the user may want to divide the entire annotation set into smaller groups. Here we show an example to divide 28770 GENCODE TSS groups into 4 expression groups. The grouping criteria are based on the on/off status (determined from CAGE experiments) of the TSSs in 31 cell lines.

OMICsPCA has a function **create\_group()** to do this task. This function takes the following 4 arguments:

1. **group\_names** : a vector containing the user-defined names of the groups to be created
2. **factor** : name of the data frame on which groups will be created
3. **comparison** : a vector of comparison symbols such as >, <, ==, >=, <=, %in% etc
4. **condition** : a vector of conditions corresponding to `comparison`. condition should be a vector or range of digits (e.g. c(1,3,7,9). or 1:5) if %in% is chosen as comparison and a single digit for other cases.
5. **name** : name of the **MultiAssayExperiment** object containing the assay data
6. **grouping\_factor** : name of the assay/modality on which grouping will be done

```
groupinfo <- create_group(name = multi_assay, group_names = c("WE" ,
"RE" ,"NE" ,"IntE"),
grouping_factor = "CAGE",
comparison = c(">=" ,"%in%" ,"==" ,"%in%"),
condition = c("25" ,"1:5" ,"0" ,"6:24"))
```

In the above example the dataframe CAGE is divided into 4 smaller data frames e.g; WE, RE, NE and IntE. “WE” contains TSSs expressed in >= 25 cell lines, “RE” represents TSSs expressed in 1 to 5 cell lines and so on.

The CAGE data frame looks like this:

|  | A549 | AG04450 | B.Cells\_CD20. | BJ | Gm12878 |
| --- | --- | --- | --- | --- | --- |
| ENST00000387347.2 | 0 | 0 | 85.8895806558477 | 0 | 0 |
| ENST00000387314.1 | 49.6336910685519 | 0 | 0 | 0 | 0 |
| ENST00000389680.2 | 0 | 0 | 0 | 0 | 0 |
| ENST00000386347.1 | 61.4568108749758 | 19.4710468352727 | 23.969601604456 | 17.9526438211874 | 129.285323659344 |
| ENST00000361390.2 | 196.720325095994 | 121.562481593189 | 216.782580604901 | 60.083445046716 | 74.770012182987 |

The **groupinfo** object is accessd by subsequent functions. So this object has to be present in the global environment to run other functions. If the user do not wish to divide the datasets into groups or if the user has predefined groups, then this information may be read directly from a file or object having this information. We compiled a predefined group format in a dataframe **groupinfo\_ext** and compiled it in **OMICsPCAdata**.

|  | group |
| --- | --- |
| ENST00000361390.2 | WE |
| ENST00000361335.1 | WE |
| ENST00000361567.2 | WE |
| ENST00000293860.5 | WE |
| ENST00000400266.3 | WE |

## 3.4 Exploratory data analysis (EDA) on created groups

Once the group information is read, we can study the the distribution of various Assays/factors(e.g. H2az, H3k9ac etc) on the annotations (e.g. TSSs, genes) of various groups (In the above example, the groups are created on the basis of on-off state of TSSs in 31 cell lines). OMICsPCA has several functions for EDA.

### 3.4.1 descriptor()

Descriptor works in two modes depending on the value passed through the argument `choice`. choice = 1 displays panels of boxplots corresponding to the Assay(s) or factor(s) or modality(ies) chosen through argument `factor`. Each panel shows a number of boxplots corresponding to the group(s) passed through argument `groups`. Each boxplot in choice 1 represents the distribution of the percentage of cell lines corresponding to a group that is overlapped with the selected assay.

**NOTE :** in `groups`, one group name should be used only once.

**NOTE :** `groups` can handle only the predefined groups or the groups created by “create\_group()”

```
descriptor(name = multi_assay,
factors = c(
"H2az",
"H3k4me1","H3k9ac"),
groups = c("WE","RE"),
choice = 1,
title = "Distribution of percentage of cell types overlapping
with various factors",
groupinfo = groupinfo)
```

![](data:image/png;base64...)

Above boxplot shows that “H2az” and “H3k9ac” overlaps with Widely Expressed (“WE”) TSSs in almost 100 % cell lines of respective assays. Thus they can be thought of as characteristics of “WE”. In addition, almost the opposite trait is observed in “NE”, which in turn, indicates that these 6 properties may be the discriminatory factors between the various expression groups.

In `choice` = 2, a value needs to be supplied to the argument `choice2group`. This value should be the name of one of the groups created by “create\_group()”. The plot displayed in this mode represents the distribution of the percentage of celll lines corresponding to a factor/Assay/modality with various combination of other Assays/factors/modalities supplied through `factors`.

```
descriptor(name = multi_assay,
factors = c("H2az",
"H3k4me1","H3k9ac"),
groups = c("WE","RE"),
choice = 2,
choice2group = "WE",
title = "Distribution of percentage of cell types overlapping with
a factor in various combinations of epigenetic marks in the
selected group",
groupinfo = groupinfo)
```

![](data:image/png;base64...)

The above set of boxplots indicates that most of the epigenetic factors in Widely expressed TSSs (“WE”) are present with other factors. This gives us an indication of the interplay between various epigenetic marks

### 3.4.2 chart\_correlation()

This function creates pairwise correlation and scatter plots and histogram on selected groups. The type of results should be passed through the argument `choice`. This is a wrapper function on various functions and thus can take additional and non-conflicting arguments specific to them.

Summary of choices

| choice | functions | output |
| --- | --- | --- |
| table | cor {stats} | correlation table |
| scatter | pairs {graphics} | scatterplot of each pair |
| hist | ggplot,geom\_histogram,facet\_wrap{ggplot2} | histogram of each column |
| all | chart.Correlation {PerformanceAnalytics} | all of the above together |

```
groups <- c("WE")
chart_correlation(name = multi_assay, Assay = "H2az",
groups = "WE", choice = "scatter", groupinfo = groupinfo)
```

![](data:image/png;base64...)

All the correlation scatterplots of TSSs in “WE” looks similarly shaped except the ones coming from Hepg2. This is an indication that H2az pattern of the expression group “WE” is different in Hepg2 than other 4 cell lines.

The correlation value between each pair of cell lines may be calculated by `choice` = table. The slight difference in Hepg2 is visible here also.

```
chart_correlation(name = multi_assay,
Assay = "H2az",
groups = "WE", choice = "table",
groupinfo = groupinfo)
#           Gm12878     Hepg2      Hsmm      K562   Osteobl
# Gm12878 1.0000000 0.4631833 0.5542564 0.5637424 0.5693692
# Hepg2   0.4631833 1.0000000 0.4421005 0.4324214 0.4609538
# Hsmm    0.5542564 0.4421005 1.0000000 0.5003985 0.6742468
# K562    0.5637424 0.4324214 0.5003985 1.0000000 0.5058489
# Osteobl 0.5693692 0.4609538 0.6742468 0.5058489 1.0000000
```

The diversion of hepg2 is more evident when plotted as a histogram. The mode of “WE” is close to 0 in Hepg2 compared to other cell lines. This indicates that most of the “WE” in Hepg2 do not have H2az marks on them.

```
chart_correlation(name = multi_assay, Assay = "H2az",
groups = "WE", choice = "hist", bins = 10,
groupinfo = groupinfo)
```

![](data:image/png;base64...)

All the above 3 plots can be plotted in a single plot

```
chart_correlation(name = multi_assay, Assay = "H2az",
groups = "WE", choice = "all",
groupinfo = groupinfo)
```

![](data:image/png;base64...)

## 3.5 Integration of Multiple Cell lines

If an assay (e.g. ChIP-seq for the histone modification of type H3k9ac) is done on multiple cells/conditions/treatment/time, it might be, sometimes, necessary to integrate or combine them, in order to understand the source of variation or to calculate a common metric to be served as the representative of all variables etc. Such a combination may be done by several techniques like Principal Component Analysis (PCA) or Factor Analysis (FA). OMICsPCA has a function **integrate\_variables()** to integrate data from multiple cells or conditions using PCA.

***integrate\_variables()*** takes 3 mandatory inputs:

1. **Assays**: name of the assays read in the **MultiAssayExperiment** object
2. **name**: name of the **MultiAssayExperiment** object containing the assays to be integrated.
3. **groups**: a full set or subset of groups present in **groupinfo** object. The group names should be provided as a vector string. e.g. c(“WE” ,“RE”)

***integrate\_variables()*** runs PCA on the assays/data modalities supplied through the `Assays` argument.This function is a wrapper around the function PCA() from package FactoMineR and thus can take additional arguments specific to the function PCA()

In this example, we supply two more additional arguments **scale.unit = FALSE** and **graph = FALSE**

This function returns a list containing the PCA results.

```
PCAlist <- integrate_variables(Assays = c("H2az","H3k4me1",
"H3k9ac"), name = multi_assay,
groups = c("WE","RE", "NE", "IntE"), groupinfo = groupinfo,
scale.unit = FALSE, graph = FALSE)
```

## 3.6 Analysis of integrated data

The **analyse\_vaiables()** function is designed for a quick analysis and visualization of the data integrated by integrate\_variables() function. It takes 3 compulsory arguments **1) name**, **2) Assay** and **3) choice**. The type of analysis should be selected through the `choice` argument. This function acts as a wrapper around a collection of functions of package “factoextra” and “corrplot” and thus can take additional arguments specific and non-conflicting to such functions. Types of analysis and their corresponding input in `choice` are listed below:

**Note:** `PC` argument is mandatory for `choice` 4 and 5. (PC = principal component)

**Note:** User may use the functions listed below directly to supply more graphical parameters (e.g. `ncp` in choice 1, i.e. in fviz\_eig, to restrict the display of the number of dimensions or use `select.var` in choice 2 to select columns/variables/cell lines satisfying some condition.). use `?` followed by the function name listed in the above table to explore more options available for each choice of “analyse\_variables()”.

available choices

| choice | graphical output | console output | function used | | package | additional arguments |
| --- | --- | --- | --- | --- | --- |
| 1 | Barplot of variance explained by each principal component (PC) or dimension | | Table of eigen values and corresponding variance | | fviz\_eig | | factoextra | | addlabels |
| 2 | Loadings (in terms of cos2, contrib or coord supplied through the argument var\_type) of columns/variables (cell lines in this example) on PC1 and PC2 | | Table of loadings in terms of coord, cos2 or contrib as supplied through the argument var\_ty | e | fviz\_pca\_var | | factoextra | | var\_type |
| 3 | Matrix plot of correlations of each column/variable (Cell line in this example) with each PC | | Table of correlations of variables (Cell lines) with PCs/Dimensions | | corrplot | | factoextra and corrplo | | is.corr |
| 4 | Barplot of squarred loadings (or cos2) of each column/variable (cell line in this example) on the PC/dimension of choice | | Table of squarred loadings/cos2 of each variable (Cell line) on the PCs/ Dimensions | | fviz\_cos2 | | factoextra | | PC |
| 5 | The contributions of each column/variable (cell line in this example) in accounting for the variability in a given PC/dimension. The contribution (in percentage) is calculated as : squared loading of the variable (e.g. a cell line) \* 100 / total squared loading of the given PC/dimen | ion | Table of contribution of each variable on the selected PC/Dimension | | fviz\_contr | b | factoextra | | PC |
| 6 | Variance explained by each of the first few PCs together with barplot explaining total variance explained by the displayed PCs in each assay | | None | | ggplot, plot\_gri | | ggplot2, cowplot | | various graphical arguments to ggplot2 and cowplot function |

Here are some examples of different choices:

### 3.6.1 choice = 1

Barplot of variance explained by each principal component (PC) or dimension

```
analyse_variables(name = PCAlist, Assay = "H2az", choice = 1,
title = "variance barplot", addlabels = TRUE)
# Warning in geom_bar(stat = "identity", fill = barfill, color = barcolor, :
# Ignoring empty aesthetic: `width`.
```

![](data:image/png;base64...)

```
#       eigenvalue variance.percent cumulative.variance.percent
# Dim.1  35.779393        83.305644                    83.30564
# Dim.2   2.639572         6.145752                    89.45140
# Dim.3   1.787209         4.161183                    93.61258
# Dim.4   1.541631         3.589401                    97.20198
# Dim.5   1.201736         2.798019                   100.00000
```

83.3 % of variation is captured by PC1 alone, which indicates that 5 cell lines are very similar to one another. However, there may be the influence of the huge number of “NE” (see integrate\_variables() step). Therefore doing this analysis might be worth on each individual expression group.

### 3.6.2 choice = 2

```
analyse_variables(name = PCAlist, Assay = "H3k4me1",choice = 2,
title = "Loadings of cell lines on PC1 and PC2", xlab = "PCs")
# Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
# ℹ Please use `linewidth` instead.
# ℹ The deprecated feature was likely used in the ggpubr package.
#   Please report the issue at <https://github.com/kassambara/ggpubr/issues>.
# This warning is displayed once every 8 hours.
# Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
# generated.
```

![](data:image/png;base64...)

```
#              Dim.1       Dim.2       Dim.3      Dim.4      Dim.5        Dim.6
# Gm12878  1.6122501  0.07547622  0.36835090  2.4284811 51.4717421 40.315062978
# H1hesc   1.5266506  0.02547903  0.53455825  1.4913785  2.6823855  0.828927010
# Hmec    16.1611363  0.30279710 33.70752633  3.2831916  1.6894946  0.483017979
# Hsmm     3.6874185  2.15453027  0.07828379 11.7724181  2.1749222  8.809164528
# Hsmmt    3.4691140  2.28192948  0.18369298 16.9958418  3.6659963 15.751292720
# Huvec   10.4436967  1.41658682 16.19028015 50.5689254 12.8392675  5.489527201
# K562    17.2569846 78.93580791  1.00403525  0.6481982  0.2682735  0.008995178
# Nha     13.8628626  2.33736031  2.44025845  0.5796352  0.5178672  1.463454402
# Nhek    11.5221725  3.09780299 26.27831808  2.4563523  0.6874715  1.943600174
# Nhlf     3.5818397  1.45169741  0.35898153  5.3904567  0.7152927  1.776931840
# Osteobl 16.3047489  7.85274807 18.54098951  2.3396086 21.6769279 22.348353163
# Nt2d1    0.5711254  0.06778439  0.31472477  2.0455125  1.6103591  0.781672826
#                Dim.7       Dim.8       Dim.9       Dim.10       Dim.11
# Gm12878  0.106080568  2.80435698  0.60963169 2.014637e-01  0.005936925
# H1hesc  23.530092378 27.87809070 23.00036062 3.597760e+00 14.559723336
# Hmec     5.251661572 31.11659053  7.94529318 4.828593e-02  0.001014659
# Hsmm     4.696128343  0.63685688  0.00421789 1.969276e+00  0.089383167
# Hsmmt   11.527108397  1.81117415  0.63102455 2.294400e+01  0.002172222
# Huvec    1.419317375  0.02773966  1.51420176 4.444542e-02  0.044402812
# K562     1.549245247  0.03621791  0.18588650 1.631878e-04  0.103230182
# Nha     31.030361268  0.02063827 44.27677390 2.799019e+00  0.670878054
# Nhek    17.543335232 29.75569789  6.61326787 7.677415e-02  0.005607470
# Nhlf     0.004438558  0.06598961  0.17687757 6.421933e+01  7.761651267
# Osteobl  0.948431674  0.02381584  9.53974191 2.355337e-01  0.175006347
# Nt2d1    2.393799388  5.82283157  5.50272257 3.863944e+00 76.580993559
#               Dim.12
# Gm12878 1.166628e-03
# H1hesc  3.445938e-01
# Hmec    9.990303e-03
# Hsmm    6.392740e+01
# Hsmmt   2.073665e+01
# Huvec   1.609120e-03
# K562    2.962405e-03
# Nha     8.912644e-04
# Nhek    1.959976e-02
# Nhlf    1.449651e+01
# Osteobl 1.409443e-02
# Nt2d1   4.445297e-01
```

Loadings of each variable (here the cell lines) explain the intensity of their correlation with principal components. Each Cell line(variable) has a loading on each principal components, which is calculated as: **Loadings = Eigenvectors x sqrt(Eigenvalues)**.

In the above plot, the loading is expressed as the contribution of each cell lines on PC 1 and 2. Although the contribution of K562 is very high in PC1, its direction indicates its strong correlation with other PCs (PC2). On the other hand, Hmec, Huvec, Nha, Nhek and Osteobl are highly correlated only with PC1. The small value (hence the small arrows) of the contribution of other cell lines with PC1 indicates they might be correlated with other PCs also. This is more clearly explained when the plot is studied with the table generated by this command simultaneously.

### 3.6.3 choice = 3

As explained in “chart\_correlation()”, Hepg2 is slightly different than other cell lines, and this is evident in the correlation plot also.

```
analyse_variables(name = PCAlist, Assay = "H2az",
choice = 3,title = "Correlation matrix", xlab = "PCs")
```

![](data:image/png;base64...)

```
# $corr
#             Dim.1       Dim.2       Dim.3       Dim.4         Dim.5
# Gm12878 0.9257715  0.09106662  0.01566028 -0.35624071 -0.0866104415
# Hepg2   0.7485728  0.08655067  0.64588121  0.09860930  0.0725360565
# Hsmm    0.9401016 -0.18374599 -0.08173410 -0.01104782  0.2750341646
# K562    0.8968137  0.39775752 -0.11549647  0.15548198 -0.0001868809
# Osteobl 0.9418103 -0.25031371 -0.02302760  0.12489507 -0.1849523974
#
# $corrPos
#    xName   yName x y          corr
# 1  Dim.1 Gm12878 1 5  0.9257714700
# 2  Dim.1   Hepg2 1 4  0.7485727529
# 3  Dim.1    Hsmm 1 3  0.9401016447
# 4  Dim.1    K562 1 2  0.8968137170
# 5  Dim.1 Osteobl 1 1  0.9418102819
# 6  Dim.2 Gm12878 2 5  0.0910666238
# 7  Dim.2   Hepg2 2 4  0.0865506679
# 8  Dim.2    Hsmm 2 3 -0.1837459897
# 9  Dim.2    K562 2 2  0.3977575158
# 10 Dim.2 Osteobl 2 1 -0.2503137143
# 11 Dim.3 Gm12878 3 5  0.0156602810
# 12 Dim.3   Hepg2 3 4  0.6458812134
# 13 Dim.3    Hsmm 3 3 -0.0817340989
# 14 Dim.3    K562 3 2 -0.1154964749
# 15 Dim.3 Osteobl 3 1 -0.0230275965
# 16 Dim.4 Gm12878 4 5 -0.3562407085
# 17 Dim.4   Hepg2 4 4  0.0986093009
# 18 Dim.4    Hsmm 4 3 -0.0110478221
# 19 Dim.4    K562 4 2  0.1554819762
# 20 Dim.4 Osteobl 4 1  0.1248950672
# 21 Dim.5 Gm12878 5 5 -0.0866104415
# 22 Dim.5   Hepg2 5 4  0.0725360565
# 23 Dim.5    Hsmm 5 3  0.2750341646
# 24 Dim.5    K562 5 2 -0.0001868809
# 25 Dim.5 Osteobl 5 1 -0.1849523974
#
# $arg
# $arg$type
# [1] "full"
```

### 3.6.4 choice = 4

This choice depicts the message interpreted above more clearly.

```
analyse_variables(name = PCAlist, Assay = "H2az",
choice = 4,PC = 1,
title = "Squarred loadings of Cell lines on PC1")
#             Dim.1       Dim.2        Dim.3        Dim.4        Dim.5
# Gm12878 0.8570528 0.008293130 0.0002452444 0.1269074424 7.501369e-03
# Hepg2   0.5603612 0.007491018 0.4171625418 0.0097237942 5.261479e-03
# Hsmm    0.8837911 0.033762589 0.0066804629 0.0001220544 7.564379e-02
# K562    0.8042748 0.158211041 0.0133394357 0.0241746449 3.492447e-08
# Osteobl 0.8870066 0.062656956 0.0005302702 0.0155987778 3.420739e-02
```

![](data:image/png;base64...)

### 3.6.5 choice = 5

The contribution (in percentage) is calculated as: squared loading of the variable(e.g. a cell line) \* 100 / total squared loading of the given PC/dimension. This is another way to represent similar message we got from choice 2

```
analyse_variables(name = PCAlist, Assay = "H2az",
choice = 5,PC=1,
title = "Contribution of Cell lines on PC1")
```

![](data:image/png;base64...)

```
#             Dim.1     Dim.2      Dim.3       Dim.4        Dim.5
# Gm12878 20.686358  2.713278  0.1185040 71.09121587 5.390644e+00
# Hepg2    5.964017  1.080715 88.8860882  2.40192278 1.667257e+00
# Hsmm    23.693083 12.268941  3.5853877  0.07594124 6.037665e+01
# K562    21.294342 56.780069  7.0705762 14.85498595 2.753045e-05
# Osteobl 28.362200 27.156997  0.3394438 11.57593416 3.256542e+01
```

### 3.6.6 choice = 6

Percentage of variance explained by principal components in all the selected assays. The number of PCs is automatically reduced to the column dimension of the assay having the least number of cell lines (and thus least number of PCs or dimensions)

```
analyse_variables(name = PCAlist,
Assay = c("H3k9ac","H2az",
"H3k4me1"), choice = 6)
# Using PC as id variables
# Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
# ℹ Please use tidy evaluation idioms with `aes()`.
# ℹ See also `vignette("ggplot2-in-packages")` for more information.
# ℹ The deprecated feature was likely used in the OMICsPCA package.
#   Please report the issue to the authors.
# This warning is displayed once every 8 hours.
# Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
# generated.
# Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
# ℹ Please use the `linewidth` argument instead.
# ℹ The deprecated feature was likely used in the OMICsPCA package.
#   Please report the issue to the authors.
# This warning is displayed once every 8 hours.
# Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
# generated.
```

![](data:image/png;base64...)

## 3.7 Analysis of individuals/annotations from integrated data

We can take the projection of each TSS on the principal components and plot them on the space of PCs.

### 3.7.1 choice = 1

```
analyse_individuals(name = PCAlist,
Assay = "H3k9ac", groupinfo = groupinfo,
choice = 1, PC = c(1,2))
# Ignoring unknown labels:
# • fill : "Groups"
# • linetype : "Groups"
```

![](data:image/png;base64...)

The TSSs on the PC space appears bimodal, indicating two broad groups of TSSs in terms of H3k4me1 overlap on them.

Now, let’s look at some top rows/TSSs according to some conditions like their contribution to selected PCs (contrib)

```
# selecting top 40 TSS groups according to their contribution on
# PC 1 and PC 2 using the argument "select.ind"

selected <- analyse_individuals(name = PCAlist,
Assay = "H3k4me1",
choice = 1, PC = c(1,2),
select.ind = list(contrib = 100),
groupinfo = groupinfo)

# plot selected individuals
plot(selected)
# Ignoring unknown labels:
# • fill : "Groups"
# • linetype : "Groups"
```

![](data:image/png;base64...)

```
# extracted information of the selected individuals
head(selected$data)
# # A tibble: 6 × 7
#   name                  x     y coord  cos2 contrib Col.
#   <fct>             <dbl> <dbl> <dbl> <dbl>   <dbl> <chr>
# 1 ENST00000419582.1  21.4  2.99  469. 0.835  0.0127 NE
# 2 ENST00000432651.1  21.4  2.99  469. 0.835  0.0127 NE
# 3 ENST00000435132.1  21.4  2.99  469. 0.835  0.0127 RE
# 4 ENST00000434095.1  21.4  2.99  469. 0.835  0.0127 IntE
# 5 ENST00000423100.1  20.8  2.87  443. 0.844  0.0120 RE
# 6 ENST00000524946.2  20.8  2.87  443. 0.844  0.0120 IntE
```

Let’s mine some information about these selected TSSs.

```
# The TSSs used in this example (each row) are obtained by combining
# many neighboring TSSs together. The combinations should be uncombined
# to find the corresponding annotations.

names  <- gsub(";",",",paste(as.character(selected$data$name),
                             collapse = ","))

names <- as.vector(strsplit(names, ",", fixed = TRUE)[[1]])

## The top 100 combined TSS_groups actually come from 115 TSSs

length(names)
# [1] 115

# retrieve details of top 100 individuals
# transcript details contains the GENCODE v 17
# annotation of TSSs.

details <- transcript_details[
transcript_details$transcript_id %in% names,,drop = FALSE]

head(details)
# # A tibble: 6 × 8
#   gene_id          transcript_id gene_type gene_status gene_name transcript_type
#   <fct>            <fct>         <fct>     <fct>       <fct>     <fct>
# 1 ENSG00000116809… ENST00000494… protein_… KNOWN       ZBTB17    processed_tran…
# 2 ENSG00000142627… ENST00000480… protein_… KNOWN       EPHA2     processed_tran…
# 3 ENSG00000142669… ENST00000270… protein_… KNOWN       SH3BGRL3  protein_coding
# 4 ENSG00000163874… ENST00000472… protein_… KNOWN       ZC3H12A   retained_intron
# 5 ENSG00000183386… ENST00000483… protein_… KNOWN       FHL3      processed_tran…
# 6 ENSG00000188396… ENST00000339… protein_… NOVEL       TCTEX1D4  protein_coding
# # ℹ 2 more variables: transcript_status <fct>, transcript_name <fct>

## checking the gene type

table(details$gene_type)
#
# 3prime_overlapping_ncrna                antisense                IG_C_gene
#                        0                        7                        0
#          IG_C_pseudogene                IG_D_gene                IG_J_gene
#                        0                        0                        0
#          IG_J_pseudogene                IG_V_gene          IG_V_pseudogene
#                        0                        0                        0
#                  lincRNA                    miRNA                 misc_RNA
#                        4                        2                        0
#                  Mt_rRNA                  Mt_tRNA   polymorphic_pseudogene
#                        0                        0                        0
#     processed_transcript           protein_coding               pseudogene
#                        4                       97                        1
#                     rRNA           sense_intronic        sense_overlapping
#                        0                        0                        0
#                   snoRNA                    snRNA                TR_C_gene
#                        0                        0                        0
#                TR_D_gene                TR_J_gene          TR_J_pseudogene
#                        0                        0                        0
#                TR_V_gene          TR_V_pseudogene
#                        0                        0
```

We can do various analysis with the gene name or id. Here is an example:

```
# find GO annotation

library(clusterProfiler)
library(org.Hs.eg.db)

gene <- details$gene_name

gene.df <- bitr(gene, fromType = "SYMBOL",
                toType = c("ENSEMBL", "ENTREZID"),
                OrgDb = org.Hs.eg.db)

ggo <- groupGO(gene     = unique(gene.df$ENTREZID),
               OrgDb    = org.Hs.eg.db,
               ont      = "MF",
               level    = 5,
               readable = TRUE)

# If we want to see the top results, we need to reorder
#the list. So, the following line is strictly optional.

#ggo@result <- ggo@result[order(-ggo@result$Count),]
#head(ggo@result)

# The barplot may not fit to the Rstudio window, therefore
# we may plot it in a different window

#grDevices::windows()
#barplot(ggo, drop=TRUE, showCategory=20)
```

There are many packages that do a similar kind of analysis. We encourage to visit the website of **clusterProfiler** to check the available analyses by this package.

***NOTE:***  If we need to see some top individuals from a specific expression group, then we should select that group only in “integrate\_variables()” function call.

We can draw a similar plot in 3D also.

### 3.7.2 choice = 2

```
analyse_individuals(name = PCAlist, Assay = "H3k9ac",
choice = 2, PC = c(1,2,3),
col = c("RED", "BLACK"), groupinfo = groupinfo)
```

## 3.8 Density analysis

The scatter plot of data points (here, rows/TSSs/individuals) may be highly disorganized. In such a situation, we may take the help of density functions to understand the overall structure of the dataset.

Once the cell lines of an assay are integrated into PCs, we may check the density distribution of scores on various principal components. OMICsPCA has a function ***plot\_desnity()*** to calculate and plot the density distribution of PC scores. This function uses ggplot(), geom\_density() and other additional functions from package ggplot2. Additional arguments of geom\_density (e.g. `adjust`) may be also supplied through this function. The returned value is a “gg,ggplot” object.

Such kind of analysis may help us to choose factors (e.g. H2az, H3k4me1) that can discriminate between various groups (e.g. our expression groups “WE”, “RE”, “NE” and “IntE”).

**NOTE :** the `groups` argument should not contain a value that is not used in **integrate\_variables**.

### 3.8.1 1D plots

Here is a discriminatory factor:

```
#head(groupinfo)
densityplot <- plot_density(name = PCAlist,
Assay = "H2az", groupinfo = groupinfo,
PC = 1, groups = c("WE","RE","IntE"),
adjust = 1)
```

![](data:image/png;base64...)

Density plots can be modified using other graphical functions like xlim(), theme() etc.

```
library(ggplot2)
library(graphics)

densityplot <- densityplot+xlim(as.numeric(c("-8", "23")))
densityplot
```

![](data:image/png;base64...)

and here is a non-discriminatory factor:

```
densityplot <- plot_density(name = PCAlist, Assay = "H3k4me1",
PC = 1, groups = c("WE" ,"RE"), adjust = 2,
groupinfo = groupinfo)
```

![](data:image/png;base64...)

```
densityplot <- densityplot+xlim(as.numeric(c("-8", "15")))

print(densityplot)
# Warning: Removed 163 rows containing non-finite outside the scale range
# (`stat_density()`).
```

![](data:image/png;base64...)

### 3.8.2 3D plots

OMICsPCA also has a function to visualize the density the scores on 2 principal components together in 3D

#### 3.8.2.1 static = FALSE

If `static` is set to “FALSE” the function opens the interactive 3D density plot in a new window.

```
plot_density_3D(name = PCAlist, Assay = "H2az",
group = "WE", PC1 = 1,PC2 = 2, grid_size = 100,
groupinfo = groupinfo,
static = FALSE)
```

#### 3.8.2.2 static = TRUE

If `static` is set to “TRUE”, some additional graphical parameters may be supplied

```
plot_density_3D(name = PCAlist, Assay = "H2az", group = "WE",
groupinfo = groupinfo,
PC1 = 1,PC2 = 2, grid_size = 100, static = TRUE, theta = -50,
phi = 40, box = TRUE, shade = 0.1, ticktype = "detailed", d = 10)
# Warning in persp.default(x = bivn.kde, col = col1, xlab = labx, ylab = laby, :
# "grid_size" is not a graphical parameter
```

![](data:image/png;base64...)

**NOTE :** 2D density is calculated using the **kde2d** function from package **MASS** which use kernel density estimation (KDE) to calculate the density of 2D data. Now, if the variance on either or both of the PCs are 0, the KDE can’t be calculated.

## 3.9 Integration of multiple assays/ modalities

Once the discriminatory Assays between the groups are identified by previous analyses, we may integrate all such assays together.

```
Assays = c("H2az", "H3k9ac")
```

In this process it is possible to observe that some variables (Cell lines) are not similar to others and thus can be excluded :

```
exclude <- list(0,c(1,9))
```

The length of the list “exclude” should be equal to the Number of assays (i.e. length of “Assays”“). If no columns are selected for exclusion, a”0" should be placed in the “exclude” list. In the above example, we are excluding none of the columns from “H2az” and column 1 and 9 from “H3k9ac”

The integration of multiple assays is handled by **integrate\_pca** function in OMICsPCA. It works in 2 modes:

1. runs PCA on selected groups
2. runs PCA on all individuals (e.g. annotations: gene, TSS etc.)

The type of merging the assays should be entered by the argument `mergetype`

**integrate\_pca()** returns a list of 2 elements containing 1) the start and end column of each Assay in the integrated Assay

2. and the integrated PCA results

```
int_PCA <- integrate_pca(Assays = c("H2az",
"H3k9ac"),
groupinfo = groupinfo,
name = multi_assay, mergetype = 2,
exclude = exclude, graph = FALSE)
```

if `mergetype` is set to 1, then **integrate\_pca** asks for the name of groups to be integrated.

```
Enter a vector of strings containing group names:
```

Here is an example of the allowed input

```
Enter a vector of strings containing group names: c("WE","RE")
```

Let’s split the output into different variables

```
start_end = int_PCA$start_end

name = int_PCA$int_PCA
```

  ## Analysis of integrated data

All the analyses on variables and individuals of integrated Assays are designed to be done by the functions **analyse\_integrated\_variables()** and **analyse\_integrated\_individuals()**. These functions work similarly as **analyse\_variables()** and **analyse\_individuals()** described in section **3.6** and **3.7**. The only difference between the analyses in section **3.6** and **3.7** is that in those sections multiple cell lines from a single type of assay were integrated. Whereas, the analyses described in this section will be on multiple assays or modalities.

### 3.9.1 Analyses of variables

The extra argument needs to be supplied in **analyse\_integrated\_variables()** is `start_end` which is the returned value by **integrate\_pca()**.

The `Assay` argument works a little bit differently here. it takes the number corresponding to the order of assays used in the `Assays` argument of **integrate\_pca()**. For example, in the above example `Assays` = c(“H2az”, “H3k9ac”). So here `Assay` = 1 indicates to “H2az” and 2 = “H3k9ac”

The default argument set to `Assay` is “all”, which show analyses on full integrated assays. Here are some examples:

#### 3.9.1.1 choice = 1

```
analyse_integrated_variables(start_end = start_end, name = name,
choice = 1, title = "variance barplot", Assay = 1, addlabels = TRUE)
# Warning in geom_bar(stat = "identity", fill = barfill, color = barcolor, :
# Ignoring empty aesthetic: `width`.
```

![](data:image/png;base64...)

```
#        eigenvalue variance.percent cumulative.variance.percent
# Dim.1  11.2785626       70.4910162                    70.49102
# Dim.2   0.8238060        5.1487873                    75.63980
# Dim.3   0.6662760        4.1642251                    79.80403
# Dim.4   0.4757188        2.9732428                    82.77727
# Dim.5   0.4634762        2.8967263                    85.67400
# Dim.6   0.3769878        2.3561736                    88.03017
# Dim.7   0.2944345        1.8402155                    89.87039
# Dim.8   0.2854485        1.7840531                    91.65444
# Dim.9   0.2348603        1.4678766                    93.12232
# Dim.10  0.2063641        1.2897757                    94.41209
# Dim.11  0.2040527        1.2753297                    95.68742
# Dim.12  0.1681539        1.0509619                    96.73838
# Dim.13  0.1558582        0.9741139                    97.71250
# Dim.14  0.1534076        0.9587973                    98.67129
# Dim.15  0.1106141        0.6913379                    99.36263
# Dim.16  0.1019787        0.6373671                   100.00000
```

A large part of the total variance in the 2 assays (H2az and H3k9ac) are captured by PC1 alone. This indicates that these two Histone modifications are very similar and this is followed by most of the cell lines. Remember the `mergetype` was set to 2 in **integrate\_pca()**, which uses all the groups **(“WE”, “RE”, “NE”,“IntE”)** . This analysis may overshadow the true structure of data due to a strong influence of “NE”, coming from their large number. So redoing the analysis on smaller groups (use `mergetype` = 1 in integrate\_pca()) may be useful in this context.

#### 3.9.1.2 choice = 2

```
analyse_integrated_variables(start_end = start_end, Assay = 1,
name = name, choice = 2 ,
title = "Loadings of cell lines on PC1 and PC2",
var_type = "contrib")
```

![](data:image/png;base64...)

```
#            Dim.1      Dim.2     Dim.3       Dim.4      Dim.5      Dim.6
# Gm12878 7.019011  1.2022488  4.363976 0.291303442  1.9215282  4.6885934
# Hepg2   4.393136 11.1677691 39.321690 0.000174136  1.5736144 23.4659659
# Hsmm    7.301528  0.1798474  2.212726 0.368788009  6.7670216  2.1489352
# K562    6.377948  2.1539977  5.903030 0.341823532  0.4280165  8.4930567
# Osteobl 6.939920  0.6948640  4.231786 0.553465147 11.1108419  0.2422759
#              Dim.7        Dim.8     Dim.9       Dim.10   Dim.11       Dim.12
# Gm12878  3.7985466  0.063925338 0.1367839 3.538108e-03 8.438047 53.461394565
# Hepg2    7.1821780  8.436740487 1.7452647 6.803953e-04 2.551384  0.001205519
# Hsmm     1.7167732  6.699253439 8.4147624 2.608879e+00 1.240043  0.573802616
# K562    38.2841992  0.001052331 7.6878611 1.426352e+01 2.104304 13.829331294
# Osteobl  0.5608388 10.062792723 8.5792964 7.950644e+00 1.982927  4.834482288
#              Dim.13      Dim.14       Dim.15      Dim.16
# Gm12878 14.24693821 0.002776747 2.371410e-01  0.12424788
# Hepg2    0.11738886 0.005801164 2.622110e-03  0.03438516
# Hsmm     0.89098246 3.173102481 3.667644e+01 19.02711452
# K562     0.03768112 0.073091240 2.339767e-06  0.02108900
# Osteobl  7.16367507 1.044890125 1.989426e+01 14.15303909
```

We can see that almost all the cell lines are very strongly correlated with PC1. So PC1 of the integrated assays may be a representation of H2az. If we repeat this analysis for other assays, we may find out a strong correlation of multiple assays with a single PC. If this happens, we may conclude that those Assays are similar to one another. However, they may differ in various groups and cell lines under study. Therefore, the `exclude` argument in **integrate\_pca** should be carefully chosen in order to exclude non-related cell types.

#### 3.9.1.3 choice = 3

```
analyse_integrated_variables(start_end = start_end, Assay = 1,
name = name, choice = 3,
title = "Correlation of Cell lines with PCs of integrated Assays",
is.cor = TRUE)
```

![](data:image/png;base64...)

```
# $corr
#             Dim.1       Dim.2     Dim.3         Dim.4       Dim.5       Dim.6
# Gm12878 0.8897436 -0.09951983 0.1705172  0.0372261383 -0.09437068 -0.13294895
# Hepg2   0.7039052 -0.30331625 0.5118506 -0.0009101637  0.08540099  0.29742869
# Hsmm    0.9074731 -0.03849147 0.1214202  0.0418854875 -0.17709753 -0.09000679
# K562    0.8481397 -0.13320947 0.1983191  0.0403251654 -0.04453936 -0.17893514
# Osteobl 0.8847165 -0.07565931 0.1679148  0.0513121625 -0.22692754 -0.03022169
#               Dim.7        Dim.8       Dim.9       Dim.10      Dim.11
# Gm12878 -0.10575552 -0.013508290  0.01792347  0.002702108 -0.13121763
# Hepg2    0.14541942  0.155185529 -0.06402291  0.001184944  0.07215379
# Hsmm     0.07109692 -0.138285638  0.14058070 -0.073374309  0.05030250
# K562    -0.33574080 -0.001733166 -0.13437161  0.171565664  0.06552779
# Osteobl  0.04063622 -0.169481827  0.14194843 -0.128090890 -0.06360988
#               Dim.12       Dim.13       Dim.14        Dim.15       Dim.16
# Gm12878 -0.299828990 -0.149013504  0.002063914  1.619603e-02  0.011256395
# Hepg2    0.001423772 -0.013526278  0.002983190  1.703063e-03 -0.005921617
# Hsmm     0.031062381  0.037264855 -0.069769474 -2.014182e-01 -0.139296847
# K562     0.152494462  0.007663493  0.010589027 -5.087348e-05 -0.004637489
# Osteobl  0.090163024  0.105665399  0.040036741  1.483437e-01  0.120137799
#
# $corrPos
#     xName   yName  x y          corr
# 1   Dim.1 Gm12878  1 5  8.897436e-01
# 2   Dim.1   Hepg2  1 4  7.039052e-01
# 3   Dim.1    Hsmm  1 3  9.074731e-01
# 4   Dim.1    K562  1 2  8.481397e-01
# 5   Dim.1 Osteobl  1 1  8.847165e-01
# 6   Dim.2 Gm12878  2 5 -9.951983e-02
# 7   Dim.2   Hepg2  2 4 -3.033163e-01
# 8   Dim.2    Hsmm  2 3 -3.849147e-02
# 9   Dim.2    K562  2 2 -1.332095e-01
# 10  Dim.2 Osteobl  2 1 -7.565931e-02
# 11  Dim.3 Gm12878  3 5  1.705172e-01
# 12  Dim.3   Hepg2  3 4  5.118506e-01
# 13  Dim.3    Hsmm  3 3  1.214202e-01
# 14  Dim.3    K562  3 2  1.983191e-01
# 15  Dim.3 Osteobl  3 1  1.679148e-01
# 16  Dim.4 Gm12878  4 5  3.722614e-02
# 17  Dim.4   Hepg2  4 4 -9.101637e-04
# 18  Dim.4    Hsmm  4 3  4.188549e-02
# 19  Dim.4    K562  4 2  4.032517e-02
# 20  Dim.4 Osteobl  4 1  5.131216e-02
# 21  Dim.5 Gm12878  5 5 -9.437068e-02
# 22  Dim.5   Hepg2  5 4  8.540099e-02
# 23  Dim.5    Hsmm  5 3 -1.770975e-01
# 24  Dim.5    K562  5 2 -4.453936e-02
# 25  Dim.5 Osteobl  5 1 -2.269275e-01
# 26  Dim.6 Gm12878  6 5 -1.329490e-01
# 27  Dim.6   Hepg2  6 4  2.974287e-01
# 28  Dim.6    Hsmm  6 3 -9.000679e-02
# 29  Dim.6    K562  6 2 -1.789351e-01
# 30  Dim.6 Osteobl  6 1 -3.022169e-02
# 31  Dim.7 Gm12878  7 5 -1.057555e-01
# 32  Dim.7   Hepg2  7 4  1.454194e-01
# 33  Dim.7    Hsmm  7 3  7.109692e-02
# 34  Dim.7    K562  7 2 -3.357408e-01
# 35  Dim.7 Osteobl  7 1  4.063622e-02
# 36  Dim.8 Gm12878  8 5 -1.350829e-02
# 37  Dim.8   Hepg2  8 4  1.551855e-01
# 38  Dim.8    Hsmm  8 3 -1.382856e-01
# 39  Dim.8    K562  8 2 -1.733166e-03
# 40  Dim.8 Osteobl  8 1 -1.694818e-01
# 41  Dim.9 Gm12878  9 5  1.792347e-02
# 42  Dim.9   Hepg2  9 4 -6.402291e-02
# 43  Dim.9    Hsmm  9 3  1.405807e-01
# 44  Dim.9    K562  9 2 -1.343716e-01
# 45  Dim.9 Osteobl  9 1  1.419484e-01
# 46 Dim.10 Gm12878 10 5  2.702108e-03
# 47 Dim.10   Hepg2 10 4  1.184944e-03
# 48 Dim.10    Hsmm 10 3 -7.337431e-02
# 49 Dim.10    K562 10 2  1.715657e-01
# 50 Dim.10 Osteobl 10 1 -1.280909e-01
# 51 Dim.11 Gm12878 11 5 -1.312176e-01
# 52 Dim.11   Hepg2 11 4  7.215379e-02
# 53 Dim.11    Hsmm 11 3  5.030250e-02
# 54 Dim.11    K562 11 2  6.552779e-02
# 55 Dim.11 Osteobl 11 1 -6.360988e-02
# 56 Dim.12 Gm12878 12 5 -2.998290e-01
# 57 Dim.12   Hepg2 12 4  1.423772e-03
# 58 Dim.12    Hsmm 12 3  3.106238e-02
# 59 Dim.12    K562 12 2  1.524945e-01
# 60 Dim.12 Osteobl 12 1  9.016302e-02
# 61 Dim.13 Gm12878 13 5 -1.490135e-01
# 62 Dim.13   Hepg2 13 4 -1.352628e-02
# 63 Dim.13    Hsmm 13 3  3.726485e-02
# 64 Dim.13    K562 13 2  7.663493e-03
# 65 Dim.13 Osteobl 13 1  1.056654e-01
# 66 Dim.14 Gm12878 14 5  2.063914e-03
# 67 Dim.14   Hepg2 14 4  2.983190e-03
# 68 Dim.14    Hsmm 14 3 -6.976947e-02
# 69 Dim.14    K562 14 2  1.058903e-02
# 70 Dim.14 Osteobl 14 1  4.003674e-02
# 71 Dim.15 Gm12878 15 5  1.619603e-02
# 72 Dim.15   Hepg2 15 4  1.703063e-03
# 73 Dim.15    Hsmm 15 3 -2.014182e-01
# 74 Dim.15    K562 15 2 -5.087348e-05
# 75 Dim.15 Osteobl 15 1  1.483437e-01
# 76 Dim.16 Gm12878 16 5  1.125639e-02
# 77 Dim.16   Hepg2 16 4 -5.921617e-03
# 78 Dim.16    Hsmm 16 3 -1.392968e-01
# 79 Dim.16    K562 16 2 -4.637489e-03
# 80 Dim.16 Osteobl 16 1  1.201378e-01
#
# $arg
# $arg$type
# [1] "full"
```

A Similar message is appearing here as observed in `choice` = 1. Hepg2 in H2az is relatively less correlated with PC1 and more with other PCs (Dim), indicating that it should be excluded by `exclude` argument of integrate\_pca()

#### 3.9.1.4 choice = 4

```
analyse_integrated_variables(start_end = start_end, Assay = 1,
name = name, choice = 4, PC = 1,
title = "Squarred loadings of Cell lines on PC1 of integrated Assays")
#             Dim.1       Dim.2      Dim.3        Dim.4       Dim.5        Dim.6
# Gm12878 0.7916436 0.009904198 0.02907612 1.385785e-03 0.008905826 0.0176754239
# Hepg2   0.4954826 0.092000749 0.26199099 8.283980e-07 0.007293328 0.0884638233
# Hsmm    0.8235074 0.001481594 0.01474286 1.754394e-03 0.031363535 0.0081012231
# K562    0.7193409 0.017744762 0.03933047 1.626119e-03 0.001983755 0.0320177857
# Osteobl 0.7827232 0.005724331 0.02819537 2.632938e-03 0.051496109 0.0009133506
#               Dim.7        Dim.8        Dim.9       Dim.10      Dim.11
# Gm12878 0.011184231 1.824739e-04 0.0003212509 7.301386e-06 0.017218066
# Hepg2   0.021146808 2.408255e-02 0.0040989330 1.404092e-06 0.005206169
# Hsmm    0.005054772 1.912292e-02 0.0197629320 5.383789e-03 0.002530342
# K562    0.112721882 3.003863e-06 0.0180557298 2.943478e-02 0.004293891
# Osteobl 0.001651303 2.872409e-02 0.0201493570 1.640728e-02 0.004046217
#               Dim.12       Dim.13       Dim.14       Dim.15       Dim.16
# Gm12878 8.989742e-02 2.220502e-02 4.259741e-06 2.623114e-04 1.267064e-04
# Hepg2   2.027127e-06 1.829602e-04 8.899424e-06 2.900422e-06 3.506555e-05
# Hsmm    9.648715e-04 1.388669e-03 4.867780e-03 4.056930e-02 1.940361e-02
# K562    2.325456e-02 5.872913e-05 1.121275e-04 2.588111e-09 2.150630e-05
# Osteobl 8.129371e-03 1.116518e-02 1.602941e-03 2.200585e-02 1.443309e-02
```

![](data:image/png;base64...)

Most of the variances explained by PC1 is actually contributed by Hsmm, Gm12878,Osteobl and K562. This again indicates that Hepg2 is different from others.

#### 3.9.1.5 choice = 5

```
analyse_integrated_variables(start_end = start_end, Assay = 1,
name = name, choice = 5, PC=1,
title = "Contribution of Cell lines on PC1 of integrated Assays")
```

![](data:image/png;base64...)

```
#            Dim.1      Dim.2     Dim.3       Dim.4      Dim.5      Dim.6
# Gm12878 7.019011  1.2022488  4.363976 0.291303442  1.9215282  4.6885934
# Hepg2   4.393136 11.1677691 39.321690 0.000174136  1.5736144 23.4659659
# Hsmm    7.301528  0.1798474  2.212726 0.368788009  6.7670216  2.1489352
# K562    6.377948  2.1539977  5.903030 0.341823532  0.4280165  8.4930567
# Osteobl 6.939920  0.6948640  4.231786 0.553465147 11.1108419  0.2422759
#              Dim.7        Dim.8     Dim.9       Dim.10   Dim.11       Dim.12
# Gm12878  3.7985466  0.063925338 0.1367839 3.538108e-03 8.438047 53.461394565
# Hepg2    7.1821780  8.436740487 1.7452647 6.803953e-04 2.551384  0.001205519
# Hsmm     1.7167732  6.699253439 8.4147624 2.608879e+00 1.240043  0.573802616
# K562    38.2841992  0.001052331 7.6878611 1.426352e+01 2.104304 13.829331294
# Osteobl  0.5608388 10.062792723 8.5792964 7.950644e+00 1.982927  4.834482288
#              Dim.13      Dim.14       Dim.15      Dim.16
# Gm12878 14.24693821 0.002776747 2.371410e-01  0.12424788
# Hepg2    0.11738886 0.005801164 2.622110e-03  0.03438516
# Hsmm     0.89098246 3.173102481 3.667644e+01 19.02711452
# K562     0.03768112 0.073091240 2.339767e-06  0.02108900
# Osteobl  7.16367507 1.044890125 1.989426e+01 14.15303909
```

A total of 16 cell lines are integrated by integrate\_pca(). Therefore, the contribution of each of these 16 should be reflected on PCs, if they are of similar type. Here we see that 4 cell lines of H2az contribute around 7% to PC1. This means that PC1 is not only the representation of H2az, but the other assay H3k9ac is also represented well in PC1. However, we should redo this analysis on H3k9ac to confirm.

### 3.9.2 Analysis of integrated individuals/annotations

This is the same as the analyses done using “analyse\_individuals()”. The downstream analyses shown at section **3.7** are also applicable here.

#### 3.9.2.1 choice 1: 2D scatter plot

`PC` should contain 2 values and length(`col`) should match with length(`PC`)

```
analyse_integrated_individuals(
name = name, choice = 1, PC = c(1,2),
groupinfo = groupinfo)
# Ignoring unknown labels:
# • fill : "Groups"
# • linetype : "Groups"
```

![](data:image/png;base64...)

#### 3.9.2.2 choice 2: 3D scatter plot

`PC` should contain 3 values and length(`col`) should match with length(`PC`)

```
analyse_integrated_individuals(
name = name,
choice = 2, PC = c(1,2,3),
col = c("RED", "BLACK","GREEN"),
groupinfo = groupinfo)
```

It seems the bimodal structure observed in case of individual assays also retained in integrated assays. This structure would be more clear if seen from the angle of density.

### 3.9.3 Density analysis of integrated data

The scatter plot of data points (here, rows/TSSs/individuals) may be highly disorganized. In such a situation, we may take the help of density functions to understand the overall structure of the dataset.

#### 3.9.3.1 1D plot

```
densityplot <- plot_integrated_density(name = name, PC = 1,
groups = c("WE","RE","IntE","NE"), groupinfo = groupinfo)
```

![](data:image/png;base64...)

```
# additional graphical functions (e.g. xlim, ylim, theme) may be
#added with densityplot (see section VIII. Density analysis)

densityplot
```

![](data:image/png;base64...)

#### 3.9.3.2 3D plot

##### 3.9.3.2.1 static = TRUE

```
plot_integrated_density_3D(name = name, PC1 = 1, PC2 = 2,
group = c("RE","RE"), gridsize = 100, static = TRUE,
groupinfo = groupinfo)
```

![](data:image/png;base64...)

##### 3.9.3.2.2 static = FALSE

```
plot_integrated_density_3D(name = name, PC1 = 1, PC2 = 2,
group = c("WE","RE"), gridsize = 100, static = FALSE,
groupinfo = groupinfo)
```

The above analyses clearly indicate the presence of two broad groups according to combined epigenetic states of various expression groups. The obvious next job is to find out the TSSs in these groups.

## 3.10 Cluster Analysis

The principal components obtained by combining multiple assays represent the overall epigenetic state of each annotation (here TSSs). Our next objective is to find out groups of similar TSSs in terms of the combined epigenetic state. We will use a suitable clustering technique(s) to accomplish this job.

There are various clustering techniques available, each is designed to perform specific tasks. Most of the partition based clustering algorithms need the number of clusters as an input. From our density analysis, we observed two dense regions in the data space of PC1 and PC2. This suggests that the number of clusters should be set at 2. However, there are sophisticated indices designed to validate the number of clusters.

OMICsPCA has a function “cluster\_parameters()” to perform this job. It runs two algorithms “clvalid” and “NbClust” in the background, which in turn use different sets of validation techniques to decide the number of clusters.

“cluster\_parameters()” extracts data from the PCA the object object supplied through `name` argument via the “extract()” function. Both the algorithms used in “cluster\_parameters()” function takes huge memory and CPU for a higher number of samples. Therefore, it is recommended to use a subset of original data while running this function. A subset of rows can be selected randomly through the `rand` argument of “extract()”. The user may also choose whether to use integrated assays or nonintegrated assays through the logical argument `integrated` of the function “extract()”.

```
# extracting data from integrated PCA
data <- extract(name = name, PC = c(1:4),
groups = c("WE","RE"), integrated = TRUE, rand = 600,
groupinfo = groupinfo)

#or

# extracting PCA data from an individual assay
# if integrated = TRUE, an assay name should be entered by
# Assay == "assayname"

data <- extract(name = PCAlist, PC = c(1:4),
groups = c("WE","RE"), integrated = FALSE, rand = 600,
Assay = "H2az", groupinfo = groupinfo)
```

“cluster\_parameters()” uses the output of “extract()” and runs one of the algorithms between “clvalid” or “NbClust” to determine the number of clusters.

The parameters of “clvalid” and “NbClust” are passed through the `clusteringMethods`, `validationMethods` and `distance` argument of “cluster\_parameters()” function. The argument pairs are different in “NbClust” and “clvalid” and thus should be chosen carefully.

```
#### Using "clValid" ####

clusterstats <- cluster_parameters(name = data,
optimal = FALSE, n = 2:6, comparisonAlgorithm = "clValid",
distance = "euclidean", clusteringMethods = c("kmeans","pam"),
validationMethods = c("internal","stability"))

#### plot indexes vs cluster numbers returned by clValid
#plot(clusterstats)

#### using "NbClust"

data <- extract(name = name, PC = c(1:4),
groups = c("WE","RE"),integrated = TRUE, rand = 400,
groupinfo = groupinfo)

clusterstats <- cluster_parameters(name = data, n = 2:6,
comparisonAlgorithm = "NbClust", distance = "euclidean",
clusteringMethods = "kmeans",
validationMethods = "all")

library(factoextra)

fviz_nbclust(clusterstats, method = c("silhouette",
"wss", "gap_stat"))
```

Now, depending on the output of “cluster\_parameters()”, we may choose the appropriate clustering algorithm and number of clusters.

OMICsPCA has a function “cluster()” that is designed for the clustering task. “cluster()” has many clustering options which should be chosen through `choice` argument. The class of the returned value by “cluster()” depends on the type of clustering method chosen. So, extraction and visualization of data from cluster objects are different for different choices.

```
data <- extract(name = name, PC = c(1:4),
groups = c("WE","RE"), integrated = TRUE, rand = 1000,
groupinfo = groupinfo)

library(factoextra)
# Welcome! Want to learn more? See two factoextra-related books at https://goo.gl/ve3WBa

### kmeans clustering

clusters <- cluster(name = data, n = 2, choice = "kmeans",
title = "kmeans on 2 clusters")

# visualization of clusters

print(clusters$plot)
```

![](data:image/png;base64...)

```
clustered_data <- cbind(data,clusters$cluster$cluster)
plot3d(data[,1:3], col = clusters$cluster$cluster)

### density-based clustering

clusters <- cluster(name = data, choice = "density",
eps = 2, MinPts = 100, graph = TRUE,
title = "eps = 1 and MinPts = 1.5")

# visualization of clusters
print(clusters$plot)
```

![](data:image/png;base64...)

```
clustered_data <- as.data.frame(cbind(data,clusters$cluster$cluster))

#removing unclustered points
clustered_data <- clustered_data[clustered_data$V5 != 0, ]

library(rgl)
#plotting clusters on first 3 PCs
plot3d(clustered_data[,1:3], col = clustered_data$V5)
```

### 3.10.1 Validation of clusters

```
#### Using silhouette index
# calculating the distance matrix
library(cluster)
dist <- daisy(data)

sil = silhouette(clusters$cluster$cluster,dist)

# RStudio sometimes does not display silhouette plots
#correctly. So sometimes, it is required to plot in separate
#window.

#grDevices::windows()
#plot(sil)
```

### 3.10.2 Identification of misclassified points

```
# Identification of misclassified data points
# silhouette width of misclassified points are negative
misclassified <- which(sil[,3] < 0)

head(sil[misclassified,])
#      cluster neighbor   sil_width
# [1,]       0        2 -0.07895732
# [2,]       0        1 -0.01673462
# [3,]       1        0 -0.20055068
# [4,]       1        0 -0.07532661
# [5,]       0        2 -0.07786404
# [6,]       0        2 -0.16809018

data[misclassified[3:7],]
#                       Dim.1       Dim.2      Dim.3      Dim.4
# ENST00000491458.1 2.2228843  1.46426837 -1.0521241 -0.9004107
# ENST00000420698.1 1.9570548  0.61880148 -1.9962879 -0.7828562
# ENST00000574405.1 1.1950802 -0.75601509  2.2366391  1.6421242
# ENST00000385289.1 1.1609372 -0.04865664 -1.0890772 -0.9980095
# ENST00000397454.2 0.1508929  2.65680587  0.7479576 -0.2020893
```

We may reorganize the misclassified points into appropriate clusters.

### 3.10.3 Exploration of clusters

let’s explore the clusters more

```
bp <- cluster_boxplot(name = multi_assay,
Assay = "H2az", clusterobject = clustered_data,
clustercolumn = 5)

bp <- bp+xlab("Cell lines") + ylab(
"value")+ggtitle(
"Distribution of H2az_cell_wise in various clusters")+theme(
plot.title=element_text(hjust=0.5),
legend.position = "top")+guides(
fill=guide_legend("Cell lines"))

bp
```

![](data:image/png;base64...)

The overall distribution of H2az is significantly different in the two clusters, implying a good clustering by density based. This process may be applied to other factors or other clustering methods.

# 4 Summary

Most of the multi-omics data integration algorithms are focused on 2 applications:

1. use of integrated data for class prediction (e.g. identification of diseased individuals) and
2. analysis of the source of variation across samples and individuals.

However, such approaches do not suffice to other potential applications including quantitative representation of the combined effect of multiple data modalities, clustering of individuals on the basis of combined epigenetic state etc. We propose here a new tool OMICsPCA, designed for integrative analysis of multi-omics data including the ones mentioned above.

Integration of multi-omics data involves 2 major tasks:

1. analysis of the source of variation among the samples of a data modality and
2. calculation of the combined effect of multiple data modalities on the individuals.

We used a **3 step process** to analyse the variation among the samples of each data modality. **First**, we used **descriptor()** and **chart\_correlation()** to get an initial clue about the overall nature of the samples. **Second**, we used **integrate\_variables()**, **analyse\_variables()** and **analyse\_individuals()** to dissect the variation among the samples of a modality, as well as the individuals in a group-wise manner. **Third**, we used density analysis to study the internal structure of the data distribution which in turn used to identify the “discriminatory data modalities” or assays that show different density structures in different groups of individuals. These 3 step process is used to study the difference between the groups of individuals and to select the similar samples corresponding to a data modality.

In the second task, we linearly combined all the similar samples corresponding to the selected factors (these may be the discriminatory factors) using Principal Component Analysis (PCA). Each of the Principal components represents the combined state of various data modalities across multiple samples. We used these combined metrices to identify similar individuals (TSSs) by various clustering methods.

OMICsPCA overcomes the limitations of the existing tools and has a good potential to be used as an multipurpose data integration and analysis tool.

# 5 SessionInfo

```
sessionInfo()
# R version 4.5.1 Patched (2025-08-23 r88802)
# Platform: x86_64-pc-linux-gnu
# Running under: Ubuntu 24.04.3 LTS
#
# Matrix products: default
# BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
# LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#
# locale:
#  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#  [3] LC_TIME=en_GB              LC_COLLATE=C
#  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#  [9] LC_ADDRESS=C               LC_TELEPHONE=C
# [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#
# time zone: America/New_York
# tzcode source: system (glibc)
#
# attached base packages:
# [1] stats4    stats     graphics  grDevices utils     datasets  methods
# [8] base
#
# other attached packages:
#  [1] cluster_2.1.8.1             factoextra_1.0.7
#  [3] ggplot2_4.0.0               rgl_1.3.24
#  [5] magick_2.9.0                knitr_1.50
#  [7] rmarkdown_2.30              kableExtra_1.4.0
#  [9] OMICsPCA_1.28.0             OMICsPCAdata_1.27.0
# [11] MultiAssayExperiment_1.36.0 SummarizedExperiment_1.40.0
# [13] Biobase_2.70.0              GenomicRanges_1.62.0
# [15] Seqinfo_1.0.0               IRanges_2.44.0
# [17] S4Vectors_0.48.0            BiocGenerics_0.56.0
# [19] generics_0.1.4              MatrixGenerics_1.22.0
# [21] matrixStats_1.5.0
#
# loaded via a namespace (and not attached):
#   [1] splines_4.5.1              BiocIO_1.20.0
#   [3] bitops_1.0-9               tibble_3.3.0
#   [5] xts_0.14.1                 XML_3.99-0.19
#   [7] lifecycle_1.0.4            rstatix_0.7.3
#   [9] lattice_0.22-7             prabclus_2.3-4
#  [11] MASS_7.3-65                flashClust_1.01-2
#  [13] NbClust_3.0.1              backports_1.5.0
#  [15] magrittr_2.0.4             sass_0.4.10
#  [17] jquerylib_0.1.4            yaml_2.3.10
#  [19] flexmix_2.3-20             askpass_1.2.1
#  [21] cowplot_1.2.0              DBI_1.2.3
#  [23] RColorBrewer_1.1-3         multcomp_1.4-29
#  [25] abind_1.4-8                quadprog_1.5-8
#  [27] purrr_1.1.0                RCurl_1.98-1.17
#  [29] nnet_7.3-20                TH.data_1.1-4
#  [31] VariantAnnotation_1.56.0   sandwich_3.1-1
#  [33] ggrepel_0.9.6              svglite_2.2.2
#  [35] codetools_0.2-20           DelayedArray_0.36.0
#  [37] DT_0.34.0                  xml2_1.4.1
#  [39] pdftools_3.6.0             tidyselect_1.2.1
#  [41] clValid_0.7                farver_2.1.2
#  [43] base64enc_0.1-3            GenomicAlignments_1.46.0
#  [45] jsonlite_2.0.0             Formula_1.2-5
#  [47] survival_3.8-3             emmeans_2.0.0
#  [49] systemfonts_1.3.1          tools_4.5.1
#  [51] Rcpp_1.1.0                 glue_1.8.0
#  [53] Rttf2pt1_1.3.14            SparseArray_1.10.0
#  [55] BiocBaseUtils_1.12.0       xfun_0.53
#  [57] dplyr_1.1.4                withr_3.0.2
#  [59] fastmap_1.2.0              digest_0.6.37
#  [61] R6_2.6.1                   estimability_1.5.1
#  [63] qpdf_1.4.1                 textshaping_1.0.4
#  [65] dichromat_2.0-0.1          RSQLite_2.4.3
#  [67] cigarillo_1.0.0            diptest_0.77-2
#  [69] utf8_1.2.6                 tidyr_1.3.1
#  [71] ggsci_4.1.0                PerformanceAnalytics_2.0.8
#  [73] data.table_1.17.8          rtracklayer_1.70.0
#  [75] robustbase_0.99-6          class_7.3-23
#  [77] httr_1.4.7                 htmlwidgets_1.6.4
#  [79] S4Arrays_1.10.0            scatterplot3d_0.3-44
#  [81] pkgconfig_2.0.3            gtable_0.3.6
#  [83] modeltools_0.2-24          blob_1.2.4
#  [85] S7_0.2.0                   XVector_0.50.0
#  [87] htmltools_0.5.8.1          carData_3.0-5
#  [89] multcompView_0.1-10        scales_1.4.0
#  [91] docopt_0.7.2               leaps_3.2
#  [93] png_0.1-8                  corrplot_0.95
#  [95] rstudioapi_0.17.1          reshape2_1.4.4
#  [97] rjson_0.2.23               coda_0.19-4.1
#  [99] curl_7.0.0                 cachem_1.1.0
# [101] zoo_1.8-14                 stringr_1.5.2
# [103] parallel_4.5.1             extrafont_0.20
# [105] AnnotationDbi_1.72.0       restfulr_0.0.16
# [107] pillar_1.11.1              grid_4.5.1
# [109] vctrs_0.6.5                ggpubr_0.6.2
# [111] car_3.1-3                  xtable_1.8-4
# [113] extrafontdb_1.1            evaluate_1.0.5
# [115] GenomicFeatures_1.62.0     mvtnorm_1.3-3
# [117] cli_3.6.5                  compiler_4.5.1
# [119] Rsamtools_2.26.0           rlang_1.1.6
# [121] crayon_1.5.3               ggsignif_0.6.4
# [123] HelloRanges_1.36.0         labeling_0.4.3
# [125] mclust_6.1.1               plyr_1.8.9
# [127] stringi_1.8.7              viridisLite_0.4.2
# [129] BiocParallel_1.44.0        Biostrings_2.78.0
# [131] Matrix_1.7-4               BSgenome_1.78.0
# [133] bit64_4.6.0-1              KEGGREST_1.50.0
# [135] fpc_2.2-13                 FactoMineR_2.12
# [137] kernlab_0.9-33             broom_1.0.10
# [139] memoise_2.0.1              bslib_0.9.0
# [141] DEoptimR_1.1-4             bit_4.6.0
```

# 6 References

1. Huang YT. Integrative modeling of multiple genomic data from different types of genetic association studies. Biostatistics. 2014 Oct;15(4):587-602. PubMed PMID: 24705142.
2. He X, Fuller CK, Song Y, Meng Q, Zhang B, Yang X, et al. Sherlock: detecting gene-disease associations by matching patterns of expression QTL and GWAS. American journal of human genetics. 2013 May 2;92(5):667-80. PubMed PMID: 23643380. Pubmed Central PMCID: 3644637.
3. Xiong Q, Ancona N, Hauser ER, Mukherjee S, Furey TS. Integrating genetic and gene expression evidence into genome-wide association analysis of gene sets. Genome research. 2012 Feb;22(2): 386-97. PubMed PMID: 21940837. Pubmed Central PMCID: 3266045.
4. Ha M, Hong S. Gene-regulatory interactions in embryonic stem cells represent cell-type specific gene regulatory programs. Nucleic acids research. 2017 Oct 13;45(18):10428-35. PubMed PMID: 28977540. Pubmed Central PMCID: 5737473.
5. Chen L, Ge B, Casale FP, Vasquez L, Kwan T, Garrido-Martin D, et al. Genetic Drivers of Epigenetic and Transcriptional Variation in Human Immune Cells. Cell. 2016 Nov 17;167(5):1398-414 e24. PubMed PMID: 27863251. Pubmed Central PMCID: 5119954.
6. Consortium GT. Human genomics. The Genotype-Tissue Expression (GTEx) pilot analysis: multitissue gene regulation in humans. Science. 2015 May 8;348(6235):648-60. PubMed PMID: 25954001. Pubmed Central PMCID: 4547484.
7. Lanckriet GR, De Bie T, Cristianini N, Jordan MI, Noble WS. A statistical framework for genomic data fusion. Bioinformatics. 2004 Nov 1;20(16):2626-35. PubMed PMID: 15130933.
8. Wang B, Mezlini AM, Demir F, Fiume M, Tu Z, Brudno M, et al. Similarity network fusion for aggregating data types on a genomic scale. Nature methods. 2014 Mar;11(3):333-7. PubMed PMID: 24464287.
9. Argelaguet R, Velten B, Arnol D, Dietrich S, Zenz T, Marioni JC, et al. Multi-Omics Factor Analysis-a framework for unsupervised integration of multi-omics data sets. Molecular systems biology. 2018 Jun 20;14(6):e8124. PubMed PMID: 29925568. Pubmed Central PMCID: 6010767.