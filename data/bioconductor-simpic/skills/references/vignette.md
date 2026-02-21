# simPIC: simulating single-cell ATAC-seq data

Sagrika Chugh

#### 2025-10-30

#### Package

simPIC 1.6.0

![](data:image/png;base64...)

# 1 Introduction

simPIC is an R package for simulating single-cell ATAC sequencing (scATAC-seq) data. It provides flexible control over cell-type composition and batch structure. Users can generate synthetic scATAC-seq matrices that reflect realistic scATAC-seq data characteristics, including sparsity, heterogeneity, and technical variation.

simPIC supports simulation of:

* scATAC-seq data that mimics key characteristics— library size, peak means, and cell sparsity of real scATAC-seq data.
* Multiple cell types with varying proportions and distinct accessibility profiles.
* Batch effects that mimic real experimental scenarios.

The output includes peak-level accessibility counts and metadata, which can be used in downstream analysis pipelines. This vignette provides an overview of simPIC’s key functions and demonstrates how to simulate datasets under different experimental designs.

# 2 Installation

simPIC can be installed from Bioconductor:

```
BiocManager::install("simPIC")
```

To install the latest development version from GitHub use:

```
BiocManager::install(
    "sagrikachugh/simPIC",
    dependencies = TRUE,
    build_vignettes = TRUE
)
```

# 3 Quick start

To get started with simPIC, follow these two simple steps to simulate a dataset:

* Load your existing count matrix (similar to the one you wish to simulate) and estimate parameters using `simPICestimate` function
* Run the simulation with the `simPICsimulate` function to generate a synthetic dataset that mimics the characteristics of your real data.

```
# Load package
suppressPackageStartupMessages({
    library(simPIC)
})

# Load test data
set.seed(567)
counts <- readRDS(system.file("extdata", "test.rds", package = "simPIC"))

# Estimate parameters
est <- simPICestimate(counts)
#> simPIC is:
#> estimating library size parameters...
#> estimating sparsity...
#> estimating peak mean parameters...
#> using weibull distribution for estimating peak mean

# Simulate data using estimated parameters
sim <- simPICsimulate(est)
#> simPIC is:
#> updating parameters...
#> setting up SingleCellExperiment object...
#> Simulating library size...
#> Simulating peak mean...
#> using weibull distribution for simulating peak mean
#> Simulating true counts...
#> Done!!
```

# 4 Input data

