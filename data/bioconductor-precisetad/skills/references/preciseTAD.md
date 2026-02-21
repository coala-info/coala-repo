# preciseTAD Vignette

Spiro Stilianoudakis1 and Mikhail Dozmorov1

1Department of Biostatistics, Virginia Commonwealth University, Richmond, VA

#### October 30, 2025

#### Abstract

Chromosome conformation capture technologies combined with high-throughput sequencing (Hi-C) have revealed that chromatin undergoes layers of compaction through DNA looping and folding, forming dynamic 3D structures. Among these are Topologically Associating Domains (TADs) and chromatin loops, which are known to play critical roles in cell dynamics like gene regulation and cell differentiation. Precise identification of TAD/loop (domain) boundaries remains difficult, as it is strongly reliant on Hi-C data resolution. Obtaining genome-wide chromatin interactions at high-resolution is costly resulting in low resolution of Hi-C matrices and high uncertainty in the location of domain boundaries. We developed a machine learning framework that leverages the spatial relationship of high-resolution genome annotation data (e.g., ChIP-seq-defined transcription factor binding sites) to maximally accurately predict low-resolution domain boundaries. Translated on a base level, the model predicts the probability of each base being a boundary. These probabilities, coupled with density-based clustering and scalable partitioning techniques, allow the precise (base-level) identification of domain boundary regions and points. We show that known molecular drivers of 3D chromatin structures including CTCF, RAD21, and SMC3 are more enriched at our predicted boundaries, as compared with the boundaries identified by the popular Arrowhead TAD caller. The model trained in one cell type can leverage genomic annotations and predict boundaries in another cell type.

#### Package

