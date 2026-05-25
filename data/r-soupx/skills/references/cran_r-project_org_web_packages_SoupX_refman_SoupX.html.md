# Package {SoupX}

---

![[logo]](/usr/lib/R/doc/html/Rlogo.svg)

## Contents

* [PBMC\_metaData](#PBMC_metaData)
* [PBMC\_sc](#PBMC_sc)
* [SoupChannel](#SoupChannel)
* [SoupX](#SoupX)
* [adjustCounts](#adjustCounts)
* [alloc](#alloc)
* [autoEstCont](#autoEstCont)
* [calculateContaminationFraction](#calculateContaminationFraction)
* [estimateNonExpressingCells](#estimateNonExpressingCells)
* [estimateSoup](#estimateSoup)
* [expandClusters](#expandClusters)
* [initProgBar](#initProgBar)
* [load10X](#load10X)
* [plotChangeMap](#plotChangeMap)
* [plotMarkerDistribution](#plotMarkerDistribution)
* [plotMarkerMap](#plotMarkerMap)
* [plotSoupCorrelation](#plotSoupCorrelation)
* [print.SoupChannel](#print.SoupChannel)
* [quickMarkers](#quickMarkers)
* [scToy](#scToy)
* [setClusters](#setClusters)
* [setContaminationFraction](#setContaminationFraction)
* [setDR](#setDR)
* [setSoupProfile](#setSoupProfile)

---

|  |  |
| --- | --- |
| Title: | Single Cell mRNA Soup eXterminator |
| Version: | 1.6.2 |
| Date: | 2022-11-01 |
| Author: | Matthew Daniel Young |
| Maintainer: | Matthew Daniel Young <my4@sanger.ac.uk> |
| Description: | Quantify, profile and remove ambient mRNA contamination (the "soup") from droplet based single cell RNA-seq experiments. Implements the method described in Young et al. (2018) <[doi:10.1101/303727](https://doi.org/10.1101/303727)>. |
| URL: | <https://github.com/constantAmateur/SoupX> |
| Suggests: | knitr, rstan, DropletUtils, rmarkdown, formatR |
| VignetteBuilder: | knitr |
| Imports: | ggplot2, Matrix, methods, Seurat (≥ 3.2.2) |
| Depends: | R (≥ 3.5.0) |
| LazyData: | true |
| LazyDataCompression: | xz |
| License: | [GPL-2](https://www.r-project.org/Licenses/GPL-2) |
| Encoding: | UTF-8 |
| RoxygenNote: | 7.1.1 |
| NeedsCompilation: | no |
| Packaged: | 2022-11-01 13:18:04 UTC; my4 |
| Repository: | CRAN |
| Date/Publication: | 2022-11-01 14:00:03 UTC |

---

## PBMC 4K meta data

### Description

Collection of bits of meta data relating to the 10X PBMC 4K data.

### Usage

```
data(PBMC_metaData)
```

### Format

`PBMC_metaData` is a data.frame with 4 columns: RD1, RD2, Cluster, and Annotation.

### Details

This data set pertains to the 10X demonstration PBMC 4K data and includes metadata about it in the `data.frame` named `PBMC_metaData`.

`PBMC_metaData` was created using Seurat (v2) to calculate a tSNE representation of the data and cluster cells with these commands.

* `set.seed(1)`
* `srat = CreateSeuratObject(sc$toc)`
* `srat = NormalizeData(srat)`
* `srat = ScaleData(srat)`
* `srat = FindVariableGenes(srat)`
* `srat = RunPCA(srat,pcs.compute=30)`
* `srat = RunTSNE(srat,dims.use=seq(30))`
* `srat = FindClusters(srat,dims.use=seq(30),resolution=1)`
* `PBMC_metaData = as.data.frame(srat@dr$tsne@cell.embeddings)`
* `colnames(PBMC_metaData) = c('RD1','RD2')`
* `PBMC_metaData$Cluster = factor(srat@meta.data[rownames(PBMC_metaData),'res.1'])`
* `PBMC_metaData$Annotation = factor(c('7'='B','4'='B','1'='T_CD4','2'='T_CD4','3'='T_CD8','5'='T_CD8','6'='NK','8'='NK','0'='MNP','9'='MNP','10'='MNP','11'='?')[as.character(PBMC_metaData$Cluster)])`

### Source

<https://support.10xgenomics.com/single-cell-gene-expression/datasets/2.1.0/pbmc4k>

---

## SoupChannel from PBMC data

### Description

`[SoupChannel](#topic+SoupChannel)` created from 10X demonstration PBMC 4k data. The cells have been sub-sampled by a factor of 2 to reduce file size of package.

### Usage

```
data(PBMC_sc)
```

### Format

`PBMC_sc` is a `SoupChannel` object with 33,694 genes and 2,170 cells.

### Details

`PBMC_sc` was created by running the following commands.

* `set.seed(1137)`
* `tmpDir = tempdir(check=TRUE)`
* `download.file('http://cf.10xgenomics.com/samples/cell-exp/2.1.0/pbmc4k/pbmc4k_raw_gene_bc_matrices.tar.gz',destfile=file.path(tmpDir,'tod.tar.gz'))`
* `download.file('http://cf.10xgenomics.com/samples/cell-exp/2.1.0/pbmc4k/pbmc4k_filtered_gene_bc_matrices.tar.gz',destfile=file.path(tmpDir,'toc.tar.gz'))`
* `untar(file.path(tmpDir,'tod.tar.gz'),exdir=tmpDir)`
* `untar(file.path(tmpDir,'toc.tar.gz'),exdir=tmpDir)`
* `library(SoupX)`
* `PBMC_sc = load10X(tmpDir,calcSoupProfile=FALSE)`
* `PBMC_sc = SoupChannel(PBMC_sc$tod,PBMC_sc$toc[,sample(ncol(PBMC_sc$toc),round(ncol(PBMC_sc$toc)*0.5))])`

### Source

<https://support.10xgenomics.com/single-cell-gene-expression/datasets/2.1.0/pbmc4k>

---

## Construct a SoupChannel object

### Description

Creates a SoupChannel object that contains everything related to the soup estimation of a single channel.

### Usage

```
SoupChannel(tod, toc, metaData = NULL, calcSoupProfile = TRUE, ...)
```

### Arguments

|  |  |
| --- | --- |
| `tod` | Table of droplets. A matrix with columns being each droplet and rows each gene. |
| `toc` | Table of counts. Just those columns of `tod` that contain cells. |
| `metaData` | Meta data pertaining to the cells. Optional. Must be a data-frame with rownames equal to column names of `toc`. |
| `calcSoupProfile` | By default, the soup profile is calculated using `[estimateSoup](#topic+estimateSoup)` with default values. If you want to do something other than the defaults, set this to `FALSE` and call `[estimateSoup](#topic+estimateSoup)` manually. |
| `...` | Any other named parameters to store. |

### Value

A SoupChannel object.

### See Also

SoupChannelList estimateSoup setSoupProfile setClusters

### Examples

```
#Load droplet and count tables
tod = Seurat::Read10X(system.file('extdata','toyData','raw_gene_bc_matrices','GRCh38',
                                  package='SoupX'))
toc = Seurat::Read10X(system.file('extdata','toyData','filtered_gene_bc_matrices','GRCh38',
                                  package='SoupX'))
#Default calculates soup profile
sc = SoupChannel(tod,toc)
names(sc)
#This can be suppressed
sc = SoupChannel(tod,toc,calcSoupProfile=FALSE)
names(sc)
```

---

## SoupX: Profile, quantify and remove ambient RNA expression from droplet based RNA-seq

### Description

This package implements the method described in REF. First a few notes about nomenclature:
soup - Used a shorthand to refer to the ambient RNA which is contained in the input solution to droplet based RNA-seq experiments and ends up being sequenced along with the cell endogenous RNAs that the experiment is aiming to quantify.
channel - This refers to a single run input into a droplet based sequencing platform. For Chromium 10X 3' sequencing there are currently 8 "channels" per run of the instrument. Because the profile of the soup depends on the input solution, this is the minimal unit on which the soup should be estimated and subtracted.

### Details

The essential step in performing background correction is deciding which genes are not expressed in a reasonable fraction of cells. This is because SoupX estimates the contamination fraction by comparing the expression of these non-expressed genes in droplets containing cells to the soup defined from empty droplets. For solid tissue, the set of Haemoglobin genes usually works well. The key properties a gene should have are:
- it should be easy to identify when it is truly expressed (i.e., when it's expressed, it should be highly expressed)
- it should be highly specific to a certain cell type or group of cell types so that when the expression level is low, you can be confident that the expression is coming from the soup and not a very low level of expression from the cell

Spike-in RNAs are the best case scenario. In the case where you do not have spike-ins and haemoglobin genes are not viable estimators, the user should begin by using the [plotMarkerDistribution](#topic+plotMarkerDistribution) function to plot those genes with bi-modal distributions that have a pattern of expression across cells that is consistent with high cell-type specificity. The user should then select a set of genes that can be used for estimation from this list. One or two high quality genes is usually sufficient to obtain a good estimate for the average contamination level of a channel.

---

## Remove background contamination from count matrix

### Description

After the level of background contamination has been estimated or specified for a channel, calculate the resulting corrected count matrix with background contamination removed.

### Usage

```
adjustCounts(
  sc,
  clusters = NULL,
  method = c("subtraction", "soupOnly", "multinomial"),
  roundToInt = FALSE,
  verbose = 1,
  tol = 0.001,
  pCut = 0.01,
  ...
)
```

### Arguments

|  |  |
| --- | --- |
| `sc` | A SoupChannel object. |
| `clusters` | A vector of cluster IDs, named by cellIDs. If NULL clusters auto-loaded from `sc`. If FALSE, no clusters are used. See details. |
| `method` | Method to use for correction. See details. One of 'multinomial', 'soupOnly', or 'subtraction' |
| `roundToInt` | Should the resulting matrix be rounded to integers? |
| `verbose` | Integer giving level of verbosity. 0 = silence, 1 = Basic information, 2 = Very chatty, 3 = Debug. |
| `tol` | Allowed deviation from expected number of soup counts. Don't change this. |
| `pCut` | The p-value cut-off used when `method='soupOnly'`. |
| `...` | Passed to expandClusters. |

### Details

This essentially subtracts off the mean expected background counts for each gene, then redistributes any "unused" counts. A count is unused if its subtraction has no effect. For example, subtracting a count from a gene that has zero counts to begin with.

As expression data is highly sparse at the single cell level, it is highly recommended that clustering information be provided to allow the subtraction method to share information between cells. Without grouping cells into clusters, it is difficult (and usually impossible) to tell the difference between a count of 1 due to background contamination and a count of 1 due to endogenous expression. This ambiguity is removed at the cluster level where counts can be aggregated across cells. This information can then be propagated back to the individual cell level to provide a more accurate removal of contaminating counts.

To provide clustering information, either set clustering on the SoupChannel object with `[setClusters](#topic+setClusters)` or explicitly passing the `clusters` parameter.

If `roundToInt=TRUE`, this function will round the result to integers. That is, it will take the floor of the connected value and then round back up with probability equal to the fractional part of the number.

The `method` parameter controls how the removal of counts in performed. This should almost always be left at the default ('subtraction'), which iteratively subtracts counts from all genes as described above. The 'soupOnly' method will use a p-value based estimation procedure to identify those genes that can be confidently identified as having endogenous expression and removes everything else (described in greater detail below). Because this method either removes all or none of the expression for a gene in a cell, the correction procedure is much faster. Finally, the 'multinomial' method explicitly maximises the multinomial likelihood for each cell. This method gives essentially identical results as 'subtraction' and is considerably slower.

In greater detail, the 'soupOnly' method is done by sorting genes within each cell by their p-value under the null of the expected soup fraction using a Poisson model. So that genes that definitely do have a endogenous contribution are at the end of the list with p=0. Those genes for which there is poor evidence of endogenous cell expression are removed, until we have removed approximately nUMIs\*rho molecules. The cut-off to prevent removal of genes above nUMIs\*rho in each cell is achieved by calculating a separate p-value for the total number of counts removed to exceed nUMIs\*rho, again using a Poisson model. The two p-values are combined using Fisher's method and the cut-off is applied to the resulting combined p-value calculated using a chi-squared distribution with 4 degrees of freedom.

### Value

A modified version of the table of counts, with background contamination removed.

### Examples

```
out = adjustCounts(scToy)
#Return integer counts only
out = adjustCounts(scToy,roundToInt=TRUE)
```

---

## Allocate values to "buckets" subject to weights and constraints

### Description

Allocates `tgt` of something to `length(bucketLims)` different "buckets" subject to the constraint that each bucket has a maximum value of `bucketLims` that cannot be exceeded. By default counts are distributed equally between buckets, but weights can be provided using `ws` to have the redistribution prefer certain buckets over others.

### Usage

```
alloc(tgt, bucketLims, ws = rep(1/length(bucketLims), length(bucketLims)))
```

### Arguments

|  |  |
| --- | --- |
| `tgt` | Value to distribute between buckets. |
| `bucketLims` | The maximum value that each bucket can take. Must be a vector of positive values. |
| `ws` | Weights to be used for each bucket. Default value makes all buckets equally likely. |

### Value

A vector of the same length as `bucketLims` containing values distributed into buckets.

---

## Automatically calculate the contamination fraction

### Description

The idea of this method is that genes that are highly expressed in the soup and are marker genes for some population can be used to estimate the background contamination. Marker genes are identified using the tfidf method (see `[quickMarkers](#topic+quickMarkers)`). The contamination fraction is then calculated at the cluster level for each of these genes and clusters are then aggressively pruned to remove those that give implausible estimates.

### Usage

```
autoEstCont(
  sc,
  topMarkers = NULL,
  tfidfMin = 1,
  soupQuantile = 0.9,
  maxMarkers = 100,
  contaminationRange = c(0.01, 0.8),
  rhoMaxFDR = 0.2,
  priorRho = 0.05,
  priorRhoStdDev = 0.1,
  doPlot = TRUE,
  forceAccept = FALSE,
  verbose = TRUE
)
```

### Arguments

|  |  |
| --- | --- |
| `sc` | The SoupChannel object. |
| `topMarkers` | A data.frame giving marker genes. Must be sorted by decreasing specificity of marker and include a column 'gene' that contains the gene name. If set to NULL, markers are estimated using `[quickMarkers](#topic+quickMarkers)`. |
| `tfidfMin` | Minimum value of tfidf to accept for a marker gene. |
| `soupQuantile` | Only use genes that are at or above this expression quantile in the soup. This prevents inaccurate estimates due to using genes with poorly constrained contribution to the background. |
| `maxMarkers` | If we have heaps of good markers, keep only the best `maxMarkers` of them. |
| `contaminationRange` | Vector of length 2 that constrains the contamination fraction to lie within this range. Must be between 0 and 1. The high end of this range is passed to `[estimateNonExpressingCells](#topic+estimateNonExpressingCells)` as `maximumContamination`. |
| `rhoMaxFDR` | False discovery rate passed to `[estimateNonExpressingCells](#topic+estimateNonExpressingCells)`, to 