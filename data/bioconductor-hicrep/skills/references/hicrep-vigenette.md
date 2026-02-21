# Evaluate reproducibility of Hi-C data with `hicrep`

#### *Tao Yang xadmyangt@gmail.com*

#### *3/1/2017*

## Introduction

Hi-C data analysis and interpretation are still in their early stages. In particular, there has been a lack of sound statistical metric to evaluate the quality of Hi-C data. When biological replicates are not available, investigators often rely on eithervisual inspection of Hi-C interaction heatmap or examining the ratio of long-range interaction read pairs over the total sequenced reads, neither of which are supported by robust statistics. When two or more biological replicates are available, it is a common practice to compute either Pearson or Spearman correlation coefficients between the two Hi-C data matrices and use them as a metric for quality control. However, these kind of over-simplified approaches are problematic and may lead to wrong conclusions, because they do not take into consideration of the unique characteristics of Hi-C data, such as distance-dependence and domain structures. As a result, two un-related biological samples can have a strong Pearson correlation coefficient, while two visually similar replicates can have poor Spearman correlation coefficient. It is also not uncommon to observe higher Pearson and Spearman correlations between unrelated samples than those between real biological replicates.

we develop a novel framework, `hicrep`, for assessing the reproducibility of Hi-C data. It first minimizes the effect of noise and biases by smoothing Hi-C matrix, and then addresses the distance-dependence effect by stratifying Hi-C data according to their genomic distance. We further adopt a stratum-adjusted correlation coefficient (SCC) as the measurement of Hi-C data reproducibility. The value of SCC ranges from -1 to 1, and it can be used to compare the degrees of differences in reproducibility. Our framework can also infer confidence intervals for SCC, and further estimate the statistical significance of the difference in reproducibility measurement for different data sets.

In this Vignette, we explain the method rationale, and provide guidance to use the functions of `hicrep` to assess the reproducibility for Hi-C intrachromosome replicates.

## Citation

Cite the following paper:

HiCRep: assessing the reproducibility of Hi-C data using a stratum-adjusted correlation coefficient. Tao Yang, Feipeng Zhang, Galip Gurkan Yardimci, Ross C Hardison, William Stafford Noble, Feng Yue, Qunhua Li. bioRxiv 101386; doi: <https://doi.org/10.1101/101386>

## Installation

Download the source package `hicrep_0.99.5.tar.gz` from Github. Or install it from Bioconductor.

## Rationale of method

This is a 2-step method (Figure1). In Hi-C data it is often difficult to achieve sufficient coverage. When samples are not sufficiently sequenced, the local variation introduced by under-sampling can make it difficult to capture large domain structures. To reduce local variation, we first smooth the contact map before assessing reproducibility. Although a smoothing filter will reduce the individual spatial resolution, it can improve the contiguity of the regions with elevated interaction, consequently enhancing the domain structures. We use a 2D moving window average filter to smooth the Hi-C contact map. This choice is made for the simplicity and fast computation of mean filter, and the rectangular shape of Hi-C compartments.

In the second step, we stratify the Hi-C reads by the distance of contacting loci, calculate the Pearson correlations within each stratum, and then summarize the stratum-specific correlation coefficients into an aggregated statistic. We name it as Stratum-adjusted Correlation Coefficient (SCC). For the methodology details, please refer to our manuscript.

