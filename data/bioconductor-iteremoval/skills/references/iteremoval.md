# iteremoval

The package provides a flexible algorithm to iteratively screen features in consideration of overfitting and overall performance. Two distinct groups of observations are required. It is originally tailored for methylation locus screening of NGS data, and it can also be used as a generic method for feature selection. Each step of the algorithm provides a default function for simple implemention, and it is able to be replaced by a user defined method.

## Install

To install this package, start R and enter:

```
# try http:// if https:// URLs are not supported
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("iteremoval")
```

## An example

We identified 299 genomic regions related to the methylation status of a disease. Then, we sequenced the cfDNA of 44 subjects. 22 were malignant, while others were normal. We built a statistical model to compute the probability of the disease for each region and subject. Thus, we use the probability data to demonstrate how the package works.

The input files are in either format:

1. Two datasets, `SWRG1`(malignant individuals) and `SWRG0`(normal individuals). Each row of the two datasets indicates a genomic region, and the columns are the probabilities.
2. A `SummarizedExperiment::`SummarizedExperiment object (`SummarizedData`) and a logical vector (`SummarizedData$Group==0`) to distinguish normal samples from all samples. Note: Name 'Group' is not required.

We expect that higher the value means higher the probability of having a disease. However, we discover that not all genes are related to the disease. Therefore, we use the package `iteremoval` to select the gene locus with high probability in malignant samples and low probability in normal samples.

`iteremoval` is oriented to find a dataset to classify two different groups, and the feature that removed in each iteration is comprehensively considered according to all observations. If the observations have subtypes, the process might generate a feature set favoring all subtypes with the default settings. You can also define the function that each step uses to meet your requirement.

### Removing features

```
library(iteremoval)
```

```
## Loading required package: ggplot2
```

```
# input two datasets
removal.stat <- feature_removal(SWRG1, SWRG0, cutoff1=0.95, cutoff0=0.95,
                                 offset=c(0.25, 0.5, 2, 4))
```

```
## Current offset: 0.25
## Current offset: 0.5
## Current offset: 2
## Current offset: 4
```

```
# input SummarizedExperiment object
removal.stat <- feature_removal(SummarizedData, SummarizedData$Group==0,
                                 cutoff1=0.95, cutoff0=0.95,
                                 offset=c(0.25, 0.5, 2, 4))
```

```
## Current offset: 0.25
## Current offset: 0.5
## Current offset: 2
## Current offset: 4
```

It is the core function of the package. The first four parameters are required. A vector of `offset` means doing the whole computational process with different offsets *respectively*, and you can also define only one numeric number to `offset`. To get a overall information of features, the iteration will not stop until there is no feature to remove.

* You can also lower `cutoff0` and higher `cutoff1` to reduce overfitting. Why? You can type `?feature_removal` to see the whole algorithm.

### Ploting the iteration trace of removed features' scores

It is useful to visulize how each feature is removed in the iterative process. The package provides a way to plot the scores of features being removed in each iteration.

```
ggiteration_trace(removal.stat) + theme_bw()
```

```
## Warning: Removed 6 rows containing missing values (geom_path).
```

![plot of chunk unnamed-chunk-4](data:image/png;base64...)

`ggiteration_trace` returns a ggplot2 object, so `+` is used in the same way as `ggplot2` package.

X-axis is the iteration index, and Y-axis is the score of the feature being removed, and the legend is the offset you passed to `feature_removal`. Normally, you can stop removing features from the index of which the scores fluctuate drastically.

### Generating the feature list

Once you confirm the cutoff of iteration index, you can generate the feature list. Since using a vector of `offset` and the features are removed with different `cutoff` seperately, the remaining feature lists are not unique for multiple cutoffs. Thus, we compute the feature prevalence for the feature lists, using:

```
features <- feature_prevalence(removal.stat, index=255, hist.plot=TRUE)
```

![plot of chunk unnamed-chunk-5](data:image/png;base64...)

```
features
```

```
##
## Feature151 Feature155 Feature161 Feature170 Feature176 Feature242
##          1          1          1          1          1          1
## Feature257 Feature263 Feature264 Feature104 Feature109 Feature128
##          1          1          1          2          2          2
##  Feature14 Feature146 Feature148 Feature156 Feature163 Feature178
##          2          2          2          2          2          2
## Feature198   Feature2 Feature211 Feature220 Feature225 Feature229
##          2          2          2          2          2          2
## Feature259 Feature260  Feature27  Feature28  Feature48  Feature49
##          2          2          2          2          2          2
##   Feature5  Feature56  Feature61  Feature62   Feature9  Feature94
##          2          2          2          2          2          2
## Feature160 Feature212  Feature23 Feature230 Feature232  Feature57
##          3          3          3          3          3          3
##  Feature58 Feature102  Feature12  Feature13 Feature147 Feature152
##          3          4          4          4          4          4
## Feature159 Feature171 Feature186 Feature187 Feature188 Feature190
##          4          4          4          4          4          4
## Feature191 Feature192 Feature224 Feature252 Feature289  Feature29
##          4          4          4          4          4          4
##  Feature30  Feature32  Feature39  Feature59   Feature6  Feature85
##          4          4          4          4          4          4
##  Feature93
##          4
```

### Screening the features with prevalence

At last, you can see the prevalence histogram of the features because of multiple offsets. You can specify a cutoff for the prevalence, and output the final feature list.

```
feature_screen(features, prevalence=4)
```

```
##  [1] "Feature102" "Feature12"  "Feature13"  "Feature147" "Feature152"
##  [6] "Feature159" "Feature171" "Feature186" "Feature187" "Feature188"
## [11] "Feature190" "Feature191" "Feature192" "Feature224" "Feature252"
## [16] "Feature289" "Feature29"  "Feature30"  "Feature32"  "Feature39"
## [21] "Feature59"  "Feature6"   "Feature85"  "Feature93"
```