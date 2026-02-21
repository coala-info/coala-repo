# How to use TDbasedUFEadv

Y-h. Taguchi1\*

1Department of Physics, Chuo University, Tokyo 112-8551, Japan

\*tag@granular.com

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Integrated analyses of two omics profiles](#integrated-analyses-of-two-omics-profiles)
  + [2.1 When features are shared.](#when-features-are-shared.)
    - [2.1.1 Reduction of required memory using partial summation.](#reduction-of-required-memory-using-partial-summation.)
  + [2.2 When samples are shared](#when-samples-are-shared)
    - [2.2.1 Reduction of required memory using partial summation.](#reduction-of-required-memory-using-partial-summation.-1)
* [3 Integrated analysis of multiple omics data](#integrated-analysis-of-multiple-omics-data)
  + [3.1 When samples are shared](#when-samples-are-shared-1)
  + [3.2 When features are shared](#when-features-are-shared)

```
library(TDbasedUFEadv)
library(Biobase)
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
library(RTCGA.rnaseq)
library(TDbasedUFE)
library(MOFAdata)
library(TDbasedUFE)
library(RTCGA.clinical)
```

# 1 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("TDbasedUFEadv")
```

# 2 Integrated analyses of two omics profiles

Here is a flowchart how we can make use of individual functions in
[TDbasedUFE](https://doi.org/doi%3A10.18129/B9.bioc.TDbasedUFE) and TDbasedUFEadv.

![](data:image/jpeg;base64...)

Relationship among functions in TDbasedUFE and TDbasedUFEadv

## 2.1 When features are shared.

In order to make use of [TDbasedUFE](https://doi.org/doi%3A10.18129/B9.bioc.TDbasedUFE) for the drug repositioning, we previously
proposed(Taguchi [2017](#ref-Taguchi2017)[a](#ref-Taguchi2017)) the integrated analysis of two gene expression profiles,
each of which is composed of gene expression of drug treated one and disease
one. At first, we try to prepare two omics profiles, expDrug and expDisease,
that represent gene expression profiles of cell lines treated by various drugs
and a cell line of diseases by

```
Cancer_cell_lines <- list(ACC.rnaseq, BLCA.rnaseq, BRCA.rnaseq, CESC.rnaseq)
Drug_and_Disease <- prepareexpDrugandDisease(Cancer_cell_lines)
expDrug <- Drug_and_Disease$expDrug
expDisease <- Drug_and_Disease$expDisease
rm(Cancer_cell_lines)
```

expDrug is taken from RTCGA package and those associated with Drugs based upon
(Ding, Zu, and Gu [2016](#ref-Ding2016)). Those files are listed in drug\_response.txt included in Clinical
drug responses at <http://lifeome.net/supp/drug_response/>.
expDisease is composed of files in BRCA.rnaseq, but not included in expDrug
(For more details, see source code of prepareexpDrugandDisease).
Then prepare a tensor as

```
Z <- prepareTensorfromMatrix(
  exprs(expDrug[seq_len(200), seq_len(100)]),
  exprs(expDisease[seq_len(200), seq_len(100)])
)
sample <- outer(
  colnames(expDrug)[seq_len(100)],
  colnames(expDisease)[seq_len(100)], function(x, y) {
    paste(x, y)
  }
)
Z <- PrepareSummarizedExperimentTensor(
  sample = sample, feature = rownames(expDrug)[seq_len(200)], value = Z
)
```

In the above, sample are pairs of file IDs taken from expDrug and expDisease.
Since full data cannot be treated because of memory restriction, we restricted
the first two hundred features and the first one hundred samples, respectively
(In the below, we will introduce how to deal with the full data sets).

Then HOSVD is applied to a tensor as

```
HOSVD <- computeHosvd(Z)
#>
  |
  |                                                                      |   0%
  |
  |=======================                                               |  33%
  |
  |===============================================                       |  67%
  |
  |======================================================================| 100%
```

Here we tries to find if Cisplatin causes distinct expression (0: cell lines
treated with drugs other than Cisplatin, 1: cell lines treated with Cisplatin)
and those between two classes (1 vs 2) of BRCA (in this case, there are no
meaning of two classes) within top one hundred samples.

```
Cond <- prepareCondDrugandDisease(expDrug)
cond <- list(NULL, Cond[, colnames = "Cisplatin"][seq_len(100)], rep(1:2, each = 50))
```

Then try to select singular value vectors attributed to objects.
When you try this vignettes, although you can do it in the interactive
mode (see below), here we assume that you have already finished the selection.

```
input_all <- selectSingularValueVectorLarge(HOSVD,cond,input_all=c(2,9)) #Batch mode
```

![](data:image/png;base64...)![](data:image/png;base64...)

In the case you prefer to select by yourself you can execute interactive mode.

```
input_all <- selectSingularValueVectorLarge(HOSVD,cond)
```

When you can see `Next'',`Prev’‘, and ``Select’’ radio buttons by which you
can performs selection as well as histogram and standard deviation optimization
by which you can verify the success of selection interactively.

Next we select which genes’ expression is altered by Cisplatin.

```
index <- selectFeature(HOSVD,input_all,de=0.05)
```

![](data:image/png;base64...)

You might need to specify suitable value for de which is initial value of
standard deviation.

Then we get the following plot.

Finally, list the genes selected as those associated with distinct expression.

```
head(tableFeatures(Z,index))
#>       Feature      p value adjusted p value
#> 4   ACADVL.37 2.233863e-24     4.467726e-22
#> 6     ACLY.47 1.448854e-19     1.448854e-17
#> 1       A2M.2 6.101507e-16     4.067671e-14
#> 3 ABHD2.11057 3.934360e-10     1.967180e-08
#> 2     AARS.16 1.449491e-06     5.797964e-05
#> 5 ACIN1.22985 6.510593e-06     2.170198e-04
```

```
rm(Z)
rm(HOSVD)
detach("package:RTCGA.rnaseq")
rm(SVD)
#> Warning in rm(SVD): object 'SVD' not found
```

The described methods were frequently used
in the studies(Taguchi [2017](#ref-Taguchi2017a)[b](#ref-Taguchi2017a)) (Taguchi [2018](#ref-Taguchi2018)) (Taguchi and Turki [2020](#ref-Taguchi2020)) by maintainers.

### 2.1.1 Reduction of required memory using partial summation.

In the case that there are large number of features, it is impossible to apply
HOSVD to a full tensor (Then we have reduced the size of tensor).
In this case, we apply SVD instead of HOSVD to matrix
generated from a tensor as follows.
In contrast to the above where only top two hundred features and top one hundred
samples are included, the following one includes all features and all samples since
it can save required memory because partial summation of features.

```
SVD <- computeSVD(exprs(expDrug), exprs(expDisease))
Z <- t(exprs(expDrug)) %*% exprs(expDisease)
sample <- outer(
  colnames(expDrug), colnames(expDisease),
  function(x, y) {
    paste(x, y)
  }
)
Z <- PrepareSummarizedExperimentTensor(
  sample = sample,
  feature = rownames(expDrug), value = Z
)
```

Nest select singular value vectors attributed to drugs and cell lines then
identify features associated with altered expression by treatment of
Cisplatin as well as distinction between two classes. Again, it included
all samples for expDrug and expDisease.

```
cond <- list(NULL,Cond[,colnames="Cisplatin"],rep(1:2,each=dim(SVD$SVD$v)[1]/2))
```

Next we select singular value vectors and optimize standard deviation
as batch mode

```
index_all <- selectFeatureRect(SVD,cond,de=c(0.01,0.01),
                               input_all=3) #batch mode
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)
Again you need to select suitable de by trials and errors.

For interactive mode, one should do

```
index_all <- selectFeatureRect(SVD,cond,de=c(0.01,0.01))
```

but it is not possible in vignettes that does not allow interactive mode.

Then you can see selected features as

```
head(tableFeatures(Z,index_all[[1]]))
#>         Feature p value adjusted p value
#> 15      ACTB.60       0                0
#> 22   ADAM6.8755       0                0
#> 42  AHNAK.79026       0                0
#> 150   AZGP1.563       0                0
#> 152     B2M.567       0                0
#> 219     C4A.720       0                0
head(tableFeatures(Z,index_all[[2]]))
#>         Feature p value adjusted p value
#> 7   ABHD2.11057       0                0
#> 14      ACTB.60       0                0
#> 18   ADAM6.8755       0                0
#> 36  AHNAK.79026       0                0
#> 95    AZGP1.563       0                0
#> 135     C4A.720       0                0
```

The upper one is for distinct expression between cell lines treated with
Cisplatin and other cell lines and the lower one is for distinct expression
between two classes of BRCA cell lines.

Although they are highly coincident, not fully same ones (Row: expDrug,
column:expDisease).

```
table(index_all[[1]]$index,index_all[[2]]$index)
#>
#>         FALSE  TRUE
#>   FALSE 18455   185
#>   TRUE    949   942
```

Confusion matrix of features selected between expDrug and expDisease.

The described methods were frequently used in the studies(Taguchi and Turki [2019](#ref-Taguchi2019a)) by maintainers.

```
rm(Z)
rm(SVD)
```

## 2.2 When samples are shared

The above procedure can be used when two omics data that shares samples must be integrated.
Prepare data set as

```
data("CLL_data")
data("CLL_covariates")
```

(see vignettes QuickStart in [TDbasedUFE](https://doi.org/doi%3A10.18129/B9.bioc.TDbasedUFE) for more details about this
data set).
Generate tensor from matrix as in the above, but since not features but
samples are shared between two matrices,
the resulting Z has samples as features and features as samples, respectively.

```
Z <- prepareTensorfromMatrix(
  t(CLL_data$Drugs[seq_len(200), seq_len(50)]),
  t(CLL_data$Methylation[seq_len(200), seq_len(50)])
)
Z <- prepareTensorRect(
  sample = colnames(CLL_data$Drugs)[seq_len(50)],
  feature = list(
    Drugs = rownames(CLL_data$Drugs)[seq_len(200)],
    Methylatiion = rownames(CLL_data$Methylation)[seq_len(200)]
  ),
  sampleData = list(CLL_covariates$Gender[seq_len(50)]),
  value = Z
)
```

HOSVD was applied to Z as

```
HOSVD <- computeHosvd(Z)
#>
  |
  |                                                                      |   0%
  |
  |=======================                                               |  33%
  |
  |===============================================                       |  67%
  |
  |======================================================================| 100%
```

```
cond <- list(attr(Z,"sampleData")[[1]],NULL,NULL)
```

Condition is distinction between male and female
(see QucikStart in TDbasedUFE package).
Then try to find singular value vectors distinct between male and female
in interactive mode.

```
index_all <- selectFeatureTransRect(HOSVD,cond,de=c(0.01,0.01),
                                    input_all=8) #batch mode
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)
In the above, selection was supposed to be performed before executing the
above, since vignettes does not allow interactive mode.
In actual, you need to execute it in interactive mode

```
index_all <- selectFeatureTransRect(HOSVD,cond,de=c(0.01,0.01))
```

and try to select iteratively. Selected features can be shown in the below.

```
head(tableFeaturesSquare(Z,index_all,1))
#>   Feature      p value adjusted p value
#> 6 D_041_1 8.625818e-12     1.725164e-09
#> 1 D_001_1 2.648615e-07     2.648615e-05
#> 5 D_020_1 6.373260e-07     4.248840e-05
#> 2 D_001_2 3.526011e-06     1.763006e-04
#> 3 D_007_1 7.228555e-06     2.891422e-04
#> 4 D_007_2 5.526041e-05     1.842014e-03
head(tableFeaturesSquare(Z,index_all,2))
#> [1] Feature          p value          adjusted p value
#> <0 rows> (or 0-length row.names)
```

This method was used in the studies(Taguchi [2019](#ref-Taguchi2019)) by the maintainer.

### 2.2.1 Reduction of required memory using partial summation.

As in the case where two omics profiles share features, in the case where two
omics data share the samples, we can also take an alternative approach where
SVD is applied to an matrix generated from a tensor by taking partial summation.

```
SVD <- computeSVD(t(CLL_data$Drugs), t(CLL_data$Methylation))
Z <- CLL_data$Drugs %*% t(CLL_data$Methylation)
sample <- colnames(CLL_data$Methylation)
Z <- prepareTensorRect(
  sample = sample,
  feature = list(rownames(CLL_data$Drugs), rownames(CLL_data$Methylation)),
  value = array(NA, dim(Z)), sampleData = list(CLL_covariates[, 1])
)
```

Condition is also distinction between male (m) and female (f).

```
cond <- list(NULL,attr(Z,"sampleData")[[1]],attr(Z,"sampleData")[[1]])
```

In order to apply the previous function to SVD, we exchange feature singular
value vectors with sample singular value vectors.

```
SVD <- transSVD(SVD)
```

Then try to find which sample singular value vectors should be selected and
which features are selected based upon feature singular value vectors
corresponding to selected sample feature vectors.
Although I do not intend to repeat whole process, we decided to select the
sixth singular value vectors which are some what distinct between male
and female. Since package does not allow us interactive mode, we place here batch mode.

```
index_all <- selectFeatureRect(SVD,cond,de=c(0.5,0.5),input_all=6) #batch mode
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

In the real usage, we can activate
selectFeatureRect in interactive mode as well.

```
index_all <- selectFeatureRect(SVD,cond,de=c(0.5,0.5))
```

Then we can list the Drugs and Methylation sites selected as being distinct
between male and female.

```
head(tableFeaturesSquare(Z,index_all,1))
#>   Feature      p value adjusted p value
#> 1 D_004_4 1.210706e-11     3.753189e-09
#> 5 D_040_4 1.759860e-08     2.727782e-06
#> 4 D_040_3 1.473704e-05     1.522828e-03
#> 3 D_021_2 6.873730e-05     5.072336e-03
#> 2 D_007_3 8.181187e-05     5.072336e-03
head(tableFeaturesSquare(Z,index_all,2))
#> [1] Feature          p value          adjusted p value
#> <0 rows> (or 0-length row.names)
```

This method was used in many studies(Taguchi and Ng [2018](#ref-Taguchi2018a)) (Ng and Y [2020](#ref-Taguchi2020a)) by maintainer.

# 3 Integrated analysis of multiple omics data

Here is a flowchart how we can make use of individual functions in TDbasedUFE and TDbasedUFEadv.

![](data:image/jpeg;base64...)

Relationship among functions in TDbasedUFE and TDbasedUFEadv

## 3.1 When samples are shared

As an alternative approach that can integrate multiple omics that share sample,
we propose the method that makes use of projection provided by SVD.

We prepare a tensor that is a bundle of the first ten singular value vectors
generated by applying SVD to individual omics profiles.

```
data("CLL_data")
data("CLL_covariates")
Z <- prepareTensorfromList(CLL_data, 10L)
Z <- PrepareSummarizedExperimentTensor(
  feature = character("1"),
  sample = array(colnames(CLL_data$Drugs), 1), value = Z,
  sampleData = list(CLL_covariates[, 1])
)
```

Then HOSVD was applied to a tensor

```
HOSVD <- computeHosvd(Z,scale=FALSE)
#>
  |
  |                                                                      |   0%
  |
  |=======================                                               |  33%
  |
  |===============================================                       |  67%
  |
  |======================================================================| 100%
```

Next we select singular value vectors attributed to samples.
In order to select those distinct between male (m) and female (f),
we set conditions as

```
cond <- list(NULL,attr(Z,"sampleData")[[1]],seq_len(4))
```

But here in order to include TDbasedUFEadv into package, we are forced to
execute function as batch mode as

```
input_all <- selectSingularValueVectorLarge(HOSVD,
  cond,
  input_all = c(12, 1)
) # batch mode
```

![](data:image/png;base64...)![](data:image/png;base64...)
Interactive more can be activated as

```
input_all <- selectSingularValueVectorLarge(HOSVD,cond)
```

Although we do not intend to repeat how to use menu in interactive mode, please
select the 12th one and the third one.

Finally, we perform the following function to select features in individual
omics profiles in an batch mode,
since packaging does not allow interactive mode.

```
HOSVD$U[[1]] <- HOSVD$U[[2]]
index_all <- selectFeatureSquare(HOSVD, input_all, CLL_data,
  de = c(0.5, 0.1, 0.1, 1), interact = FALSE
) # Batch mode
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

In actual usage, you can activate interactive mode as

```
HOSVD$U[[1]] <- HOSVD$U[[2]]
index_all <- selectFeatureSquare(HOSVD, input_all, CLL_data,
  de = c(0.5, 0.1, 0.1, 1)
)
```

Finally, we list the selected features for four omics profiles that share samples.

```
for (id in c(1:4))
{
  attr(Z, "feature") <- rownames(CLL_data[[id]])
  print(tableFeatures(Z, index_all[[id]]))
}
#> [1] Feature          p value          adjusted p value
#> <0 rows> (or 0-length row.names)
#> [1] Feature          p value          adjusted p value
#> <0 rows> (or 0-length row.names)
#>            Feature      p value adjusted p value
#> 5  ENSG00000173110 3.368388e-10     1.684194e-06
#> 2  ENSG00000214787 1.017605e-09     2.544013e-06
#> 12 ENSG00000204389 5.527594e-08     9.212657e-05
#> 16 ENSG00000070808 1.274235e-07     1.592794e-04
#> 14 ENSG00000168878 1.821868e-07     1.821868e-04
#> 17 ENSG00000183876 3.708588e-07     3.090490e-04
#> 15 ENSG00000204388 9.345517e-07     6.675370e-04
#> 1  ENSG00000186522 2.802006e-06     1.751254e-03
#> 7  ENSG00000053918 6.473465e-06     3.596369e-03
#> 3  ENSG00000152953 8.284655e-06     4.142327e-03
#> 4  ENSG00000136237 1.164833e-05     5.294694e-03
#> 11 ENSG00000071246 1.453660e-05     6.056918e-03
#> 10 ENSG00000185920 2.170178e-05     7.771502e-03
#> 18 ENSG00000078900 2.176021e-05     7.771502e-03
#> 13 ENSG00000189325 2.833035e-05     9.443449e-03
#> 9  ENSG00000165259 3.070426e-05     9.595083e-03
#> 6  ENSG00000140443 3.499777e-05     9.772303e-03
#> 8  ENSG00000170160 3.518029e-05     9.772303e-03
#>    Feature      p value adjusted p value
#> 1 del17p13 0.0001409456      0.009725248
```

This method was used in many studies(Taguchi and Turki [2022](#ref-Taguchi2022)) by maintainer.

## 3.2 When features are shared

Now we discuss what to do when multiple omics data share not samples but
features. We prepare data set from RTCGA.rnaseq as follows, with retrieving
reduced partial sets from four ones. One should notice that RTCGA is an old
package from TCGA (as for 2015). I used it only for demonstration purpose.
If you would like to use TCGA for your research, I recommend you to use
more modern packages, e.g., curatedTCGAData in Bioconductor.

```
library(RTCGA.rnaseq) #it must be here, not in the first chunk
Multi <- list(
  BLCA.rnaseq[seq_len(100), 1 + seq_len(1000)],
  BRCA.rnaseq[seq_len(100), 1 + seq_len(1000)],
  CESC.rnaseq[seq_len(100), 1 + seq_len(1000)],
  COAD.rnaseq[seq_len(100), 1 + seq_len(1000)]
)
```

Multi includes four objects, each of which is matrix that represent 100 samples (rows) and 1000 (features). Please note it is different from usual cases where columns and rows are features and samples, respectively. They are marge into tensor as follows

```
Z <- prepareTensorfromList(Multi,10L)
Z <- aperm(Z,c(2,1,3))
```

The function, prepareTeansorfromList which was used in the previous subsection
where samples are shared, can be used as it is. However, the first and second
modes of a tensor must be exchanged by aperm function for the latter analyses,
because of the difference as mentioned in the above. Then tensor object
associated with various information is generated as usual as follows and
HOSVD was applied to it.

```
Clinical <- list(BLCA.clinical, BRCA.clinical, CESC.clinical, COAD.clinical)
Multi_sample <- list(
  BLCA.rnaseq[seq_len(100), 1, drop = FALSE],
  BRCA.rnaseq[seq_len(100), 1, drop = FALSE],
  CESC.rnaseq[seq_len(100), 1, drop = FALSE],
  COAD.rnaseq[seq_len(100), 1, drop = FALSE]
)
# patient.stage_event.tnm_categories.pathologic_categories.pathologic_m
ID_column_of_Multi_sample <- c(770, 1482, 773, 791)
# patient.bcr_patient_barcode
ID_column_of_Clinical <- c(20, 20, 12, 14)
Z <- PrepareSummarizedExperimentTensor(
  feature = colnames(ACC.rnaseq)[1 + seq_len(1000)],
  sample = array("", 1), value = Z,
  sampleData = prepareCondTCGA(
    Multi_sample, Clinical,
    ID_column_of_Multi_sample, ID_column_of_Clinical
  )
)
HOSVD <- computeHosvd(Z)
#>
  |
  |                                                                      |   0%
  |
  |=======================                                               |  33%
  |
  |===============================================                       |  67%
  |
  |======================================================================| 100%
```

In order to see which singular value vectors attributed to samples are used for the selection of singular value vectors attributed to features, we need to assign sample conditions.

```
cond<- attr(Z,"sampleData")
```

Since package does not allow us to include interactive mode, we place here batch mode as follows.
Finally, selected feature are listed as follows.

```
index <- selectFeatureProj(HOSVD,Multi,cond,de=1e-3,input_all=3) #Batch mode
```

![](data:image/png;base64...)![](data:image/png;base64...)

```
head(tableFeatures(Z,index))
#>       Feature       p value adjusted p value
#> 10    ACTB|60  0.000000e+00     0.000000e+00
#> 11   ACTG1|71  0.000000e+00     0.000000e+00
#> 37  ALDOA|226  0.000000e+00     0.000000e+00
#> 19 ADAM6|8755 5.698305e-299    1.424576e-296
#> 22  AEBP1|165 1.057392e-218    2.114785e-216
#> 9    ACTA2|59 7.862975e-198    1.310496e-195
```

In actual, you can activate interactive mode as

```
par(mai=c(0.3,0.2,0.2,0.2))
index <- selectFeatureProj(HOSVD,Multi,cond,de=1e-3)
```

Although we do not intend to explain how to use menu interactively,
we select the third singular value vectors as shown in above.

This method was used in many studies(Taguchi and Turki [2021](#ref-Taguchi2021)) by maintainer.

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
#>  [1] RTCGA.rnaseq_20151101.39.0   MOFAdata_1.25.0
#>  [3] Biobase_2.70.0               BiocGenerics_0.56.0
#>  [5] generics_0.1.4               STRINGdb_2.22.0
#>  [7] enrichR_3.4                  RTCGA.clinical_20151101.39.0
#>  [9] RTCGA_1.40.0                 enrichplot_1.30.0
#> [11] DOSE_4.4.0                   TDbasedUFEadv_1.10.0
#> [13] TDbasedUFE_1.10.0            BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] rTensor_1.4.9           splines_4.5.1           later_1.4.4
#>   [4] bitops_1.0-9            ggplotify_0.1.3         tibble_3.3.0
#>   [7] R.oo_1.27.1             XML_3.99-0.19           lifecycle_1.0.4
#>  [10] rstatix_0.7.3           processx_3.8.6          lattice_0.22-7
#>  [13] backports_1.5.0         magrittr_2.0.4          sass_0.4.10
#>  [16] rmarkdown_2.30          jquerylib_0.1.4         yaml_2.3.10
#>  [19] plotrix_3.8-4           httpuv_1.6.16           otel_0.2.0
#>  [22] ggtangle_0.0.7          cowplot_1.2.0           chromote_0.5.1
#>  [25] DBI_1.2.3               RColorBrewer_1.1-3      abind_1.4-8
#>  [28] rvest_1.0.5             GenomicRanges_1.62.0    purrr_1.1.0
#>  [31] R.utils_2.13.0          RCurl_1.98-1.17         hash_2.2.6.3
#>  [34] yulab.utils_0.2.1       WriteXLS_6.8.0          rappdirs_0.3.3
#>  [37] gdtools_0.4.4           IRanges_2.44.0          KMsurv_0.1-6
#>  [40] S4Vectors_0.48.0        ggrepel_0.9.6           tidytree_0.4.6
#>  [43] proto_1.0.0             codetools_0.2-20        xml2_1.4.1
#>  [46] tximportData_1.37.5     tidyselect_1.2.1        aplot_0.2.9
#>  [49] farver_2.1.2            viridis_0.6.5           stats4_4.5.1
#>  [52] Seqinfo_1.0.0           jsonlite_2.0.0          Formula_1.2-5
#>  [55] survival_3.8-3          systemfonts_1.3.1       tools_4.5.1
#>  [58] chron_2.3-62            treeio_1.34.0           Rcpp_1.1.0
#>  [61] glue_1.8.0              gridExtra_2.3           xfun_0.53
#>  [64] qvalue_2.42.0           ggthemes_5.1.0          websocket_1.4.4
#>  [67] dplyr_1.1.4             withr_3.0.2             BiocManager_1.30.26
#>  [70] fastmap_1.2.0           caTools_1.18.3          digest_0.6.37
#>  [73] R6_2.6.1                mime_0.13               gridGraphics_0.5-1
#>  [76] GO.db_3.22.0            gtools_3.9.5            dichromat_2.0-0.1
#>  [79] RSQLite_2.4.3           R.methodsS3_1.8.2       tidyr_1.3.1
#>  [82] fontLiberation_0.1.0    data.table_1.17.8       htmlwidgets_1.6.4
#>  [85] httr_1.4.7              sqldf_0.4-11            pkgconfig_2.0.3
#>  [88] gtable_0.3.6            blob_1.2.4              S7_0.2.0
#>  [91] XVector_0.50.0          survMisc_0.5.6          htmltools_0.5.8.1
#>  [94] fontBitstreamVera_0.1.1 carData_3.0-5           bookdown_0.45
#>  [97] fgsea_1.36.0            scales_1.4.0            png_0.1-8
#> [100] ggfun_0.2.0             knitr_1.50              km.ci_0.5-6
#> [103] tzdb_0.5.0              reshape2_1.4.4          rjson_0.2.23
#> [106] nlme_3.1-168            curl_7.0.0              cachem_1.1.0
#> [109] zoo_1.8-14              stringr_1.5.2           KernSmooth_2.23-26
#> [112] parallel_4.5.1          AnnotationDbi_1.72.0    pillar_1.11.1
#> [115] grid_4.5.1              vctrs_0.6.5             gplots_3.2.0
#> [118] promises_1.4.0          ggpubr_0.6.2            car_3.1-3
#> [121] xtable_1.8-4            tximport_1.38.0         evaluate_1.0.5
#> [124] readr_2.1.5             gsubfn_0.7              cli_3.6.5
#> [127] compiler_4.5.1          rlang_1.1.6             crayon_1.5.3
#> [130] ggsignif_0.6.4          labeling_0.4.3          survminer_0.5.1
#> [133] ps_1.9.1                plyr_1.8.9              fs_1.6.6
#> [136] ggiraph_0.9.2           stringi_1.8.7           viridisLite_0.4.2
#> [139] BiocParallel_1.44.0     assertthat_0.2.1        Biostrings_2.78.0
#> [142] lazyeval_0.2.2          fontquiver_0.2.1        GOSemSim_2.36.0
#> [145] Matrix_1.7-4            hms_1.1.4               patchwork_1.3.2
#> [148] bit64_4.6.0-1           ggplot2_4.0.0           KEGGREST_1.50.0
#> [151] shiny_1.11.1            igraph_2.2.1            broom_1.0.10
#> [154] memoise_2.0.1           bslib_0.9.0             ggtree_4.0.0
#> [157] fastmatch_1.1-6         bit_4.6.0               ape_5.8-1
```

Ding, Zijian, Songpeng Zu, and Jin Gu. 2016. “Evaluating the molecule-based prediction of clinical drug responses in cancer.” *Bioinformatics* 32 (19): 2891–5. <https://doi.org/10.1093/bioinformatics/btw344>.

Ng, Ka-Lok, and -H Taguchi Y. 2020. “Identification of miRNA signatures for kidney renal clear cell carcinoma using the tensor-decomposition method.” *Scientific Reports* 10 (1): 15149. <https://doi.org/10.1038/s41598-020-71997-6>.

Taguchi, Y-H. 2017a. “Identification of candidate drugs using tensor-decomposition-based unsupervised feature extraction in integrated analysis of gene expression between diseases and DrugMatrix datasets.” *Scientific Reports* 7 (1): 13733. <https://doi.org/10.1038/s41598-017-13003-0>.

———. 2018. “Tensor decomposition-based and principal-component-analysis-based unsupervised feature extraction applied to the gene expression and methylation profiles in the brains of social insects with multiple castes.” *BMC Bioinformatics* 19 (Suppl 4): 99. <https://doi.org/10.1186/s12859-018-2068-7>.

———. 2019. “Multiomics Data Analysis Using Tensor Decomposition Based Unsupervised Feature Extraction.” In *Intelligent Computing Theories and Application*, edited by De-Shuang Huang, Vitoantonio Bevilacqua, and Prashan Premaratne, 565–74. Cham: Springer International Publishing.

———. 2017b. “Tensor Decomposition-Based Unsupervised Feature Extraction Applied to Matrix Products for Multi-View Data Processing.” *PLOS ONE* 12 (8): 1–36. <https://doi.org/10.1371/journal.pone.0183933>.

Taguchi, Y-H., and Ka-Lok Ng. 2018. “[Regular Paper] Tensor Decomposition–Based Unsupervised Feature Extraction for Integrated Analysis of Tcga Data on Microrna Expression and Promoter Methylation of Genes in Ovarian Cancer.” In *2018 Ieee 18th International Conference on Bioinformatics and Bioengineering (Bibe)*, 195–200. <https://doi.org/10.1109/BIBE.2018.00045>.

Taguchi, Y-H., and Turki Turki. 2019. “Tensor Decomposition-Based Unsupervised Feature Extraction Applied to Single-Cell Gene Expression Analysis.” *Frontiers in Genetics* 10. <https://doi.org/10.3389/fgene.2019.00864>.

———. 2020. “Universal Nature of Drug Treatment Responses in Drug-Tissue-Wide Model-Animal Experiments Using Tensor Decomposition-Based Unsupervised Feature Extraction.” *Frontiers in Genetics* 11. <https://doi.org/10.3389/fgene.2020.00695>.

———. 2021. “Tensor-Decomposition-Based Unsupervised Feature Extraction in Single-Cell Multiomics Data Analysis.” *Genes* 12 (9). <https://doi.org/10.3390/genes12091442>.

———. 2022. “A tensor decomposition-based integrated analysis applicable to multiple gene expression profiles without sample matching.” *Scientific Reports* 12 (1): 21242. <https://doi.org/10.1038/s41598-022-25524-4>.