[Figure1. `hicrep` pipeline schematic representation] (<https://raw.githubusercontent.com/MonkeyLB/hicrep/master/vignettes/hicrep-pipeline.JPG>)

## The format of input and Pre-processing

The input are simply two Hi-C matrices to be compared. The Hi-C matrices should have the dimension \(N\times(3+N)\). The three additional initial columns are the chromosome name and mid-point coordinates of the two contact bins. Here, we should a example data:

```
dim(HiCR1)
```

```
## [1] 52 55
```

```
HiCR1[1:10,1:10]
```

```
##       V1      V2       V3 V4 V5 V6 V7 V8 V9 V10
## 1  chr22       0  1000000  0  0  0  0  0  0   0
## 2  chr22 1000000  2000000  0  0  0  0  0  0   0
## 3  chr22 2000000  3000000  0  0  0  0  0  0   0
## 4  chr22 3000000  4000000  0  0  0  0  0  0   0
## 5  chr22 4000000  5000000  0  0  0  0  0  0   0
## 6  chr22 5000000  6000000  0  0  0  0  0  0   0
## 7  chr22 6000000  7000000  0  0  0  0  0  0   0
## 8  chr22 7000000  8000000  0  0  0  0  0  0   0
## 9  chr22 8000000  9000000  0  0  0  0  0  0   0
## 10 chr22 9000000 10000000  0  0  0  0  0  0   0
```

A single function `prep` will tranform the HiC matrix, smooth the data with given neighborhood size parameter \(h\), and filter the bins that have zero counts in both replicates. The arguments includes the two matrices, the resolution of matrices, smoothing parameter, and the maximum distance considered. The resolution is simply the bin size. Smoothing parameter decides the neighborhood size of smoothing. Below (Figure 2) is a demonstration of smoothing neighborhood for a point \(C\_{ij}\):

[Figure2. A smoothing neighborhood with \(h = 2\)] (<https://raw.githubusercontent.com/MonkeyLB/hicrep/master/vignettes/Smoothing_neighborhood.JPG>)

The maximum distance is that contacts beyond this distance will be under investigation. Here we are showing an example that has resolution 40kb, smoothing parameter \(h = 1\), and contacts with distance over 5M will not be considered:

```
Pre_HiC <- prep(HiCR1, HiCR2, 1000000, 1, 5000000)
head(Pre_HiC)
```

```
##           V1       V2        V3        V4
## 796 15500000 15500000 314.66667 515.11111
## 797 15500000 16500000 539.88889 871.11111
## 798 15500000 17500000 579.66667 927.11111
## 799 15500000 18500000 283.00000 439.44444
## 800 15500000 19500000  65.33333  95.55556
## 801 15500000 20500000  32.88889  53.88889
```

The first two columns of the output are the mid-point coordinates of two contact bins, and the last two are the smoothed (or not if \(h = 0\)) values of the two replicates.

## Select the optimal smoothing parameter

A natrual question is how to select the smoothing parameter \(h\).To select \(h\) objectively, we develop a heuristic procedure to search for the optimal smoothing parameter. Our procedure is designed based on the observation that the correlation between contact maps of replicate samples first increases with the level of smoothness and plateaus when sufficient smoothness is reached. To proceed, we use a pair of reasonably deeply sequenced interaction map as the training data. We randomly partition the data into ten fractions 10% of the data, then compute SCC for the sampled dataeach fraction at a series of smoothing parameters in the ascending order, then choose the smallest h at which the increment of the average reproducibility score is less than 0.01. This procedure is repeated ten times, and the mode among the ten h’s is picked.

```
h_hat <- htrain(HiCR1, HiCR2, 1000000, 5000000, 0:2)
```

```
## smoothing:0
```

```
## smoothing:1
```

```
h_hat
```

```
## [1] 0
```

[Figure3. Select the optimal smoothing parameter \(h\)] (<https://raw.githubusercontent.com/MonkeyLB/hicrep/master/vignettes/Smoothing_parameter.JPG>)

The above graph shows the change of SCC as the \(h\) increases from 0 to 10. The parameter \(h=5\) is selected as the optimal smoothing neighborhood size.

The smoothing parameter selection could be confounded by the sequencing depth. Insufficient sequencing depth data might lead to inflated smoothing neighborhood size. We suggest to use sufficient sequenced Hi-C data to train the smoothing parameter given the resolution (i.e., > 300 million total nubmer of reads for whole chromosome). To compare SCC between pairs of replicates that has the same resolution, one shall use the same smoothing parameter.

## Equalize the total number of reads

In previous section, we mention that sequencing depth could be a confounding effect. If the total numbers of reads are very different between the two replicates, it’s suggested that one should down-sample the higher sequencing depth to make it equal the lower one. The best way to do it is to use the bam files to do the sub-sampling. In case you only have the matrix file available, we made a function to do down-sampling from matrix files.

```
#check total number of reads before adjustment
sum(HiCR1[,-c(1:3)])
```

```
## [1] 2065436
```

```
DS_HiCR1 <- depth.adj(HiCR1, 200000, 1000000, out = 0)

#check total number of reads after adjustment
sum(DS_HiCR1[,-c(1:3)])
```

```
## [1] 2e+05
```

When out = 0, the function will return matrix in the original format. When it equals 1, the vectorized format will be outputed.

## Calculate Stratum-adjusted Correlation Coefficient (SCC)

After the raw matrices are pre-processed, we are ready to calculate the SCC and its variance. The input file is just the output dataset (i.e., vectorized, smoothed, zero-in-both filtered) from the function `prep`. We also need to specify the resolution of the matrix, and the maximum contacting distance considered.

```
SCC.out = get.scc(Pre_HiC, 1000000, 5000000)

#SCC score
SCC.out[[3]]
```

```
##           [,1]
## [1,] 0.9822897
```

```
#Standard deviation of SCC
SCC.out[[4]]
```

```
## [1] 0.004437169
```

```
sessionInfo()
```

```
## R version 3.4.0 (2017-04-21)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.2 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] hicrep_1.0.0
##
## loaded via a namespace (and not attached):
##  [1] compiler_3.4.0  backports_1.0.5 magrittr_1.5    rprojroot_1.2
##  [5] htmltools_0.3.5 tools_3.4.0     yaml_2.1.14     Rcpp_0.12.10
##  [9] stringi_1.1.5   rmarkdown_1.4   knitr_1.15.1    stringr_1.2.0
## [13] digest_0.6.12   evaluate_0.10
```

The output is a list of results including stratum specific Pearson correlations, weight coefficient, SCC and the asymptotic standard deviation of SCC. The last two numbers are the ones we needed in most of the situations.

## Computation efficiency

The computation speed is determined by the size of the chromosome. For the chromosome 22 data, `htrain` needs approximately 15 minutes, and the `get.scc` takes about 1~2 minutes. For chromosome 1, `get.scc` takes about 90 minutes. the The estimation is based on Intel i7-3250M core.