# An Introduction to Harman

Jason Ross and Yalchin Oytam

#### 30 October 2025

#### Abstract

Harman is a PCA and constrained optimisation based technique that maximises the removal of batch effects from datasets, with the constraint that the probability of overcorrection (i.e. removing genuine biological signal along with batch noise) is kept to a fraction which is set by the end-user.

#### Package

Harman 1.38.0

# Contents

* [1 Introduction](#introduction)
* [2 Transcriptome data examples](#transcriptome-data-examples)
  + [2.1 Working with a simple transciptome microarray dataset](#working-with-a-simple-transciptome-microarray-dataset)
    - [2.1.1 Running Harman](#running-harman)
    - [2.1.2 Inspecting results](#inspecting-results)
    - [2.1.3 Reconstruct the corrected data](#reconstruct-the-corrected-data)
    - [2.1.4 How does the new data differ from the old data?](#how-does-the-new-data-differ-from-the-old-data)
  + [2.2 Another simple transciptome dataset](#another-simple-transciptome-dataset)
    - [2.2.1 Evidence of batch effects](#evidence-of-batch-effects)
    - [2.2.2 Running Harman](#running-harman-1)
    - [2.2.3 Reconstruct the corrected data](#reconstruct-the-corrected-data-1)
  + [2.3 Working with very small datasets](#working-with-very-small-datasets)
    - [2.3.1 Running Harman](#running-harman-2)
    - [2.3.2 More aggressive settings](#more-aggressive-settings)
    - [2.3.3 Harman plots](#harman-plots)
    - [2.3.4 Reconstruct the corrected data](#reconstruct-the-corrected-data-2)
* [3 Working with unbalanced and confounded data](#working-with-unbalanced-and-confounded-data)
  + [3.1 Example dataset](#example-dataset)
    - [3.1.1 Batch structure](#batch-structure)
    - [3.1.2 Running Harman](#running-harman-3)
    - [3.1.3 Reconstruct the corrected data](#reconstruct-the-corrected-data-3)
  + [3.2 Limma analysis](#limma-analysis)
* [4 Methylation data examples](#methylation-data-examples)
  + [4.1 Example dataset](#example-dataset-1)
    - [4.1.1 Loading 450K data](#loading-450k-data)
    - [4.1.2 Appropriate normalisation](#appropriate-normalisation)
    - [4.1.3 Harman correction of M](#harman-correction-of-m)
    - [4.1.4 Reconstruct the corrected data](#reconstruct-the-corrected-data-4)
  + [4.2 Clustering of methylation values](#clustering-of-methylation-values)
    - [4.2.1 Introduction](#introduction-1)
    - [4.2.2 Implications for EWAS](#implications-for-ewas)
    - [4.2.3 Loading the reference matrix](#loading-the-reference-matrix)
    - [4.2.4 Discovering clusters *de novo* in large EWAS studies](#discovering-clusters-de-novo-in-large-ewas-studies)
    - [4.2.5 Thresholding](#thresholding)
  + [4.3 Limma analysis](#limma-analysis-1)
* [5 Mass Spectrophotometry data example](#mass-spectrophotometry-data-example)
  + [5.1 Example dataset](#example-dataset-2)
    - [5.1.1 Loading the mass-spec data](#loading-the-mass-spec-data)
    - [5.1.2 Preprocessing](#preprocessing)
    - [5.1.3 Batch structure](#batch-structure-1)
    - [5.1.4 Running Harman](#running-harman-4)
    - [5.1.5 Reconstruct the corrected data](#reconstruct-the-corrected-data-5)
* [6 Comparison to ComBat](#comparison-to-combat)
  + [6.0.1 IMR90 example data](#imr90-example-data)
  + [6.0.2 Applying Harman and ComBat to adjust for known batches](#applying-harman-and-combat-to-adjust-for-known-batches)
  + [6.0.3 Compare](#compare)
  + [6.0.4 Concluding remarks](#concluding-remarks)

# 1 Introduction

The quantification of methylation can be expressed as the log-transformed ratio of methylated over unmethylated signal (M) or the ratio of methylated over total (methylated plus unmethylated) signal (β). *It is important to use M values when batch effect correcting Infinium methylation data as these are unbounded*. By definition, β is constrained between 0 and 1, and after correction there is no guarantee the values will still be within this range. M values can be batch-adjusted and then transformed back into the more readily interpretable β methylation values by a simple inverse logit transformation. With this transformation, very large negative and positive M values become asymptotic to β of 0 and 1, respectively.

Before detecting clusters, this conversion from M-values to β must be undertaken.

*The Harman package is available from Bioconductor (*[Harman](https://bioconductor.org/packages/3.22/Harman)*).*

# 2 Transcriptome data examples

## 2.1 Working with a simple transciptome microarray dataset

First off, let’s load an example dataset from *[HarmanData](https://bioconductor.org/packages/3.22/HarmanData)* where the batches and experimental variable are balanced.

```
library(Harman)
library(HarmanData)
data(OLF)
```

The olfactory stem cell study is an experiment to gauge the response of human olfactory neurosphere-derived (hONS) cells established from adult donors to ZnO nanoparticles. A total of 28 Affymetrix HuGene 1.0 ST arrays were normalised together using RMA.

The data comprises six treatment groups plus a control group, each consisting of four replicates:

```
table(olf.info)
```

```
##          Batch
## Treatment 1 2 3 4
##         1 1 1 1 1
##         2 1 1 1 1
##         3 1 1 1 1
##         4 1 1 1 1
##         5 1 1 1 1
##         6 1 1 1 1
##         7 1 1 1 1
```

The `olf.info` data.frame has the expt and batch variables across 2 columns, with each sample described in one row to give 28 rows.

```
olf.info[1:7,]
```

```
##    Treatment Batch
## c1         1     1
## c2         2     1
## c3         3     1
## c4         4     1
## c5         5     1
## c6         6     1
## c7         7     1
```

The data is a data.frame of normalised log2 expression values with dimensions: 33297 rows (features) x 28 columns (samples). This data can be handed to Harman as is, or first coerced into a matrix.

```
head(olf.data)
```

```
##         c1      c2      c3      c4      c5      c6      c7      c8      c9
## p1 5.05866 4.58076 5.58438 2.90481 5.39752 4.24041 2.46891 5.34241 2.86128
## p2 4.23886 4.08143 3.21386 3.53045 4.18741 3.70027 3.05552 4.62957 4.09687
## p3 3.66121 2.79664 4.13699 2.86271 3.17795 2.92988 3.05603 3.42135 2.70507
## p4 8.61399 9.09654 9.16841 9.10928 8.94949 8.70754 8.75558 9.31429 8.63934
## p5 2.84004 2.66609 3.03612 3.26561 3.22945 3.32247 3.05079 3.02775 3.18419
## p6 3.12234 3.05058 3.85761 3.07707 3.67759 3.72965 3.43910 3.15980 2.40544
##        c10     c11     c12     c13     c14     c15     c16     c17     c18
## p1 3.03601 4.16908 2.58603 3.14912 2.80076 5.84228 4.51905 3.63710 5.40139
## p2 3.59235 3.61548 3.87856 3.28656 4.12426 4.75150 4.44983 4.59084 4.87332
## p3 3.02844 3.11758 2.78865 3.82057 2.98588 4.34385 3.04461 3.47405 2.96032
## p4 8.67534 8.68344 9.06311 8.57974 9.01710 8.80506 8.82719 9.17436 8.72230
## p5 3.39400 3.27891 2.20645 3.26020 3.10178 3.72065 3.11529 3.75199 3.43958
## p6 3.33047 2.81670 3.34086 2.61524 2.38151 3.06240 4.51134 3.69132 3.08967
##        c19     c20     c21     c22     c23     c24     c25     c26     c27
## p1 4.61271 5.07018 5.11652 3.11507 3.63363 4.00769 4.57562 4.34872 4.81612
## p2 4.24876 4.43532 5.59789 2.64399 3.54669 3.26678 3.31107 4.03487 3.60095
## p3 3.31022 2.89191 3.84660 3.24867 2.56718 2.99377 3.18528 2.99099 3.14193
## p4 9.14509 9.27561 9.17592 8.79834 8.92382 9.42164 9.07371 8.91382 8.76901
## p5 3.41088 3.42294 3.77549 3.47989 2.79997 2.41906 2.64609 3.14506 3.39344
## p6 5.20479 4.35899 3.80101 2.95787 2.82707 2.76646 2.89902 3.28622 4.27340
##        c28
## p1 2.64101
## p2 4.10095
## p3 2.74735
## p4 8.30663
## p5 3.82901
## p6 3.21685
```

### 2.1.1 Running Harman

**Okay, so let’s run Harman.**

```
olf.harman <- harman(olf.data, expt=olf.info$Treatment, batch=olf.info$Batch, limit=0.95)
```

This creates a `harmanresults` S3 object which has a number of slots. These include the centre and rotation slots of a prcomp object which is returned after calling `prcomp(t(x))`, where x is the datamatrix supplied. These two slots are required for reconstructing the data later. The other slots are the factors supplied for the analysis (specified as expt and batch), the runtime parameters and some summary stats for Harman. Finally, there are the original and corrected PC scores.

```
str(olf.harman)
```

```
## List of 7
##  $ factors   :'data.frame':  28 obs. of  4 variables:
##   ..$ expt         : Factor w/ 7 levels "1","2","3","4",..: 1 2 3 4 5 6 7 1 2 3 ...
##   ..$ batch        : Factor w/ 4 levels "1","2","3","4": 1 1 1 1 1 1 1 2 2 2 ...
##   ..$ expt.numeric : int [1:28] 1 2 3 4 5 6 7 1 2 3 ...
##   ..$ batch.numeric: int [1:28] 1 1 1 1 1 1 1 2 2 2 ...
##  $ parameters:List of 4
##   ..$ limit     : num 0.95
##   ..$ numrepeats: int 100000
##   ..$ randseed  : num 5.88e+08
##   ..$ forceRand : logi FALSE
##  $ stats     :'data.frame':  28 obs. of  3 variables:
##   ..$ dimension : chr [1:28] "PC1" "PC2" "PC3" "PC4" ...
##   ..$ confidence: num [1:28] 0.95 0.949 0.95 0.95 0.951 ...
##   ..$ correction: num [1:28] 0.25 0.33 0.5 0.9 0.44 0.85 0.74 1 1 1 ...
##  $ center    : Named num [1:33297] 4.13 3.95 3.19 8.92 3.19 ...
##   ..- attr(*, "names")= chr [1:33297] "p1" "p2" "p3" "p4" ...
##  $ rotation  : num [1:33297, 1:28] -0.020637 -0.011028 -0.006488 -0.000785 -0.00551 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : chr [1:33297] "p1" "p2" "p3" "p4" ...
##   .. ..$ : chr [1:28] "PC1" "PC2" "PC3" "PC4" ...
##  $ original  : num [1:28, 1:28] -26.72 3.79 -19.76 25.66 -3.14 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : chr [1:28] "c1" "c2" "c3" "c4" ...
##   .. ..$ : chr [1:28] "PC1" "PC2" "PC3" "PC4" ...
##  $ corrected : num [1:28, 1:28] -27.17 3.34 -20.21 25.21 -3.59 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : chr [1:28] "c1" "c2" "c3" "c4" ...
##   .. ..$ : chr [1:28] "PC1" "PC2" "PC3" "PC4" ...
##  - attr(*, "class")= chr "harmanresults"
```

### 2.1.2 Inspecting results

Harman objects can be inspected with methods such as `pcaPlot` and `arrowPlot`, as well as the generic functions `plot` and `summary`.

```
plot(olf.harman)
```

![](data:image/png;base64...)

```
arrowPlot(olf.harman, main='Arrowplot of correction')
```

![](data:image/png;base64...)

Using `summary` or inspecting the stats slot we can see Harman corrected the first 7 PCs and left the rest uncorrected.

```
summary(olf.harman)
```

```
## Total factor levels:
##
##  expt batch
##     7     4
##
## Experiment x Batch Design:
##
##     batch
## expt 1 2 3 4
##    1 1 1 1 1
##    2 1 1 1 1
##    3 1 1 1 1
##    4 1 1 1 1
##    5 1 1 1 1
##    6 1 1 1 1
##    7 1 1 1 1
##
## Simulation parameters:
## 100000 simulations (with seed of 587623719). ForceRand is FALSE.
##
## Harman results with confidence limit of 0.95:
##  PC1  PC2  PC3  PC4  PC5  PC6  PC7  PC8  PC9 PC10 PC11 PC12 PC13 PC14 PC15 PC16
## 0.25 0.33 0.50 0.90 0.44 0.85 0.74 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00
## PC17 PC18 PC19 PC20 PC21 PC22 PC23 PC24 PC25 PC26 PC27 PC28
## 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00
##
## Top batch-effected PCs:
##  PC1  PC2  PC5  PC3  PC7
## 0.25 0.33 0.44 0.50 0.74
```

| dimension | confidence | correction |
| --- | --- | --- |
| PC1 | 0.9500996 | 0.25 |
| PC2 | 0.9490076 | 0.33 |
| PC3 | 0.9500139 | 0.50 |
| PC4 | 0.9497873 | 0.90 |
| PC5 | 0.9509498 | 0.44 |
| PC6 | 0.9505247 | 0.85 |
| PC7 | 0.9507247 | 0.74 |
| PC8 | 0.8353300 | 1.00 |
| PC9 | 0.8897871 | 1.00 |
| PC10 | 0.7478036 | 1.00 |
| PC11 | 0.7534338 | 1.00 |
| PC12 | 0.6490559 | 1.00 |
| PC13 | 0.8538693 | 1.00 |
| PC14 | 0.5361958 | 1.00 |
| PC15 | 0.7655424 | 1.00 |
| PC16 | 0.4155103 | 1.00 |
| PC17 | 0.6931610 | 1.00 |
| PC18 | 0.7644623 | 1.00 |
| PC19 | 0.2869585 | 1.00 |
| PC20 | 0.1424034 | 1.00 |
| PC21 | 0.8732809 | 1.00 |
| PC22 | 0.8205077 | 1.00 |
| PC23 | 0.8612620 | 1.00 |
| PC24 | 0.9488360 | 1.00 |
| PC25 | 0.5062507 | 1.00 |
| PC26 | 0.5842571 | 1.00 |
| PC27 | 0.9466016 | 1.00 |
| PC28 | 0.8940783 | 1.00 |

As the confidence (limit) was 0.95, Harman will look for batch effects until this limit is met. It does this by reducing the batch means in an iterative way using a binary search algorithm until the chance that biological variance is being removed (the factor given in expt) is too high. Consider the values specified in the `confidence` column as the likelihood that separation of samples in this PC is due to batch alone and not due to the experimental variable. If this confidence value is less than limit, Harman will not make another iterative correction. For example, on PC8 the confidence is about 0.835 which is below the limit of 0.95, so Harman did not alter data on this PC. Let’s check this on a plot.

```
arrowPlot(olf.harman, 1, 8)
```

![](data:image/png;base64...)

The horizontal arrows show us that, on PC1 the scores were shifted, but on PC8 they were not.

If both dimensions were not shifted, the `arrowPlot` will default to printing **x** instead of arrows (*can’t have 0 length arrows!*)

```
arrowPlot(olf.harman, 8, 9)
```

![](data:image/png;base64...)

We can also easily colour the PCA plot by the experimental variable to compare:

```
par(mfrow=c(1,2))
pcaPlot(olf.harman, colBy='batch', pchBy='expt', main='Col by Batch')
pcaPlot(olf.harman, colBy='expt', pchBy='batch', main='Col by Expt')
```

![](data:image/png;base64...)

### 2.1.3 Reconstruct the corrected data

So, if corrections have been made and we’re happy with the value of limit, then we reconstruct corrected data from the Harman adjusted PC scores. To do this, a harmanresults object is handed to the function `reconstructData()`. This function produces a matrix of the same dimensions as the input matrix filled with corrected data.

```
olf.data.corrected <- reconstructData(olf.harman)
```

This new data can be over-written into something like an ExpressionSet object with a command like `exprs(eset) <- data.corrected`. An example of this is below.

To convince you that Harman is working as it should in reconstructing the data back from the PCA domain, let’s test this principle on the original data.

```
olf.data.remade <- reconstructData(olf.harman, this='original')
all.equal(as.matrix(olf.data), olf.data.remade)
```

```
## [1] TRUE
```

So, the data is indeed the same *(to within the machine epsilon limit for floating point error)!*

### 2.1.4 How does the new data differ from the old data?

Let’s try graphically plotting the differences using `image()`. First, the rows (assays) are ordered by the variation in the difference between the original and corrected data.

```
olf.data.diff <- abs(as.matrix(olf.data) - olf.data.corrected)

diff_rowvar <- apply(olf.data.diff, 1, var)
by_rowvar <- order(diff_rowvar)

par(mfrow=c(1,1))
image(x=1:ncol(olf.data.diff),
      y=1:nrow(olf.data.diff),
      z=t(olf.data.diff[by_rowvar, ]),
      xlab='Sample',
      ylab='Probeset',
      main='Harman probe adjustments (ordered by variance)',
      cex.main=0.7,
      col=brewer.pal(9, 'Reds'))
```

![](data:image/png;base64...)

We can see that most Harman adjusted probes were from batch 3 (samples 15 to 21), while batch 1 is relatively unchanged. In batches 2 and 3, often the same probes were adjusted to a larger extent in batch 3. This suggests some probes on this array design are prone to a batch effect.

## 2.2 Another simple transciptome dataset

The IMR90 Human lung fibroblast cell line data that was published in a paper by Johnson et al doi: 10.1093/biostatistics/kxj037 comes with Harman as an example dataset.

```
require(Harman)
require(HarmanData)
data(IMR90)
```

The data is structured like so:

|  | Treatment | Batch |
| --- | --- | --- |
| \_23\_1CON | 1 | 1 |
| \_23\_2CON | 2 | 1 |
| \_23\_3NO0 | 3 | 1 |
| \_23\_4NO7 | 4 | 1 |
| \_26\_1CON | 1 | 2 |
| \_26\_2CON | 2 | 2 |
| \_26\_3NO0 | 3 | 2 |
| \_26\_4NO7 | 4 | 2 |
| CONTROLZ | 1 | 3 |
| CONTROL7 | 2 | 3 |
| NO\_ZERO | 3 | 3 |
| NO\_7\_5 | 4 | 3 |

It can be seen from the below table the experimental structure is completely balanced.

```
table(expt=imr90.info$Treatment, batch=imr90.info$Batch)
```

```
##     batch
## expt 1 2 3
##    1 1 1 1
##    2 1 1 1
##    3 1 1 1
##    4 1 1 1
```

### 2.2.1 Evidence of batch effects

While there isn’t glaring batch effects in PC1 and PC2, they are more apparent when plotting PC1 and PC3.

```
par(mfrow=c(1,2), mar=c(4, 4, 4, 2) + 0.1)
imr90.pca <- prcomp(t(imr90.data), scale. = TRUE)
prcompPlot(imr90.pca, pc_x=1, pc_y=2, colFactor=imr90.info$Batch,
           pchFactor=imr90.info$Treatment, main='IMR90, PC1 v PC2')
prcompPlot(imr90.pca, pc_x=1, pc_y=3, colFactor=imr90.info$Batch,
           pchFactor=imr90.info$Treatment, main='IMR90, PC1 v PC3')
```

![](data:image/png;base64...)

### 2.2.2 Running Harman

```
imr90.hm <- harman(as.matrix(imr90.data), expt=imr90.info$Treatment,
                   batch=imr90.info$Batch)
```

We can see the most batch correction was actually on the 3rd principal component and the data was also corrected on the 1st and 4th component.

| dimension | confidence | correction |
| --- | --- | --- |
| PC1 | 0.9498640 | 0.76 |
| PC2 | 0.9247775 | 1.00 |
| PC3 | 0.9503938 | 0.35 |
| PC4 | 0.9502018 | 0.69 |
| PC5 | 0.6654655 | 1.00 |
| PC6 | 0.2424223 | 1.00 |
| PC7 | 0.2775396 | 1.00 |
| PC8 | 0.7810260 | 1.00 |
| PC9 | 0.1267338 | 1.00 |
| PC10 | 0.3193122 | 1.00 |
| PC11 | 0.1313642 | 1.00 |
| PC12 | 0.2962281 | 1.00 |

Plotting PC1 v. PC2 and PC1 v. PC3…

```
plot(imr90.hm, pc_x=1, pc_y=2)
```

![](data:image/png;base64...)

```
plot(imr90.hm, pc_x=1, pc_y=3)
```

![](data:image/png;base64...)

While no batch effect was found on PC2, there are batch effects on PC1, 3 and 4. An `arrowPlot()` shows the extent of the correction:

```
arrowPlot(imr90.hm, pc_x=1, pc_y=3)
```

![](data:image/png;base64...)

On PC1 the data has been shifted only a little, while on PC3 a large batch-effect signature seems to be present. The corrected data on the PC1 v. PC3 plot is still a little separated by batch. If we wish to aggressively stomp on the batch effect, (with increased risk of removing some experimental variance), we may specify something like limit=0.9.

```
imr90.hm <- harman(as.matrix(imr90.data), expt=imr90.info$Treatment,
                   batch=imr90.info$Batch, limit=0.9)
plot(imr90.hm, pc_x=1, pc_y=3)
```

![](data:image/png;base64...)
This time the samples across batches are less separated on the plot and there is also a batch effect found on PC2.

| dimension | confidence | correction |
| --- | --- | --- |
| PC1 | 0.8990548 | 0.54 |
| PC2 | 0.9006838 | 0.86 |
| PC3 | 0.8990320 | 0.25 |
| PC4 | 0.8985044 | 0.49 |
| PC5 | 0.6654655 | 1.00 |
| PC6 | 0.2424223 | 1.00 |
| PC7 | 0.2775396 | 1.00 |
| PC8 | 0.7810260 | 1.00 |
| PC9 | 0.1267338 | 1.00 |
| PC10 | 0.3193122 | 1.00 |
| PC11 | 0.1313642 | 1.00 |
| PC12 | 0.2962281 | 1.00 |

### 2.2.3 Reconstruct the corrected data

Again, as before we reconstuct the data. Let’s also use this data to do a comparison: a PCA plot of the original data and shiny new reconstructed data.

```
imr90.data.corrected <- reconstructData(imr90.hm)
par(mfrow=c(1,2))
prcompPlot(imr90.data, 1, 3, colFactor=imr90.hm$factors$batch, cex=1.5, main='PCA, Original')
prcompPlot(imr90.data.corrected, 1, 3, colFactor=imr90.hm$factors$batch, cex=1.5, main='PCA, Corrected')
```

![](data:image/png;base64...)

## 2.3 Working with very small datasets

This example is an illustration of how Harman will have reduced power in teasing apart biological and technical variance when presented with a very small dataset (2 replicates and 2 conditions).

To illustrate, we use the toy dataset in *[affydata](https://bioconductor.org/packages/3.22/affydata)*. The `Dilution` data within relates to two sources of cRNA, A (human liver tissue) and B (Central Nervous System cell line), which have been hybridized to human array (HGU95A) in a range of proportions and dilutions.

This toy example is taken from arrays hybridized to source A at 10 μg and 20 μg. There are two replicate arrays for each generated cRNA, with each array replicate processed in a different scanner. [*For more information see Gautier et al., affy - Analysis of Affymetrix GeneChip data at the probe level*](http://bioinformatics.oxfordjournals.org/content/20/3/307.full.pdf).

```
library(affydata, quietly = TRUE, warn.conflicts = FALSE)
```

```
FALSE      Package    LibPath                                        Item
FALSE [1,] "affydata" "/home/biocbuild/bbs-3.22-bioc/R/site-library" "Dilution"
FALSE      Title
FALSE [1,] "AffyBatch instance Dilution"
```

```
data(Dilution)
Dilution.log <- Dilution
intensity(Dilution.log) <- log(intensity(Dilution))
cols <- brewer.pal(nrow(pData(Dilution)), 'Paired')
```

This dataset contains technical replicates of liver RNA run on two different scanners. Technical replicates are denoted as A and B samples. There are two technical replicates across two array scanners. The 10 and 20 The second 2 are also replicates. The second arrays are hybridized to twice as much RNA so the intensities should be, in general, bigger.

|  | liver | sn19 | scanner |
| --- | --- | --- | --- |
| 20A | 20 | 0 | 1 |
| 20B | 20 | 0 | 2 |
| 10A | 10 | 0 | 1 |
| 10B | 10 | 0 | 2 |

```
boxplot(Dilution, col=cols)
```

```
## Warning: replacing previous import 'AnnotationDbi::tail' by 'utils::tail' when
## loading 'hgu95av2cdf'
```

```
## Warning: replacing previous import 'AnnotationDbi::head' by 'utils::head' when
## loading 'hgu95av2cdf'
```

```
##
```

![](data:image/png;base64...)

Notice that the scanner effect (A vs B) is stronger than the RNA concentration effect (10 vs 20). This certainly hints at a batch effect.

Let’s normalize the data by two methods (Loess and Quantile) and see if it removes this technical noise.

```
Dilution.loess <- normalize(Dilution.log, method="loess")
```

```
## Done with 1 vs 2 in iteration 1
## Done with 1 vs 3 in iteration 1
## Done with 1 vs 4 in iteration 1
## Done with 2 vs 3 in iteration 1
## Done with 2 vs 4 in iteration 1
## Done with 3 vs 4 in iteration 1
## 1 0.01018877
```

```
Dilution.qnt <- normalize(Dilution.log, method="quantiles")

# define a quick PCA and plot function
pca <- function(exprs, pc_x=1, pc_y=2, cols, ...) {
  pca <- prcomp(t(exprs), retx=TRUE, center=TRUE)
  if(is.factor(cols)) {
    factor_names <- levels(cols)
    num_levels <- length(factor_names)
    palette <- rainbow(num_levels)
    mycols <- palette[cols]
  } else {
    mycols <- cols
  }
  plot(pca$x[, pc_x], pca$x[, pc_y],
       xlab=paste('PC', pc_x, sep=''),
       ylab=paste('PC', pc_y, sep=''),
       col=mycols, ...)
  if(is.factor(cols)) {
    legend(x=min(pca$x[, pc_x]), y=max(pca$x[, pc_y]),
           legend=factor_names, fill=palette, cex=0.5)
  }
}

par(mfrow=c(1,2), mar=c(4, 4, 4, 2) + 0.1)
boxplot(Dilution.loess, col=cols, main='Loess')
boxplot(Dilution.qnt, col=cols, main='Quantile')
```

![](data:image/png;base64...)

```
pca(exprs(Dilution.loess), cols=cols, cex=1.5, pch=16, main='PCA Loess')
pca(exprs(Dilution.qnt), cols=cols, cex=1.5, pch=16, main='PCA Quantile')
```

![](data:image/png;base64...)

The boxplots give the impression the batch effect has been removed. However, principal component analysis (PCA) shows the batch effect to still be the largest source of variance in the data. PC1 is dominated by batch effect (seperation of bold and pastel colours), while on PC2 the effect of RNA quantity is observed, so green (10 μg) compared with blue (20 μg).

### 2.3.1 Running Harman

Let’s fire up harman and try to remove this batch effect.

```
library(Harman)
loess.hm <- harman(exprs(Dilution.loess),
                   expt=pData(Dilution.loess)$liver,
                   batch=pData(Dilution.loess)$scanner)
qnt.hm <- harman(exprs(Dilution.qnt),
                 expt=pData(Dilution.qnt)$liver,
                 batch=pData(Dilution.qnt)$scanner)
```

If we inspect the stats on the Harman runs,

Loess-normalised data

| dimension | confidence | correction |
| --- | --- | --- |
| PC1 | 0.7728267 | 1 |
| PC2 | 0.4878121 | 1 |
| PC3 | 0.1367558 | 1 |
| PC4 | 0.3157739 | 1 |

Quantile-normalised data

| dimension | confidence | correction |
| --- | --- | --- |
| PC1 | 0.7784752 | 1 |
| PC2 | 0.0199157 | 1 |
| PC3 | 0.0628038 | 1 |
| PC4 | 0.8046682 | 1 |

**The correction statistic is 1.0 for all dimensions, so Harman didn’t find any batch effect!**

### 2.3.2 More aggressive settings

While our intuition tells us there is a batch effect, with the default settings (limit=0.95), harman fails to find one. *This is due to the fact there are only two replicates in each batch!* Let’s step up the limit now, to a confidence interval of 0.75. So, we are 75% sure only technical (batch) variation and not biological variation is being removed.

```
loess.hm <- harman(exprs(Dilution.loess),
                   expt=pData(Dilution.loess)$liver,
                   batch=pData(Dilution.loess)$scanner,
                   limit=0.75)
qnt.hm <- harman(exprs(Dilution.qnt),
                 expt=pData(Dilution.qnt)$liver,
                 batch=pData(Dilution.qnt)$scanner,
                 limit=0.75)
```

This time a batch effect is found on PC1.

Loess-normalised data

| dimension | confidence | correction |
| --- | --- | --- |
| PC1 | 0.7498986 | 0.47 |
| PC2 | 0.4878121 | 1.00 |
| PC3 | 0.1367558 | 1.00 |
| PC4 | 0.3157739 | 1.00 |

Quantile-normalised data

| dimension | confidence | correction |
| --- | --- | --- |
| PC1 | 0.7491598 | 0.17 |
| PC2 | 0.0199157 | 1.00 |
| PC3 | 0.0628038 | 1.00 |
| PC4 | 0.7494596 | 0.73 |

### 2.3.3 Harman plots

So what corrections did Harman make with limit=0.75? Let’s take a look…

```
par(mfrow=c(2,2), mar=c(4, 4, 4, 2) + 0.1)
plot(loess.hm, 1, 2, pch=17, col=cols)
```

![](data:image/png;base64...)

```
plot(qnt.hm, 1, 2, pch=17, col=cols)
```

![](data:image/png;base64...)

### 2.3.4 Reconstruct the corrected data

```
Dilution.loess.hm <- Dilution.loess
Dilution.qnt.hm <- Dilution.qnt
exprs(Dilution.loess.hm) <- reconstructData(loess.hm)
exprs(Dilution.qnt.hm) <- reconstructData(qnt.hm)
```

```
detach('package:affydata')
```

# 3 Working with unbalanced and confounded data

## 3.1 Example dataset

The dataset (*[bladderbatch](https://bioconductor.org/packages/3.22/bladderbatch)*) for this exercise is that discussed by Jeff Leek and others [here](http://www.nature.com/nrg/journal/v11/n10/pdf/nrg2825.pdf) and arises from this [paper](http://www.ncbi.nlm.nih.gov/pubmed/15173019). This was a bladder cancer study comparing Affymetrix HG-U133A microarray expression profiles across five groups: superficial transitional cell carcinoma (sTCC) with surrounding carcinoma *in situ* (CIS) lesions (sTCC+CIS) or without surrounding CIS lesions (sTCC-CIS), muscle invasive carcinomas (mTCC) with normal bladder mucosa from patients without a bladder cancer history (Normal) and biopsies from cystectomy specimens (Biopsy). The arrays were run on 5 different days (5 batches).

First, loading the data:

```
library(bladderbatch)
library(Harman)
# This loads an ExpressionSet object called bladderEset
data(bladderdata)
bladderEset
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 22283 features, 57 samples
##   element names: exprs, se.exprs
## protocolData: none
## phenoData
##   sampleNames: GSM71019.CEL GSM71020.CEL ... GSM71077.CEL (57 total)
##   varLabels: sample outcome batch cancer
##   varMetadata: labelDescription
## featureData: none
## experimentData: use 'experimentData(object)'
## Annotation: hgu133a
```

The phenotype data.

|  | sample | outcome | batch | cancer |
| --- | --- | --- | --- | --- |
| GSM71019.CEL | 1 | Normal | 3 | Normal |
| GSM71020.CEL | 2 | Normal | 2 | Normal |
| GSM71021.CEL | 3 | Normal | 2 | Normal |
| GSM71022.CEL | 4 | Normal | 3 | Normal |
| GSM71023.CEL | 5 | Normal | 3 | Normal |
| GSM71024.CEL | 6 | Normal | 3 | Normal |
| GSM71025.CEL | 7 | Normal | 2 | Normal |
| GSM71026.CEL | 8 | Normal | 2 | Normal |
| GSM71028.CEL | 9 | sTCC+CIS | 5 | Cancer |
| GSM71029.CEL | 10 | sTCC-CIS | 2 | Cancer |
| GSM71030.CEL | 11 | sTCC-CIS | 5 | Cancer |
| GSM71031.CEL | 12 | sTCC-CIS | 2 | Cancer |
| GSM71032.CEL | 13 | sTCC+CIS | 5 | Cancer |
| GSM71033.CEL | 14 | sTCC-CIS | 2 | Cancer |
| GSM71034.CEL | 15 | sTCC+CIS | 5 | Cancer |
| GSM71035.CEL | 16 | sTCC+CIS | 5 | Cancer |
| GSM71036.CEL | 17 | sTCC-CIS | 2 | Cancer |
| GSM71037.CEL | 18 | mTCC | 1 | Cancer |
| GSM71038.CEL | 19 | sTCC+CIS | 5 | Cancer |
| GSM71039.CEL | 20 | mTCC | 1 | Cancer |
| GSM71040.CEL | 21 | mTCC | 2 | Cancer |
| GSM71041.CEL | 22 | mTCC | 1 | Cancer |
| GSM71042.CEL | 23 | sTCC-CIS | 2 | Cancer |
| GSM71043.CEL | 24 | sTCC+CIS | 5 | Cancer |
| GSM71044.CEL | 25 | sTCC-CIS | 2 | Cancer |
| GSM71045.CEL | 26 | sTCC-CIS | 2 | Cancer |
| GSM71046.CEL | 27 | sTCC+CIS | 5 | Cancer |
| GSM71047.CEL | 28 | mTCC | 1 | Cancer |
| GSM71048.CEL | 29 | mTCC | 1 | Cancer |
| GSM71049.CEL | 30 | sTCC-CIS | 2 | Cancer |
| GSM71050.CEL | 31 | mTCC | 1 | Cancer |
| GSM71051.CEL | 32 | mTCC | 1 | Cancer |
| GSM71052.CEL | 33 | mTCC | 1 | Cancer |
| GSM71053.CEL | 34 | sTCC+CIS | 5 | Cancer |
| GSM71054.CEL | 35 | mTCC | 1 | Cancer |
| GSM71055.CEL | 36 | sTCC-CIS | 2 | Cancer |
| GSM71056.CEL | 37 | sTCC-CIS | 2 | Cancer |
| GSM71058.CEL | 38 | sTCC-CIS | 2 | Cancer |
| GSM71059.CEL | 39 | sTCC-CIS | 2 | Cancer |
| GSM71060.CEL | 40 | mTCC | 1 | Cancer |
| GSM71061.CEL | 41 | sTCC+CIS | 5 | Cancer |
| GSM71062.CEL | 42 | sTCC+CIS | 5 | Cancer |
| GSM71063.CEL | 43 | sTCC+CIS | 5 | Cancer |
| GSM71064.CEL | 44 | sTCC-CIS | 2 | Cancer |
| GSM71065.CEL | 45 | sTCC-CIS | 5 | Cancer |
| GSM71066.CEL | 46 | mTCC | 1 | Cancer |
| GSM71067.CEL | 47 | sTCC-CIS | 5 | Cancer |
| GSM71068.CEL | 48 | sTCC+CIS | 5 | Cancer |
| GSM71069.CEL | 49 | Biopsy | 4 | Biopsy |
| GSM71070.CEL | 50 | Biopsy | 4 | Biopsy |
| GSM71071.CEL | 51 | Biopsy | 5 | Biopsy |
| GSM71072.CEL | 52 | Biopsy | 5 | Biopsy |
| GSM71073.CEL | 53 | Biopsy | 5 | Biopsy |
| GSM71074.CEL | 54 | Biopsy | 5 | Biopsy |
| GSM71075.CEL | 55 | Biopsy | 4 | Biopsy |
| GSM71076.CEL | 56 | Biopsy | 4 | Biopsy |
| GSM71077.CEL | 57 | Biopsy | 4 | Biopsy |

A table of batch by outcome.

```
table(batch=pData(bladderEset)$batch, expt=pData(bladderEset)$outcome)
```

```
##      expt
## batch Biopsy mTCC Normal sTCC-CIS sTCC+CIS
##     1      0   11      0        0        0
##     2      0    1      4       13        0
##     3      0    0      4        0        0
##     4      5    0      0        0        0
##     5      4    0      0        3       12
```

### 3.1.1 Batch structure

The experimental design is very poor in controlling for a batch effect. Ideally, the five factors should be distributed across the five run dates (batches). Instead, four out of the five experimental factors are distributed across two batches. The sTCC+CIS samples are all within batch 5. In this instance, batch is completely confounded with the experimental variable, so any variation in the data will be a sum of the biological variance and technical variance. Any inference about the difference of sTCC+CIS to other groups needs to be made very guardedly. It is also worth noting the spread of the mTCC samples across batches is suboptimal. While there are 11 samples in batch 1, there is only a single sample in batch 2. Finally, batches 3 and 4 have only one sample type.

Let’s explore the multivariate grouping of the data by generating some PCA plots, first with colouring by batch and then by experimental variable.

```
par(mfrow=c(1,2))
prcompPlot(exprs(bladderEset), colFactor=pData(bladderEset)$batch,
    pchFactor=pData(bladderEset)$outcome, main='Col by Batch')
prcompPlot(exprs(bladderEset), colFactor=pData(bladderEset)$outcome,
    pchFactor=pData(bladderEset)$batch, main='Col by Expt')
```

![](data:image/png;base64...)

The batch structures are highly unbalanced and so a batch effect is not immediately obvious to casual observation. However, a closer examination of samples that are represented well across two batches (Biopsy and Normal), shows a batch effect is certainly present. Certainly, with an older microarray technology like the Affymetrix HG-U133A, batch effects will be present.

### 3.1.2 Running Harman

Even though the batch structures are highly unbalanced, this dataset is quite large - so, we expect Harman to be well powered to find batch effects. Let’s take a look.

```
expt <- pData(bladderEset)$outcome
batch <- pData(bladderEset)$batch
bladder_harman <- harman(exprs(bladderEset), expt=expt, batch=batch)
sum(bladder_harman$stats$correction < 1)
```

```
## [1] 46
```

Harman found 46 of the
57 PCs had a batch effect.

```
summary(bladder_harman)
```

```
## Total factor levels:
##
##  expt batch
##     5     5
##
## Experiment x Batch Design:
##
##           batch
## expt        1  2  3  4  5
##   Biopsy    0  0  0  5  4
##   mTCC     11  1  0  0  0
##   Normal    0  4  4  0  0
##   sTCC-CIS  0 13  0  0  3
##   sTCC+CIS  0  0  0  0 12
##
## Simulation parameters:
## 100000 simulations (with seed of 119937713). ForceRand is FALSE.
##
## Harman results with confidence limit of 0.95:
##  PC1  PC2  PC3  PC4  PC5  PC6  PC7  PC8  PC9 PC10 PC11 PC12 PC13 PC14 PC15 PC16
## 0.00 0.56 0.07 0.11 0.27 0.56 0.38 0.10 0.22 0.25 0.24 0.42 0.60 0.28 0.36 0.46
## PC17 PC18 PC19 PC20 PC21 PC22 PC23 PC24 PC25 PC26 PC27 PC28 PC29 PC30 PC31 PC32
## 0.24 1.00 0.62 0.15 0.24 0.51 0.70 0.42 0.35 0.60 0.44 0.37 0.82 0.37 0.33 0.32
## PC33 PC34 PC35 PC36 PC37 PC38 PC39 PC40 PC41 PC42 PC43 PC44 PC45 PC46 PC47 PC48
## 0.47 0.53 0.25 0.46 0.61 1.00 0.34 0.88 1.00 1.00 1.00 0.81 1.00 0.47 1.00 0.74
## PC49 PC50 PC51 PC52 PC53 PC54 PC55 PC56 PC57
## 1.00 0.72 0.89 1.00 0.97 0.94 1.00 1.00 0.08
##
## Top batch-effected PCs:
##  PC1  PC3 PC57  PC8  PC4
## 0.00 0.07 0.08 0.10 0.11
```

The `summary()` shows PC3 to be highly affected by batch. Now plotting the original and corrected data.

```
par(mfrow=c(1,1))
plot(bladder_harman)
```

![](data:image/png;base64...)

This time for PCs 1 and 3.

```
plot(bladder_harman, 1, 3)
```

![](data:image/png;base64...)

Now the PC scores changes displayed on an `arrowPlot`.

```
arrowPlot(bladder_harman, 1, 3)
```

![](data:image/png;base64...)

### 3.1.3 Reconstruct the corrected data

First create a new object and then fill the exprs slot of the ExpressionSet object with Harman corrected data. Alternatively, the existing object can have the exprs slot overwritten.

```
CorrectedBladderEset <- bladderEset
exprs(CorrectedBladderEset) <- reconstructData(bladder_harman)
comment(bladderEset) <- 'Original'
comment(CorrectedBladderEset) <- 'Corrected'
```

## 3.2 Limma analysis

Let’s check the effects of Harman with a *[limma](https://bioconductor.org/packages/3.22/limma)* analysis. First fitting the original data:

```
library(limma, quietly=TRUE)
design <- model.matrix(~0 + expt)
colnames(design) <- c("Biopsy", "mTCC", "Normal", "sTCC", "sTCCwCIS")
contrast_matrix <- makeContrasts(sTCCwCIS - sTCC, sTCCwCIS - Normal,
                                 Biopsy - Normal,
                                 levels=design)

fit <- lmFit(exprs(bladderEset), design)
fit2 <- contrasts.fit(fit, contrast_matrix)
fit2 <- eBayes(fit2)
summary(decideTests(fit2))
```

```
##        sTCCwCIS - sTCC sTCCwCIS - Normal Biopsy - Normal
## Down              7063              8975            1014
## NotSig           11447              7059           20678
## Up                3773              6249             591
```

Now a linear model on the Harman corrected data:

```
fit_hm <- lmFit(exprs(CorrectedBladderEset), design)
fit2_hm <- contrasts.fit(fit_hm, contrast_matrix)
fit2_hm <- eBayes(fit2_hm)
summary(decideTests(fit2_hm))
```

```
##        sTCCwCIS - sTCC sTCCwCIS - Normal Biopsy - Normal
## Down                 0              6147               0
## NotSig           22283             12680           22263
## Up                   0              3456              20
```

We can see the dramatic effect Harman has had in reducing the number of significant microarray probes. The huge reduction in the Biopsy - Normal contrast makes biological sense, about half of the biopsies were from cystectomies that were histologically normal. The Harman corrected data on the sTCCwCIS - sTCC contrast suggests that surrounding *in situ* lesions (CIS) does not overly impact the transcriptome of superficial transitional cell carcinoma (sTCC).

# 4 Methylation data examples

## 4.1 Example dataset

As an example, let’s consider the Illumina Infinium HumanMethylation450 BeadChip data (450k array). First up, an important tip, **put M-values into Harman (M), not Beta-values (β).** Harman is designed for continuous ordinal data, not data which is constrained, such as β; which by definition are between 0 and 1. Input M into Harman and if β are needed downstream, convert the corrected M back into β using something like the `m2beta()` function in the *[lumi](https://bioconductor.org/packages/3.22/lumi)* package, or the `ilogit2()` function in *[minfi](https://bioconductor.org/packages/3.22/minfi)*.

M-values also have the property of having far more centrality than β. PCA is a parametric technique and so it works best with an underlying Gaussian distribution to the data. While it has been historically shown that PCA works rather well in non-parametric settings, Harman might be expected to be more sensitive if the data is more centred (M), rather than bimodal at the extremes (β).

β of exactly 0 or 1 will translate to minus infinity and infinity, respectively, in M space. M is the `logit2()` of a β and β are `ilogit2` of M. These infinite values will make the internal singular value decomposition (SVD) step of Harman throw an exception. Further, infinite M-values are not commutative. If an M of Inf or -Inf is transformed back into a β it will have the value NaN or 0, respectively. For these reasons we do not recommend a normalisation step which creates β of exactly 0 or 1.

```
library(minfi, quietly = TRUE)
logit2
```

```
## function (x)
## log2(x) - log2(1 - x)
## <bytecode: 0x65362565a710>
## <environment: namespace:minfi>
```

```
ilogit2
```

```
## function (x)
## 2^x/(1 + 2^x)
## <bytecode: 0x6536256f5470>
## <environment: namespace:minfi>
```

```
ilogit2(Inf)
```

```
## [1] NaN
```

```
ilogit2(-Inf)
```

```
## [1] 0
```

A normalisation technique such as `preprocessIllumina()` in the *[minfi](https://bioconductor.org/packages/3.22/minfi)* package will give some β of exactly 0 or 1, while a technique such as `preprocessSWAN()` does not. Instead it incorporates a small offset, alpha, as suggested by [Pan Du et al](http://www.biomedcentral.com/content/pdf/1471-2105-11-587.pdf). If you have a `MethySet` object, the *[minfi](https://bioconductor.org/packages/3.22/minfi)* package now allows a user to specify an `offset` to the β as well as a `betaThreshold` to constrain betas away from 0 or 1.

While we do not recommend use of a normalisation technique that generate β of exactly 0 or 1, sometimes, we realise, only this normalised data is available. For instance, when the data has been downloaded from a public resource, pre-normalised with no raw red and green channel data. For this case, we have supplied the `shiftBetas()` helper function in Harman to resolve this problem. We shift beta values of *exactly* 0 or 1 by a very small amount (typically 1 x 10-4) before transformation into M. As an example:

```
betas <- seq(0, 1, by=0.05)
betas
```

```
##  [1] 0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70
## [16] 0.75 0.80 0.85 0.90 0.95 1.00
```

```
newBetas <- shiftBetas(betas, shiftBy=1e-4)
newBetas
```

```
##  [1] 0.0001 0.0500 0.1000 0.1500 0.2000 0.2500 0.3000 0.3500 0.4000 0.4500
## [11] 0.5000 0.5500 0.6000 0.6500 0.7000 0.7500 0.8000 0.8500 0.9000 0.9500
## [21] 0.9999
```

```
range(betas)
```

```
## [1] 0 1
```

```
range(newBetas)
```

```
## [1] 0.0001 0.9999
```

```
logit2(betas)
```

```
##  [1]       -Inf -4.2479275 -3.1699250 -2.5025003 -2.0000000 -1.5849625
##  [7] -1.2223924 -0.8930848 -0.5849625 -0.2895066  0.0000000  0.2895066
## [13]  0.5849625  0.8930848  1.2223924  1.5849625  2.0000000  2.5025003
## [19]  3.1699250  4.2479275        Inf
```

```
logit2(newBetas)
```

```
##  [1] -13.2875681  -4.2479275  -3.1699250  -2.5025003  -2.0000000  -1.5849625
##  [7]  -1.2223924  -0.8930848  -0.5849625  -0.2895066   0.0000000   0.2895066
## [13]   0.5849625   0.8930848   1.2223924   1.5849625   2.0000000   2.5025003
## [19]   3.1699250   4.2479275  13.2875681
```

### 4.1.1 Loading 450K data

So, let’s get underway and analyse the toy dataset supplied with minfi.

```
library(minfiData, quietly = TRUE)
baseDir <- system.file("extdata", package="minfiData")
targets <- read.metharray.sheet(baseDir)
```

```
## [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/minfiData/extdata/SampleSheet.csv"
```

Read in the files, normalise using `preprocessSWAN()` and `preprocessIllumina()` and filter out poorly called CpG sites.

```
rgSet <- read.metharray.exp(targets=targets)
mSetSw <- preprocessSWAN(rgSet)

mSet <- preprocessIllumina(rgSet, bg.correct=TRUE, normalize="controls",
                           reference=2)
detP <- detectionP(rgSet)
keep <- rowSums(detP < 0.01) == ncol(rgSet)
mSetIl <- mSet[keep,]
mSetSw <- mSetSw[keep,]
```

This dataset has quite a few phenotype variables of interest. The samples are paired cancer-normal samples from three people, 1 male and 2 females.

|  | Sample\_Group | person | sex | status | Array | Slide |
| --- | --- | --- | --- | --- | --- | --- |
| 5723646052\_R02C02 | GroupA | id3 | M | normal | R02C02 | 5723646052 |
| 5723646052\_R04C01 | GroupA | id2 | F | normal | R04C01 | 5723646052 |
| 5723646052\_R05C02 | GroupB | id3 | M | cancer | R05C02 | 5723646052 |
| 5723646053\_R04C02 | GroupB | id1 | F | cancer | R04C02 | 5723646053 |
| 5723646053\_R05C02 | GroupA | id1 | F | normal | R05C02 | 5723646053 |
| 5723646053\_R06C02 | GroupB | id2 | F | cancer | R06C02 | 5723646053 |

As mentioned above, it is prudent to look for sources of biological epigenetic variance which is potentially unrelated to the main experimental factor. If the source of variance has high population prevalence, it will often present by chance with unequal representation across each batch. If the biological variance is undeclared, batch effect correction methods will naïvely mistake this as array feature technical variance and moderate batches with unequal representation towards the global mean. In DNA methylation studies, obvious sources of biological variance are gender and cellular composition.

Doing some exploratory data analysis using MDS (considering it is methylation data), we can see that status is separated on PC1 and sex on PC2. This makes biological sense as we know cancer and gender both have large effects on DNA methylation. In cancer samples, there is typically global hypomethylation and focal hypermethylation at some CpG islands. While in the case of gender, female and male samples have very different X chromosome methylation (due to X chromosome inactivation in females) and there are also other DNA gender-associated methylation differences on the autosomes.

If the plot is recoloured by “Slide”", there is some suggestion a batch effect is intermingled with these two experimental variables. The tricky question is how to use Harman to remove the influence of Slide on the data, without also removing variance due to the experimental variables of interest?

```
par(mfrow=c(1, 1))
cancer_by_gender_factor <- as.factor(paste(pData(mSetSw)$sex,
                                           pData(mSetSw)$status)
                                     )

mdsPlot(mSetSw, sampGroups=cancer_by_gender_factor, pch=16)
```

![](data:image/png;base64...)

```
mdsPlot(mSetSw, sampGroups=as.factor(pData(mSet)$Slide), pch=16)
```

![](data:image/png;base64...)
The experiment is very small, with only 6 (paired) samples. The MDS plots suggests there are two main phenotypes of influence, status and sex. The batch variable in this case is “Slide”. The sex phenotype variable, which is highly influencing the data, is spread unevenly across the two slides (batches).

```
table(gender=pData(mSetSw)$sex, slide=pData(mSetSw)$Slide)
```

```
##       slide
## gender 5723646052 5723646053
##      F          1          3
##      M          2          0
```

From the table, we can see that only slide 5723646052 has samples of male origin. If we specify a simple cancer-based model with `expt=pData(mSetSw)$status` and `batch=pData(mSetSw)$Slide`, Harman will attribute the male-specific methylation signature of the two paired male samples on slide 5723646052 as batch effect and will try and eliminate it.

There are two strategies here:
1. Form a compound factor by joining the status and sex factors together.
2. Generate two Harman corrections, one for status and one for sex.

As this experiment is so small, the first strategy won’t be very effective. Only the factor level “F normal” is shared by both batches and for only one replicate. It’s very hard for Harman to get an idea of the batch distributions.

```
cancer_by_gender_factor <- as.factor(paste(pData(mSetSw)$sex,
                                           pData(mSetSw)$status)
                                     )
table(expt=cancer_by_gender_factor, batch=pData(mSetSw)$Slide)
```

```
##           batch
## expt       5723646052 5723646053
##   F cancer          0          2
##   F normal          1          1
##   M cancer          1          0
##   M normal          1          0
```

In the second strategy, both levels of expt are shared across both levels of batch. This is a far more ideal way to find batch effects. Of course though, *there is confounding between sex and Slide!* So, in these cases, do not consider a batch confounded factor in downstream differential analysis.

```
table(expt=pData(mSetSw)$status, batch=pData(mSetSw)$Slide)
```

```
##         batch
## expt     5723646052 5723646053
##   cancer          1          2
##   normal          2          1
```

### 4.1.2 Appropriate normalisation

If the β distribution is shifted away from 0 or 1 by a very small amount, (say 1e-7), this will generate extreme M-values. Instead a moderate correction (such as 1e-4) seems the preferred option.

```
par(mfrow=c(2,2))
library(lumi, quietly = TRUE)
```

```
## No methods found in package 'RSQLite' for request: 'dbListFields' when loading 'lumi'
```

```
##
## Attaching package: 'lumi'
```

```
## The following objects are masked from 'package:affy':
##
##     MAplot, plotDensity
```

```
shifted_betas <- shiftBetas(betas=getBeta(mSetIl), shiftBy=1e-7)
shifted_ms <- beta2m(shifted_betas)  # same as logit2() from package minfi
plot(density(shifted_ms, 0.05), main="Shifted M-values, shiftBy = 1e-7",
     cex.main=0.7)

shifted_betas <- shiftBetas(betas=getBeta(mSetIl), shiftBy=1e-4)
shifted_ms <- beta2m(shifted_betas)  # same as logit2() from package minfi
plot(density(shifted_ms, 0.05), main="Shifted M-values, shiftBy = 1e-4",
     cex.main=0.7)

plot(density(beta2m(getBeta(mSetSw)), 0.05), main="SWAN normalised M-values",
     cex.main=0.7)
```

![](data:image/png;base64...)

It can be seen that M have far more central-tendency (more Gaussian-like) than β.

```
par(mfrow=c(1,2))
plot(density(shifted_betas, 0.1), main="Beta-values, shiftBy = 1e-4",
     cex.main=0.7)
plot(density(shifted_ms, 0.1), main="M-values, shiftBy = 1e-4",
     cex.main=0.7)
```

![](data:image/png;base64...)

A comparison of M-values produced by the GenomeStudio-like `preprocessIllumina()` function and by `preprocessSWAN()`.

```
par(mfrow=c(1,2))
plot(density(shifted_ms, 0.1),
     main="GenomeStudio-like M-values, shiftBy = 1e-4", cex.main=0.7)
plot(density(getM(mSetSw), 0.1), main="SWAN M-values", cex.main=0.7)
```

![](data:image/png;base64...)

**From here on, we will work with SWAN normalised M.**

### 4.1.3 Harman correction of M

For this example, status is declared as the experimental variable. When comparing conditions with very large DNA methylation differences, such as cancer and non-neoplastic samples, the batch effect will not be so easy to observe amongst all that biological variation. This scenario changes with a more subtle phenotype of interest. More arrays in each batch will allow Harman to more easily find batch effects. Considering this experiment is so small, an aggressive setting (limit=0.65) is needed to find a batch effect across a number of PCs (PCs 2, 5 and 1 in particular). A plot shows the correction made was relatively minor.

```
methHarman <- harman(getM(mSetSw), expt=pData(mSetSw)$status,
                     batch=pData(mSetSw)$Slide, limit=0.65)
summary(methHarman)
```

```
## Total factor levels:
##
##  expt batch
##     2     2
##
## Experiment x Batch Design:
##
##         batch
## expt     5723646052 5723646053
##   cancer          1          2
##   normal          2          1
##
## Simulation parameters:
## 100000 simulations (with seed of 254101460). ForceRand is FALSE.
##
## Harman results with confidence limit of 0.65:
##  PC1  PC2  PC3  PC4  PC5  PC6
## 0.96 0.61 1.00 1.00 0.92 1.00
##
## Top batch-effected PCs:
##  PC2  PC5  PC1
## 0.61 0.92 0.96
```

```
plot(methHarman, 2, 5)
```

![](data:image/png;base64...)

### 4.1.4 Reconstruct the corrected data

It is difficult to tease out the batch effect with such a small experimental group. Rather than further reduce the limit, let’s just convert the data back.

```
ms_hm <- reconstructData(methHarman)
betas_hm <- m2beta(ms_hm)
```

## 4.2 Clustering of methylation values

### 4.2.1 Introduction

**There are caveats with batch-effect correction of methylation data**. The distribution of β at particular CpG sites may be modal in nature, which results in a clustered methylation pattern across samples. Clustered methylation profiles can be due to technical or biological factors, and batch correction should ideally remove the former but preserve the latter.

Harman (and other methods such as ComBat) have biological variance to keep declared per sample, rather than per CpG site, so they are prone to erroneously attributing methylation clustering at particular CpG sites to technical factors. When the distribution of biologically relevant clustered methylation is unbalanced across batches, then batch effect removal software will inappropriately seek to converge the means of each batch. It is good practice to retrospectively identify the CpG sites subject to such erroneous correction as it can profoundly destroy biologically meaningful clustering of the data.

The first recommendation is to undertake exploratory data analysis (like the MDS plotting example above) to look for obvious sample-wise sources of biological variance in the data, such as gender and cellular composition. These sources of sample-wise biological variance should be declared *a priori* and incorporated as factors into the batch correction. Without this, methods such as Harman and ComBat will seek to eliminate this biological variance when the batches have unequal loading of these factors.

The second recommendation is to look for inappropriate feature-wise correction. Often this feature-wise biological variance on methylation arrays is the result of a single nucleotide polymorphism (SNP) at the cytosine within the measured CpG site. C-to-T transversion events at CpG sites are the most frequent SNPs in the genome and post-bisulfite conversion, this inherited genotype is misrepresented as epigenetic state – an inherited ‘T’ allele and a bisulfite-treated unmethylated ‘C’ allele are identical. CpG sites might also have methylation rates influenced by other proximal or distal SNPs. These cis-acting DNA polymorphisms can create allele-specific DNA methylation (ASM). Identifying feature-wise biological variance *a priori* is problematic. Filtering the features by lists of proximal SNPs does not account for unknown relationships between methylation state and distal SNPs, nor metastable epialleles. To optimally apply batch effect correction, we must empirically identify *post-hoc* the features where the algorithm is incorrectly distorting the data.

The aim of batch-effect correction is to reduce technical variance in the data. When the methylation data is clustered with unequal epiallele loadings across batches, batch-effect removal algorithms will moderate the batches together, reducing technical variance but destroying the biologically relevant clustering patterns. The more recent versions of Harman (since V1.24) have a solution to identify inappropriate correction via a ‘cluster-aware’ variance statistic instead of considering variance in totality. This statistic computes the sum of squares relative to each individual cluster centroid and not the centroid of all the data. The ‘cluster-aware’ variance statistic will separate out instances of appropriate and inappropriate correction. Thereafter, investigators can use batch-effect corrected values for CpG sites that qualify as appropriately corrected and the original uncorrected data for CpG sites highly clustered due to biological factors, where correction is inappropriate. Large EWAS studies can use the functions in Harman to find clustered CpG sites in their study. Smaller studies may wish to use the reference matrices we provide in the *[HarmanData](https://bioconductor.org/packages/3.22/HarmanData)* package.

### 4.2.2 Implications for EWAS

**For the probes erroneously corrected, the original uncorrected data should be used in any downstream linear regressions.** It could also be useful to use the clustering data identified above to determine which probes might benefit from logistic regression analysis, where the probes are regressed not on the M or β value, but their cluster membership. This approach might be particularly useful for identifying and analysing metastable epialleles.

### 4.2.3 Loading the reference matrix

A reference matrix of data from 5 datasets can be loaded from *[HarmanData](https://bioconductor.org/packages/3.22/HarmanData)*.

```
library(HarmanData)
data(Infinium5)
lvr.harman[1:2, ]
```

```
##             dataset
## probe_id     EpiSCOPE_var_ratio_harman EPIC-Italy_var_ratio_harman
##   cg00050873                    0.8106                      4.1019
##   cg00212031                    0.6578                      4.9756
##             dataset
## probe_id     BodyFatness_var_ratio_harman NOVI_var_ratio_harman
##   cg00050873                           NA                    NA
##   cg00212031                       4.2629                2.2947
##             dataset
## probe_id     URECA_var_ratio_harman
##   cg00050873                 1.7346
##   cg00212031                 2.1068
```

```
md.harman[1:2, ]
```

```
##             dataset
## probe_id     EpiSCOPE_meandiffs_harman EPIC-Italy_meandiffs_harman
##   cg00050873                    0.0224                      0.1108
##   cg00212031                    0.0078                      0.1488
##             dataset
## probe_id     BodyFatness_meandiffs_harman NOVI_meandiffs_harman
##   cg00050873                           NA                    NA
##   cg00212031                       0.0228                0.0524
##             dataset
## probe_id     URECA_meandiffs_harman
##   cg00050873                 0.0113
##   cg00212031                 0.0105
```

### 4.2.4 Discovering clusters *de novo* in large EWAS studies

To undertake this, there are a set of three functions in Harman designed to be run in series. Firstly, `discoverClusteredMethylation` takes a matrix of methylation beta values and clusters the data across a range of ks specified by the user. Then the data is reclustered again across the the best two candidate values for k (determined by the rate of change in Bayesian information criterion), and minimum cluster size and distance filters are employed. If both clusters meet these filters, then the higher value of k is returned. This function should be run on uncorrected data that ideally has slides removed which are prone to batch effect. This will bias towards finding clusters that are driven by biological factors such as X-chromosome inactivation and allele-specific methylation.

The output of the above is input for `kClusterMethylation`. This function extracts cluster membership and statistics on variance for a given β matrix. The full dataset should be specified for this step (not trimmed data where samples prone to batch effect are removed).

Finally, `clusterStats` provides a comparison of differences of uncorrected to batch-corrected β. This function generates a data.frame containing log variance ratio and mean beta differences to clusters after correction.

Let’s use the first 1000 rows on the toy data above to illustrate the workflow.

```
betas_sml <- getBeta(mSetSw)[1:1000, ]
betas_hm_sml <- betas_hm[1:1000, ]

myK <- discoverClusteredMethylation(betas_sml, min_cluster_size = 3, cores=2, printInfo = TRUE)
```

```
## First clustering, now find top two k, done. Reclustering, done.
```

```
mykClust = kClusterMethylation(betas_sml, row_ks=myK, cores=2)
res <- clusterStats(pre_betas=betas_sml,
                   post_betas=betas_hm_sml,
                   kClusters = mykClust)
res[1:2, ]
```

```
##              probe_id num_clusters pre_total_withinss post_total_withinss
## cg01707559 cg01707559            1         0.09832133          0.08248753
## cg02494853 cg02494853            1         0.11367056          0.10016174
##            pre_withinvar post_withinvar    pre_var   post_var log2_var_ratio
## cg01707559    0.01966427     0.01649751 0.01966427 0.01649751     -0.2533285
## cg02494853    0.02273411     0.02003235 0.02273411 0.02003235     -0.1825271
##             meandiffs
## cg01707559 0.02936431
## cg02494853 0.01206882
```

Here is a further canned example using 11 CpG sites from the EpiSCOPE cohort 450K data.

```
library(HarmanData)
data(episcope)
bad_batches <- c(1, 5, 9, 17, 25)
is_bad_sample <- episcope$pd$array_num %in% bad_batches
myK <- discoverClusteredMethylation(episcope$original[, !is_bad_sample])
mykClust <- kClusterMethylation(episcope$original, row_ks=myK)
res <- clusterStats(pre_betas=episcope$original,
                   post_betas=episcope$harman,
                   kClusters = mykClust)
res[1:2, ]
```

```
##              probe_id num_clusters pre_total_withinss post_total_withinss
## cg25465065 cg25465065            3          0.1269350            4.146770
## cg15544633 cg15544633            2          0.1518356            1.368199
##            pre_withinvar post_withinvar    pre_var   post_var log2_var_ratio
## cg25465065  0.0003449321    0.011268396 0.10677715 0.10658313       5.029826
## cg15544633  0.0004125968    0.003717933 0.03973108 0.03696931       3.171696
##             meandiffs
## cg25465065 0.07530548
## cg15544633 0.03935657
```

This set of 11 CpG sites illustrates examples of appropriate (cg04294190) and inappropriate (cg25465065) correction.

```
slide_cols <- rep(brewer.pal(9, "Set1"), times=5)[as.factor(episcope$pd$array_num)]
myplot <- function(probe) {
  plot(episcope$original[probe, ],
       main=paste(probe, ". Pre-var: ", round(res[probe, "pre_withinvar"], 5), sep=""),
       xlab="", ylab="Beta", cex=0.7, cex.main=0.9, ylim=c(0, 1), col=slide_cols)
  plot(episcope$harman[probe, ],
       main=paste(probe, ". Post-var: ", round(res[probe, "post_withinvar"], 5), ", LVR: ", round(res[probe, "log2_var_ratio"], 2), sep=""),
       xlab="", ylab="Beta", cex=0.7, cex.main=0.9, ylim=c(0, 1), col=slide_cols)
}
par(mfrow=c(2,2))
myplot("cg04294190")
myplot("cg25465065")
```

![](data:image/png;base64...)

For each feature, the number of clusters are determined empirically. In the above example, cg04294190 was identified as having 1 cluster as the slides prone to batch effect (1, 5, 9, 17, 25) were removed in the initial cluster identification step. One-dimensional K-means clustering analysis yielded 3 clusters for cg25465065. Next, the within-cluster sum of squares is computed for each cluster and summed as the total within-cluster sum of squares. This is computed before batch correction (pre) and after (post). To determine if the batch effection correction algorithm is appropriately correcting a given feature, `log2_var_ratio` (LVR) is the critical statistic. This is computed as `log2(post_withinvar / pre_withinvar)`. An LVR below 0 suggests the adjustment for that feature was appropriate, whereas an LVR above 0 indicates that cluster-aware variance is being magnified post-correction, so applying batch-effect correction to this probe is likely to be inappropriate.

### 4.2.5 Thresholding

In practice, when applying the LVR statistic to identify batch-effect susceptible probes, fully methylated or unmethylated CpG sites often have very small corrections made to them by Harman, but given the initial small variance, result in large changes in LVR. To focus on probes with a large change in LVR and an appreciable difference to β after correction we suggest the use of thresholding.

To classify as ‘erroneously corrected’ or ‘batch-effect susceptible’ we suggest as a rule of thumb to use a cut-off of 50% variance increase (log2(1.5), LVR = 0.584) or decrease (log2(1/1.5), LVR = -0.584) and mean differences after correction of at least β >= |0.01|. These absolute value mean differences are given in the `meandiffs` column in the output of `clusterStats`.

#### 4.2.5.1 On *de novo* clustered data

This is illustrated is below.

```
# Erroneously corrected
res$probe_id[res$log2_var_ratio > log2(1.5) & res$meandiffs > 0.01]
```

```
## [1] "cg25465065" "cg15544633" "cg15410402"
```

```
# Batch-effect susceptible
res$probe_id[res$log2_var_ratio < log2(1/1.5) & res$meandiffs > 0.01]
```

```
## [1] "cg01381374" "cg27298252" "cg04294190" "cg11963436" "cg18368637"
```

#### 4.2.5.2 Using a reference

The reference matrix can also be used to threshold. In the below example, we find all the probes in the MethylationEPIC reference datasets (BodyFatness, NOVI, URECA) which consistently seem batch-effect susceptible. Batch effects are fairly idiosyncratic to each project, so in this case we are hunting for probes which often seem troublesome across projects. To find erroneously corrected probes we are thresholding on 1 or more datasets. This accounts for rare SNPs which may only appear in high enough frequency to identify a cluster in a subset of projects.

```
is_epic <- grepl("BodyFatness|NOVI|URECA", colnames(lvr.harman))
epic_lvr <- na.omit(lvr.harman[, is_epic])
epic_md <- na.omit(md.harman[, is_epic])

sum_batchy_lvr <- apply(epic_lvr, 1, function(p) sum(p < log2(1/1.5)))
sum_geno_lvr <- apply(epic_lvr, 1, function(p) sum(p > log2(1.5)))
sum_md <- apply(epic_md, 1, function(p) sum(p > 0.01))

table(sum_batchy_lvr & sum_md)
```

```
##
##  FALSE   TRUE
## 576259 289600
```

```
table(sum_geno_lvr & sum_md)
```

```
##
##  FALSE   TRUE
## 845129  20730
```

Using these thresholds, there were 289600 probes consistently prone to some batch effect over the three MethylationEPIC datasets and 20730 probes with a substantial erroneous changes post-correction, likely due to allele-specific methylation or a similar phenomenon.

## 4.3 Limma analysis

In downstream differential methylation analysis using *[limma](https://bioconductor.org/packages/3.22/limma)* or otherwise, care must be taken to interpret the results. As Harman was run with the expt variable set to status, any other variation unrelated to status which is unbalanced across the two slides is considered as batch noise. For example, we have already shown that sex is a highly influential factor and it is unbalanced across the slides; only person of id3 is male and both the normal and cancer samples are on slide 5723646052. **Therefore, we expect Harman to attribute this gender effect to a slide effect.**

In the specification of a linear model of `model.matrix(~id + group)`, we should then expect to find no differential methylation in person id3, the male. Let’s try this:

```
library(limma)

group <- factor(pData(mSetSw)$status, levels=c("normal", "cancer"))
id <- factor(pData(mSetSw)$person)
design <- model.matrix(~id + group)
design
```

```
##   (Intercept) idid2 idid3 groupcancer
## 1           1     0     1           0
## 2           1     1     0           0
## 3           1     0     1           1
## 4           1     0     0           1
## 5           1     0     0           0
## 6           1     1     0           1
## attr(,"assign")
## [1] 0 1 1 2
## attr(,"contrasts")
## attr(,"contrasts")$id
## [1] "contr.treatment"
##
## attr(,"contrasts")$group
## [1] "contr.treatment"
```

Now time to fit this design to both the original M-values and the Harman corrected M-values.

```
fit_hm <- lmFit(ms_hm, design)
fit_hm <- eBayes(fit_hm)

fit <- lmFit(getM(mSetSw), design)
fit <- eBayes(fit)
```

Our intuition is correct. Harman has indeed squashed the variation in person id3, there are now no differentially methylated probes.

```
summary_fit_hm <- summary(decideTests(fit_hm))
summary_fit <- summary(decideTests(fit))
summary_fit_hm
```

```
##        (Intercept)  idid2  idid3 groupcancer
## Down        165075      0      0       19429
## NotSig       75167 466668 466668      434234
## Up          226426      0      0       13005
```

```
summary_fit
```

```
##        (Intercept)  idid2  idid3 groupcancer
## Down        162815      0   2641       13145
## NotSig       79504 466668 463855      443281
## Up          224349      0    172       10242
```

We also note, our ability to detect cancer-related differential methylation has been enhanced. There are now 6284 more hypermethylated CpG probes and 2763 more hypomethylated CpG probes.

# 5 Mass Spectrophotometry data example

## 5.1 Example dataset

We use the data available in the *[msmsEDA](https://bioconductor.org/packages/3.22/msmsEDA)* library which has 14 samples across two treatments and two batches.

### 5.1.1 Loading the mass-spec data

```
# Call dependencies
library(msmsEDA)
library(Harman)

data(msms.dataset)
msms.dataset
```

```
## MSnSet (storageMode: lockedEnvironment)
## assayData: 697 features, 14 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: U2.2502.1 U2.2502.2 ... U6.0302.3 (14 total)
##   varLabels: treat batch
##   varMetadata: labelDescription
## featureData: none
## experimentData: use 'experimentData(object)'
##   pubMedIds: http://www.ncbi.nlm.nih.gov/pubmed/22588121
## Annotation:
## - - - Processing information - - -
##  MSnbase version: 1.8.0
```

### 5.1.2 Preprocessing

The data matrix in an MSnSet object from package *[msmsEDA](https://bioconductor.org/packages/3.22/msmsEDA)* may have all zero rows (if it’s a subset of a larger object) and some samples may have NA values, which correspond to proteins not identified in that particular sample. Principle components analysis cannot be undertaken on matrices with such features. So first we can use the wrapper function `pp.msms.data()`, which removes all zero rows and replaces NA with 0.

```
# Preprocess to remove rows which are all 0 and replace NA values with 0.
msms_pp <- pp.msms.data(msms.dataset)
```

### 5.1.3 Batch structure

|  | treat | batch |
| --- | --- | --- |
| U2.2502.1 | U200 | 2502 |
| U2.2502.2 | U200 | 2502 |
| U2.2502.3 | U200 | 2502 |
| U2.2502.4 | U200 | 2502 |
| U6.2502.1 | U600 | 2502 |
| U6.2502.2 | U600 | 2502 |
| U6.2502.3 | U600 | 2502 |
| U6.2502.4 | U600 | 2502 |
| U2.0302.1 | U200 | 0302 |
| U2.0302.2 | U200 | 0302 |
| U2.0302.3 | U200 | 0302 |
| U6.0302.1 | U600 | 0302 |
| U6.0302.2 | U600 | 0302 |
| U6.0302.3 | U600 | 0302 |

```
# Create experimental and batch variables
expt <- pData(msms_pp)$treat
batch <- pData(msms_pp)$batch
table(expt, batch)
```

```
##       batch
## expt   0302 2502
##   U200    3    4
##   U600    3    4
```

### 5.1.4 Running Harman

```
# Log2 transform data, add 1 to avoid infinite values
log_ms_exprs <- log(exprs(msms_pp) + 1, 2)

# Correct data with Harman
hm <- harman(log_ms_exprs, expt=expt, batch=batch)
summary(hm)
```

```
## Total factor levels:
##
##  expt batch
##     2     2
##
## Experiment x Batch Design:
##
##       batch
## expt   0302 2502
##   U200    3    4
##   U600    3    4
##
## Simulation parameters:
## 100000 simulations (with seed of 924863060). ForceRand is FALSE.
##
## Harman results with confidence limit of 0.95:
##  PC1  PC2  PC3  PC4  PC5  PC6  PC7  PC8  PC9 PC10 PC11 PC12 PC13 PC14
## 0.06 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 0.56
##
## Top batch-effected PCs:
##  PC1 PC14
## 0.06 0.56
```

The Harman result is interesting. This MS data seems to have the batch effect contained within the 1st and 14th PCs only. A marked difference compared to transcriptome microarray data and the like.

A plot rather convincingly shows that Harman was able to remove the batch effect.

```
plot(hm)
```

![](data:image/png;base64...)

### 5.1.5 Reconstruct the corrected data

As usual we now reconstruct corrected data, but we add an extra transformation step on the end. As the data was Log2 transformed we convert it back to the original format (and subtract 1 as this was added before during the transformation into Log2 space). The corrected and transformed back data is placed into a new ‘MSnSet’ instance.

```
# Reconstruct data and convert from Log2, removing 1 as we added it before.
log_ms_exprs_hm <- reconstructData(hm)
ms_exprs_hm <- 2^log_ms_exprs_hm - 1

# Place corrected data into a new 'MSnSet' instance
msms_pp_hm <- msms_pp
exprs(msms_pp_hm) <- ms_exprs_hm
```

# 6 Comparison to ComBat

ComBat, available in the *[sva](https://bioconductor.org/packages/3.22/sva)* package, adjusts for known batches using an empirical Bayesian framework. This involves mean and variance shrinkage on a feature by feature basis using the Bayesian model to estimate the shrinkage parameters. To allow some robustness in estimates when the number of samples is low, the model pools information across genes.

Harman uses a dimensionality reduction approach with a confidence constraint set by the user. In this case, the features by samples matrix is decomposed into principal components. Unlike ComBat, batch adjustments are not on a feature by feature basis but on a principal component by principal component basis. Each orthogonal component is examined for evidence of a batch effect and if one is found, the batch means are moved step-wise towards zero in principal component space until the confidence limit for no evidence of a batch effect is met. Finally the adjusted PC scores are transformed back into raw data space.

Fundamentally, Harman shifts feature values in a coordinated way across a batch one prinicipal component at a time, whereas ComBat shifts feature values one feature at a time by an amount informed by the batch structure and overall mean and variance of the data.

To compare the techniques, we will apply the methods to a dataset and plot the difference between the original data matrix and after correction.

### 6.0.1 IMR90 example data

For this comparison we use the IMR90 data from the transcriptomics example earlier. This is the dataset used in the original ComBat paper by Johnson et al doi: 10.1093/biostatistics/kxj037

This data has 4 treatments and 3 batches.

```
table(imr90.info)
```

```
##          Batch
## Treatment 1 2 3
##         1 1 1 1
##         2 1 1 1
##         3 1 1 1
##         4 1 1 1
```

### 6.0.2 Applying Harman and ComBat to adjust for known batches

In accordance with the [advice](https://support.bioconductor.org/p/62874/) of Jeff Leek, for ComBat we do not include the variable of interest in specification of the model matrix.

```
library(HarmanData)
library(sva)

modcombat <- model.matrix(~1, data=imr90.info)
imr90.data.cb <- ComBat(dat=as.matrix(imr90.data), batch=imr90.info$Batch, mod=modcombat,
                        par.prior=TRUE, prior.plots=FALSE)
```

```
## Found 7 genes with uniform expression within a single batch (all zeros); these will not be adjusted for batch.
```

```
imr90.hr <- harman(imr90.data, expt = imr90.info$Treatment, batch = imr90.info$Batch)
imr90.data.hr <- reconstructData(imr90.hr)

prcompPlot(imr90.data, pc_x = 1, pc_y = 3,
           colFactor = imr90.info$Batch,
           pchFactor = imr90.info$Treatment,
           main='PC1 versus PC3')
```

![](data:image/png;base64...)

```
arrowPlot(imr90.hr, pc_x = 1, pc_y = 3, main='PC1 versus PC3')
```

![](data:image/png;base64...)

### 6.0.3 Compare

Plotting the differences between matrix values as a type of heatmap. The features of the microarray (rows) are ordered by the degree of correction in Harman.

```
library(RColorBrewer)

diffMap <- function(a, b, feature_order=1:nrow(a), batch, ...) {

  image(t(abs(a[feature_order, ] - b[feature_order, ])),
      col = brewer.pal(9, "Greys"),
      xaxt='n',
      yaxt='n',
      xlab='Batch',
      ylab='Ordered feature',
      ...)
  axis(1, at=seq(0, 1, length.out=length(batch)), labels=batch)
}
```

```
probe_diffs_hr <- order(rowSums(abs(as.matrix(imr90.data - imr90.data.hr))))
probe_diffs_cb <- order(rowSums(abs(as.matrix(imr90.data - imr90.data.cb))))

diffMap(a=imr90.data, b=imr90.data.hr, feature_order=probe_diffs_hr,
        batch=imr90.info$Batch, main='Original - Harman')
```

![](data:image/png;base64...)

```
diffMap(a=imr90.data, b=imr90.data.cb, feature_order=probe_diffs_hr,
        batch=imr90.info$Batch, main='Original - ComBat')
```

![](data:image/png;base64...)

```
diffMap(a=imr90.data.hr, b=imr90.data.cb, feature_order=probe_diffs_hr,
        batch=imr90.info$Batch, main='Harman - ComBat')
```

![](data:image/png;base64...)

### 6.0.4 Concluding remarks

The feature by feature and sample by sample nature of ComBat is evident. In particular, the outlying sample in batch 3 has been subjected to quite extensive feature adjustment.

Harman adjusts the values of features within batches in a coordinated way. In is particular example, Harman identifies across batches a highly coordinate set of features which need correction.

Despite their differences, the Harman and Combat approaches have large overlaps in the features they identify as needing correction and the amount of feature adjustment required.