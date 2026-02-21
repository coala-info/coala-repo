# Integration with R

#### Xiuwen Zheng (Department of Biostatistics, University of Washington, Seattle)

#### Aug 31, 2016

* [1 SeqArray Functions](#seqarray-functions)
  + [1.1 Key R Functions](#key-r-functions)
  + [1.2 Calculating Allele Frequencies](#calculating-allele-frequencies)
  + [1.3 PCA R Implementation](#pca-r-implementation)
  + [1.4 Parallel Implementation](#parallel-implementation)
* [2 Bioconductor Features](#bioconductor-features)
  + [2.1 GRanges and GRangesList](#granges-and-grangeslist)
  + [2.2 VariantAnnotation](#variantannotation)
* [3 Integration with SeqVarTools](#integration-with-seqvartools)
  + [3.1 Linear Regression](#linear-regression)
* [4 Integration with SNPRelate](#integration-with-snprelate)
  + [4.1 LD-based Marker Pruning](#ld-based-marker-pruning)
  + [4.2 Principal Component Analysis](#principal-component-analysis)
  + [4.3 Relatedness Analysis](#relatedness-analysis)
  + [4.4 Identity-By-State Analysis](#identity-by-state-analysis)
  + [4.5 Fixation Index (\(F\_\text{st}\))](#fixation-index-f_textst)
* [5 GENESIS](#genesis)
* [6 Resources](#resources)
* [7 Session Information](#session-information)
* [References](#references)

.

.

.

The SeqArray package is designed for R programming environment, and enables high-performance computing in the multi-core symmetric multiprocessing and loosely coupled computer cluster framework. The features of SeqArray are extended with other existing R packages for WGS data analyses, and the R codes for demonstration are available in the package vignette [R Integration](http://bioconductor.org/packages/release/bioc/vignettes/SeqArray/inst/doc/SeqArray.html).

![](data:image/svg+xml;base64...)

**Figure 1**: SeqArray framework and flowchart. The SeqArray format is built on top of the Genomic Data Structure (GDS) format, and GDS is a generic data container with hierarchical structure for storing multiple array-oriented data sets. A high-level R interface to GDS files is provided in the gdsfmt package with a C++ library, and the SeqArray package offers functionalities specific to sequencing data. At a minimum a SeqArray file contains sample and variant identifiers, position, chromosome, reference and alternate alleles for each variant. Parallel computing environments, like multi-core computer clusters, are enabled with SeqArray. The functionality of SeqArray is extended by SeqVarTools, SNPRelate, GENESIS and other R/Bioconductor packages for WGS analyses.

.

```
library(SeqArray)
```

```
## Loading required package: gdsfmt
```

```
# open a SeqArray file in the package (1000 Genomes Phase1, chromosome 22)
file <- seqOpen(seqExampleFileName("KG_Phase1"))

seqSummary(file)
```

```
## File: /tmp/RtmpXPTVOy/Rinst2e71e94b082247/SeqArray/extdata/1KG_phase1_release_v3_chr22.gds
## Format Version: v1.0
## Reference: GRCh37
## Ploidy: 2
## Number of samples: 1,092
## Number of variants: 19,773
## Chromosomes:
##     chr22: 19773
## Alleles:
##     DEL, Deletion
##     tabulation: 2, 19773(100.0%)
## Annotation, Quality:
##     Min: 0, 1st Qu: 100, Median: 100, Mean: 110.146536457016, 3rd Qu: 100, Max: 3002, NA's: 10
## Annotation, FILTER:
##     PASS, , 19773(100.0%)
## Annotation, INFO variable(s):
##     <None>
## Annotation, FORMAT variable(s):
##     GT, 1, String, Genotype
## Annotation, sample variable(s):
##     Family.ID, String, <NA>
##     Population, String, <NA>
##     Gender, String, <NA>
```

.

.

.

.

.

.

.

# 1 SeqArray Functions

## 1.1 Key R Functions

**Table 1**: The key functions in the SeqArray package.

| Function | Description |
| --- | --- |
| seqVCF2GDS | Reformat VCF files. [»](https://rdrr.io/bioc/SeqArray/man/seqVCF2GDS.html) |
| seqSetFilter | Define a data subset of samples or variants. [»](https://rdrr.io/bioc/SeqArray/man/seqSetFilter.html) |
| seqGetData | Get data from a SeqArray file with a defined filter. [»](https://rdrr.io/bioc/SeqArray/man/seqGetData.html) |
| seqApply | Apply a user-defined function over array margins. [»](https://rdrr.io/bioc/SeqArray/man/seqApply.html) |
| seqParallel | Apply functions in parallel. [»](https://rdrr.io/bioc/SeqArray/man/seqParallel.html) |

Genotypic data and annotations are stored in an array-oriented manner, providing efficient data access using the R programming language. Table 1 lists five key functions provided in the SeqArray package and many data analyses can be done using just these functions.

`seqVCF2GDS()` converts VCF files to SeqArray format. Multiple cores in an SMP architecture within one or more compute nodes in a compute cluster can be used to simultaneously reformat the data. `seqVCF2GDS()` utilizes R’s connection interface to read VCF files incrementally, and it is able to import data from http/ftp texts and the standard output of a command-line tool via a pipe.

`seqSetFilter()` and `seqGetData()` can be used together to retrieve data for a selected set of samples from a defined genomic region. `GRanges` and `GRangesList` objects defined in the Bioconductor core packages are supported via `seqSetFilter()` (Gentleman et al. 2004; Lawrence et al. 2013).

`seqApply()` applies a user-defined function to array margins of genotypes and annotations. The function that is applied can be defined in R as is typical, or via C/C++ code using the Rcpp package (Eddelbuettel et al. 2011). `seqParallel()` utilizes the facilities in the parallel package (Rossini, Tierney, and Li 2007; R Core Team 2016) to perform calculations on a SeqArray file in parallel.

## 1.2 Calculating Allele Frequencies

We illustrate the SeqArray functions by implementing an example to calculate the frequency of reference allele across all chromosomes. If a genomic region is specified via `seqSetFilter()`, the calculation is performed within the region instead of using all variants. `seqApply()` enables applying a user-defined function to the margin of genotypes, and the R code is shown as follows:

```
af <- seqApply(file, "genotype", as.is="double", margin="by.variant",
    FUN=function(x) { mean(x==0L, na.rm=TRUE) })
head(af)
```

```
## [1] 0.6950549 0.9432234 0.9995421 0.9995421 0.9386447 0.9990842
```

where `file` is a SeqArray file, `as.is` indicates returning a numeric vector, `margin` is specified for applying the function by variant. The variable `x` in the user-defined function is an allele-by-sample integer matrix at a site and `0L` denotes the reference allele where the suffix `L` indicates the number is an integer.

The Rcpp package simplifies integration of compiled C++ code with R (Eddelbuettel et al. 2011), and the function can be dynamically defined with inlined C/C++ codes:

```
library(Rcpp)

cppFunction("
    double CalcAlleleFreq(IntegerVector x)
    {
        int len=x.size(), n=0, n0=0;
        for (int i=0; i < len; i++)
        {
            int g = x[i];
            if (g != NA_INTEGER)
            {
                n++;
                if (g == 0) n0++;
            }
        }
        return double(n0) / n;
    }")
```

where *IntegerVector* indicates the input variable `x` is an integer vector, `NA_INTEGER` is missing value and the function counts how many zeros and non-missing values for calculating frequency. The name *CalcAlleleFreq* can be passed to `seqApply()` directly:

```
af <- seqApply(file, "genotype", as.is="double", margin="by.variant", FUN=CalcAlleleFreq)
head(af)
```

```
## [1] 0.6950549 0.9432234 0.9995421 0.9995421 0.9386447 0.9990842
```

The C++ integration is several times faster than the R implementation, suggesting an efficient approach with C/C++ when real-time performance is required.

It is able to run the calculation in parallel. The genotypes of a SeqArray file are automatically split into non-overlapping parts according to different variants or samples, and the results from client processes collected internally:

```
af <- seqApply(file, "genotype", as.is="double",
    margin="by.variant", FUN=function(x) { mean(x==0L, na.rm=TRUE) }, parallel=2)
head(af)
```

```
## [1] 0.6950549 0.9432234 0.9995421 0.9995421 0.9386447 0.9990842
```

Here `parallel` specifies the number of cores.

## 1.3 PCA R Implementation

Principal Component Analysis (PCA) is a common tool used in exploratory data analysis for high-dimensional data. PCA is often involved with the calculation of covariance matrix, and the following R code implements the calculation proposed in (Patterson, Price, and Reich 2006). The user-defined function computes the covariance matrix for each variant and adds up to a total matrix `s`. The argument `.progress=TRUE` enables the display of progress information during the calculation.

```
# covariance variable with an initial value
s <- 0

seqApply(file, "$dosage", function(x)
    {
        p <- 0.5 * mean(x, na.rm=TRUE)      # allele frequency
        g <- (x - 2*p) / sqrt(p*(1-p))      # normalized by allele frequency
        g[is.na(g)] <- 0                    # correct missing values
        s <<- s + (g %o% g)                 # update the cov matrix s in the parent environment
    }, margin="by.variant", .progress=TRUE)

# scaled by the number of samples over the trace
s <- s * (nrow(s) / sum(diag(s)))

# eigen-decomposition
eig <- eigen(s)
```

```
[..................................................]  0%, ETC: ---
[==================>...............................] 36%, ETC: 4.1m
...
[==================================================] 100%, completed in 14.3m
```

```
# covariance variable with an initial value
s <- 0

seqBlockApply(file, "$dosage", function(x)
    {
        p <- 0.5 * colMeans(x, na.rm=TRUE)     # allele frequencies (a vector)
        g <- (t(x) - 2*p) / sqrt(p*(1-p))      # normalized by allele frequency
        g[is.na(g)] <- 0                       # correct missing values
        s <<- s + crossprod(g)                 # update the cov matrix s in the parent environment
    }, margin="by.variant", .progress=TRUE)
```

```
## [..................................................]  0%, ETC: ---    [=======================>..........................] 45%, ETC: 12s    [==================================================] 100%, used 20s
```

```
# scaled by the number of samples over the trace
s <- s * (nrow(s) / sum(diag(s)))

# eigen-decomposition
eig <- eigen(s, symmetric=TRUE)
```

`seqParallel()` utilizes the facilities offered by the R parallel package to perform calculations within a cluster or SMP environment, and the genotypes are automatically split into non-overlapping parts. The parallel implementation with R is shown as follows, and the C optimized function is also available in the SNPRelate package.

```
# the datasets are automatically split into four non-overlapping parts
genmat <- seqParallel(2, file, FUN = function(f)
    {
        s <- 0  # covariance variable with an initial value
        seqBlockApply(f, "$dosage", function(x)
            {
                p <- 0.5 * colMeans(x, na.rm=TRUE)     # allele frequencies (a vector)
                g <- (t(x) - 2*p) / sqrt(p*(1-p))      # normalized by allele frequency
                g[is.na(g)] <- 0                       # correct missing values
                s <<- s + crossprod(g)                 # update the cov matrix s in the parent environment
            }, margin="by.variant")
        s  # output
    }, .combine = "+",    # sum "s" of different processes together
    split = "by.variant")

# scaled by the number of samples over the trace
genmat <- genmat * (nrow(genmat) / sum(diag(genmat)))

# eigen-decomposition
eig <- eigen(genmat, symmetric=TRUE)
```

```
# figure
plot(eig$vectors[,1], eig$vectors[,2], xlab="PC 1", ylab="PC 2")
```

![](data:image/png;base64...)

More examples can be found: [SeqArray Data Format and Access](./SeqArrayTutorial.html#examples)

## 1.4 Parallel Implementation

The default setting for the analysis functions in the SeqArray package is serial implementation, but users can setup a cluster computing environment manually via `seqParallelSetup()` and distribute the calculations to multiple cores or even more than 100 cluster nodes.

```
# use 2 cores for demonstration
seqParallelSetup(2)
```

```
## Enable the computing cluster with 2 forked R processes.
```

```
# numbers of distinct alleles per site
table(seqNumAllele(file))
```

```
##
##     2
## 19773
```

```
# reference allele frequencies
summary(seqAlleleFreq(file, ref.allele=0L))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.0000  0.9725  0.9963  0.9286  0.9991  1.0000
```

```
# close the cluster environment
seqParallelSetup(FALSE)
```

.

.

.

.

.

.

.

# 2 Bioconductor Features

## 2.1 GRanges and GRangesList

In this section, we illustrate how to work with Bioconductor core packages for performing common queries to retrieve data from a SeqArray file. The `GRanges` and `GRangesList` classes manipulate genomic range data and can be used in the function `seqSetFilter()` to define a data subset. For example, the annotation information of each exon, the coding range and transcript ID are stored in the `TxDb.Hsapiens.UCSC.hg19.knownGene` object for the UCSC known gene annotations on hg19.

```
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
```

```
# get the exons grouped by gene
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
txs <- exonsBy(txdb, "gene")
```

where `exonsBy()` returns a `GRangesList` object for all known genes in the database.

```
seqSetFilter(file, txs)  # define an exon filter
```

```
## # of selected variants: 1,050
```

```
# VCF export with exon variants
seqGDS2VCF(file, "exons.vcf.gz")
```

```
## Tue Jan  3 15:43:55 2017
## VCF Export: exons.vcf.gz
##     1,092 samples, 1,050 variants
##     INFO Field: <none>
##     FORMAT Field: <none>
##
[..................................................]  0%, ETC: ---
[==================================================] 100%, completed in 0s
## Tue Jan  3 15:43:55 2017    Done.
```

If random-access memory is sufficiently large, users could load all exon variants via `seqGetData(file, "genotype")`; otherwise, data have to be loaded by chunk or a user-defined function is applied over variants by `seqApply()`.

## 2.2 VariantAnnotation

SeqArray can also export data with selected variants and samples as a `VCF` object for use with the VariantAnnotation package (Obenchain et al. 2014):

```
library(VariantAnnotation)
```

```
# select a region [10Mb, 30Mb] on chromosome 22
seqSetFilterChrom(file, 22, from.bp=10000000, to.bp=30000000)
```

```
## # of selected variants: 7,066
```

```
vcf <- seqAsVCF(file, chr.prefix="chr")
vcf
```

```
## class: CollapsedVCF
## dim: 7066 1092
## rowRanges(vcf):
##   GRanges with 9 metadata columns: ID, REF, ALT, QUAL, FILTER, REF, ALT, QUAL, FILTER
## info(vcf):
##   DataFrame with 0 columns:
## geno(vcf):
##   List of length 1: GT
## geno(header(vcf)):
##       Number Type   Description
##    GT 1      String Genotype
```

```
locateVariants(vcf, txdb, CodingVariants())
```

```
## GRanges object with 524 ranges and 9 metadata columns:
##       seqnames               ranges strand | LOCATION  LOCSTART    LOCEND   QUERYID        TXID         CDSID
##          <Rle>            <IRanges>  <Rle> | <factor> <integer> <integer> <integer> <character> <IntegerList>
##     1    chr22 [17071862, 17071862]      - |   coding      1579      1579       128       74436        216505
##     2    chr22 [17073170, 17073170]      - |   coding       271       271       129       74436        216505
##     3    chr22 [17589225, 17589225]      + |   coding      1116      1116       377       73481        214034
##     4    chr22 [17601466, 17601466]      - |   coding       552       552       382       74444        216522
##     5    chr22 [17629357, 17629357]      - |   coding       424       424       394       74446        216528
##   ...      ...                  ...    ... .      ...       ...       ...       ...         ...           ...
##   520    chr22 [29913278, 29913278]      - |   coding      1567      1567      7023       74771        217273
##   521    chr22 [29924156, 29924156]      - |   coding       977       977      7030       74768        217279
##   522    chr22 [29924156, 29924156]      - |   coding       977       977      7030       74769        217279
##   523    chr22 [29924156, 29924156]      - |   coding       977       977      7030       74770        217279
##   524    chr22 [29924156, 29924156]      - |   coding       977       977      7030       74771        217279
##            GENEID       PRECEDEID        FOLLOWID
##       <character> <CharacterList> <CharacterList>
##     1      150160
##     2      150160
##     3       23765
##     4       27439
##     5       27440
##   ...         ...             ...             ...
##   520        8563
##   521        8563
##   522        8563
##   523        8563
##   524        8563
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

.

.

.

.

.

.

.

# 3 Integration with SeqVarTools

The [SeqVarTools](http://www.bioconductor.org/packages/release/bioc/html/SeqVarTools.html) package is available on Bioconductor, which defines S4 classes and methods for other common operations and analyses on SeqArray datasets. The vignette of SeqVarTools is <http://www.bioconductor.org/packages/release/bioc/vignettes/SeqVarTools/inst/doc/SeqVarTools.pdf>.

## 3.1 Linear Regression

The SeqVarTools package extends SeqArray by providing methods for many tasks common to quality control and analysis of sequence data. Methods include: transition/transversion ratio, heterozygosity and homozygosity rates, singleton counts, Hardy-Weinberg equilibrium, Mendelian error checking, and linear and logistic regression. Additionally, SeqVarTools defines a new class to link the information present in the SeqArray file to additional sample and variant annotation provided by the user, such as sex and phenotype. One could select a subset of samples in a file and run a linear regression on all variants:

```
library(Biobase)
```

```
library(SeqVarTools)
```

```
data(KG_P1_SampData)
KG_P1_SampData
```

```
## An object of class 'AnnotatedDataFrame'
##   rowNames: 1 2 ... 1092 (1092 total)
##   varLabels: sample.id sex age phenotype
##   varMetadata: labelDescription
```

```
head(pData(KG_P1_SampData))  # show KG_P1_SampData
```

```
##   sample.id    sex age   phenotype
## 1   HG00096   male  55 -0.65582105
## 2   HG00097 female  34  1.28337670
## 3   HG00099 female  39  0.05563847
## 4   HG00100 female  62  0.11139003
## 5   HG00101   male  60  0.34933331
## 6   HG00102 female  28  0.36536723
```

```
# link sample data to SeqArray file
seqData <- SeqVarData(file, sample.data)

# set sample and variant filters
female <- sampleData(seqData)$sex == "female"
seqSetFilter(seqData, sample.sel=female)

# run linear regression
res <- regression(seqData, outcome="phenotype", covar="age")
head(res)
```

```
##   variant.id   n      freq          Est        SE   Wald.Stat  Wald.Pval
## 1          1 567 0.6887125 -0.090555715 0.0699074 1.677974724 0.19519378
## 2          2 567 0.9400353  0.009685877 0.1321824 0.005369459 0.94158602
## 3          3 567 0.9991182 -0.378945215 1.0238102 0.136997920 0.71128392
## 4          4 567 1.0000000           NA        NA          NA         NA
## 5          5 567 0.9356261 -0.009732930 0.1281883 0.005764880 0.93947733
## 6          6 567 0.9982363 -1.379486822 0.7233651 3.636804912 0.05651529
```

.

.

.

.

.

.

.

# 4 Integration with SNPRelate

Parallel implementations of relatedness and principal component analysis with SeqArray format are enabled in the package SNPRelate, to detect and adjust for population structure and cryptic relatedness in association studies. The kernel of SNPRelate was optimized with SIMD instructions and multi-thread algorithms, and it was designed for bi-allelic SNP data originally (Zheng et al. 2012). In order to analyze sequence variant calls, and SNPRelate has been rewritten to take the dosages of reference alleles as an input genotype matrix with distinct integers 0, 1, 2 and NA for SeqArray files. Therefore no format conversion is required for WGS analyses.

Principal component analysis is implemented in the SNPRelate function `snpgdsPCA()`, and the exact and new randomized algorithms are both provided (Patterson, Price, and Reich 2006; Galinsky et al. 2016). The randomized matrix algorithm is designed to reduce the running time for large number of study individuals (e.g., greater than 10,000 samples). Relatedness analyses include PLINK method of moment (MoM), KING robust methods, GCTA genetic relationship matrix (GRM) and individual-perspective beta estimator (Purcell et al. 2007; Manichaikul et al. 2010; “GCTA: A Tool for Genome-Wide Complex Trait Analysis.” 2011; Weir and Zheng 2015), and these algorithms are computationally efficient and optimized with SIMD instructions. In addition, fixation index (\(F\_\text{st}\)) has been widely used to measure the genetic difference between populations, and the calculations of moment estimators are available in the SNPRelate package with all variants or a sliding window (Weir and Cockerham 1984; Weir and Hill 2002; Weir et al. 2005).

## 4.1 LD-based Marker Pruning

It is suggested to perform marker pruning before running PCA and IBD analyses on WGS variant data, to reduce the influence of linkage disequilibrium and rare variants.

```
library(SNPRelate)
```

```
## SNPRelate -- supported by Streaming SIMD Extensions 2 (SSE2)
```

```
set.seed(1000)

# may try different LD thresholds for sensitivity analysis
snpset <- snpgdsLDpruning(file, ld.threshold=0.2, maf=0.01)
```

```
## SNV pruning based on LD:
## Calculating allele counts/frequencies (19773 variants) ...
## [..................................................]  0%, ETC: --- (1/1)    [==================================================] 100%, used 0s (1/1)    [==================================================] 100%, complete, 0s
## # of selected variants: 7,028
## Excluding 12,745 SNVs (monomorphic: TRUE, MAF: 0.01, missing rate: 0.01)
##     # of samples: 1,092
##     # of SNVs: 7,028
##     using 1 thread/core
##     sliding window: 500,000 basepairs, Inf SNPs
##     |LD| threshold: 0.2
##     method: composite
## Chrom 22: |====================|====================|
##     10.19%, 2,014 / 19,773 (Thu Jan 29 21:06:27 2026)
## 2,014 markers are selected in total.
```

```
names(snpset)
```

```
## [1] "chr22"
```

```
head(snpset$chr22)  # variant.id
```

```
## [1]  1  8  9 10 12 16
```

```
# get all selected variant id
snpset.id <- unlist(snpset)
```

## 4.2 Principal Component Analysis

```
# Run PCA
pca <- snpgdsPCA(file, snp.id=snpset.id, num.thread=2)
```

```
## Principal Component Analysis (PCA) on genotypes:
## Calculating allele counts/frequencies (2014 variants) ...
## [..................................................]  0%, ETC: --- (1/6)    [==================================================] 100%, used 0s (1/6)    [..................................................]  0%, ETC: --- (2/6)    [..................................................]  0%, ETC: --- (3/6)    [==================================================] 100%, used 0s (2/6)    [==================================================] 100%, used 0s (3/6)    [==================================================] 100%, used 0s (4/6)    [..................................................]  0%, ETC: --- (5/6)    [==================================================] 100%, used 0s (5/6)    [==================================================] 100%, used 0s (6/6)    [==================================================] 100%, complete, 0s
## # of selected variants: 2,014
##     # of samples: 1,092
##     # of SNVs: 2,014
##     using 2 threads/cores
##     # of principal components: 32
## CPU capabilities: Double-Precision SSE2
## 2026-01-29 21:06:28    (internal increment: 2844)
## [..................................................]  0%, ETC: ---        [==================================================] 100%, completed, 0s
## 2026-01-29 21:06:28    Begin (eigenvalues and eigenvectors)
## 2026-01-29 21:06:29    Done.
```

```
# variance proportion (%)
pc.percent <- pca$varprop*100
head(round(pc.percent, 2))
```

```
## [1] 4.17 2.65 0.70 0.60 0.47 0.41
```

```
# plot the first 4 eigenvectors with character=20 and size=0.5
plot(pca, eig=1:4, pch=20, cex=0.5)
```

![](data:image/png;base64...)

Population information are available:

```
pop.code <- factor(seqGetData(file, "sample.annotation/Population"))
head(pop.code)
```

```
## [1] GBR GBR GBR GBR GBR GBR
## Levels: ASW CEU CHB CHS CLM FIN GBR IBS JPT LWK MXL PUR TSI YRI
```

```
popgroup <- list(
    EastAsia = c("CHB", "JPT", "CHS", "CDX", "KHV", "CHD"),
    European = c("CEU", "TSI", "GBR", "FIN", "IBS"),
    African  = c("ASW", "ACB", "YRI", "LWK", "GWD", "MSL", "ESN"),
    SouthAmerica = c("MXL", "PUR", "CLM", "PEL"),
    India = c("GIH", "PJL", "BEB", "STU", "ITU"))

colors <- sapply(levels(pop.code), function(x) {
    for (i in 1:length(popgroup)) {
        if (x %in% popgroup[[i]])
            return(names(popgroup)[i])
    }
    NA
    })
colors <- as.factor(colors)
legend.text <- sapply(levels(colors), function(x) paste(levels(pop.code)[colors==x], collapse=","))
legend.text
```

```
##               African              EastAsia              European          SouthAmerica
##         "ASW,LWK,YRI"         "CHB,CHS,JPT" "CEU,FIN,GBR,IBS,TSI"         "CLM,MXL,PUR"
```

```
# make a data.frame
tab <- data.frame(sample.id = pca$sample.id,
    EV1 = pca$eigenvect[,1],    # the first eigenvector
    EV2 = pca$eigenvect[,2],    # the second eigenvector
    Population = pop.code, stringsAsFactors = FALSE)
head(tab)
```

```
##   sample.id        EV1        EV2 Population
## 1   HG00096 0.01300336 0.03432677        GBR
## 2   HG00097 0.01194089 0.02977460        GBR
## 3   HG00099 0.01109778 0.02788650        GBR
## 4   HG00100 0.01563469 0.03185198        GBR
## 5   HG00101 0.01031886 0.02887336        GBR
## 6   HG00102 0.01510305 0.03243198        GBR
```

```
# draw
plot(pca, pch=20, cex=0.75, main="1KG Phase 1, chromosome 22", col=colors[tab$Population])
legend("topright", legend=legend.text, col=1:length(legend.text), pch=19, cex=0.75)
```

![](data:image/png;base64...)

## 4.3 Relatedness Analysis

For relatedness analysis, Identity-By-Descent (IBD) estimation in [SNPRelate](http://www.bioconductor.org/packages/release/bioc/html/SNPRelate.html) can be done by the method of moments (MoM) (Purcell et al. 2007).

```
# YRI samples
sample.id <- seqGetData(file, "sample.id")
CEU.id <- sample.id[pop.code == "CEU"]
```

```
# Estimate IBD coefficients
ibd <- snpgdsIBDMoM(file, sample.id=CEU.id, snp.id=snpset.id, num.thread=2)
```

```
## IBD analysis (PLINK method of moment) on genotypes:
## Calculating allele counts/frequencies (2014 variants) ...
## [..................................................]  0%, ETC: --- (1/6)    [==================================================] 100%, used 0s (1/6)    [..................................................]  0%, ETC: --- (2/6)    [==================================================] 100%, used 0s (2/6)    [..................................................]  0%, ETC: --- (3/6)    [==================================================] 100%, used 0s (3/6)    [==================================================] 100%, used 0s (4/6)    [..................................................]  0%, ETC: --- (5/6)    [==================================================] 100%, used 0s (5/6)    [==================================================] 100%, used 0s (6/6)    [==================================================] 100%, complete, 0s
## # of selected variants: 1,391
## Excluding 623 SNVs (monomorphic: TRUE, MAF: NaN, missing rate: 0.01)
##     # of samples: 85
##     # of SNVs: 1,391
##     using 2 threads/cores
## 2026-01-29 21:06:31    (internal increment: 65536)
## [..................................................]  0%, ETC: ---        [==================================================] 100%, completed, 1s
## 2026-01-29 21:06:32    Done.
```

```
# Make a data.frame
ibd.coeff <- snpgdsIBDSelection(ibd)
head(ibd.coeff)
```

```
##       ID1     ID2        k0         k1    kinship
## 1 NA06984 NA06986 0.8651157 0.13488434 0.03372109
## 2 NA06984 NA06989 1.0000000 0.00000000 0.00000000
## 3 NA06984 NA06994 0.9073457 0.09265426 0.02316357
## 4 NA06984 NA07000 1.0000000 0.00000000 0.00000000
## 5 NA06984 NA07037 1.0000000 0.00000000 0.00000000
## 6 NA06984 NA07048 1.0000000 0.00000000 0.00000000
```

```
plot(ibd.coeff$k0, ibd.coeff$k1, xlim=c(0,1), ylim=c(0,1), xlab="k0", ylab="k1", main="CEU samples (MoM)")
lines(c(0,1), c(1,0), col="red", lty=2)
```

![](data:image/png;base64...)

## 4.4 Identity-By-State Analysis

For \(n\) study individuals, `snpgdsIBS()` can be used to create a \(n \times n\) matrix of genome-wide average IBS pairwise identities. To perform cluster analysis on the \(n \times n\) matrix of genome-wide IBS pairwise distances, and determine the groups by a permutation score:

```
set.seed(1000)
ibs.hc <- snpgdsHCluster(snpgdsIBS(file, snp.id=snpset.id, num.thread=2))
```

```
## Identity-By-State (IBS) analysis on genotypes:
## Calculating allele counts/frequencies (2014 variants) ...
## [..................................................]  0%, ETC: --- (1/6)    [==================================================] 100%, used 0s (1/6)    [..................................................]  0%, ETC: --- (2/6)    [..................................................]  0%, ETC: --- (3/6)    [==================================================] 100%, used 0s (2/6)    [==================================================] 100%, used 0s (3/6)    [==================================================] 100%, used 0s (4/6)    [..................................................]  0%, ETC: --- (5/6)    [==================================================] 100%, used 0s (5/6)    [==================================================] 100%, used 0s (6/6)    [==================================================] 100%, complete, 0s
## # of selected variants: 2,014
##     # of samples: 1,092
##     # of SNVs: 2,014
##     using 2 threads/cores
## 2026-01-29 21:06:32    (internal increment: 65536)
## [..................................................]  0%, ETC: ---        [==================================================] 100%, completed, 2s
## 2026-01-29 21:06:34    Done.
```

Here is the population information we have known:

```
# Determine groups of individuals by population information
rv <- snpgdsCutTree(ibs.hc, samp.group=as.factor(colors[pop.code]))
```

```
## Create 4 groups.
```

```
plot(rv$dendrogram, leaflab="none", main="1KG Phase 1, chromosome 22",
    edgePar=list(col=rgb(0.5,0.5,0.5,0.75), t.col="black"))
legend("bottomleft", legend=legend.text, col=1:length(legend.text), pch=19, cex=0.75, ncol=4)
```

![](data:image/png;base64...)

## 4.5 Fixation Index (\(F\_\text{st}\))

Fixation index (Fst) has been widely used to measure the genetic difference between populations, and the calculations of moment estimators are available in the SNPRelate package with all variants or a sliding window.

```
# sliding windows (window size: 500kb)
sw <- snpgdsSlidingWindow(file, winsize=500000, shift=100000,
    FUN="snpgdsFst", as.is="numeric", population=pop.code)
```

```
## Sliding Window Analysis:
## Calculating allele counts/frequencies (19773 variants) ...
## [..................................................]  0%, ETC: --- (1/1)    [==================================================] 100%, used 0s (1/1)    [==================================================] 100%, complete, 0s
## # of selected variants: 19,651
## Excluding 122 SNVs (monomorphic: TRUE, MAF: NaN, missing rate: NaN)
##     # of samples: 1,092
##     # of SNVs: 19,651
##     using 1 thread/core
##     window size: 500000, shift: 100000 (basepair)
## Method: Weir & Cockerham, 1984
## # of Populations: 14
##     ASW (61), CEU (85), CHB (97), CHS (100), CLM (60), FIN (93), GBR (89), IBS (14), JPT (89), LWK (97), MXL (66), PUR (55), TSI (98), YRI (88)
## Chromosome Set: 22
## Thu Jan 29 21:06:36 2026, Chromosome 22 (19651 SNPs), 348 windows
## [..................................................]  0%, ETC: ---        [==================================================] 100%, completed, 12s
## Thu Jan 29 21:06:48 2026     Done.
```

```
plot(sw$chr22.pos/1000, sw$chr22.val, xlab="genome coordinate (kb)", ylab="population-average Fst",
    main="1KG Phase 1, chromosome 22")
abline(h=mean(sw$chr22.val), lty=3, col="red", lwd=2)
```

![](data:image/png;base64...)

.

.

.

.

.

.

.

# 5 GENESIS

The [GENESIS](http://www.bioconductor.org/packages/GENESIS) package offers methodology for estimating and accounting for population and pedigree structure in genetic analyses. The current implementation provides functions to perform PC-AiR and PC-Relate (Conomos, Miller, and Thornton 2015; Conomos et al. 2016). PC-AiR performs PCA on whole-genome genotypes taking into account known or cryptic relatedness in the study sample. PC-Relate uses ancestry representative principal components to estimate measures of recent genetic relatedness. In addition, GENESIS includes support for SeqArray files in mixed model association testing and aggregate tests of rare variants like burden and SKAT tests.

.

.

.

.

.

.

.

# 6 Resources

1. gdsfmt R package: <https://github.com/zhengxwen/gdsfmt>, <http://bioconductor.org/packages/gdsfmt>
2. SeqArray R package: <https://github.com/zhengxwen/SeqArray>, <http://bioconductor.org/packages/SeqArray>
3. SeqVarTools R package: <http://bioconductor.org/packages/SeqVarTools>
4. SNPRelate R package: <https://github.com/zhengxwen/SNPRelate>, <http://bioconductor.org/packages/SNPRelate>
5. GENESIS R package: <http://bioconductor.org/packages/GENESIS>

# 7 Session Information

```
seqClose(file)
```

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] SNPRelate_1.44.0            VariantAnnotation_1.56.0    Rsamtools_2.26.0
##  [4] Biostrings_2.78.0           XVector_0.50.0              SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.1        IRanges_2.44.0
## [10] S4Vectors_0.48.0            Seqinfo_1.0.0               MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocGenerics_0.56.0         generics_0.1.4
## [16] Rcpp_1.1.1                  SeqArray_1.50.1             gdsfmt_1.46.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0          rjson_0.2.23             xfun_0.56                bslib_0.10.0
##  [5] lattice_0.22-7           vctrs_0.7.1              tools_4.5.2              bitops_1.0-9
##  [9] curl_7.0.0               parallel_4.5.2           AnnotationDbi_1.72.0     RSQLite_2.4.5
## [13] blob_1.3.0               Matrix_1.7-4             BSgenome_1.78.0          cigarillo_1.0.0
## [17] lifecycle_1.0.5          compiler_4.5.2           RhpcBLASctl_0.23-42      codetools_0.2-20
## [21] htmltools_0.5.9          sass_0.4.10              RCurl_1.98-1.17          yaml_2.3.12
## [25] crayon_1.5.3             jquerylib_0.1.4          BiocParallel_1.44.0      DelayedArray_0.36.0
## [29] cachem_1.1.0             abind_1.4-8              digest_0.6.39            restfulr_0.0.16
## [33] fastmap_1.2.0            grid_4.5.2               cli_3.6.5                SparseArray_1.10.8
## [37] S4Arrays_1.10.1          GenomicFeatures_1.62.0   XML_3.99-0.20            bit64_4.6.0-1
## [41] rmarkdown_2.30           httr_1.4.7               bit_4.6.0                otel_0.2.0
## [45] png_0.1-8                memoise_2.0.1            evaluate_1.0.5           knitr_1.51
## [49] BiocIO_1.20.0            rtracklayer_1.70.1       rlang_1.1.7              DBI_1.2.3
## [53] jsonlite_2.0.0           R6_2.6.1                 GenomicAlignments_1.46.0
```

# References

Conomos, Matthew P., Michael B. Miller, and Timothy A. Thornton. 2015. “Robust Inference of Population Structure for Ancestry Prediction and Correction of Stratification in the Presence of Relatedness.” *Genetic Epidemiology* 39 (4): 276–93. <https://doi.org/10.1002/gepi.21896>.

Conomos, Matthew P., Alexander P. Reiner, Bruce S. Weir, and Timothy A. Thornton. 2016. “Model-Free Estimation of Recent Genetic Relatedness.” *American Journal of Human Genetics* 98 (1): 127–48. <https://doi.org/10.1016/j.ajhg.2015.11.022>.

Eddelbuettel, Dirk, Romain François, J Allaire, John Chambers, Douglas Bates, and Kevin Ushey. 2011. “Rcpp: Seamless R and C++ Integration.” *Journal of Statistical Software* 40 (8): 1–18.

Galinsky, Kevin J., Gaurav Bhatia, Po-Ru Loh, Stoyan Georgiev, Sayan Mukherjee, Nick J. Patterson, and Alkes L. Price. 2016. “Fast Principal-Component Analysis Reveals Convergent Evolution of ADH1B in Europe and East Asia.” *American Journal of Human Genetics* 98 (3): 456–72. <https://doi.org/10.1016/j.ajhg.2015.12.022>.

“GCTA: A Tool for Genome-Wide Complex Trait Analysis.” 2011. *American Journal of Human Genetics* 88 (1): 76–82. <https://doi.org/10.1016/j.ajhg.2010.11.011>.

Gentleman, Robert C., Vincent J. Carey, Douglas M. Bates, Ben Bolstad, Marcel Dettling, Sandrine Dudoit, Byron Ellis, et al. 2004. “Bioconductor: Open Software Development for Computational Biology and Bioinformatics.” *Genome Biology* 5 (10): 1–16. <https://doi.org/10.1186/gb-2004-5-10-r80>.

Lawrence, Michael, Wolfgang Huber, Hervé Pagès, Patrick Aboyoun, Marc Carlson, Robert Gentleman, Martin T. Morgan, and Vincent J. Carey. 2013. “Software for Computing and Annotating Genomic Ranges.” *PLoS Computational Biology* 9 (8): e1003118. <https://doi.org/10.1371/journal.pcbi.1003118>.

Manichaikul, Ani, Josyf C. Mychaleckyj, Stephen S. Rich, Kathy Daly, Michèle Sale, and Wei-Min Chen. 2010. “Robust Relationship Inference in Genome-Wide Association Studies.” *Bioinformatics (Oxford, England)* 26 (22): 2867–73. <https://doi.org/10.1093/bioinformatics/btq559>.

Obenchain, Valerie, Michael Lawrence, Vincent Carey, Stephanie Gogarten, Paul Shannon, and Martin Morgan. 2014. “VariantAnnotation: A Bioconductor Package for Exploration and Annotation of Genetic Variants.” *Bioinformatics (Oxford, England)* 30 (14): 2076–8. <https://doi.org/10.1093/bioinformatics/btu168>.

Patterson, N, A L Price, and D Reich. 2006. “Population Structure and Eigenanalysis.” *PLoS Genet* 2 (12). <https://doi.org/10.1371/journal.pgen.0020190>.

Purcell, S, B Neale, K Todd-Brown, L Thomas, M A Ferreira, D Bender, J Maller, et al. 2007. “PLINK: A Tool Set for Whole-Genome Association and Population-Based Linkage Analyses.” *Am J Hum Genet* 81 (3): 559–75. <https://doi.org/10.1086/519795>.

R Core Team. 2016. “R: A Language and Environment for Statistical Computing.”

Rossini, A. J, Luke Tierney, and Na Li. 2007. “Simple Parallel Statistical Computing in R.” *Journal of Computational and Graphical Statistics* 16 (2): 399–420. <https://doi.org/10.1198/106186007X178979>.

Weir, Bruce S., Lon R. Cardon, Amy D. Anderson, Dahlia M. Nielsen, and William G. Hill. 2005. “Measures of Human Population Structure Show Heterogeneity Among Genomic Regions.” *Genome Research* 15 (11): 1468–76. <https://doi.org/10.1101/gr.4398405>.

Weir, Bruce S, and Xiuwen Zheng. 2015. “SNPs and SNVs in Forensic Science.” *Forensic Science International: Genetics Supplement Series* 5: e267–e268.

Weir, B. S., and C. Clark Cockerham. 1984. “Estimating F-Statistics for the Analysis of Population Structure.” *Evolution* 38 (6): pp. 1358–70. <https://onlinelibrary.wiley.com/doi/10.1111/j.1558-5646.1984.tb05657.x>.

Weir, B S, and W G Hill. 2002. “Estimating F-Statistics.” *Annu Rev Genet* 36: 721–50. <https://doi.org/10.1146/annurev.genet.36.050802.093940>.

Zheng, Xiuwen, David Levine, Jess Shen, Stephanie M. Gogarten, Cathy Laurie, and Bruce S. Weir. 2012. “A High-Performance Computing Toolset for Relatedness and Principal Component Analysis of Snp Data.” *Bioinformatics (Oxford, England)* 28 (24): 3326–8. <https://doi.org/10.1093/bioinformatics/bts606>.