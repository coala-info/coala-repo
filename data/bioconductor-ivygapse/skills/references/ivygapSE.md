# ivygapSE – Bioconductor container for Ivy-GAP expression and metadata

Vincent J. Carey, stvjc at channing.harvard.edu

#### October 30, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Background on the ivyGlimpse app](#background-on-the-ivyglimpse-app)
* [3 Summary information on the underlying data](#summary-information-on-the-underlying-data)
* [4 Additional details](#additional-details)
  + [4.1 Basic experimental design layout](#basic-experimental-design-layout)
  + [4.2 Tumor-level details](#tumor-level-details)
  + [4.3 Sub-block-level details](#sub-block-level-details)
  + [4.4 Details on RNA-seq samples](#details-on-rna-seq-samples)
    - [4.4.1 Key RNA-seq subsets](#key-rna-seq-subsets)
    - [4.4.2 A simple differential expression study](#a-simple-differential-expression-study)
    - [4.4.3 Differential expression by molecular subtype](#differential-expression-by-molecular-subtype)
    - [4.4.4 Classification of structural character](#classification-of-structural-character)
* [5 Next steps](#next-steps)

# 1 Introduction

CSV files from the Ivy-GAP project have been assembled into a SummarizedExperiment instance.

```
library(ivygapSE)
data(ivySE)
ivySE
```

```
## class: SummarizedExperiment
## dim: 25873 270
## metadata(5): README URL builder tumorDetails subBlockDetails
## assays(1): fpkm
## rownames(25873): A1BG A2M ... PP12719 LOC100653024
## rowData names(5): gene_id chromosome gene_entrez_id gene_symbol
##   gene_name
## colnames(270): 305273026 305405294 ... 305273038 306124458
## colData names(28): tumor_id tumor_name ... bam_download_link
##   bai_download_link
```

There are several types of metadata collected with the object, including the
README.txt (use `cat(metadata(ivySE)$README, sep="\n")` to see this in R),
the URL where data were retrieved,
a character vector (builder) with the R code for creating (much of) the SummarizedExperiment,
and two tables of tumor-specific and
block-specific information.

# 2 Background on the ivyGlimpse app

The ivyGlimpse app is a rapid prototype of a browser-based
interface to salient features of the data. The
most current code is maintained in the Bioconductor
ivygapSE package, but a public version of the app
may be visited at [shinyapps.io](https://vjcitn.shinyapps.io/ivyglimpse/).

The ivygapSE
package will evolve, based in part on associations
observed through the use of this app. Briefly, the main
visualization of the app is a scatterplot of user-selected
tumor image features. All contributions, based
on tumor sub-blocks (that have varying multiplicities per
tumor block and donor) are assembled
together without regard for source; interactive aspects of
the display allow the user to see which donor contributes
each point.

Strata can be formed interactively by brushing
over the scatterplot; after the brushing event, the survival
times of donors contributing selected points are compared
to donors all of whose contributions lie outside the selection.
Expression data are also stratified in this way and gene-specific
boxplot sets (for user-specified gene sets) are produced for each stratum.

# 3 Summary information on the underlying data

The number of RNA-seq samples is 270. The FPKM matrix has dimensions

```
dim(ivySE)
```

```
## [1] 25873   270
```

There are 42 different tumor donors.

```
length(unique(metadata(ivySE)$tumorDetails$donor_id))
```

```
## [1] 42
```

However, only 37 donors contributed tumor RNA that was sequenced:

```
sum(metadata(ivySE)$tumorDetails$tumor_name %in% ivySE$tumor_name)
```

```
## [1] 37
```

Features of images from sub-blocks were quantified according to the following terminology for
anatomical characteristics. Not all images provided information
on all attributes.

![](data:image/png;base64...)

# 4 Additional details

We have used information in the
[IvyGAP technical white paper](http://help.brain-map.org/display/glioblastoma/Documentation?preview=/8028197/8454231/IvyOverview.pdf) to
spell out additional background on the data underlying the app and
SummarizedExperiment.

## 4.1 Basic experimental design layout

There are six substudies contributing data in a partly
sequential design.

![](data:image/png;base64...)

## 4.2 Tumor-level details

The following table has one record per tumor (N=42).

## 4.3 Sub-block-level details

The following table has one record per sub-block (N=946).

## 4.4 Details on RNA-seq samples

The complete annotation on RNA-seq samples is provided in `colData(ivySE)`. The
table follows here:

### 4.4.1 Key RNA-seq subsets

#### 4.4.1.1 Subsets of design origin

The sub-blocks arose from a number of measurement objectives.

```
sb = subBlockDetails(ivySE)
table(sb$study_name)
```

```
##
##             Anatomic Structures ISH Survey
##                                         96
## Anatomic Structures ISH for Enriched Genes
##                                         48
##                Anatomic Structures RNA Seq
##                                         47
##               Cancer Stem Cells ISH Survey
##                                        648
##   Cancer Stem Cells ISH for Enriched Genes
##                                         48
##                  Cancer Stem Cells RNA Seq
##                                         59
```

#### 4.4.1.2 Subsets based on structure

We use the `structure_acronym` variable to assess the composition of
sources in the RNA-seq collection.

```
struc = as.character(colData(ivySE)$structure_acronym)
spls = strsplit(struc, "-")
basis = vapply(spls, function(x) x[1], character(1))
spec = vapply(spls, function(x) x[2], character(1))
table(basis, exclude=NULL)
```

```
## basis
##    CT CThbv CTmvp CTpan CTpnz    IT    LE
##   111    22    28    40    26    24    19
```

```
barplot(table(basis))
```

![](data:image/png;base64...)

Each of the major structural types contributes multiple samples from
specific objectives.

```
lapply(split(spec,basis), function(x)sort(table(x),decreasing=TRUE))
```

```
## $CT
## x
##   control reference       ID1     POSTN      CD44     DANCR     HIF1A    IGFBP2
##        59        30         3         3         2         2         2         2
##       MET      NOS2       PI3    PDGFRA      PDPN
##         2         2         2         1         1
##
## $CThbv
## x
## TGFBR2  POSTN IGFBP2  ITGA6   CD44  DANCR  HIF1A
##      8      7      2      2      1      1      1
##
## $CTmvp
## x
## reference    TGFBR2     ITGA6
##        25         2         1
##
## $CTpan
## x
## reference       ID2      PDPN   TNFAIP3       MYC       PI3     PROM1
##        24         4         3         3         2         2         2
##
## $CTpnz
## x
##     PI3    PDPN   PROM1 TNFAIP3     ID1    CD44   DANCR  IGFBP2     MYC
##       8       4       4       4       2       1       1       1       1
##
## $IT
## reference
##        24
##
## $LE
## reference
##        19
```

### 4.4.2 A simple differential expression study

We have used *[limma](https://bioconductor.org/packages/3.22/limma)* to test for differential
expression among samples identified as `reference histology` in
classes `CT`, `CT-mvp`, `CT-pan`, `IT`, and `LE`. The
resulting mean expression estimates (FPKM scale)
and moderated test statistics are obtained
as follows:

```
library(limma)
ebout = getRefLimma()
```

The ten genes that are most significantly differentially
expressed between conditions CT and CT-mvp are found as follows:

```
odig = options()$digits
options(digits=3)
limma::topTable(ebout, 2)
```

```
##                logFC AveExpr    t  P.Value adj.P.Val   B
## TRPC6          16.58    3.82 39.2 2.93e-69  7.59e-65 147
## GPR116        100.40   27.90 35.1 4.42e-64  5.72e-60 135
## FZD4            9.37    3.09 32.8 5.29e-61  4.57e-57 128
## CYYR1          50.46   13.46 31.6 3.26e-59  2.11e-55 124
## CALD1         321.33  141.88 31.0 2.19e-58  1.13e-54 122
## NR5A2           7.66    1.86 30.7 5.55e-58  2.39e-54 122
## LOC100505813 5804.06 1998.11 30.0 6.80e-57  2.52e-53 119
## FSTL1         234.03   71.86 29.9 1.13e-56  3.67e-53 119
## KDR            28.06    7.82 29.3 7.86e-56  2.26e-52 117
## LRRC32         23.15    5.76 29.1 1.89e-55  4.57e-52 116
```

```
options(digits=odig) # revert
```

### 4.4.3 Differential expression by molecular subtype

We can bind the molecular subtype information from the tumor
details to the expression sample annotation as follows:

```
moltype = tumorDetails(ivySE)$molecular_subtype
names(moltype) = tumorDetails(ivySE)$tumor_name
moltype[nchar(moltype)==0] = "missing"
ivySE$moltype = factor(moltype[ivySE$tumor_name])
```

We will confine attention to samples annotated as “reference histology”
and compute the duplicate correlation for modeling the
effect of molecular subtype in the available samples.

```
library(limma)
refex = ivySE[, grep("reference", ivySE$structure_acronym)]
refmat = assay(refex)
tydes = model.matrix(~moltype, data=as.data.frame(colData(refex)))
ok = which(apply(tydes,2,sum)>0)  # some subtypes don't have ref histo samples
tydes = tydes[,ok]
block = factor(refex$tumor_id)
dd = duplicateCorrelation(refmat, tydes, block=block)
f2 = lmFit(refmat, tydes, correlation=dd$consensus)
ef2 = eBayes(f2)
```

```
## Warning: Zero sample variances detected, have been offset away from zero
```

```
colnames(tydes)
```

```
## [1] "(Intercept)"                   "moltypeClassical, Mesenchymal"
## [3] "moltypeClassical, Neural"      "moltypeNeural"
## [5] "moltypeProneural"
```

```
topTable(ef2,2)
```

```
##              logFC    AveExpr         t      P.Value    adj.P.Val        B
## PGAM4    -3.464745  0.8788400 -8.793853 1.450258e-14 3.752253e-10 22.27486
## SGCB     28.288935 45.5211562  7.738074 3.880394e-12 5.019872e-08 17.03899
## ANXA4    10.981958 14.4540170  7.174149 7.062419e-11 6.090865e-07 14.31838
## FLJ16779 -1.397749  0.4856463 -6.862396 3.397237e-10 1.964422e-06 12.84563
## TANK     28.120813 50.9024126  6.840152 3.796278e-10 1.964422e-06 12.74152
## SLIT1    -2.795607  1.5910338 -6.797291 4.700253e-10 2.026828e-06 12.54130
## FOXRED2  -6.266522  5.0362090 -6.753422 5.845577e-10 2.160609e-06 12.33689
## EFEMP1   74.747156 40.4488473  6.701711 7.553455e-10 2.244861e-06 12.09664
## COL8A2    2.298288  1.3095658  6.679804 8.417847e-10 2.244861e-06 11.99509
## BCRP3    -1.245920  0.4751551 -6.632199 1.064715e-09 2.244861e-06 11.77492
```

### 4.4.4 Classification of structural character

We assess the capacity of the expression measures to
discriminate the structural type (CT, CT-mvp, CT-pan, LE, IT)
using the random forests algorithm. Features used have
interquartile range (IQR) over all relevant samples exceeding the
median IQR over all genes.

```
refex = ivySE[, grep("reference", ivySE$structure_acronym)]
refex$struc = factor(refex$structure_acronym)
iqrs = rowIQRs(assay(refex))
inds = which(iqrs>quantile(iqrs,.5))
set.seed(1234)
rf1 = randomForest(x=t(assay(refex[inds,])),
        y=refex$struc, mtry=30, importance=TRUE)
rf1
```

```
##
## Call:
##  randomForest(x = t(assay(refex[inds, ])), y = refex$struc, mtry = 30,      importance = TRUE)
##                Type of random forest: classification
##                      Number of trees: 500
## No. of variables tried at each split: 30
##
##         OOB estimate of  error rate: 6.56%
## Confusion matrix:
##                           CT-reference-histology CTmvp-reference-histology
## CT-reference-histology                        29                         0
## CTmvp-reference-histology                      0                        25
## CTpan-reference-histology                      0                         0
## IT-reference-histology                         2                         0
## LE-reference-histology                         0                         0
##                           CTpan-reference-histology IT-reference-histology
## CT-reference-histology                            0                      1
## CTmvp-reference-histology                         0                      0
## CTpan-reference-histology                        24                      0
## IT-reference-histology                            0                     21
## LE-reference-histology                            0                      4
##                           LE-reference-histology class.error
## CT-reference-histology                         0  0.03333333
## CTmvp-reference-histology                      0  0.00000000
## CTpan-reference-histology                      0  0.00000000
## IT-reference-histology                         1  0.12500000
## LE-reference-histology                        15  0.21052632
```

```
varImpPlot(rf1)
```

![](data:image/png;base64...)

# 5 Next steps

Patel et al. Science 2014 (344(6190): 1396–1401) present single cell RNA-seq
for 430 cells from 5 tumors of different molecular subtypes. It would
be interesting to use signature of structural origin to see whether
intra-tumor variation can be resolved into components coherent with
the five-element typology. It would also be of interest to assess whether
structural type signatures are associated with any signatures of drug
sensitivity in relevant cell lines.