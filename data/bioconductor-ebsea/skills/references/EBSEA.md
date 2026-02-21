# EBSEA: Exon Based Strategy for Expression Analysis of genes

#### Arfa Mehmood

#### 2025-10-29

## Introduction

Conventionally, gene-level read counts are used as input to test for differential gene expression between sample condition groups. EBSEA follows a different approach: in order to increase the power it first performs the statistical testing separately for each exon prior to aggregating the results to the gene level. The user provides the raw exon count data, which can be generated, for instance, using the python scripts in the DEXSeq or RSubread R/Bioconductor packages. DESeq2 R/Bioconductor package is used for normalization (RLE method) and statistical testing. Exon-level results are aggregated to the gene level using empirical Brown’s method (ebm), taking the dependence of exons into consideration to avoid inflation of p-values. P-values are corrected using the Benjamini-Hochberg method.

## Data

EBSEA takes the raw exon-level counts as input. Columns of the data frame contain the sample names and row names consist of the gene name followed by the exon number, separated by a colon: e.g. GeneName:ExonNumber.

exonCounts provided with the package can be used for testing. It contains the first 1000 exon count rows from the pasilla dataset from Pasilla R/Bioconductor package. The dataset has seven samples belonging to either treated or untreated sample group.

The dataset can be taken into use as follows:

```
library(EBSEA)
data("exonCounts")
head(exonCounts)
#>                 treated1fb treated2fb treated3fb untreated1fb untreated2fb
#> FBgn0000003:001          0          0          1            0            0
#> FBgn0000008:001          0          0          0            0            0
#> FBgn0000008:002          0          0          0            0            0
#> FBgn0000008:003          0          1          0            1            1
#> FBgn0000008:004          1          0          1            0            1
#> FBgn0000008:005          4          1          1            2            2
#>                 untreated3fb untreated4fb
#> FBgn0000003:001            0            0
#> FBgn0000008:001            0            0
#> FBgn0000008:002            1            0
#> FBgn0000008:003            1            0
#> FBgn0000008:004            0            1
#> FBgn0000008:005            0            1
```

## Data Filtering

It is recommended to filter out the lowly expressed exons prior to statistical testing. This can be performed using filterCount method that filters out the exons with average count across the sample set lower than the threshold (default 1). After filtering the individual exons, it is controlled that each gene has a required mimimum number of exons remaining (default 1) or otherwise the whole gene is filtered out.

```
filtCounts <- filterCounts(exonCounts)
#> Filter exons with average count less than 1 across the dataset and keep genes with
#>                      at least 1 remaining exon
```

## Analysis

To run EBSEA, sample group is defined for each column. It can also be separately indicated which samples of the two groups are paired.

```
group <- data.frame('group' = as.factor(c('G1', 'G1', 'G1', 'G2', 'G2', 'G2', 'G2')))
row.names(group) <- colnames(filtCounts)
design <- ~group
ebsea.out <- EBSEA(filtCounts, group, design)
#> Checking Parameters
#> Performing Statistical testing of Exons
#> gene-wise dispersion estimates
#> mean-dispersion relationship
#> final dispersion estimates
#> Using Wald test for testing
#> Aggregating to Gene-level results
#> Done
```

The paired analysis can be provided as follows:

```
group <- data.frame('group' = as.factor(c('G1', 'G1', 'G1', 'G2', 'G2', 'G2', 'G2')), 'paired' = as.factor(c(1,2,3,1,2,3,3)))
row.names(group) <- colnames(exonCounts)
design <- ~paired+group
ebsea.out <- EBSEA(exonCounts, group, design)
#> Checking Parameters
#> Performing Statistical testing of Exons
#> gene-wise dispersion estimates
#> mean-dispersion relationship
#> final dispersion estimates
#> Using Wald test for testing
#> Aggregating to Gene-level results
#> Done
```

## Results

The result list contains the following information:

* ExonTable: Table of exon-level statistics
* GeneTable: Table of gene-level statistics
* RawCounts: Raw exon-level read counts
* NormCounts: Normalized exon-level read counts
* Group: Sample group for each sample
* design: design matrix used

The exon statistics are as follows:

```
head(ebsea.out$ExonTable)
#>                  baseMean log2FoldChange    lfcSE       stat    pvalue padj
#> FBgn0000003:001 0.1568342     -1.0853517 3.852853 -0.2817008 0.7781730   NA
#> FBgn0000008:001 0.0000000             NA       NA         NA        NA   NA
#> FBgn0000008:002 0.1893382      0.5522615 3.871083  0.1426633 0.8865561   NA
#> FBgn0000008:003 0.5914569      1.3209978 2.724739  0.4848162 0.6278067   NA
#> FBgn0000008:004 0.5250020     -0.4194157 2.818955 -0.1487841 0.8817240   NA
#> FBgn0000008:005 1.3557847     -0.4019721 1.732976 -0.2319548 0.8165731   NA
#>                     gene_id
#> FBgn0000003:001 FBgn0000003
#> FBgn0000008:001 FBgn0000008
#> FBgn0000008:002 FBgn0000008
#> FBgn0000008:003 FBgn0000008
#> FBgn0000008:004 FBgn0000008
#> FBgn0000008:005 FBgn0000008
```

The result for each exon contains the following:

* **baseMean:** mean expression level across the dataset
* **log2FoldChange:** log2 fold-change
* **lfcSE:** standard error of the log2 fold-change
* **stat:** z-statistics
* **pvalue:** p-values
* **padj:** adjusted p-values
* **gene\_id:** Associated gene name

The exon statistics are as follows:

```
head(ebsea.out$GeneTable)
#>                    Gene       P_test padj
#> FBgn0000003 FBgn0000003 0.778172....    1
#> FBgn0000008 FBgn0000008 0.996374....    1
#> FBgn0000014 FBgn0000014 0.976959....    1
#> FBgn0000015 FBgn0000015 0.895788....    1
#> FBgn0000017 FBgn0000017 0.168138....    1
#> FBgn0000018 FBgn0000018 0.499559....    1
```

The column names represent the following:

* **Gene:** gene name
* **P\_test:** p-value
* **padj:** adjusted p-value

Result for a specific gene can be visualized as follows:

```
visualizeGenes('FBgn0000064', ebsea.out)
#> Obtaining Data
#> Creating Plot
```

![](data:image/png;base64...)

Top panel contains the log2 fold-change for each expressed exon. Asterisk denotes the significance level (\*: < 0.05, \*\*: < 0.01). Bottom panel shows the averaged normalized read count for each sample group.

The title of the figure shows the gene name and the adjusted gene-level p-value (fdr)

## Reference

Laiho, A. et al., **A note on an exon-based strategy to identify differentially expressed genes in RNA-seq experiments**. PloS One, 2014.