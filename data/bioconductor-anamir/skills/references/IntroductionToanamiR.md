# Introduction to anamiR

anamiR Developers

#### *2018-10-30*

# Contents

* [0.1 Installation](#installation)
* [0.2 General Workflow](#general-workflow)
* [0.3 Data Source](#data-source)
  + [0.3.1 mRNA expression](#mrna-expression)
  + [0.3.2 miRNA expression](#mirna-expression)
  + [0.3.3 phenotype data](#phenotype-data)
* [0.4 Usage Example](#usage-example)
  + [0.4.1 Example Data Source](#example-data-source)
  + [0.4.2 Format of Input Data](#format-of-input-data)
  + [0.4.3 Normalization (Optional)](#normalization-optional)
  + [0.4.4 SummarizedExperiment class](#summarizedexperiment-class)
  + [0.4.5 Differential Expression Analysis](#differential-expression-analysis)
  + [0.4.6 Convert miRNA Annotation (Optional)](#convert-mirna-annotation-optional)
  + [0.4.7 Correlation Analysis](#correlation-analysis)
  + [0.4.8 Heat map (optional)](#heat-map-optional)
  + [0.4.9 Intersect with Databases](#intersect-with-databases)
  + [0.4.10 Functional Analysis](#functional-analysis)
* [0.5 Function Driven Analysis Workflow](#function-driven-analysis-workflow)
* [0.6 Usage Example](#usage-example-1)
  + [0.6.1 Example Data Source](#example-data-source-1)
  + [0.6.2 Format of Input Data](#format-of-input-data-1)
  + [0.6.3 SummarizedExperiment class](#summarizedexperiment-class-1)
  + [0.6.4 GSEA analysis](#gsea-analysis)
  + [0.6.5 GSEA Result](#gsea-result)
* [0.7 Other Functions](#other-functions)
  + [0.7.1 Multiple-Groups Data](#multiple-groups-data)
  + [0.7.2 Continuous Data](#continuous-data)

This document guides one through all available functions of the `anamiR` package. Package anamiR aims to find potential miRNA-target gene interactions from both miRNA and mRNA expression data.

Traditional miRNA analysis method is to use online databases to predict miRNA-target gene interactions. However, the inconsistent results make interactions are less reliable. To address this issue, anamiR integrates the whole expression analysis with expression data into workflow, including normalization, differential expression, correlation and then databases intersection, to find more reliable interactions.
Moreover, users can identify interactions from interested pathways or gene sets.

## 0.1 Installation

anamiR is on Bioconductor and can be installed following standard installation procedure.

```
install.packages("BiocManager")
BiocManager::install("anamiR")
```

To use,

```
library(anamiR)
```

```
## Setting options('download.file.method.GEOquery'='auto')
```

```
## Setting options('GEOquery.inmemory.gpl'=FALSE)
```

## 0.2 General Workflow

The general workflow can be summarized as follows,

![](data:image/png;base64...)

Basically there are six steps, corresponding to six R functions, to complete the whole analysis:

1. Normalize expression data
2. Find differential expreesion miRNAs and genes
3. Convert miRNA annotation to the latest version
4. Calculate the correlation coefficient between each miRNA and gene
5. Intersect with prediction and validation of miRNA- target gene interactions databases
6. Functional analysis with interested genes

## 0.3 Data Source

As shown in the workflow, not only samples of *paired* miRNA and mRNA expression
data, but phenotypical information of miRNA and mRNA are also required for the
analysis. Since anamiR reads data in expression matrices, data sources are
platform and technology agnostic. particularly, expression data from microarray
or next generation sequencing are all acceptable for anamiR. However, this also
indicates the raw data should be pre-processd to the expression matrices before
using anamiR.

### 0.3.1 mRNA expression

Columns for samples. Rows for genes

```
GENE  SmapleA   SamplB ...
A     0.1       0.2
B    -0.5      -0.3
C     0.4       0.1
```

### 0.3.2 miRNA expression

Columns for samples. Rows for miRNAs

```
miRNA  SampleA  SampleB ...
A         0.1     0.5
B        -0.5     2.1
C         0.4     0.3
```

### 0.3.3 phenotype data

Cloumns for samples. Rows for feature name, including two groups, multiple groups, continuous data.

```
Feature  groupA  groupA  groupA ...
SampleA  123.33     A       A
SampleB  120.34     B       C
SampleC  121.22     A       B
```

## 0.4 Usage Example

Now, we show an example using internal data for anamiR workflow.

### 0.4.1 Example Data Source

To demonstrate the usage of the `anamiR` package, the package contains 30 paired
miRNA and mRNA breast cancer samples, which are selected from 101 miRNA samples and
114 mRNA samples from GSE19536. As for phenotype data (hybridization information),
there are three types of information in it, including two-groups, multi-groups,
continuous data.

The mRNA data was conducted by Agilent-014850 Whole Human Genome Microarray 4x44K
G4112F (Probe Name version) platform and the miRNA data was generated from
Agilent-019118 Human miRNA Microarray 2.0 G4470B (miRNA ID version).

### 0.4.2 Format of Input Data

First of all, load the internal data and check the format.

```
data(mrna)
data(mirna)
data(pheno.mirna)
data(pheno.mrna)
```

Basically, the format of input data should be the same as the internal data.
For mRNA expression data should be like,

```
mrna[1:5, 1:5]
```

```
##          BC.M.014  BC.M.015  BC.M.017  BC.M.019  BC.M.023
## TRIM35   8.725157  8.699302  9.864870  8.986249  9.253038
## NR2C2AP 10.973569 11.318088 11.212974 11.803147 11.823159
## CENPO    7.404785  8.417221  8.272822  8.670029  9.392538
## ADCY8    5.785176  6.066669  6.240934  6.345486  6.037214
## RGS22    8.828413  7.844503  7.712051  7.078598  8.712837
```

As for miRNA expression data,

```
mirna[1:5, 1:5]
```

```
##                BC.M.014  BC.M.015  BC.M.017 BC.M.019 BC.M.023
## hsa-miR-139-5p 3.301236  4.072743  3.476371 3.957260 6.662144
## hsa-miR-575    9.525705 10.097954 10.790396 9.365697 9.289803
## hsa-miR-33b*   4.089836  4.297618  4.051852 3.842798 3.044545
## hsa-miR-335    4.146060  5.615910  6.274007 5.655296 9.309553
## hsa-miR-16-2*  3.407055  4.023072  3.052135 4.208022 4.572399
```

And the phenotype data,
(NOTICE:users should arrange the case columns front of the control columns.)

```
pheno.mrna[1:3, 1:3]
```

```
##          Subtype                        Survival           ER
## BC.M.014 "breast cancer subtype: Lum A" "126.611842105263" "case"
## BC.M.015 "breast cancer subtype: Lum A" "126.513157894737" "case"
## BC.M.017 "breast cancer subtype: Lum A" "80.9868421052632" "case"
```

```
pheno.mrna[28:30, 1:3]
```

```
##          Subtype                        Survival           ER
## BC.M.221 "breast cancer subtype: Basal" "115.197368421053" "control"
## BC.M.318 "breast cancer subtype: ERBB2" "110.526315789474" "control"
## BC.M.709 "breast cancer subtype: Basal" "15.2960526315789" "control"
```

Actually, the phenotype data of miRNA and mRNA share the same contents,but
in this case, we still make it in two data to prevent users from being
confused about it.

### 0.4.3 Normalization (Optional)

Secondly, we normalize data.
(If you use the normalized data, you can skip this step.)

```
se <- normalization(data = mirna, method = "quantile")
```

For this function, there are three methods provided, including `quantile`,
`rank.invariant`, `normal`. For more detail, Please refer to their
documentation.

Note that internal data have already been normalized, here is only for
demonstration.

### 0.4.4 SummarizedExperiment class

Before entering the main workflow, we should put our data and phenotype
information into `SummarizedExperiment` class first, which you can get
more information from SummarizedExperiment.

```
mrna_se <- SummarizedExperiment::SummarizedExperiment(
    assays = S4Vectors::SimpleList(counts=mrna),
    colData = pheno.mrna)

mirna_se <- SummarizedExperiment::SummarizedExperiment(
    assays = S4Vectors::SimpleList(counts=mirna),
    colData = pheno.mirna)
```

### 0.4.5 Differential Expression Analysis

Third, we will find differential expression genes and miRNAs.
There are three statitical methods in this function. here, we use
`t.test` for demonstration.

```
mrna_d <- differExp_discrete(se = mrna_se,
    class = "ER", method = "t.test",
    t_test.var = FALSE, log2 = FALSE,
    p_value.cutoff = 0.05,  logratio = 0.5
)

mirna_d <- differExp_discrete(se = mirna_se,
   class = "ER", method = "t.test",
   t_test.var = FALSE, log2 = FALSE,
   p_value.cutoff = 0.05,  logratio = 0.5
)
```

This function will delete genes and miRNAs (rows), which do not
differential express, and add another three columns represent
fold change (log2), p-value, adjusted p-value.

Take differential expressed mRNA data for instance,

```
nc <- ncol(mrna_d)
mrna_d[1:5, (nc-4):nc]
```

```
##          log-ratio      P-Value     P-adjust mean_case mean_control
## NR2C2AP -1.0712486 2.316469e-04 5.312839e-04 11.556393    12.627641
## CENPO   -0.8558411 2.682517e-04 5.748560e-04  8.349869     9.205710
## RGS22    1.6894848 2.039121e-05 1.631297e-04  8.398516     6.709031
## KIF3C   -0.5848147 4.541900e-05 2.270950e-04  8.279248     8.864063
## SENP5   -0.7626540 8.630361e-07 1.917858e-05 10.737840    11.500494
```

### 0.4.6 Convert miRNA Annotation (Optional)

Before using collected databases for intersection with potential
miRNA-target gene interactions, we have to make sure all miRNA
are in the latest annotation version (miRBase 21). If not, we
could use this function to do it.

```
mirna_21 <- miR_converter(data = mirna_d, remove_old = TRUE,
    original_version = 17, latest_version = 21)
```

Now, we can compare these two data,

```
# Before
head(row.names(mirna_d))
```

```
## [1] "hsa-miR-575"    "hsa-miR-150*"   "hsa-miR-198"    "hsa-miR-342-3p"
## [5] "hsa-miR-342-5p" "hsa-miR-134"
```

```
# After
head(row.names(mirna_21))
```

```
## [1] "hsa-miR-575"    "hsa-miR-150-3p" "hsa-miR-198"    "hsa-miR-342-3p"
## [5] "hsa-miR-342-5p" "hsa-miR-134-5p"
```

Note that user must put the right original version into parameter,
because it is an important information for function to convert
annotation.

### 0.4.7 Correlation Analysis

To find potential miRNA-target gene interactions, we should
combine the information in two differential expressed data,
which we obtained from `differExp_discrete`.

```
cor <- negative_cor(mrna_data = mrna_d, mirna_data = mirna_21,
    method = "pearson", cut.off = -0.5)
```

For output,

```
head(cor)
```

```
##      miRNA            Gene      Correlation( -0.5 )  logratio(miRNA)
## [1,] "hsa-miR-198"    "NR2C2AP" "-0.60749521052608"  "1.434328524"
## [2,] "hsa-miR-198"    "SENP5"   "-0.54646311346452"  "1.434328524"
## [3,] "hsa-miR-134-5p" "SENP5"   "-0.508211941696094" "1.0180378"
## [4,] "hsa-miR-198"    "AKAP1"   "-0.540628213927599" "1.434328524"
## [5,] "hsa-miR-342-3p" "PIF1"    "-0.565476513859015" "2.19495706"
## [6,] "hsa-miR-342-5p" "PIF1"    "-0.621317621065092" "2.115864648"
##      P-adjust(miRNA)        mean_case(miRNA) mean_control(miRNA)
## [1,] "0.0287086140383543"   "4.963163064"    "3.52883454"
## [2,] "0.0287086140383543"   "4.963163064"    "3.52883454"
## [3,] "0.000137286128508541" "8.14071616"     "7.12267836"
## [4,] "0.0287086140383543"   "4.963163064"    "3.52883454"
## [5,] "1.07192166300769e-09" "11.34977766"    "9.1548206"
## [6,] "9.42861994530635e-11" "7.135666308"    "5.01980166"
##      logratio(gene)       P-adjust(gene)         mean_case(gene)
## [1,] "-1.071248568"       "0.000531283948592135" "11.556392652"
## [2,] "-0.762654017199999" "1.91785808708134e-05" "10.7378403228"
## [3,] "-0.762654017199999" "1.91785808708134e-05" "10.7378403228"
## [4,] "-1.2822530884"      "0.000659175618505387" "12.1560164316"
## [5,] "-1.5501717548"      "0.00020239427080686"  "8.5069645972"
## [6,] "-1.5501717548"      "0.00020239427080686"  "8.5069645972"
##      mean_control(gene)
## [1,] "12.62764122"
## [2,] "11.50049434"
## [3,] "11.50049434"
## [4,] "13.43826952"
## [5,] "10.057136352"
## [6,] "10.057136352"
```

As the showing `list`, each row is a potential interaction,
and only the row that correlation coefficient < cut.off would
be kept in list.

Note that in our assumption, miRNAs negatively regulate
expression of their target genes, that is, cut.off basically
should be negative decimal.

### 0.4.8 Heat map (optional)

There is a function for user to see the heatmaps about
the miRNA-target gene interactions remaining in the
correlation analysis table.

```
heat_vis(cor, mrna_d, mirna_21)
```

![](data:image/png;base64...)![](data:image/png;base64...)

### 0.4.9 Intersect with Databases

After correlation analysis, we have some potential interactions,
and then using `database_support` helps us to get information
that whether there are databases predict or validate these
interactions.

```
sup <- database_support(cor_data = cor,
    org = "hsa", Sum.cutoff = 3)
```

From output, column `Sum` tells us the total hits by 8 predict
databases and column `Validate` tells us if this interaction
have been validated.

```
head(sup)
```

```
##      miRNA_21         Gene_symbol Ensembl           Gene_ID DIANA_microT_CDS
## [1,] "hsa-miR-342-3p" "ATF4"      "ENSG00000128272" "468"   0
## [2,] "hsa-miR-342-3p" "PKP1"      "ENSG00000081277" "5317"  1
## [3,] "hsa-miR-342-5p" "ITPRIP"    "ENSG00000148841" "85450" 1
## [4,] "hsa-miR-342-3p" "LRP8"      "ENSG00000157193" "7804"  1
## [5,] "hsa-miR-134-5p" "SIN3B"     "ENSG00000127511" "23309" 1
##      EIMMo Microcosm miRDB miRanda PITA rna22 Targetscan Sum miRecords
## [1,] 0     0         0     0       0    0     0          0   0
## [2,] 1     0         0     1       0    1     0          4   0
## [3,] 1     0         0     1       0    0     0          3   0
## [4,] 1     0         1     1       0    1     0          5   0
## [5,] 1     0         0     1       0    0     0          3   0
##      miRTarBase Validate Correlation( -0.5 )  logratio(miRNA)
## [1,] 1          "TRUE"   "-0.53495895225322"  "2.19495706"
## [2,] 1          "TRUE"   "-0.597546840711108" "2.19495706"
## [3,] 0          "FALSE"  "-0.58001171396371"  "2.115864648"
## [4,] 0          "FALSE"  "-0.699212107696958" "2.19495706"
## [5,] 0          "FALSE"  "-0.549533374374203" "1.0180378"
##      P-adjust(miRNA)        mean_case(miRNA) mean_control(miRNA)
## [1,] "1.07192166300769e-09" "11.34977766"    "9.1548206"
## [2,] "1.07192166300769e-09" "11.34977766"    "9.1548206"
## [3,] "9.42861994530635e-11" "7.135666308"    "5.01980166"
## [4,] "1.07192166300769e-09" "11.34977766"    "9.1548206"
## [5,] "0.000137286128508541" "8.14071616"     "7.12267836"
##      logratio(gene)  P-adjust(gene)         mean_case(gene)
## [1,] "-1.007603132"  "1.70115709649906e-05" "15.556558828"
## [2,] "-1.49107022"   "0.00020239427080686"  "6.694310296"
## [3,] "-1.12346218"   "0.000311769820018285" "9.41393342"
## [4,] "-1.8819269508" "0.000574855984019839" "7.6078690312"
## [5,] "-1.0848951548" "0.000324178247302931" "8.4875415732"
##      mean_control(gene) de novo
## [1,] "16.56416196"      0
## [2,] "8.185380516"      0
## [3,] "10.5373956"       0
## [4,] "9.489795982"      0
## [5,] "9.572436728"      0
```

Note that we have 8 predict databases (DIANA microT CDS, EIMMo,
Microcosm, miRDB, miRanda, PITA, rna22, TargetScan) and 2
validate databases (miRecords, miRTarBase).

### 0.4.10 Functional Analysis

The last, after finding reliable miRNA-target gene interactions,
we are also interested in pathways, which may be enriched by
these genes.

```
path <- enrichment(data_support = sup, org = "hsa", per_time = 500)
```

Note that for parameter per\_time, we only choose 500 times,
because it is for demonstration here. Default is 5000 times.

The output from this data not only shows P-Value generated by
hypergeometric test, but Empirical P-Value, which means the
value of average permutation test in each pathway.

```
head(path)
```

```
##      Database   Term
## [1,] "KEGG_hsa" "Adrenergic signaling in cardiomyocytes"
## [2,] "KEGG_hsa" "Alcoholism"
## [3,] "KEGG_hsa" "Aldosterone synthesis and secretion"
## [4,] "KEGG_hsa" "Amphetamine addiction"
## [5,] "KEGG_hsa" "Apoptosis"
## [6,] "KEGG_hsa" "cGMP-PKG signaling pathway"
##      Total Genes of the Term Targets in the Term
## [1,] "148"                   "1"
## [2,] "166"                   "1"
## [3,] "64"                    "1"
## [4,] "61"                    "1"
## [5,] "133"                   "1"
## [6,] "157"                   "1"
##      Targets in Total Genes of the Term(%) Raw P-Value
## [1,] "0.00675675675675676"                 "0.0211173573494353"
## [2,] "0.00602409638554217"                 "0.0236611563367605"
## [3,] "0.015625"                            "0.00917609139003062"
## [4,] "0.0163934426229508"                  "0.00874747254557706"
## [5,] "0.0075187969924812"                  "0.0189934770386644"
## [6,] "0.00636942675159236"                 "0.0223899187544135"
##      Empirical P-Value
## [1,] "0.0109780439121756"
## [2,] "0.0159680638722555"
## [3,] "0.00499001996007984"
## [4,] "0.00698602794411178"
## [5,] "0.00998003992015968"
## [6,] "0.0199600798403194"
```

## 0.5 Function Driven Analysis Workflow

This package also provides another workflow for analyzing
expression data.

![](data:image/png;base64...)

Basically there are only two steps with two R functions, to complete the whole analysis:

1. Find related miRNAs and genes in the possible enriched pathways.
2. Find potential interactions from the above result.

## 0.6 Usage Example

Now, we show an example using internal data for anamiR workflow.

### 0.6.1 Example Data Source

To demonstrate the usage of the `anamiR` package, the package contains 99 paired
miRNA and mRNA breast cancer samples, which are selected from 101 miRNA samples and
114 mRNA samples from GSE19536. As for phenotype data (hybridization information).

The mRNA data was conducted by Agilent-014850 Whole Human Genome Microarray 4x44K
G4112F (Probe Name version) platform and the miRNA data was generated from
Agilent-019118 Human miRNA Microarray 2.0 G4470B (miRNA ID version).

### 0.6.2 Format of Input Data

The same as the format in the first workflow.

```
require(data.table)
```

```
## Loading required package: data.table
```

```
aa <- system.file("extdata", "GSE19536_mrna.csv", package = "anamiR")
mrna <- fread(aa, fill = TRUE, header = TRUE)

bb <- system.file("extdata", "GSE19536_mirna.csv", package = "anamiR")
mirna <- fread(bb, fill = TRUE, header = TRUE)

cc <- system.file("extdata", "pheno_data.csv", package = "anamiR")
pheno.data <- fread(cc, fill = TRUE, header = TRUE)
```

transform the data format to matrix.

```
mirna_name <- mirna[["miRNA"]]
mrna_name <- mrna[["Gene"]]
mirna <- mirna[, -1]
mrna <- mrna[, -1]
mirna <- data.matrix(mirna)
mrna <- data.matrix(mrna)
row.names(mirna) <- mirna_name
row.names(mrna) <- mrna_name

pheno_name <- pheno.data[["Sample"]]
pheno.data <- pheno.data[, -1]
pheno.data <- as.matrix(pheno.data)
row.names(pheno.data) <- pheno_name
```

mrna expression data should be the same format as,

```
mrna[1:5, 1:5]
```

```
##          BC.M.002  BC.M.003  BC.M.014  BC.M.015  BC.M.017
## FAM174B 11.933085 12.336716 11.316612 12.897171 11.202400
## AP3S2    6.594222  6.782256  6.686422  8.184705  6.873914
## SV2B     9.507788  7.785795  6.931555  8.069596  8.076411
## RBPMS2   7.043462  6.432242  6.287466  7.160961  6.637851
## AVEN    10.858463 10.310998 10.218271 10.054989 10.924755
```

as for mirna,

```
mirna[1:5, 1:5]
```

```
##                BC.M.002  BC.M.003  BC.M.014  BC.M.015  BC.M.017
## hsa-let-7a-5p 13.265629 15.638350 13.895478 14.093235 13.073778
## hsa-let-7a-3p  2.655024  3.458061  3.773592  3.849688  1.625209
## hsa-let-7b-5p 12.896871 15.462644 14.169578 14.373066 12.913365
## hsa-let-7b-3p  1.805261  3.562475  3.441661  3.514808  2.697695
## hsa-let-7c-5p 11.920269 13.777391 12.585502 12.696483 11.707704
```

and phenotype data,

```
pheno.data[1:5, 1]
```

```
## BC.M.002 BC.M.003 BC.M.014 BC.M.015 BC.M.017
##   "case"   "case"   "case"   "case"   "case"
```

```
pheno.data[94:98, 1]
```

```
##  BC.M.551  BC.M.579  BC.M.627  BC.M.630  BC.M.709
## "control" "control" "control" "control" "control"
```

### 0.6.3 SummarizedExperiment class

Before entering the main workflow, we should put our data and phenotype
information into `SummarizedExperiment` class first, which you can get
more information from SummarizedExperiment.

```
mrna_se <- SummarizedExperiment::SummarizedExperiment(
    assays = S4Vectors::SimpleList(counts=mrna),
    colData = pheno.data)

mirna_se <- SummarizedExperiment::SummarizedExperiment(
    assays = S4Vectors::SimpleList(counts=mirna),
    colData = pheno.data)
```

### 0.6.4 GSEA analysis

First step, we use `GSEA_ana` function to find the pathways
which are the most likely enriched in given expreesion data.

```
table <- GSEA_ana(mrna_se = mrna_se, mirna_se = mirna_se, class = "ER", pathway_num = 2)
```

the result would be a list containg related genes and miRNAs
matrix for each pathway.

Note that because it would take a few minutes to run GSEA\_ana,
here we use the pre-calculated data to show the output.

```
data(table_pre)
```

For the first pathway,

```
names(table_pre)[1]
```

```
## [1] "CHARAFE_BREAST_CANCER_LUMINAL_VS_BASAL_UP - mirna"
```

```
table_pre[[1]][1:5, 1:5]
```

```
##                BC.M.002  BC.M.003  BC.M.014  BC.M.015  BC.M.017
## hsa-let-7a-5p 13.265629 15.638350 13.895478 14.093235 13.073778
## hsa-let-7a-3p  2.655024  3.458061  3.773592  3.849688  1.625209
## hsa-let-7b-5p 12.896871 15.462644 14.169578 14.373066 12.913365
## hsa-let-7b-3p  1.805261  3.562475  3.441661  3.514808  2.697695
## hsa-let-7d-5p  9.739521 11.480442 10.432780 10.410680  9.861024
```

```
names(table_pre)[2]
```

```
## [1] "CHARAFE_BREAST_CANCER_LUMINAL_VS_BASAL_UP - mrna"
```

```
table_pre[[2]][1:5, 1:5]
```

```
##         BC.M.002  BC.M.003  BC.M.014  BC.M.015  BC.M.017
## MYO5B  11.683596 11.635398 11.227723 11.580794 10.486385
## HPN     8.328735 11.169826  9.674486 12.917072 10.847883
## RSPH1   9.157633 11.376723 10.428724 11.192539 10.217411
## PI4KA  11.258279 10.465667  9.751591 11.539817 10.976314
## HMGCS2 10.151288  8.542307  6.256523  9.715437  8.422795
```

`GSEA_ana` intersects the related genes and miRNAs found
from databases with the given expression data.

### 0.6.5 GSEA Result

After doing GSEA analysis, we have selected miRNA and gene
expression data for each enriched pathway. As for the second
step, the generated odject would be put into `GSEA_res`.

```
result <- GSEA_res(table = table_pre, pheno.data = pheno.data, class = "ER", DE_method = "limma", cor_cut = 0)
```

This function helps us calculate P-value, Fold-Change,
Correlation for each miRNA-gene pair and show these
value to users.

```
names(result)[1]
```

```
## [1] "CHARAFE_BREAST_CANCER_LUMINAL_VS_BASAL_UP "
```

```
result[[1]]
```

```
##        miRNA_21          Gene_symbol     Ensembl           Gene_ID
##   [1,] "hsa-let-7b-3p"   "MYO5B"         "ENSG00000167306" "4645"
##   [2,] "hsa-let-7f-1-3p" "MYO5B"         "ENSG00000167306" "4645"
##   [3,] "hsa-miR-106b-3p" "RSPH1"         "ENSG00000160188" "89765"
##   [4,] "hsa-let-7d-5p"   "HMGCS2"        "ENSG00000134240" "3158"
##   [5,] "hsa-miR-103a-3p" "HMGCS2"        "ENSG00000134240" "3158"
##   [6,] "hsa-miR-105-5p"  "HMGCS2"        "ENSG00000134240" "3158"
##   [7,] "hsa-let-7i-3p"   "ANXA9"         "ENSG00000143412" "8416"
##   [8,] "hsa-miR-1-3p"    "ZNF84"         "ENSG00000198040" "7637"
##   [9,] "hsa-miR-106b-3p" "SERF2"         "ENSG00000140264" "10169"
##  [10,] "hsa-let-7f-2-3p" "RAB11FIP3"     "ENSG00000090565" "9727"
##  [11,] "hsa-let-7d-5p"   "SPDEF"         "ENSG00000124664" "25803"
##  [12,] "hsa-let-7i-5p"   "SPDEF"         "ENSG00000124664" "25803"
##  [13,] "hsa-let-7b-3p"   "VPS72"         "ENSG00000163159" "6944"
##  [14,] "hsa-let-7i-5p"   "HMG20B"        "ENSG00000064961" "10362"
##  [15,] "hsa-let-7i-3p"   "HMG20B"        "ENSG00000064961" "10362"
##  [16,] "hsa-miR-106b-3p" "CFD"           "ENSG00000197766" "1675"
##  [17,] "hsa-miR-103a-3p" "TTC3"          "ENSG00000182670" "7267"
##  [18,] "hsa-miR-106b-3p" "WFS1"          "ENSG00000109501" "7466"
##  [19,] "hsa-let-7i-5p"   "LLGL2"         "ENSG00000073350" "3993"
##  [20,] "hsa-miR-1-3p"    "LLGL2"         "ENSG00000073350" "3993"
##  [21,] "hsa-let-7b-5p"   "EPN3"          "ENSG00000049283" "55040"
##  [22,] "hsa-let-7d-5p"   "EPN3"          "ENSG00000049283" "55040"
##  [23,] "hsa-miR-100-5p"  "EPN3"          "ENSG00000049283" "55040"
##  [24,] "hsa-let-7b-5p"   "PYCR1"         "ENSG00000183010" "5831"
##  [25,] "hsa-let-7e-5p"   "PYCR1"         "ENSG00000183010" "5831"
##  [26,] "hsa-let-7i-5p"   "PYCR1"         "ENSG00000183010" "5831"
##  [27,] "hsa-miR-1-3p"    "PYCR1"         "ENSG00000183010" "5831"
##  [28,] "hsa-miR-103a-3p" "PYCR1"         "ENSG00000183010" "5831"
##  [29,] "hsa-let-7e-3p"   "GGA1"          "ENSG00000100083" "26088"
##  [30,] "hsa-miR-106b-3p" "GGA1"          "ENSG00000100083" "26088"
##  [31,] "hsa-miR-100-5p"  "SIDT1"         "ENSG00000072858" "54847"
##  [32,] "hsa-miR-106b-3p" "TBX3"          "ENSG00000135111" "6926"
##  [33,] "hsa-let-7e-5p"   "FAM46C"        "ENSG00000183508" "54855"
##  [34,] "hsa-miR-105-5p"  "FAM46C"        "ENSG00000183508" "54855"
##  [35,] "hsa-miR-106b-3p" "ABCA3"         "ENSG00000167972" "21"
##  [36,] "hsa-miR-106b-3p" "KLHL22"        "ENSG00000099910" "84861"
##  [37,] "hsa-miR-105-5p"  "THSD4"         "ENSG00000187720" "79875"
##  [38,] "hsa-miR-106b-3p" "THSD4"         "ENSG00000187720" "79875"
##  [39,] "hsa-let-7d-5p"   "CAPN9"         "ENSG00000135773" "10753"
##  [40,] "hsa-let-7i-3p"   "SLC16A6"       "ENSG00000108932" "9120"
##  [41,] "hsa-miR-105-5p"  "SLC16A6"       "ENSG00000108932" "9120"
##  [42,] "hsa-miR-106b-3p" "SLC16A6"       "ENSG00000108932" "9120"
##  [43,] "hsa-miR-105-5p"  "MLPH"          "ENSG00000115648" "79083"
##  [44,] "hsa-let-7a-5p"   "TMEM184A"      "ENSG00000164855" "202915"
##  [45,] "hsa-let-7b-5p"   "TMEM184A"      "ENSG00000164855" "202915"
##  [46,] "hsa-let-7d-5p"   "TMEM184A"      "ENSG00000164855" "202915"
##  [47,] "hsa-let-7e-5p"   "TMEM184A"      "ENSG00000164855" "202915"
##  [48,] "hsa-let-7f-5p"   "TMEM184A"      "ENSG00000164855" "202915"
##  [49,] "hsa-let-7g-5p"   "TMEM184A"      "ENSG00000164855" "202915"
##  [50,] "hsa-let-7i-5p"   "TMEM184A"      "ENSG00000164855" "202915"
##  [51,] "hsa-miR-100-5p"  "TTC39A"        "ENSG00000085831" "22996"
##  [52,] "hsa-let-7f-2-3p" "DNALI1"        "ENSG00000163879" "7802"
##  [53,] "hsa-let-7i-5p"   "ABCG1"         "ENSG00000160179" "9619"
##  [54,] "hsa-miR-100-5p"  "ABCG1"         "ENSG00000160179" "9619"
##  [55,] "hsa-let-7b-3p"   "GPR160"        "ENSG00000173890" "26996"
##  [56,] "hsa-let-7f-1-3p" "GPR160"        "ENSG00000173890" "26996"
##  [57,] "hsa-let-7f-2-3p" "GPR160"        "ENSG00000173890" "26996"
##  [58,] "hsa-miR-105-5p"  "GPR160"        "ENSG00000173890" "26996"
##  [59,] "hsa-let-7f-2-3p" "TSPAN13"       "ENSG00000106537" "27075"
##  [60,] "hsa-let-7f-2-3p" "TMEM57"        "ENSG00000204178" "55219"
##  [61,] "hsa-let-7b-5p"   "ZNF74"         "ENSG00000185252" "7625"
##  [62,] "hsa-let-7g-5p"   "ZNF74"         "ENSG00000185252" "7625"
##  [63,] "hsa-let-7b-3p"   "TNIP1"         "ENSG00000145901" "10318"
##  [64,] "hsa-let-7f-1-3p" "TNIP1"         "ENSG00000145901" "10318"
##  [65,] "hsa-let-7f-2-3p" "IQCE"          "ENSG00000106012" "23288"
##  [66,] "hsa-miR-105-5p"  "IQCE"          "ENSG00000106012" "23288"
##  [67,] "hsa-let-7d-3p"   "SNX27"         "ENSG00000143376" "81609"
##  [68,] "hsa-miR-105-5p"  "MAPT"          "ENSG00000186868" "4137"
##  [69,] "hsa-let-7b-5p"   "CSNK1D"        "ENSG00000141551" "1453"
##  [70,] "hsa-let-7e-5p"   "CSNK1D"        "ENSG00000141551" "1453"
##  [71,] "hsa-let-7g-5p"   "CSNK1D"        "ENSG00000141551" "1453"
##  [72,] "hsa-miR-1-3p"    "CSNK1D"        "ENSG00000141551" "1453"
##  [73,] "hsa-miR-101-3p"  "CSNK1D"        "ENSG00000141551" "1453"
##  [74,] "hsa-let-7b-3p"   "SYCP2"         "ENSG00000196074" "10388"
##  [75,] "hsa-let-7f-1-3p" "SYCP2"         "ENSG00000196074" "10388"
##  [76,] "hsa-let-7f-2-3p" "SYCP2"         "ENSG00000196074" "10388"
##  [77,] "hsa-miR-106b-3p" "CLSTN2"        "ENSG00000158258" "64084"
##  [78,] "hsa-miR-106b-3p" "ATP6AP1"       "ENSG00000071553" "537"
##  [79,] "hsa-let-7d-3p"   "SEC16A"        "ENSG00000148396" "9919"
##  [80,] "hsa-miR-1-3p"    "STRBP"         "ENSG00000165209" "55342"
##  [81,] "hsa-miR-101-3p"  "PGGT1B"        "ENSG00000164219" "5229"
##  [82,] "hsa-miR-106b-3p" "PGGT1B"        "ENSG00000164219" "5229"
##  [83,] "hsa-miR-106b-3p" "ZNF444"        "ENSG00000167685" "55311"
##  [84,] "hsa-let-7a-5p"   "C4orf19"       "ENSG00000154274" "55286"
##  [85,] "hsa-let-7b-5p"   "C4orf19"       "ENSG00000154274" "55286"
##  [86,] "hsa-miR-1-3p"    "C4orf19"       "ENSG00000154274" "55286"
##  [87,] "hsa-miR-106b-3p" "HEXDC"         "ENSG00000169660" "284004"
##  [88,] "hsa-let-7f-2-3p" "TAPT1"         "ENSG00000169762" "202018"
##  [89,] "hsa-let-7i-3p"   "C10orf82"      "ENSG00000165863" "143379"
##  [90,] "hsa-miR-106b-3p" "RHPN1"         "ENSG00000158106" "114822"
##  [91,] "hsa-let-7a-5p"   "ABHD11"        "ENSG00000106077" "83451"
##  [92,] "hsa-let-7b-5p"   "ABHD11"        "ENSG00000106077" "83451"
##  [93,] "hsa-let-7d-5p"   "ABHD11"        "ENSG00000106077" "83451"
##  [94,] "hsa-let-7d-3p"   "ABHD11"        "ENSG00000106077" "83451"
##  [95,] "hsa-let-7e-5p"   "ABHD11"        "ENSG00000106077" "83451"
##  [96,] "hsa-let-7f-5p"   "ABHD11"        "ENSG00000106077" "83451"
##  [97,] "hsa-let-7g-5p"   "ABHD11"        "ENSG00000106077" "83451"
##  [98,] "hsa-let-7i-5p"   "ABHD11"        "ENSG00000106077" "83451"
##  [99,] "hsa-miR-1-3p"    "ABHD11"        "ENSG00000106077" "83451"
## [100,] "hsa-miR-103a-3p" "ABHD11"        "ENSG00000106077" "83451"
## [101,] "hsa-let-7a-5p"   "ISG20"         "ENSG00000172183" "3669"
## [102,] "hsa-let-7b-5p"   "ISG20"         "ENSG00000172183" "3669"
## [103,] "hsa-let-7d-3p"   "ISG20"         "ENSG00000172183" "3669"
## [104,] "hsa-let-7f-5p"   "ISG20"         "ENSG00000172183" "3669"
## [105,] "hsa-miR-1-3p"    "ISG20"         "ENSG00000172183" "3669"
## [106,] "hsa-let-7i-3p"   "GPRC5C"        "ENSG00000170412" "55890"
## [107,] "hsa-miR-101-5p"  "GPRC5C"        "ENSG00000170412" "55890"
## [108,] "hsa-miR-103a-3p" "GPRC5C"        "ENSG00000170412" "55890"
## [109,] "hsa-miR-1-3p"    "MGRN1"         "ENSG00000102858" "23295"
## [110,] "hsa-miR-106b-3p" "MGRN1"         "ENSG00000102858" "23295"
## [111,] "hsa-miR-106b-3p" "STARD10"       "ENSG00000214530" "10809"
## [112,] "hsa-let-7f-2-3p" "SNED1"         "ENSG00000162804" "25992"
## [113,] "hsa-miR-103a-3p" "SNED1"         "ENSG00000162804" "25992"
## [114,] "hsa-let-7i-3p"   "EFR3B"         "ENSG00000084710" "22979"
## [115,] "hsa-miR-101-5p"  "EFR3B"         "ENSG00000084710" "22979"
## [116,] "hsa-miR-1-3p"    "SLC38A10"      "ENSG00000157637" "124565"
## [117,] "hsa-miR-106b-3p" "DUSP8"         "ENSG00000184545" "1850"
## [118,] "hsa-let-7i-3p"   "FAM110B"       "ENSG00000169122" "90362"
## [119,] "hsa-miR-106b-3p" "FAM110B"       "ENSG00000169122" "90362"
## [120,] "hsa-miR-103a-3p" "HIP1R"         "ENSG00000130787" "9026"
## [121,] "hsa-miR-106b-3p" "HIP1R"         "ENSG00000130787" "9026"
## [122,] "hsa-let-7d-5p"   "CXXC5"         "ENSG00000171604" "51523"
## [123,] "hsa-let-7i-5p"   "CXXC5"         "ENSG00000171604" "51523"
## [124,] "hsa-let-7i-3p"   "CXXC5"         "ENSG00000171604" "51523"
## [125,] "hsa-let-7b-3p"   "DKFZP586I1420" ""                "222161"
## [126,] "hsa-let-7f-1-3p" "DKFZP586I1420" ""                "222161"
## [127,] "hsa-miR-105-5p"  "DKFZP586I1420" ""                "222161"
## [128,] "hsa-miR-105-5p"  "ELOVL2"        "ENSG00000197977" "54898"
## [129,] "hsa-miR-106b-3p" "ELOVL2"        "ENSG00000197977" "54898"
## [130,] "hsa-let-7e-3p"   "CCDC117"       "ENSG00000159873" "150275"
## [131,] "hsa-miR-100-5p"  "CCDC117"       "ENSG00000159873" "150275"
## [132,] "hsa-miR-106b-3p" "CCDC117"       "ENSG00000159873" "150275"
## [133,] "hsa-let-7i-3p"   "LFNG"          "ENSG00000106003" "3955"
## [134,] "hsa-let-7a-5p"   "DENND1A"       "ENSG00000119522" "57706"
## [135,] "hsa-let-7b-5p"   "DENND1A"       "ENSG00000119522" "57706"
## [136,] "hsa-let-7e-5p"   "DENND1A"       "ENSG00000119522" "57706"
## [137,] "hsa-let-7f-5p"   "DENND1A"       "ENSG00000119522" "57706"
## [138,] "hsa-let-7g-5p"   "DENND1A"       "ENSG00000119522" "57706"
## [139,] "hsa-miR-101-3p"  "DENND1A"       "ENSG00000119522" "57706"
## [140,] "hsa-miR-103a-3p" "DENND1A"       "ENSG00000119522" "57706"
## [141,] "hsa-miR-101-3p"  "RND1"          "ENSG00000172602" "27289"
## [142,] "hsa-miR-105-5p"  "RND1"          "ENSG00000172602" "27289"
## [143,] "hsa-let-7b-3p"   "RHOH"          "ENSG00000168421" "399"
## [144,] "hsa-let-7f-1-3p" "RHOH"          "ENSG00000168421" "399"
## [145,] "hsa-miR-106b-3p" "ZNF467"        "ENSG00000181444" "168544"
## [146,] "hsa-let-7a-5p"   "PLCXD1"        "ENSG00000182378" "55344"
## [147,] "hsa-let-7a-3p"   "PLCXD1"        "ENSG00000182378" "55344"
## [148,] "hsa-let-7b-5p"   "PLCXD1"        "ENSG00000182378" "55344"
## [149,] "hsa-let-7e-5p"   "PLCXD1"        "ENSG00000182378" "55344"
## [150,] "hsa-let-7e-3p"   "PLCXD1"        "ENSG00000182378" "55344"
## [151,] "hsa-let-7f-5p"   "PLCXD1"        "ENSG00000182378" "55344"
## [152,] "hsa-let-7f-1-3p" "PLCXD1"        "ENSG00000182378" "55344"
## [153,] "hsa-miR-103a-3p" "PLCXD1"        "ENSG00000182378" "55344"
## [154,] "hsa-let-7b-5p"   "SBK1"          "ENSG00000188322" "388228"
## [155,] "hsa-miR-100-5p"  "DHRS13"        "ENSG00000167536" "147015"
## [156,] "hsa-let-7i-3p"   "KRT19"         "ENSG00000171345" "3880"
## [157,] "hsa-let-7b-3p"   "CACYBP"        "ENSG00000116161" "27101"
## [158,] "hsa-miR-1-3p"    "MYEF2"         "ENSG00000104177" "50804"
## [159,] "hsa-miR-100-5p"  "MYEF2"         "ENSG00000104177" "50804"
## [160,] "hsa-miR-1-3p"    "TGIF2"         "ENSG00000118707" "60436"
## [161,] "hsa-miR-1-3p"    "SLC24A3"       "ENSG00000185052" "57419"
## [162,] "hsa-miR-105-5p"  "KLHDC9"        "ENSG00000162755" "126823"
## [163,] "hsa-let-7i-5p"   "SLC1A4"        "ENSG00000115902" "6509"
## [164,] "hsa-let-7i-3p"   "SLC1A4"        "ENSG00000115902" "6509"
## [165,] "hsa-miR-1-3p"    "SLC1A4"        "ENSG00000115902" "6509"
## [166,] "hsa-miR-106b-3p" "SLC1A4"        "ENSG00000115902" "6509"
## [167,] "hsa-let-7a-5p"   "GRAMD4"        "ENSG00000075240" "23151"
## [168,] "hsa-let-7b-5p"   "GRAMD4"        "ENSG00000075240" "23151"
## [169,] "hsa-let-7e-5p"   "GRAMD4"        "ENSG00000075240" "23151"
## [170,] "hsa-let-7g-5p"   "GRAMD4"        "ENSG00000075240" "23151"
## [171,] "hsa-miR-101-3p"  "GRAMD4"        "ENSG00000075240" "23151"
## [172,] "hsa-miR-103a-3p" "GRAMD4"        "ENSG00000075240" "23151"
## [173,] "hsa-miR-106b-3p" "GRAMD4"        "ENSG00000075240" "23151"
## [174,] "hsa-miR-105-5p"  "SLC44A4"       "ENSG00000204385" "80736"
## [175,] "hsa-miR-103a-3p" "SIDT2"         "ENSG00000149577" "51092"
## [176,] "hsa-miR-106b-3p" "SIDT2"         "ENSG00000149577" "51092"
## [177,] "hsa-let-7a-5p"   "KIAA1211"      "ENSG00000109265" "57482"
## [178,] "hsa-let-7a-3p"   "KIAA1211"      "ENSG00000109265" "57482"
## [179,] "hsa-let-7b-5p"   "KIAA1211"      "ENSG00000109265" "57482"
## [180,] "hsa-let-7e-5p"   "KIAA1211"      "ENSG00000109265" "57482"
## [181,] "hsa-let-7f-5p"   "KIAA1211"      "ENSG00000109265" "57482"
## [182,] "hsa-let-7g-5p"   "KIAA1211"      "ENSG00000109265" "57482"
## [183,] "hsa-miR-101-5p"  "KIAA1211"      "ENSG00000109265" "57482"
## [184,] "hsa-let-7a-5p"   "ZFYVE16"       "ENSG00000039319" "9765"
## [185,] "hsa-let-7b-5p"   "ZFYVE16"       "ENSG00000039319" "9765"
## [186,] "hsa-miR-103a-3p" "ZFYVE16"       "ENSG00000039319" "9765"
## [187,] "hsa-miR-100-5p"  "ZNF703"        "ENSG00000183779" "80139"
## [188,] "hsa-miR-106b-3p" "ZNF703"        "ENSG00000183779" "80139"
## [189,] "hsa-let-7f-2-3p" "FOXA1"         "ENSG00000129514" "3169"
## [190,] "hsa-let-7i-3p"   "FOXA1"         "ENSG00000129514" "3169"
## [191,] "hsa-miR-105-5p"  "FOXA1"         "ENSG00000129514" "3169"
## [192,] "hsa-miR-101-3p"  "SYNGR2"        "ENSG00000108639" "9144"
## [193,] "hsa-miR-100-5p"  "TBL1X"         "ENSG00000101849" "6907"
## [194,] "hsa-miR-105-5p"  "TBL1X"         "ENSG00000101849" "6907"
## [195,] "hsa-let-7a-3p"   "SFMBT2"        "ENSG00000198879" "57713"
## [196,] "hsa-let-7b-5p"   "SFMBT2"        "ENSG00000198879" "57713"
## [197,] "hsa-let-7b-3p"   "SFMBT2"        "ENSG00000198879" "57713"
## [198,] "hsa-let-7f-1-3p" "SFMBT2"        "ENSG00000198879" "57713"
## [199,] "hsa-miR-103a-3p" "SFMBT2"        "ENSG00000198879" "57713"
## [200,] "hsa-miR-105-5p"  "SFMBT2"        "ENSG00000198879" "57713"
## [201,] "hsa-let-7i-5p"   "NUCB2"         "ENSG00000070081" "4925"
## [202,] "hsa-miR-100-5p"  "NUCB2"         "ENSG00000070081" "4925"
## [203,] "hsa-miR-106b-3p" "NUCB2"         "ENSG00000070081" "4925"
## [204,] "hsa-let-7i-5p"   "CACNG4"        "ENSG00000075461" "27092"
## [205,] "hsa-miR-1-3p"    "CACNG4"        "ENSG00000075461" "27092"
## [206,] "hsa-let-7b-5p"   "DLG3"          "ENSG00000082458" "1741"
## [207,] "hsa-let-7e-5p"   "DLG3"          "ENSG00000082458" "1741"
## [208,] "hsa-miR-105-5p"  "LONRF2"        "ENSG00000170500" "164832"
##        DIANA_microT_CDS EIMMo Microcosm miRDB miRanda PITA rna22 Targetscan
##   [1,] 0                1     0         0     1       0    0     0
##   [2,] 0                1     0         0     1       0    0     0
##   [3,] 0                0     0         0     0       0    1     0
##   [4,] 0                1     0         0     0       0    0     0
##   [5,] 1                1     0         0     1       0    0     1
##   [6,] 1                0     0         0     0       0    0     0
##   [7,] 0                1     0         0     0       0    0     0
##   [8,] 1                1     0         0     0       0    0     0
##   [9,] 0                0     0         0     0       0    1     0
##  [10,] 0                0     0         0     1       0    0     0
##  [11,] 0                1     0         0     0       0    0     0
##  [12,] 0                1     0         0     0       0    0     0
##  [13,] 0                0     0         0     1       0    0     0
##  [14,] 0                0     0         0     0       0    1     0
##  [15,] 0                0     1         0     0       0    0     0
##  [16,] 0                0     0         0     0       0    1     0
##  [17,] 0                1     0         0     1       0    0     0
##  [18,] 0                0     0         0     0       0    1     0
##  [19,] 0                0     1         0     0       0    0     0
##  [20,] 0                1     0         0     0       0    0     0
##  [21,] 0                0     0         0     1       0    0     0
##  [22,] 1                0     0         0     0       0    0     0
##  [23,] 0                0     0         0     1       0    0     0
##  [24,] 0                0     0         0     0       0    1     0
##  [25,] 0                0     0         0     0       0    0     0
##  [26,] 0                0     0         0     1       0    0     0
##  [27,] 0                0     0         0     0       0    0     1
##  [28,] 0                1     0         0     0       0    0     0
##  [29,] 0                0     1         0     0       0    0     0
##  [30,] 0                1     0         0     0       0    0     0
##  [31,] 0                0     0         0     1       0    0     0
##  [32,] 1                1     1         0     1       0    0     0
##  [33,] 1                1     0         0     0       0    0     0
##  [34,] 0                0     0         0     0       1    0     0
##  [35,] 0                1     0         0     0       0    0     0
##  [36,] 0                1     0         0     0       0    1     0
##  [37,] 1                1     1         0     0       0    0     0
##  [38,] 0                1     1         0     0       0    0     0
##  [39,] 0                1     0         0     1       0    0     0
##  [40,] 0                1     0         0     0       0    0     0
##  [41,] 0                1     0         0     1       0    0     0
##  [42,] 0                0     0         0     0       0    1     0
##  [43,] 1                1     0         0     1       0    0     0
##  [44,] 0                1     0         0     0       0    1     0
##  [45,] 0                1     0         0     0       0    0     0
##  [46,] 1                1     0         0     0       0    1     0
##  [47,] 0                1     0         0     0       0    1     0
##  [48,] 0                1     0         0     0       0    0     0
##  [49,] 0                1     0         0     0       0    0     0
##  [50,] 0                1     0         0     0       0    0     0
##  [51,] 0                1     0         1     1       1    0     0
##  [52,] 1                0     0         0     1       0    0     0
##  [53,] 0                0     0         0     0       0    1     0
##  [54,] 0                0     1         0     0       0    0     0
##  [55,] 0                1     0         0     0       0    0     0
##  [56,] 0                1     0         0     0       0    0     0
##  [57,] 0                1     0         0     0       0    0     0
##  [58,] 0                0     0         0     1       0    0     0
##  [59,] 1                1     0         0     1       0    0     0
##  [60,] 0                0     0         0     1       0    0     0
##  [61,] 0                1     0         0     0       0    0     0
##  [62,] 0                1     0         0     0       0    0     0
##  [63,] 0                1     0         0     1       0    0     0
##  [64,] 0                1     0         0     1       0    0     0
##  [65,] 0                1     0         0     0       0    0     0
##  [66,] 0                0     0         0     0       0    1     0
##  [67,] 0                0     0         0     1       0    0     0
##  [68,] 0                1     0         0     0       0    0     0
##  [69,] 0                1     0         0     0       0    0     0
##  [70,] 0                1     0         0     0       0    0     0
##  [71,] 0                1     0         0     0       0    0     0
##  [72,] 0                0     0         0     1       0    0     0
##  [73,] 1                0     0         0     0       0    0     1
##  [74,] 0                1     0         0     0       0    0     0
##  [75,] 0                1     0         0     1       0    0     0
##  [76,] 1                1     1         1     1       0    0     0
##  [77,] 0                0     0         0     1       0    0     0
##  [78,] 0                1     0         0     0       0    0     0
##  [79,] 0                0     0         0     0       0    1     0
##  [80,] 1                1     0         0     0       0    0     1
##  [81,] 1                1     0         0     1       0    0     1
##  [82,] 0                0     0         0     1       0    0     0
##  [83,] 0                1     0         0     0       0    0     0
##  [84,] 0                1     0         0     0       0    0     0
##  [85,] 0                1     0         0     0       0    0     0
##  [86,] 0                1     0         0     0       0    0     0
##  [87,] 0                0     1         0     0       0    0     0
##  [88,] 1                1     0         0     1       0    0     0
##  [89,] 0                1     0         0     0       0    0     0
##  [90,] 0                1     0         0     0       0    0     0
##  [91,] 0                1     0         0     0       0    0     0
##  [92,] 0                1     0         0     1       0    0     0
##  [93,] 0                1     0         0     0       0    0     0
##  [94,] 0                0     1         0     0       0    0     0
##  [95,] 0                1     0         0     0       0    0     0
##  [96,] 0                1     0         0     0       0    0     0
##  [97,] 0                1     0         0     1       0    0     0
##  [98,] 0                1     1         0     1       0    0     0
##  [99,] 0                0     0         0     0       0    0     0
## [100,] 0                1     0         0     0       0    0     1
## [101,] 0                0     1         0     0       0    0     0
## [102,] 0                0     1         0     0       0    0     0
## [103,] 0                0     0         0     0       0    1     0
## [104,] 0                0     1         0     0       0    0     0
## [105,] 0                0     0         0     0       0    0     0
## [106,] 0                0     0         0     0       0    1     0
## [107,] 0                0     0         0     0       0    1     0
## [108,] 0                1     0         0     0       0    0     0
## [109,] 0                0     0         0     0       0    1     0
## [110,] 0                1     0         0     0       0    0     0
## [111,] 0                0     1         0     0       0    0     0
## [112,] 0                1     0         0     0       0    0     0
## [113,] 0                1     0         0     0       0    0     0
## [114,] 0                0     0         0     0       0    1     0
## [115,] 0                0     0         0     0       0    1     0
## [116,] 0                1     0         0     0       0    0     1
## [117,] 1                1     1         0     1       0    0     0
## [118,] 0                0     1         0     0       0    0     0
## [119,] 0                1     1         0     1       0    0     0
## [120,] 0                1     0         0     0       0    0     0
## [121,] 0                1     0         0     0       0    0     0
## [122,] 0                1     0         0     0       0    0     0
## [123,] 0                1     0         0     0       0    0     0
## [124,] 0                1     0         0     0       0    0     0
## [125,] 0                0     0         0     1       0    0     0
## [126,] 0                0     0         0     1       0    0     0
## [127,] 0                0     0         0     1       0    0     0
## [128,] 1                1     0         1     1       0    0     0
## [129,] 0                1     0         0     0       0    0     0
## [130,] 1                0     0         0     0       0    0     0
## [131,] 1                0     0         0     0       0    0     0
## [132,] 0                1     0         0     0       0    0     0
## [133,] 0                1     0         0     0       0    1     0
## [134,] 0                1     0         0     0       0    0     0
## [135,] 0                1     0         0     0       0    0     0
## [136,] 0                1     0         0     0       0    0     0
## [137,] 0                1     0         0     0       0    0     0
## [138,] 0                1     0         0     0       0    0     0
## [139,] 0                1     0         0     0       0    0     0
## [140,] 1                0     0         0     0       0    0     1
## [141,] 0                0     0         0     1       0    0     0
## [142,] 1                1     0         0     1       1    0     0
## [143,] 1                1     0         0     1       0    0     0
## [144,] 1                1     0         0     1       0    0     0
## [145,] 0                1     0         0     0       0    0     0
## [146,] 1                0     0         0     0       0    0     0
## [147,] 1                0     0         0     0       0    0     0
## [148,] 1                0     1         0     0       0    0     0
## [149,] 1                0     0         0     0       0    0     0
## [150,] 0                0     0         0     0       0    1     0
## [151,] 1                0     0         0     0       0    0     0
## [152,] 1                0     0         0     1       0    0     0
## [153,] 0                0     0         0     0       0    1     0
## [154,] 1                1     0         0     0       0    0     1
## [155,] 0                1     0         0     0       0    0     0
## [156,] 0                1     0         0     0       0    0     0
## [157,] 0                1     0         0     0       0    0     0
## [158,] 0                1     0         0     1       1    0     1
## [159,] 0                0     0         0     1       0    0     0
## [160,] 1                1     0         0     1       0    0     0
## [161,] 1                1     0         0     0       0    0     0
## [162,] 0                1     0         0     0       0    0     0
## [163,] 1                1     0         0     1       1    0     0
## [164,] 0                1     0         0     0       0    1     0
## [165,] 0                1     0         0     0       0    0     0
## [166,] 0                0     0         0     0       0    1     0
## [167,] 0                1     0         0     0       0    0     0
## [168,] 0                1     0         0     0       0    0     0
## [169,] 0                1     0         0     0       0    0     0
## [170,] 0                1     0         0     0       0    0     0
## [171,] 1                1     0         0     1       1    0     1
## [172,] 0                1     0         0     0       0    0     0
## [173,] 0                1     0         0     0       0    0     0
## [174,] 0                1     0         0     0       0    0     0
## [175,] 1                1     0         0     0       0    0     0
## [176,] 0                1     0         0     0       0    0     0
## [177,] 0                1     0         0     0       0    0     1
## [178,] 0                1     0         0     1       0    0     0
## [179,] 0                1     0         0     0       0    0     0
## [180,] 0                1     0         0     0       0    0     0
## [181,] 0                1     0         0     0       0    0     0
## [182,] 0                1     0         0     0       0    0     0
## [183,] 0                0     0         0     1       0    0     0
## [184,] 1                1     0         0     1       1    0     0
## [185,] 1                1     0         0     1       1    0     0
## [186,] 0                0     0         1     1       0    0     0
## [187,] 0                0     1         0     0       0    0     0
## [188,] 0                0     1         0     0       0    0     0
## [189,] 1                0     0         0     1       0    0     0
## [190,] 0                1     0         0     0       0    0     0
## [191,] 1                0     0         0     1       0    0     0
## [192,] 0                0     0         0     1       0    0     0
## [193,] 0                1     0         0     0       0    0     0
## [194,] 1                1     0         0     1       0    0     0
## [195,] 1                0     0         0     0       0    0     0
## [196,] 1                1     0         0     0       0    0     0
## [197,] 1                0     0         0     0       0    0     0
## [198,] 1                0     0         0     0       0    0     0
## [199,] 1                1     0         0     0       0    0     0
## [200,] 1                1     0         0     0       0    0     0
## [201,] 1                0     0         0     0       0    0     0
## [202,] 0                0     1         0     0       0    0     0
## [203,] 0                0     0         0     1       0    0     0
## [204,] 0                1     0         0     1       1    0     0
## [205,] 1                1     0         0     1       0    0     0
## [206,] 0                0     0         0     0       0    1     0
## [207,] 0                0     0         0     0       0    1     0
## [208,] 1                1     0         0     0       0    0     0
##        Sum miRecords miRTarBase Validate Correlation( 0 )
##   [1,] 2   0         0          "FALSE"  "-0.00469329458275759"
##   [2,] 2   0         0          "FALSE"  "-0.026803017193859"
##   [3,] 1   0         0          "FALSE"  "-0.160745567601311"
##   [4,] 1   0         0          "FALSE"  "-0.111964048541342"
##   [5,] 4   0         0          "FALSE"  "-0.101357243121489"
##   [6,] 1   0         0          "FALSE"  "-0.0138595925653847"
##   [7,] 1   0         0          "FALSE"  "-0.0493985280901175"
##   [8,] 2   0         0          "FALSE"  "-0.0129238223686879"
##   [9,] 1   0         0          "FALSE"  "-0.0665867533017747"
##  [10,] 1   0         0          "FALSE"  "-0.0564326046509687"
##  [11,] 1   0         0          "FALSE"  "-0.0459942601748237"
##  [12,] 1   0         0          "FALSE"  "-0.0736721307003247"
##  [13,] 1   0         0          "FALSE"  "-0.0247048756048784"
##  [14,] 1   0         0          "FALSE"  "-0.0282557589021449"
##  [15,] 1   0         0          "FALSE"  "-0.139497841212745"
##  [16,] 1   0         0          "FALSE"  "-0.202114297419076"
##  [17,] 2   0         0          "FALSE"  "-0.0340419828768836"
##  [18,] 1   0         0          "FALSE"  "-0.173814257426519"
##  [19,] 1   0         0          "FALSE"  "-0.0377887870473492"
##  [20,] 1   0         0          "FALSE"  "-0.00437566645359563"
##  [21,] 1   0         0          "FALSE"  "-0.0690182848141104"
##  [22,] 1   0         0          "FALSE"  "-0.192730189701922"
##  [23,] 1   0         0          "FALSE"  "-0.124900788830998"
##  [24,] 1   0         0          "FALSE"  "-0.0746142430648831"
##  [25,] 0   0         1          "TRUE"   "-0.10602416731452"
##  [26,] 1   0         0          "FALSE"  "-0.0344292287371299"
##  [27,] 1   0         0          "FALSE"  "-0.0785143844421945"
##  [28,] 1   0         0          "FALSE"  "-0.0410779417225139"
##  [29,] 1   0         0          "FALSE"  "-0.0454305279633042"
##  [30,] 1   0         0          "FALSE"  "-0.0349988603196793"
##  [31,] 1   0         0          "FALSE"  "-0.0141626858752407"
##  [32,] 4   0         0          "FALSE"  "-0.0822283193088585"
##  [33,] 2   0         0          "FALSE"  "-0.0604113554871089"
##  [34,] 1   0         0          "FALSE"  "-0.0203223156891843"
##  [35,] 1   0         0          "FALSE"  "-0.115734682603499"
##  [36,] 2   0         0          "FALSE"  "-0.00432212791596763"
##  [37,] 3   0         0          "FALSE"  "-0.0534159788289955"
##  [38,] 2   0         0          "FALSE"  "-0.246049858460371"
##  [39,] 2   0         0          "FALSE"  "-0.0071521882579686"
##  [40,] 1   0         0          "FALSE"  "-0.100898169242734"
##  [41,] 2   0         0          "FALSE"  "-0.00200040458554424"
##  [42,] 1   0         0          "FALSE"  "-0.169642024353886"
##  [43,] 3   0         0          "FALSE"  "-0.0148017844400933"
##  [44,] 2   0         0          "FALSE"  "-0.0732159489190473"
##  [45,] 1   0         0          "FALSE"  "-0.13518772101538"
##  [46,] 3   0         0          "FALSE"  "-0.0390888970943003"
##  [47,] 2   0         0          "FALSE"  "-0.0273816812836608"
##  [48,] 1   0         0          "FALSE"  "-0.0157707076358428"
##  [49,] 1   0         0          "FALSE"  "-0.0900948416232156"
##  [50,] 1   0         0          "FALSE"  "-0.155527063583308"
##  [51,] 4   0         0          "FALSE"  "-0.0173644681089988"
##  [52,] 2   0         0          "FALSE"  "-0.079831022998766"
##  [53,] 1   0         0          "FALSE"  "-0.00255998389069238"
##  [54,] 1   0         0          "FALSE"  "-0.0817444527295079"
##  [55,] 1   0         0          "FALSE"  "-0.0435133887663125"
##  [56,] 1   0         0          "FALSE"  "-0.0648260542173642"
##  [57,] 1   0         0          "FALSE"  "-0.111139803499355"
##  [58,] 1   0         0          "FALSE"  "-0.0260413357680768"
##  [59,] 3   0         0          "FALSE"  "-0.0163612525393968"
##  [60,] 1   0         0          "FALSE"  "-0.0695257974504453"
##  [61,] 1   0         0          "FALSE"  "-0.0412623460405872"
##  [62,] 1   0         0          "FALSE"  "-0.0195641118842683"
##  [63,] 2   0         0          "FALSE"  "-0.00238088236483886"
##  [64,] 2   0         0          "FALSE"  "-0.0351031159735516"
##  [65,] 1   0         0          "FALSE"  "-0.0765302572779514"
##  [66,] 1   0         0          "FALSE"  "-0.0222647475081597"
##  [67,] 1   0         0          "FALSE"  "-0.0376332495812914"
##  [68,] 1   0         0          "FALSE"  "-0.0584480443897348"
##  [69,] 1   0         1          "TRUE"   "-0.0351889800902353"
##  [70,] 1   0         0          "FALSE"  "-0.0828608450534563"
##  [71,] 1   0         0          "FALSE"  "-0.0249917822697364"
##  [72,] 1   0         0          "FALSE"  "-0.0245841663095478"
##  [73,] 2   0         0          "FALSE"  "-0.0408393201437719"
##  [74,] 1   0         0          "FALSE"  "-0.00472945993817595"
##  [75,] 2   0         0          "FALSE"  "-0.108476180046981"
##  [76,] 5   0         0          "FALSE"  "-0.0716325467108868"
##  [77,] 1   0         0          "FALSE"  "-0.0576418474845019"
##  [78,] 1   0         0          "FALSE"  "-0.00970440394200319"
##  [79,] 1   0         0          "FALSE"  "-0.0830020201853157"
##  [80,] 3   0         0          "FALSE"  "-0.054160466135176"
##  [81,] 4   0         0          "FALSE"  "-0.0271760407350081"
##  [82,] 1   0         0          "FALSE"  "-0.0358427677256584"
##  [83,] 1   0         0          "FALSE"  "-0.058034455549039"
##  [84,] 1   0         0          "FALSE"  "-0.0429066437295362"
##  [85,] 1   0         0          "FALSE"  "-0.130449896054702"
##  [86,] 1   0         0          "FALSE"  "-0.151273635131331"
##  [87,] 1   0         0          "FALSE"  "-0.039744653296719"
##  [88,] 3   0         0          "FALSE"  "-0.0451579052452179"
##  [89,] 1   0         0          "FALSE"  "-0.0299938982569402"
##  [90,] 1   0         0          "FALSE"  "-0.0950125795664926"
##  [91,] 1   0         0          "FALSE"  "-0.20116287467963"
##  [92,] 2   0         0          "FALSE"  "-0.219314853824572"
##  [93,] 1   0         0          "FALSE"  "-0.115977183999841"
##  [94,] 1   0         0          "FALSE"  "-0.104332959579403"
##  [95,] 1   0         0          "FALSE"  "-0.107095725822984"
##  [96,] 1   0         0          "FALSE"  "-0.151368320928965"
##  [97,] 2   0         0          "FALSE"  "-0.128497771519202"
##  [98,] 3   0         0          "FALSE"  "-0.123583054545899"
##  [99,] 0   0         1          "TRUE"   "-0.0390063073534936"
## [100,] 2   0         0          "FALSE"  "-0.056173338446142"
## [101,] 1   0         0          "FALSE"  "-0.097656761169652"
## [102,] 1   0         0          "FALSE"  "-0.257021654065956"
## [103,] 1   0         0          "FALSE"  "-0.0690016072561739"
## [104,] 1   0         0          "FALSE"  "-0.0150605613671584"
## [105,] 0   0         1          "TRUE"   "-0.18124075540884"
## [106,] 1   0         0          "FALSE"  "-0.0101757786578789"
## [107,] 1   0         0          "FALSE"  "-0.0331220298035206"
## [108,] 1   0         0          "FALSE"  "-0.00394057958050813"
## [109,] 1   0         0          "FALSE"  "-0.0145831749276612"
## [110,] 1   0         0          "FALSE"  "-0.0561175516080145"
## [111,] 1   0         0          "FALSE"  "-0.119570155944897"
## [112,] 1   0         0          "FALSE"  "-0.058225569486375"
## [113,] 1   0         0          "FALSE"  "-0.120724326456088"
## [114,] 1   0         0          "FALSE"  "-0.0680166897997314"
## [115,] 1   0         0          "FALSE"  "-0.049807040142193"
## [116,] 2   0         0          "FALSE"  "-0.105681085626406"
## [117,] 4   0         0          "FALSE"  "-0.119231337341744"
## [118,] 1   0         0          "FALSE"  "-0.0938743003752882"
## [119,] 3   0         0          "FALSE"  "-0.226685031063792"
## [120,] 1   0         0          "FALSE"  "-0.070813384908843"
## [121,] 1   0         0          "FALSE"  "-0.0602364327741436"
## [122,] 1   0         0          "FALSE"  "-0.0296976569649153"
## [123,] 1   0         0          "FALSE"  "-0.146829408454961"
## [124,] 1   0         0          "FALSE"  "-0.126825052930146"
## [125,] 1   0         0          "FALSE"  "-0.192139087005256"
## [126,] 1   0         0          "FALSE"  "-0.245961400752861"
## [127,] 1   0         0          "FALSE"  "-0.160354054590504"
## [128,] 4   0         0          "FALSE"  "-0.00817700606888721"
## [129,] 1   0         0          "FALSE"  "-0.166165736860862"
## [130,] 1   0         0          "FALSE"  "-0.020591098341203"
## [131,] 1   0         0          "FALSE"  "-0.156550368224252"
## [132,] 1   0         0          "FALSE"  "-0.00340707573051329"
## [133,] 2   0         0          "FALSE"  "-0.163885469526453"
## [134,] 1   0         0          "FALSE"  "-0.115324291439957"
## [135,] 1   0         0          "FALSE"  "-0.202342752181346"
## [136,] 1   0         0          "FALSE"  "-0.155479324387455"
## [137,] 1   0         0          "FALSE"  "-0.0540145088887996"
## [138,] 1   0         0          "FALSE"  "-0.0224334977028391"
## [139,] 1   0         0          "FALSE"  "-0.104625832313338"
## [140,] 2   0         0          "FALSE"  "-0.108540941652119"
## [141,] 1   0         0          "FALSE"  "-0.0766236447481583"
## [142,] 4   0         0          "FALSE"  "-0.125361353868268"
## [143,] 3   0         0          "FALSE"  "-0.0604414780172276"
## [144,] 3   0         0          "FALSE"  "-0.0739512843673057"
## [145,] 1   0         0          "FALSE"  "-0.145557019847801"
## [146,] 1   0         0          "FALSE"  "-0.0440783400191794"
## [147,] 1   0         0          "FALSE"  "-0.0344401414239305"
## [148,] 2   0         0          "FALSE"  "-0.113223203527758"
## [149,] 1   0         1          "TRUE"   "-0.0616939347447661"
## [150,] 1   0         0          "FALSE"  "-0.107974718298354"
## [151,] 1   0         0          "FALSE"  "-0.00569716655807841"
## [152,] 2   0         0          "FALSE"  "-0.0256859656450377"
## [153,] 1   0         0          "FALSE"  "-0.00331831710821351"
## [154,] 3   0         0          "FALSE"  "-0.0226451835679747"
## [155,] 1   0         0          "FALSE"  "-0.0833785911473021"
## [156,] 1   0         0          "FALSE"  "-0.204935297589399"
## [157,] 1   0         0          "FALSE"  "-0.00491598822446839"
## [158,] 4   0         1          "TRUE"   "-0.0625430156898712"
## [159,] 1   0         0          "FALSE"  "-0.0302015522570322"
## [160,] 3   0         0          "FALSE"  "-0.0177008472006125"
## [161,] 2   0         0          "FALSE"  "-0.0694300616335995"
## [162,] 1   0         0          "FALSE"  "-0.104518550024666"
## [163,] 4   0         0          "FALSE"  "-0.0121717274157986"
## [164,] 2   0         0          "FALSE"  "-0.164940310465331"
## [165,] 1   0         0          "FALSE"  "-0.00350777845481623"
## [166,] 1   0         0          "FALSE"  "-0.0656903184542091"
## [167,] 1   0         0          "FALSE"  "-0.0122239422959904"
## [168,] 1   0         0          "FALSE"  "-0.0696453990415214"
## [169,] 1   0         0          "FALSE"  "-0.156265954349996"
## [170,] 1   0         0          "FALSE"  "-0.0150296203705942"
## [171,] 5   0         0          "FALSE"  "-0.0201860012584755"
## [172,] 1   0         0          "FALSE"  "-0.0832663530915705"
## [173,] 1   0         0          "FALSE"  "-0.0118018214239647"
## [174,] 1   0         0          "FALSE"  "-0.0456494530357291"
## [175,] 2   0         0          "FALSE"  "-0.0171192541550353"
## [176,] 1   0         0          "FALSE"  "-0.182969916489946"
## [177,] 2   0         0          "FALSE"  "-0.078930113173772"
## [178,] 2   0         0          "FALSE"  "-0.0245626961130111"
## [179,] 1   0         0          "FALSE"  "-0.109259974409534"
## [180,] 1   0         0          "FALSE"  "-0.0678909792151139"
## [181,] 1   0         0          "FALSE"  "-0.0353851406857655"
## [182,] 1   0         0          "FALSE"  "-0.0264400615492675"
## [183,] 1   0         0          "FALSE"  "-0.042513000852672"
## [184,] 4   0         0          "FALSE"  "-0.0180079166104844"
## [185,] 4   0         0          "FALSE"  "-0.0160010452631988"
## [186,] 2   0         0          "FALSE"  "-0.0557495511343818"
## [187,] 1   0         0          "FALSE"  "-0.162973238495035"
## [188,] 1   0         0          "FALSE"  "-0.093420459285713"
## [189,] 2   0         0          "FALSE"  "-0.0207866845099378"
## [190,] 1   0         0          "FALSE"  "-0.0861313367496941"
## [191,] 2   0         0          "FALSE"  "-0.147112989994077"
## [192,] 1   0         0          "FALSE"  "-0.0571812656679315"
## [193,] 1   0         0          "FALSE"  "-0.0899548646481515"
## [194,] 3   0         0          "FALSE"  "-0.0921118130054476"
## [195,] 1   0         0          "FALSE"  "-0.156938750282532"
## [196,] 2   0         0          "FALSE"  "-0.0737659137840028"
## [197,] 1   0         0          "FALSE"  "-0.0314932092951809"
## [198,] 1   0         0          "FALSE"  "-0.037838514663787"
## [199,] 2   0         0          "FALSE"  "-0.00126378564005593"
## [200,] 2   0         0          "FALSE"  "-0.0325585079645554"
## [201,] 1   0         1          "TRUE"   "-0.0719658449360214"
## [202,] 1   0         0          "FALSE"  "-0.00099687991162299"
## [203,] 1   0         0          "FALSE"  "-0.130902782548756"
## [204,] 3   0         0          "FALSE"  "-0.0604463809017228"
## [205,] 3   0         0          "FALSE"  "-0.0448347830995044"
## [206,] 1   0         0          "FALSE"  "-0.158427805002612"
## [207,] 1   0         0          "FALSE"  "-0.128727704613367"
## [208,] 2   0         0          "FALSE"  "-0.131492575727561"
##        logratio(miRNA)        P-adjust(miRNA)        mean_case(miRNA)
##   [1,] "0.260930386290323"    "0.246997134412268"    "2.71811076129032"
##   [2,] "0.12843422015233"     "0.524207090686478"    "1.98063033209677"
##   [3,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##   [4,] "-0.00435579659498231" "0.975457378262621"    "10.5471040645161"
##   [5,] "0.395326186827957"    "0.00801637073812844"  "11.2174993951613"
##   [6,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
##   [7,] "-0.0418024902374552"  "0.884721897720132"    "1.79228402129032"
##   [8,] "0.313214337043011"    "0.432025621108341"    "3.60085180370968"
##   [9,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##  [10,] "0.0133768047777778"   "0.972760477429415"    "0.7742908005"
##  [11,] "-0.00435579659498231" "0.975457378262621"    "10.5471040645161"
##  [12,] "-0.143935879032258"   "0.325068307671028"    "11.5634993709677"
##  [13,] "0.260930386290323"    "0.246997134412268"    "2.71811076129032"
##  [14,] "-0.143935879032258"   "0.325068307671028"    "11.5634993709677"
##  [15,] "-0.0418024902374552"  "0.884721897720132"    "1.79228402129032"
##  [16,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##  [17,] "0.395326186827957"    "0.00801637073812844"  "11.2174993951613"
##  [18,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##  [19,] "-0.143935879032258"   "0.325068307671028"    "11.5634993709677"
##  [20,] "0.313214337043011"    "0.432025621108341"    "3.60085180370968"
##  [21,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
##  [22,] "-0.00435579659498231" "0.975457378262621"    "10.5471040645161"
##  [23,] "-0.25095749767025"    "0.19228460871898"     "9.24812269677419"
##  [24,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
##  [25,] "0.483138913530466"    "0.00459245770983532"  "10.6757934274194"
##  [26,] "-0.143935879032258"   "0.325068307671028"    "11.5634993709677"
##  [27,] "0.313214337043011"    "0.432025621108341"    "3.60085180370968"
##  [28,] "0.395326186827957"    "0.00801637073812844"  "11.2174993951613"
##  [29,] "0.5615149596819"      "0.00247854366880183"  "2.34753278870968"
##  [30,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##  [31,] "-0.25095749767025"    "0.19228460871898"     "9.24812269677419"
##  [32,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##  [33,] "0.483138913530466"    "0.00459245770983532"  "10.6757934274194"
##  [34,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
##  [35,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##  [36,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##  [37,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
##  [38,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##  [39,] "-0.00435579659498231" "0.975457378262621"    "10.5471040645161"
##  [40,] "-0.0418024902374552"  "0.884721897720132"    "1.79228402129032"
##  [41,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
##  [42,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##  [43,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
##  [44,] "0.393125512992832"    "0.0358146963292343"   "14.1567251935484"
##  [45,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
##  [46,] "-0.00435579659498231" "0.975457378262621"    "10.5471040645161"
##  [47,] "0.483138913530466"    "0.00459245770983532"  "10.6757934274194"
##  [48,] "0.263929851254481"    "0.184062819074797"    "13.7247531290323"
##  [49,] "0.141142457437276"    "0.432025621108341"    "11.9694836935484"
##  [50,] "-0.143935879032258"   "0.325068307671028"    "11.5634993709677"
##  [51,] "-0.25095749767025"    "0.19228460871898"     "9.24812269677419"
##  [52,] "0.0133768047777778"   "0.972760477429415"    "0.7742908005"
##  [53,] "-0.143935879032258"   "0.325068307671028"    "11.5634993709677"
##  [54,] "-0.25095749767025"    "0.19228460871898"     "9.24812269677419"
##  [55,] "0.260930386290323"    "0.246997134412268"    "2.71811076129032"
##  [56,] "0.12843422015233"     "0.524207090686478"    "1.98063033209677"
##  [57,] "0.0133768047777778"   "0.972760477429415"    "0.7742908005"
##  [58,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
##  [59,] "0.0133768047777778"   "0.972760477429415"    "0.7742908005"
##  [60,] "0.0133768047777778"   "0.972760477429415"    "0.7742908005"
##  [61,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
##  [62,] "0.141142457437276"    "0.432025621108341"    "11.9694836935484"
##  [63,] "0.260930386290323"    "0.246997134412268"    "2.71811076129032"
##  [64,] "0.12843422015233"     "0.524207090686478"    "1.98063033209677"
##  [65,] "0.0133768047777778"   "0.972760477429415"    "0.7742908005"
##  [66,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
##  [67,] "0.153662880080645"    "0.436254579533941"    "2.87293672258065"
##  [68,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
##  [69,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
##  [70,] "0.483138913530466"    "0.00459245770983532"  "10.6757934274194"
##  [71,] "0.141142457437276"    "0.432025621108341"    "11.9694836935484"
##  [72,] "0.313214337043011"    "0.432025621108341"    "3.60085180370968"
##  [73,] "0.355484058870967"    "0.0309691965546709"   "9.51399518387097"
##  [74,] "0.260930386290323"    "0.246997134412268"    "2.71811076129032"
##  [75,] "0.12843422015233"     "0.524207090686478"    "1.98063033209677"
##  [76,] "0.0133768047777778"   "0.972760477429415"    "0.7742908005"
##  [77,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##  [78,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##  [79,] "0.153662880080645"    "0.436254579533941"    "2.87293672258065"
##  [80,] "0.313214337043011"    "0.432025621108341"    "3.60085180370968"
##  [81,] "0.355484058870967"    "0.0309691965546709"   "9.51399518387097"
##  [82,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##  [83,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##  [84,] "0.393125512992832"    "0.0358146963292343"   "14.1567251935484"
##  [85,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
##  [86,] "0.313214337043011"    "0.432025621108341"    "3.60085180370968"
##  [87,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##  [88,] "0.0133768047777778"   "0.972760477429415"    "0.7742908005"
##  [89,] "-0.0418024902374552"  "0.884721897720132"    "1.79228402129032"
##  [90,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
##  [91,] "0.393125512992832"    "0.0358146963292343"   "14.1567251935484"
##  [92,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
##  [93,] "-0.00435579659498231" "0.975457378262621"    "10.5471040645161"
##  [94,] "0.153662880080645"    "0.436254579533941"    "2.87293672258065"
##  [95,] "0.483138913530466"    "0.00459245770983532"  "10.6757934274194"
##  [96,] "0.263929851254481"    "0.184062819074797"    "13.7247531290323"
##  [97,] "0.141142457437276"    "0.432025621108341"    "11.9694836935484"
##  [98,] "-0.143935879032258"   "0.325068307671028"    "11.5634993709677"
##  [99,] "0.313214337043011"    "0.432025621108341"    "3.60085180370968"
## [100,] "0.395326186827957"    "0.00801637073812844"  "11.2174993951613"
## [101,] "0.393125512992832"    "0.0358146963292343"   "14.1567251935484"
## [102,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
## [103,] "0.153662880080645"    "0.436254579533941"    "2.87293672258065"
## [104,] "0.263929851254481"    "0.184062819074797"    "13.7247531290323"
## [105,] "0.313214337043011"    "0.432025621108341"    "3.60085180370968"
## [106,] "-0.0418024902374552"  "0.884721897720132"    "1.79228402129032"
## [107,] "0.579902692123656"    "0.00107084889770573"  "2.45416823629032"
## [108,] "0.395326186827957"    "0.00801637073812844"  "11.2174993951613"
## [109,] "0.313214337043011"    "0.432025621108341"    "3.60085180370968"
## [110,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
## [111,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
## [112,] "0.0133768047777778"   "0.972760477429415"    "0.7742908005"
## [113,] "0.395326186827957"    "0.00801637073812844"  "11.2174993951613"
## [114,] "-0.0418024902374552"  "0.884721897720132"    "1.79228402129032"
## [115,] "0.579902692123656"    "0.00107084889770573"  "2.45416823629032"
## [116,] "0.313214337043011"    "0.432025621108341"    "3.60085180370968"
## [117,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
## [118,] "-0.0418024902374552"  "0.884721897720132"    "1.79228402129032"
## [119,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
## [120,] "0.395326186827957"    "0.00801637073812844"  "11.2174993951613"
## [121,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
## [122,] "-0.00435579659498231" "0.975457378262621"    "10.5471040645161"
## [123,] "-0.143935879032258"   "0.325068307671028"    "11.5634993709677"
## [124,] "-0.0418024902374552"  "0.884721897720132"    "1.79228402129032"
## [125,] "0.260930386290323"    "0.246997134412268"    "2.71811076129032"
## [126,] "0.12843422015233"     "0.524207090686478"    "1.98063033209677"
## [127,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
## [128,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
## [129,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
## [130,] "0.5615149596819"      "0.00247854366880183"  "2.34753278870968"
## [131,] "-0.25095749767025"    "0.19228460871898"     "9.24812269677419"
## [132,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
## [133,] "-0.0418024902374552"  "0.884721897720132"    "1.79228402129032"
## [134,] "0.393125512992832"    "0.0358146963292343"   "14.1567251935484"
## [135,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
## [136,] "0.483138913530466"    "0.00459245770983532"  "10.6757934274194"
## [137,] "0.263929851254481"    "0.184062819074797"    "13.7247531290323"
## [138,] "0.141142457437276"    "0.432025621108341"    "11.9694836935484"
## [139,] "0.355484058870967"    "0.0309691965546709"   "9.51399518387097"
## [140,] "0.395326186827957"    "0.00801637073812844"  "11.2174993951613"
## [141,] "0.355484058870967"    "0.0309691965546709"   "9.51399518387097"
## [142,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
## [143,] "0.260930386290323"    "0.246997134412268"    "2.71811076129032"
## [144,] "0.12843422015233"     "0.524207090686478"    "1.98063033209677"
## [145,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
## [146,] "0.393125512992832"    "0.0358146963292343"   "14.1567251935484"
## [147,] "0.542315739964158"    "0.00391914122085866"  "3.24683051774194"
## [148,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
## [149,] "0.483138913530466"    "0.00459245770983532"  "10.6757934274194"
## [150,] "0.5615149596819"      "0.00247854366880183"  "2.34753278870968"
## [151,] "0.263929851254481"    "0.184062819074797"    "13.7247531290323"
## [152,] "0.12843422015233"     "0.524207090686478"    "1.98063033209677"
## [153,] "0.395326186827957"    "0.00801637073812844"  "11.2174993951613"
## [154,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
## [155,] "-0.25095749767025"    "0.19228460871898"     "9.24812269677419"
## [156,] "-0.0418024902374552"  "0.884721897720132"    "1.79228402129032"
## [157,] "0.260930386290323"    "0.246997134412268"    "2.71811076129032"
## [158,] "0.313214337043011"    "0.432025621108341"    "3.60085180370968"
## [159,] "-0.25095749767025"    "0.19228460871898"     "9.24812269677419"
## [160,] "0.313214337043011"    "0.432025621108341"    "3.60085180370968"
## [161,] "0.313214337043011"    "0.432025621108341"    "3.60085180370968"
## [162,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
## [163,] "-0.143935879032258"   "0.325068307671028"    "11.5634993709677"
## [164,] "-0.0418024902374552"  "0.884721897720132"    "1.79228402129032"
## [165,] "0.313214337043011"    "0.432025621108341"    "3.60085180370968"
## [166,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
## [167,] "0.393125512992832"    "0.0358146963292343"   "14.1567251935484"
## [168,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
## [169,] "0.483138913530466"    "0.00459245770983532"  "10.6757934274194"
## [170,] "0.141142457437276"    "0.432025621108341"    "11.9694836935484"
## [171,] "0.355484058870967"    "0.0309691965546709"   "9.51399518387097"
## [172,] "0.395326186827957"    "0.00801637073812844"  "11.2174993951613"
## [173,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
## [174,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
## [175,] "0.395326186827957"    "0.00801637073812844"  "11.2174993951613"
## [176,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
## [177,] "0.393125512992832"    "0.0358146963292343"   "14.1567251935484"
## [178,] "0.542315739964158"    "0.00391914122085866"  "3.24683051774194"
## [179,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
## [180,] "0.483138913530466"    "0.00459245770983532"  "10.6757934274194"
## [181,] "0.263929851254481"    "0.184062819074797"    "13.7247531290323"
## [182,] "0.141142457437276"    "0.432025621108341"    "11.9694836935484"
## [183,] "0.579902692123656"    "0.00107084889770573"  "2.45416823629032"
## [184,] "0.393125512992832"    "0.0358146963292343"   "14.1567251935484"
## [185,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
## [186,] "0.395326186827957"    "0.00801637073812844"  "11.2174993951613"
## [187,] "-0.25095749767025"    "0.19228460871898"     "9.24812269677419"
## [188,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
## [189,] "0.0133768047777778"   "0.972760477429415"    "0.7742908005"
## [190,] "-0.0418024902374552"  "0.884721897720132"    "1.79228402129032"
## [191,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
## [192,] "0.355484058870967"    "0.0309691965546709"   "9.51399518387097"
## [193,] "-0.25095749767025"    "0.19228460871898"     "9.24812269677419"
## [194,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
## [195,] "0.542315739964158"    "0.00391914122085866"  "3.24683051774194"
## [196,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
## [197,] "0.260930386290323"    "0.246997134412268"    "2.71811076129032"
## [198,] "0.12843422015233"     "0.524207090686478"    "1.98063033209677"
## [199,] "0.395326186827957"    "0.00801637073812844"  "11.2174993951613"
## [200,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
## [201,] "-0.143935879032258"   "0.325068307671028"    "11.5634993709677"
## [202,] "-0.25095749767025"    "0.19228460871898"     "9.24812269677419"
## [203,] "-0.459609872320788"   "0.0268114568476553"   "1.12506766529032"
## [204,] "-0.143935879032258"   "0.325068307671028"    "11.5634993709677"
## [205,] "0.313214337043011"    "0.432025621108341"    "3.60085180370968"
## [206,] "0.75106936469534"     "0.000849277717515689" "13.9084079758065"
## [207,] "0.483138913530466"    "0.00459245770983532"  "10.6757934274194"
## [208,] "-0.297657890803763"   "0.291928618591068"    "0.663438186612903"
##        mean_control(miRNA) logratio(gene)         P-adjust(gene)
##   [1,] "2.457180375"       "-0.274279164157706"   "0.281564520324039"
##   [2,] "1.85219611194444"  "-0.274279164157706"   "0.281564520324039"
##   [3,] "1.58467753761111"  "1.40108635589606"     "8.14361477201009e-07"
##   [4,] "10.5514598611111"  "0.78136412939068"     "0.0987135836521272"
##   [5,] "10.8221732083333"  "0.78136412939068"     "0.0987135836521272"
##   [6,] "0.961096077416667" "0.78136412939068"     "0.0987135836521272"
##   [7,] "1.83408651152778"  "1.87866651555555"     "1.82994795998066e-10"
##   [8,] "3.28763746666667"  "0.0972127002867378"   "0.503271933096673"
##   [9,] "1.58467753761111"  "0.0906114629928325"   "0.531674114312941"
##  [10,] "0.760913995722222" "0.819136647858423"    "2.19655014733162e-06"
##  [11,] "10.5514598611111"  "1.7955132184319"      "6.27250368110013e-07"
##  [12,] "11.70743525"       "1.7955132184319"      "6.27250368110013e-07"
##  [13,] "2.457180375"       "-0.105646599740144"   "0.593239706283949"
##  [14,] "11.70743525"       "0.164426834256274"    "0.271222847223139"
##  [15,] "1.83408651152778"  "0.164426834256274"    "0.271222847223139"
##  [16,] "1.58467753761111"  "0.645890723118278"    "0.074741476439557"
##  [17,] "10.8221732083333"  "0.150630936514338"    "0.439420706609033"
##  [18,] "1.58467753761111"  "0.746969606577062"    "0.000155434840252826"
##  [19,] "11.70743525"       "-0.066785074435483"   "0.749079073583798"
##  [20,] "3.28763746666667"  "-0.066785074435483"   "0.749079073583798"
##  [21,] "13.1573386111111"  "0.327663989318998"    "0.169736522335655"
##  [22,] "10.5514598611111"  "0.327663989318998"    "0.169736522335655"
##  [23,] "9.49908019444444"  "0.327663989318998"    "0.169736522335655"
##  [24,] "13.1573386111111"  "-0.400548569892473"   "0.0632670560653719"
##  [25,] "10.1926545138889"  "-0.400548569892473"   "0.0632670560653719"
##  [26,] "11.70743525"       "-0.400548569892473"   "0.0632670560653719"
##  [27,] "3.28763746666667"  "-0.400548569892473"   "0.0632670560653719"
##  [28,] "10.8221732083333"  "-0.400548569892473"   "0.0632670560653719"
##  [29,] "1.78601782902778"  "-0.0940064069892461"  "0.621866321796862"
##  [30,] "1.58467753761111"  "-0.0940064069892461"  "0.621866321796862"
##  [31,] "9.49908019444444"  "0.681921928566307"    "0.00156729450897665"
##  [32,] "1.58467753761111"  "0.676254081989248"    "0.00369409623615164"
##  [33,] "10.1926545138889"  "0.165081362293908"    "0.41024072512539"
##  [34,] "0.961096077416667" "0.165081362293908"    "0.41024072512539"
##  [35,] "1.58467753761111"  "0.816552631550179"    "0.00253061523327468"
##  [36,] "1.58467753761111"  "-0.0221023723207887"  "0.890466217213773"
##  [37,] "0.961096077416667" "2.16992893517921"     "1.41095482197442e-11"
##  [38,] "1.58467753761111"  "2.16992893517921"     "1.41095482197442e-11"
##  [39,] "10.5514598611111"  "0.595871673933692"    "0.0468488370475683"
##  [40,] "1.83408651152778"  "0.921755124498208"    "4.66907829461033e-05"
##  [41,] "0.961096077416667" "0.921755124498208"    "4.66907829461033e-05"
##  [42,] "1.58467753761111"  "0.921755124498208"    "4.66907829461033e-05"
##  [43,] "0.961096077416667" "1.35908654586022"     "1.97154136219981e-07"
##  [44,] "13.7635996805556"  "-0.0689702640681009"  "0.774529370564702"
##  [45,] "13.1573386111111"  "-0.0689702640681009"  "0.774529370564702"
##  [46,] "10.5514598611111"  "-0.0689702640681009"  "0.774529370564702"
##  [47,] "10.1926545138889"  "-0.0689702640681009"  "0.774529370564702"
##  [48,] "13.4608232777778"  "-0.0689702640681009"  "0.774529370564702"
##  [49,] "11.8283412361111"  "-0.0689702640681009"  "0.774529370564702"
##  [50,] "11.70743525"       "-0.0689702640681009"  "0.774529370564702"
##  [51,] "9.49908019444444"  "0.880217813790322"    "0.000586725931820622"
##  [52,] "0.760913995722222" "2.42536514608423"     "1.36168143234451e-11"
##  [53,] "11.70743525"       "0.653742176137994"    "0.000101460941640254"
##  [54,] "9.49908019444444"  "0.653742176137994"    "0.000101460941640254"
##  [55,] "2.457180375"       "1.04988091651434"     "0.000513088481147208"
##  [56,] "1.85219611194444"  "1.04988091651434"     "0.000513088481147208"
##  [57,] "0.760913995722222" "1.04988091651434"     "0.000513088481147208"
##  [58,] "0.961096077416667" "1.04988091651434"     "0.000513088481147208"
##  [59,] "0.760913995722222" "1.06418007429212"     "0.000101460941640254"
##  [60,] "0.760913995722222" "0.0701641049372768"   "0.673339317627116"
##  [61,] "13.1573386111111"  "-0.304281804910394"   "0.0240460862473942"
##  [62,] "11.8283412361111"  "-0.304281804910394"   "0.0240460862473942"
##  [63,] "2.457180375"       "-0.0284001860483869"  "0.840033441773759"
##  [64,] "1.85219611194444"  "-0.0284001860483869"  "0.840033441773759"
##  [65,] "0.760913995722222" "0.315794221200717"    "0.0860814380769875"
##  [66,] "0.961096077416667" "0.315794221200717"    "0.0860814380769875"
##  [67,] "2.7192738425"      "0.129616373969533"    "0.446847057822629"
##  [68,] "0.961096077416667" "1.20351927226702"     "2.84479739057599e-06"
##  [69,] "13.1573386111111"  "-0.0794770483333327"  "0.635312896541165"
##  [70,] "10.1926545138889"  "-0.0794770483333327"  "0.635312896541165"
##  [71,] "11.8283412361111"  "-0.0794770483333327"  "0.635312896541165"
##  [72,] "3.28763746666667"  "-0.0794770483333327"  "0.635312896541165"
##  [73,] "9.158511125"       "-0.0794770483333327"  "0.635312896541165"
##  [74,] "2.457180375"       "0.800439898378136"    "0.00057597286814142"
##  [75,] "1.85219611194444"  "0.800439898378136"    "0.00057597286814142"
##  [76,] "0.760913995722222" "0.800439898378136"    "0.00057597286814142"
##  [77,] "1.58467753761111"  "1.2497375746147"      "5.7965482617752e-07"
##  [78,] "1.58467753761111"  "0.353898591039426"    "0.0640225432216981"
##  [79,] "2.7192738425"      "0.363128905824373"    "0.0961216832746928"
##  [80,] "3.28763746666667"  "0.273498156424731"    "0.100856256540663"
##  [81,] "9.158511125"       "0.0485400201075263"   "0.632344165687227"
##  [82,] "1.58467753761111"  "0.0485400201075263"   "0.632344165687227"
##  [83,] "1.58467753761111"  "0.494635142025089"    "0.000534573799705414"
##  [84,] "13.7635996805556"  "-0.102791621890681"   "0.673339317627116"
##  [85,] "13.1573386111111"  "-0.102791621890681"   "0.673339317627116"
##  [86,] "3.28763746666667"  "-0.102791621890681"   "0.673339317627116"
##  [87,] "1.58467753761111"  "0.3698449615681"      "0.0110193216376923"
##  [88,] "0.760913995722222" "0.779465988888889"    "4.44564910293446e-06"
##  [89,] "1.83408651152778"  "0.437748235528674"    "0.0240460862473942"
##  [90,] "1.58467753761111"  "0.443096507786738"    "0.0385530970099399"
##  [91,] "13.7635996805556"  "-0.0246945528673823"  "0.910752168339817"
##  [92,] "13.1573386111111"  "-0.0246945528673823"  "0.910752168339817"
##  [93,] "10.5514598611111"  "-0.0246945528673823"  "0.910752168339817"
##  [94,] "2.7192738425"      "-0.0246945528673823"  "0.910752168339817"
##  [95,] "10.1926545138889"  "-0.0246945528673823"  "0.910752168339817"
##  [96,] "13.4608232777778"  "-0.0246945528673823"  "0.910752168339817"
##  [97,] "11.8283412361111"  "-0.0246945528673823"  "0.910752168339817"
##  [98,] "11.70743525"       "-0.0246945528673823"  "0.910752168339817"
##  [99,] "3.28763746666667"  "-0.0246945528673823"  "0.910752168339817"
## [100,] "10.8221732083333"  "-0.0246945528673823"  "0.910752168339817"
## [101,] "13.7635996805556"  "-0.498722641487454"   "0.0771122458248699"
## [102,] "13.1573386111111"  "-0.498722641487454"   "0.0771122458248699"
## [103,] "2.7192738425"      "-0.498722641487454"   "0.0771122458248699"
## [104,] "13.4608232777778"  "-0.498722641487454"   "0.0771122458248699"
## [105,] "3.28763746666667"  "-0.498722641487454"   "0.0771122458248699"
## [106,] "1.83408651152778"  "0.0183046245340499"   "0.940240541374255"
## [107,] "1.87426554416667"  "0.0183046245340499"   "0.940240541374255"
## [108,] "10.8221732083333"  "0.0183046245340499"   "0.940240541374255"
## [109,] "3.28763746666667"  "0.224791879390681"    "0.212354345352163"
## [110,] "1.58467753761111"  "0.224791879390681"    "0.212354345352163"
## [111,] "1.58467753761111"  "1.3043305822491"      "2.07386469276697e-06"
## [112,] "0.760913995722222" "0.341289856120072"    "0.121257033313765"
## [113,] "10.8221732083333"  "0.341289856120072"    "0.121257033313765"
## [114,] "1.83408651152778"  "-0.105737552652331"   "0.206890146000646"
## [115,] "1.87426554416667"  "-0.105737552652331"   "0.206890146000646"
## [116,] "3.28763746666667"  "-0.118856767464158"   "0.521457651001563"
## [117,] "1.58467753761111"  "0.264439281191757"    "0.184845095152697"
## [118,] "1.83408651152778"  "1.04312231704301"     "9.08341136279668e-06"
## [119,] "1.58467753761111"  "1.04312231704301"     "9.08341136279668e-06"
## [120,] "10.8221732083333"  "-0.16410807750896"    "0.415702996804968"
## [121,] "1.58467753761111"  "-0.16410807750896"    "0.415702996804968"
## [122,] "10.5514598611111"  "1.2476072950448"      "3.96488583623637e-09"
## [123,] "11.70743525"       "1.2476072950448"      "3.96488583623637e-09"
## [124,] "1.83408651152778"  "1.2476072950448"      "3.96488583623637e-09"
## [125,] "2.457180375"       "0.283849083288532"    "0.128522317430866"
## [126,] "1.85219611194444"  "0.283849083288532"    "0.128522317430866"
## [127,] "0.961096077416667" "0.283849083288532"    "0.128522317430866"
## [128,] "0.961096077416667" "0.152084021379928"    "0.212354345352163"
## [129,] "1.58467753761111"  "0.152084021379928"    "0.212354345352163"
## [130,] "1.78601782902778"  "0.464959122473118"    "0.0628744699958889"
## [131,] "9.49908019444444"  "0.464959122473118"    "0.0628744699958889"
## [132,] "1.58467753761111"  "0.464959122473118"    "0.0628744699958889"
## [133,] "1.83408651152778"  "0.00191829141577138"  "0.988192045399355"
## [134,] "13.7635996805556"  "-0.34094438077957"    "0.00860241915390606"
## [135,] "13.1573386111111"  "-0.34094438077957"    "0.00860241915390606"
## [136,] "10.1926545138889"  "-0.34094438077957"    "0.00860241915390606"
## [137,] "13.4608232777778"  "-0.34094438077957"    "0.00860241915390606"
## [138,] "11.8283412361111"  "-0.34094438077957"    "0.00860241915390606"
## [139,] "9.158511125"       "-0.34094438077957"    "0.00860241915390606"
## [140,] "10.8221732083333"  "-0.34094438077957"    "0.00860241915390606"
## [141,] "9.158511125"       "0.176846033360215"    "0.531674114312941"
## [142,] "0.961096077416667" "0.176846033360215"    "0.531674114312941"
## [143,] "2.457180375"       "0.75743010047491"     "0.00822001518267293"
## [144,] "1.85219611194444"  "0.75743010047491"     "0.00822001518267293"
## [145,] "1.58467753761111"  "0.0889274530555548"   "0.438985017202481"
## [146,] "13.7635996805556"  "-0.0858636887096775"  "0.635312896541165"
## [147,] "2.70451477777778"  "-0.0858636887096775"  "0.635312896541165"
## [148,] "13.1573386111111"  "-0.0858636887096775"  "0.635312896541165"
## [149,] "10.1926545138889"  "-0.0858636887096775"  "0.635312896541165"
## [150,] "1.78601782902778"  "-0.0858636887096775"  "0.635312896541165"
## [151,] "13.4608232777778"  "-0.0858636887096775"  "0.635312896541165"
## [152,] "1.85219611194444"  "-0.0858636887096775"  "0.635312896541165"
## [153,] "10.8221732083333"  "-0.0858636887096775"  "0.635312896541165"
## [154,] "13.1573386111111"  "-0.0602517025089604"  "0.483384061251613"
## [155,] "9.49908019444444"  "0.26857133719534"     "0.304507379361637"
## [156,] "1.83408651152778"  "0.137811671953404"    "0.561702568129719"
## [157,] "2.457180375"       "-0.138744352688173"   "0.508609150568473"
## [158,] "3.28763746666667"  "0.0955080030824371"   "0.490359594244203"
## [159,] "9.49908019444444"  "0.0955080030824371"   "0.490359594244203"
## [160,] "3.28763746666667"  "-0.00965798807347618" "0.943896953941426"
## [161,] "3.28763746666667"  "0.487373240026882"    "0.117462359699773"
## [162,] "0.961096077416667" "1.42145250612007"     "3.22387671732929e-06"
## [163,] "11.70743525"       "0.245562178243727"    "0.287198185723224"
## [164,] "1.83408651152778"  "0.245562178243727"    "0.287198185723224"
## [165,] "3.28763746666667"  "0.245562178243727"    "0.287198185723224"
## [166,] "1.58467753761111"  "0.245562178243727"    "0.287198185723224"
## [167,] "13.7635996805556"  "-0.154042436890681"   "0.121257033313765"
## [168,] "13.1573386111111"  "-0.154042436890681"   "0.121257033313765"
## [169,] "10.1926545138889"  "-0.154042436890681"   "0.121257033313765"
## [170,] "11.8283412361111"  "-0.154042436890681"   "0.121257033313765"
## [171,] "9.158511125"       "-0.154042436890681"   "0.121257033313765"
## [172,] "10.8221732083333"  "-0.154042436890681"   "0.121257033313765"
## [173,] "1.58467753761111"  "-0.154042436890681"   "0.121257033313765"
## [174,] "0.961096077416667" "1.80042208596774"     "4.38369761870984e-07"
## [175,] "10.8221732083333"  "0.287680863620073"    "0.0452363910101052"
## [176,] "1.58467753761111"  "0.287680863620073"    "0.0452363910101052"
## [177,] "13.7635996805556"  "-0.0531431949910388"  "0.635312896541165"
## [178,] "2.70451477777778"  "-0.0531431949910388"  "0.635312896541165"
## [179,] "13.1573386111111"  "-0.0531431949910388"  "0.635312896541165"
## [180,] "10.1926545138889"  "-0.0531431949910388"  "0.635312896541165"
## [181,] "13.4608232777778"  "-0.0531431949910388"  "0.635312896541165"
## [182,] "11.8283412361111"  "-0.0531431949910388"  "0.635312896541165"
## [183,] "1.87426554416667"  "-0.0531431949910388"  "0.635312896541165"
## [184,] "13.7635996805556"  "-0.0325320655555563"  "0.726113082768401"
## [185,] "13.1573386111111"  "-0.0325320655555563"  "0.726113082768401"
## [186,] "10.8221732083333"  "-0.0325320655555563"  "0.726113082768401"
## [187,] "9.49908019444444"  "0.412350103136201"    "0.00243787567434807"
## [188,] "1.58467753761111"  "0.412350103136201"    "0.00243787567434807"
## [189,] "0.760913995722222" "2.62871618991935"     "8.47951826309877e-09"
## [190,] "1.83408651152778"  "2.62871618991935"     "8.47951826309877e-09"
## [191,] "0.961096077416667" "2.62871618991935"     "8.47951826309877e-09"
## [192,] "9.158511125"       "0.181959138969535"    "0.521610045686861"
## [193,] "9.49908019444444"  "0.307198805071685"    "0.0654869415933698"
## [194,] "0.961096077416667" "0.307198805071685"    "0.0654869415933698"
## [195,] "2.70451477777778"  "-0.0458736311648744"  "0.631603981354613"
## [196,] "13.1573386111111"  "-0.0458736311648744"  "0.631603981354613"
## [197,] "2.457180375"       "-0.0458736311648744"  "0.631603981354613"
## [198,] "1.85219611194444"  "-0.0458736311648744"  "0.631603981354613"
## [199,] "10.8221732083333"  "-0.0458736311648744"  "0.631603981354613"
## [200,] "0.961096077416667" "-0.0458736311648744"  "0.631603981354613"
## [201,] "11.70743525"       "0.565640802553762"    "0.00860241915390606"
## [202,] "9.49908019444444"  "0.565640802553762"    "0.00860241915390606"
## [203,] "1.58467753761111"  "0.565640802553762"    "0.00860241915390606"
## [204,] "11.70743525"       "0.551519544363799"    "0.00658763061704287"
## [205,] "3.28763746666667"  "0.551519544363799"    "0.00658763061704287"
## [206,] "13.1573386111111"  "-0.250514620394266"   "0.0513344437604453"
## [207,] "10.1926545138889"  "-0.250514620394266"   "0.0513344437604453"
## [208,] "0.961096077416667" "2.25645131103943"     "3.6511553203874e-11"
##        mean_case(gene)    mean_control(gene) de novo
##   [1,] "11.2184064330645" "11.4926855972222" 0
##   [2,] "11.2184064330645" "11.4926855972222" 0
##   [3,] "10.8860943914516" "9.48500803555556" 0
##   [4,] "8.5685921366129"  "7.78722800722222" 0
##   [5,] "8.5685921366129"  "7.78722800722222" 0
##   [6,] "8.5685921366129"  "7.78722800722222" 0
##   [7,] "9.585765225"      "7.70709870944444" 0
##   [8,] "10.0222594730645" "9.92504677277778" 0
##   [9,] "14.6169198435484" "14.5263083805556" 0
##  [10,] "11.3761430325806" "10.5570063847222" 0
##  [11,] "12.9655517887097" "11.1700385702778" 0
##  [12,] "12.9655517887097" "11.1700385702778" 0
##  [13,] "11.012596878871"  "11.1182434786111" 0
##  [14,] "10.8879934756452" "10.7235666413889" 0
##  [15,] "10.8879934756452" "10.7235666413889" 0
##  [16,] "13.7745548564516" "13.1286641333333" 0
##  [17,] "10.3657648179032" "10.2151338813889" 0
##  [18,] "10.5484809443548" "9.80151133777778" 0
##  [19,] "10.5165094330645" "10.5832945075"    0
##  [20,] "10.5165094330645" "10.5832945075"    0
##  [21,] "9.91263204709677" "9.58496805777778" 0
##  [22,] "9.91263204709677" "9.58496805777778" 0
##  [23,] "9.91263204709677" "9.58496805777778" 0
##  [24,] "14.5046142467742" "14.9051628166667" 0
##  [25,] "14.5046142467742" "14.9051628166667" 0
##  [26,] "14.5046142467742" "14.9051628166667" 0
##  [27,] "14.5046142467742" "14.9051628166667" 0
##  [28,] "14.5046142467742" "14.9051628166667" 0
##  [29,] "13.5441684096774" "13.6381748166667" 0
##  [30,] "13.5441684096774" "13.6381748166667" 0
##  [31,] "8.95929116967742" "8.27736924111111" 0
##  [32,] "8.42556038032258" "7.74930629833333" 0
##  [33,] "7.57038927451613" "7.40530791222222" 0
##  [34,] "7.57038927451613" "7.40530791222222" 0
##  [35,] "11.0381468501613" "10.2215942186111" 0
##  [36,] "7.69568655629032" "7.71778892861111" 0
##  [37,] "11.0620734062903" "8.89214447111111" 0
##  [38,] "11.0620734062903" "8.89214447111111" 0
##  [39,] "8.12967414532258" "7.53380247138889" 0
##  [40,] "8.2484851533871"  "7.32673002888889" 0
##  [41,] "8.2484851533871"  "7.32673002888889" 0
##  [42,] "8.2484851533871"  "7.32673002888889" 0
##  [43,] "9.74105918419355" "8.38197263833333" 0
##  [44,] "9.51118165870968" "9.58015192277778" 0
##  [45,] "9.51118165870968" "9.58015192277778" 0
##  [46,] "9.51118165870968" "9.58015192277778" 0
##  [47,] "9.51118165870968" "9.58015192277778" 0
##  [48,] "9.51118165870968" "9.58015192277778" 0
##  [49,] "9.51118165870968" "9.58015192277778" 0
##  [50,] "9.51118165870968" "9.58015192277778" 0
##  [51,] "10.3451832662903" "9.4649654525"     0
##  [52,] "11.3498071608065" "8.92444201472222" 0
##  [53,] "10.5390777541935" "9.88533557805555" 0
##  [54,] "10.5390777541935" "9.88533557805555" 0
##  [55,] "11.2344046029032" "10.1845236863889" 0
##  [56,] "11.2344046029032" "10.1845236863889" 0
##  [57,] "11.2344046029032" "10.1845236863889" 0
##  [58,] "11.2344046029032" "10.1845236863889" 0
##  [59,] "12.0139219329032" "10.9497418586111" 0
##  [60,] "9.33591464854839" "9.26575054361111" 0
##  [61,] "9.47491935564516" "9.77920116055556" 0
##  [62,] "9.47491935564516" "9.77920116055556" 0
##  [63,] "8.36535806145161" "8.3937582475"     0
##  [64,] "8.36535806145161" "8.3937582475"     0
##  [65,] "11.3129354306452" "10.9971412094444" 0
##  [66,] "11.3129354306452" "10.9971412094444" 0
##  [67,] "8.74901937258064" "8.61940299861111" 0
##  [68,] "8.13640123532258" "6.93288196305556" 0
##  [69,] "11.071394925"     "11.1508719733333" 0
##  [70,] "11.071394925"     "11.1508719733333" 0
##  [71,] "11.071394925"     "11.1508719733333" 0
##  [72,] "11.071394925"     "11.1508719733333" 0
##  [73,] "11.071394925"     "11.1508719733333" 0
##  [74,] "8.58800569532258" "7.78756579694444" 0
##  [75,] "8.58800569532258" "7.78756579694444" 0
##  [76,] "8.58800569532258" "7.78756579694444" 0
##  [77,] "8.21679992822581" "6.96706235361111" 0
##  [78,] "13.4868625854839" "13.1329639944444" 0
##  [79,] "11.1916897469355" "10.8285608411111" 0
##  [80,] "11.4087726722581" "11.1352745158333" 0
##  [81,] "6.87506713677419" "6.82652711666667" 0
##  [82,] "6.87506713677419" "6.82652711666667" 0
##  [83,] "11.8533889225806" "11.3587537805556" 0
##  [84,] "7.4720977083871"  "7.57488933027778" 0
##  [85,] "7.4720977083871"  "7.57488933027778" 0
##  [86,] "7.4720977083871"  "7.57488933027778" 0
##  [87,] "9.36097694129032" "8.99113197972222" 0
##  [88,] "10.600268405"     "9.82080241611111" 0
##  [89,] "7.37322184580645" "6.93547361027778" 0
##  [90,] "9.90633540806452" "9.46323890027778" 0
##  [91,] "12.9034160193548" "12.9281105722222" 0
##  [92,] "12.9034160193548" "12.9281105722222" 0
##  [93,] "12.9034160193548" "12.9281105722222" 0
##  [94,] "12.9034160193548" "12.9281105722222" 0
##  [95,] "12.9034160193548" "12.9281105722222" 0
##  [96,] "12.9034160193548" "12.9281105722222" 0
##  [97,] "12.9034160193548" "12.9281105722222" 0
##  [98,] "12.9034160193548" "12.9281105722222" 0
##  [99,] "12.9034160193548" "12.9281105722222" 0
## [100,] "12.9034160193548" "12.9281105722222" 0
## [101,] "13.2969204112903" "13.7956430527778" 0
## [102,] "13.2969204112903" "13.7956430527778" 0
## [103,] "13.2969204112903" "13.7956430527778" 0
## [104,] "13.2969204112903" "13.7956430527778" 0
## [105,] "13.2969204112903" "13.7956430527778" 0
## [106,] "8.08787522564516" "8.06957060111111" 0
## [107,] "8.08787522564516" "8.06957060111111" 0
## [108,] "8.08787522564516" "8.06957060111111" 0
## [109,] "12.8023194016129" "12.5775275222222" 0
## [110,] "12.8023194016129" "12.5775275222222" 0
## [111,] "12.6985306241935" "11.3942000419444" 0
## [112,] "8.51591132306452" "8.17462146694444" 0
## [113,] "8.51591132306452" "8.17462146694444" 0
## [114,] "6.33624481290323" "6.44198236555556" 0
## [115,] "6.33624481290323" "6.44198236555556" 0
## [116,] "7.87809375225806" "7.99695051972222" 0
## [117,] "9.22120844758065" "8.95676916638889" 0
## [118,] "9.41723547370968" "8.37411315666667" 0
## [119,] "9.41723547370968" "8.37411315666667" 0
## [120,] "12.1458561919355" "12.3099642694444" 0
## [121,] "12.1458561919355" "12.3099642694444" 0
## [122,] "13.4014502403226" "12.1538429452778" 0
## [123,] "13.4014502403226" "12.1538429452778" 0
## [124,] "13.4014502403226" "12.1538429452778" 0
## [125,] "10.3526938696774" "10.0688447863889" 0
## [126,] "10.3526938696774" "10.0688447863889" 0
## [127,] "10.3526938696774" "10.0688447863889" 0
## [128,] "6.59644993193548" "6.44436591055556" 0
## [129,] "6.59644993193548" "6.44436591055556" 0
## [130,] "11.6801654308065" "11.2152063083333" 0
## [131,] "11.6801654308065" "11.2152063083333" 0
## [132,] "11.6801654308065" "11.2152063083333" 0
## [133,] "8.20879584419355" "8.20687755277778" 0
## [134,] "6.9724568683871"  "7.31340124916667" 0
## [135,] "6.9724568683871"  "7.31340124916667" 0
## [136,] "6.9724568683871"  "7.31340124916667" 0
## [137,] "6.9724568683871"  "7.31340124916667" 0
## [138,] "6.9724568683871"  "7.31340124916667" 0
## [139,] "6.9724568683871"  "7.31340124916667" 0
## [140,] "6.9724568683871"  "7.31340124916667" 0
## [141,] "8.04364874919355" "7.86680271583333" 0
## [142,] "8.04364874919355" "7.86680271583333" 0
## [143,] "10.3916130374194" "9.63418293694444" 0
## [144,] "10.3916130374194" "9.63418293694444" 0
## [145,] "6.98219636"       "6.89326890694444" 0
## [146,] "8.48951189129032" "8.57537558"       0
## [147,] "8.48951189129032" "8.57537558"       0
## [148,] "8.48951189129032" "8.57537558"       0
## [149,] "8.48951189129032" "8.57537558"       0
## [150,] "8.48951189129032" "8.57537558"       0
## [151,] "8.48951189129032" "8.57537558"       0
## [152,] "8.48951189129032" "8.57537558"       0
## [153,] "8.48951189129032" "8.57537558"       0
## [154,] "6.54965400193548" "6.60990570444444" 0
## [155,] "10.1861109908065" "9.91753965361111" 0
## [156,] "17.5653704080645" "17.4275587361111" 0
## [157,] "12.2657196806452" "12.4044640333333" 0
## [158,] "7.36270688419355" "7.26719888111111" 0
## [159,] "7.36270688419355" "7.26719888111111" 0
## [160,] "7.46377880887097" "7.47343679694444" 0
## [161,] "10.5959257541935" "10.1085525141667" 0
## [162,] "11.5493079280645" "10.1278554219444" 0
## [163,] "8.99141984435484" "8.74585766611111" 0
## [164,] "8.99141984435484" "8.74585766611111" 0
## [165,] "8.99141984435484" "8.74585766611111" 0
## [166,] "8.99141984435484" "8.74585766611111" 0
## [167,] "7.2532758833871"  "7.40731832027778" 0
## [168,] "7.2532758833871"  "7.40731832027778" 0
## [169,] "7.2532758833871"  "7.40731832027778" 0
## [170,] "7.2532758833871"  "7.40731832027778" 0
## [171,] "7.2532758833871"  "7.40731832027778" 0
## [172,] "7.2532758833871"  "7.40731832027778" 0
## [173,] "7.2532758833871"  "7.40731832027778" 0
## [174,] "10.0424925209677" "8.242070435"      0
## [175,] "12.3877191580645" "12.1000382944444" 0
## [176,] "12.3877191580645" "12.1000382944444" 0
## [177,] "6.66489320306452" "6.71803639805556" 0
## [178,] "6.66489320306452" "6.71803639805556" 0
## [179,] "6.66489320306452" "6.71803639805556" 0
## [180,] "6.66489320306452" "6.71803639805556" 0
## [181,] "6.66489320306452" "6.71803639805556" 0
## [182,] "6.66489320306452" "6.71803639805556" 0
## [183,] "6.66489320306452" "6.71803639805556" 0
## [184,] "6.31490324"       "6.34743530555556" 0
## [185,] "6.31490324"       "6.34743530555556" 0
## [186,] "6.31490324"       "6.34743530555556" 0
## [187,] "7.32820054258065" "6.91585043944444" 0
## [188,] "7.32820054258065" "6.91585043944444" 0
## [189,] "13.9638110774194" "11.3350948875"    0
## [190,] "13.9638110774194" "11.3350948875"    0
## [191,] "13.9638110774194" "11.3350948875"    0
## [192,] "11.2522421525806" "11.0702830136111" 0
## [193,] "9.04463756451613" "8.73743875944444" 0
## [194,] "9.04463756451613" "8.73743875944444" 0
## [195,] "6.6810354616129"  "6.72690909277778" 0
## [196,] "6.6810354616129"  "6.72690909277778" 0
## [197,] "6.6810354616129"  "6.72690909277778" 0
## [198,] "6.6810354616129"  "6.72690909277778" 0
## [199,] "6.6810354616129"  "6.72690909277778" 0
## [200,] "6.6810354616129"  "6.72690909277778" 0
## [201,] "8.8635200483871"  "8.29787924583333" 0
## [202,] "8.8635200483871"  "8.29787924583333" 0
## [203,] "8.8635200483871"  "8.29787924583333" 0
## [204,] "7.69552500741935" "7.14400546305556" 0
## [205,] "7.69552500741935" "7.14400546305556" 0
## [206,] "7.84967777516129" "8.10019239555556" 0
## [207,] "7.84967777516129" "8.10019239555556" 0
## [208,] "10.3627084004839" "8.10625708944444" 0
```

## 0.7 Other Functions

### 0.7.1 Multiple-Groups Data

As for the data, which classify samples into more than two
groups, anamiR provides function `multi_Differ`. User can
get more information about this function by refering to
its documentation.

### 0.7.2 Continuous Data

The data with continuous phenotype feature are also supported,
`differExp_continuous` contains linear regression model, which
can fit the continuous data series. User can get more
information about this function by refering to its documentation.