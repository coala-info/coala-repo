# adverSCarial, generate and analyze the vulnerability of scRNA-seq

## Ghislain FIEVET ghislain.fievet@gmail.com

# Introduction

**adverSCarial is a package for generating and evaluating vulnerability to adversarial attacks on single-cell RNA sequencing classifiers.**
Single cell analysis are on the way to be used in clinical routine. As a critical use, algorithms must address the challenge of ensuring reliability, one concern being the susceptibility to adversarial attacks.

Zhang, J., Wang, W., Huang, J., Wang, X., & Zeng, Y. (2020). How far is single-cell sequencing from clinical application?. Clinical and translational medicine, 10(3), e117. <https://doi.org/10.1002/ctm2.117>

de Hond, A.A.H., Leeuwenberg, A.M., Hooft, L. et al. Guidelines and quality criteria for artificial intelligence-based prediction models in healthcare: a scoping review. npj Digit. Med. 5, 2 (2022). <https://doi.org/10.1038/s41746-021-00549-7>

The package is designed to generate and analyze the vulnerability of scRNA-seq classifiers to adversarial attacks. The package is versatile and provides a format for integrating
any type of classifier. It offers functions for studying and generating two types of attacks, single gene attack and max change attack.
The single gene attack involves making a small modification to the input to alter the classification. This is an issue when the change of classification is made on a gene that is not known to be biologicaly involved in the change of this cell type.
The max change attack involves making a large modification to the input without changing its classification. This is an issue when a significant percentage of genes, sometimes as high as 99%, can be modified with the classifier still predicting the same cell type.

# Jupyter Notebook examples

