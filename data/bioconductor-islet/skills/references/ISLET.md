# **Individual-specific and cell-type-specific deconvolution using ISLET**

Hao Feng1\*, Qian Li2 and Guanqun Meng1\*\*

1Department of Population and Quantitative Health Sciences, Case Western Reserve University
2Department of Biostatistics, St. Jude Children's Research Hospital

\*hxf155@case.edu
\*\*gxm324@case.edu

#### 30 October 2025

#### Abstract

This vignette introduces the usage of the Bioconductor package ISLET (Individual-Specific ceLl typE referencing Tool). Complementary to classic deconvolution algorithms, ISLET can take cell type proportions as input, and infer the individual-specific and cell-type-specific reference panels. ISLET also offers functions to detect cell-type specific differential expression (csDE) genes. Additionally, it can test for csDE genes change rate difference between two groups, given an additional covariate of time points or age. ISLET is based on rigorous statistical framework of Expectation–Maximization(EM) algorithm, and has parallel computing embedded to provide superior computational performance.

#### Package

ISLET 1.12.0

# Contents

* [1 Install and help](#install-and-help)
  + [1.1 Install ISLET](#install-islet)
  + [1.2 How to get help](#how-to-get-help)
* [2 Introduction](#introduction)
* [3 ISLET input files](#islet-input-files)
* [4 Data preparation](#data-preparation)
* [5 Deconvolve individual-specific reference panel](#deconvolve-individual-specific-reference-panel)
* [6 Test cell-type-specific differential expression (csDE) in mean (intercept)](#test-cell-type-specific-differential-expression-csde-in-mean-intercept)
* [7 Test csDE in change-rate (slope)](#test-csde-in-change-rate-slope)
* [8 ***imply***: improving cell-type deconvolution accuracy using personalized reference profiles](#imply-improving-cell-type-deconvolution-accuracy-using-personalized-reference-profiles)
* [Session info](#session-info)

![logo](data:image/png;base64...)

# 1 Install and help

## 1.1 Install ISLET

To install the package, start R (version 4.2.0 or higher) and enter:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ISLET")
```

## 1.2 How to get help

You may post your question on ISLET’s GitHub Issue section: <https://github.com/haoharryfeng/ISLET/issues>.

# 2 Introduction

In clinical samples, the observed bulk sequencing/microarray data are often a mixture of different cell types. Because each unique cell type has its own gene expression profile, the real sequencing/microarray data are the weighted average of signals from multiple pure cell types. In high-throughput data analysis, the mixing proportions will confound with the primary phenotype-of-interest, if not properly accounted for. Over the past several years, researchers have gained substantial interests in using computational methods to deconvolute cell compositions. Under the assumption of a commonly shared feature-by-cell-type reference panel across all samples, deconvolution methods were developed. However, this assumption may not hold. For example, when repeated samples are measured for each subject, assuming a shared reference panel across different time points for each subject is a preferred choice over assuming a shared one across all the samples.

Here, we developed a method called `ISLET` (Individual-Specific ceLl typE referencing Tool), to solve for the individual-specific and cell-type-specific reference panels, once the cell type proportions are given. `ISLET` can leverage on multiple observations or temporal measurements of the same subject. `ISLET` adopted a more reasonable assumption that repeated samples from the same subject would share the same reference panel. This unknown **subject-specific** panel, treated as missing values, are modeled by Gaussian distribution in the mixed-effect regression framework and estimated by an iterative Expectation–Maximization (EM) algorithm, when combining all samples from all subjects together. This is the first statistical framework to estimate the subject-level cell-type-specific reference panel, for repeated measures. Our modeling can effectively borrow information across samples within the same subject. `ISLET` can deconvolve reference panels based on the raw counts without batch effect in library size or the normalized counts such as Transcript Per Million (TPM). In the current version, `ISLET` performs cell-type-specific differential expression analysis for two groups of subjects. Other covariates and additional groups will be added in future versions.

![](data:image/png;base64...)

Schematic overview of ISLET workflow.

`ISLET` depends on the following packages:

* *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)*, for parallel computing implementation,
* *[Matrix](https://CRAN.R-project.org/package%3DMatrix)*, for large matrices operations in *R*,
* *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*, to store rectangular matrices of experimental results.

# 3 ISLET input files

ISLET needs one input file organized into *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* objects, combining cases and controls. The input file should contain a feature by sample matrix for observed values stored in the `counts` slot. It should also use the first column in `colData` slot to store the group status (i.e. case/control), the second column in the `colData` slot to store the subject IDs mapping to each sample. The remaining columns in the `colData` slot should store the cell type proportions. In other words, use the column 3 to K+2 to store the cell type proportions for all K cell types. An example dataset `GE600` is included:

**Step 1**: Load in example data.

```
library(ISLET)
data(GE600)
ls()
```

```
## [1] "GE600_se"
```

```
GE600_se
```

```
## class: SummarizedExperiment
## dim: 10 520
## metadata(0):
## assays(1): counts
## rownames(10): gene1 gene2 ... gene9 gene10
## rowData names(0):
## colnames(520): 6454256 1716203 ... 3657905 2440389
## colData names(8): group subject_ID ... Mono Others
```

It contains a `SummarizedExperiment` object containing the following elements:

`counts` stores the gene expression value data frame of 10 genes by 520 sample, with 83 cases and 89 controls, and multiple repeated measurements (i.e. time points) per subject. Each row is a gene and each column is a sample.

```
assays(GE600_se)$counts[1:5, 1:6]
```

```
##       6454256 1716203 8125261 6264143 5640428 3764673
## gene1      52      51      30      55     194      61
## gene2       1       2       3       2       1       2
## gene3      34      41      50      16      46      23
## gene4       6       4       8       1       1       1
## gene5      67      76     107     257      86      67
```

`colData` stores the sample meta-data and the input cell type proportions. The first column is the group status (i.e. case/ctrl), the second column is the subject ID, shows the relationship between the 520 samples IDs and their 172 subject IDs. The remaining 6 columns (i.e. column 3-8) are the cell type proportions of all samples by their 6 cell types. The 6 cell types are: B cells, Tcells\_CD4, Tcells\_CD8, NK cells, Mono cells, and others cells.

```
colData(GE600_se)
```

```
## DataFrame with 520 rows and 8 columns
##               group subject_ID    Bcells Tcells_CD4 Tcells_CD8   NKcells
##         <character>  <integer> <numeric>  <numeric>  <numeric> <numeric>
## 6454256        case     210298  0.294597  0.0459207  0.0960261 0.0245194
## 1716203        case     210298  0.229228  0.0307202  0.0874901 0.0237722
## 8125261        case     210298  0.229506  0.0429694  0.1207701 0.0212622
## 6264143        case     223361  0.262023  0.0127117  0.0520090 0.0194373
## 5640428        case     223361  0.124125  0.0645530  0.0586977 0.0615492
## ...             ...        ...       ...        ...        ...       ...
## 5220586        ctrl     954888  0.426594 0.04046180  0.0854448 0.0184139
## 4601267        ctrl     954888  0.332744 0.04181961  0.0995010 0.0267642
## 6500466        ctrl     999257  0.311047 0.01287898  0.1226221 0.0312183
## 3657905        ctrl     999257  0.242521 0.01412359  0.1105289 0.0241399
## 2440389        ctrl     999257  0.353854 0.00908941  0.1042287 0.0192127
##              Mono    Others
##         <numeric> <numeric>
## 6454256 0.1003072  0.438630
## 1716203 0.1284324  0.500357
## 8125261 0.0736778  0.511814
## 6264143 0.0608441  0.592975
## 5640428 0.2664628  0.424613
## ...           ...       ...
## 5220586 0.1106113  0.318474
## 4601267 0.0876010  0.411570
## 6500466 0.1019383  0.420296
## 3657905 0.0509589  0.557728
## 2440389 0.0952407  0.418374
```

# 4 Data preparation

This is the first step required before using ISLET for individual-specific reference deconvolution or testing. This step will prepare your input data for the downstream reference panels deconvolution (function `isletSolve`) and/or testing of differential expression gene (function `isletTest`). During this step, the input data in `SummarizedExperiment` format will be further processed for ISLET. The expression values, from cases and controls respectively, will be extracted. The cell type names, number of cell types, number of cases/controls subject, number of cases/controls samples, will be obtained.

**Step 2**: Data preparation for downstream ISLET analysis.

```
study123input <- dataPrep(dat_se=GE600_se)
```

The output, are the extracted information in a S4 object, and can be overviewed by the function below:

```
study123input
```

```
## First couple of elements from cases and controls:
##       6454256 1716203 8125261 6264143 5640428 3764673
## gene1      52      51      30      55     194      61
## gene2       1       2       3       2       1       2
## gene3      34      41      50      16      46      23
##       1622468 6724003 3390865 2961023 2297235 1104596
## gene1      69      42      73      59      53      77
## gene2       4       2       3       3       4       4
## gene3      48      40      38      13      12      16
## Design matrices hidded.
## Total cell type number:
## [1] 6
## Cell type categories:
## [1] "Bcells"     "Tcells_CD4" "Tcells_CD8" "NKcells"    "Mono"
## [6] "Others"
## Total sample number and subject number:
## [1] 520 172
## Total case number and ctrl number:
## [1] 83 89
## First several subject ID for the samples:
##  [1] 210298 210298 210298 223361 223361 223361 228055 228055 228055 228055
## Data preparation type (intercept/slope):
## [1] "intercept"
```

[**Attention**] Here we have strict requirement for the input data. Each subject ID represents a unique participant across cases and controls. Subjects also need to be sorted.

# 5 Deconvolve individual-specific reference panel

**Step 3**: With the curated data `study123input` from the previous step, now we can use `ISLET` to conduct deconvolution and obtain the individual-specific and cell-type-specific reference panels. This process can be achieved by running:

```
#Use ISLET for deconvolution
res.sol <- isletSolve(input=study123input)
```

The `res.sol` is the deconvolution result list. For both case and control group, the deconvolution result is a list of length `K`, where `K` is the number of cell types. For each of the `K` elements, it is a matrix of dimension `G` by `N`. For each of the `K` cell types, it stores the deconvoluted values in a feature (`G`) by subject (`N`) matrix,

```
#View the deconvolution results
caseVal <- caseEst(res.sol)
ctrlVal <- ctrlEst(res.sol)
length(caseVal) #For cases, a list of 6 cell types' matrices.
```

```
## [1] 6
```

```
length(ctrlVal) #For controls, a list of 6 cell types' matrices.
```

```
## [1] 6
```

```
caseVal$Bcells[1:5, 1:4] #view the reference panels for B cells, for the first 5 genes and first 4 subjects, in Case group.
```

```
##           210298     223361    228055     229203
## gene1  0.0000000  0.3850878  1.539059  0.0000000
## gene2  0.7832484  1.0361946  1.603214  0.1246517
## gene3  9.3136335  5.0316322  5.117765  0.0000000
## gene4 15.4500068  2.1851800  5.344849 16.4165497
## gene5 26.7978624 31.3172845 15.189913 30.3343586
```

```
ctrlVal$Bcells[1:5, 1:4] #view the reference panels for B cells, for the first 5 genes and first 4 subjects, in Control group.
```

```
##         225490    230198    248848    253527
## gene1  0.00000  0.000000  0.000000  0.000000
## gene2  2.99786  3.093770  2.628672  2.650039
## gene3 28.95266  2.277781 37.992774  5.404299
## gene4 14.18251 30.006750  8.062981  9.056236
## gene5 62.63332 54.096193 74.357783 52.577315
```

`case.ind.ref` A list of length `K`, where `K` is the number of cell types. For each of the `K` elements in this list, it is a feature by subject matrix containing all the feature values (i.e. gene expression values), for case group. It is one of the main products the individual-specific and cell-type-specific solve algorithm. `ctrl.ind.ref` A list of length `K`, where `K` is the number of cell types. For each of the `K` elements in this list, it is a feature by subject matrix containing all the feature values (i.e., gene expression values), for control group. It is one of the main products the individual-specific and cell-type-specific solve algorithm. `mLLK` A scalar, the optimized marginal log-likelihood for the current model. It will be used in Likelihood Ratio Test (LRT).

# 6 Test cell-type-specific differential expression (csDE) in mean (intercept)

Also, with the curated data `study123input` from the previous **Step 2**, now we can test the group effect on individual reference panels, i.e., identifying csDE genes in mean or intercept. In this ‘intercept test’, we assume that the individual-specific reference panel is unchanged across time points. Note that **Step 3** can be skipped, if one only need to call csDE genes. This test is done by the following line of code:

```
#Test for csDE genes
res.test <- isletTest(input=study123input)
```

```
## csDE testing on cell type 1
## csDE testing on cell type 2
## csDE testing on cell type 3
## csDE testing on cell type 4
## csDE testing on cell type 5
## csDE testing on cell type 6
## csDE testing on 6 cell types finished
```

The result `res.test` is a matrix of p-values, in the dimension of feature by cell type. Each element is the LRT p-value, by contrasting case group and control group, for one feature in one cell type.

```
#View the test p-values
head(res.test)
```

```
##          Bcells Tcells_CD4 Tcells_CD8    NKcells       Mono     Others
## [1,] 0.06604531  0.7750110  0.6089543 0.15376472 0.69429666 0.02954946
## [2,] 0.33838223  0.0704467  0.8254034 0.56242531 0.91112552 0.94698468
## [3,] 0.59449490  0.7938664  0.4512833 0.17778619 0.05738593 0.39293734
## [4,] 0.19176879  0.1338551  0.5681148 1.00000000 1.00000000 0.75971147
## [5,] 0.39935927  0.4042231  0.7844478 0.04569687 0.62466905 0.57882828
## [6,] 0.02482765  0.6301537  0.1690033 0.91648104 0.90515297 0.93159487
```

# 7 Test csDE in change-rate (slope)

Given an additional continuous variable such as time or age, ISLET is able to compare cases and controls in the change-rate of reference profile over time. This is the ‘slope test’. Here, the assumption is that for the participants or subjects in a group, the individual reference profile could change over time, with change-rate fixed by group. At a given time point, there may be no (significant) group effect in the reference panel, but the participants still have distinct underlying reference profiles. Under this setting, it is of interest to test for such difference. Below is an example to detect reference panel change-rate difference between two groups, from data preparation to test.

We provide an additional example dataset `GE600age` from the initial step to illustrate this. Different from the dataset `GE600` above, here `GE600age` has an additional `age` column in the `colData`, besides subject ID and cell type proportions. This covariate `age` is required for the test.

**Step 1**: Load example dataset.

```
#(1) Example dataset for 'slope' test
data(GE600age)
ls()
```

```
## [1] "GE600_se"      "GE600age_se"   "caseVal"       "ctrlVal"
## [5] "res.sol"       "res.test"      "study123input"
```

Similar to previous sections, it contains one `SummarizedExperiment` objects containing the following elements:

`counts` has the gene expression value data frame of 10 genes by 520 sample, with 83 cases and 89 controls, and multiple repeated measurements (i.e. time points) per subject. Each row is a gene and each column is a sample.

```
assays(GE600age_se)$counts[1:5, 1:6]
```

```
##       6454256 1716203 8125261 6264143 5640428 3764673
## gene1      52      51      30      55     194      61
## gene2       1       2       3       2       1       2
## gene3      34      41      50      16      46      23
## gene4       6       4       8       1       1       1
## gene5      67      76     107     257      86      67
```

`colData` contains the sample meta-data. The first column is the case/ctrl group status, the second column is the subject ID, shows the relationship between the samples IDs and the corresopnding subject IDs. The third column is the age variable for each sample, which is the main variable in downstream testing. The remaining 6 columns (i.e. column 4-9) are the cell type proportions of all samples by their 6 cell types. The 6 cell types are: B cells, Tcells\_CD4, Tcells\_CD8, NK cells, Mono cells, and others cells.

```
colData(GE600age_se)
```

```
## DataFrame with 520 rows and 9 columns
##               group subject_ID       age    Bcells Tcells_CD4 Tcells_CD8
##         <character>  <integer> <numeric> <numeric>  <numeric>  <numeric>
## 6454256        case     210298   9.63333  0.294597  0.0459207  0.0960261
## 1716203        case     210298  12.26667  0.229228  0.0307202  0.0874901
## 8125261        case     210298  15.50000  0.229506  0.0429694  0.1207701
## 6264143        case     223361   8.43333  0.262023  0.0127117  0.0520090
## 5640428        case     223361  16.66667  0.124125  0.0645530  0.0586977
## ...             ...        ...       ...       ...        ...        ...
## 5220586        ctrl     954888   16.2333  0.426594 0.04046180  0.0854448
## 4601267        ctrl     954888   19.1000  0.332744 0.04181961  0.0995010
## 6500466        ctrl     999257   12.8667  0.311047 0.01287898  0.1226221
## 3657905        ctrl     999257   15.2000  0.242521 0.01412359  0.1105289
## 2440389        ctrl     999257   18.0333  0.353854 0.00908941  0.1042287
##           NKcells      Mono    Others
##         <numeric> <numeric> <numeric>
## 6454256 0.0245194 0.1003072  0.438630
## 1716203 0.0237722 0.1284324  0.500357
## 8125261 0.0212622 0.0736778  0.511814
## 6264143 0.0194373 0.0608441  0.592975
## 5640428 0.0615492 0.2664628  0.424613
## ...           ...       ...       ...
## 5220586 0.0184139 0.1106113  0.318474
## 4601267 0.0267642 0.0876010  0.411570
## 6500466 0.0312183 0.1019383  0.420296
## 3657905 0.0241399 0.0509589  0.557728
## 2440389 0.0192127 0.0952407  0.418374
```

[**Attention**] This time/age covariate must be stored in the third column in `colData`, to successfully execute this testing. The data must be sorted by subject ID, so that the multiple replicates per subject are close to each other.

**Step 2**: Data preparation.

```
#(2) Data preparation
study456input <- dataPrepSlope(dat_se=GE600age_se)
```

```
## Begin: working on data preparation as the input for ISLET algorithm.
```

```
## Complete: data preparation for ISLET.
```

**Step 3**: ‘Slope’ testing.

```
#(3) Test for slope effect(i.e. age) difference in csDE testing
age.test <- isletTest(input=study456input)
```

```
## csDE testing on cell type 1
## csDE testing on cell type 2
## csDE testing on cell type 3
## csDE testing on cell type 4
## csDE testing on cell type 5
## csDE testing on cell type 6
## csDE testing on 6 cell types finished
```

The result `age.test` is a matrix of p-values, in the dimension of feature by cell type. Each element is the LRT p-value, by contrasting case group and control group, for one feature in one cell type. In contrast to the (intercept) test described before, here is a test for difference of the expression CHANGE IN REFERENCE over time, between cases and controls.

```
#View the test p-values
head(age.test)
```

```
##          Bcells Tcells_CD4 Tcells_CD8   NKcells       Mono     Others
## [1,] 1.00000000  0.7011151 0.03172258 0.8319778 0.02029938 0.09467346
## [2,] 0.94706639  0.8048326 0.64478681 0.2653217 0.89428382 0.68854325
## [3,] 0.35398833  0.2020403 0.07030922 0.1752736 0.03322149 0.83863604
## [4,] 0.18990662  0.4711377 0.76455747 0.1210926 0.57482995 0.41169660
## [5,] 0.08643906  0.6276170 0.88240158 0.7375951 0.24992114 0.49421013
## [6,] 0.36433560  0.6580562 0.67839937 0.9286173 0.52078056 0.30568408
```

# 8 ***imply***: improving cell-type deconvolution accuracy using personalized reference profiles

To use imply to improve cell proportions by incorporating subject-specific and cell-type-specific (personalized) reference panels, you need to start with an input file organized into `SummarizedExperiment` objects, as previously described for ISLET. In this example, we will use the `GE600` dataset for illustration.

This initial step is crucial to prepare your input data for the downstream cell deconvolution using the `implyDataPrep` function. During this preparation step, the data in `SummarizedExperiment` format will undergo the following processing:

* Extraction of expression values from both cases and controls.
* Extraction of the initial cell proportions, preferably obtained from CIBERSORT.
* Determination of the total number of cell types.
* Extraction of the total number of subjects for case and control, respectively.
* Determination of the total number of samples.

By executing this preparation step, your data will be in the ideal format for subsequent personalized deconvolution with `imply`.

```
dat123 <- implyDataPrep(sim_se=GE600_se)
```

The output of this preparation step is an S4 object containing the extracted information. You can easily review this object to ensure that your data is correctly prepared.

```
dat123
```

```
## First couple of elements from samples:
##        6454256 1716203 8125261 6264143 5640428 3764673 3461244 9646374 9720100
## gene1       52      51      30      55     194      61      89      94      55
## gene2        1       2       3       2       1       2       3       5       4
## gene3       34      41      50      16      46      23      29      33      20
## gene4        6       4       8       1       1       1       1       2       2
## gene5       67      76     107     257      86      67      39      88      17
## gene6       15      11       1      13       1      20      13      15      17
## gene7        2       2       2       5       2       3       2       2       6
## gene8       26      39      63      21      31      16      11       6       5
## gene9        2       2       2       3       2       2       2       1       2
## gene10       1       1       1       0       0       2       1       1       1
##        1142414
## gene1       87
## gene2        3
## gene3       15
## gene4        1
## gene5       19
## gene6       18
## gene7        5
## gene8        4
## gene9        2
## gene10       1
## Total cell type number:
## [1] 6
## Cell type categories:
## [1] "Bcells"     "Tcells_CD4" "Tcells_CD8" "NKcells"    "Mono"
## [6] "Others"
## Total case subjects and ctrl subjects:
## [1] 83 89
## Total sample number and subject number:
## [1] 520 172
## First couple initial cell proportion, ideally solved by CIBERSORT:
##            Bcells Tcells_CD4 Tcells_CD8    NKcells       Mono    Others
## 6454256 0.2945971 0.04592068 0.09602612 0.02451937 0.10030720 0.4386295
## 1716203 0.2292283 0.03072017 0.08749011 0.02377217 0.12843240 0.5003568
## 8125261 0.2295064 0.04296941 0.12077010 0.02126223 0.07367780 0.5118141
## 6264143 0.2620226 0.01271168 0.05200897 0.01943731 0.06084408 0.5929753
## 5640428 0.1241247 0.06455296 0.05869773 0.06154920 0.26646283 0.4246126
## 3764673 0.3458079 0.01697162 0.06552412 0.03946399 0.08397481 0.4482575
## First and last few group labels and subject IDs samples:
##     group subject_ID
## 1       1     210298
## 2       1     210298
## 3       1     210298
## 4       1     223361
## 5       1     223361
## 6       1     223361
## 515     0     954888
## 516     0     954888
## 517     0     954888
## 518     0     999257
## 519     0     999257
## 520     0     999257
```

With the curated input `dat123` from the previous step, now we can use `imply` to conduct personalized cell deconvolution to obtain the improved cell proportions. This process can be achieved by running:

```
#Use imply for deconvolution
result <- imply(dat123)
```

The `result` is a list of deconvolution results returned by `imply`, which includes two elements: `p.ref` and `imply.prop`. `p.ref` is the estimated personalized reference panels. It is an array of dimension by by , where is the total number of genetic features, is the total number of cell types, and is the total number of subjects. `imply.prop` is the updated cell proportion results improved by personalized reference panels from . It is a `data.frame` of by , where is the total number of samples across all subjects.

The outputs and can be extracted as shown below:

```
#View the subject-specific and cell-type-specific reference panels solved
#by linear mixed-effect models of the first subject
result$p.ref[,,1]
```

```
##            Bcells Tcells_CD4  Tcells_CD8    NKcells       Mono      Others
## gene1   0.0000000 457.412078   0.0000000  47.572128 453.145624 105.4878507
## gene2   0.0000000   4.941950   0.4821258   0.000000   5.780701   2.4575975
## gene3   1.2374451   0.000000   7.6474391 102.549737 115.792000  53.8641647
## gene4  13.3185857   3.141818  23.1518600   7.635743   0.000000   1.0442168
## gene5  18.9326266 160.965285   0.0000000   0.000000   0.000000 217.1606260
## gene6  18.2386789  40.914077   0.0000000   0.000000   0.000000  25.0825985
## gene7   0.3398822   0.000000   3.9524367  21.026248   5.332610   4.6266028
## gene8  11.1717680   8.731575 162.8195562 191.632318   0.000000  24.3271909
## gene9   0.2267970   0.000000   7.1719313   7.389022   0.000000   2.7897725
## gene10  0.7947675   0.000000  11.2046716  11.275438   0.000000   0.1643296
```

```
#View the improved cell deconvolution results
head(result$imply.prop)
```

```
##             Bcells Tcells_CD4 Tcells_CD8    NKcells       Mono    Others
## 6454256 0.47234621          0 0.00000000 0.11432272 0.05527426 0.3580568
## 1716203 0.17726935          0 0.00000000 0.25446331 0.02875361 0.5395137
## 8125261 0.07459335          0 0.22284753 0.14882205 0.00000000 0.5537371
## 6264143 0.19276825          0 0.05662827 0.00000000 0.00000000 0.7506035
## 5640428 0.00000000          0 0.26471064 0.05190627 0.34160223 0.3417808
## 3764673 0.71903333          0 0.00000000 0.04854783 0.06819265 0.1642262
```

```
tail(result$imply.prop)
```

```
##            Bcells Tcells_CD4 Tcells_CD8    NKcells       Mono     Others
## 4959689 0.4499954 0.05482048 0.00000000 0.15350717 0.28371795 0.05795896
## 5220586 0.3615109 0.09766623 0.40489579 0.00000000 0.00000000 0.13592710
## 4601267 0.0000000 0.25745801 0.66326235 0.03197499 0.00000000 0.04730465
## 6500466 0.6503862 0.00000000 0.17027042 0.09648100 0.08286235 0.00000000
## 3657905 0.5146023 0.00000000 0.09742423 0.08831355 0.10751921 0.19214077
## 2440389 0.8654349 0.00000000 0.00000000 0.01070423 0.11325433 0.01060655
```

# Session info

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
## [1] stats4    parallel  stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] ISLET_1.12.0                nnls_1.6
##  [3] lme4_1.1-37                 SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocParallel_1.44.0
## [15] Matrix_1.7-4                BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         SparseArray_1.10.0  lattice_0.22-7
##  [4] magrittr_2.0.4      digest_0.6.37       evaluate_1.0.5
##  [7] grid_4.5.1          bookdown_0.45       fastmap_1.2.0
## [10] jsonlite_2.0.0      BiocManager_1.30.26 purrr_1.1.0
## [13] codetools_0.2-20    jquerylib_0.1.4     abind_1.4-8
## [16] reformulas_0.4.2    Rdpack_2.6.4        cli_3.6.5
## [19] rlang_1.1.6         rbibutils_2.3       XVector_0.50.0
## [22] splines_4.5.1       cachem_1.1.0        DelayedArray_0.36.0
## [25] yaml_2.3.10         S4Arrays_1.10.0     tools_4.5.1
## [28] nloptr_2.2.1        dplyr_1.1.4         minqa_1.2.8
## [31] boot_1.3-32         vctrs_0.6.5         R6_2.6.1
## [34] mime_0.13           lifecycle_1.0.4     MASS_7.3-65
## [37] pkgconfig_2.0.3     pillar_1.11.1       bslib_0.9.0
## [40] glue_1.8.0          Rcpp_1.1.0          tidyselect_1.2.1
## [43] tibble_3.3.0        xfun_0.53           knitr_1.50
## [46] htmltools_0.5.8.1   nlme_3.1-168        rmarkdown_2.30
## [49] compiler_4.5.1
```