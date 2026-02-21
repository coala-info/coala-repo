# MetaVolcanoR: Differential expression meta-analysis tool

#### June 5, 2019

* [Introduction](#introduction)
* [Usage](#usage)
  + [Overview](#overview)
  + [Installation](#installation)
  + [Load library](#load-library)
  + [Input Data](#input-data)
* [Implemented meta-analysis approaches](#implemented-meta-analysis-approaches)
  + [Random Effect Model MetaVolcano](#random-effect-model-metavolcano)
  + [Vote-counting approach](#vote-counting-approach)
  + [Combining-approach](#combining-approach)

# Introduction

The measurement of how gene expression changes under different biological conditions is necessary to reveal the gene regulatory programs that determine the cellular phenotype.

Comparing the expresion of genes under a given condition against a reference biological state is usually applied to identify sets of differentially expressed genes (DEG). These DEG point out the genomic regions functionally relevant under the biological condition of interest.

Athough individual genome-wide expression studies have small signal/noise ratio, today’s genomic data availability usually allows to combine differential gene expression results from independent studies to overcome this limitation.

Databases such as GEO (<https://www.ncbi.nlm.nih.gov/geo/>), SRA (<https://www.ncbi.nlm.nih.gov/sra>), ArrayExpress, (<https://www.ebi.ac.uk/arrayexpress/>), and ENA (<https://www.ebi.ac.uk/ena>) offer systematic access to vast amounts of transcriptome data. There exists more than one gene expression study for many biological conditions. This redundancy could be exploit by meta-analysis approaches to reveal genes that are consistently and differentially expressed under given conditions.

MetaVolcanoR was designed to identify the genes whose expression is consistently perturbed across several studies.

# Usage

## Overview

The MetaVolcanoR R package combines differential gene expression results. It implements three strategies to summarize gene expression activities from different studies. i) Random Effects Model (REM) approach. ii) a vote-counting approach, and iii) a p-value combining-approach. MetaVolcano exploits the Volcano plot reasoning to visualize the gene expression meta-analysis results.

## Installation

```
BiocManager::install("MetaVolcanoR", eval = FALSE)
```

## Load library

```
library(MetaVolcanoR)
```

## Input Data

Users should provide a named list of objects containing differential gene expression results. Each object of the list
must contain a *gene name*, a *fold change*, and a *p-value* variable. It is highly recommended to also include the *variance* or the confidence intervals of the *fold change* variable.

Take a look at the demo data. It includes differential gene expression results from five studies.

```
data(diffexplist)
class(diffexplist)
```

```
## [1] "list"
```

```
head(diffexplist[[1]])
```

```
##     Symbol      Log2FC      pvalue       CI.L        CI.R
## 1     A1BG -0.70126879 0.000140100 -1.0087857 -0.39375189
## 2 A1BG-AS1 -0.25106351 0.008694757 -0.4304790 -0.07164803
## 3     A1CF  0.03332573 0.615989488 -0.1036882  0.17033968
## 4      A2M  0.83504214 0.018550388  0.1568214  1.51326289
## 5    A2ML1  0.03942552 0.843222358 -0.3728473  0.45169836
## 6   A4GALT -0.20815882 0.282488068 -0.6025247  0.18620708
```

```
length(diffexplist)
```

```
## [1] 5
```

# Implemented meta-analysis approaches

## Random Effect Model MetaVolcano

The *REM* MetaVolcano summarizes the gene fold change of several studies taking into account the variance. The *REM* estimates a *summary p-value* which stands for the probability of the *summary fold-change* is not different than zero. Users can set the *metathr* parameter to highlight the top percentage of the most consistently perturbed genes. This perturbation ranking is defined following the *topconfects* approach.

```
meta_degs_rem <- rem_mv(diffexp=diffexplist,
            pcriteria="pvalue",
            foldchangecol='Log2FC',
            genenamecol='Symbol',
            geneidcol=NULL,
            collaps=FALSE,
            llcol='CI.L',
            rlcol='CI.R',
            vcol=NULL,
            cvar=TRUE,
            metathr=0.01,
            jobname="MetaVolcano",
            outputfolder=".",
            draw='HTML',
            ncores=1)

head(meta_degs_rem@metaresult, 3)
```

```
##   Symbol signcon randomSummary randomCi.lb randomCi.ub      randomP
## 1  MXRA5       5      1.033300   0.7882044   1.2783958 1.420312e-16
## 2 COL6A6      -5     -1.064975  -1.3396138  -0.7903361 2.956522e-14
## 3  CIDEA      -3     -1.041788  -1.3210774  -0.7624977 2.653168e-13
##     het_QE   het_QEp   het_QM      het_QMp error rank
## 1 4.179945 0.3822003 68.27752 1.420312e-16 FALSE    1
## 2 4.580708 0.3330846 57.76318 2.956522e-14 FALSE    2
## 3 1.980047 0.3715680 53.44957 2.653168e-13 FALSE    3
```

```
meta_degs_rem@MetaVolcano
```

![](data:image/png;base64...)

```
draw_forest(remres=meta_degs_rem,
        gene="MMP9",
        genecol="Symbol",
        foldchangecol="Log2FC",
        llcol="CI.L",
        rlcol="CI.R",
        jobname="MetaVolcano",
        outputfolder=".",
        draw="HTML")
```

![](data:image/png;base64...)

```
draw_forest(remres=meta_degs_rem,
        gene="COL6A6",
        genecol="Symbol",
        foldchangecol="Log2FC",
        llcol="CI.L",
        rlcol="CI.R",
        jobname="MetaVolcano",
        outputfolder=".",
        draw="HTML")
```

![](data:image/png;base64...)

  The *REM* MetaVolcano also allows users to explore the forest plot of a given gene based on the REM results.

## Vote-counting approach

The *vote-counting* MetaVolcano identifies differential expressed genes (DEG) for each study based on the user-defined *p-value* and *fold change* thresholds. It displays the number of differentially expressed and unperturbed genes per study. In addition, it plots the inverse cumulative distribution of the consistently DEG, so the user can identify the number of genes whose expression is perturbed in at least 1 or n studies.

```
meta_degs_vote <- votecount_mv(diffexp=diffexplist,
                   pcriteria='pvalue',
                   foldchangecol='Log2FC',
                   genenamecol='Symbol',
                   geneidcol=NULL,
                   pvalue=0.05,
                   foldchange=0,
                   metathr=0.01,
                   collaps=FALSE,
                   jobname="MetaVolcano",
                   outputfolder=".",
                   draw='HTML')

head(meta_degs_vote@metaresult, 3)
```

```
##   Symbol deg_1 deg_2 deg_3 deg_4 deg_5 ndeg ddeg idx        degvcount
## 1  ABCC3     1     1     1     1     1    5    5  25   2.Up-regulated
## 2  ABHD5    -1    -1    -1    -1    -1    5   -5 -25 0.Down-regulated
## 3  ACACB    -1    -1    -1    -1    -1    5   -5 -25 0.Down-regulated
```

```
meta_degs_vote@degfreq
```

![](data:image/png;base64...)

The *vote-counting* MetaVolcano visualizes genes based on the number of studies where genes were identified as differentially expressed and the gene fold change sign consistency. It means that a gene that was differentially expressed in five studies, from which three of them it was downregulated, will get a sign consistency score of 2 + (-3) = -1. Based on user preference, MetaVolcano can highlight the top *metathr* percentage of consistently perturbed genes.

```
meta_degs_vote@MetaVolcano
```

![](data:image/png;base64...)

## Combining-approach

The *combinig* MetaVolcano summarizes the fold change of a gene in different studies by the *mean* or *median* depending on the user preference. In addition, the *combinig* MetaVolcano summarizes the gene differential expression *p-values* using the Fisher method. The *combining* MetaVolcano can highlight the top *metathr* percentage of consistently perturbed genes.

```
meta_degs_comb <- combining_mv(diffexp=diffexplist,
                   pcriteria='pvalue',
                   foldchangecol='Log2FC',
                   genenamecol='Symbol',
                   geneidcol=NULL,
                   metafc='Mean',
                   metathr=0.01,
                   collaps=TRUE,
                   jobname="MetaVolcano",
                   outputfolder=".",
                   draw='HTML')

head(meta_degs_comb@metaresult, 3)
```

```
##   Symbol        metap     metafc       idx
## 1   MMP9 9.002947e-15  1.9693517  27.66076
## 2 ACVR1C 3.548802e-20 -1.2544105 -24.39818
## 3    ANG 5.674270e-26 -0.9364936 -23.64280
```

```
meta_degs_comb@MetaVolcano
```

![](data:image/png;base64...)