simPIC recommends using a Paired-Insertion Count (PIC) matrix for optimal utilization of the quantitative information in scATAC-seq data. To convert your own matrix to a PIC format, refer to the `PICsnATAC`
[GitHub vignette](https://github.com/Zhen-Miao/PICsnATAC/blob/main/vignettes/Run_PIC_counting_on_pbmc_3k_data.ipynb) for detailed instructions. In brief, you will need three input files:

* Cell barcodes with metadata (`singlecell.csv`)
* List of peak regions (`peaks.bed`)
* Fragment files (`fragment.tsv.gz`)

```
pic_mat <- PIC_counting(
    cells = cells,
    fragment_tsv_gz_file_location = fragment_tsv_gz_file_location,
    peak_sets = peak_sets
)
```

# 5 simPIC simulation

The core of the simPIC simulation framework is a `gamma-Poisson model`, which generates a uniform peak-by-cell count matrix reflecting chromatin accessibility. Mean accessibility values for each peak are drawn from a `Weibull` distribution by default, though users can optionally choose from `gamma`, `lognormal-gamma`, or `pareto` distributions to better match the characteristics of their data.

Each cell is assigned an expected library size, simulated using a `log-normal` distribution to mimic real datasets. Finally, sparsity is introduced by applying a `Bernoulli` distribution to counts simulated using `Poisson` distribution, capturing the high sparsity nature of single-cell ATAC-seq data.

# 6 simPICcount class

All simulation parameters in simPIC are stored in a dedicated `simPICcount` object — a class specifically designed to hold settings and metadata for simulating single-cell ATAC-seq data. Let’s create one and explore its structure.

```
sim.params <- newsimPICcount()
```

The default values of the `simPICcount` object are pre-loaded based on the included test dataset, providing a starting point for simulation.

```
sim.params
#> An object of class "simPICcount"
#> Slot "nPeaks":
#> [1] 5000
#>
#> Slot "nCells":
#> [1] 700
#>
#> Slot "seed":
#> [1] 49726
#>
#> Slot "default":
#> [1] TRUE
#>
#> Slot "pm.distr":
#> [1] "weibull"
#>
#> Slot "lib.size.meanlog":
#> [1] 6.687082
#>
#> Slot "lib.size.sdlog":
#> [1] 0.344361
#>
#> Slot "peak.mean.shape":
#> [1] 0.7909301
#>
#> Slot "peak.mean.rate":
#> [1] 7.100648
#>
#> Slot "peak.mean.scale":
#> [1] 0.09522228
#>
#> Slot "peak.mean.pi":
#> [1] -17.17441
#>
#> Slot "peak.mean.meanlog":
#> [1] -2.825233
#>
#> Slot "peak.mean.sdlog":
#> [1] -1.366378
#>
#> Slot "sparsity":
#>  [1] 0.05871538 0.28744902 0.05382904 0.49116400 0.73566184 0.80734653
#>  [7] 0.64273280 0.10932077 0.94818918 0.58692185 0.30822488 0.81636836
#> [13] 0.50935747 0.34884727 0.46485584 0.85033288 0.59006230 0.80856521
#> [19] 0.28397706 0.79606233 0.98370869 0.06221149 0.80370704 0.67930803
#> [25] 0.05459596 0.81660907 0.29203258 0.84401251 0.12260215 0.18438490
#>  [ reached 'max' / getOption("max.print") -- omitted 199970 entries ]
#>
#> Slot "nGroups":
#> [1] 1
#>
#> Slot "group.prob":
#> [1] 1
#>
#> Slot "da.prob":
#> [1] 0.13
#>
#> Slot "da.downProb":
#> [1] 0.5
#>
#> Slot "da.facLoc":
#> [1] 0.1
#>
#> Slot "da.facScale":
#> [1] 0.4
#>
#> Slot "bcv.common":
#> [1] 0.1
#>
#> Slot "bcv.df":
#> [1] 60
#>
#> Slot "nBatches":
#> [1] 1
#>
#> Slot "batchCells":
#> [1] 100
#>
#> Slot "batch.facLoc":
#> [1] 0.1
#>
#> Slot "batch.facScale":
#> [1] 0.1
#>
#> Slot "batch.rmEffect":
#> [1] FALSE
```

## 6.1 Getting and setting parameters

To access a specific parameter, such as the number of peaks, the user can use the `simPICget` function:

```
simPICget(sim.params, "nPeaks")
#> [1] 5000
```

Alternatively, to assign a new value to a parameter, we can use the `setsimPICparameters` function:

```
sim.params <- setsimPICparameters(sim.params, nPeaks = 2000)
simPICget(sim.params, "nPeaks")
#> [1] 2000
```

The above functions also allows getting or setting multiple parameters simultaneously:

```
# Set multiple parameters at once (using a list)
sim.params <- setsimPICparameters(sim.params,
    update = list(nPeaks = 8000, nCells = 500)
)
# Extract multiple parameters as a list
params <- simPICgetparameters(
    sim.params,
    c("nPeaks", "nCells", "peak.mean.shape")
)
# Set multiple parameters at once (using additional arguments)
params <- setsimPICparameters(sim.params,
    lib.size.sdlog = 3.5, lib.size.meanlog = 9.07
)
params
#> An object of class "simPICcount"
#> Slot "nPeaks":
#> [1] 8000
#>
#> Slot "nCells":
#> [1] 500
#>
#> Slot "seed":
#> [1] 49726
#>
#> Slot "default":
#> [1] TRUE
#>
#> Slot "pm.distr":
#> [1] "weibull"
#>
#> Slot "lib.size.meanlog":
#> [1] 9.07
#>
#> Slot "lib.size.sdlog":
#> [1] 3.5
#>
#> Slot "peak.mean.shape":
#> [1] 0.7909301
#>
#> Slot "peak.mean.rate":
#> [1] 7.100648
#>
#> Slot "peak.mean.scale":
#> [1] 0.09522228
#>
#> Slot "peak.mean.pi":
#> [1] -17.17441
#>
#> Slot "peak.mean.meanlog":
#> [1] -2.825233
#>
#> Slot "peak.mean.sdlog":
#> [1] -1.366378
#>
#> Slot "sparsity":
#>  [1] 0.05871538 0.28744902 0.05382904 0.49116400 0.73566184 0.80734653
#>  [7] 0.64273280 0.10932077 0.94818918 0.58692185 0.30822488 0.81636836
#> [13] 0.50935747 0.34884727 0.46485584 0.85033288 0.59006230 0.80856521
#> [19] 0.28397706 0.79606233 0.98370869 0.06221149 0.80370704 0.67930803
#> [25] 0.05459596 0.81660907 0.29203258 0.84401251 0.12260215 0.18438490
#>  [ reached 'max' / getOption("max.print") -- omitted 199970 entries ]
#>
#> Slot "nGroups":
#> [1] 1
#>
#> Slot "group.prob":
#> [1] 1
#>
#> Slot "da.prob":
#> [1] 0.13
#>
#> Slot "da.downProb":
#> [1] 0.5
#>
#> Slot "da.facLoc":
#> [1] 0.1
#>
#> Slot "da.facScale":
#> [1] 0.4
#>
#> Slot "bcv.common":
#> [1] 0.1
#>
#> Slot "bcv.df":
#> [1] 60
#>
#> Slot "nBatches":
#> [1] 1
#>
#> Slot "batchCells":
#> [1] 100
#>
#> Slot "batch.facLoc":
#> [1] 0.1
#>
#> Slot "batch.facScale":
#> [1] 0.1
#>
#> Slot "batch.rmEffect":
#> [1] FALSE
```

# 7 Estimating Parameters

simPIC enables the estimation of its parameters from a SingleCellExperiment object or a count matrix using the `simPICestimate` function.

In this section, we estimate parameters from a counts matrix using the default settings. The estimation process involves the following steps:

* Estimating mean parameters by fitting a Weibull distribution (default) to the peak means.
* Estimating library size parameters by fitting a log-normal distribution to the library sizes.
* Estimating the sparsity parameter by fitting a Bernoulli distribution.

```
# Get the counts from test data
#counts <- readRDS(system.file("extdata", "test.rds", package = "simPIC"))

# Check that counts is a dgCMatrix
class(counts)
#> [1] "dgCMatrix"
#> attr(,"package")
#> [1] "Matrix"
typeof(counts)
#> [1] "S4"

# Check the dimensions, each row is a peak, each column is a cell
dim(counts)
#> [1] 90000   500

# Show the first few entries
counts[1:5, 1:5]
#> 5 x 5 sparse Matrix of class "dgCMatrix"
#>                         GTCACAAGTGGCATAG-1 CCATACCGTGAGGGTT-1
#> chr11-3622698-3623526                    .                  .
#> chr1-40703222-40703996                   .                  .
#> chr2-21316881-21317790                   .                  .
#> chr18-3411756-3412657                    .                  .
#> chr10-12446853-12447562                  .                  .
#>                         AACAAAGGTCGTAGTT-1 ATTGTGGTCGATGTGT-1
#> chr11-3622698-3623526                    .                  .
#> chr1-40703222-40703996                   .                  .
#> chr2-21316881-21317790                   .                  .
#> chr18-3411756-3412657                    .                  .
#> chr10-12446853-12447562                  .                  1
#>                         TCTATTGGTCTGGGAA-1
#> chr11-3622698-3623526                    .
#> chr1-40703222-40703996                   .
#> chr2-21316881-21317790                   .
#> chr18-3411756-3412657                    .
#> chr10-12446853-12447562                  .

new <- newsimPICcount()
new <- simPICestimate(counts)
#> simPIC is:
#> estimating library size parameters...
#> estimating sparsity...
#> estimating peak mean parameters...
#> using weibull distribution for estimating peak mean

## estimating using gamma distribution
## new <- simPICestimate(counts, pm.distr = "gamma")
```

For more details on the estimation procedures, refer to `?simPICestimate`.

# 8 Simulating counts

Once we have a set of parameters, we can use the `simPICsimulate` function to simulate counts. To modify the parameters, simply provide them as additional arguments. If no parameters are supplied, the default values will be used:

```
sim <- simPICsimulate(new, nCells = 500)
#> simPIC is:
#> updating parameters...
#> setting up SingleCellExperiment object...
#> Simulating library size...
#> Simulating peak mean...
#> using weibull distribution for simulating peak mean
#> Simulating true counts...
#> Done!!
sim
#> class: SingleCellExperiment
#> dim: 90000 500
#> metadata(1): Params
#> assays(3): BatchCellMeans BaseCellMeans counts
#> rownames(90000): Peak1 Peak2 ... Peak89999 Peak90000
#> rowData names(2): Peak exp.peakmean
#> colnames(500): Cell1 Cell2 ... Cell499 Cell500
#> colData names(3): Cell Batch exp.libsize
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):

## simulating using gamma distribution
## sim <- simPICsimulate(new, nCells =500, pm.distr = "gamma")
```

The output of `simPICsimulate` is a `SingleCellExperiment` object, where `sim` contains 90000 features (peaks) and 500 samples (cells). The main component of this object is a matrix of simulated counts, organized by features (peaks) and samples (cells), which can be accessed using the `counts` function. In addition, the `SingleCellExperiment` object stores metadata for each cell (accessible via `colData`) and each peak (accessible via `rowData`). simPIC uses these slots, along with `assays`, to store intermediate values during the simulation process.

```
# Access the counts
counts(sim)[1:5, 1:5]
#>       Cell1 Cell2 Cell3 Cell4 Cell5
#> Peak1     0     0     0     0     0
#> Peak2     0     0     0     0     0
#> Peak3     0     0     1     0     0
#> Peak4     0     0     0     0     0
#> Peak5     1     0     1     0     0
# Information about peaks
head(rowData(sim))
#> DataFrame with 6 rows and 2 columns
#>              Peak exp.peakmean
#>       <character>    <numeric>
#> Peak1       Peak1  2.83235e-07
#> Peak2       Peak2  1.24076e-05
#> Peak3       Peak3  1.49274e-05
#> Peak4       Peak4  1.00859e-05
#> Peak5       Peak5  4.89855e-06
#> Peak6       Peak6  3.75282e-06
# Information about cells
head(colData(sim))
#> DataFrame with 6 rows and 3 columns
#>              Cell       Batch exp.libsize
#>       <character> <character>   <numeric>
#> Cell1       Cell1      Batch1       10363
#> Cell2       Cell2      Batch1       11127
#> Cell3       Cell3      Batch1       11655
#> Cell4       Cell4      Batch1        7589
#> Cell5       Cell5      Batch1        8370
#> Cell6       Cell6      Batch1       18304
# Peak by cell matrices
names(assays(sim))
#> [1] "BatchCellMeans" "BaseCellMeans"  "counts"
```

The `simPICsimulate` function provides additional simulation details:

**Cell Information (`colData`)**
- `Cell`: Unique cell identifier.
- `exp.libsize`: Expected library size for that cell (not derived from the final simulated counts).

**Peak Information (`rowData`)**
- `Peak`: Unique peak identifier.
- `exp.peakmean`: Expected peak means for that peak (not derived from the final simulated counts).

**Peak-by-Cell Information (`assays`)**
- `counts`: Final simulated counts.

For more information on the simulation process, see `?simPICsimulate`.

## 8.1 Comparing Simulations and Real Data

simPIC provides a function `simPICcompare` that helps simplify the comparison between simulations and real data. This function takes a list of `SingleCellExperiment` objects, combines the datasets, and produces comparison plots. Let’s create two small simulations and see how they compare.

```
sim1 <- simPICsimulate(nPeaks = 2000, nCells = 500)
#> simPIC is:
#> updating parameters...
#> setting up SingleCellExperiment object...
#> Simulating library size...
#> Simulating peak mean...
#> using weibull distribution for simulating peak mean
#> Simulating true counts...
#> Done!!
sim2 <- simPICsimulate(nPeaks = 2000, nCells = 500)
#> simPIC is:
#> updating parameters...
#> setting up SingleCellExperiment object...
#> Simulating library size...
#> Simulating peak mean...
#> using weibull distribution for simulating peak mean
#> Simulating true counts...
#> Done!!
comparison <- simPICcompare(list(real = sim1, simPIC = sim2))

names(comparison)
#> [1] "RowData" "ColData" "Plots"
names(comparison$Plots)
#> [1] "Means"        "Variances"    "MeanVar"      "LibrarySizes" "ZerosPeak"
#> [6] "ZerosCell"    "MeanZeros"    "PeakMeanNzp"
```

The returned list from `simPICcompare` contains three items:

* The first two items are the combined datasets:
* By peak (`RowData`)
* By cell (`ColData`)
* The third item contains comparison plots (produced using `ggplot2`), such as a plot of the distribution of means.

```
comparison$Plots$Means
```

![](data:image/png;base64...)

# 9 Simulating Multiple Cell Types - equal proportions

simPIC allows you to simulate data for multiple cell types, each with its own distinct accessibility profile. This is useful when you want to model more complex scenarios where different cell types contribute to the overall chromatin accessibility landscape.

To simulate multiple cell-types, set the `method` parameter to `groups`. This tells simPIC to simulate counts for multiple cell-types. You also need to specify the number of groups (cell-types) and their respective proportions using the `nGroups` and `group.prob` parameters.

For example, to simulate two cell types with equal proportions, you can use:

```
#counts <- readRDS(system.file("extdata", "test.rds", package = "simPIC"))

sim <- simPICsimulate(new, method = "groups",
                nGroups = 2, group.prob = c(0.5, 0.5))
#> simPIC is:
#> updating parameters...
#> setting up SingleCellExperiment object...
#> Simulating library size...
#> Simulating peak mean...
#> using weibull distribution for simulating peak mean
#> Simulating group DA
#> Simulating group (cell) means
#> Simulating BCV
#> Simulating true counts groups...
#> Done!!
```

```
library(SingleCellExperiment)
library(scater)
#> Loading required package: scuttle
#> Loading required package: ggplot2

sim <- logNormCounts(sim)
sim <- scater::runPCA(sim)
plotPCASCE(sim,color_by="Group")
```

![](data:image/png;base64...)

# 10 Simulating Multiple Cell Types - variable proportions

In above example, two cell-types were simulated in equal proportions (50% each). You can adjust the proportions to reflect your experimental design, such as having one dominant cell type. The `group.probs` parameter should sum to 1. You can simulate any number of cell types by increasing `nGroups`.

```
sim_multi <- simPICsimulate(new, method ="groups",
                            nGroups = 2,
                            group.prob = c(0.7, 0.3))
#> simPIC is:
#> updating parameters...
#> setting up SingleCellExperiment object...
#> Simulating library size...
#> Simulating peak mean...
#> using weibull distribution for simulating peak mean
#> Simulating group DA
#> Simulating group (cell) means
#> Simulating BCV
#> Simulating true counts groups...
#> Done!!

sim_multi <- logNormCounts(sim_multi)
sim_multi <- runPCA(sim_multi)
plotPCASCE(sim_multi, color_by="Group")
```

![](data:image/png;base64...)

# 11 Simulating Batch effects

simPIC also supports adding batch effects, allowing you to simulate variations in peak accessibility across batches or conditions for different cell types. To simulate batch effects, you can use the `nBatches` parameter to specify the number of batches, and the `batchCells` parameter to define the number of cells in each batch.

```
set.seed(567)
sim_batch <- simPICsimulate(new, method="groups",
                            nGroups=2, nBatches=2,
                            group.prob=c(0.5, 0.5),
                            batchCells=c(250,250))
#> simPIC is:
#> updating parameters...
#> setting up SingleCellExperiment object...
#> Simulating library size...
#> Simulating peak mean...
#> using weibull distribution for simulating peak mean
#> Simulating batch effects...
#> Simulating group DA
#> Simulating group (cell) means
#> Simulating BCV
#> Simulating true counts groups...
#> Done!!

sim_batch <- logNormCounts(sim_batch)
sim_batch <- runPCA(sim_batch)
plotPCASCE(sim_batch, color_by="Batch", shape_by="Group")
```

![](data:image/png;base64...)

# 12 Citing simPIC

If you use simPIC in your work please cite our paper:

```
citation("simPIC")
#> To cite package 'simPIC' in publications use:
#>
#>   Chugh S, Shim H, McCarthy D (2025). _simPIC: Flexible simulation of
#>   paired-insertion counts for single-cell ATAC-sequencing data_.
#>   doi:10.18129/B9.bioc.simPIC
#>   <https://doi.org/10.18129/B9.bioc.simPIC>, R package version 1.6.0,
#>   <https://bioconductor.org/packages/simPIC>.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Manual{,
#>     title = {simPIC: Flexible simulation of paired-insertion counts for single-cell
#> ATAC-sequencing data},
#>     author = {Sagrika Chugh and Heejung Shim and Davis McCarthy},
#>     year = {2025},
#>     note = {R package version 1.6.0},
#>     url = {https://bioconductor.org/packages/simPIC},
#>     doi = {10.18129/B9.bioc.simPIC},
#>   }
```

# Session information

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
#>  [1] scater_1.38.0               ggplot2_4.0.0
#>  [3] scuttle_1.20.0              simPIC_1.6.0
#>  [5] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [7] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [9] Seqinfo_1.0.0               IRanges_2.44.0
#> [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [13] generics_0.1.4              MatrixGenerics_1.22.0
#> [15] matrixStats_1.5.0           BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1    viridisLite_0.4.2   dplyr_1.1.4
#>  [4] vipor_0.4.7         farver_2.1.2        viridis_0.6.5
#>  [7] S7_0.2.0            fastmap_1.2.0       digest_0.6.37
#> [10] rsvd_1.0.5          lifecycle_1.0.4     survival_3.8-3
#> [13] magrittr_2.0.4      compiler_4.5.1      rlang_1.1.6
#> [16] sass_0.4.10         tools_4.5.1         yaml_2.3.10
#> [19] knitr_1.50          S4Arrays_1.10.0     labeling_0.4.3
#> [22] fitdistrplus_1.2-4  DelayedArray_0.36.0 RColorBrewer_1.1-3
#> [25] abind_1.4-8         BiocParallel_1.44.0 withr_3.0.2
#> [28] grid_4.5.1          beachmat_2.26.0     scales_1.4.0
#>  [ reached 'max' / getOption("max.print") -- omitted 43 entries ]
```