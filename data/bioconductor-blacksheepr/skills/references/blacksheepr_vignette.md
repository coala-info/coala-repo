# Outlier Analysis using blacksheepr

MacIntosh Cornwell

#### 10/29/2025

#### Abstract

blacksheep is used to perform extreme value analysis in the context of differential comparison between two populations. The basic mechanism is to test the proportions of outliers between the two populations, and assess for statistical difference between the proportions of outliers.

#### Package

blacksheepr 1.24.0

# Contents

* [0.1 Introduction](#introduction)
* [0.2 Installation](#installation)
* [0.3 Input Data](#input-data)
  + [0.3.1 Count data](#count-data)
  + [0.3.2 Annotation data](#annotation-data)
  + [0.3.3 SummarizedExperiment data](#summarizedexperiment-data)
* [1 Example Workflow - Phosphoprotein](#example-workflow---phosphoprotein)
  + [1.1 Input Data](#input-data-1)
    - [1.1.1 Read in Annotation](#read-in-annotation)
    - [1.1.2 Read in the phospho data](#read-in-the-phospho-data)
    - [1.1.3 Creating a SummarizedExperiment from our data.](#creating-a-summarizedexperiment-from-our-data.)
  + [1.2 Running deva (differential extreme value analysis)](#running-deva-differential-extreme-value-analysis)
    - [1.2.1 deva parameters](#deva-parameters)
  + [1.3 Exploring deva output](#exploring-deva-output)
    - [1.3.1 The deva\_results() function](#the-deva_results-function)
    - [1.3.2 Results](#results)
* [2 Piecewise analysis](#piecewise-analysis)
  + [2.1 Create groupings](#create-groupings)
  + [2.2 Make Outlier table](#make-outlier-table)
  + [2.3 Tabulate Outliers](#tabulate-outliers)
  + [2.4 Run Outlier Analysis](#run-outlier-analysis)
  + [2.5 Plot Results using Heatmap Generating Function](#plot-results-using-heatmap-generating-function)
* [3 Appendix](#appendix)
  + [3.1 Formatting your annotations table](#formatting-your-annotations-table)
    - [3.1.1 Using the make\_comparison\_columns utility function](#using-the-make_comparison_columns-utility-function)
  + [3.2 Running blacksheep functions for other -omics data](#running-blacksheep-functions-for-other--omics-data)
    - [3.2.1 Running deva with RNAseq data](#running-deva-with-rnaseq-data)
  + [3.3 Processing data for running with deva](#processing-data-for-running-with-deva)

## 0.1 Introduction

Outlier analysis is a well established method for exploring extreme values in
the context of the rest of the population. In biological contexts, exploring the
shift in proportion of these outliers can elucidate differences between
subpopulations, suggesting potential differential characteristics that can be
further explored.
blacksheep is a project that was developed in an effort to refine this analysis
to a functional tool for outlier analysis in the context of biological data.
This data can take many forms: protein, phosphoprotein, RNA, CNA, etc. The input
for blacksheep is count data of some form, and annotation data indicative of the
populations for comparison. The primary function call is `deva` (Differential
Extreme Value Analysis).
This vignette will run through a few standard use-cases, illustrating the
functionality of blacksheep and hopefully answering questions and showing its
usefulness in biological exploration.

## 0.2 Installation

Installation is similar to all Bioconductor packages. Start R and run the
following lines to install:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("blacksheepr")
```

Loading the library is done by using the `library` call

```
library(blacksheepr)
```

## 0.3 Input Data

### 0.3.1 Count data

Count data should be a table of counts with samples along the x-axis, and
features along the y-axis, with the labels being rownames and colnames.

```
data("sample_phosphodata")
sample_phosphodata[1:5,1:5]
```

```
##                        TCGA-AO-A12D TCGA-BH-A18Q TCGA-C8-A130 TCGA-C8-A138
## NP_149131-S462s T469t    -2.7612119           NA           NA    -2.289952
## NP_061893-S25s                   NA  -1.35695974   -0.2667119           NA
## NP_001182345-S413s        0.5208798   0.09949606   -2.1361523    -3.729862
## NP_116026-S179s                  NA   0.97943811    0.4830637           NA
## NP_002388-S192s                  NA           NA           NA           NA
##                        TCGA-E2-A154
## NP_149131-S462s T469t     -1.512795
## NP_061893-S25s                   NA
## NP_001182345-S413s         2.658696
## NP_116026-S179s                  NA
## NP_002388-S192s                  NA
```

### 0.3.2 Annotation data

The Annotation data should be a table with the same samples included in your
count data, listed along the y-axis. Each column will then be a comparison to
perform, with the values of the column being some form of binary system
indicating the samples belonging to each sub group.
NOTE - that these should be strings. It’s more informative if your columns
actually contain useful information such as “high”/“low”, “mutant”/“WT”, etc.
as oppposed to “1/0” or any other non-descriptive binary.

```
data("sample_annotationdata")
sample_annotationdata[1:5,]
```

```
##              PAM50_Her2 PAM50_Basal PAM50_LumA PAM50_LumB ER_Status PR_Status
## TCGA-AO-A12D       Her2   not_Basal   not_LumA   not_LumB  Negative  Negative
## TCGA-BH-A18Q   not_Her2       Basal   not_LumA   not_LumB  Negative  Negative
## TCGA-C8-A130       Her2   not_Basal   not_LumA   not_LumB  Positive  Positive
## TCGA-C8-A138       Her2   not_Basal   not_LumA   not_LumB  Positive  Negative
## TCGA-E2-A154   not_Her2   not_Basal       LumA   not_LumB  Positive  Positive
```

### 0.3.3 SummarizedExperiment data

blacksheepr takes in a SummarizedExperiment object into the main `deva`
function call (more on this below). blacksheepr can therefore start with any
SummarizedExperiment object, as long as the colData of the SummarizedExperiment
contains rownames that are the same as the column names in the data as
described above, and the metadata is made up of BINARY classifications. NOTE
that this may take some additional formatting. The Appendix has a note on
helper functions that can assist with this formatting.

# 1 Example Workflow - Phosphoprotein

In the following section - we will go through an example of using outlier
analysis using Phosphoprotein data. The inputted data is being supplied from
[Github](https://github.com/ruggleslab/blacksheep_supp/tree/master) and is
originally sourced using breast cancer data from TCGA and CPTAC.
[doi:10.1038/nature18003](https://www.nature.com/articles/nature18003)

## 1.1 Input Data

### 1.1.1 Read in Annotation

Read in the Annotation table.

```
data(sample_annotationdata)
comptable <- sample_annotationdata
comptable[1:5,]
```

```
##              PAM50_Her2 PAM50_Basal PAM50_LumA PAM50_LumB ER_Status PR_Status
## TCGA-AO-A12D       Her2   not_Basal   not_LumA   not_LumB  Negative  Negative
## TCGA-BH-A18Q   not_Her2       Basal   not_LumA   not_LumB  Negative  Negative
## TCGA-C8-A130       Her2   not_Basal   not_LumA   not_LumB  Positive  Positive
## TCGA-C8-A138       Her2   not_Basal   not_LumA   not_LumB  Positive  Negative
## TCGA-E2-A154   not_Her2   not_Basal       LumA   not_LumB  Positive  Positive
```

```
dim(comptable)
```

```
## [1] 76  6
```

### 1.1.2 Read in the phospho data

Next we need to have the actual count data that we are analyzing. Note that
this data is made up of features - proteins - that then have a number of
subfeatures - phosphorylation sites. This aspect of the data will directly
relate to later analysis, as blacksheep will AGGREGATE on this data and
collapse the data onto the primary feature. More on this later. Note also that
this data has been prenormalized. For more on the processing of data to input
into `deva`, refer to the appendix.

```
data(sample_phosphodata)
phosphotable <- sample_phosphodata
phosphotable[1:5,1:5]
```

```
##                        TCGA-AO-A12D TCGA-BH-A18Q TCGA-C8-A130 TCGA-C8-A138
## NP_149131-S462s T469t    -2.7612119           NA           NA    -2.289952
## NP_061893-S25s                   NA  -1.35695974   -0.2667119           NA
## NP_001182345-S413s        0.5208798   0.09949606   -2.1361523    -3.729862
## NP_116026-S179s                  NA   0.97943811    0.4830637           NA
## NP_002388-S192s                  NA           NA           NA           NA
##                        TCGA-E2-A154
## NP_149131-S462s T469t     -1.512795
## NP_061893-S25s                   NA
## NP_001182345-S413s         2.658696
## NP_116026-S179s                  NA
## NP_002388-S192s                  NA
```

```
dim(phosphotable)
```

```
## [1] 15532    76
```

### 1.1.3 Creating a SummarizedExperiment from our data.

blacksheep - as a part of the Bioconductor universe - starts from a single
object that contains the assay of interest, and the underlying metadata. A
`SummarizedExperiment` object is easy to create - and helps ensure that there
is no misalignment between the data and the metadata associated with each
sample.
NOTE - as demonstrated below that the count data must be formatted as a MATRIX
and the annotation data must be formatted as a DATAFRAME.

```
suppressPackageStartupMessages(library(SummarizedExperiment))

blacksheep_SE <- SummarizedExperiment(
    assays=list(counts=as.matrix(phosphotable)),
    colData=DataFrame(comptable))
blacksheep_SE
```

```
## class: SummarizedExperiment
## dim: 15532 76
## metadata(0):
## assays(1): counts
## rownames(15532): NP_149131-S462s T469t NP_061893-S25s ...
##   NP_542417-S1276s NP_001136254-S832s
## rowData names(0):
## colnames(76): TCGA-AO-A12D TCGA-BH-A18Q ... TCGA-BH-A0C7 TCGA-A2-A0SX
## colData names(6): PAM50_Her2 PAM50_Basal ... ER_Status PR_Status
```

## 1.2 Running deva (differential extreme value analysis)

The `deva` function has a number of steps to it that are individually
described below. Note though that the individual steps only need to be used for
specific query or alteration. In the general case, the `deva` function on
its own should be sufficient for the desired analysis.

```
deva_out <- deva(se = blacksheep_SE,
    analyze_negative_outliers = FALSE, aggregate_features = TRUE,
    feature_delineator = "-", fraction_samples_cutoff = 0.3,
    fdrcutoffvalue = 0.1)
```

### 1.2.1 deva parameters

* se - The SummarizedExperiment that will serve as the input for deva
* analyze\_negative\_outliers - Is the analysis looking at positive or negative
  outliers.
* aggregate\_features - Should the analysis collapse features to a primary term.
  Useful for phosphosites on proteins, isotypes of proteins, etc.
* feature\_delineator - The character marker that delineates the primary feature
  when using the  parameter
* fraction\_samples\_cutoff - how many samples in a group must contain an outlier
  for the feature to be considered significant. This parameter is used to avoid
  overbiased results from single samples. (see appendix)
* fdrcutoffvalue - the FDR value to be considered for significant output.

## 1.3 Exploring deva output

The output from blacksheep are lists with the desired results. There is an
`outlier_analysis` and a `significant_heatmaps` for the desired analysis. In
this example, we only ran analysis for positive outliers. So the output will
be 2 items long - heatmaps and tables for the positive outlier analysis.

```
names(deva_out)
```

```
## [1] "outlier_analysis_out"   "significant_heatmaps"   "fraction_table"
## [4] "median_value_table"     "outlier_boundary_table"
```

The `outlier_analysis` is a nested list of analyses - with one anaysis per
comparison columns

```
names(deva_out$pos_outlier_analysis)
```

```
## NULL
```

The `significant_heatmaps` section is a nested list of heatmap obejcts, again
with one anaysis per comparison columns

```
names(deva_out$significant_pos_heatmaps)
```

```
## NULL
```

### 1.3.1 The deva\_results() function

`deva_results()` is a utility function to help explore your data. If you use
`deva_results` on the `deva_out` object, it will return a list of the performed
analyses that returned significant results.

```
deva_results(deva_out)
```

```
## [1] "outlier_analysis_out"   "significant_heatmaps"   "fraction_table"
## [4] "median_value_table"     "outlier_boundary_table"
```

The other parameters for deva\_out are `ID` and `type`. `ID` is a keyword to
grab the desired analysis. `type` is one of the following options: `table` or
`heatmap` specifies which analysis object you want to grab, followed by the ID
of the specific analysis. `fraction_table` is the outputted table that shows
the fraction of outliers per sample per feature (NOTE that this will be the
same as the outlier table if no aggregation was done). `median` and `boundary`
return lists for the median value, and the outlier boundary value for each
feature.

```
subanalysis_Her2 <- deva_results(deva_out, ID = "Her2", type = "table")
head(subanalysis_Her2)
```

```
##           gene pval_more_pos_outliers_in_PAM50_Her2__Her2
## 1    NP_000215                       0.000876167768317826
## 2    NP_000393                         0.0104700645400028
## 3 NP_001002814                          0.312790178663637
## 4 NP_001003408                          0.540506340033899
## 5 NP_001005751
## 6 NP_001020262                         0.0519534804138539
##   pval_more_pos_outliers_in_PAM50_Her2__not_Her2
## 1
## 2
## 3
## 4
## 5                                              1
## 6
##   fdr_more_pos_outliers_in_PAM50_Her2__Her2
## 1                        0.0055210906126839
## 2                        0.0260165240084919
## 3                         0.371721661600264
## 4                         0.575604154321814
## 5
## 6                        0.0774579162533822
##   fdr_more_pos_outliers_in_PAM50_Her2__not_Her2 PAM50_Her2__Her2_nonposoutlier
## 1                                                                           32
## 2                                                                           12
## 3                                                                           47
## 4                                                                           65
## 5                                             1                            100
## 6                                                                           31
##   PAM50_Her2__Her2_posoutlier PAM50_Her2__not_Her2_nonposoutlier
## 1                           6                                186
## 2                           4                                 67
## 3                           4                                285
## 4                           4                                392
## 5                           5                                562
## 6                           5                                165
##   PAM50_Her2__not_Her2_posoutlier
## 1                               3
## 2                               2
## 3                              14
## 4                              18
## 5                              33
## 6                               8
```

### 1.3.2 Results

For each column of your comparison table that you put in (occupies `colData` in
a SummarizedExperiment object), `deva` will output a table of analysis if there
were any applicable results.
One example of a table is as follows:

```
subanalysis_Her2 <- deva_results(deva_out, ID = "Her2", type = "table")
head(subanalysis_Her2)
```

```
##           gene pval_more_pos_outliers_in_PAM50_Her2__Her2
## 1    NP_000215                       0.000876167768317826
## 2    NP_000393                         0.0104700645400028
## 3 NP_001002814                          0.312790178663637
## 4 NP_001003408                          0.540506340033899
## 5 NP_001005751
## 6 NP_001020262                         0.0519534804138539
##   pval_more_pos_outliers_in_PAM50_Her2__not_Her2
## 1
## 2
## 3
## 4
## 5                                              1
## 6
##   fdr_more_pos_outliers_in_PAM50_Her2__Her2
## 1                        0.0055210906126839
## 2                        0.0260165240084919
## 3                         0.371721661600264
## 4                         0.575604154321814
## 5
## 6                        0.0774579162533822
##   fdr_more_pos_outliers_in_PAM50_Her2__not_Her2 PAM50_Her2__Her2_nonposoutlier
## 1                                                                           32
## 2                                                                           12
## 3                                                                           47
## 4                                                                           65
## 5                                             1                            100
## 6                                                                           31
##   PAM50_Her2__Her2_posoutlier PAM50_Her2__not_Her2_nonposoutlier
## 1                           6                                186
## 2                           4                                 67
## 3                           4                                285
## 4                           4                                392
## 5                           5                                562
## 6                           5                                165
##   PAM50_Her2__not_Her2_posoutlier
## 1                               3
## 2                               2
## 3                              14
## 4                              18
## 5                              33
## 6                               8
```

The output in order is:
\* col1 - the list of genes
\* col2-3 - the pvalue of the gene being significantly different, the column it
appears in is indicative of the measure of the gene being higher in group1
or group2.
\* col4-5 - the FDR value for that pvalue
\* col6-9 - the raw data behind the statisical test, showing how many outliers
and nonoutliers there are for each group.

The heatmaps serve as a snapshot of the significant genes that met the
parameterized fdr cutoff in the `deva` function call. They can be accessed
in a similar manner to the analysis tables. NOTE though that there will only be
a heatmap if there were ANY significant genes. If there were no genes that met
the fdr cut off - then there will be no heatmap generated.

```
subanalysis_Her2_HM <- deva_results(deva_out, ID = "Her2", type = "heatmap")
subanalysis_Her2_HM
```

![](data:image/png;base64...)

The heatmap objects themselves are [ComplexHeatmap](https://%20www.bioconductor.org/packages/release/bioc/html/ComplexHeatmap.html)
objects - and will be drawn when called, either in the default Rplot, or can be
saved out to an external file.

```
## NOT RUN
## To output separately to pdf
pdf("outfile.pdf")
draw(subanalysis_Her2_HM)
dev.off()
```

# 2 Piecewise analysis

*THIS SECTION ASSUMES THAT THE PREVIOUS STEPS FOR READING IN THE DATA AND
ANNOTATIONS HAS BEEN COMPLETED*
The next section demonstrates the individual steps of deva. NOTE that the
user may *never* need to call the specific steps, but if specific tweaks are
needed, or if an intermediate step needs to be extracted, then this workflow
can be followed to see how the analysis is generated.

## 2.1 Create groupings

Create the subgroups based on your metadata. Note that the
`comparison_groupings` function creates groups by going through the comparison
columns, and creating the first subgroup for all of the comparisons, and then
creates the second subgroup for all of the comparisons. The order depends on
the first subcategory encounted moving down the column. This order will matter
later on when you look at comparisons, but this information will be contained
in the ouput table to avoid confusion, more on this later.

```
groupings <- comparison_groupings(comptable)
## Print out the first 6 samples in each of our first 5 groupings
lapply(groupings, head)[1:5]
```

```
## $PAM50_Her2__Her2
## [1] "TCGA-AO-A12D" "TCGA-C8-A130" "TCGA-C8-A138" "TCGA-C8-A12L" "TCGA-C8-A12T"
## [6] "TCGA-A2-A0EQ"
##
## $PAM50_Basal__not_Basal
## [1] "TCGA-AO-A12D" "TCGA-C8-A130" "TCGA-C8-A138" "TCGA-E2-A154" "TCGA-C8-A12L"
## [6] "TCGA-A2-A0EX"
##
## $PAM50_LumA__not_LumA
## [1] "TCGA-AO-A12D" "TCGA-BH-A18Q" "TCGA-C8-A130" "TCGA-C8-A138" "TCGA-C8-A12L"
## [6] "TCGA-BH-A0AV"
##
## $PAM50_LumB__not_LumB
## [1] "TCGA-AO-A12D" "TCGA-BH-A18Q" "TCGA-C8-A130" "TCGA-C8-A138" "TCGA-E2-A154"
## [6] "TCGA-C8-A12L"
##
## $ER_Status__Negative
## [1] "TCGA-AO-A12D" "TCGA-BH-A18Q" "TCGA-C8-A12L" "TCGA-BH-A0AV" "TCGA-A2-A0CM"
## [6] "TCGA-A2-A0EQ"
```

## 2.2 Make Outlier table

The next function `make_outlier_table` will take in the countdata and output a
table that has been converted to show outliers. A value of 0 means that it was
not an outlier, 1 means it was an outlier in the positive direction, and if the
parameter is set to analyze negative outliers, then -1 means an outlier in the
negative direction.

The output from this function is a list of objects, that depends on the input
and the specified parameters. Namely - it will output a $upperboundtab only
if the parameter to analyze\_negative\_outliers is turned OFF, and $lowerboundtab
if the analyze\_negative\_outliers parameter is turned ON

```
## Perform the function
reftable_function_out <- make_outlier_table(phosphotable,
                                        analyze_negative_outliers = FALSE)
## See the names of the outputted objects
names(reftable_function_out)
```

```
## [1] "outliertab"    "sampmedtab"    "upperboundtab"
```

```
## Assign them to individual variables
outliertab <- reftable_function_out$outliertab
upperboundtab <- reftable_function_out$upperboundtab
sampmedtab <- reftable_function_out$sampmedtab

## Note we will only use the outlier table - which looks like this now
outliertab[1:5,1:5]
```

```
##                        TCGA-AO-A12D TCGA-BH-A18Q TCGA-C8-A130 TCGA-C8-A138
## NP_149131-S462s T469t             0           NA           NA            0
## NP_061893-S25s                   NA            0            0           NA
## NP_001182345-S413s                0            0            0            0
## NP_116026-S179s                  NA            0            0           NA
## NP_002388-S192s                  NA           NA           NA           NA
##                        TCGA-E2-A154
## NP_149131-S462s T469t             0
## NP_061893-S25s                   NA
## NP_001182345-S413s                1
## NP_116026-S179s                  NA
## NP_002388-S192s                  NA
```

## 2.3 Tabulate Outliers

For each of our groups, run through the outlier table and count up the total
number of outliers and nonoutliers. For phospho (And this example) we are going
to use the AGGREGATION FUNCTION to aggregate our counts together on a per
protein basis

The output from this function is a list of objects, that depends on the input
and the specified parameters. For Phosphoprotein - you can have data that has
several phospho sites per protein. As a part of this analysis, one option is to
aggregate data on that protein - and collapse the outlier information into a
single feature. Turning `aggregate_features = TRUE` will perform this function,
and the `feature_delineator` is the character string to collapse on
ex) Feature1-1 and Feature1-2-1 with the delineator of “-” will collapse onto
Feature 1

The output with `aggregate_features = TRUE` will contain two additional
objects. It will output the normal outliertable, and boundary tables, and also
the “aggoutlierstab” and “fractiontab”
The “aggoutlierstab” will be the collapsed table, summing up the number of
outliers per feature
The “fractiontab” returns the % outliers per feature per sample, given
available information - this will be IMPORTANT FOR FURTHER FILTERING later on.
ex) 1,0,0 >> 1/3
ex) 1,0,NA >> 1/2

```
count_outliers_out <- count_outliers(groupings, outliertab,
                        aggregate_features = TRUE, feature_delineator = "-")
grouptablist <- count_outliers_out$grouptablist
aggoutliertab <- count_outliers_out$aggoutliertab
fractiontab <- count_outliers_out$fractiontab

names(grouptablist)
```

```
##  [1] "PAM50_Her2__Her2"       "PAM50_Basal__not_Basal" "PAM50_LumA__not_LumA"
##  [4] "PAM50_LumB__not_LumB"   "ER_Status__Negative"    "PR_Status__Negative"
##  [7] "PAM50_Her2__not_Her2"   "PAM50_Basal__Basal"     "PAM50_LumA__LumA"
## [10] "PAM50_LumB__LumB"       "ER_Status__Positive"    "PR_Status__Positive"
```

Each tabulated table has the feature counts, and the stored infor the samples
that went into the count

```
names(grouptablist$PAM50_Her2__Her2)
```

```
## [1] "feature_counts" "samples"
```

Example of what the feature counts look like:

```
head(grouptablist$PAM50_Her2__Her2$feature_counts)
```

```
##           0 1
## NP_000011 9 1
## NP_000012 0 0
## NP_000019 1 0
## NP_000034 4 0
## NP_000035 7 1
## NP_000042 0 0
```

Example of what the samples are that went into the analysis:

```
grouptablist$PAM50_Her2__Her2$samples
```

```
##  [1] "TCGA-AO-A12D" "TCGA-C8-A130" "TCGA-C8-A138" "TCGA-C8-A12L" "TCGA-C8-A12T"
##  [6] "TCGA-A2-A0EQ" "TCGA-AR-A0TX" "TCGA-A8-A076" "TCGA-C8-A135" "TCGA-C8-A12Z"
## [11] "TCGA-AO-A0JE" "TCGA-A8-A09G"
```

## 2.4 Run Outlier Analysis

With the tabulated tables, run the outlier analysis to look for enrichment of
outliers between groups. NOTE that this function has a functionality built in
to write out tables to the external file, we will not use this parameter now,
but it can be set by turning the to parameter `write_out_tables = TRUE`

In this outlier analysis - we will have an additional filter included. The
`fractiontab` outputted in the previous step has a metric that measure the
number of samples in each group that have an outlier in them. In this next step
we will use this information to filter for features that only have at least
`0.3` (30%) of samples with an outlier. This filter is important because our
aggregation step collapsed all of the sites down from each sample, and then we
counted the total. If one sample had ALL of its sites as outliers - while
interesting - this does not indicate the our entire ingroup has an
overrepresentation - just that one sample. This filter enables a clearer
analysis by only picking out features that have multiple samples with outliers.
NOTE that this can be omitted by just leaving the `fraction_table` parameter
out or as a `NULL`

```
outlier_analysis_out <- outlier_analysis(grouptablist = grouptablist,
                                        fraction_table = fractiontab,
                                        fraction_samples_cutoff = 0.3)
names(outlier_analysis_out)
```

```
## [1] "outlieranalysis_for_PAM50_Her2__Her2_vs_PAM50_Her2__not_Her2"
## [2] "outlieranalysis_for_PAM50_Basal__not_Basal_vs_PAM50_Basal__Basal"
## [3] "outlieranalysis_for_PAM50_LumA__not_LumA_vs_PAM50_LumA__LumA"
## [4] "outlieranalysis_for_PAM50_LumB__not_LumB_vs_PAM50_LumB__LumB"
## [5] "outlieranalysis_for_ER_Status__Negative_vs_ER_Status__Positive"
## [6] "outlieranalysis_for_PR_Status__Negative_vs_PR_Status__Positive"
```

```
head(outlier_analysis_out$
        outlieranalysis_for_PAM50_Her2__Her2_vs_PAM50_Her2__not_Her2)
```

```
##           gene pval_more_pos_outliers_in_PAM50_Her2__Her2
## 1    NP_000215                       0.000876167768317826
## 2    NP_000393                         0.0104700645400028
## 3 NP_001002814                          0.312790178663637
## 4 NP_001003408                          0.540506340033899
## 5 NP_001005751
## 6 NP_001020262                         0.0519534804138539
##   pval_more_pos_outliers_in_PAM50_Her2__not_Her2
## 1
## 2
## 3
## 4
## 5                                              1
## 6
##   fdr_more_pos_outliers_in_PAM50_Her2__Her2
## 1                        0.0055210906126839
## 2                        0.0260165240084919
## 3                         0.371721661600264
## 4                         0.575604154321814
## 5
## 6                        0.0774579162533822
##   fdr_more_pos_outliers_in_PAM50_Her2__not_Her2 PAM50_Her2__Her2_nonposoutlier
## 1                                                                           32
## 2                                                                           12
## 3                                                                           47
## 4                                                                           65
## 5                                             1                            100
## 6                                                                           31
##   PAM50_Her2__Her2_posoutlier PAM50_Her2__not_Her2_nonposoutlier
## 1                           6                                186
## 2                           4                                 67
## 3                           4                                285
## 4                           4                                392
## 5                           5                                562
## 6                           5                                165
##   PAM50_Her2__not_Her2_posoutlier
## 1                               3
## 2                               2
## 3                              14
## 4                              18
## 5                              33
## 6                               8
```

## 2.5 Plot Results using Heatmap Generating Function

After you have your results, its useful to have a snapshot of your results in a
figure. blacksheepr includes a utility function to output a heatmap with custom
annotations and data. Use the plotting function with the original annotation
data, and populate the heatmap with whatever information you want to represent.
In this case, we are going to populate the table with the fractions of outliers
per feature.
The outlier\_analysis object is used to select the differential genes.
NOTE that you can write out the plot directly in the function using the given
parameter `write_out_plot` or the saved object from the function is a heatmap,
so you can open your own pdf and print out using the commented out code below.
NOTE that the metatable must be in the ORDER desired, and that this function
will NOT order it for you.

```
plottable <- comptable[do.call(order, c(decreasing = TRUE,
                            data.frame(comptable[,1:ncol(comptable)]))),]
hm1 <- outlier_heatmap(outlier_analysis_out = outlier_analysis_out,
                counttab = fractiontab, metatable = plottable,
                fdrcutoffvalue = 0.1)

## To output heatmap to pdf outside of the function
#pdf(paste0(outfilepath, "test_hm1.pdf"))
#hm1
#junk<-dev.off()
```

```
hm1$print_outlieranalysis_for_PAM50_Her2__Her2_vs_PAM50_Her2__not_Her2
```

![Example outputted Heatmap](data:image/png;base64...)

Figure 1: Example outputted Heatmap

# 3 Appendix

## 3.1 Formatting your annotations table

Formatting your annotation table is a crucial step to making sure blacksheepr
runs smoothly. The key points are that that the rownames of your annotations
EXACTLY match the column names of the assay data, and that the annotation
columns are BINARY and therefore have only 2 subcategories per column.

### 3.1.1 Using the make\_comparison\_columns utility function

There is a built in utility function `make_comparison_columns` to help turn a
multifactor column into several binary columns. The user can input as many
columns as they want, and the function will output a table with each
multifactorial column turned into a number of binary columns

```
dummyannotations <- data.frame(comp1 = c(1,1,2,2,3,3),
                    comp2 = c("red", "blue", "red", "blue", "green", "green"),
                    row.names = paste0("sample", seq_len(6)))
dummyannotations
```

```
##         comp1 comp2
## sample1     1   red
## sample2     1  blue
## sample3     2   red
## sample4     2  blue
## sample5     3 green
## sample6     3 green
```

```
## Use the make_comparison_columns function to create binary columns
expanded_dummyannotations <- make_comparison_columns(dummyannotations)
expanded_dummyannotations
```

```
##         comp1_1 comp1_2 comp1_3 comp2_red comp2_blue comp2_green
## sample1 "1"     "not_2" "not_3" "red"     "not_blue" "not_green"
## sample2 "1"     "not_2" "not_3" "not_red" "blue"     "not_green"
## sample3 "not_1" "2"     "not_3" "red"     "not_blue" "not_green"
## sample4 "not_1" "2"     "not_3" "not_red" "blue"     "not_green"
## sample5 "not_1" "not_2" "3"     "not_red" "not_blue" "green"
## sample6 "not_1" "not_2" "3"     "not_red" "not_blue" "green"
```

## 3.2 Running blacksheep functions for other -omics data

blacksheepr is built as a generalized suite of tools with algorithms for use
with any type of -omics data in the format of the previously described assay
and annotations. Along those lines there are a couple common practices for
other -omics data types.

### 3.2.1 Running deva with RNAseq data

The principles are the same, the only main difference is that you will not
aggregate on to a primary feature, so the `aggregate_features` parameter should
be left to the default `FALSE`. Also Note that if you want to output all genes
regardless of significance, this can be accomplished by setting the `FDRcutoff`
to 1, and the `fraction_value_cutoff` to 0.

## 3.3 Processing data for running with deva

`deva` at its core explores for outliers based on the difference from the
median. Heavily skewed data needs to be to insure accurate analyses.
Blacksheepr includes a normalization function that will perform both a Median
of Ratios normalization in addition to a log2 transform. See below for an
example using the `pasilla` data set:

```
library(pasilla)
```

```
## Loading required package: DEXSeq
```

```
## Loading required package: BiocParallel
```

```
## Loading required package: DESeq2
```

```
## Loading required package: AnnotationDbi
```

```
## Loading required package: RColorBrewer
```

```
pasCts <- system.file("extdata", "pasilla_gene_counts.tsv", package="pasilla")
cts <- as.matrix(read.csv(pasCts,sep="\t",row.names="gene_id"))
norm_cts <- deva_normalization(cts, method = "MoR-log")
```