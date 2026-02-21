# RNAAgeCalc: A multi-tissue transcriptional age calculator

#### Xu Ren and Pei Fen Kuan

#### 2025-10-30

* [Installation](#installation)
* [Introduction](#introduction)
* [Description of RNASeq age calculator](#description-of-rnaseq-age-calculator)
* [Usage of RNASeq age calculator](#usage-of-rnaseq-age-calculator)
  + [Options in predict\_age function](#options-in-predict_age-function)
  + [Options in predict\_age\_fromse function](#options-in-predict_age_fromse-function)
* [Visualization](#visualization)
* [Session info](#session-info)
* [References](#references)

## Installation

To install and load RNAAgeCalc

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RNAAgeCalc")
```

```
library(RNAAgeCalc)
```

## Introduction

It has been shown that both DNA methylation and RNA transcription are linked to chronological age and age related diseases. Several estimators have been developed to predict human aging from DNA level and RNA level. Most of the human transcriptional age predictor are based on microarray data and limited to only a few tissues. To date, transcriptional studies on aging using RNASeq data from different human tissues is limited. The aim of this package is to provide a tool for across-tissue and tissue-specific transcriptional age calculation based on Genotype-Tissue Expression (GTEx) RNASeq data (Lonsdale et al. 2013).

## Description of RNASeq age calculator

We utilized the GTEx data to construct our across-tissue and tissue-specific transcriptional age calculator. GTEx is a public available genetic database for studying tissue specific gene expression and regulation. GTEx V6 release contains gene expression data at gene, exon, and transcript level of 9,662 samples from 30 different tissues. To avoid the influence of tumor on gene expression, the 102 tumor samples from GTEx V6 release are dropped and the remaining 9,560 samples were used in the subsequent analysis. To facilitate integrated analysis and direct comparison of multiple datasets, we utilized recount2 (Collado-Torres et al. 2017) version of GTEx data, where all samples were processed with the same analytical pipeline. FPKM values were calculated for each individual sample using `getRPKM` function in Bioconductor package [recount](http://bioconductor.org/packages/release/bioc/html/recount.html).

For the tissue-specific RNASeq age calculator, elastic net (Zou and Hastie 2005) algorithm was used to train the predictors for each individual tissue. Chronological age was response variable whereas logarithm transformed FPKM of genes were predictors. The across-tissue calculator was constructed by first performing differential expression analysis on the RNASeq counts data for each individual tissue. To identify genes consistently differentially expressed across tissues, we adapted the binomial test discussed in de Magalhaes et al. (De Magalhães, Curado, and Church 2009) to find the genes with the largest number of age-related signals. A detailed explanation can be found in our paper.

The package is implemented as follows. For each tissue, signature and sample type (see below for the descriptions), we pre-trained the calculator using elastic net based on the GTEx samples. We saved the pre-trained model coefficients as internal data in the package. The package takes gene expression data as input and then match the input genes to the genes in the internal data. This matching process is automatic so that the users just need to provide gene expression data without having to pull out the internal coefficients.

## Usage of RNASeq age calculator

The main functions to calculate RNASeq age are `predict_age` and `predict_age_fromse`. Users can use either of them. `predict_age` function takes data frame as input whereas `predict_age_fromse` function takes [SummarizedExperiment](https://bioconductor.org/packages/SummarizedExperiment) as input. Both functions work in the same way internally. In this section, we explain the arguments in `predict_age` and `predict_age_fromse` respectively.

### Options in predict\_age function

#### exprdata

`exprdata` is a matrix or data frame which contains gene expression data with each row represents a gene and each column represents a sample. Users are expected to use the argument `exprtype` to specify raw count or FPKM (see below). The rownames of `exprdata` should be gene ids and colnames of `exprdata` should be sample ids. Here is an example of FPKM expression data:

```
data(fpkmExample)
head(fpkm)
```

```
        SRR2166176 SRR2167642
AFF4     23.478648 21.7803347
ZGLP1     1.880514  2.6874455
CHDH      6.062126  5.9185735
MIR6801   0.000000  0.3882558
ZFP90     6.478456  7.1444598
KDM6B     5.849882  5.1937368
```

#### tissue

`tissue` is a string indicates which tissue the gene expression data is obtained from. Users are expected to provide one of the following tissues. If the tissue argument is not provide or the provided tissue is not in this list, the age predictor trained on all tissues will be used to calculate RNA age.

* adipose\_tissue
* adrenal\_gland
* blood
* blood\_vessel
* brain
* breast
* colon
* esophagus
* heart
* liver
* lung
* muscle
* nerve
* ovary
* pancreas
* pituitary
* prostate
* salivary\_gland
* skin
* small\_intestine
* spleen
* stomach
* testis
* thyroid
* uterus
* vagina

#### exprtype

`exprtype` is either “counts” or “FPKM”. If `exprtype` is counts, the expression data will be converted to FPKM by `count2FPKM` automatically and the calculator will be applied on FPKM data. When calculating FPKM, by default gene length is obtained from the package’s internal database. The internal gene length information was obtained from recount2. However, users are able to provide their own gene length information by using `genelength` argument (see below).

#### idtype

`idtype` is a string which indicates the gene id type in `exprdata`. Default is “SYMBOL”. The following id types are supported.

* SYMBOL
* ENSEMBL
* ENTREZID
* REFSEQ

#### stype

`stype` is a string which specifies which version of pre-trained calculators to be used. Two versions are provided. If `stype="all"`, the calculator trained on samples from all races (American Indian/Alaska Native, Asian, Black/African American, and Caucasian) will be used. If `stype="Caucasian"`, the calculator trained on Caucasian samples only will be used. We found that RNA Age signatures could be different in different races (see our paper for details). Thus we provide both the universal calculator and race specific calculator. The race specific calculator for American Indian/Alaska Native, Asian, or Black/African American are not provided due to the small sample size in GTEx data.

#### signature

`signature` is a string which indicate the age signature to use when calculating RNA age. This argument is not required.

In the case that this argument is not provided, if `tissue` argument is also provided and the tissue is in the list above, the tissue specific age signature given by our DESeq2 analysis result on GTEx data will be used. Otherwise, the across tissue signature “GTExAge” will be used.

In the case that this argument is provided, it should be one of the following signatures.

* DESeq2. DESeq2 signature was obtained by performing differential expression analysis on each tissue and select the top differential expressed genes.
* Pearson. Pearson signature represents the genes highly correlated with chronological age by Pearson correlation.
* Dev. Dev signature contains genes with large variation in expression across samples. We adapted the gene selection strategy discussed in (Fleischer et al. 2018), which is a gene must have at least a \(t\_1\)-fold difference in expression between any two samples in the training set and at least one sample have expression level > \(t\_2\) FPKM to be included in the prediction models. \(t\_1\) and \(t\_2\) (typically 5 or 10) are thresholds to control the degree of deviance of the genes. We used \(t\_1\) = \(t\_2\) = 10 for most tissues. For some tissues with large sample size, in order to maximize the prediction accuracy while maintaining low computation cost, we increased \(t\_1\) and \(t\_2\) such that the number of genes retained in the model is between 2,000 and 7,000.
* deMagalhaes. deMagalhaes signature contains the 73 age-related genes by (De Magalhães, Curado, and Church 2009).
* GenAge. GenAge signature contains the 307 age-related genes in the Ageing Gene Database (Tacutu et al. 2017).
* GTExAge. GTExAge signature represents the genes consistently differentially expressed across tissues discussed in our paper.
* Peters. Peters signature contains the 1,497 genes differentially expressed with age discussed in (Peters et al. 2015).
* all. “all” represents all the genes used when constructing the RNAAge calculator.

If the genes in `exprdata` do not cover all the genes in the signature, imputation will be made automatically by the `impute.knn` function in Bioconductor package [impute](https://www.bioconductor.org/packages/release/bioc/html/impute.html).

#### genelength

`genelength` is a vector of gene length in bp. The size of `genelength` should be equal to the number of rows in `exprdata`. This argument is optional. When using `exprtype = "FPKM"`, `genelength` argument is ignored. When using `exprtype = "counts"`, the raw count will be converted to FPKM. If `genelength` is provided, the function will convert raw count to FPKM based on the user-supplied gene length. Otherwise, gene length is obtained from the internal database.

#### chronage

`chronage` is a data frame which contains the chronological age of each sample. This argument is optional.

If provided, it should be a dataframe with 1st column sample id and 2nd column chronological age. The sample order in `chronage` doesn’t have to be in the same order as in `exprdata`. However, the samples in `chronage` and `exprdata` should be the same. If some samples’ chronological age are not available, users are expected to set the chronological age in `chronage` to NA. If `chronage` contains more than 2 columns, only the first 2 columns will be considered. If more than 30 samples’ chronological age are available, age acceleration residual will be calculated. Age acceleration residual is defined as the residual of linear regression with RNASeq age as dependent variable and chronological age as independent variable.

If this argument is not provided, the age acceleration residual will not be calculated.

#### Example

```
chronage = data.frame(sampleid = colnames(fpkm), age = c(30,50))
res = predict_age(exprdata = fpkm, tissue = "brain", exprtype = "FPKM",
                  chronage = chronage)
```

```
signature is not provided, using DESeq2 signature
automatically.
```

```
head(res)
```

```
             RNAAge ChronAge
SRR2166176 27.32436       30
SRR2167642 49.16285       50
```

In the above example, we calculated the RNASeq age for 2 samples based on their gene expression data coming from brain. Since the sample size is small, age acceleration residual are not calculated.
Here is an example with sample size > 30:

```
# This example is just for illustration purpose. It does not represent any
# real data.
# construct a large gene expression data
fpkm_large = cbind(fpkm, fpkm+1, fpkm+2, fpkm+3)
fpkm_large = cbind(fpkm_large, fpkm_large, fpkm_large, fpkm_large)
colnames(fpkm_large) = paste0("sample",1:32)
# construct the samples' chronological age
chronage2 = data.frame(sampleid = colnames(fpkm_large), age = 31:62)
res2 = predict_age(exprdata = fpkm_large, exprtype = "FPKM",
                  chronage = chronage2)
head(res2)
```

```
          RNAAge ChronAge AgeAccelResid
sample1 34.84154       31    -31.254133
sample2 49.77605       32    -16.909233
sample3 65.00385       33     -2.271030
sample4 76.91602       34      9.051533
sample5 82.66541       35     14.211328
sample6 93.07443       36     24.030742
```

### Options in predict\_age\_fromse function

The main difference between `predict_age_fromse` and `predict_age` is that `predict_age_fromse` takes SummarizedExperiment as input. The `se` argument is a SummarizedExperiment object.

* The `assays(se)` should contain gene expression data. The name of `assays(se)` should be either “FPKM” or “counts”. Use `exprtype` argument to specify the type of gene expression data provided.
* Users are able to provide the chronological age of samples using `colData(se)`. This is optional. If provided, the column name for chronological age in `colData(se)` should be “age”. If some samples’ chronological age are not available, users are expected to set the chronological age in `colData(se)` to NA. If chronological age is not provided, the age acceleration residual will not be calculated.
* Users are able to provide their own gene length using `rowData(se)`. This is also optional. If using `exprtype = "FPKM"`, the provided gene length will be ignored. If provided, the column name for gene length in `rowData(se)` should be “bp\_length”. The function will convert raw count to FPKM by the user-supplied gene length. Otherwise, gene length is obtained from the internal database.
* The other arguments `tissue`, `exprtype`, `idtype`, `stype`, `signature` are exactly the same as described in `predict_age` function.

#### Example

```
library(SummarizedExperiment)
colData = data.frame(age = c(40, 50))
se = SummarizedExperiment(assays=list(FPKM=fpkm), colData=colData)
res3 = predict_age_fromse(se = se, exprtype = "FPKM")
head(res3)
```

```
             RNAAge ChronAge
SRR2166176 34.84154       40
SRR2167642 49.77605       50
```

## Visualization

We suggest visualizing the results by plotting RNAAge vs chronological age. This can be done by calling `makeplot` function and passing in the data frame returned by `predict_age` function.

```
makeplot(res2)
```

![](data:image/png;base64...)

## Session info

```
sessionInfo()
```

```
R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4    stats     graphics  grDevices utils     datasets  methods
[8] base

other attached packages:
 [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
 [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
 [5] IRanges_2.44.0              S4Vectors_0.48.0
 [7] BiocGenerics_0.56.0         generics_0.1.4
 [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
[11] RNAAgeCalc_1.22.0

loaded via a namespace (and not attached):
  [1] RColorBrewer_1.1-3       rstudioapi_0.17.1        jsonlite_2.0.0
  [4] magrittr_2.0.4           GenomicFeatures_1.62.0   farver_2.1.2
  [7] rmarkdown_2.30           BiocIO_1.20.0            vctrs_0.6.5
 [10] memoise_2.0.1            Rsamtools_2.26.0         RCurl_1.98-1.17
 [13] base64enc_0.1-3          htmltools_0.5.8.1        S4Arrays_1.10.0
 [16] curl_7.0.0               SparseArray_1.10.0       Formula_1.2-5
 [19] sass_0.4.10              bslib_0.9.0              htmlwidgets_1.6.4
 [22] plyr_1.8.9               impute_1.84.0            cachem_1.1.0
 [25] GenomicAlignments_1.46.0 lifecycle_1.0.4          iterators_1.0.14
 [28] pkgconfig_2.0.3          Matrix_1.7-4             R6_2.6.1
 [31] fastmap_1.2.0            digest_0.6.37            colorspace_2.1-2
 [34] AnnotationDbi_1.72.0     Hmisc_5.2-4              RSQLite_2.4.3
 [37] org.Hs.eg.db_3.22.0      labeling_0.4.3           mgcv_1.9-3
 [40] httr_1.4.7               abind_1.4-8              compiler_4.5.1
 [43] rngtools_1.5.2           withr_3.0.2              downloader_0.4.1
 [46] bit64_4.6.0-1            recount_1.36.0           htmlTable_2.4.3
 [49] S7_0.2.0                 backports_1.5.0          BiocParallel_1.44.0
 [52] DBI_1.2.3                DelayedArray_0.36.0      rjson_0.2.23
 [55] derfinderHelper_1.44.0   tools_4.5.1              foreign_0.8-90
 [58] rentrez_1.2.4            nnet_7.3-20              glue_1.8.0
 [61] restfulr_0.0.16          nlme_3.1-168             grid_4.5.1
 [64] checkmate_2.3.3          derfinder_1.44.0         cluster_2.1.8.1
 [67] reshape2_1.4.4           gtable_0.3.6             BSgenome_1.78.0
 [70] tzdb_0.5.0               tidyr_1.3.1              data.table_1.17.8
 [73] hms_1.1.4                xml2_1.4.1               XVector_0.50.0
 [76] foreach_1.5.2            pillar_1.11.1            stringr_1.5.2
 [79] limma_3.66.0             splines_4.5.1            dplyr_1.1.4
 [82] lattice_0.22-7           rtracklayer_1.70.0       bit_4.6.0
 [85] GEOquery_2.78.0          tidyselect_1.2.1         locfit_1.5-9.12
 [88] Biostrings_2.78.0        knitr_1.50               gridExtra_2.3
 [91] xfun_0.53                statmod_1.5.1            stringi_1.8.7
 [94] UCSC.utils_1.6.0         yaml_2.3.10              evaluate_1.0.5
 [97] codetools_0.2-20         cigarillo_1.0.0          GenomicFiles_1.46.0
[100] tibble_3.3.0             qvalue_2.42.0            cli_3.6.5
[103] bumphunter_1.52.0        rpart_4.1.24             jquerylib_0.1.4
[106] dichromat_2.0-0.1        Rcpp_1.1.0               GenomeInfoDb_1.46.0
[109] png_0.1-8                XML_3.99-0.19            parallel_4.5.1
[112] ggplot2_4.0.0            readr_2.1.5              blob_1.2.4
[115] doRNG_1.8.6.2            bitops_1.0-9             VariantAnnotation_1.56.0
[118] scales_1.4.0             purrr_1.1.0              crayon_1.5.3
[121] rlang_1.1.6              KEGGREST_1.50.0
```

## References

Collado-Torres, Leonardo, Abhinav Nellore, Kai Kammers, Shannon E Ellis, Margaret A Taub, Kasper D Hansen, Andrew E Jaffe, Ben Langmead, and Jeffrey T Leek. 2017. “Reproducible Rna-Seq Analysis Using Recount2.” *Nature Biotechnology* 35 (4): 319.

De Magalhães, João Pedro, João Curado, and George M Church. 2009. “Meta-Analysis of Age-Related Gene Expression Profiles Identifies Common Signatures of Aging.” *Bioinformatics* 25 (7): 875–81.

Fleischer, Jason G, Roberta Schulte, Hsiao H Tsai, Swati Tyagi, Arkaitz Ibarra, Maxim N Shokhirev, Ling Huang, Martin W Hetzer, and Saket Navlakha. 2018. “Predicting Age from the Transcriptome of Human Dermal Fibroblasts.” *Genome Biology* 19 (1): 221.

Lonsdale, John, Jeffrey Thomas, Mike Salvatore, Rebecca Phillips, Edmund Lo, Saboor Shad, Richard Hasz, et al. 2013. “The Genotype-Tissue Expression (Gtex) Project.” *Nature Genetics* 45 (6): 580.

Peters, Marjolein J, Roby Joehanes, Luke C Pilling, Claudia Schurmann, Karen N Conneely, Joseph Powell, Eva Reinmaa, et al. 2015. “The Transcriptional Landscape of Age in Human Peripheral Blood.” *Nature Communications* 6: 8570.

Tacutu, Robi, Daniel Thornton, Emily Johnson, Arie Budovsky, Diogo Barardo, Thomas Craig, Eugene Diana, et al. 2017. “Human Ageing Genomic Resources: New and Updated Databases.” *Nucleic Acids Research* 46 (D1): D1083–D1090.

Zou, Hui, and Trevor Hastie. 2005. “Regularization and Variable Selection via the Elastic Net.” *Journal of the Royal Statistical Society: Series B (Statistical Methodology)* 67 (2): 301–20.