* [Train, format and CGD attack on a scAnnotatR classifier](https://github.com/GhislainFievet/adverSCarial_article/blob/master/04_train_and_attack_scAnnotatR.ipynb)
* [Train, format and max-change attack on a random forest classifier](https://github.com/GhislainFievet/adverSCarial_article/blob/master/05_train_format_random_forest_classifier_scRF.ipynb)
* [Train, format and single-gene attack on a multi layer perceptron classifier](https://github.com/GhislainFievet/adverSCarial_article/blob/master/06_train_format_classifier_scMLP.ipynb)

# Installation

```
## Install BiocManager is necessary
if (!require("BiocManager")) {
    install.packages("BiocManager")
}
BiocManager::install('adverSCarial')
```

# Generate an adversarial attack

There are three types of adversarial attacks: `single-gene attack` which modifies the expression of a gene in order to alter the classification, `max-change attack` which introduce the largest possible perturbations to the input while still keeping the same classification, and `Cluster Gradient Descent (CGD)` which modifies the input matrix gene by gene by following an approximated gradient until the cluster has switch its classification.

Load libraries

```
library(adverSCarial)
library(LoomExperiment)
```

Load a pbmc raw data

```
pbmcPath <- system.file("extdata", "pbmc_short.loom", package="adverSCarial")
lfile <- import(pbmcPath, type="SingleCellLoomExperiment")
```

```
matPbmc <- counts(lfile)
```

```
matPbmc[1:5, 1:5]
```

```
## <5 x 5> DelayedMatrix object of type "integer":
##      NEK11 IL5RA OR4C5 KHDRBS3 OPA3
## [1,]     0     0     0       0    0
## [2,]     0     0     0       0    0
## [3,]     0     0     0       0    0
## [4,]     0     0     0       0    0
## [5,]     0     0     0       0    0
```

and its cell type classification based on [Seurat documentation](https://satijalab.org/seurat/articles/pbmc3k_tutorial.html)

```
cellTypes <- rowData(lfile)$cell_type
```

```
head(cellTypes)
```

```
## [1] "Naive CD4 T"  "Naive CD4 T"  "FCGR3A+ Mono" "Naive CD4 T"  "B"
## [6] "Naive CD4 T"
```

The package contains a marker based classifier working on the pbmc3k dataset: `MClassifier`.
We verify it is classifying properly according to the `cellTypes`.

```
for ( cell_type in unique(cellTypes)){
    resClassif <- MClassifier(matPbmc, cellTypes, cell_type)
    print(paste0("Expected: ", cell_type, ", predicted: ", resClassif[1]))
}
```

```
## [1] "Expected: Naive CD4 T, predicted: Naive CD4 T"
## [1] "Expected: FCGR3A+ Mono, predicted: FCGR3A+ Mono"
## [1] "Expected: B, predicted: B"
## [1] "Expected: Memory CD4 T, predicted: Memory CD4 T"
## [1] "Expected: CD14+ Mono, predicted: CD14+ Mono"
## [1] "Expected: CD8 T, predicted: CD8 T"
## [1] "Expected: UNDETERMINED, predicted: UNDETERMINED"
## [1] "Expected: NK, predicted: NK"
## [1] "Expected: Platelet, predicted: Platelet"
## [1] "Expected: DC, predicted: DC"
```

We want to run attacks on the “DC” cluster but without modifying the genes used by human to make manual classification. We can find this list on [Seurat documentation](https://satijalab.org/seurat/articles/pbmc3k_tutorial.html)

```
# Known markers for each cell type
markers <- c("IL7R", "CCR7", "CD14", "LYZ", "S100A4", "MS4A1", "CD8A", "FCGR3A", "MS4A7",
              "GNLY", "NKG7", "FCER1A", "CST3", "PPBP")
```

## Single-gene attack

Modify the value of a gene inside a cell cluster in order to change its classification.

The function `advSingleGene` runs a dichotomic search of one gene attacks, given the cluster to attack and a type of modification. We suggest two main modifications: `perc1` replacing the value of the gene by its first percentile, and `perc99` replacing the value of the gene by its 99th percentile. The `adv_fct` argument allows users to choose custom modifications of the gene.

The `excl_genes` argument allows users to exclude certain genes from being modified. Here we exclude the genes usually used as markers of specific cell types, as defined previously.

Computation times can be lengthy, we use the `return_first_found` argument to return the result as soon as it is found.

We can specify the `change_type = "not_na"` argument to indicate that we want the attack to misclassify the cluster as an existing cell type, rather than as NA.

```
genesMinChange <- advSingleGene(matPbmc, cellTypes, "DC",
                        MClassifier, exclGenes = markers, advMethod = "perc99",
                        returnFirstFound = TRUE, changeType = "not_na",
                        firstDichot = 10)
```

```
genesMinChange
```

```
## $PF4
## [1] "Platelet" "1"
```

The function found that modifying the single gene PF4 with the `perc99` modification on the cluster leads to a new classification, Platelet.

Let’s run this attack and verify if it is successful.

First we modify the `matPbmc` matrix on the target cluster.

```
matAdver <- advModifications(matPbmc, names(genesMinChange@values)[1], cellTypes, "DC")
```

Then classify the “DC” cluster with `MClassifier`.

```
resClassif <- MClassifier(matAdver, cellTypes, "DC")
```

```
resClassif
```

```
## $prediction
## [1] "Platelet"
##
## $odd
## [1] 1
##
## $typePredictions
##              1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
## Naive CD4 T  0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## FCGR3A+ Mono 0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## B            0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Memory CD4 T 0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## CD14+ Mono   0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## CD8 T        0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## UNDETERMINED 0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## NK           0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Platelet     1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
## DC           0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
##              26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
## Naive CD4 T   0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## FCGR3A+ Mono  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## B             0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Memory CD4 T  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## CD14+ Mono    0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## CD8 T         0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## UNDETERMINED  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## NK            0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Platelet      1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
## DC            0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
##              48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69
## Naive CD4 T   0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## FCGR3A+ Mono  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## B             0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Memory CD4 T  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## CD14+ Mono    0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## CD8 T         0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## UNDETERMINED  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## NK            0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Platelet      1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
## DC            0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
##              70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91
## Naive CD4 T   0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## FCGR3A+ Mono  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## B             0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Memory CD4 T  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## CD14+ Mono    0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## CD8 T         0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## UNDETERMINED  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## NK            0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Platelet      1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
## DC            0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
##              92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109
## Naive CD4 T   0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## FCGR3A+ Mono  0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## B             0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## Memory CD4 T  0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## CD14+ Mono    0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## CD8 T         0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## UNDETERMINED  0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## NK            0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## Platelet      1  1  1  1  1  1  1  1   1   1   1   1   1   1   1   1   1   1
## DC            0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
##              110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125
## Naive CD4 T    0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## FCGR3A+ Mono   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## B              0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Memory CD4 T   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## CD14+ Mono     0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## CD8 T          0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## UNDETERMINED   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## NK             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Platelet       1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
## DC             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
##              126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141
## Naive CD4 T    0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## FCGR3A+ Mono   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## B              0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Memory CD4 T   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## CD14+ Mono     0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## CD8 T          0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## UNDETERMINED   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## NK             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Platelet       1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
## DC             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
##              142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157
## Naive CD4 T    0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## FCGR3A+ Mono   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## B              0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Memory CD4 T   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## CD14+ Mono     0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## CD8 T          0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## UNDETERMINED   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## NK             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Platelet       1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
## DC             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
##              158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173
## Naive CD4 T    0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## FCGR3A+ Mono   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## B              0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Memory CD4 T   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## CD14+ Mono     0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## CD8 T          0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## UNDETERMINED   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## NK             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Platelet       1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
## DC             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
##              174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189
## Naive CD4 T    0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## FCGR3A+ Mono   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## B              0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Memory CD4 T   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## CD14+ Mono     0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## CD8 T          0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## UNDETERMINED   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## NK             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Platelet       1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
## DC             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
##              190 191 192 193 194 195 196 197 198 199 200
## Naive CD4 T    0   0   0   0   0   0   0   0   0   0   0
## FCGR3A+ Mono   0   0   0   0   0   0   0   0   0   0   0
## B              0   0   0   0   0   0   0   0   0   0   0
## Memory CD4 T   0   0   0   0   0   0   0   0   0   0   0
## CD14+ Mono     0   0   0   0   0   0   0   0   0   0   0
## CD8 T          0   0   0   0   0   0   0   0   0   0   0
## UNDETERMINED   0   0   0   0   0   0   0   0   0   0   0
## NK             0   0   0   0   0   0   0   0   0   0   0
## Platelet       1   1   1   1   1   1   1   1   1   1   1
## DC             0   0   0   0   0   0   0   0   0   0   0
##
## $cellTypes
## [1] "Platelet" "Platelet" "Platelet"
```

## Max-change attack

Modify the maximum number of genes inside a cell cluster without altering its classification.

The function `advMaxChange` runs a dichotomic search of gene subsets, given the cluster to attack and a type of modification, such that the classification does not change.

The `maxSplitSize` argument is the maximum size of dichotomic slices. Set to 1 to have better results, but it will take longer to compute.

```
genesMaxChange <- advMaxChange(matPbmc, cellTypes, "Memory CD4 T", MClassifier,
                    exclGenes = markers, advMethod = "perc99")
```

```
length(genesMaxChange@values)
```

```
## [1] 179
```

The function found 179 genes that you can modify with the `perc99` modification, and the cluster is still classified as `Memory CD4 T`.

Let’s run this attack and verify if it is successful.

First we modify the `matPbmc` matrix on the target cluster, on the genes previously determined.

```
matMaxAdver <- advModifications(matPbmc, genesMaxChange@values, cellTypes, "Memory CD4 T")
```

Then we verify that classification is still `Memory CD4 T`.

```
resClassif <- MClassifier(matMaxAdver, cellTypes, "Memory CD4 T")
```

```
resClassif
```

```
## $prediction
## [1] "Memory CD4 T"
##
## $odd
## [1] 1
##
## $typePredictions
##              1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
## Naive CD4 T  0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## FCGR3A+ Mono 0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## B            0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Memory CD4 T 1 1 1 1 1 1 1 1 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
## CD14+ Mono   0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## CD8 T        0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## UNDETERMINED 0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## NK           0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Platelet     0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## DC           0 0 0 0 0 0 0 0 0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
##              26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
## Naive CD4 T   0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## FCGR3A+ Mono  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## B             0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Memory CD4 T  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
## CD14+ Mono    0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## CD8 T         0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## UNDETERMINED  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## NK            0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Platelet      0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## DC            0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
##              48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69
## Naive CD4 T   0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## FCGR3A+ Mono  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## B             0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Memory CD4 T  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
## CD14+ Mono    0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## CD8 T         0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## UNDETERMINED  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## NK            0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Platelet      0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## DC            0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
##              70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91
## Naive CD4 T   0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## FCGR3A+ Mono  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## B             0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Memory CD4 T  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
## CD14+ Mono    0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## CD8 T         0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## UNDETERMINED  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## NK            0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## Platelet      0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
## DC            0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
##              92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109
## Naive CD4 T   0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## FCGR3A+ Mono  0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## B             0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## Memory CD4 T  1  1  1  1  1  1  1  1   1   1   1   1   1   1   1   1   1   1
## CD14+ Mono    0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## CD8 T         0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## UNDETERMINED  0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## NK            0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## Platelet      0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
## DC            0  0  0  0  0  0  0  0   0   0   0   0   0   0   0   0   0   0
##              110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125
## Naive CD4 T    0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## FCGR3A+ Mono   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## B              0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Memory CD4 T   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
## CD14+ Mono     0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## CD8 T          0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## UNDETERMINED   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## NK             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Platelet       0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## DC             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
##              126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141
## Naive CD4 T    0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## FCGR3A+ Mono   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## B              0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Memory CD4 T   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
## CD14+ Mono     0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## CD8 T          0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## UNDETERMINED   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## NK             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Platelet       0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## DC             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
##              142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157
## Naive CD4 T    0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## FCGR3A+ Mono   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## B              0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Memory CD4 T   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
## CD14+ Mono     0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## CD8 T          0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## UNDETERMINED   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## NK             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Platelet       0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## DC             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
##              158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173
## Naive CD4 T    0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## FCGR3A+ Mono   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## B              0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Memory CD4 T   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
## CD14+ Mono     0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## CD8 T          0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## UNDETERMINED   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## NK             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Platelet       0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## DC             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
##              174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189
## Naive CD4 T    0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## FCGR3A+ Mono   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## B              0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Memory CD4 T   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
## CD14+ Mono     0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## CD8 T          0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## UNDETERMINED   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## NK             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## Platelet       0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
## DC             0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
##              190 191 192 193 194 195 196 197 198 199 200
## Naive CD4 T    0   0   0   0   0   0   0   0   0   0   0
## FCGR3A+ Mono   0   0   0   0   0   0   0   0   0   0   0
## B              0   0   0   0   0   0   0   0   0   0   0
## Memory CD4 T   1   1   1   1   1   1   1   1   1   1   1
## CD14+ Mono     0   0   0   0   0   0   0   0   0   0   0
## CD8 T          0   0   0   0   0   0   0   0   0   0   0
## UNDETERMINED   0   0   0   0   0   0   0   0   0   0   0
## NK             0   0   0   0   0   0   0   0   0   0   0
## Platelet       0   0   0   0   0   0   0   0   0   0   0
## DC             0   0   0   0   0   0   0   0   0   0   0
##
## $cellTypes
##  [1] "Memory CD4 T" "Memory CD4 T" "Memory CD4 T" "Memory CD4 T" "Memory CD4 T"
##  [6] "Memory CD4 T" "Memory CD4 T" "Memory CD4 T" "Memory CD4 T" "Memory CD4 T"
## [11] "Memory CD4 T" "Memory CD4 T" "Memory CD4 T" "Memory CD4 T" "Memory CD4 T"
## [16] "Memory CD4 T" "Memory CD4 T" "Memory CD4 T" "Memory CD4 T" "Memory CD4 T"
## [21] "Memory CD4 T" "Memory CD4 T" "Memory CD4 T" "Memory CD4 T"
```

## CGD attack

Apply the Cluster Gradient Descent (CGD) attack on the “Memory CD4 T” cells cluster with parameters alpha=epsilon=1

```
resCGD <- advCGD(as.data.frame(matPbmc), cellTypes,
                "Memory CD4 T", MClassifier, alpha=1, epsilon=1,
                genes=colnames(matPbmc)[ncol(matPbmc):1])
```

The algorithm test each gene and stops when the cluster prediction has switched
to another cell type prediction. Here it stops after having modified the CCR5 gene which make the classifier switch its prediction to Naive CD4 T.

```
tail(resCGD$byGeneSummary)
```

```
##    order   gene nbModifiedCells oriCell_pourc targCell_pourc oriCell_odd
## 9      8   CD8A               0             1              0           1
## 10     9  MS4A1               0             1              0           1
## 11    10 S100A4               0             1              0           1
## 12    11    LYZ               0             1              0           1
## 13    12   CD14               0             1              0           1
## 14    13   CCR7              24             0              1         NaN
##    targCell_odd wholeClust_oriOdd wholeClust_targOdd
## 9             0               NaN                NaN
## 10            0               NaN                NaN
## 11            0               NaN                NaN
## 12            0               NaN                NaN
## 13            0               NaN                NaN
## 14            1               NaN                NaN
```

```
resCGD$oneRowSummary
```

```
##  [1] "Memory CD4 T" "24"           "Naive CD4 T"  "1"            "1"
##  [6] "0"            "1"            "13"           "1"            "0"
## [11] "0"            "1"            "NaN"          "NaN"          "NaN"
## [16] "NaN"
```

You can retrieve the modified matrix.

```
modifiedMatrix <- resCGD$expr
```

And visualize the list of modified genes.

```
resCGD$modGenes
```

```
## [1] "CCR7"
```

Check the new classification of the modified matrix.

```
MClassifier(modifiedMatrix, cellTypes, "Memory CD4 T")$prediction
```

```
## [1] "Naive CD4 T"
```

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] LoomExperiment_1.28.0       BiocIO_1.20.0
##  [3] rhdf5_2.54.0                SingleCellExperiment_1.32.0
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0         generics_0.1.4
## [15] adverSCarial_1.8.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] xfun_0.53           stringi_1.8.7       h5mread_1.2.0
##  [7] DelayedArray_0.36.0 glue_1.8.0          grid_4.5.1
## [10] evaluate_1.0.5      abind_1.4-8         lifecycle_1.0.4
## [13] Rhdf5lib_1.32.0     stringr_1.5.2       compiler_4.5.1
## [16] rhdf5filters_1.22.0 XVector_0.50.0      lattice_0.22-7
## [19] SparseArray_1.10.0  HDF5Array_1.38.0    magrittr_2.0.4
## [22] Matrix_1.7-4        tools_4.5.1         S4Arrays_1.10.0
```