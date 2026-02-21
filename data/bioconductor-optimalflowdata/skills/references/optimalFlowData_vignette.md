# optimalFlowData: a data package for optimalFlow

Hristo Inouzhe1\*

1Universidad de Valladolid, Spain

\*hristo.inouzhe@gmail.com

#### 04 November, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Use](#use)
* [References](#references)

# 1 Introduction

*optimalFlowData* is a package containing 40 simulated flow cytometry datasets, saved as data frames, used for testing and developping examples for the package *optimalFlow* based on the results in del Barrio et al. ([2019](#ref-optimalFlow)).

The simulated cytometries are based on data that come from flow cytometry measurements obtained following the Euroflow protocols and kindly provided by Centro de Investigación del Cancer (CIC) in Salamanca, Spain. The artificial cytometries mimic 31 cytometries from healthy individuals and 9 cytometries from patients with different types of cancer.

# 2 Installation

Installation procedure:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("optimalFlowData")
```

# 3 Use

```
library(optimalFlowData)
head(Cytometry1)
```

```
##   CD19/TCRgd:PE Cy7-A LOGICAL CD38:APC H7-A LOGICAL CD3:APC-A LOGICAL
## 1                        3808                  5814              3060
## 2                        2848                  5584              3472
## 3                        3008                  5103              2814
## 4                        3283                  5270              2660
## 5                        3600                  6056              4136
## 6                        3271                  6091              3876
##   CD4+CD20:PB-A LOGICAL CD45:PO-A LOGICAL CD56+IgK:PE-A LOGICAL
## 1                  2449              4620                  5498
## 2                  2388              4391                  6064
## 3                  2017              4440                  5350
## 4                  1877              4339                  5634
## 5                  1198              4666                  5963
## 6                  2422              4506                  5791
##   CD5:PerCP Cy5-5-A LOGICAL CD8+IgL:FITC-A LOGICAL FSC-A LINEAR
## 1                      3112                   5200         1780
## 2                      1691                   5491         2104
## 3                      3531                   4982         2034
## 4                      2358                   5010         1762
## 5                      2272                   5246         2033
## 6                      2161                   5094         1657
##   SSC-A Exp-SSC Low Population ID (name)
## 1              1626            Basophils
## 2              1769            Basophils
## 3              1721            Basophils
## 4              1211            Basophils
## 5              1913            Basophils
## 6              1398            Basophils
```

We can create a database of gated cytometries containing. For simplicity and visualisation we only choose 4 cell types. For an example of a database, we select some of the cytometries, as is usual in machine learning, where a subset of the data is the learning set.

```
database <- buildDatabase(
  dataset_names = paste0('Cytometry', c(2:5, 7:9, 12:17, 19, 21)),
    population_ids = c('Monocytes', 'CD4+CD8-', 'Mature SIg Kappa', 'TCRgd-'))
```

A plot of the data in a 3 dimensional subspace

```
pairs(database[[1]][,c(4, 3, 9)], col = droplevels(database[[1]][, 11]))
```

![](data:image/png;base64...)
The diagnosis for each cytometry is obtained as follows

```
help("cytometry.diagnosis") # for an explanation of the abbreviations
cytometry.diagnosis
```

```
##  [1] "HD"    "HD"    "HD"    "HD"    "HD"    "HD"    "HD"    "HD"    "HD"
## [10] "HD"    "HD"    "HD"    "HD"    "HD"    "HD"    "HD"    "HD"    "HD"
## [19] "HD"    "HD"    "HD"    "MCL"   "MCL"   "FL"    "MCL"   "LPL"   "CLL"
## [28] "CLL"   "HD"    "HD"    "HD"    "HD"    "HD"    "DLBCL" "HCL"   "HD"
## [37] "HD"    "HD"    "HD"    "HD"
```

# References

del Barrio, Eustasio, Hristo Inouzhe, Jean-Michel Loubes, Agustin Mayo-Iscar, and Carlos Matran. 2019. “optimalFlow: Optimal-Transport Approach to Flow Cytometry Analysis,” July. <https://arxiv.org/abs/1907.08006>.