# Introduction to the Robust longitudinal Differential Expression (RolDE) method

* [Introduction](#introduction)
* [Installation](#installation)
* [Applying RolDE in example datasets with aligned time points](#applying-rolde-in-example-datasets-with-aligned-time-points)
  + [Semi-simulated spike-in dataset](#semi-simulated-spike-in-dataset)
* [Applying RolDE in example data with non aligned time points](#applying-rolde-in-example-data-with-non-aligned-time-points)
* [Changing the settings for RolDE](#changing-the-settings-for-rolde)
* [Preparation of data for RolDE](#preparation-of-data-for-rolde)
* [References](#references)

```
library(RolDE)
library(printr)
#> Registered S3 method overwritten by 'printr':
#>   method                from
#>   knit_print.data.frame rmarkdown
library(knitr)
```

## Introduction

RolDE is a composite method, consisting of three independent modules with different approaches to detecting longitudinal differential expression. The combination of these diverse modules allows RolDE to robustly detect varying differences in longitudinal trends and expression levels in diverse data types and experimental settings.

The RegROTS module merges the power of regression modelling with the power of the established differential expression method Reproducibility Optimized Test Statistic (ROTS) (Elo et al., Suomi et al.). A polynomial regression model for protein expression over time is fitted separately for each replicate (individual) in each condition. Differential expression between two replicates (individuals) in different conditions is examined by comparing the coefficients of the replicate-specific regression models. If all coefficient differences are zero, no longitudinal differential expression between the two replicates in different conditions exist. For a thorough exploration of differential expression between the conditions, all possible combinations of replicates in different conditions are examined.

In the DiffROTS module the expression of replicates (individuals) in different conditions are directly compared at all time points. Again, if the expression level differences at all time points are zero, no differential expression between the examined replicates (individuals) in different conditions exist. Similarly to the RegROTS module, differential expression is examined between all possible combinations of replicates (individuals) in the different conditions. In non-aligned time point data, the overall expression level differences between the conditions is examined when accounting for time-associated trends of varying complexity in the data. More specifically, the expression level differences between the conditions are examined when adjusting for increasingly complex time-related expression trends of polynomial degrees d=0,1,.,d where d is the maximum degree for the polynomial and the same degree as is used for the PolyReg module.

In the PolyReg module, polynomial regression modelling is used to detect longitudinal differential expression. Condition is included as a categorical factor within the models and by investigating the condition related intercept and longitudinal-term related coefficients at different levels of the condition factor, average differences in expression levels as well as differences in longitudinal expression patterns between the conditions can be examined.

Finally, to conclusively detect any differential expression, the findings from the different modules are combined using the rank product. For more details about the method, see the original RolDE publication (Valikangas et al.).

## Installation

The latest version of RolDE can be installed from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager", repos = "http://cran.us.r-project.org")
BiocManager::install("RolDE")
```

## Applying RolDE in example datasets with aligned time points

First, load the dataset and the design matrix to be used:

```
data(data1)
data("des_matrix1")
```

To understand the structure of the design matrix and what a design matrix for RolDE should look like, let’s explore the data and the design matrix:

Dimensions of the data:

```
dim(data1)
#> [1] 1045   30
```

Column names of the data:

```
head(colnames(data1))
#> [1] "Condition1_timepoint_1_Sample_1_r1" "Condition1_timepoint_1_Sample_1_r2"
#> [3] "Condition1_timepoint_1_Sample_1_r3" "Condition1_timepoint_2_Sample_2_r1"
#> [5] "Condition1_timepoint_2_Sample_2_r2" "Condition1_timepoint_2_Sample_2_r3"
```

Dimensions of the design matrix:

```
dim(des_matrix1)
#> [1] 30  4
```

Column names of the design matrix:

```
colnames(des_matrix1)
#> [1] "Sample Names"         "Condition"            "Time point"
#> [4] "Replicate/Individual"
```

Contents of the design matrix:

```
head(des_matrix1)
```

| Sample Names | Condition | Time point | Replicate/Individual |
| --- | --- | --- | --- |
| Condition1\_timepoint\_1\_Sample\_1\_r1 | Condition1 | 1 | 1 |
| Condition1\_timepoint\_1\_Sample\_1\_r2 | Condition1 | 1 | 2 |
| Condition1\_timepoint\_1\_Sample\_1\_r3 | Condition1 | 1 | 3 |
| Condition1\_timepoint\_2\_Sample\_2\_r1 | Condition1 | 2 | 1 |
| Condition1\_timepoint\_2\_Sample\_2\_r2 | Condition1 | 2 | 2 |
| Condition1\_timepoint\_2\_Sample\_2\_r3 | Condition1 | 2 | 3 |

```
tail(des_matrix1)
```

|  | Sample Names | Condition | Time point | Replicate/Individual |
| --- | --- | --- | --- | --- |
| [25,] | Condition2\_timepoint\_4\_Sample\_4\_r1 | Condition2 | 4 | 4 |
| [26,] | Condition2\_timepoint\_4\_Sample\_4\_r2 | Condition2 | 4 | 5 |
| [27,] | Condition2\_timepoint\_4\_Sample\_4\_r3 | Condition2 | 4 | 6 |
| [28,] | Condition2\_timepoint\_5\_Sample\_5\_r1 | Condition2 | 5 | 4 |
| [29,] | Condition2\_timepoint\_5\_Sample\_5\_r2 | Condition2 | 5 | 5 |
| [30,] | Condition2\_timepoint\_5\_Sample\_5\_r3 | Condition2 | 5 | 6 |

The first column of the design matrix should contain the sample names of the data (column names of the data). The second column should indicate the condition/group factor status for each sample to be explored (e.g. sick/healthy, control/case). The third column should indicate the time point for each sample (data with aligned time points) or time value (or equivalent, e.g. age, temperature, disease progression) information in data with non-aligned time points. The fourth and final column of the design matrix should indicate the replicate / individual each sample came from. Let’s look at the exemplary design matrix a little bit more:

Unique samples:

```
unique(des_matrix1[,1])
#>  [1] "Condition1_timepoint_1_Sample_1_r1" "Condition1_timepoint_1_Sample_1_r2"
#>  [3] "Condition1_timepoint_1_Sample_1_r3" "Condition1_timepoint_2_Sample_2_r1"
#>  [5] "Condition1_timepoint_2_Sample_2_r2" "Condition1_timepoint_2_Sample_2_r3"
#>  [7] "Condition1_timepoint_3_Sample_3_r1" "Condition1_timepoint_3_Sample_3_r2"
#>  [9] "Condition1_timepoint_3_Sample_3_r3" "Condition1_timepoint_4_Sample_4_r1"
#> [11] "Condition1_timepoint_4_Sample_4_r2" "Condition1_timepoint_4_Sample_4_r3"
#> [13] "Condition1_timepoint_5_Sample_5_r1" "Condition1_timepoint_5_Sample_5_r2"
#> [15] "Condition1_timepoint_5_Sample_5_r3" "Condition2_timepoint_1_Sample_1_r1"
#> [17] "Condition2_timepoint_1_Sample_1_r2" "Condition2_timepoint_1_Sample_1_r3"
#> [19] "Condition2_timepoint_2_Sample_2_r1" "Condition2_timepoint_2_Sample_2_r2"
#> [21] "Condition2_timepoint_2_Sample_2_r3" "Condition2_timepoint_3_Sample_3_r1"
#> [23] "Condition2_timepoint_3_Sample_3_r2" "Condition2_timepoint_3_Sample_3_r3"
#> [25] "Condition2_timepoint_4_Sample_4_r1" "Condition2_timepoint_4_Sample_4_r2"
#> [27] "Condition2_timepoint_4_Sample_4_r3" "Condition2_timepoint_5_Sample_5_r1"
#> [29] "Condition2_timepoint_5_Sample_5_r2" "Condition2_timepoint_5_Sample_5_r3"
```

Conditions:

```
unique(des_matrix1[,2])
#> [1] "Condition1" "Condition2"
table(des_matrix1[,2])
```

| Condition1 | Condition2 |
| --- | --- |
| 15 | 15 |

Time points:

```
unique(des_matrix1[,3])
#> [1] "1" "2" "3" "4" "5"
table(des_matrix1[,3])
```

| 1 | 2 | 3 | 4 | 5 |
| --- | --- | --- | --- | --- |
| 6 | 6 | 6 | 6 | 6 |

Replicates:

```
unique(des_matrix1[,4])
#> [1] "1" "2" "3" "4" "5" "6"
table(des_matrix1[,4])
```

| 1 | 2 | 3 | 4 | 5 | 6 |
| --- | --- | --- | --- | --- | --- |
| 5 | 5 | 5 | 5 | 5 | 5 |

In this example, we have a dataset of 30 samples, 2 conditions, 6 replicates each with 5 time points. The timepoints in the data are aligned.

This is how a design matrix for a dataset for RolDE should look like. This gives all the essential information for RolDE it needs to determine longitudinal differential expression between the conditions.

By bare minimum, RolDE needs the data and the design matrix. By default RolDE assumes that the time points in the data are aligned. If not defined otherwise, RolDE will by default use sequential processing. However, using parallel processing and multiple threads will greatly reduce the computational time required by RolDE.

Please use set.seed() for reproducibility.

Running RolDE using parallel processing and 3 threads:

```
set.seed(1)
data1.res<-RolDE(data=data1, des_matrix=des_matrix1, n_cores=3)
```

RolDE supports the SummarizedExperiment data structure and the data and design matrix can be provided to RolDE as a SummarizedExperiment object. In this case, the *data* argument for RolDE must be a SummarizedExperiment object, where the data matrix is included as a list in the *assays* argument and the design matrix in the *colData* argument. The format of the data matrix and the design matrix within the SummarizedExperiment object must be the same as when provided separately.

Constructing a SummarizedExperiment object from data1 and the associated design matrix for RolDE:

```
SE_object_for_RolDE = SummarizedExperiment(assays=list(data1),
                                            colData = des_matrix1)
```

Running RolDE using a SummarizedExperiment object including the data and the metadata:

```
set.seed(1)
data1.res<-RolDE(data=SE_object_for_RolDE, n_cores=3)
```

The results of RolDE are returned in a list with lot of information:

```
names(data1.res)
#>  [1] "RolDE_Results"     "RegROTS_Results"   "RegROTS_P_Values"
#>  [4] "DiffROTS_Results"  "DiffROTS_P_Values" "PolyReg_Results"
#>  [7] "PolyReg_P_Values"  "ROTS_Runs"         "Method_Degrees"
#> [10] "Input"
```

The main results of RolDE are located in the first element of the provided result list. Elements 2,4 and 6 provide the result for the different modules of RolDE separately (the RegROTS, DiffROTS and PolyReg modules).

Elements 3 and 5 provide the significance values for the different ROTS runs of the RegROTS and DiffROTS modules, respectively. The used ROTS runs within those modules are given in element 8. The comparisons between the replicates in the different conditions are divided into different runs so that each sample is used only once within each run to preserve the proper degrees of freedom for statistical testing.

All the condition related significance values of the polynomial regression models in the PolyReg module are given in element 7. The used polynomial degrees for the regression models in the RegROTS and the PolyReg modules are given in element 9. And in element 10, all the inputs used by RolDE (both given by the user and those determined automatically by the method) are given.

Typically, the main (only) interest of the user is in element 1, where the main results of RolDE are given:

```
RolDE.data1<-data1.res$RolDE_Results
dim(RolDE.data1)
#> [1] 1045    4
colnames(RolDE.data1)
#> [1] "Feature ID"
#> [2] "RolDE Rank Product"
#> [3] "Estimated Significance Value"
#> [4] "Adjusted Estimated Significance Value"
```

By default, the features in the result data frame are given in the same order as entered.

Let’s order the results based on the strength of longitudinal differential expression detected by RolDE:

```
RolDE.data1<-RolDE.data1[order(as.numeric(RolDE.data1[,2])),]
head(RolDE.data1, 5)
```

|  | Feature ID | RolDE Rank Product | Estimated Significance Value | Adjusted Estimated Significance Value |
| --- | --- | --- | --- | --- |
| sp|P32263|P5CR\_YEAST | sp|P32263|P5CR\_YEAST | 4.447960 | 0.0010988 | 0.9983582 |
| P01344ups|IGF2\_HUMAN\_UPS | P01344ups|IGF2\_HUMAN\_UPS | 6.073178 | 0.0028508 | 0.9983582 |
| sp|Q04935|COX20\_YEAST | sp|Q04935|COX20\_YEAST | 7.989570 | 0.0044291 | 0.9983582 |
| sp|P40008|FMP52\_YEAST | sp|P40008|FMP52\_YEAST | 9.356095 | 0.0053161 | 0.9983582 |
| sp|P15180|SYKC\_YEAST | sp|P15180|SYKC\_YEAST | 9.619002 | 0.0061172 | 0.9983582 |

Explore the distribution of the estimated significance values:

```
hist(RolDE.data1$`Estimated Significance Value`, main = "Estimated significance values", xlab="")
```

![](data:image/png;base64...)

As can be observed, the distribution of the estimated significance values is approximately uniform. Data1 is random data; the values for the features have been randomly assigned from a normal distribution with a mean of 22 and a standard deviation of 1.5. Overall, the null hypothesis between Condition1 and Condition2 is true; the conditions are not differentially expressed and a uniform significance value distribution is expected.

After correcting for the simultaneous testing of multiple hypothesis by using the Bejamini-Hochberg (FDR) correction, no differentially epxressed feature remains with the commonly used FDR level of 0.05:

```
length(which(RolDE.data1$`Adjusted Estimated Significance Value`<=0.05))
#> [1] 0
```

The calculation of significance values in RolDE is controlled via the parameter *sigValSampN* which control if the significance values should be calculated and how many permutations should be used when determining the significance values. Computational time required by RolDE can be reduced by not calculating the significance values by setting *sigValSampN* to 0. By increasing *sigValSampN* from the default number, the significance values can be estimated more accurately but the required computational time will also increase. If parallel processing for RolDE is enabled (*n\_cores* > 1), it will also be utilized when estimating the significance values.

The estimated significance values can be adjusted by any method included in the p.adjust method in the stats package. Alternatively, q-values as defined by Storey et al. in the Bioconductor package qvalue can be used. Valid values for *sig\_adj\_meth* are then: “holm”, “hochberg”, “hommel”, “bonferroni”, “BH”, “BY”,“fdr”,“none”, “qvalue”.

### Semi-simulated spike-in dataset

In addition to the random data already explored, a semi-simulated spike-in dataset with differential expression between the conditions is also included in the RolDE package:

```
data("data3")
data("des_matrix3")
?data3
```

|  |  |
| --- | --- |
| data3 | R Documentation |

## A semi-simulated UPS1 spike-in dataset with differences in longitudinal expression for the spike-in proteins - no missing values.

### Description

A longitudinal proteomics dataset with five timepoints, two conditions and
three replicates for each sample at each timepoint in each condition. The expression
values for each protein in each sample have been generated by using the `rnorm`
function and the means and standard deviations of the corresponding proteins and samples
in the original experimental UPS1 spike-in data. In this manner, the expression for each
protein in each sample could be replicated with some random variation multiple times when
necessary. The pattern of missing values was directly copied from the used samples
in the original UPS1 spike-in dataset. All proteins with missing values have been filtered out.
Linear-like trends for the spike-in proteins for Condition 1 were generated using the 4,4,10,25 and 50 fmol samples of the original
UPS1 spike-in data. Linear-like trends for the spike-in proteins for Condition 2 were generated using the 2,4,4,10 and 25 fmol samples
of the original UPS1 spike-in data. For more information about the generation of the semi-simulated spike-in datasets,
see the original RolDE publication. In the spike-in datasets, the UPS1
spike-in proteins are expected to differ between conditions while the expression of the rest
of the proteins (the background proteins) are expected to remain stable between the conditions,
excluding experimental noise.

### Usage

```
data3
```

### Format

A matrix with 1033 rows and 30 variables.

### Source

<https://www.ebi.ac.uk/pride/archive/projects/PXD002099>

Let’s run RolDE for data3 using the Bonferroni procedure for multiple hypothesis adjustement:

```
set.seed(1)
data3.res<-RolDE(data=data3, des_matrix=des_matrix3, n_cores=3, sig_adj_meth = "bonferroni")
```

Retrieve the final RolDE results and organize the results based on strength of differential expression:

```
RolDE.data3<-data3.res$RolDE_Results
RolDE.data3<-RolDE.data3[order(as.numeric(RolDE.data3[,2])),]
head(RolDE.data3, 3)
```

|  | Feature ID | RolDE Rank Product | Estimated Significance Value | Adjusted Estimated Significance Value |
| --- | --- | --- | --- | --- |
| P41159ups|LEP\_HUMAN\_UPS | P41159ups|LEP\_HUMAN\_UPS | 5.235409 | 0 | 0 |
| P01133ups|EGF\_HUMAN\_UPS | P01133ups|EGF\_HUMAN\_UPS | 5.473704 | 0 | 0 |
| P01112ups|RASH\_HUMAN\_UPS | P01112ups|RASH\_HUMAN\_UPS | 7.894447 | 0 | 0 |

Explore the distribution of the estimated significance values:

```
hist(RolDE.data3$`Estimated Significance Value`, main = "Estimated significance values", xlab="")
```

![](data:image/png;base64...)

We can now observe, that the distribution of signficance values is different than for the random data of data1, where the null hypothesis was true. In data3, true differential expression between the conditions exists. The spike-in proteins are expected to change between the conditions, while most of the background proteins are expected to remain stable between the conditions. However, in reality this is not always the case - some background proteins might be changing too due to variations in the experimental conditions during the preparation of the dataset.

Let’s see how RolDE has ranked the spike-in proteins known to be changing between the conditions:

```
grep("ups", RolDE.data3[,1])
#>  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 21 22 23 24 25 26 27
#> [26] 29 30 31 32 33 34 35 36 37 38 39 41 42 43 44 46 47 48 54 57 60 67
```

Most of the spike-in proteins are located near the top of the result list, as expected.

How many of the proteins remain signifcant at the alpha level of 0.05 after the Bonferroni procedure to adjust for multiple hypothesis testing:

```
length(which(RolDE.data3[,4]<=0.05))
#> [1] 74
```

Findings from the DE analysis can be plotted with the *plotFindings* function included in the RolDE package:

```
?plotFindings
```

|  |  |
| --- | --- |
| plotFindings | R Documentation |

## Plot RolDE results

### Description

Plot the findings from longitudinal differential expression analysis with RolDE.

### Usage

```
plotFindings(file_name = NULL, RolDE_res, top_n, col1 = "blue", col2 = "red")
```

### Arguments

|  |  |
| --- | --- |
| `file_name` | a string indicating the file name in which the results should be plotted. Should have a ".pdf" extension. Default is NULL, no file is created. |
| `RolDE_res` | the RolDE result object. |
| `top_n` | an integer or a vector of integers indicating what top differentially expressed features should be plotted. If `top_n` is a single number, the `top_n` most differentially expressed feature will be plotted (e.g `top_n`=1 will plot the most differentially expressed feature). If `top_n` is a vector of numbers, the differentially expressed features corresponding to top detections within the given range will be plotted (e.g. `top_n`=seq(1:50) will plot the top 50 differentially expressed features). If more than one feature will be plotted, it is advisable to define a suitable file name in `file_name`. |
| `col1` | a string indicating which color should be used for Individuals / Replicates in condition 1. The default is blue. |
| `col2` | a string indicating which color should be used for Individuals / Replicates in condition 2. The default is red. |

### Details

The function plots the longitudinal expression of the top RolDE findings. The function can plot either the expression of a single finding
or multiple top findings as indicated by the `top_n`. The findings can be plotted into a pdf file as indicated by the `file_name`.
The given `file_name` should have a ".pdf" extension. If the plottable feature has missing values, a mean value over the feature values will
be imputted for visualization purposes. The missing / imputed value will be indicated with an empty circle symbol.

### Value

`plotFindings` Plots the results from the RolDE object.

### Examples

```
data("res3")
#Plotting the most DE finding. DE results are in the res3 object.
plotFindings(file_name = NULL, RolDE_res = res3, top_n = 1)
```

## Applying RolDE in example data with non aligned time points

In addition to data with aligned time points, RolDE can be applied in data with non-aligned time points. However, the *aligned* parameter in RolDE must now be set to FALSE in order for RolDE to discern that time points in the data are not aligned.

Instead of fixed time points, the integer values in the time point column 3 of the design matrix should now be replaced with continuous numerical values, or time values (e.g. age at the time of sampling).

## Changing the settings for RolDE

While RolDE performs typically very well with the default parameter values, the user might sometimes wish to alter some of these values for a specific kind of analysis. Some of the most important parameters include:

Parameter *min\_comm\_diff* controls how many common time points must two replicates (individuals) have in different conditions to be compared. The first value controls the number of common time points for the RegROTS module, while the second one controls the number of common time points for the DiffROTS module. If *min\_comm\_diff* is set to “auto”, RolDE will use a value of 3 for the RegROTS module and a value of 1 for the DiffROTS module. In the case of data with non-aligned time points, the first value of *min\_comm\_diff* controls how many time values (or similar, e.g. age, temperature) must both replicates (individuals) in different conditions have in the common time interval to be compared.

Defining larger values for the minimum number of common time points to be used in RolDE with data1:

```
set.seed(1)
data1.res<-RolDE(data=data1, des_matrix=des_matrix1, doPar=T, n_cores=3, min_comm_diff = c(4,3))
```

Using the above values for *min\_comm\_diff* requires the replicates in different conditions to have 4 common time points to be compared in the RegROTS module and 3 common time points to be compared in the DiffROTS module.

*min\_feat\_obs* controls the number of non-missing values a feature must have for a replicate (an individual) in a condition to be compared in the RegROTS module and the DiffROTS module (in data with aligned time points). A feature is required to have at least *min\_feat\_obs* non-missing values for both replicates in the different conditions to be compared. If lowered, more missing values are allowed but the analysis may become less accurate. If increased, only replicates (individuals) with less missing values for a feature are compared.

The user can control the degree of polynomials used by the RegROTS and the PolyReg modules via the *degtree\_RegROTS* and the *degree\_PolyReg parameters*. If left to “auto”, RolDE will determine the suitable degrees automatically as described in (Valikangas et al.)

Using RolDE with non default user given polynomial degrees for the RegROTS and PolyReg modules:

```
set.seed(1)
data1.res<-RolDE_Main(data=data1, des_matrix=des_matrix1, n_cores=3, degree_RegROTS = 2, degree_PolyReg = 3)
```

By default, RolDE uses fixed effects only regression with a common intercept and slope for the replicates (individuals) when time points in the data are aligned and mixed effects models with a random effect for the individual baseline (intercept) if the time points are non aligned for the PolyReg and the DiffROTS (only in data with non aligned time points) modules. This behaviour is controlled with the parameter *model\_type* and the default behaviour is induced when *model\_type* is allowed to be “auto”. However, the user can choose to use mixed effects regression modelling when appropriate by setting the parameter *model\_type* as “mixed0” for random effects for the individual baseline and setting *model\_type* as “mixed1” for an individual baseline and slope. Fixed effects only models can be chosen to be used by setting as “fixed”. Valid inputs for are “auto” (the default), “mixed0”, “mixed1” and “fixed”.

Analyzing data1 using mixed effects modelling with random intercepts for the replicates in the PolyReg module of RolDE:

```
set.seed(1)
data1.res<-RolDE_Main(data=data1, des_matrix=des_matrix1, n_cores=3, model_type="mixed0")
```

Analyzing data1 using mixed effects modelling with random intercepts and also random linear slopes for the replicates in the PolyReg AND the DiffROTS modules of RolDE:

```
set.seed(1)
data1.res<-RolDE(data=data1, des_matrix=des_matrix1, n_cores=3, model_type="mixed1")
```

Altering the *model\_type* parameter has an effect for the DiffROTS module only when the time points in the data are non-aligned. In non-aligned time point data, the expression level differences between the conditions in the DiffROTS module is examined when accounting for time-associated trends of varying complexity in the data.

## Preparation of data for RolDE

The data for RolDE needs to be appropriately preprocessed (e.g. log - transformed, normalized). RolDE does not perform any filtering or normalization for the data; such preprocessing must be performed prior to applying RolDE. Similarly, adjusting for possible confounding effects in the data must be performed before the application of RolDE.

## References

Elo, Laura, Filen S, Lahesmaa R, et al. Reproducibility-optimized test statistic for ranking genes in microarray studies. IEEE/ACM Trans. Comput. Biol. Bioinform. 2008; 5:423-31.

Suomi T, Seyednasrollah F, Jaakkola MK, et al. ROTS: An R package for reproducibility-optimized statistical testing. PLoS Comput. Biol. 2017; 13:5.

Storey JD, Bass AJ, Dabney A, et al. qvalue: Q-value estimation for false discovery rate control. 2019.

Välikangas T, Suomi T, ELo LL, et al. Enhanced longitudinal differential expression detection in proteomics with robust reproducibility optimization regression. bioRxiv 2021.

```
#Session info
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
#> [1] knitr_1.50   printr_0.3   RolDE_1.14.0
#>
#> loaded via a namespace (and not attached):
#>  [1] Matrix_1.7-4                jsonlite_2.0.0
#>  [3] compiler_4.5.1              SummarizedExperiment_1.40.0
#>  [5] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [7] parallel_4.5.1              jquerylib_0.1.4
#>  [9] doRNG_1.8.6.2               IRanges_2.44.0
#> [11] Seqinfo_1.0.0               yaml_2.3.10
#> [13] fastmap_1.2.0               lattice_0.22-7
#> [15] R6_2.6.1                    XVector_0.50.0
#> [17] S4Arrays_1.10.0             generics_0.1.4
#> [19] BiocGenerics_0.56.0         iterators_1.0.14
#> [21] DelayedArray_0.36.0         MatrixGenerics_1.22.0
#> [23] bslib_0.9.0                 rlang_1.1.6
#> [25] cachem_1.1.0                xfun_0.53
#> [27] sass_0.4.10                 SparseArray_1.10.0
#> [29] cli_3.6.5                   digest_0.6.37
#> [31] foreach_1.5.2               grid_4.5.1
#> [33] lifecycle_1.0.4             nlme_3.1-168
#> [35] S4Vectors_0.48.0            evaluate_1.0.5
#> [37] codetools_0.2-20            rngtools_1.5.2
#> [39] abind_1.4-8                 stats4_4.5.1
#> [41] rmarkdown_2.30              matrixStats_1.5.0
#> [43] tools_4.5.1                 htmltools_0.5.8.1
```