# epidecodeR: a functional exploration tool for epigenetic and epitranscriptomic regulation

* [Introduction](#introduction)
* [Implementation steps](#implementation-steps)
* [For the impatient](#for-the-impatient)
  + [Installation](#installation)
* [Run example](#run-example)
* [Details](#details)
  + [Inputs](#inputs)
  + [Output](#output)
  + [Plots](#plots)
  + [usage](#usage-1)
  + [arguments](#arguments-1)
  + [usage](#usage-2)
  + [arguments](#arguments-2)

## Introduction

Recent technological advances in chemical modification detection on DNA and RNA using high throughput sequencing have generated a plethora of epigenomic and epitranscriptomic datasets. However, functional characterization of chemical modifications on DNA and RNA still remain largely unexplored. Generally, in silico methods rely on identifying location and quantitative differential analysis of the modifications.

The number of epigenomic/epitranscriptomic modification events associated with the gene can provide the degree of modification/accessibility associated with the gene of interest, which in turn plays a crucial role in determining the levels of differential gene expression. Data integration methods can combine both these layers and provide information about the degree of events occurring and its influence on the differential gene expression, ribosome occupancy or protein translation. We made an assumption that if an epi-mark is functional for up- or down-regulation of expression in a particular context, a gene with the epi-mark is more likely to be impacted for its expression. If a gene has more marked sites thus higher degree of modification would be impacted more, which can be quantified as differential RNA expression, ribosome occupancy, or protein abundance obtained from RNA-seq, Ribo-seq, or proteomics datasets

Here we present epidecodeR, an R package capable of integrating chemical modification data generated from a host of epigenomic or epitranscriptomic techniques such as ChIP-seq, ATAC-seq, m6A-seq, etc. and dysregulated gene lists in the form of differential gene expression, ribosome occupancy or differential protein translation and identify impact of dysregulation of genes caused due to varying degrees of chemical modifications associated with the genes. epidecodeR generates cumulative distribution function (CDF) plots showing shifts in trend of overall log2FC between genes divided into groups based on the degree of modification associated with the genes. The tool also tests for significance of difference in log2FC between groups of genes.

## Implementation steps

1. Calculate sum of all events associated with each gene
2. Group genes into user defined groups based on degree (count) of events per gene
3. Calculate theoretical and empirical cumulative probabilities (quantiles) of log2FC per group
4. Perform ANOVA one-way test of significance in difference of mean between groups
5. Plot CDF plots and boxplot with significance testing results

![](data:image/png;base64...)

## For the impatient

### Installation

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("epidecodeR")
```

```
library(epidecodeR)
```

## Run example

```
events<-system.file("extdata", "NOMO-1_ref_peaks.bed", package="epidecodeR")
deg<-system.file("extdata", "FTOi.txt", package="epidecodeR")
epiobj <- epidecodeR(events = events, deg = deg, pval=0.05, param = 3, ints=c(2,4))
```

```
makeplot(epiobj, lim = c(-10,10), title = "m6A mediated dysregulation after FTO inhibitor treatment", xlab = "log2FC")
#> Warning: Removed 1 row containing missing values or values outside the scale range
#> (`geom_point()`).
#> Warning: Removed 1 row containing missing values or values outside the scale range
#> (`geom_line()`).
```

![](data:image/png;base64...)

```
plot_test(epiobj, title = "m6A mediated dysregulation after FTO inhibitor treatment", ylab = "log2FC")
```

![](data:image/png;base64...)

## Details

### Inputs

epidecodeR expects two mandatory inputs:

1. reference events file and
2. dysregulated gene list

Dysregulated genes are divided into groups based on degree of events associated with the respective gene as determined using events file

Event files consist of reference DNA/RNA modification’s genomic positions as a bed file or counts of events (modifications) per gene

Reference modifications are generally modifications identified on wild type cell line or normal (healthy) organism using high throughput sequencing techniques such as ChIP-seq, ATAC-seq, m6A-seq, etc.

Example input files look like this:

Input file as event counts per gene looks like this:

```
events<-system.file("extdata", "eventcounts.txt", package="epidecodeR")
events_df<-read.table(events, header = TRUE, row.names = NULL, stringsAsFactors = FALSE, sep = "\t", fill = TRUE)
```

```
head (events_df)
#>                             ID x
#> 1 ENSMUSG00000025907.14|Rb1cc1 4
#> 2 ENSMUSG00000051285.17|Pcmtd1 2
#> 3    ENSMUSG00000061024.8|Rrs1 2
#> 4   ENSMUSG00000025915.14|Sgk3 1
#> 5  ENSMUSG00000056763.16|Cspp1 2
#> 6  ENSMUSG00000016918.15|Sulf1 2
```

Events as genomic coordinates in BED file format looks like this:

```
events<-system.file("extdata", "NOMO-1_ref_peaks.bed", package="epidecodeR")
peaks_df<-read.table(events, header = FALSE, row.names = NULL, stringsAsFactors = FALSE, sep = "\t", fill = TRUE)
```

```
head (peaks_df)
#>     V1     V2     V3                 V4      V5 V6     V7     V8 V9 V10    V11
#> 1 chr1 133350 133500  ENSG00000233750.3 1.8e-03  + 133350 133500  0   1   150,
#> 2 chr1 856249 856749  ENSG00000228794.9 1.0e-28  + 856249 856749  0   1   500,
#> 3 chr1 904833 915757  ENSG00000272438.1 1.8e-04  + 904833 915757  0   2 124,8,
#> 4 chr1 912454 913502  ENSG00000230699.2 1.3e-75  + 912454 913502  0   1  1048,
#> 5 chr1 914099 914250  ENSG00000230699.2 3.0e-05  + 914099 914250  0   1   151,
#> 6 chr1 944282 944482 ENSG00000187634.12 3.2e-26  + 944282 944482  0   1   200,
#>       V12
#> 1       0
#> 2       0
#> 3 0,10916
#> 4       0
#> 5       0
#> 6       0
```

BED files must have a minimum three columns i.e. chr, start and end. If ID of the coordinate is provided it must be in the fourth column of BED file

##### Important: ID of events file and dysregulated gene list must be same. e.g. If ID type in event counts file is gene\_id, dysregulated gene list also must have ID type gene\_id for successful mapping and groups assignment.

[Note: Version of the gene\_id must also match e.g. ENSG00000228794.9 & ENSG00000228794.10 not allowed]

In case ID type is not provided as fourth column of the BED file, epidecodeR is capable of assigning ID type to coordinates by overlapping with “gene” level coordinates of the organism using reference genome annotation GTF file. Please provide appropriate genome annotation file in GTF format and ID type compatible with ID type of dysregulated gene list. (\*.gtf.gz are accepted)

#### usage

epidecodeR(events, deg, gtf\_file, id\_type, boundaries, pval, param, ints)

#### arguments

| Parameter | Explanation |
| --- | --- |
| events | char - Name of events file. This can be a txt file with two columns: 1) id & 2) counts of events in the gene. Optionally, users can provide a 3+ column .bed file. The count of events per gene in fourth column are calculated to determine degree of events per gene; Default NULL |
| deg | char - Name of dysregulated genes file. This file is a three column file consisting of column 1: id (Make sure ID type matches between events and deg); column 2) log2foldchange; 3) P value of signficance of fold change; Default NULL |
| gtf\_file | char - Name of compressed gtf file. Use gtf file if .bed file used as events input and users wish to count events per gene from bed file by comparing coordinates in bed to gene coordinates in gtf to assign events to genes. Note: For coordinates overlapping to multiple features in gtf, only one feature is assigned to the coordinate, which is choosen arbitrarily; Default NULL |
| id\_type | char - Name of id type used to count events per gene. ID type must match between events and DEG file. For example, if ‘gene\_name’ is used as ID type in DEG file, same ID type must be used to assign coordinates to genes. In case the DEG list contains two ID types merged e.g. ’ENSMUSG00000035299.16 |
| boundaries | numeric - Number of base pairs to include within boundries of genes for event counting. This option adds # of bases to start and end of coordinates of the genes to include promotor regions within gene for overlap with bed files and event counting; Default 0 |
| pval | numeric - P value cut-off of dysregulated genes in DEG file to be considered for distribution into groups. Default: 0.05} |
| param | numeric - Defines the number and size of groups of dysregulated genes. Allowed values are param = 1 [0 events: 1+ events]; param = 2 [0 events: 1-N event: (N+1)+ event]; param = 3 [0 events; 1 event; 2-N events; (N+1)+ events]; N is user defined limit of the group provided using ints parameter |
| ints | vector - A vector of intervals defining limits of the degree of group for param = 2 and param = 3. e.g. c(1, 4) or c(2, 5): For param = 2, Default :c(1,4) and for param = 3, Default: c(2,5) |

### Output

epidecodeR function returns an epidecodeR object of S4 class, which contains theoretical and empirical cumulative probabilities of the quantiles as well as group information and set of genes belonging to each group. The object also contains result of one-way ANOVA significance test of difference in means of log2FC between groups following Tukey’s test between every set of two groups.

Theoretical cumulative probabilities

```
head (get_theoretical_table(epiobj))
#>   Quantiles Cumulative.Probabilities grp
#> 1 -8.167854              0.001000000   0
#> 2 -8.150726              0.001021031   0
#> 3 -8.133597              0.001042468   0
#> 4 -8.116469              0.001064316   0
#> 5 -8.099341              0.001086584   0
#> 6 -8.082212              0.001109278   0
```

Empirical cumulative probabilities

```
head (get_empirical_table(epiobj))
#>   Order.Statistics Cumulative.Probabilities grp
#> 1        -12.71380             0.0003950071   0
#> 2         -8.82960             0.0010270185   0
#> 3         -7.49162             0.0016590299   0
#> 4         -7.39978             0.0022910412   0
#> 5         -7.23092             0.0029230526   0
#> 6         -7.15772             0.0035550640   0
```

Count of genes per group

```
head (get_grpcounts(epiobj))
#>    0    1 2to4   5+
#> 1582  425  451   62
```

Access genes belonging to particular group using group name like so

```
grptables_list<-get_grptables(epiobj)
head (grptables_list$'0')
#>              baseMean       X0         padj
#> 16  ENSG00000278948.1  1.51625 2.636506e-02
#> 44 ENSG00000176927.15  3.17202 8.034753e-22
#> 69  ENSG00000286757.1 -4.35532 1.684922e-12
#> 75  ENSG00000223529.1 -1.91574 6.635630e-12
#> 88 ENSG00000077782.20  1.31434 2.806739e-02
#> 97  ENSG00000259426.6  2.45728 3.627620e-03
head (grptables_list$'1')
#>               baseMean       X0         padj
#> 17  ENSG00000187984.12 -1.56877 6.782814e-05
#> 45  ENSG00000158106.14 -2.13955 1.092973e-03
#> 76  ENSG00000153029.14  1.82145 1.862121e-32
#> 84  ENSG00000104549.12 -1.89319 7.894604e-26
#> 159 ENSG00000136628.18 -1.17646 2.339078e-05
#> 191 ENSG00000090621.14 -1.51476 2.350620e-13
head (grptables_list$'2to4')
#>               baseMean       X0          padj
#> 38   ENSG00000183019.7  2.37796 3.228213e-129
#> 120 ENSG00000196843.16  1.51918  1.462454e-15
#> 362 ENSG00000064012.21  1.30417  7.608556e-10
#> 392 ENSG00000143374.17 -1.53433  6.231672e-11
#> 445 ENSG00000142512.15  1.66547  6.574096e-21
#> 474 ENSG00000135473.15 -1.25041  1.066688e-02
head (grptables_list$'5+')
#>                baseMean       X0         padj
#> 121  ENSG00000185504.17 -2.84979 4.605607e-27
#> 271  ENSG00000068654.16 -1.35169 2.697329e-08
#> 400  ENSG00000186350.11 -1.87750 1.450095e-17
#> 682  ENSG00000015676.18 -1.26450 1.247364e-07
#> 1569 ENSG00000166949.16  1.27631 3.484713e-08
#> 1738 ENSG00000188191.15 -1.61237 3.124481e-06
```

### Plots

#### makeplot

This function creates CDF plots using epidecodeR object generated above.

```
makeplot(epiobj, lim = c(-10,10), title = "m6A mediated dysregulation after FTO inhibitor treatment", xlab = "log2FC")
#> Warning: Removed 1 row containing missing values or values outside the scale range
#> (`geom_point()`).
#> Warning: Removed 1 row containing missing values or values outside the scale range
#> (`geom_line()`).
```

![](data:image/png;base64...)

### usage

makeplot(obj, type, lim, title, xlab, ylab)

### arguments

| Parameter | Explanation |
| --- | --- |
| obj | (epidecodeR object) epidecodeR object generated using epidecodeR function |
| type | (char) Type of CDF plot to generate; Accepted values ‘t’: theoretical CDF plot; ‘e’: empirical CDF plot; ‘both’: Creates both theoretical and empirical plots. Default: both |
| lim | (vector) Upper and lower limits of log2FC for X-axis |
| title | (char) Title of the plot |
| xlab | (char) X-axis label |
| ylab | (char) Y-axis label |

#### plot\_test

This function creates boxplots of distribution of log2FC in individual groups using epidecodeR object generated above.

```
plot_test(epiobj, title = "m6A mediated dysregulation after FTO inhibitor treatment", ylab = "log2FC")
```

![](data:image/png;base64...)

### usage

plot\_test(obj, title, ylab)

### arguments

| Parameter | Explanation |
| --- | --- |
| obj | (epidecodeR object) epidecodeR object generated using epidecodeR function |
| title | (char) Title of the plot |
| ylab | (char) Y-axis label |

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
#> [1] epidecodeR_1.18.0
#>
#> loaded via a namespace (and not attached):
#>  [1] SummarizedExperiment_1.40.0 gtable_0.3.6
#>  [3] rjson_0.2.23                xfun_0.53
#>  [5] bslib_0.9.0                 ggplot2_4.0.0
#>  [7] rstatix_0.7.3               lattice_0.22-7
#>  [9] Biobase_2.70.0              vctrs_0.6.5
#> [11] tools_4.5.1                 bitops_1.0-9
#> [13] generics_0.1.4              stats4_4.5.1
#> [15] curl_7.0.0                  parallel_4.5.1
#> [17] tibble_3.3.0                pkgconfig_2.0.3
#> [19] Matrix_1.7-4                RColorBrewer_1.1-3
#> [21] cigarillo_1.0.0             S7_0.2.0
#> [23] S4Vectors_0.48.0            lifecycle_1.0.4
#> [25] compiler_4.5.1              farver_2.1.2
#> [27] Rsamtools_2.26.0            Biostrings_2.78.0
#> [29] Seqinfo_1.0.0               codetools_0.2-20
#> [31] carData_3.0-5               htmltools_0.5.8.1
#> [33] sass_0.4.10                 RCurl_1.98-1.17
#> [35] yaml_2.3.10                 Formula_1.2-5
#> [37] pillar_1.11.1               car_3.1-3
#> [39] ggpubr_0.6.2                crayon_1.5.3
#> [41] jquerylib_0.1.4             tidyr_1.3.1
#> [43] BiocParallel_1.44.0         DelayedArray_0.36.0
#> [45] cachem_1.1.0                abind_1.4-8
#> [47] tidyselect_1.2.1            digest_0.6.37
#> [49] dplyr_1.1.4                 purrr_1.1.0
#> [51] restfulr_0.0.16             labeling_0.4.3
#> [53] fastmap_1.2.0               grid_4.5.1
#> [55] SparseArray_1.10.0          cli_3.6.5
#> [57] magrittr_2.0.4              S4Arrays_1.10.0
#> [59] dichromat_2.0-0.1           XML_3.99-0.19
#> [61] broom_1.0.10                withr_3.0.2
#> [63] scales_1.4.0                backports_1.5.0
#> [65] rmarkdown_2.30              XVector_0.50.0
#> [67] httr_1.4.7                  matrixStats_1.5.0
#> [69] ggsignif_0.6.4              evaluate_1.0.5
#> [71] knitr_1.50                  GenomicRanges_1.62.0
#> [73] IRanges_2.44.0              BiocIO_1.20.0
#> [75] EnvStats_3.1.0              rtracklayer_1.70.0
#> [77] rlang_1.1.6                 glue_1.8.0
#> [79] BiocGenerics_0.56.0         jsonlite_2.0.0
#> [81] R6_2.6.1                    MatrixGenerics_1.22.0
#> [83] GenomicAlignments_1.46.0
```