preciseTAD 1.20.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Input data](#input-data)
  + [1.2 preciseTAD functionality and output](#precisetad-functionality-and-output)
* [2 Getting Started](#getting-started)
  + [2.1 Installation](#installation)
* [3 Implementation](#implementation)
  + [3.1 Model building](#model-building)
    - [3.1.1 Construction of the data matrix](#construction-of-the-data-matrix)
    - [3.1.2 Feature selection using recursive feature elimination](#feature-selection-using-recursive-feature-elimination)
    - [3.1.3 Implementing a random forest for boundary prediction](#implementing-a-random-forest-for-boundary-prediction)
  + [3.2 Precise boundary prediction](#precise-boundary-prediction)
    - [3.2.1 Running preciseTAD](#running-precisetad)
    - [3.2.2 Using preciseTAD with Juicebox](#using-precisetad-with-juicebox)
    - [3.2.3 Cross-cell-type prediction](#cross-cell-type-prediction)
* [References](#references)

# 1 Introduction

`preciseTAD` is an R package designed to transform domain boundary calling into a supervised machine learning framework. `preciseTAD` offers full functionality in building the predictor-response data and selecting the best model for precise prediction of boundary regions. This functionality can be broken into 2 primary usages:

* Model building, and
* Precise domain boundary prediction

## 1.1 Input data

The training/testing data used for modeling is represented as a matrix with rows being genomic regions, columns being genomic annotations, and cells containing measures of association between them. Users have the option to concatenate genomic regions from multiple chromosomes.

To create the row-wise dimension of the data, `preciseTAD` uses *shifted binning*, a strategy for making the dimensions of the data matrix used for modeling by segmenting the linear genome into nonoverlapping regions. This step is transparent for the user. To create shifted bins, chromosome-specific bins start at half of the resolution *r*, and continue in congruent intervals of length *r* until the end of the chromosome (*mod r* + *r/2*), using hg19 genomic coordinates. The shifted genomic bins, are then defined as boundary regions (*Y = 1*) if they contain a called boundary, and non-boundary regions (*Y = 0*) otherwise, thus establishing the binary response vector (**Y**) used for classification. Intuitively, shifted bins are centered on borders between the original bins, thus capturing potential boundaries. We found the shifted binning strategy improves model performance.

The column-wise dimension is formed by genomic annotations, such as transcription factor binding sites (TFBSs), histone modification marks, chromatin states. The *(\(log\_{2}\)) distances*, which enumerate the genomic distance from the center of each genomic bin to the center of the nearest ChIP-seq peak region of interest, form the feature space. Other feature type options include *binary overlaps* - an indicator for whether a ChIP-seq region overlaps with genomic bin, *count overlaps* - the number of overlaps in each bin, and *percent overlaps* - the percentage of overlap between any bin and the total width of all ChIP-seq regions overlapping it. The customized training/testing data formation offered by `preciseTAD` allows users to implement any binary classification machine learning algorithm.

## 1.2 preciseTAD functionality and output

`preciseTAD` implements a random forest (RF) model, allowing tuning hyperparameters and applying feature reduction. The primary inputs are the training and testing data, a list of hyperparameter values, the number of cross-validation folds to use (if a grid of hyperparameter values is provided), and the metric used for optimization. The output includes the model object (necessary for downstream prediction of boundaries), the variable importance values, and a list of performance metrics when validating the model on the testing data (see Table 1). This model is then used to predict base-level precise boundary locations.

To predict the base-level location of domain boundaries, the `preciseTAD` model is applied for each base annotated with the aforementioned genomic annotations. The base-level probabilities are clustered using density-based clustering and scalable data partitioning techniques, to narrow boundary regions and points. First, the probability vector, \(p\_{n\_{i}}\), is extracted (\(n\_{i}\) representing the length of chromosome \(i\)). Next, *DBSCAN* (Density-based Spatial Clustering of Applications with Noise) (Ester et al. [1996](#ref-ester1996density); Hahsler, Piekenbrock, and Doran [2019](#ref-hahsler2019dbscan)) is applied to the matrix of pairwise genomic distances between bases with \(p\_{n\_{i}} \ge t\), where \(t\) is a threshold determined by the user. The resulting clusters of highly predictive bases identified by DBSCAN are termed *preciseTAD boundary regions* (PTBR). To precisely identify a single base among each PTBR, *preciseTAD* implements partitioning around medoids (PAM) within each cluster. The corresponding cluster medoid is defined as a *preciseTAD boundary point* (PTBP), making it the most representative and biologically meaningful base within each clustered PTBR. The output includes a list of genomic coordinates of PTBPs and PTBSs.

`preciseTAD` allows us to use the pre-trained model to predict the precise location of domain boundaries in cell types without Hi-C data but with genome annotation data. Specifically, only cell-type-specific ChIP-seq data (BED format) for CTCF, RAD21, SMC3, and ZNF143 transcription factor binding sites is required. We provide models pre-trained using GM12878 and K562 genome annotation data, and Arrowhead- and Peakachu-predicted boundaries for chromosome-specific prediction of precise domain boundaries in other cell types.

# 2 Getting Started

## 2.1 Installation

```
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
BiocManager::install("preciseTAD")
# For the latest version install from GitHub
# BiocManager::install("dozmorovlab/preciseTAD")
```

```
library(knitr)
library(e1071)
library(preciseTAD)
```

# 3 Implementation

## 3.1 Model building

### 3.1.1 Construction of the data matrix

`preciseTAD` requires users to supply genomic coordinates of the “ground-truth” domain boundaries to establish the response vector (**Y**). As an example, we consider TAD boundaries derived from the popular *Arrowhead* TAD caller, a part of the Juicebox suite of tools developed by Aiden Lab (Durand et al. [2016](#ref-durand2016juicer)). To get boundaries, *Arrowhead* was applied on the autosomal chromosomes using 5 kb GM12878 Hi-C data (Rao et al. [2014](#ref-rao20143d)) ([GSE63525](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE63525)). An example of the command line script used to called TADs with *Arrowhead* is provided below, as well as the first three columns of the resulting TAD coordinates. A more detailed tutorial for implementing *Arrowhead* can be found [here](http://github.com/aidenlab/juicer/wiki/Arrowhead).

```
arrowhead -c 1 \ #chromosome to call TADs on
  -r 5000 \ #HiC data resolution
  ~/GSE63525_GM12878_insitu_primary.hic \ #location of the .HIC file
  ~/arrowhead_output #location to store the output
```

```
data("arrowhead_gm12878_5kb")
head(arrowhead_gm12878_5kb)
```

```
##   V1        V2        V3
## 1  1  49375000  50805000
## 2  1  16830000  17230000
## 3  1 163355000 164860000
## 4  1 231935000 233400000
## 5  1 149035000 149430000
## 6  1   3995000   5505000
```

Users will then need to transform this TAD coordinate data into a GRanges object of unique boundary coordinates using the `preciseTAD::extractBoundaries()` function. Note that the input for this function is a BED-like data frame where the second and third columns are genomic coordinates of domain anchor’s midpoints. Here we only extract boundaries for CHR1 and CHR22 (`CHR = c("CHR1", "CHR22")` parameter). We specify `preprocess=FALSE` because we are only interested in all boundaries and not filtering TADs by length. Lastly, we specify `resolution=5000` to match the resolution used by *Arrowhead* (although this argument is ignored given that `preprocess=FALSE`). As shown below, there were a total of 1901 unique TAD boundaries reported by *Arrowhead* for chromosomes 1 and 22.

```
bounds <- extractBoundaries(domains.mat = arrowhead_gm12878_5kb, filter = FALSE, CHR = c("CHR1", "CHR22"), resolution = 5000)
# View unique boundaries
bounds
```

```
## GRanges object with 1901 ranges and 0 metadata columns:
##         seqnames            ranges strand
##            <Rle>         <IRanges>  <Rle>
##     787     chr1     815000-815001      *
##    9196     chr1     890000-890001      *
##      37     chr1     915000-915001      *
##    8923     chr1   1005000-1005001      *
##     275     chr1   1015000-1015001      *
##     ...      ...               ...    ...
##    8379    chr22 50815000-50815001      *
##   16788    chr22 50935000-50935001      *
##    8382    chr22 50945000-50945001      *
##   16791    chr22 51060000-51060001      *
##   16670    chr22 51235000-51235001      *
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

To identify genomic features best predictive of TAD boundaries, `preciseTAD` requires functional genomic annotation data. They are used to establish the feature space (\(\textbf{X}=\{X\_{1}, X\_{2}, \cdots, X\_{p} \}\)). Cell type-specific genomic annotation data can be downloaded from the [ENCODE](http://www.encodeproject.org/chip-seq-matrix/?type=Experiment&replicates.library.biosample.donor.organism.scientific_name=Homo%20sapiens&assay_title=TF%20ChIP-seq&status=released) data portal as BED files. Once you have downloaded your preferred list of functional genomic annotations, store them in a specific file location (i.e., “./path/to/BEDfiles”). These files can then be converted into a GRangesList object and used to create the feature space using the `preciseTAD::bedToGRangesList()` function. The `signal` argument refers to the column in the BED files containing peak signal strength values and is used to assign metadata to the corresponding GRanges (only necessary for downstream plotting). We have already provided a GRangesList object with 26 transcription factor binding sites (TFBS) specific to the GM12878 cell type. Once you load it in, you can see the list of transcription factors using the following commands.

```
# path <- "./path/to/BEDfiles"
# tfbsList <- bedToGRangesList(filepath=path, bedList=NULL, bedNames=NULL, pattern = "*.bed", signal=4)

data("tfbsList")
names(tfbsList)
```

```
##  [1] "Gm12878-Atf3-Haib"       "Gm12878-Cfos-Sydh"       "Gm12878-Cmyc-Uta"        "Gm12878-Ctcf-Broad"      "Gm12878-Egr1-Haib"       "Gm12878-Ets1-Haib"       "Gm12878-Gabp-Haib"       "Gm12878-Jund-Sydh"       "Gm12878-Max-Sydh"        "Gm12878-Mazab85725-Sydh" "Gm12878-Mef2a-Haib"      "Gm12878-Mxi1-Sydh"       "Gm12878-P300-Sydh"       "Gm12878-Pol2-Haib"       "Gm12878-Pu1-Haib"
## [16] "Gm12878-Rad21-Haib"      "Gm12878-Rfx5-Sydh"       "Gm12878-Sin3a-Sydh"      "Gm12878-Six5-Haib"       "Gm12878-Smc3-Sydh"       "Gm12878-Sp1-Haib"        "Gm12878-Srf-Haib"        "Gm12878-Taf1-Haib"       "Gm12878-Tr4-Sydh"        "Gm12878-Yy1-Sydh"        "Gm12878-Znf143-Sydh"
```

```
tfbsList
```

```
## GRangesList object of length 26:
## $`Gm12878-Atf3-Haib`
## GRanges object with 1677 ranges and 1 metadata column:
##          seqnames              ranges strand |  coverage
##             <Rle>           <IRanges>  <Rle> | <numeric>
##      [1]     chr1     1167429-1167599      * |   28.5019
##      [2]     chr1     1510215-1510385      * |   64.7440
##      [3]     chr1     1655730-1655900      * |   25.1686
##      [4]     chr1     1709843-1710013      * |   15.5525
##      [5]     chr1     2343938-2344108      * |   19.6961
##      ...      ...                 ...    ... .       ...
##   [1673]     chrX 118699292-118699462      * |   17.6970
##   [1674]     chrX 119947928-119948098      * |   13.8884
##   [1675]     chrX 128481457-128481627      * |   26.1075
##   [1676]     chrX 132399481-132399651      * |   20.7070
##   [1677]     chrX 136520393-136520563      * |   24.4197
##   -------
##   seqinfo: 24 sequences from an unspecified genome; no seqlengths
##
## ...
## <25 more elements>
```

Using the “ground-truth” boundaries and the following TFBS, we can build the data matrix that will be used for predictive modeling. The `preciseTAD::createTADdata()` function can create the training and testing data. Here, we specify to train on chromosome 1 and test on chromosome 22. Additionally, we specify `resolution = 5000` to construct 5kb shifted genomic bins (to match the Hi-C data resolution), `featureType = "distance"` for a \(log\_2(distance + 1)\)-type feature space, and `resampling = "rus"` to apply random under-sampling (RUS) on the training data to balance classes of boundary vs. non-boundary regions. We also specify a seed to ensure reproducibility when performing the resampling. The result is a list containing two data frames: (1) the resampled (if specified) training data, and (2) the testing data.

```
set.seed(123)
tadData <- createTADdata(bounds.GR = bounds,
                         resolution = 5000,
                         genomicElements.GR = tfbsList,
                         featureType = "distance",
                         resampling = "rus",
                         trainCHR = "CHR1",
                         predictCHR = "CHR22")

# View subset of training data
tadData[[1]][1:5,1:4]
```

```
##         y Gm12878-Atf3-Haib Gm12878-Cfos-Sydh Gm12878-Cmyc-Uta
## 5799   No          18.73205          17.73674         14.60901
## 32930  No          21.23327          15.32696         15.03635
## 5767  Yes          18.07127          17.99360         13.22415
## 8504  Yes          19.24515          19.26026         18.31016
## 39486  No          21.23396          17.28550         19.09578
```

```
# Check it is balanced
table(tadData[[1]]$y)
```

```
##
##   No  Yes
## 1595 1595
```

```
# View subset of testing data
tadData[[2]][1:5,1:4]
```

```
##    y Gm12878-Atf3-Haib Gm12878-Cfos-Sydh Gm12878-Cmyc-Uta
## 1 No          24.08978           24.1100         24.12327
## 2 No          24.08937           24.1096         24.12287
## 3 No          24.08897           24.1092         24.12248
## 4 No          24.08857           24.1088         24.12208
## 5 No          24.08816           24.1084         24.12169
```

### 3.1.2 Feature selection using recursive feature elimination

We can now implement our machine learning algorithm of choice to predict boundary regions. Here, we opt for the random forest algorithm for binary classification. `preciseTAD` offers functionality for performing recursive feature elimination (RFE) as a form of feature reduction through the use of the `preciseTAD::TADrfe()` function, which is a wrapper for the `rfe` function in the `caret` package (Kuhn [2012](#ref-kuhn2012caret)). `preciseTAD::TADrfe()` implements a random forest model on the best subset of features from 2 to the maximum number of features in the data by powers of 2, using 5-fold cross-validation. We specify accuracy as the performance metric. An example is shown below.

```
set.seed(123)
rfe_res <- TADrfe(trainData = tadData[[1]],
                 tuneParams = list(ntree = 500, nodesize = 1),
                 cvFolds = 5,
                 cvMetric = "Accuracy",
                 verbose = TRUE)
```

```
# View RFE performances
rfe_res[[1]]
```

```
##   Variables       MCC       ROC      Sens      Spec Pos Pred Value Neg Pred Value  Accuracy     Kappa      MCCSD       ROCSD      SensSD     SpecSD Pos Pred ValueSD Neg Pred ValueSD  AccuracySD    KappaSD
## 1         2 0.3491082 0.7420849 0.6526646 0.6952978      0.6822854      0.6667258 0.6739812 0.3479624 0.02627631 0.010098192 0.009508308 0.02993689      0.019873426      0.008273672 0.013160545 0.02632109
## 2         4 0.4613042 0.8026680 0.6984326 0.7611285      0.7455349      0.7163087 0.7297806 0.4595611 0.01904174 0.009974699 0.015099178 0.02275698      0.015584018      0.007949199 0.008769029 0.01753806
## 3         8 0.5076806 0.8229440 0.7122257 0.7931034      0.7749194      0.7340188 0.7526646 0.5053292 0.01922275 0.010486133 0.022648767 0.01063061      0.008681254      0.014664805 0.010711191 0.02142238
## 4        16 0.5150537 0.8263765 0.7197492 0.7943574      0.7779659      0.7394767 0.7570533 0.5141066 0.01881406 0.014157078 0.022886160 0.01696849      0.012896280      0.014149142 0.010802546 0.02160509
## 5        26 0.5307963 0.8294258 0.7210031 0.8075235      0.7894162      0.7439457 0.7642633 0.5285266 0.02605025 0.015234024 0.036287890 0.01480341      0.009062094      0.022029556 0.013957766 0.02791553
```

```
# View the variable importance among top n features across each CV fold
head(rfe_res[[2]])
```

```
##    Overall                 var Variables Resample
## 1 26.76923   Gm12878-Smc3-Sydh        26    Fold1
## 2 23.70939  Gm12878-Rad21-Haib        26    Fold1
## 3 20.08605  Gm12878-Ctcf-Broad        26    Fold1
## 4 17.65042 Gm12878-Znf143-Sydh        26    Fold1
## 5 14.17874   Gm12878-Pol2-Haib        26    Fold1
## 6 13.25481   Gm12878-Gabp-Haib        26    Fold1
```

Recursive feature elimination results indicate that model accuracy begins to stabilize when only considering the top four transcription factors for building random forest predictive models (Figure 1A). After aggregating the variable importance values of the top four TFBS across each cross-fold, we see that the top four most important TFBS in each of the five folds are the SMC3, RAD21, CTCF, and ZNF143 (Figure 1B). These are known components of the loop-extrusion model that has been proposed as a mechanism for the 3D architecture of the human genome (Sanborn et al. [2015](#ref-sanborn2015chromatin); Fudenberg et al. [2016](#ref-fudenberg2016formation); Hansen et al. [2018](#ref-hansen2018recent)).

![](data:image/png;base64...)

**Figure 1**. (A) Recursive feature elimination (RFE) indicates that performance stabilizes when only considering the top 4 most predictive transcription factor binding sites (TFBS). (B) Aggregate mean variable importance (using mean decrease in accuracy) for the top 4 TFBS across each of the 5 cross-folds.

### 3.1.3 Implementing a random forest for boundary prediction

Now that we have suitably reduced our feature space, we can implement a random forest algorithm built simply on the TFBS mentioned above (SMC3, RAD21, CTCF, and ZNF143). We can take advantage of the `preciseTAD::TADrandomForest()` function, which is a wrapper of the `randomForest` package (Breiman [2001](#ref-breiman2001random); Liaw, Wiener, and others [2002](#ref-liaw2002classification)). We specify the training and testing data, the hyperparameter values, the number of cross-validation folds, the performance metric to consider (here, accuracy), the seed to initialize for reproducibility, an indicator for retaining the model object, an indicator for retaining variable importances, the variable importance measure to consider (here, mean decrease in accuracy (MDA)), and an indicator for retaining model performances based on the test data. The function returns a list containing: 1) a trained model from caret with model information (`tadModel[[1]]`), 2) a `data.frame` of variable importance for each feature included in the model (`tadModel[[2]]`), and 3) a `data.frame` of various model performance metrics.

```
# Restrict the data matrix to include only SMC3, RAD21, CTCF, and ZNF143
tfbsList_filt <- tfbsList[names(tfbsList) %in% c("Gm12878-Ctcf-Broad",
                                            "Gm12878-Rad21-Haib",
                                            "Gm12878-Smc3-Sydh",
                                            "Gm12878-Znf143-Sydh")]

set.seed(123)
tadData <- createTADdata(bounds.GR   = bounds,
                         resolution  = 5000,
                         genomicElements.GR = tfbsList_filt,
                         featureType = "distance",
                         resampling  = "rus",
                         trainCHR    = "CHR1",
                         predictCHR  = "CHR22")

# Run RF
set.seed(123)
tadModel <- TADrandomForest(trainData  = tadData[[1]],
                            testData   = tadData[[2]],
                            tuneParams = list(mtry     = 2,
                                              ntree    = 500,
                                              nodesize = 1),
                            cvFolds      = 3,
                            cvMetric     = "Accuracy",
                            verbose      = FALSE,
                            model        = TRUE,
                            importances  = TRUE,
                            impMeasure   = "MDA",
                            performances = TRUE)
```

```
# View model performances
performances <- tadModel[[3]]
performances$Performance <- round(performances$Performance, digits = 2)
rownames(performances) <- performances$Metric
kable(t(performances), caption = "List of model performances when validating an RF built on CHR1 on CHR22 test data.")
```

Table 1: List of model performances when validating an RF built on CHR1 on CHR22 test data.

|  | TN | FN | FP | TP | Total | Sensitivity | Specificity | Kappa | Accuracy | BalancedAccuracy | Precision | FPR | FNR | NPV | MCC | F1 | AUC | Youden | AUPRC |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Metric | TN | FN | FP | TP | Total | Sensitivity | Specificity | Kappa | Accuracy | BalancedAccuracy | Precision | FPR | FNR | NPV | MCC | F1 | AUC | Youden | AUPRC |
| Performance | 6400.00 | 67.00 | 2954.00 | 239.00 | 9660.00 | 0.78 | 0.68 | 0.08 | 0.69 | 0.73 | 0.07 | 0.32 | 0.01 | 0.99 | 0.17 | 0.14 | 0.80 | 0.47 | 0.09 |

As you may know, there exist other machine learning binary classifiers that can be used in this setting. For example, suppose we opt to implement a support vector machine (SVM). This is easy enough to accomplish given that `preciseTAD::createTADdata()` conveniently sets up the training and testing data sets. We use the `e1071` package to run the SVM with a radial kernel, cost = 1, and gamma = 0.5 using the example command below. We see that the SVM model’s accuracy is only 0.67, whereas the accuracy from our random forest was 0.69 (Table 1).

```
svmModel <- svm(y ~ ., data = tadData[[1]], kernel = "radial", cost = 1, gamma = 0.5)

svmPreds <- predict(svmModel, tadData[[2]][, -1], positive = "Yes")

# View confusion matrix
table(svmPreds, tadData[[2]][, 1])
```

```
##
## svmPreds   No  Yes
##      No  6278   49
##      Yes 3076  257
```

## 3.2 Precise boundary prediction

Recall that our model classifies boundary **regions**, in that each prediction refers to a genomic bin of width 5000 bases. To predict boundary coordinates at the base resolution more precisely, we can leverage our model through the use of the `preciseTAD::preciseTAD()` function. Conceptually, instead of genomic bins, we annotate each base with the selected genomic annotations and featureType. We then apply our model on this annotation matrix to predict the probability of each base is a boundary given the associated genomic annotations. To minimize computational costs, the base-level prediction should be performed in selected regions.

### 3.2.1 Running preciseTAD

Suppose we want to precisely predict the domain boundary coordinates for the 2Mb section of CHR22:25,500,000-27,500,000. To do so, we specify `chromCoords = list(25500000, 27500000)`. Additionally, we set a range of probability threshold values including 0.975, 0.99, and 1.0 used for constructing PTBRs. For DBSCAN, we assign a range of \(\epsilon\)-neighborhood values including 5000, 10000, 15000, 20000, and 30000 and maintain 3 as the *MinPts* value. We specify `verbose=TRUE` so that the function will print out some minor results for each combination of \((t, \epsilon)\) as well as the overall best combination

```
# Run preciseTAD
set.seed(123)
pt <- preciseTAD(genomicElements.GR = tfbsList_filt,
                featureType         = "distance",
                CHR                 = "CHR22",
                chromCoords         = list(17000000, 18000000),
                tadModel            = tadModel[[1]],
                threshold           = 1,
                verbose             = TRUE,
                parallel            = NULL,
                DBSCAN_params       = list(eps = c(30000), # c(10000, 30000, 50000)
                                           MinPts = c(100)), # c(3, 10, 100)
                slope               = 5000,
                genome              = "hg19",
                BaseProbs           = TRUE)
```

```
## [1] "Establishing bp resolution test data using a distance type feature space"
## [1] "Establishing probability vector"
## [1] "Determining optimal combination of epsilon neighborhood (eps) and minimum number of points (MinPts)"
## [1] "Initializing DBSCAN for MinPts=100 and eps=30000"
## [1] "    preciseTAD identified 2 PTBRs"
## [1] "    Establishing PTBPs"
## [1] "        Cluster 1 out of 2"
## [1] "        Cluster 2 out of 2"
## [1] "Optimal combination of MinPts and eps is = (100, 30000)"
## [1] "preciseTAD identified a total of 1678 base pairs whose predictive probability was equal to or exceeded a threshold of 1"
## [1] "Initializing DBSCAN for MinPts = 100 and eps = 30000"
## [1] "preciseTAD identified 2 PTBRs"
## [1] "Establishing PTBPs"
## [1] "Cluster 1 out of 2"
## [1] "Cluster 2 out of 2"
```

```
# What is getting returned? PTBRs - precide TAD boundary regions, and PTBPs - boundary points
names(pt)
```

```
## [1] "preciseTADparams" "PTBR"             "PTBP"             "Summaries"
```

```
# View the results
# pt
```

When specifying `verbose=TRUE` the function provides brief output for all \(t \times \epsilon\) combinations including how many PTBRs/PTBPs result from each combination. NOTE: it is advised to provide `verbose=FALSE` when implementing *preciseTAD* using multiple \(t\) and \(\epsilon\) on the entire chromosome. Additionally, we see from the verbose statements that the optimal combination of \((t, \epsilon) = (1, 30000)\).

The full output of the `preciseTAD::preciseTAD()` function is a list with 4 elements: 1) data frame with average (and standard deviation) normalized enrichment (NE) values for each combination of t and eps (only if multiple values are provided for at least paramenter; all subsequent summaries are applied to optimal combination of (t, eps)), 2) the genomic coordinates spanning each preciseTAD predicted region (PTBR), 3) the genomic coordinates of preciseTAD predicted boundaries points (PTBP). 4) a named list including summary statistics of the following: PTBRWidth - PTBR width, PTBRCoverage - the ratio of base level coordinates with probabilities that exceed the threshold to PTBRWidth, DistanceBetweenPTBR - the genomic distance between the end of the previous PTBR and the start of the subsequent PTBR, NumSubRegions - the number of elements in each PTBR cluster, SubRegionWidth - the genomic coordinates spanning the subregion associated with each PTBR, DistBetweenSubRegions - the genomic distance between the end of the previous PTBR-specific region and the start of the subsequent PTBR-specific region, NormilizedEnrichment - the normalized enrichment of the genomic annotations used in the model around flanked PTBPs, and BaseProbs - a numeric vector of probabilities for each corresponding base coordinate. Normalized enrichment is calculated as the total number of peak regions that overlap with flanked predicted boundaries divided by the number of predicted boundaries. A schematic of how each of the summaries are calculated is presented in Figure 2.

![](data:image/png;base64...)

**Figure 2**. A schematic illustrating how each of the diagnostic summaries are calculated in the *preciseTAD()* output.

The vector of base-specific probabilities of being a boundary (`BaseProbs`) may be large, depending on the `chromCoords` settings. In our example, it has 2 million entries. Be careful when setting `BaseProbs = TRUE` to avoid memory issues. To see how the probabilities for the first five hundred bases look like, we do:

```
plot(pt$Summaries$BaseProbs[1:100000])
```

![](data:image/png;base64...)

We can see that the probability of being a boundary seems to peak around 200 and 400 bases. It is well below 1, but may be worth further investigation.

### 3.2.2 Using preciseTAD with Juicebox

Juicebox is an interface provided by Aiden Lab that allows for superimposing boundary coordinates onto Hi-C contact maps. To visualize domains flanked by the predicted boundaries, you must first select a Hi-C map. As an example, you can import the contact matrix for GM12878 derived by Rao et al. 2014 by choosing `File -> Open... -> Rao and Huntley et al. -> GM12878 -> in situ Mbol -> primary`. To format `preciseTAD` results to use in Juicebox, users can take advantage of `preciseTAD::juicer_func()`, which is a function available in the `preciseTAD` R package that transforms a GRanges object into a data frame as shown below.

```
# Transform
pt_juice <- juicer_func(pt$PTBP)
```

You will then need to save the PTBPs as a BED file using `write.table` as shown below. Once saved, import them into Juicebox using `Show Annotation Panel -> 2D Annotations -> Add Local -> pt_juice.bed`.

```
filepath = "~/path/to/store/ptbps"
write.table(pt_juice,
            file.path(filepath, "pt_juice.bed"),
            quote = FALSE,
            col.names = FALSE,
            row.names = FALSE,
            sep = "\t")
```

### 3.2.3 Cross-cell-type prediction

`preciseTAD` allows us to use the pre-trained model to predict the precise location of domain boundaries in cell types without Hi-C data but with genome annotation data. Specifically, only the cell type-specific ChIP-seq data (BED format) for CTCF, RAD21, SMC3, and ZNF143 transcription factor binding sites is required. These data need to be assembled in a GRanges object using the aforementioned `bedToGRangesList()` function (i.e., creating another cell-type-specific `tfbsList_filt` object).

The pre-trained model `tadModel` can be obtained by using `bedToGRangesList()`, `extractBoundaries()`, `createTADdata()`, and `TADrandomForest()` functions, as described. Alternatively, chromosome-specific pre-trained models can be downloaded from the [OneDrive storage](https://1drv.ms/u/s%21AhmbAyu-bORbgutlR0_b-DJP9jTNKw?e=zZhASJ). We recommend models pre-trained using GM12878 genome annotation data and Peakachu peaks. Note that each model is annotated with “CHRi\_holdout”, representing the chromosome held out of training, and thus to be used to predict boundaries. It should be noted that the pretrained *preciseTAD* models were trained on cancer cell lines (GM12878 and K562). Although we expect that the fundamental rules of domain boundary formation (CTCF etc. binding) will be preserved in cancer cells, use caution when applying the pretrained models to predict boindaries in normal cell lines.

As an example, we consider the Hela-S3 cell line. We will download and use the [CHR22\_GM12878\_5kb\_Peakachu](https://1drv.ms/u/s%21AhmbAyu-bORbguwDMgw2fA6Z84sYsQ?e=UrMUky) model to predict boundaries for chr22 in the Hela-S3 cell line.

```
# Read in RF model built on chr1-chr21
tadModel <- readRDS("~/Downloads/CHR22_GM12878_5kb_Peakachu.rds")
```

The Hela-S3-specific BED-formatted TFBS data can be downloaded at [ENCODE](http://www.encodeproject.org/chip-seq-matrix/?type=Experiment&replicates.library.biosample.donor.organism.scientific_name=Homo%20sapiens&assay_title=TF%20ChIP-seq&status=released). The selected TFBS data can be downloaded from the [supplementary repository](http://github.com/stilianoudakis/preciseTAD_supplementary/tree/master/data/bed/hela). They can be converted into a GRangesList.

```
# Establishing Hela-specific genomic annotations
# Reading in CTCF, RAD21, SMC3, and ZNF143 from repository and storing as list
ctcf <- as.data.frame(read.delim("http://raw.githubusercontent.com/stilianoudakis/preciseTAD_supplementary/master/data/bed/hela/ctcf.bed", sep = "\t", header = FALSE))
rad21 <- as.data.frame(read.delim("http://raw.githubusercontent.com/stilianoudakis/preciseTAD_supplementary/master/data/bed/hela/rad21.bed", sep = "\t", header = FALSE))
smc3 <- as.data.frame(read.delim("http://raw.githubusercontent.com/stilianoudakis/preciseTAD_supplementary/master/data/bed/hela/smc3.bed", sep = "\t", header = FALSE))
znf143 <- as.data.frame(read.delim("http://raw.githubusercontent.com/stilianoudakis/preciseTAD_supplementary/master/data/bed/hela/znf143.bed", sep = "\t", header = FALSE))
helaList <- list(ctcf, rad21, smc3, znf143)

hela.GR <- bedToGRangesList(bedList=helaList, bedNames=c("Ctcf", "Rad21", "Smc3", "Znf143"), signal=5)
```

Now we are ready to predict boundaries on chr22 for Hela-S3.

```
# Run preciseTAD
set.seed(123)
pt <- preciseTAD(genomicElements.GR = hela.GR,
                featureType         = "distance",
                CHR                 = "CHR22",
                chromCoords         = list(25500000, 27500000),
                tadModel            = tadModel[[1]],
                threshold           = 1.0,
                verbose             = FALSE,
                parallel            = NULL,
                DBSCAN_params       = list(30000, 100),
                slope               = 5000,
                BaseProbs           = FALSE,
                savetobed           = FALSE)
```

# References

Breiman, Leo. 2001. “Random Forests.” *Machine Learning* 45 (1): 5–32.

Durand, Neva C, Muhammad S Shamim, Ido Machol, Suhas SP Rao, Miriam H Huntley, Eric S Lander, and Erez Lieberman Aiden. 2016. “Juicer Provides a One-Click System for Analyzing Loop-Resolution Hi-c Experiments.” *Cell Systems* 3 (1): 95–98.

Ester, Martin, Hans-Peter Kriegel, Jörg Sander, Xiaowei Xu, and others. 1996. “A Density-Based Algorithm for Discovering Clusters in Large Spatial Databases with Noise.” In *Kdd*, 96:226–31. 34.

Fudenberg, Geoffrey, Maxim Imakaev, Carolyn Lu, Anton Goloborodko, Nezar Abdennur, and Leonid A Mirny. 2016. “Formation of Chromosomal Domains by Loop Extrusion.” *Cell Reports* 15 (9): 2038–49.

Hahsler, Michael, Matthew Piekenbrock, and Derek Doran. 2019. “Dbscan: Fast Density-Based Clustering with R.” *Journal of Statistical Software* 25: 409–16.

Hansen, Anders S, Claudia Cattoglio, Xavier Darzacq, and Robert Tjian. 2018. “Recent Evidence That Tads and Chromatin Loops Are Dynamic Structures.” *Nucleus* 9 (1): 20–32.

Kuhn, Max. 2012. “The Caret Package.” *R Foundation for Statistical Computing, Vienna, Austria. URL Https://Cran. R-Project. Org/Package= Caret*.

Liaw, Andy, Matthew Wiener, and others. 2002. “Classification and Regression by randomForest.” *R News* 2 (3): 18–22.

Rao, Suhas SP, Miriam H Huntley, Neva C Durand, Elena K Stamenova, Ivan D Bochkov, James T Robinson, Adrian L Sanborn, et al. 2014. “A 3D Map of the Human Genome at Kilobase Resolution Reveals Principles of Chromatin Looping.” *Cell* 159 (7): 1665–80.

Sanborn, Adrian L, Suhas SP Rao, Su-Chen Huang, Neva C Durand, Miriam H Huntley, Andrew I Jewett, Ivan D Bochkov, et al. 2015. “Chromatin Extrusion Explains Key Features of Loop and Domain Formation in Wild-Type and Engineered Genomes.” *Proceedings of the National Academy of Sciences* 112 (47): E6456–E6465.