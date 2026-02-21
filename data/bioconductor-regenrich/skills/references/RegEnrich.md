# RegEnrich: an R package for gene regulator enrichment analysis

Weiyang Tao, Aridaman Pandit

#### 2025-10-30

#### Abstract

Changes in a few key transcriptional regulators can alter different gene expression leading to different biological states, including disease, cellular activation, and differentiation. Extracting the key gene regulators governing a biological state can allow us to gain mechanistic insights and can further help in translational research. Most current tools perform pathway/GO enrichment analysis to identify key genes and regulators but tend to overlook the regulatory interactions between genes and proteins. Here, we present RegEnrich, an open source R package, which generates data-driven gene regulatory networks and performs enrichment analysis to extract a network of key regulators. RegEnrich further allows users to integrate literature-based networks and multi-omics data to better understand the underlying biological mechanisms. RegEnrich package version: 1.20.0

# Contents

* [1 Introduction](#introduction)
* [2 A quick example](#a-quick-example)
  + [2.1 Including RegEnrich library](#including-regenrich-library)
  + [2.2 Initializing RegenrichSet object](#initializing-regenrichset-object)
  + [2.3 Runing four major steps and obtaining results](#runing-four-major-steps-and-obtaining-results)
* [3 RegenrichSet object initialization](#regenrichset-object-initialization)
  + [3.1 The RegenrichSet object](#the-regenrichset-object)
  + [3.2 Input data](#input-data)
    - [3.2.1 Expression data](#expression-data)
    - [3.2.2 Sample information](#sample-information)
    - [3.2.3 Regulators](#regulators)
  + [3.3 Other parameters](#other-parameters)
  + [3.4 Initializing RegenrichSet object](#initializing-regenrichset-object-1)
* [4 Differential expression analysis](#differential-expression-analysis)
  + [4.1 Use the parameters initialized in the RegenrichSet object](#use-the-parameters-initialized-in-the-regenrichset-object)
  + [4.2 Re-specify the parameters for differential expression analysis](#re-specify-the-parameters-for-differential-expression-analysis)
* [5 Regulator-target network inference](#regulator-target-network-inference)
  + [5.1 COEN (based on WGCNA)](#coen-based-on-wgcna)
  + [5.2 GRN (based on random forest)](#grn-based-on-random-forest)
  + [5.3 User defined network](#user-defined-network)
* [6 Enrichment analysis](#enrichment-analysis)
  + [6.1 Fisher’s exact test (FET)](#fishers-exact-test-fet)
  + [6.2 Gene set enrichment analysis (GSEA)](#gene-set-enrichment-analysis-gsea)
* [7 Regulator scoring and ranking](#regulator-scoring-and-ranking)
* [8 Case studies](#case-studies)
  + [8.1 Case 1: Microarray (single-channel) data](#case-1-microarray-single-channel-data)
    - [8.1.1 Background](#background)
    - [8.1.2 Reading the data](#reading-the-data)
    - [8.1.3 RegEnrich analysis](#regenrich-analysis)
  + [8.2 Case 2: RNAseq read count data](#case-2-rnaseq-read-count-data)
    - [8.2.1 Background](#background-1)
    - [8.2.2 Reading the data](#reading-the-data-1)
    - [8.2.3 RegEnrich analysis](#regenrich-analysis-1)
* [9 Session info](#session-info)
* [References](#references)

---

# 1 Introduction

This package is a pipeline to identify the key gene regulators in a biological
process, for example in cell differentiation and in cell development after stimulation.
Given gene expression data and sample information, there are four major
steps in this pipeline: (1) differential expression analysis; (2) regulator-target
network inference; (3) enrichment analysis; and (4) regulators scoring and ranking.

In this tutorial, we are showing you how to perform RegEnrich analysis by starting
with a quick example, followed by detailed explanation in each step and three case
studies.

---

# 2 A quick example

To illustrate how to use RegEnrich pipline, here we simply show the basic steps,
assuming you have had all input data and the parameters ready.

## 2.1 Including RegEnrich library

```
library(RegEnrich)
```

## 2.2 Initializing RegenrichSet object

```
object = RegenrichSet(expr = expressionMatrix, # expression data (matrix)
                      colData = sampleInfo, # sample information (data frame)
                      reg = regulators, # regulators
                      method = "limma", # differentila expression analysis method
                      design = designMatrix, # desing model matrix
                      contrast = contrast, # contrast
                      networkConstruction = "COEN", # network inference method
                      enrichTest = "FET") # enrichment analysis method
```

## 2.3 Runing four major steps and obtaining results

```
# Differential expression analysis
object = regenrich_diffExpr(object)
# Regulator-target network inference
object = regenrich_network(object)
# Enrichment analysis
object = regenrich_enrich(object)
# Regulator scoring and ranking
object = regenrich_rankScore(object)

# Obtaining results
res = results_score(object)
```

The code can be even simpler if pipe (`%>%`) is used.

```
# Perform 4 steps in RegEnrich analysis
object = regenrich_diffExpr(object) %>%
  regenrich_network() %>%
  regenrich_enrich() %>%
  regenrich_rankScore()

res = results_score(object)
```

---

# 3 RegenrichSet object initialization

## 3.1 The RegenrichSet object

RegEnrich package is programmed in a style of `S4` object system. The most fundamental class
in RegEnrich is `RegenrichSet`, and majority functions are working with this class in the
following analysis steps. So the `RegenrichSet` object must be initialized prior to RegEnrich
analysis. The `RegenrichSet` object can be easily initialized by `RegenrichSet` function, which
require several input data along with other parameters.

## 3.2 Input data

There are three fundamental input data for RegEnrich pipline.

### 3.2.1 Expression data

The first one is expression
data (`expr`), which is a table (`matrix`) with m rows (genes or proteins) and n columns (samples).
Here the expression data can be of genes, measured by microarray or
RNA sequencing, and can be of proteins, measured by mass spectrometry, etc.

Here we downloaded the gene expression data (RNA-sequencing data in FPKM format) that is from
(Bouquet et al. [2016](#ref-bouquet2016longitudinal)) in GEO database
([GSE63085](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE63085)). And
only 52 samples were included in `Lyme_GSE63085` dataset and can be loaded in the
following way.

```
data(Lyme_GSE63085)
FPKM = Lyme_GSE63085$FPKM
```

Althouth here RNA-sequencing data is reprensented in FPKM (Fragments Per Kilobase of
transcript per Million) format, we do recomment raw
read count format. To further work on this FPKM data, we convert the FPKM data (plus 1)
into logarithm to the base 2.

```
log2FPKM = log2(FPKM + 1)
print(log2FPKM[1:6, 1:5])
#>          GSM1540487 GSM1540488  GSM1540489 GSM1540490 GSM1540491
#> A1BG     0.20255689  0.1035833 0.252087406 0.18977776  0.0000000
#> A1BG-AS1 0.24372879  0.3816776 0.256499850 0.67166657  0.0000000
#> A1CF     0.01262565  0.0000000 0.018093311 0.03190273  0.0000000
#> A2M      0.49206032  0.5511636 0.832497953 0.63190517  0.7838539
#> A2M-AS1  1.42709122  1.4919608 1.483632648 1.71557274  2.0862607
#> A2ML1    0.00000000  0.0000000 0.007600189 0.00000000  0.0000000
```

### 3.2.2 Sample information

The second input data is sample information (`colData`), which is also a table (`data.frame`),
showing which samples (rows) belonging to which groups or having what features (columns).
Here we use the sample information for the 52 samples in `Lyme_GSE63085` dataset.

```
sampleInfo = Lyme_GSE63085$sampleInfo
head(sampleInfo)
#>            geo_accession    title source_name     organism patientID week      disease
#> GSM1540487    GSM1540487 01-20_V1       PBMCs Homo sapiens     01_20    0 Lyme disease
#> GSM1540488    GSM1540488 01-23_V1       PBMCs Homo sapiens     01_23    0 Lyme disease
#> GSM1540489    GSM1540489 01-24_V1       PBMCs Homo sapiens     01_24    0 Lyme disease
#> GSM1540490    GSM1540490 01-25_V1       PBMCs Homo sapiens     01_25    0 Lyme disease
#> GSM1540491    GSM1540491 01-26_V1       PBMCs Homo sapiens     01_26    0 Lyme disease
#> GSM1540492    GSM1540492 01-27_V1       PBMCs Homo sapiens     01_27    0 Lyme disease
#>                              description  molecule
#> GSM1540487 acute Lyme pre-treatment (V1) total RNA
#> GSM1540488 acute Lyme pre-treatment (V1) total RNA
#> GSM1540489 acute Lyme pre-treatment (V1) total RNA
#> GSM1540490 acute Lyme pre-treatment (V1) total RNA
#> GSM1540491 acute Lyme pre-treatment (V1) total RNA
#> GSM1540492 acute Lyme pre-treatment (V1) total RNA
```

### 3.2.3 Regulators

The third input is the regulators in the studied organisms. If the organism is human,
RegEnrich by default provided transcrpiton factors and co-factors in humans as the regulators
which are obtained from (Han et al. [2015](#ref-han2015trrust); Marbach et al. [2016](#ref-marbach2016tissue); and Liu et al. [2015](#ref-liu2015regnetwork)).

```
data(TFs)
head(TFs)
#>                              TF TF_name
#> ENSG00000001167 ENSG00000001167    NFYA
#> ENSG00000004848 ENSG00000004848     ARX
#> ENSG00000005007 ENSG00000005007    UPF1
#> ENSG00000005073 ENSG00000005073  HOXA11
#> ENSG00000005075 ENSG00000005075  POLR2J
#> ENSG00000005102 ENSG00000005102   MEOX1
```

You can define your own regulators in RegEnrich. For example, for the studies in other
organisms such as mouse, yeast, drosophila and arabidopsis thaliana, you can use the
transcription (co-)factors in the following links, and cite corresponding paper:

[*Mouse*](http://tools.sschmeier.com/tcof/home/),
[*Yeast*](http://www.yeastract.com/consensuslist.php),
[*Drosophila*](https://www.mrc-lmb.cam.ac.uk/genomes/FlyTF/old_index.html), and
[*Arabidopsis thaliana*](http://planttfdb.cbi.pku.edu.cn/index.php?sp=Ath)

But one thing to keep in mind, the type of names or IDs of regulators should be the same as
those of genes in the expression data. For example, if ENSEMBL gene ID is used in
the expression data, then the regulators should be represented by ENSEMBL gene ID as well.

## 3.3 Other parameters

In addition to previous 3 most fundamental input data, other parameters for RegEnrich
analysis can be initialized here as well. These parameters include 3 groups.

First, parameters to perform differential expression analysis, such as `method` (differential
test method), `minMeanExpr` (the threshold to remove the lowly expressed gene), `design`
(design model matrix or formula), `reduced` (reduced model matrix or formula), `contrast`
(to extract the coefficients in the model), etc.
Here we consider the effect of different patients and time (`week` in sample information
table) on gene expression. To identify the differential genes related to time, we can simply use
`LRT_LM` method (likelihood retio test on two linear model) to perfrom differential expression
analysis. So the corresponding parameters are defined by:

```
method = "LRT_LM"
# design and reduced formulae
design = ~ patientID + week
reduced = ~ patientID
```

Second, parameters to perform regulator-target network inference, such as `networkConstruction`
(network inference method), `topNetPercent` (what percentage of the top edges to retain), etc.
Here we use `COEN` method (weighted gene coexpression network) and other default parameters to
inference regulator-target network.

```
networkConstruction = "COEN"
```

Third, parameters to perform enrichment analysis, such as `enrichTest` (enrichment method),
`minSize` (minimum number of targets of regulator), etc.
Here we use `FET` method (Fisher’s exact test) and other default parameters to perform
enrichment analysis.

```
enrichTest = "FET"
```

The detailed explaination of these parameters can be found in the help page of `RegenrichSet`
function, which can be viewed by `?RegenrichSet`. Unlike expression data and sample information
data, these parameters can be re-specified in the later steps of RegEnrich analysis.

## 3.4 Initializing RegenrichSet object

To reduce the running time, we consider the first 2000 genes, and remove genes
with mean log2FPKM <= 0.01.

```
object = RegenrichSet(expr = log2FPKM[1:2000, ],
                      colData = sampleInfo,
                      method = "LRT_LM",
                      minMeanExpr = 0.01,
                      design = ~ patientID + week,
                      reduced = ~ patientID,
                      networkConstruction = "COEN",
                      enrichTest = "FET")
print(object)
#> RegenrichSet object
#>  assayData: 1720 rows, 52 columns (filtered 280 rows by average expression <= 0.01)
#>  Differential expression analysis needs to be performed.
```

---

# 4 Differential expression analysis

In this step, the major goal is to obtain differential p-values and log2 fold changes of gene
expression between different conditions. There are couple of packages being developed to perform
differential expression analysis, such as
[DESeq2](http://bioconductor.org/packages/SESeq2),
[edgeR](http://bioconductor.org/packages/edgeR),
[limma](http://bioconductor.org/packages/limma),
[DSS](http://bioconductor.org/packages/DSS),
[EBSeq](http://bioconductor.org/packages/EBSeq), and
[baySeq](http://bioconductor.org/packages/baySeq).
The full tutorials of these packages have been already provided as vignettes or other documentation in
these packages. Here, we provide a wraper function, `regenrich_diffExpr`, which allows you to choose
either “Wald\_DESeq2”, “LRT\_DESeq2”, “limma”, or “LRT\_LM” to perform the differential expression analysis
on the `RegenrichSet` obejct.

## 4.1 Use the parameters initialized in the RegenrichSet object

Since RegenrichSet object is initialized with `method = "LRT_LM"`,
`regenrich_diffExpr` function performs differential expression analysis using likelihood ratio test on
two linear models that are specified by `design` formula and `reduced` formula.

```
object = regenrich_diffExpr(object)
print(object)
#> RegenrichSet object
#>  assayData: 1720 rows, 52 columns (filtered 280 rows by average expression <= 0.01)
#>
#>  (1) 544 rows with differential p-value < 0.05
#>
#>  Network inference needs to be performed, or a 'TopNetwork' object needs to be provided.
print(results_DEA(object))
#> DataFrame with 1720 rows and 3 columns
#>                  gene           p     logFC
#>           <character>   <numeric> <numeric>
#> A1BG             A1BG 8.66920e-01         0
#> A1BG-AS1     A1BG-AS1 2.00275e-01         0
#> A1CF             A1CF 6.55367e-01         0
#> A2M               A2M 4.98931e-06         0
#> A2M-AS1       A2M-AS1 3.57559e-04         0
#> ...               ...         ...       ...
#> C17orf103   C17orf103  0.80616307         0
#> C17orf104   C17orf104  0.00927184         0
#> C17orf105   C17orf105  0.71747166         0
#> C17orf107   C17orf107  0.96590666         0
#> C17orf47     C17orf47  0.72293696         0
```

`LRT_LM` method is implemented for data with complicated experiment designs, in which it is less
meaningful to calculate log2 fold changes. In the current version of RegEnrich, calculating the
log2 fold change between conditions is not implemented in `LRT_LM` method. And the log2 fold
changes of all genes are set to 0 by default.

## 4.2 Re-specify the parameters for differential expression analysis

Here, parameters to perform differential expression analysis can be re-specified in
`regenrich_diffExpr` function. Below, we show an example of using limma to obtain differential
expressed genes, by changing parameters.

```
object2 = regenrich_diffExpr(object, method = "limma", coef = "week3")
#> When method is limma or Wald_DESeq2, the 'reduced' argument is not used.
#> The method is limma, a formula is provided to the design,
#> so the model matrix is generated using model.matrix(design, data = pData).
print(object2)
#> RegenrichSet object
#>  assayData: 1720 rows, 52 columns (filtered 280 rows by average expression <= 0.01)
#>
#>  (1) 510 rows with differential p-value < 0.05
#>
#>  Network inference needs to be performed, or a 'TopNetwork' object needs to be provided.
print(results_DEA(object2))
#> DataFrame with 1720 rows and 3 columns
#>                  gene           p       logFC
#>           <character>   <numeric>   <numeric>
#> A1BG             A1BG 8.74264e-01  0.00409204
#> A1BG-AS1     A1BG-AS1 2.04362e-01  0.07395716
#> A1CF             A1CF 8.38490e-01 -0.00224502
#> A2M               A2M 8.23976e-05  0.27179291
#> A2M-AS1       A2M-AS1 1.10891e-03  0.30939387
#> ...               ...         ...         ...
#> C17orf103   C17orf103   0.8071424 -0.01069455
#> C17orf104   C17orf104   0.0174435 -0.07552484
#> C17orf105   C17orf105   0.7972371 -0.00352343
#> C17orf107   C17orf107   0.9655112 -0.00305637
#> C17orf47     C17orf47   0.7496326 -0.00667404
```

More detailed explaination of `regenrich_diffExpr` function can be accessed by `?regenrich_diffExpr`.

---

# 5 Regulator-target network inference

RegEnrich provides two computational methods, `COEN` and `GRN`,
to infer regulator-target network based on expression data.
For COEN method, the weighted co-expression network is constructed using
[WGCNA](https://cran.r-project.org/web/packages/WGCNA/index.html)
package, and then the regulator-target network is the robust subnetwork
of weighted co-expression network, and the nodes and edges are removed if
they are not connected to any regulators.
With respect to GRN, it infers regulator-target network using random forest algorithm.
This method was initially described in
[GENIE3](http://www.montefiore.ulg.ac.be/~huynh-thu/software.html) package,
and it is modified in RegEnrich to support parallel computing and to
control the model accuracy. Regulator-target network inferences using COEN and
GRN methods are shown bellow.

## 5.1 COEN (based on WGCNA)

`regenrich_network` is the function to perform regulator-target network inference.
Since the `networkConstruction = "COEN"` parameter has been set during the RegenrichSet
initialization, so by default RegEnrich constructs a `COEN` network.

```
set.seed(123)
object = regenrich_network(object)
print(object)
#> RegenrichSet object
#>  assayData: 1720 rows, 52 columns (filtered 280 rows by average expression <= 0.01)
#>
#>  (1) 544 rows with differential p-value < 0.05
#>
#>  (2) Top p% network info:
#> TopNetwork object (3661 edges, networkConstruction: 'COEN', percentage: 5%)
#> # A tibble: 3,661 × 3
#>    set   element weight
#>    <chr> <chr>    <dbl>
#>  1 AATF  ABCB7   0.0213
#>  2 AATF  ABCF2   0.0540
#>  3 AATF  ABHD12  0.0233
#>  4 AATF  ABI3    0.0342
#>  5 AATF  ABTB2   0.0181
#>  6 AATF  ACADM   0.0516
#>  7 ABT1  ACAP1   0.0297
#>  8 AATF  ACAP2   0.0269
#>  9 AATF  ACAT1   0.0231
#> 10 AATF  ACBD5   0.0386
#> # ℹ 3,651 more rows
#>  FET/GSEA enrichment needs to be performed.
```

What happens under the hood in above codes is updating `object@topNetP` slot, which is a
`Topnetwork` class. RegEnrich provides a function to access this slot.

```
# TopNetwork class
print(results_topNet(object))
#> TopNetwork object (3661 edges, networkConstruction: 'COEN', percentage: 5%)
#> # A tibble: 3,661 × 3
#>    set   element weight
#>    <chr> <chr>    <dbl>
#>  1 AATF  ABCB7   0.0213
#>  2 AATF  ABCF2   0.0540
#>  3 AATF  ABHD12  0.0233
#>  4 AATF  ABI3    0.0342
#>  5 AATF  ABTB2   0.0181
#>  6 AATF  ACADM   0.0516
#>  7 ABT1  ACAP1   0.0297
#>  8 AATF  ACAP2   0.0269
#>  9 AATF  ACAT1   0.0231
#> 10 AATF  ACBD5   0.0386
#> # ℹ 3,651 more rows
```

Please note that since the oganism of
[GSE63085](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE63085)
dataset is Homo sapien, the regulators used in RegEnrich by default are obtained from
(Han et al. [2015](#ref-han2015trrust); Marbach et al. [2016](#ref-marbach2016tissue); and Liu et al. [2015](#ref-liu2015regnetwork)). And we are using gene
names in the expression data, so the regulators here are also represented by gene names.

```
# All parameters are stored in object@paramsIn slot
head(slot(object, "paramsIn")$reg)
#> [1] "NFYA"   "ARX"    "UPF1"   "HOXA11" "POLR2J" "MEOX1"
```

Since network inference is generally very time-consuming, we suggest saving
the `RegenrichSet` object with the regulator-target network in case of
using it next time.

```
# Saving object to 'fileName.Rdata' file in '/folderName' directory
save(object, file = "/folderName/fileName.Rdata")
```

A more detailed explaination can be found in the help pages of `regenrich_network`
(see `?regenrich_network`) and `TopNetwork-class` (see `?"TopNetwork-class"`).

## 5.2 GRN (based on random forest)

Alternatively, you can build a gene regulatory network (`GRN`) by setting
`networkConstruction = "GRN"` parameter in `regenrich_network` function.
To accelarate computing, you can set number of CPU cores and random seeds
using `BPPARAM` parameter.
Here you can control the accuracy of network inferance by `minR` which are computed
based on out-of-bag estimation in random forest. Please note that the lower `minR`
is set, the less edges and potential less regulators are retained.

```
### not run
library(BiocParallel)
# on non-Windows computers (use 2 workers)
bpparam = register(MulticoreParam(workers = 2, RNGseed = 1234))
# on Windows computers (use 2 workers)
bpparam = register(SnowParam(workers = 2, RNGseed = 1234))

object3 = regenrich_network(object, networkConstruction = "GRN",
                           BPPARAM = bpparam, minR = 0.3)
print(object3)
print(results_topNet(object3))
save(object3, file = "/folderName/fileName3.Rdata")
```

## 5.3 User defined network

It is also possible to provide a regulator-target network, which is obtained somewhere else.
For example, this network can be constructed based on the relation network of transcription
factors and their binding targets.
Here we assigned the constructed `COEN` regulator-target network (a `Topnetwork` object) in
`object` variable to `object2` variable.

```
network_user = results_topNet(object)
print(class(network_user))
#> [1] "TopNetwork"
#> attr(,"package")
#> [1] "RegEnrich"
regenrich_network(object2) = network_user
print(object2)
#> RegenrichSet object
#>  assayData: 1720 rows, 52 columns (filtered 280 rows by average expression <= 0.01)
#>
#>  (1) 510 rows with differential p-value < 0.05
#>
#>  (2) Top p% network info:
#> TopNetwork object (3661 edges, networkConstruction: 'new', percentage: 100%)
#> # A tibble: 3,661 × 3
#>    set   element weight
#>    <chr> <chr>    <dbl>
#>  1 AATF  ABCB7   0.0213
#>  2 AATF  ABCF2   0.0540
#>  3 AATF  ABHD12  0.0233
#>  4 AATF  ABI3    0.0342
#>  5 AATF  ABTB2   0.0181
#>  6 AATF  ACADM   0.0516
#>  7 ABT1  ACAP1   0.0297
#>  8 AATF  ACAP2   0.0269
#>  9 AATF  ACAT1   0.0231
#> 10 AATF  ACBD5   0.0386
#> # ℹ 3,651 more rows
#>  FET/GSEA enrichment needs to be performed.
```

It is also fine to provide a 3-column table (`data.frame` object) of network edges, in which
the first column is regulators, the second column is targets, and the third column is edge
weight (reliability).

```
network_user = slot(results_topNet(object), "elementset")
print(class(network_user))
#> [1] "tbl_elementset"      "tbl_elementset_base" "tbl_df"              "tbl"
#> [5] "data.frame"
regenrich_network(object2) = as.data.frame(network_user)
print(object2)
#> RegenrichSet object
#>  assayData: 1720 rows, 52 columns (filtered 280 rows by average expression <= 0.01)
#>
#>  (1) 510 rows with differential p-value < 0.05
#>
#>  (2) Top p% network info:
#> TopNetwork object (3661 edges, networkConstruction: 'new', percentage: 100%)
#> # A tibble: 3,661 × 3
#>    set   element weight
#>    <chr> <chr>    <dbl>
#>  1 AATF  ABCB7   0.0213
#>  2 AATF  ABCF2   0.0540
#>  3 AATF  ABHD12  0.0233
#>  4 AATF  ABI3    0.0342
#>  5 AATF  ABTB2   0.0181
#>  6 AATF  ACADM   0.0516
#>  7 ABT1  ACAP1   0.0297
#>  8 AATF  ACAP2   0.0269
#>  9 AATF  ACAT1   0.0231
#> 10 AATF  ACBD5   0.0386
#> # ℹ 3,651 more rows
#>  FET/GSEA enrichment needs to be performed.
```

---

# 6 Enrichment analysis

RegEnrich provides two methods to perform enrichment analysis, i.e. Fisher’s exact test (`FET`)
and gene set enrichment analysis (`GSEA`). Both methods are implemented in `regenrich_enrich`
function.
`regenrich_enrich` function updates `object@resEnrich` slot, which is a
`Enrich` class. RegEnrich provides `results_enrich` function to access this slot.

## 6.1 Fisher’s exact test (FET)

Since the `enrichTest = "FET"` parameter has been set during the RegenrichSet initialization,
so by default RegEnrich performs enrichment analysis using `FET` method.

```
object = regenrich_enrich(object)
print(results_enrich(object))
#> Enrich object (FET method, 65 regulators are used for enrichment,
#>  8 regulators pass the threshold)
#> # A tibble: 8 × 12
#>   ID     Description GeneRatio BgRatio RichFactor FoldEnrichment zScore   pvalue p.adjust  qvalue geneID Count
#>   <chr>  <chr>       <chr>     <chr>        <dbl>          <dbl>  <dbl>    <dbl>    <dbl>   <dbl> <chr>  <int>
#> 1 APBB1  APBB1       71/248    120/670      0.592           1.60   5.54  4.27e-8  1.81e-6 1.52e-6 APLP2…    71
#> 2 ARNTL2 ARNTL2      21/248    23/670       0.913           2.47   5.48  5.56e-8  1.81e-6 1.52e-6 ARPC5…    21
#> 3 ALYREF ALYREF      9/248     9/670        1               2.70   3.94  1.19e-4  2.33e-3 1.96e-3 ANKRD…     9
#> 4 AES    AES         32/248    52/670       0.615           1.66   3.81  1.63e-4  2.33e-3 1.96e-3 AGFG1…    32
#> 5 ARID3A ARID3A      30/248    48/670       0.625           1.69   3.79  1.79e-4  2.33e-3 1.96e-3 ARL11…    30
#> 6 ATF6   ATF6        35/248    60/670       0.583           1.58   3.58  3.60e-4  3.90e-3 3.28e-3 ATG4A…    35
#> 7 BACH2  BACH2       22/248    34/670       0.647           1.75   3.43  7.21e-4  6.69e-3 5.64e-3 BANK1…    22
#> 8 ARNT   ARNT        37/248    72/670       0.514           1.39   2.67  6.02e-3  4.89e-2 4.12e-2 ARPC1…    37
# enrich_FET = results_enrich(object)@allResult
enrich_FET = slot(results_enrich(object), "allResult")
head(enrich_FET[, 1:6])
#> # A tibble: 6 × 6
#>   ID     Description GeneRatio BgRatio RichFactor FoldEnrichment
#>   <chr>  <chr>       <chr>     <chr>        <dbl>          <dbl>
#> 1 APBB1  APBB1       71/248    120/670      0.592           1.60
#> 2 ARNTL2 ARNTL2      21/248    23/670       0.913           2.47
#> 3 ALYREF ALYREF      9/248     9/670        1               2.70
#> 4 AES    AES         32/248    52/670       0.615           1.66
#> 5 ARID3A ARID3A      30/248    48/670       0.625           1.69
#> 6 ATF6   ATF6        35/248    60/670       0.583           1.58
```

## 6.2 Gene set enrichment analysis (GSEA)

Since the `enrichTest = "FET"` parameter has been set during the RegenrichSet initialization,
but `enrichTest = GSEA` parameter can be re-specified in `regenrich_enrich` function to
perform enrichment analysis using `GSEA` method. Typically, `GSEA` is slower than `FET` method,
especially when the number of `reg` is large and the regulator-target network is also large.
Reducing the number of permutation (`nperm`, default is 10,000) can be a good trial to have a
look at preliminary results.

```
set.seed(123)
object2 = regenrich_enrich(object, enrichTest = "GSEA", nperm = 5000)
print(results_enrich(object))
#> Enrich object (FET method, 65 regulators are used for enrichment,
#>  8 regulators pass the threshold)
#> # A tibble: 8 × 12
#>   ID     Description GeneRatio BgRatio RichFactor FoldEnrichment zScore   pvalue p.adjust  qvalue geneID Count
#>   <chr>  <chr>       <chr>     <chr>        <dbl>          <dbl>  <dbl>    <dbl>    <dbl>   <dbl> <chr>  <int>
#> 1 APBB1  APBB1       71/248    120/670      0.592           1.60   5.54  4.27e-8  1.81e-6 1.52e-6 APLP2…    71
#> 2 ARNTL2 ARNTL2      21/248    23/670       0.913           2.47   5.48  5.56e-8  1.81e-6 1.52e-6 ARPC5…    21
#> 3 ALYREF ALYREF      9/248     9/670        1               2.70   3.94  1.19e-4  2.33e-3 1.96e-3 ANKRD…     9
#> 4 AES    AES         32/248    52/670       0.615           1.66   3.81  1.63e-4  2.33e-3 1.96e-3 AGFG1…    32
#> 5 ARID3A ARID3A      30/248    48/670       0.625           1.69   3.79  1.79e-4  2.33e-3 1.96e-3 ARL11…    30
#> 6 ATF6   ATF6        35/248    60/670       0.583           1.58   3.58  3.60e-4  3.90e-3 3.28e-3 ATG4A…    35
#> 7 BACH2  BACH2       22/248    34/670       0.647           1.75   3.43  7.21e-4  6.69e-3 5.64e-3 BANK1…    22
#> 8 ARNT   ARNT        37/248    72/670       0.514           1.39   2.67  6.02e-3  4.89e-2 4.12e-2 ARPC1…    37
# enrich_GSEA = results_enrich(object2)@allResult
enrich_GSEA = slot(results_enrich(object2), "allResult")
head(enrich_GSEA[, 1:6])
#> # A tibble: 6 × 6
#>   regulator     pval    padj    ES   NES nMoreExtreme
#>   <chr>        <dbl>   <dbl> <dbl> <dbl>        <dbl>
#> 1 APBB1     0.000205 0.00554 0.567  2.01            0
#> 2 AES       0.000224 0.00554 0.591  1.92            0
#> 3 ARNTL2    0.000258 0.00554 0.833  2.34            0
#> 4 ALYREF    0.000316 0.00554 0.928  2.08            0
#> 5 ARID3A    0.00113  0.0159  0.576  1.84            4
#> 6 BHLHA15   0.00179  0.0190  0.900  1.74            4
```

You can compare the order of enriched regulators obtained by FET and GSEA methods using
`plotOrders` function.

```
plotOrders(enrich_FET[[1]][1:20], enrich_GSEA[[1]][1:20])
```

---

# 7 Regulator scoring and ranking

The RegEnrich score is a summarized information from both differential expression analysis and
regulator enrichment analysis for regulators. This step of RegEnrich analysis is done by
`regenrich_rankScore` function.

Above all, the differential expression analysis is perormed by `LRT_LM` method,
regulator-target network is infered by `COEN` method, and enrichment analysis is
performed by `FET` method, so the scores and ranking summarize the importance
of regulators by considering regulatory interactions in the studied biological process.

```
object = regenrich_rankScore(object)
results_score(object)
#> # A tibble: 65 × 5
#>    reg    negLogPDEA negLogPEnrich logFC score
#>  * <chr>       <dbl>         <dbl> <dbl> <dbl>
#>  1 APBB1        4.70         7.37      0 1.71
#>  2 ARNTL2       3.95         7.25      0 1.58
#>  3 BACH2        5.03         3.14      0 1.19
#>  4 AEBP1        6.59         0.781     0 1.11
#>  5 AES          2.88         3.79      0 0.944
#>  6 ALYREF       2.75         3.92      0 0.943
#>  7 BRCA1        3.11         1.82      0 0.713
#>  8 ARID3A       1.19         3.75      0 0.680
#>  9 ATF6         1.34         3.44      0 0.662
#> 10 ARNT         2.00         2.22      0 0.597
#> # ℹ 55 more rows
```

The expression of regulator and its targets can be viewed using following code.

```
plotRegTarExpr(object, reg = "ARNTL2")
```

Note that the previous analysis is a tutorial showing you how to perform basic RegEnrich analysis.
As you known this analysis is based on only first 2000 genes, the real key regulators
should be different from the previous results.

RegEnrich can work with different types of dataset, such as microarray data, RNAseq raw read count
data, and mass spectrometriy proteomic data. The following section shows you 2 case studies of using
RegEnrich to work with these 2 types of datasets.

---

# 8 Case studies

## 8.1 Case 1: Microarray (single-channel) data

### 8.1.1 Background

This case study analyzes gene expression changes of primary human hepatocytes after 6 and 24 h
treatment with interferon alpha (IFN-α). The gene expression was examined using single-channel Affymetrix
Human Genome U133 Plus 2.0 Arrays. And the raw data and normalized data is available in GEO database
under [GSE31193](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE31193) accession ID.

### 8.1.2 Reading the data

There are several ways to read the data.
You can download the normalized data file,
decompress it, and then read it using `read.csv` function.

Reading the raw data (.cel files) and then normalize it using other normalization method is also possible.
As there is a simpler way to read data from GEO database, this method is not included in this vignette.

The simplist way to read the data is using `GEOquery` library. To use this library, you must
have this package installed.

```
if (!requireNamespace("GEOquery"))
 BiocManager::install("GEOquery")

library(GEOquery)
eset <- getGEO(GEO = "GSE31193")[[1]]
```

This dataset contains samples treated with IL28B, but here we are focusing on only control samples
and samples after 6 and 24 h IFN-α treatment.

```
# Samples information
pd0 = pData(eset)
pd = pd0[, c("title", "time:ch1", "agent:ch1")]
colnames(pd) = c("title", "time", "group")
pd$time = factor(c(`n/a` = "0", `6` = "6", `24` = "24")[pd$time],
                 levels = c("0", "6", "24"))
pd$group = factor(pd$group, levels = c("none", "IFN", "IL28B"))
pData(eset) = pd

# Only samples without or after 6 and 24 h IFN-α treatment
eset_IFN = eset[, pd$group %in% c("none", "IFN")]

# Order the samples based on time of treatment
pData(eset_IFN) = pData(eset_IFN)[order(pData(eset_IFN)$time),]

# Rename samples
colnames(eset_IFN) = pData(eset_IFN)$title

# Probes information
probeGene = fData(eset_IFN)[, "Gene Symbol", drop = FALSE]
```

Here to simplify the analysis, if there are multiple probes matching a gene,
we use only one probe with higher average expression value to represent this gene.

```
probeGene$meanExpr = rowMeans(exprs(eset_IFN))
probeGene = probeGene[order(probeGene$meanExpr, decreasing = TRUE),]

# Keep a single probe for a gene, and remove the probe matching no gene.
probeGene_noDu = probeGene[!duplicated(probeGene$`Gene Symbol`), ][-1,]

data = eset_IFN[rownames(probeGene_noDu), ]
rownames(data) = probeGene_noDu$`Gene Symbol`
```

Because the speed of network infernece is highly influenced by the number of genes,
to quickly illustrate how to use RegEnrich, here we randomly take only 5,000 genes
for analysis. If you would like to see the real result in the analysis, then the
following data subsetting step should be discarded.

```
set.seed(1234)
data = data[sample(1:nrow(data), 5000), ]
```

### 8.1.3 RegEnrich analysis

Here we would like to know which regulators play key roles in primary human hepatocytes
after *24 h* treatment with IFN-α.

```
expressionMatrix = exprs(data) # expression data
# rownames(expressionMatrix) = probeGene_noDu$`Gene Symbol`
sampleInfo = pData(data) # sample information

design = ~time
contrast = c(0, 0, 1) # to extract the coefficient "time24"

data(TFs)
# Initializing a RegenrichSet object
object = RegenrichSet(expr = expressionMatrix, # expression data (matrix)
                      colData = sampleInfo, # sample information (data frame)
                      reg = unique(TFs$TF_name), # regulators
                      method = "limma", # differentila expression analysis method
                      design = design, # desing fomula
                      contrast = contrast, # contrast
                      networkConstruction = "COEN", # network inference method
                      enrichTest = "FET") # enrichment analysis method

# Perform RegEnrich analysis
set.seed(123)

# This procedure takes quite a bit of time.
object = regenrich_diffExpr(object) %>%
  regenrich_network() %>%
  regenrich_enrich() %>%
  regenrich_rankScore()
```

```
res = results_score(object)
res
#> # A tibble: 133 × 5
#>    reg     negLogPDEA negLogPEnrich  logFC score
#>  * <chr>        <dbl>         <dbl>  <dbl> <dbl>
#>  1 NMI           8.48         63.5   1.56  1.79
#>  2 IRF7          7.49         59.4   2.30  1.63
#>  3 ETV6          5.91         53.4   1.26  1.39
#>  4 ETV7         10.7           4.20  3.92  1.07
#>  5 NOTCH2        2.31         42.3  -0.261 0.881
#>  6 DCP1A         5.51         16.1   1.06  0.768
#>  7 EIF2AK2       6.86          6.73  1.24  0.747
#>  8 CIITA         6.26          9.27  1.56  0.731
#>  9 IRF9          5.99          9.27  1.53  0.705
#> 10 ETS2          2.14         27.4   0.232 0.631
#> # ℹ 123 more rows
```

```
plotRegTarExpr(object, reg = "STAT1")
```

## 8.2 Case 2: RNAseq read count data

### 8.2.1 Background

Here we show how to apply RegEnrich on the RNAseq data by analyzing Kang et al’s
monocyte-macrophage-IFN stimulation dataset (
[GSE130567](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE130567)). There are multiple
experiment conditions in this study. But here we would like to focus on partial samples in
which monocytes were cultured with 10 ng/ml human macrophage colonystimulating factor (M-CSF)
in the presence (IFN-γ-primed macrophages) or absence (resting macrophages) of 100 U/ml human
IFN-γ for 48 h. RNA were extracted and reverse transcripted followed by sequencing (50 bp, paired-end)
using Illumina HiSeq 4000. Sequenced reads were mapped to reference human genome (hg19 assembly)
using STAR aligner with default parameters. We will use the raw HT-seq counts for the RegEnrich
analysis.

### 8.2.2 Reading the data

Since the sample information and raw read counts data are archived seperately in GEO database.
First, we can read the sample information using `GEOquery` package.

```
library(GEOquery)
eset <- getGEO(GEO = "GSE130567")[[1]]
pdata = pData(eset)[, c("title", "geo_accession", "cultured in:ch1", "treatment:ch1")]
colnames(pdata) = c("title", "accession", "cultured", "treatment")
pData(eset) = pdata

# Only samples cultured with M-CSF in the presence or absence of IFN-γ
eset = eset[, pdata$treatment %in% c("NT", "IFNG-3h") & pdata$cultured == "M-CSF"]

# Sample information
sampleInfo = pData(eset)
rownames(sampleInfo) = paste0(rep(c("Resting", "IFNG"), each = 3), 1:3)
sampleInfo$treatment = factor(rep(c("Resting", "IFNG"), each = 3),
                              levels = c("Resting", "IFNG"))
```

Second, download read count file and decompose into a temporary folder.

```
tmpFolder = tempdir()
tmpFile = tempfile(pattern = "GSE130567_", tmpdir = tmpFolder, fileext = ".tar")
download.file("https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE130567&format=file",
              destfile = tmpFile, mode = "wb")
untar(tmpFile, exdir = tmpFolder)
files = untar(tmpFile, list = TRUE)
filesFull = file.path(tmpFolder, files)
```

Then read the raw read counts in these files.

```
dat = list()
for (file in filesFull){
  accID = gsub(".*(GSM\\d{7}).*", "\\1", file)
  if(accID %in% sampleInfo$accession){
    zz = gzfile(file, "rt")
    zzdata = read.csv(zz, header = FALSE, sep = "\t", skip = 4, row.names = 1)
    close(zz)
    zzdata = zzdata[,1, drop = FALSE] # Extract the first numeric column
    colnames(zzdata) = accID
    dat = c(dat, list(zzdata))
  }
}
edata = do.call(cbind, dat)

edata = edata[grep(".*[0-9]+$", rownames(edata)),] # remove PAR locus genes
rownames(edata) = substr(rownames(edata), 1, 15)
colnames(edata) = rownames(sampleInfo)

# Retain genes with average read counts higher than 1
edata = edata[rowMeans(edata) > 1,]
```

Similar to the case 1, here we randomly take only 5,000 genes to quickly illustrate how to use
RegEnrich, but to see the real result from the analysis, you should neglect the following step.

```
set.seed(1234)
edata = edata[sample(1:nrow(edata), 5000), ]
```

### 8.2.3 RegEnrich analysis

```
expressionMatrix = as.matrix(edata) # expression data

design = ~ treatment
reduced = ~ 1

data(TFs)
# Initializing a RegenrichSet object
object = RegenrichSet(expr = expressionMatrix, # expression data (matrix)
                      colData = sampleInfo, # sample information (data frame)
                      reg = unique(TFs$TF), # regulators
                      method = "LRT_DESeq2", # differentila expression analysis method
                      design = design, # desing fomula
                      reduced = reduced, # reduced
                      networkConstruction = "COEN", # network inference method
                      enrichTest = "FET") # enrichment analysis method

# Perform RegEnrich analysis
set.seed(123)

# This procedure takes quite a bit of time.
object = regenrich_diffExpr(object) %>%
  regenrich_network() %>%
  regenrich_enrich() %>%
  regenrich_rankScore()
```

```
res = results_score(object)
res$name = TFs[res$reg, "TF_name"]
res
#> # A tibble: 91 × 6
#>    reg             negLogPDEA negLogPEnrich  logFC score name
#>  * <chr>                <dbl>         <dbl>  <dbl> <dbl> <chr>
#>  1 ENSG00000028277      0.608       49.0    -0.359 1.10  POU2F2
#>  2 ENSG00000153071      6.16         0.786  -1.37  1.02  DAB2
#>  3 ENSG00000125520      6.04         0.602  -1.52  0.992 SLC2A4RG
#>  4 ENSG00000181090      2.34        27.6    -0.878 0.944 EHMT1
#>  5 ENSG00000055332      4.28         0.434  -1.05  0.703 EIF2AK2
#>  6 ENSG00000153234      3.84         0.590  -1.62  0.634 NR4A2
#>  7 ENSG00000155229      1.50        18.9    -0.692 0.629 MMS19
#>  8 ENSG00000159692      1.10        13.6    -0.468 0.456 CTBP1
#>  9 ENSG00000116560      2.67         0.276  -0.871 0.438 SFPQ
#> 10 ENSG00000100105      2.69         0.0427 -0.953 0.437 PATZ1
#> # ℹ 81 more rows
```

```
plotRegTarExpr(object, reg = "ENSG00000028277")
```

---

# 9 Session info

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
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
#>  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
#> [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#>  [1] GEOquery_2.78.0             RegEnrich_1.20.0            SummarizedExperiment_1.40.0
#>  [4] Biobase_2.70.0              GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [7] IRanges_2.44.0              MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [10] BiocSet_1.24.0              tibble_3.3.0                dplyr_1.1.4
#> [13] S4Vectors_0.48.0            BiocGenerics_0.56.0         generics_0.1.4
#> [16] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3    rstudioapi_0.17.1     jsonlite_2.0.0        magrittr_2.0.4
#>   [5] farver_2.1.2          rmarkdown_2.30        fs_1.6.6              BiocIO_1.20.0
#>   [9] vctrs_0.6.5           memoise_2.0.1         base64enc_0.1-3       htmltools_0.5.8.1
#>  [13] S4Arrays_1.10.0       dynamicTreeCut_1.63-1 curl_7.0.0            SparseArray_1.10.0
#>  [17] Formula_1.2-5         sass_0.4.10           bslib_0.9.0           htmlwidgets_1.6.4
#>  [21] httr2_1.2.1           plyr_1.8.9            impute_1.84.0         cachem_1.1.0
#>  [25] lifecycle_1.0.4       iterators_1.0.14      pkgconfig_2.0.3       Matrix_1.7-4
#>  [29] R6_2.6.1              fastmap_1.2.0         digest_0.6.37         colorspace_2.1-2
#>  [33] AnnotationDbi_1.72.0  DESeq2_1.50.0         Hmisc_5.2-4           RSQLite_2.4.3
#>  [37] randomForest_4.7-1.2  httr_1.4.7            abind_1.4-8           compiler_4.5.1
#>  [41] withr_3.0.2           bit64_4.6.0-1         doParallel_1.0.17     htmlTable_2.4.3
#>  [45] S7_0.2.0              backports_1.5.0       BiocParallel_1.44.0   DBI_1.2.3
#>  [49] R.utils_2.13.0        rappdirs_0.3.3        DelayedArray_0.36.0   tools_4.5.1
#>  [53] foreign_0.8-90        rentrez_1.2.4         nnet_7.3-20           R.oo_1.27.1
#>  [57] glue_1.8.0            GOSemSim_2.36.0       grid_4.5.1            checkmate_2.3.3
#>  [61] cluster_2.1.8.1       reshape2_1.4.4        fgsea_1.36.0          gtable_0.3.6
#>  [65] tzdb_0.5.0            R.methodsS3_1.8.2     preprocessCore_1.72.0 tidyr_1.3.1
#>  [69] data.table_1.17.8     hms_1.1.4             WGCNA_1.73            xml2_1.4.1
#>  [73] utf8_1.2.6            XVector_0.50.0        foreach_1.5.2         pillar_1.11.1
#>  [77] stringr_1.5.2         yulab.utils_0.2.1     limma_3.66.0          splines_4.5.1
#>  [81] lattice_0.22-7        survival_3.8-3        bit_4.6.0             tidyselect_1.2.1
#>  [85] GO.db_3.22.0          locfit_1.5-9.12       Biostrings_2.78.0     knitr_1.50
#>  [89] gridExtra_2.3         bookdown_0.45         xfun_0.53             statmod_1.5.1
#>  [93] stringi_1.8.7         yaml_2.3.10           evaluate_1.0.5        codetools_0.2-20
#>  [97] qvalue_2.42.0         BiocManager_1.30.26   cli_3.6.5             ontologyIndex_2.12
#> [101] rpart_4.1.24          jquerylib_0.1.4       dichromat_2.0-0.1     Rcpp_1.1.0
#> [105] png_0.1-8             fastcluster_1.3.0     XML_3.99-0.19         parallel_4.5.1
#> [109] ggplot2_4.0.0         readr_2.1.5           blob_1.2.4            DOSE_4.4.0
#> [113] scales_1.4.0          purrr_1.1.0           crayon_1.5.3          rlang_1.1.6
#> [117] cowplot_1.2.0         fastmatch_1.1-6       KEGGREST_1.50.0
```

---

# References

Bouquet, Jerome, Mark J Soloski, Andrea Swei, Chris Cheadle, Scot Federman, Jean-Noel Billaud, Alison W Rebman, et al. 2016. “Longitudinal Transcriptome Analysis Reveals a Sustained Differential Gene Expression Signature in Patients Treated for Acute Lyme Disease.” *MBio* 7 (1): e00100–16.

Han, Heonjong, Hongseok Shim, Donghyun Shin, Jung Eun Shim, Yunhee Ko, Junha Shin, Hanhae Kim, et al. 2015. “TRRUST: A Reference Database of Human Transcriptional Regulatory Interactions.” *Scientific Reports* 5: 11432.

Liu, Zhi-Ping, Canglin Wu, Hongyu Miao, and Hulin Wu. 2015. “RegNetwork: An Integrated Database of Transcriptional and Post-Transcriptional Regulatory Networks in Human and Mouse.” *Database* 2015.

Marbach, Daniel, David Lamparter, Gerald Quon, Manolis Kellis, Zoltán Kutalik, and Sven Bergmann. 2016. “Tissue-Specific Regulatory Circuits Reveal Variable Modular Perturbations Across Complex Diseases.” *Nature Methods* 13 (4): 366.