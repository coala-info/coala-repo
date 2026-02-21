# scMAGeCK

#### Wei Li, Xiaolong Cheng

#### Oct 22, 2019

## Introduction

scMAGeCK is a computational model to identify genes associated with multiple expression phenotypes from CRISPR screening coupled with single-cell RNA sequencing data (CROP-seq).

scMAGeCK is based on our previous [MAGeCK](http://mageck.sourceforge.net) and MAGeCK-VISPR models for pooled CRISPR screens, but further extends to scRNA-seq as the readout of the screening experiment. scMAGeCK consists of two modules: scMAGeCK-Robust Rank Aggregation (RRA), a sensitive and precise algorithm to detect genes whose perturbation links to one single marker expression; and scMAGeCK-LR, a linear-regression based approach that unravels the perturbation effects on thousands of gene expressions, especially from cells undergo multiple perturbations.

## Usage

### scmageck\_rra

```
library(scMAGeCK)
### BARCODE file contains cell identity information, generated from the cell identity collection step
BARCODE <- system.file("extdata","barcode_rec.txt",package = "scMAGeCK")

### RDS can be a Seurat object or local RDS file path that contains the scRNA-seq dataset
RDS <- system.file("extdata","singles_dox_mki67_v3.RDS",package = "scMAGeCK")

### Set RRA executable file path.
###    You can generate RRA executable file by following commands:
###        wget https://bitbucket.org/weililab/scmageck/downloads/RRA_0.5.9.zip
###        unzip RRA_0.5.9.zip
###        cd RRA_0.5.9
###        make
RRAPATH <- "/Library/RRA_0.5.9/bin/RRA"

target_gene <- "MKI67"

rra_result <- scmageck_rra(BARCODE=BARCODE, RDS=RDS, GENE=target_gene, RRAPATH=RRAPATH,
LABEL='dox_mki67', NEGCTRL=NULL, KEEPTMP=FALSE, PATHWAY=FALSE, SAVEPATH=NULL)
```

```
## Checking RRA...
```

```
## RRA is not does not exist! Please check RRA executable file path
```

### scmageck\_lr

```
library(scMAGeCK)
### BARCODE file contains cell identity information, generated from the cell identity collection step
BARCODE <- system.file("extdata","barcode_rec.txt",package = "scMAGeCK")
### RDS can be a Seurat object or local RDS file path that contains the scRNA-seq dataset
RDS <- system.file("extdata","singles_dox_mki67_v3.RDS",package = "scMAGeCK")

lr_result <- scmageck_lr(BARCODE=BARCODE, RDS=RDS, LABEL='dox_scmageck_lr',
NEGCTRL = 'NonTargetingControlGuideForHuman', PERMUTATION = 1000, SAVEPATH=NULL, LAMBDA=0.01)
```

```
## Total barcode records: 8425
```

```
## Neg Ctrl guide: NonTargetingControlGuideForHuman
```

```
## Reading RDS file: /tmp/RtmpcxY7ur/Rinst159d52acc223/scMAGeCK/extdata/singles_dox_mki67_v3.RDS
```

```
## Cell names in expression matrix and barcode file do not match. Try to remove possible trailing "-1"s...
```

```
## 6704 ...
```

```
## 6229 ...
```

```
## Index matrix dimension: 5698 , 30
```

```
## Selected genes: 25
```

```
## Permutation: 100 / 1000 ...
```

```
## Permutation: 200 / 1000 ...
```

```
## Permutation: 300 / 1000 ...
```

```
## Permutation: 400 / 1000 ...
```

```
## Permutation: 500 / 1000 ...
```

```
## Permutation: 600 / 1000 ...
```

```
## Permutation: 700 / 1000 ...
```

```
## Permutation: 800 / 1000 ...
```

```
## Permutation: 900 / 1000 ...
```

```
## Permutation: 1000 / 1000 ...
```

```
lr_score <- lr_result[1]
lr_score_pval <- lr_result[2]
```

## Output

### scmageck\_rra

The scmageck\_rra function will output the ranking and p values of each perturbed genes, using the RRA program in MAGeCK. Users familiar with the MAGeCK program may find it similar with the [gene\_summary](https://sourceforge.net/p/mageck/wiki/output/#gene_summary_txt) output in MAGeCK.

Here is the example output of scMAGeCK-RRA:

```
Row.names  items_in_group.low  lo_value.low  p.low  FDR.low goodsgrna.low  items_in_group.high  lo_value.high  p.high  FDR.high  goodsgrna.high
TP53    271     0.11832 0.95619 1       48      271     1.014e-83       4.9975e-06      0.00015 184
```

Explanations of each column are below:

| Column | Content |
| --- | --- |
| Row.names | Perturbed gene name |
| items\_in\_group.low | The number of single-cells with each gene perturbed |
| lo\_value.low | The RRA score in negative selection (reducing the marker expression if this gene is perturbed). The RRA score uses a p value from rank order statistics to measure the degree of selection; the smaller score, the stronger the selection is. More information on the calculation of RRA score can be found in our original [MAGeCK](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-014-0554-4) paper. |
| p.low | The raw p-value (using permutation) of this gene in negative selection |
| FDR.low | The false discovery rate of this gene in negative selection |
| goodsgrna.low | The number of single-cells that passes the threshold and is considered in the RRA score calculation in negative selection |
| items\_in\_group.high | The same as items\_in\_group.low: the number of single-cells with each gene perturbed) |
| lo\_value.high | The RRA score in positive selection (increasing the marker expression if this gene is perturbed |
| p.high | The raw p-value (using permutation) of this gene in positive selection |
| FDR.high | The false discovery rate of this gene in positive selection |
| goodsgrna.high | The number of single-cells that passes the threshold and is considered in the RRA score calculation in positive selection |

### scmageck\_lr

The scmageck\_lr function will generate several files below:

| File | Description |
| --- | --- |
| lr\_score | The score (similar with log fold change) of each perturbed gene (rows) on each marker gene (columns) |
| lr\_score.pval | The associated p values of each score |
| LR.RData | An R object to store scores and p values |

The format of score.txt and score.pval.txt is a simple table file with rows corresponding to perturbed genes and columns corresponding to marker genes. For example in the score.txt,

```
Perturbedgene  APC                ARID1A               TP53               MKI67
     APC       0.138075836476524  -0.0343441660045313  0.214449590551132  -0.150287676553705
```

This row records the effects of perturbing APC gene on the expressions of APC, ARID1A, TP53 and MKI67.

## Contact us

Questions? Comments? Join the [MAGeCK Google group](https://groups.google.com/forum/?hl=en#!forum/mageck) or email us (wli2@childrensnational.org) directly.

Any advice and suggestions will be greatly appreciated.