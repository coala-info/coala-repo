# Explore data integration and batch effects

Almut Luetge1,2\* and Mark D Robinson1,2

1Institute for Molecular Life Sciences, University of Zurich, Switzerland
2SIB Swiss Institute of Bioinformatics, University of Zurich, Switzerland

\*almut.luetge@uzh.ch

#### 29 October 2025

#### Abstract

A tool set to evaluate and visualize data integration and batch effects in single-cell RNA-seq data.

#### Package

*[CellMixS](https://bioconductor.org/packages/3.22/CellMixS)*

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Getting started](#getting-started)
  + [3.1 Load example data](#load-example-data)
  + [3.2 Visualize batch effect](#visualize-batch-effect)
* [4 Quantify batch effects](#quantify-batch-effects)
  + [4.1 Cellspecific Mixing scores](#cellspecific-mixing-scores)
* [5 Parameter](#parameter)
  + [5.1 Defining neighbourhoods](#defining-neighbourhoods)
  + [5.2 Further cms parameter settings](#further-cms-parameter-settings)
  + [5.3 Visualize the cell mixing score](#visualize-the-cell-mixing-score)
* [6 Evaluate data integration](#evaluate-data-integration)
  + [6.1 Mixing after data integration](#di1)
  + [6.2 Compare data integration methods](#di2)
  + [6.3 Remaining batch-specific structure - ldfDiff](#remaining-batch-specific-structure---ldfdiff)
  + [6.4 Visualize ldfDiff](#ldf)
* [7 Testing different metrics](#testing-different-metrics)
* [8 Session info](#session-info)
* [9 References](#references)
* **Appendix**

# 1 Introduction

The *[CellMixS](https://bioconductor.org/packages/3.22/CellMixS)* package is a toolbox to
explore and compare group effects in single-cell RNA-seq data.
It has two major applications:

* Detection of batch effects and biases in single-cell RNA-seq data.
* Evaluation and comparison of data integration
  (e.g. after batch effect correction).

For this purpose it introduces two new metrics:

* **Cellspecific Mixing Score (CMS)**: A test for batch effects within k-nearest
  neighbouring cells.
* **Local Density Differences (ldfDiff)**: A score describing the change in
  relative local cell densities by data integration or projection.

It also provides implementations and wrappers for a set of metrics with a similar
purpose: entropy, the inverse Simpson index (Korsunsky et al. [2018](#ref-Korsunsky2018)), and Seurat’s mixing metric
and local structure metric (Stuart et al. [2018](#ref-Stuart2018)).
Besides this, several exploratory plotting functions enable evaluation of key
integration and mixing features.

# 2 Installation

*[CellMixS](https://bioconductor.org/packages/3.22/CellMixS)* can be installed from Bioconductor as follows.

```
if (!requireNamespace("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("CellMixS")
```

After installation the package can be loaded into R.

```
library(CellMixS)
```

# 3 Getting started

## 3.1 Load example data

*[CellMixS](https://bioconductor.org/packages/3.22/CellMixS)* uses the `SingleCellExperiment`
class from the *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* Bioconductor
package as the format for input data.

The package contains example data named **sim50**, a list of simulated
single-cell RNA-seq data with varying batch effect strength and unbalanced
batch sizes.

Batch effects were introduced by sampling 0%, 20% or 50% of gene expression
values from a distribution with modified mean value (e.g. 0% - 50% of genes were
affected by a batch effect).

All datasets consist of *3 batches*, one with *250 cells* and the others with
half of its size (*125 cells*). The simulation is modified after
(Büttner et al. [2019](#ref-Buttner2019)) and described in [sim50](https://github.com/almutlue/CellMixS/blob/master/inst/script/simulate_batch_scRNAseq.Rmd).

```
# Load required packages
suppressPackageStartupMessages({
    library(SingleCellExperiment)
    library(cowplot)
    library(limma)
    library(magrittr)
    library(dplyr)
    library(purrr)
    library(ggplot2)
    library(scater)
})
```

```
# Load sim_list example data
sim_list <- readRDS(system.file(file.path("extdata", "sim50.rds"),
                                package = "CellMixS"))
names(sim_list)
#> [1] "batch0"  "batch20" "batch50"

sce50 <- sim_list[["batch50"]]
class(sce50)
#> [1] "SingleCellExperiment"
#> attr(,"package")
#> [1] "SingleCellExperiment"

table(sce50[["batch"]])
#>
#>   1   2   3
#> 250 125 125
```

## 3.2 Visualize batch effect

Often batch effects can already be detected by visual inspection and simple
visualization (e.g. in a normal tSNE or UMAP plot) depending on the strength. *[CellMixS](https://bioconductor.org/packages/3.22/CellMixS)* contains various plotting functions to
visualize group label and mixing scores aside. Results are `ggplot` objects and can be further customized
using *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)*. Other packages, such as
*[scater](https://bioconductor.org/packages/3.22/scater)*, provide similar plotting functions and could
be used instead.

```
# Visualize batch distribution in sce50
visGroup(sce50, group = "batch")
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the CellMixS package.
#>   Please report the issue at <https://github.com/almutlue/CellMixS/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> ℹ The deprecated feature was likely used in the CellMixS package.
#>   Please report the issue at <https://github.com/almutlue/CellMixS/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

```
# Visualize batch distribution in other elements of sim_list
batch_names <- c("batch0", "batch20")

vis_batch <- lapply(batch_names, function(name){
    sce <- sim_list[[name]]
    visGroup(sce, "batch") + ggtitle(paste0("sim_", name))
})

plot_grid(plotlist = vis_batch, ncol = 2)
```

![](data:image/png;base64...)

# 4 Quantify batch effects

## 4.1 Cellspecific Mixing scores

Not all batch effects or group differences are obvious using visualization.
Also, in single-cell experiments celltypes and cells can be affected in
different ways by experimental conditions causing batch effects (e.g. some
cells are more robust to storing conditions than others).

Furthermore the range of methods for data integration and batch effect removal
gives rise to the question of which method performs best on which data, and
thereby a need to quantify batch effects.

The **cellspecific mixing score** `cms` tests for each cell the hypothesis that
batch-specific distance distributions towards it’s k-nearest neighbouring (knn)
cells are derived from the same unspecified underlying distribution using the
Anderson-Darling test (Scholz and Stephens [1987](#ref-Scholz1987)). Results from the `cms` function are two
scores *cms* and *cms\_smooth*, where the latter is the weighted mean of the cms
within each cell’s neighbourhood. They can be interpreted as the data’s
probability within an equally mixed neighbourhood. A high `cms` score refers to
good mixing, while a low score indicates batch-specific bias.
The test considers differences in the number of cells from each batch.
This facilitates the `cms` score to differentiate between unbalanced batches
(e.g. one celltype being more abundant in a specific batch) and a biased
distribution of cells. The `cms` function takes a `SingleCellExperiment`
object (described in *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)*) as input
and appends results to the colData slot.

# 5 Parameter

```
# Call cell-specific mixing score for sce50
# Note that cell_min is set to 4 due to the low number of cells and small k.
# Usually default parameters are recommended!!
sce50 <- cms(sce50, k = 30, group = "batch", res_name = "unaligned",
             n_dim = 3, cell_min = 4)
head(colData(sce50))
#> DataFrame with 6 rows and 3 columns
#>           batch cms_smooth.unaligned cms.unaligned
#>        <factor>            <numeric>     <numeric>
#> cell_1        1           0.00000000             0
#> cell_2        1           0.01969896             0
#> cell_3        1           0.00000000             0
#> cell_4        1           0.00823378             0
#> cell_5        1           0.02896438             0
#> cell_6        1           0.06544070             0

# Call cell-specific mixing score for all datasets
sim_list <- lapply(batch_names, function(name){
    sce <- sim_list[[name]]
    sce <- cms(sce, k = 30, group = "batch", res_name = "unaligned",
               n_dim = 3, cell_min = 4)
}) %>% set_names(batch_names)

# Append cms50
sim_list[["batch50"]] <- sce50
```

## 5.1 Defining neighbourhoods

A key question when evaluating dataset structures is how to define neighbourhoods,
or in this case, which cells to use to calculate the mixing.
`cms` provides 3 options to define cells included in each Anderson-Darling test:

* **Number of knn**: This is the default setting and can be set by the parameter
  `k`. The optimal choice depends on the application, as with a small `k` focus is
  on local mixing, while with a large `k` mixing with regard to more global
  structures is evaluated. In general `k` should not exceed the size of the
  smallest cell population as including cells from different cell populations can
  conflict with the underlying assumptions of distance distributions.
* **Density based neighbourhoods**: In cases of unequal cell population sizes
  the optimal number of neighbours might vary. Using the size of the smallest
  population can lead to suboptimal neighbourhoods for larger populations in these
  cases, as the power of the AD-test increases with cell numbers. For these cases
  or others where a local adaptation of the neighbourhood is desired the `k_min`
  parameter is provided. It denotes the minimum number of cells that define a
  neighbourhood. Starting with the *knn* as defined by `k` the `cms` function will
  cut neighbourhoods by their first local minimum in the
  *overall distance distribution* of the *knn* cells. Only cells within a distance
  smaller than the first local minimum are included in the AD-test, but at least
  `k_min` cells.
* **Fixed minimum per batch**: Another option to define a dynamic neighbourhood
  is provided by the `batch_min` parameter. It defines the minimum number of cells
  for each batch that shall be included into each neighbourhood.
  In this case the neighbourhoods will include an increasing number of neighbours
  until at least `batch_min` cells from each batch are included.

## 5.2 Further cms parameter settings

For smoothing, either `k` or (if specified) `k_min` cells are included to get a
weighted mean of `cms`-scores. Weights are defined by the reciprocal distance
towards the respective cell, with 1 as weight of the respective cell itself.

Another important parameter is the subspace to use to calculate cell distances.
This can be set using the `dim_red` parameter. By default the *PCA* subspace will be
used and calculated if not present. Some *data integration methods* provide
embeddings of a *common subspace* instead of “corrected counts”. `cms` scores
can be calculated within these by defining them with the `dim_red` argument (see [6.1](#di1)).
In general all reduced dimension representations can be specified, but only
*PCA* will be computed automatically, while other methods need to be
precomputed.

## 5.3 Visualize the cell mixing score

An overall summary of `cms` scores can be visualized as a histogram. As `cms` scores are
*p.values* from hypothesis testing, without any batch effect the p.value
histogram should be flat. An increased number of very small p-values
indicates the presence of a batch-specific bias within data.

```
# p-value histogram of cms50
visHist(sce50)
```

![](data:image/png;base64...)

```
# p-value histogram sim30
# Combine cms results in one matrix
batch_names <- names(sim_list)
cms_mat <- batch_names %>%
  map(function(name) sim_list[[name]]$cms.unaligned) %>%
  bind_cols() %>% set_colnames(batch_names)
#> New names:
#> • `` -> `...1`
#> • `` -> `...2`
#> • `` -> `...3`

visHist(cms_mat, n_col = 3)
```

![](data:image/png;base64...)

Results of `cms` can be visualized in a cell-specific way and alongside any
metadata.

```
# cms only cms20
sce20 <- sim_list[["batch20"]]
metric_plot <- visMetric(sce20, metric_var = "cms_smooth.unaligned")

# group only cms20
group_plot <- visGroup(sce20, group = "batch")

plot_grid(metric_plot, group_plot, ncol = 2)
```

![](data:image/png;base64...)

```
# Add random celltype assignments as new metadata
sce20[["celltype"]] <- rep(c("CD4+", "CD8+", "CD3"), length.out = ncol(sce20)) %>%
    as.factor

visOverview(sce20, "batch", other_var = "celltype")
```

![](data:image/png;base64...)

Systematic differences (e.g. celltype differences) can be further explored using
`visCluster`. Here we do not expect any systematic difference as celltypes were
randomly assigned.

```
visCluster(sce20, metric_var = "cms.unaligned", cluster_var = "celltype")
#> Picking joint bandwidth of 0.0996
```

![](data:image/png;base64...)

# 6 Evaluate data integration

## 6.1 Mixing after data integration

To remove batch effects when integrating different single-cell RNAseq datasets,
a range of methods can be used. The `cms` function can be used to evaluate the
effect of these methods, using a cell-specific mixing score. Some of them
(e.g. `fastMNN` from the *[batchelor](https://bioconductor.org/packages/3.22/batchelor)* package) provide a
“common subspace” with integrated embeddings. Other methods like
*[limma](https://bioconductor.org/packages/3.22/limma)* give “batch-corrected data” as results.
Both work as input for `cms`.

```
# MNN - embeddings are stored in the reducedDims slot of sce
reducedDimNames(sce20)
#> [1] "TSNE" "PCA"  "MNN"
sce20 <- cms(sce20, k = 30, group = "batch",
             dim_red = "MNN", res_name = "MNN", n_dim = 3, cell_min = 4)

# Run limma
sce20 <- scater::logNormCounts(sce20)
limma_corrected <- removeBatchEffect(logcounts(sce20), batch = sce20$batch)
#> design matrix of interest not specified. Assuming a one-group experiment.
# Add corrected counts to sce
assay(sce20, "lim_corrected") <- limma_corrected

# Run cms
sce20 <- cms(sce20, k = 30, group = "batch",
             assay_name = "lim_corrected", res_name = "limma", n_dim = 3,
             cell_min = 4)

names(colData(sce20))
#> [1] "batch"                "cms_smooth.unaligned" "cms.unaligned"
#> [4] "celltype"             "cms_smooth.MNN"       "cms.MNN"
#> [7] "sizeFactor"           "cms_smooth.limma"     "cms.limma"
```

## 6.2 Compare data integration methods

To compare different methods, summary plots from `visIntegration`
(see [6.4](#ldf)) and p-value histograms from `visHist` can be used. Local
patterns within single methods can be explored as described above.

```
# As pvalue histograms
visHist(sce20, metric = "cms.",  n_col = 3)
```

![](data:image/png;base64...)

Here both methods *[limma](https://bioconductor.org/packages/3.22/limma)* and `fastMNN` from the *[scran](https://bioconductor.org/packages/3.22/scran)* package flattened the p.value distribution.
So cells are better mixed after batch effect removal.

## 6.3 Remaining batch-specific structure - ldfDiff

Besides successful batch “mixing”, data integration should also preserve the
data’s internal structure and variability without adding new sources of
variability or removing underlying structures. Especially for methods that
result in “corrected counts” it is important to understand how much of the
dataset’s internal structures are preserved.

`ldfDiff` calculates the differences between each cell’s
**local density factor** before and after data integration (Latecki, Lazarevic, and Pokrajac [2007](#ref-Latecki2007)).
The local density factor is a relative measure of the cell density around a cell
compared to the densities within its neighbourhood. Local density factors are
calculated on the same set of k cells from the cell’s knn before integration.
In an optimal case relative densities (according to the same set of cells)
should not change by integration and the `ldfDiff` score should be close to 0.
In general the overall distribution of `ldfDiff` should be centered around 0
without long tails.

```
# Prepare input
# List with single SingleCellExperiment objects
# (Important: List names need to correspond to batch levels! See ?ldfDiff)
sce_pre_list <- list("1" = sce20[,sce20$batch == "1"],
                     "2" = sce20[,sce20$batch == "2"],
                     "3" = sce20[,sce20$batch == "3"])

sce20 <- ldfDiff(sce_pre_list, sce_combined = sce20,
                 group = "batch", k = 70, dim_red = "PCA",
                 dim_combined = "MNN", assay_pre = "counts",
                 n_dim = 3, res_name = "MNN")
#> New names:
#> New names:
#> New names:
#> • `` -> `...1`
#> • `` -> `...2`
#> • `` -> `...3`
#> • `` -> `...4`
#> • `` -> `...5`
#> • `` -> `...6`
#> • `` -> `...7`
#> • `` -> `...8`
#> • `` -> `...9`
#> • `` -> `...10`
#> • `` -> `...11`
#> • `` -> `...12`
#> • `` -> `...13`
#> • `` -> `...14`
#> • `` -> `...15`
#> • `` -> `...16`
#> • `` -> `...17`
#> • `` -> `...18`
#> • `` -> `...19`
#> • `` -> `...20`
#> • `` -> `...21`
#> • `` -> `...22`
#> • `` -> `...23`
#> • `` -> `...24`
#> • `` -> `...25`
#> • `` -> `...26`
#> • `` -> `...27`
#> • `` -> `...28`
#> • `` -> `...29`
#> • `` -> `...30`
#> • `` -> `...31`
#> • `` -> `...32`
#> • `` -> `...33`
#> • `` -> `...34`
#> • `` -> `...35`
#> • `` -> `...36`
#> • `` -> `...37`
#> • `` -> `...38`
#> • `` -> `...39`
#> • `` -> `...40`
#> • `` -> `...41`
#> • `` -> `...42`
#> • `` -> `...43`
#> • `` -> `...44`
#> • `` -> `...45`
#> • `` -> `...46`
#> • `` -> `...47`
#> • `` -> `...48`
#> • `` -> `...49`
#> • `` -> `...50`
#> • `` -> `...51`
#> • `` -> `...52`
#> • `` -> `...53`
#> • `` -> `...54`
#> • `` -> `...55`
#> • `` -> `...56`
#> • `` -> `...57`
#> • `` -> `...58`
#> • `` -> `...59`
#> • `` -> `...60`
#> • `` -> `...61`
#> • `` -> `...62`
#> • `` -> `...63`
#> • `` -> `...64`
#> • `` -> `...65`
#> • `` -> `...66`
#> • `` -> `...67`
#> • `` -> `...68`
#> • `` -> `...69`
#> • `` -> `...70`
#> • `` -> `...71`
#> • `` -> `...72`
#> • `` -> `...73`
#> • `` -> `...74`
#> • `` -> `...75`
#> • `` -> `...76`
#> • `` -> `...77`
#> • `` -> `...78`
#> • `` -> `...79`
#> • `` -> `...80`
#> • `` -> `...81`
#> • `` -> `...82`
#> • `` -> `...83`
#> • `` -> `...84`
#> • `` -> `...85`
#> • `` -> `...86`
#> • `` -> `...87`
#> • `` -> `...88`
#> • `` -> `...89`
#> • `` -> `...90`
#> • `` -> `...91`
#> • `` -> `...92`
#> • `` -> `...93`
#> • `` -> `...94`
#> • `` -> `...95`
#> • `` -> `...96`
#> • `` -> `...97`
#> • `` -> `...98`
#> • `` -> `...99`
#> • `` -> `...100`
#> • `` -> `...101`
#> • `` -> `...102`
#> • `` -> `...103`
#> • `` -> `...104`
#> • `` -> `...105`
#> • `` -> `...106`
#> • `` -> `...107`
#> • `` -> `...108`
#> • `` -> `...109`
#> • `` -> `...110`
#> • `` -> `...111`
#> • `` -> `...112`
#> • `` -> `...113`
#> • `` -> `...114`
#> • `` -> `...115`
#> • `` -> `...116`
#> • `` -> `...117`
#> • `` -> `...118`
#> • `` -> `...119`
#> • `` -> `...120`
#> • `` -> `...121`
#> • `` -> `...122`
#> • `` -> `...123`
#> • `` -> `...124`
#> • `` -> `...125`
#> • `` -> `...126`
#> • `` -> `...127`
#> • `` -> `...128`
#> • `` -> `...129`
#> • `` -> `...130`
#> • `` -> `...131`
#> • `` -> `...132`
#> • `` -> `...133`
#> • `` -> `...134`
#> • `` -> `...135`
#> • `` -> `...136`
#> • `` -> `...137`
#> • `` -> `...138`
#> • `` -> `...139`
#> • `` -> `...140`
#> • `` -> `...141`
#> • `` -> `...142`
#> • `` -> `...143`
#> • `` -> `...144`
#> • `` -> `...145`
#> • `` -> `...146`
#> • `` -> `...147`
#> • `` -> `...148`
#> • `` -> `...149`
#> • `` -> `...150`
#> • `` -> `...151`
#> • `` -> `...152`
#> • `` -> `...153`
#> • `` -> `...154`
#> • `` -> `...155`
#> • `` -> `...156`
#> • `` -> `...157`
#> • `` -> `...158`
#> • `` -> `...159`
#> • `` -> `...160`
#> • `` -> `...161`
#> • `` -> `...162`
#> • `` -> `...163`
#> • `` -> `...164`
#> • `` -> `...165`
#> • `` -> `...166`
#> • `` -> `...167`
#> • `` -> `...168`
#> • `` -> `...169`
#> • `` -> `...170`
#> • `` -> `...171`
#> • `` -> `...172`
#> • `` -> `...173`
#> • `` -> `...174`
#> • `` -> `...175`
#> • `` -> `...176`
#> • `` -> `...177`
#> • `` -> `...178`
#> • `` -> `...179`
#> • `` -> `...180`
#> • `` -> `...181`
#> • `` -> `...182`
#> • `` -> `...183`
#> • `` -> `...184`
#> • `` -> `...185`
#> • `` -> `...186`
#> • `` -> `...187`
#> • `` -> `...188`
#> • `` -> `...189`
#> • `` -> `...190`
#> • `` -> `...191`
#> • `` -> `...192`
#> • `` -> `...193`
#> • `` -> `...194`
#> • `` -> `...195`
#> • `` -> `...196`
#> • `` -> `...197`
#> • `` -> `...198`
#> • `` -> `...199`
#> • `` -> `...200`
#> • `` -> `...201`
#> • `` -> `...202`
#> • `` -> `...203`
#> • `` -> `...204`
#> • `` -> `...205`
#> • `` -> `...206`
#> • `` -> `...207`
#> • `` -> `...208`
#> • `` -> `...209`
#> • `` -> `...210`
#> • `` -> `...211`
#> • `` -> `...212`
#> • `` -> `...213`
#> • `` -> `...214`
#> • `` -> `...215`
#> • `` -> `...216`
#> • `` -> `...217`
#> • `` -> `...218`
#> • `` -> `...219`
#> • `` -> `...220`
#> • `` -> `...221`
#> • `` -> `...222`
#> • `` -> `...223`
#> • `` -> `...224`
#> • `` -> `...225`
#> • `` -> `...226`
#> • `` -> `...227`
#> • `` -> `...228`
#> • `` -> `...229`
#> • `` -> `...230`
#> • `` -> `...231`
#> • `` -> `...232`
#> • `` -> `...233`
#> • `` -> `...234`
#> • `` -> `...235`
#> • `` -> `...236`
#> • `` -> `...237`
#> • `` -> `...238`
#> • `` -> `...239`
#> • `` -> `...240`
#> • `` -> `...241`
#> • `` -> `...242`
#> • `` -> `...243`
#> • `` -> `...244`
#> • `` -> `...245`
#> • `` -> `...246`
#> • `` -> `...247`
#> • `` -> `...248`
#> • `` -> `...249`
#> • `` -> `...250`

sce20 <- ldfDiff(sce_pre_list, sce_combined = sce20,
                 group = "batch", k = 70, dim_red = "PCA",
                 dim_combined = "PCA", assay_pre = "counts",
                 assay_combined = "lim_corrected",
                 n_dim = 3, res_name = "limma")
#> New names:
#> New names:
#> New names:
#> • `` -> `...1`
#> • `` -> `...2`
#> • `` -> `...3`
#> • `` -> `...4`
#> • `` -> `...5`
#> • `` -> `...6`
#> • `` -> `...7`
#> • `` -> `...8`
#> • `` -> `...9`
#> • `` -> `...10`
#> • `` -> `...11`
#> • `` -> `...12`
#> • `` -> `...13`
#> • `` -> `...14`
#> • `` -> `...15`
#> • `` -> `...16`
#> • `` -> `...17`
#> • `` -> `...18`
#> • `` -> `...19`
#> • `` -> `...20`
#> • `` -> `...21`
#> • `` -> `...22`
#> • `` -> `...23`
#> • `` -> `...24`
#> • `` -> `...25`
#> • `` -> `...26`
#> • `` -> `...27`
#> • `` -> `...28`
#> • `` -> `...29`
#> • `` -> `...30`
#> • `` -> `...31`
#> • `` -> `...32`
#> • `` -> `...33`
#> • `` -> `...34`
#> • `` -> `...35`
#> • `` -> `...36`
#> • `` -> `...37`
#> • `` -> `...38`
#> • `` -> `...39`
#> • `` -> `...40`
#> • `` -> `...41`
#> • `` -> `...42`
#> • `` -> `...43`
#> • `` -> `...44`
#> • `` -> `...45`
#> • `` -> `...46`
#> • `` -> `...47`
#> • `` -> `...48`
#> • `` -> `...49`
#> • `` -> `...50`
#> • `` -> `...51`
#> • `` -> `...52`
#> • `` -> `...53`
#> • `` -> `...54`
#> • `` -> `...55`
#> • `` -> `...56`
#> • `` -> `...57`
#> • `` -> `...58`
#> • `` -> `...59`
#> • `` -> `...60`
#> • `` -> `...61`
#> • `` -> `...62`
#> • `` -> `...63`
#> • `` -> `...64`
#> • `` -> `...65`
#> • `` -> `...66`
#> • `` -> `...67`
#> • `` -> `...68`
#> • `` -> `...69`
#> • `` -> `...70`
#> • `` -> `...71`
#> • `` -> `...72`
#> • `` -> `...73`
#> • `` -> `...74`
#> • `` -> `...75`
#> • `` -> `...76`
#> • `` -> `...77`
#> • `` -> `...78`
#> • `` -> `...79`
#> • `` -> `...80`
#> • `` -> `...81`
#> • `` -> `...82`
#> • `` -> `...83`
#> • `` -> `...84`
#> • `` -> `...85`
#> • `` -> `...86`
#> • `` -> `...87`
#> • `` -> `...88`
#> • `` -> `...89`
#> • `` -> `...90`
#> • `` -> `...91`
#> • `` -> `...92`
#> • `` -> `...93`
#> • `` -> `...94`
#> • `` -> `...95`
#> • `` -> `...96`
#> • `` -> `...97`
#> • `` -> `...98`
#> • `` -> `...99`
#> • `` -> `...100`
#> • `` -> `...101`
#> • `` -> `...102`
#> • `` -> `...103`
#> • `` -> `...104`
#> • `` -> `...105`
#> • `` -> `...106`
#> • `` -> `...107`
#> • `` -> `...108`
#> • `` -> `...109`
#> • `` -> `...110`
#> • `` -> `...111`
#> • `` -> `...112`
#> • `` -> `...113`
#> • `` -> `...114`
#> • `` -> `...115`
#> • `` -> `...116`
#> • `` -> `...117`
#> • `` -> `...118`
#> • `` -> `...119`
#> • `` -> `...120`
#> • `` -> `...121`
#> • `` -> `...122`
#> • `` -> `...123`
#> • `` -> `...124`
#> • `` -> `...125`
#> • `` -> `...126`
#> • `` -> `...127`
#> • `` -> `...128`
#> • `` -> `...129`
#> • `` -> `...130`
#> • `` -> `...131`
#> • `` -> `...132`
#> • `` -> `...133`
#> • `` -> `...134`
#> • `` -> `...135`
#> • `` -> `...136`
#> • `` -> `...137`
#> • `` -> `...138`
#> • `` -> `...139`
#> • `` -> `...140`
#> • `` -> `...141`
#> • `` -> `...142`
#> • `` -> `...143`
#> • `` -> `...144`
#> • `` -> `...145`
#> • `` -> `...146`
#> • `` -> `...147`
#> • `` -> `...148`
#> • `` -> `...149`
#> • `` -> `...150`
#> • `` -> `...151`
#> • `` -> `...152`
#> • `` -> `...153`
#> • `` -> `...154`
#> • `` -> `...155`
#> • `` -> `...156`
#> • `` -> `...157`
#> • `` -> `...158`
#> • `` -> `...159`
#> • `` -> `...160`
#> • `` -> `...161`
#> • `` -> `...162`
#> • `` -> `...163`
#> • `` -> `...164`
#> • `` -> `...165`
#> • `` -> `...166`
#> • `` -> `...167`
#> • `` -> `...168`
#> • `` -> `...169`
#> • `` -> `...170`
#> • `` -> `...171`
#> • `` -> `...172`
#> • `` -> `...173`
#> • `` -> `...174`
#> • `` -> `...175`
#> • `` -> `...176`
#> • `` -> `...177`
#> • `` -> `...178`
#> • `` -> `...179`
#> • `` -> `...180`
#> • `` -> `...181`
#> • `` -> `...182`
#> • `` -> `...183`
#> • `` -> `...184`
#> • `` -> `...185`
#> • `` -> `...186`
#> • `` -> `...187`
#> • `` -> `...188`
#> • `` -> `...189`
#> • `` -> `...190`
#> • `` -> `...191`
#> • `` -> `...192`
#> • `` -> `...193`
#> • `` -> `...194`
#> • `` -> `...195`
#> • `` -> `...196`
#> • `` -> `...197`
#> • `` -> `...198`
#> • `` -> `...199`
#> • `` -> `...200`
#> • `` -> `...201`
#> • `` -> `...202`
#> • `` -> `...203`
#> • `` -> `...204`
#> • `` -> `...205`
#> • `` -> `...206`
#> • `` -> `...207`
#> • `` -> `...208`
#> • `` -> `...209`
#> • `` -> `...210`
#> • `` -> `...211`
#> • `` -> `...212`
#> • `` -> `...213`
#> • `` -> `...214`
#> • `` -> `...215`
#> • `` -> `...216`
#> • `` -> `...217`
#> • `` -> `...218`
#> • `` -> `...219`
#> • `` -> `...220`
#> • `` -> `...221`
#> • `` -> `...222`
#> • `` -> `...223`
#> • `` -> `...224`
#> • `` -> `...225`
#> • `` -> `...226`
#> • `` -> `...227`
#> • `` -> `...228`
#> • `` -> `...229`
#> • `` -> `...230`
#> • `` -> `...231`
#> • `` -> `...232`
#> • `` -> `...233`
#> • `` -> `...234`
#> • `` -> `...235`
#> • `` -> `...236`
#> • `` -> `...237`
#> • `` -> `...238`
#> • `` -> `...239`
#> • `` -> `...240`
#> • `` -> `...241`
#> • `` -> `...242`
#> • `` -> `...243`
#> • `` -> `...244`
#> • `` -> `...245`
#> • `` -> `...246`
#> • `` -> `...247`
#> • `` -> `...248`
#> • `` -> `...249`
#> • `` -> `...250`

names(colData(sce20))
#>  [1] "batch"                "cms_smooth.unaligned" "cms.unaligned"
#>  [4] "celltype"             "cms_smooth.MNN"       "cms.MNN"
#>  [7] "sizeFactor"           "cms_smooth.limma"     "cms.limma"
#> [10] "diff_ldf.MNN"         "diff_ldf.limma"
```

## 6.4 Visualize ldfDiff

Results from `ldfDiff` can be visualized in a similar way as results from `cms`.

```
# ldfDiff score summarized
visIntegration(sce20, metric = "diff_ldf", metric_name = "ldfDiff")
#> Picking joint bandwidth of 0.0867
```

![](data:image/png;base64...)

`ldfDiff` shows a clear difference between the two methods.
While *[limma](https://bioconductor.org/packages/3.22/limma)* is able to preserve the batch internal
structure within batches, `fastMNN` clearly changes it.
Even if batches are well mixed (see [6.2](#di2)), `fastMNN` does not work
for batch effect removal on these simulated data.
Again this is in line with expectations due to the small number of genes in
the example data. One of MNN’s assumptions is that batch effects should be much
smaller than biological variation, which does not hold true in this small
example dataset.

# 7 Testing different metrics

Often it is useful to check different aspects of data mixing and integration by
the use of different metrics, as many of them emphasize different features of
mixing. To provide an easy interface for thorough investigation of batch effects
and data integration a wrapper function of a variety of metrics is included into
*[CellMixS](https://bioconductor.org/packages/3.22/CellMixS)*. `evalIntegration` calls one or all of `cms`,
`ldfDiff`, `entropy` or equivalents to `mixingMetric`, `localStruct` from the
*[Seurat](https://CRAN.R-project.org/package%3DSeurat)* package or `isi`, a simplfied version of the
local inverse Simpson index as suggested by (Korsunsky et al. [2018](#ref-Korsunsky2018)). `entropy`
calculates the Shannon entropy within each cell’s *knn* describing the
randomness of the batch variable.
`isi` calculates the inverse Simpson index within each cell’s *knn*.
The Simpson index describes the probability that two entities are taken at
random from the dataset and its inverse represents the effective number of
batches in the neighbourhood. A simplified version of the distance based
weightening as proposed by (Korsunsky et al. [2018](#ref-Korsunsky2018)) is provided by the weight option.
As before the resulting scores are included into the colData slot of the input
`SingleCellExperiment` object and can be visualized with `visMetric` and other
plotting functions.

```
sce50 <- evalIntegration(metrics = c("isi", "entropy"), sce50,
                         group = "batch", k = 30, n_dim = 2, cell_min = 4,
                         res_name = c("weighted_isi", "entropy"))

visOverview(sce50, "batch",
            metric = c("cms_smooth.unaligned", "weighted_isi", "entropy"),
            prefix = FALSE)
```

![](data:image/png;base64...)

# 8 Session info

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
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] scater_1.38.0               scuttle_1.20.0
#>  [3] ggplot2_4.0.0               purrr_1.1.0
#>  [5] dplyr_1.1.4                 magrittr_2.0.4
#>  [7] limma_3.66.0                cowplot_1.2.0
#>  [9] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#> [11] Biobase_2.70.0              GenomicRanges_1.62.0
#> [13] Seqinfo_1.0.0               IRanges_2.44.0
#> [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [17] generics_0.1.4              MatrixGenerics_1.22.0
#> [19] matrixStats_1.5.0           CellMixS_1.26.0
#> [21] kSamples_1.2-12             SuppDists_1.1-9.9
#> [23] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1    viridisLite_0.4.2   vipor_0.4.7
#>  [4] farver_2.1.2        viridis_0.6.5       S7_0.2.0
#>  [7] fastmap_1.2.0       digest_0.6.37       rsvd_1.0.5
#> [10] lifecycle_1.0.4     statmod_1.5.1       compiler_4.5.1
#> [13] rlang_1.1.6         sass_0.4.10         tools_4.5.1
#> [16] yaml_2.3.10         knitr_1.50          S4Arrays_1.10.0
#> [19] labeling_0.4.3      DelayedArray_0.36.0 RColorBrewer_1.1-3
#> [22] abind_1.4-8         BiocParallel_1.44.0 withr_3.0.2
#> [25] grid_4.5.1          beachmat_2.26.0     scales_1.4.0
#> [28] ggridges_0.5.7      dichromat_2.0-0.1   tinytex_0.57
#> [31] cli_3.6.5           rmarkdown_2.30      crayon_1.5.3
#> [34] ggbeeswarm_0.7.2    cachem_1.1.0        parallel_4.5.1
#> [37] BiocManager_1.30.26 XVector_0.50.0      vctrs_0.6.5
#> [40] Matrix_1.7-4        jsonlite_2.0.0      bookdown_0.45
#> [43] BiocSingular_1.26.0 BiocNeighbors_2.4.0 ggrepel_0.9.6
#> [46] irlba_2.3.5.1       beeswarm_0.4.0      magick_2.9.0
#> [49] jquerylib_0.1.4     tidyr_1.3.1         glue_1.8.0
#> [52] codetools_0.2-20    gtable_0.3.6        ScaledMatrix_1.18.0
#> [55] tibble_3.3.0        pillar_1.11.1       htmltools_0.5.8.1
#> [58] R6_2.6.1            evaluate_1.0.5      lattice_0.22-7
#> [61] bslib_0.9.0         Rcpp_1.1.0          gridExtra_2.3
#> [64] SparseArray_1.10.0  xfun_0.53           pkgconfig_2.0.3
```

# 9 References

Büttner, Maren, Zhichao Miao, F. Alexander Wolf, Sarah A. Teichmann, and Fabian J. Theis. 2019. “A test metric for assessing single-cell RNA-seq batch correction.” *Nat. Methods* 16 (1): 43–49. <https://doi.org/10.1038/s41592-018-0254-1>.

Korsunsky, Ilya, Jean Fan, Kamil Slowikowski, Fan Zhang, Kevin Wei, Yuriy Baglaenko, Michael Brenner, Po-Ru Loh, and Soumya Raychaudhuri. 2018. “Fast, sensitive, and flexible integration of single cell data with Harmony.” *bioRxiv*, November, 461954. <https://doi.org/10.1101/461954>.

Latecki, Longin Jan, Aleksandar Lazarevic, and Dragoljub Pokrajac. 2007. “Outlier Detection with Kernel Density Functions.” In *Mach. Learn. Data Min. Pattern Recognit.*, 61–75. Berlin, Heidelberg: Springer Berlin Heidelberg. <https://doi.org/10.1007/978-3-540-73499-4_6>.

Scholz, F. W., and M. A. Stephens. 1987. “K-Sample Anderson-Darling Tests.” *J. Am. Stat. Assoc.* 82 (399): 918. <https://doi.org/10.2307/2288805>.

Stuart, Tim, Andrew Butler, Paul Hoffman, Christoph Hafemeister, Efthymia Papalexi, William M Mauck, Marlon Stoeckius, Peter Smibert, and Rahul Satija. 2018. “Comprehensive integration of single cell data.” *bioRxiv*, November, 460147. <https://doi.org/10.1101/460147>.

# Appendix