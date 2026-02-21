# BeadSorted.Saliva.EPIC

#### Jonah Fisher

#### 2025-10-30

# Overview

The **BeadSorted.Saliva.EPIC** data package contains publically available Illumina human methylation data from EPIC saliva samples assayed by Middleton, John Dou, Jonah Fisher, Jonathan A. Heiss, Vy K. Nguyen, Allan C. Just, Jessica Faul, Erin B. Ware, Colter Mitchell, Justin A. Colacino & Kelly M. Bakulski (2021) Saliva cell type DNA methylation reference panel for epidemiological studies in children, Epigenetics, DOI: 10.1080/15592294.2021.1890874. It includes an RGChannelSet, a comparison table with degree of association between cell type and samples, and cell proportion estimates within our samples as calculated by the ewastools implementation of the Houseman algorithm. This dataset is novel for cell proportion estimations in saliva and may be useful to end users for estimating and controlling for cell-type heterogeneity in their study samples.

# RGChannelSet

This package includes the *BeadSorted.Saliva.EPIC* RGChannelSet object. This dataset contains 60 samples, all collected from saliva taken from 22 children, with some being separated into cellular populations using bead sorting. The 60 samples consist of immune cells, epithelial cells, whole samples, and samples taken directly from the Oragene kit. The RGChannelSet is hosted on experiment hub and the raw idats are hosted on GEO as GSE147318.

```
library(ExperimentHub)
hub <- ExperimentHub()

query(hub, "BeadSorted.Saliva.EPIC")

BeadSorted.Saliva.EPIC <- hub[["EH4539"]]
BeadSorted.Saliva.EPIC
```

# Table

The *BeadSorted.Saliva.EPIC.compTable* contains comparisons of methylation of each quality control passing EPIC CpG between the 20 epithelial cell samples and the 18 immune cell samples as well as basic summary statistics. Comparisons include t-test statistic and it’s corresponding p-value. Summary statistics include the minimum and maximum beta methylation value for each probe and the average methylation value across epithelial cells and across immune cells.

```
library(ExperimentHub)
hub <- ExperimentHub()

query(hub, "BeadSorted.Saliva.EPIC.compTable")

BeadSorted.Saliva.EPIC.compTable <- hub[["EH4540"]]
head(BeadSorted.Saliva.EPIC.compTable)
```

# Estimates

The *BeadSorted.Saliva.EPIC.Estimates* contains estimated epithelial and immune cell proportions for each sample as computed with the [**ewastools**](https://github.com/hhhh5/ewastools) function *estimateLC()*. The proportions are computed by a reference dataset created from the idats corresponding to epithelial and immune cell samples. Coefficients are estimated using the Houseman algorithm.

```
head(BeadSorted.Saliva.EPIC.estimates)
```