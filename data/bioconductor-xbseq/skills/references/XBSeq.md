# Differential expression and apa usage analysis of count data using XBSeq package

#### *Yuanhang Liu*

#### *2017-04-24*

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Use XBSeq for testing differential expression](#use-xbseq-for-testing-differential-expression)
  + [3.1 featureCounts](#featurecounts)
  + [3.2 HTSeq procedure](#htseq-procedure)
  + [3.3 summarizeOverlaps](#summarizeoverlaps)
  + [3.4 Testing differential APA usage](#testing-differential-apa-usage)
  + [3.5 XBSeq testing for DE](#xbseq-testing-for-de)
  + [3.6 Compare the results with DESeq](#compare-the-results-with-deseq)
* [4 Details](#details)
  + [4.1 Construction of gtf file for background region](#construction-of-gtf-file-for-background-region)
  + [4.2 Construction of gtf file for APA annotation used by roar package](#construction-of-gtf-file-for-apa-annotation-used-by-roar-package)
  + [4.3 Regarding intron retention](#regarding-intron-retention)
* [5 Latest updates of XBSeq: XBSeq2](#latest-updates-of-xbseq-xbseq2)
* [6 Bug reports](#bug-reports)
* [7 Session information](#session-information)
* [8 Acknowledgements](#acknowledgements)
* [9 References](#references)

# 1 Introduction

XBSeq is a novel algorithm for testing RNA-seq differential expression (DE), where a statistical model was established based on the assumption that observed signals are the convolution of true expression signals and sequencing noises. The mapped reads in non-exonic regions are considered as sequencing noises, which follows a Poisson distribution. Given measurable observed signal and background noise from RNA-seq data, true expression signals, assuming governed by the negative binomial distribution, can be delineated and thus the accurate detection of differential expressed genes. XBSeq paper is published in BMC genomics [1]. We recently also incorporated functionality of roar package for testing differential alternative polyadenylation (apa) usage.

# 2 Installation

XBSeq can be installed from Bioconductor by

```
source('http://www.bioconductor.org/biocLite.R')
biocLite("XBSeq")
```

```
library("XBSeq")
```

You can also install development version of XBSeq by

```
library(devtools)
install_github('liuy12/XBSeq')
```

# 3 Use XBSeq for testing differential expression

In order to use XBSeq for testing DE, after sequence alignment, we need to carry out read-counting procedure twice to measure the reads mapped to exonic regions (observed signal) and non-exonic regions (background noise). There are several existing methods for this purpose. Here we introduce read counting using featureCounts, HTSeq and summarizeOverlaps

## 3.1 featureCounts

featureCounts is a read summarization program that can be used for reads generated from RNA or DNA sequencing technologies and it implements highly efficient chromosome hashing and feature blocking techniques which is considerably fast in speed and require less computer memory. featureCounts is available from Rsubread package within R. Basically, you will need to run the following commands:

```
fc_signal <- featureCounts(files = bamLists, annot.ext = gtf_file, isGTFAnnotationFile = TRUE)
fc_bg <- featureCounts(files = bamLists, annot.ext = gtf_file_bg, isGTFAnnotationFile = TRUE)
```

The gtf file used to measure observed signal and background noise can be downloaded in the gtf folder from github: <https://github.com/Liuy12/XBSeq_files>. We have already constructed annotations for several organism of various genome builds. If you would like to construct the gtf file by yourself, we also have deposited the perl script we used to construct the gtf file in github. Details regarding the procedure we used to construct the background gtf file can be found in the Details section in the vignette.

## 3.2 HTSeq procedure

Alternatively, you can also use HTSeq for read-counting purpose:

```
htseq-count [options] <alignment_file> <gtf_file> > Observed_count.txt
htseq-count [options] <alignment_file> <gtf_file_bg> > background_count.txt
```

Details regarding how HTSeq works can be found here: <http://www-huber.embl.de/HTSeq/doc/count.html>

## 3.3 summarizeOverlaps

You can also use `summarizeOverlaps` function which is available from GenomicRanges package:

```
features_signal <- import(gtf_file)
features_signal <- split(features_signal, mcols(features_signal)$gene_id)
so_signal <- summarizeOverlaps(features_signal, bamLists)

## for background noise
features_bg <- import(gtf_file_bg)
features_bg <- split(features_bg, mcols(features_bg)$gene_id)
so_bg <- summarizeOverlaps(features_bg, bamLists)
```

## 3.4 Testing differential APA usage

Alternative polyadenylation (APA) is a widespread mechanism, where alternative poly(A) sites are used by a gene to encode multiple mRNA transcripts of different 3’UTR lengths. User can infer differential APA usage directly form RNA-seq alignment files:

```
apaStats <- apaUsage(bamTreatment, bamControl, apaAnno)
```

Where `bamTreatment` is a list of full path of filenames of bam alignments with data for the treatment condition and `bamControl` is a list of full path of filenames of bam alignments with data for the control condition to be considered. `apaAnno` is full path of apa annotation used by roar package. APA annotation for several organisms of various genome build can be downloaded from [here](https://github.com/Liuy12/XBSeq_files). For details regarding how to construct APA annotation, please refer to Details section is the vignette.

## 3.5 XBSeq testing for DE

After HTSeq procedure, then we will have two measurements for each gene, the observed signal and background noise. Here we will use a mouse RNA-seq dataset, which contains 3 replicates of wild type mouse liver tissues (WT) and 3 replicates of Myc transgenic mouse liver tissues (MYC). The dataset is obtained from Gene Expression Omnibus [(GSE61875)](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE61875).

As a preliminary step, we have already carried out HTSeq procedure mentioned above to generate observed signal and background noise for each gene. The two datasets can be loaded into user’s working space by

```
data(ExampleData)
```

We can first take a look at the two datasets:

```
head(Observed)
```

```
##               Sample_54_WT Sample_72_WT Sample_93_WT Sample_31_MYC
## 0610005C13Rik         3683         2956         3237          2985
## 0610007C21Rik         2136         1675         1519          1782
## 0610007L01Rik         2826         3584         1712          2694
## 0610007P08Rik          717          616          529           737
## 0610007P14Rik         3138         2145         2145          1995
## 0610007P22Rik          298          254          194           211
##               Sample_75_MYC Sample_87_MYC
## 0610005C13Rik          4043          4437
## 0610007C21Rik          2265          2214
## 0610007L01Rik          3133          3552
## 0610007P08Rik           864           923
## 0610007P14Rik          2871          2945
## 0610007P22Rik           272           333
```

```
head(Background)
```

```
##               Sample_54_WT Sample_72_WT Sample_93_WT Sample_31_MYC
## 0610005C13Rik          512          374          466           496
## 0610007C21Rik           50           44           40            42
## 0610007L01Rik           33           22           35            39
## 0610007P08Rik           14           14           28            20
## 0610007P14Rik           21           17           22            10
## 0610007P22Rik           16           19           26            14
##               Sample_75_MYC Sample_87_MYC
## 0610005C13Rik           504           648
## 0610007C21Rik            42            60
## 0610007L01Rik            40            22
## 0610007P08Rik            14            18
## 0610007P14Rik            24            23
## 0610007P22Rik            28            28
```

Rows represent reads mapped to each gene or corresponding background region. Column represent samples. And differential expression analysis will be carried out as follows:

Firstly, we need to construct a XBSeqDataSet object. Conditions are the design matrix for the experiment. Observe and background are the output matrix from HTSeq (Remeber to remove the bottom few lines of summary statistics of the output matrix).

```
conditions <- factor(c(rep("C", 3), rep("T", 3)))
XB <- XBSeqDataSet(Observed, Background, conditions)
```

It is always recommended that you examine the distribution of observed signal and background noise beforehand. We provide function ‘r XBplot’ to achieve this. We recommended to examine the distribution in log2 transcript per million (TPM) unit by setting argument unit equals to “logTPM”. Genelength information is loaded via “ExampleData”. Ideally, library size should also be provided. By default, the sum of all the reads that mapped to exonic regions are used.

```
XBplot(XB, Samplenum = 1, unit = "LogTPM", Genelength = genelength[, 2])
```

```
## Warning in XBplot(XB, Samplenum = 1, unit = "LogTPM", Genelength = genelength[, : Libsize is not provided, the sum of all the read counts that mapped to exonic
##               regions in each sample is used as the total library size for that sample
```

```
## Warning: Removed 16453 rows containing non-finite values (stat_bin).
```

![](data:image/png;base64...)

Then estimate the preliminary underlying signal followed by normalizing factor and dispersion estimates

```
XB <- estimateRealCount(XB)
XB <- estimateSizeFactors(XB)
XB <- estimateSCV(XB, method = "pooled", sharingMode = "maximum", fitType = "local")
```

Take a look at the scv fitting information

```
plotSCVEsts(XB)
```

![](data:image/png;base64...)

Carry out the DE test by using function XBSeqTest

```
Teststas <- XBSeqTest( XB, levels(conditions)[1L], levels(conditions)[2L], method ='NP')
```

Plot Maplot based on test statistics

```
MAplot(Teststas, padj = FALSE, pcuff = 0.01, lfccuff = 1)
```

![](data:image/png;base64...)

```
# Alternatively, all the codes above can be done with a wrapper function
# XBSeq
Teststats <- XBSeq(Observed, Background, conditions, method = "pooled", sharingMode = "maximum",
    fitType = "local", pvals_only = FALSE, paraMethod = "NP")
```

## 3.6 Compare the results with DESeq

Now we will carry out DE analysis on the same dataset by using DESeq and then compare the results obtained by these two methods

If you have not installed DESeq before, DESeq is also available from Bioconductor

```
biocLite("DESeq")
```

Then DE analysis for DESeq can be carried out by:

```
library('DESeq')
library('ggplot2')
de <- newCountDataSet(Observed, conditions)
de <- estimateSizeFactors(de)
de <- estimateDispersions(de, method = "pooled", fitType="local")
res <- nbinomTest(de, levels(conditions)[1], levels(conditions)[2])
```

Then we can compare the results from XBSeq and DESeq

```
DE_index_DESeq <- with(res, which(pval < 0.01 & abs(log2FoldChange) > 1))
DE_index_XBSeq <- with(Teststas, which(pval < 0.01 & abs(log2FoldChange) > 1))
DE_index_inters <- intersect(DE_index_DESeq, DE_index_XBSeq)
DE_index_DESeq_uniq <- setdiff(DE_index_DESeq, DE_index_XBSeq)
DE_plot <- MAplot(Teststas, padj = FALSE, pcuff = 0.01, lfccuff = 1, shape = 16)
DE_plot + geom_point(data = Teststas[DE_index_inters, ], aes(x = baseMean, y = log2FoldChange),
    color = "green", shape = 16) + geom_point(data = Teststas[DE_index_DESeq_uniq,
    ], aes(x = baseMean, y = log2FoldChange), color = "blue", shape = 16)
```

![](data:image/png;base64...)

The red dots indicate DE genes identified only by XBSeq. Then green dots are the shared results of XBSeq and DESeq. The blue dots are DE genes identified only by DESeq.

# 4 Details

## 4.1 Construction of gtf file for background region

* Exonic region annotation is obtained from UCSC database.
* Non-exonic regions are constructed by following several criteria:
  1. Download refFlat table from UCSC database
  2. Several functional elements (mRNA, peudo genes, etc.) of the genome are excluded from the whole genome annotation.
  3. Construct the background region for each gene by making the region to have the same sturcture or length as the exonic region of the gene.

More details regarding how do we construct the background region annotation file of an real example can be found in manual page of ExampleData and also our publication of XBSeq.

## 4.2 Construction of gtf file for APA annotation used by roar package

APA sites are predicted by using POLYAR program [2], which applies an Expectation Maximization (EM) approach by using 12 different previously mapped poly(A) signal (PAS) hexamer. The predicted APA sites by POLYAR are classified into three classes, PAS-strong, PAS-medium and PAS-weak. Only APA sites in PAS-strong class are selected to construct final APA annotation. APA annotations for human and mouse genome of different versions have been built and are available to download from github: <https://github.com/Liuy12/XBSeq_files>

## 4.3 Regarding intron retention

More often than not, I have been asked about whether intron retention events have any effect over the performance of XBSeq. Intron retention is a common mechanism for alternative splicing for controlling transcriptome activity. Several articles have already demonstrated that transcripts with intronic retention will be degraded via a mechanism called Nonsense-mediated mRNA decay (NMD) [3-5]. To me, intron retention will not affect the performance of XBSeq, since this type of transcripts will be degraded eventually and it makes sense to consider them as background noise.

# 5 Latest updates of XBSeq: XBSeq2

* Updated background annotation file using latest annotation file from UCSC database
* Incorprated functionality to directly process alignment files (.bam files) using featureCounts
* Provided one alternative parameter estimation by using Maximum likelihood estimation (MLE)
* Provided one alternative statistical test for differential expression by using beta distribution approximation
* Incorporation of roar for testing differential APA usage

# 6 Bug reports

Report bugs as issues on our [GitHub repository](https://github.com/Liuy12/XBSeq/issues) or you can report directly to my email: liuy12@uthscsa.edu.

# 7 Session information

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
## [1] parallel  stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] ggplot2_2.2.1              DESeq_1.28.0
##  [3] lattice_0.20-35            locfit_1.5-9.1
##  [5] XBSeq_1.6.0                DESeq2_1.16.0
##  [7] SummarizedExperiment_1.6.0 DelayedArray_0.2.0
##  [9] matrixStats_0.52.2         Biobase_2.36.0
## [11] GenomicRanges_1.28.0       GenomeInfoDb_1.12.0
## [13] IRanges_2.10.0             S4Vectors_0.14.0
## [15] BiocGenerics_0.22.0        BiocStyle_2.4.0
##
## loaded via a namespace (and not attached):
##  [1] splines_3.4.0            Formula_1.2-1
##  [3] assertthat_0.2.0         latticeExtra_0.6-28
##  [5] roar_1.12.0              GenomeInfoDbData_0.99.0
##  [7] Rsamtools_1.28.0         yaml_2.1.14
##  [9] RSQLite_1.1-2            backports_1.0.5
## [11] quadprog_1.5-5           digest_0.6.12
## [13] RColorBrewer_1.1-2       XVector_0.16.0
## [15] checkmate_1.8.2          colorspace_1.3-2
## [17] htmltools_0.3.5          Matrix_1.2-9
## [19] plyr_1.8.4               XML_3.98-1.6
## [21] genefilter_1.58.0        zlibbioc_1.22.0
## [23] xtable_1.8-2             scales_0.4.1
## [25] BiocParallel_1.10.0      pracma_2.0.4
## [27] htmlTable_1.9            tibble_1.3.0
## [29] annotate_1.54.0          nnet_7.3-12
## [31] lazyeval_0.2.0           survival_2.41-3
## [33] magrittr_1.5             memoise_1.1.0
## [35] evaluate_0.10            foreign_0.8-67
## [37] tools_3.4.0              data.table_1.10.4
## [39] formatR_1.4              stringr_1.2.0
## [41] munsell_0.4.3            cluster_2.0.6
## [43] AnnotationDbi_1.38.0     Biostrings_2.44.0
## [45] compiler_3.4.0           grid_3.4.0
## [47] RCurl_1.95-4.8           htmlwidgets_0.8
## [49] labeling_0.3             bitops_1.0-6
## [51] base64enc_0.1-3          rmarkdown_1.4
## [53] gtable_0.2.0             DBI_0.6-1
## [55] R6_2.2.0                 GenomicAlignments_1.12.0
## [57] gridExtra_2.2.1          knitr_1.15.1
## [59] dplyr_0.5.0              rtracklayer_1.36.0
## [61] Hmisc_4.0-2              rprojroot_1.2
## [63] stringi_1.1.5            Rcpp_0.12.10
## [65] geneplotter_1.54.0       rpart_4.1-11
## [67] acepack_1.4.1
```

# 8 Acknowledgements

XBSeq is implemented in R based on the source code from DESeq and DESeq2.

# 9 References

1. H. I. Chen, Y. Liu, Y. Zou, Z. Lai, D. Sarkar, Y. Huang, et al., “Differential expression analysis of RNA sequencing data by incorporating non-exonic mapped reads,” BMC Genomics, vol. 16 Suppl 7, p. S14, Jun 11 2015.
2. Akhtar MN, Bukhari SA, Fazal Z, Qamar R, Shahmuradov IA: POLYAR, a new computer program for prediction of poly(A) sites in human sequences. BMC genomics 2010, 11:646.
3. Jung, Hyunchul, et al. “Intron retention is a widespread mechanism of tumor-suppressor inactivation.” Nature genetics (2015).
4. Braunschweig, Ulrich, et al. “Widespread intron retention in mammals functionally tunes transcriptomes.” Genome research 24.11 (2014): 1774-1786.
5. Lykke-Andersen, Søren, and Torben Heick Jensen. “Nonsense-mediated mRNA decay: an intricate machinery that shapes transcriptomes.” Nature Reviews Molecular Cell Biology (2015).