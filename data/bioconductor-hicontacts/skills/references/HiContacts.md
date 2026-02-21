# Introduction to HiContacts

Jacques Serizay

#### 2025-10-30

# Contents

* [1 Citing HiContacts](#citing-hicontacts)
* [2 Basics: importing `.(m)/cool` files as `HiCExperiment` objects](#basics-importing-.mcool-files-as-hicexperiment-objects)
* [3 Plotting matrices](#plotting-matrices)
  + [3.1 Plot matrix heatmaps](#plot-matrix-heatmaps)
  + [3.2 Plot loops](#plot-loops)
  + [3.3 Plot borders](#plot-borders)
  + [3.4 Plot aggregated matrices over features](#plot-aggregated-matrices-over-features)
* [4 Arithmetics](#arithmetics)
  + [4.1 Computing autocorrelated contact map](#computing-autocorrelated-contact-map)
  + [4.2 Detrending contact map (map of scores over expected)](#detrending-contact-map-map-of-scores-over-expected)
  + [4.3 Summing two maps](#summing-two-maps)
  + [4.4 Computing ratio between two maps](#computing-ratio-between-two-maps)
  + [4.5 Despeckling (smoothing out) a contact map](#despeckling-smoothing-out-a-contact-map)
* [5 Mapping topological features](#mapping-topological-features)
  + [5.1 Chromosome compartments](#chromosome-compartments)
  + [5.2 Diamond insulation score and chromatin domains borders](#diamond-insulation-score-and-chromatin-domains-borders)
* [6 Contact map analysis](#contact-map-analysis)
  + [6.1 Virtual 4C](#virtual-4c)
  + [6.2 Cis-trans ratios](#cis-trans-ratios)
  + [6.3 P(s)](#ps)
* [7 Session info](#session-info)

# 1 Citing HiContacts

```
citation('HiContacts')
#> To cite package 'HiContacts' in publications use:
#>
#>   Serizay J, Matthey-Doret C, Bignaud A, Baudry L, Koszul R (2024).
#>   "Orchestrating chromosome conformation capture analysis with
#>   Bioconductor." _Nature Communications_, *15*, 1-9.
#>   doi:10.1038/s41467-024-44761-x
#>   <https://doi.org/10.1038/s41467-024-44761-x>.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Article{,
#>     author = {Jacques Serizay and Cyril Matthey-Doret and Amaury Bignaud and Lyam Baudry and Romain Koszul},
#>     title = {Orchestrating chromosome conformation capture analysis with Bioconductor},
#>     journal = {Nature Communications},
#>     year = {2024},
#>     volume = {15},
#>     pages = {1--9},
#>     doi = {10.1038/s41467-024-44761-x},
#>   }
```

# 2 Basics: importing `.(m)/cool` files as `HiCExperiment` objects

The `HiCExperiment` package provides classes and methods to import an .(m)cool
file in R. The `HiContactsData` package gives access to a range of toy
datasets stored by Bioconductor in the `ExperimentHub`.

```
library(dplyr)
library(ggplot2)
library(HiCExperiment)
library(HiContacts)
library(HiContactsData)
library(rtracklayer)
#>
#> Attaching package: 'rtracklayer'
#> The following object is masked from 'package:AnnotationHub':
#>
#>     hubUrl
library(InteractionSet)
#> Loading required package: SummarizedExperiment
#> Loading required package: MatrixGenerics
#> Loading required package: matrixStats
#>
#> Attaching package: 'matrixStats'
#> The following object is masked from 'package:dplyr':
#>
#>     count
#>
#> Attaching package: 'MatrixGenerics'
#> The following objects are masked from 'package:matrixStats':
#>
#>     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
#>     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
#>     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
#>     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
#>     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
#>     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
#>     colWeightedMeans, colWeightedMedians, colWeightedSds,
#>     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
#>     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
#>     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
#>     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
#>     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
#>     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
#>     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
#>     rowWeightedSds, rowWeightedVars
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#>
#> Attaching package: 'Biobase'
#> The following object is masked from 'package:MatrixGenerics':
#>
#>     rowMedians
#> The following objects are masked from 'package:matrixStats':
#>
#>     anyMissing, rowMedians
#> The following object is masked from 'package:ExperimentHub':
#>
#>     cache
#> The following object is masked from 'package:AnnotationHub':
#>
#>     cache
cool_file <- HiContactsData('yeast_wt', format = 'cool')
#> see ?HiContactsData and browseVignettes('HiContactsData') for documentation
#> loading from cache
hic <- import(cool_file, format = 'cool')
hic
#> `HiCExperiment` object with 8,757,906 contacts over 12,079 regions
#> -------
#> fileName: "/home/biocbuild/.cache/R/ExperimentHub/a0be55a53b247_7751"
#> focus: "whole genome"
#> resolutions(1): 1000
#> active resolution: 1000
#> interactions: 2945692
#> scores(2): count balanced
#> topologicalFeatures: compartments(0) borders(0) loops(0) viewpoints(0)
#> pairsFile: N/A
#> metadata(0):
```

# 3 Plotting matrices

## 3.1 Plot matrix heatmaps

The `plotMatrix` function takes a `HiCExperiment` object and plots it as a heatmap.
Use the `use.scores` argument to specify which type of interaction scores to use
in the contact maps (e.g. `count`, `balanced`, …). By default, `plotMatrix()`
looks for balanced scores. If they are not stored in the original `.(m)/cool` file,
`plotMatrix()` simply takes the first scores available.

```
## Square matrix
plotMatrix(hic, use.scores = 'balanced', limits = c(-4, -1))
```

![](data:image/png;base64...)

```
## Horizontal matrix
plotMatrix(
    refocus(hic, 'II'),
    use.scores = 'balanced', limits = c(-4, -1),
    maxDistance = 200000
)
```

![](data:image/png;base64...)

## 3.2 Plot loops

Loops can be plotted on top of Hi-C matrices by providing a `GInteractions`
object to the `loops` argument.

*Note:*
Loops in `.bedpe` format can be imported in R using the `import()` function,
and converted into `GInteractions` with the
`InteractionSet::makeGInteractionsFromGRangesPairs()` function.

```
mcool_file <- HiContactsData('yeast_wt', format = 'mcool')
#> see ?HiContactsData and browseVignettes('HiContactsData') for documentation
#> loading from cache
loops <- system.file("extdata", 'S288C-loops.bedpe', package = 'HiCExperiment') |>
    import() |>
    makeGInteractionsFromGRangesPairs()
p <- import(mcool_file, format = 'mcool', focus = 'IV') |>
    plotMatrix(loops = loops, limits = c(-4, -1), dpi = 120)
```

## 3.3 Plot borders

```
borders <- system.file("extdata", 'S288C-borders.bed', package = 'HiCExperiment') |>
    import()
p <- import(mcool_file, format = 'mcool', focus = 'IV') |>
    plotMatrix(loops = loops, borders = borders, limits = c(-4, -1), dpi = 120)
```

## 3.4 Plot aggregated matrices over features

```
aggr_centros <- HiContacts::aggregate(
    hic, targets = loops, BPPARAM = BiocParallel::SerialParam()
)
#> Going through preflight checklist...
#> Parsing the entire contact matrice as a sparse matrix...
#> Modeling distance decay...
#> Filtering for contacts within provided targets...
plotMatrix(
    aggr_centros, use.scores = 'detrended', limits = c(-1, 1), scale = 'linear',
    cmap = bgrColors()
)
```

![](data:image/png;base64...)

# 4 Arithmetics

## 4.1 Computing autocorrelated contact map

```
mcool_file <- HiContactsData('mESCs', format = 'mcool')
#> see ?HiContactsData and browseVignettes('HiContactsData') for documentation
#> loading from cache
hic <- import(mcool_file, format = 'mcool', focus = 'chr2', resolution = 160000)
hic <- autocorrelate(hic)
#>
scores(hic)
#> List of length 5
#> names(5): count balanced expected detrended autocorrelated
summary(scores(hic, 'autocorrelated'))
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's
#> -0.4988 -0.0967  0.0400  0.0431  0.1723  1.0000    7739
plotMatrix(hic, use.scores = 'autocorrelated', limits = c(-1, 1), scale = 'linear')
```

![](data:image/png;base64...)

## 4.2 Detrending contact map (map of scores over expected)

```
hic <- import(mcool_file, format = 'mcool', focus = 'chr18:20000000-35000000', resolution = 40000)
detrended_hic <- detrend(hic)
patchwork::wrap_plots(
    plotMatrix(detrended_hic, use.scores = 'expected', scale = 'log10', limits = c(-3, -1), dpi = 120),
    plotMatrix(detrended_hic, use.scores = 'detrended', scale = 'linear', limits = c(-1, 1), dpi = 120)
)
```

![](data:image/png;base64...)

## 4.3 Summing two maps

```
mcool_file_1 <- HiContactsData('yeast_eco1', format = 'mcool')
#> see ?HiContactsData and browseVignettes('HiContactsData') for documentation
#> loading from cache
mcool_file_2 <- HiContactsData('yeast_wt', format = 'mcool')
#> see ?HiContactsData and browseVignettes('HiContactsData') for documentation
#> loading from cache
hic_1 <- import(mcool_file_1, format = 'mcool', focus = 'II:1-300000', resolution = 2000)
hic_2 <- import(mcool_file_2, format = 'mcool', focus = 'II:1-300000', resolution = 2000)
merged_hic <- merge(hic_1, hic_2)
hic_1
#> `HiCExperiment` object with 301,285 contacts over 150 regions
#> -------
#> fileName: "/home/biocbuild/.cache/R/ExperimentHub/a105d64a0d1c2_7754"
#> focus: "II:1-300,000"
#> resolutions(5): 1000 2000 4000 8000 16000
#> active resolution: 2000
#> interactions: 9607
#> scores(2): count balanced
#> topologicalFeatures: compartments(0) borders(0) loops(0) viewpoints(0)
#> pairsFile: N/A
#> metadata(0):
hic_2
#> `HiCExperiment` object with 146,812 contacts over 150 regions
#> -------
#> fileName: "/home/biocbuild/.cache/R/ExperimentHub/a0be5499b19a5_7752"
#> focus: "II:1-300,000"
#> resolutions(5): 1000 2000 4000 8000 16000
#> active resolution: 2000
#> interactions: 6933
#> scores(2): count balanced
#> topologicalFeatures: compartments(0) borders(0) loops(0) viewpoints(0)
#> pairsFile: N/A
#> metadata(0):
merged_hic
#> `HiCExperiment` object with 229,926 contacts over 150 regions
#> -------
#> fileName: "/home/biocbuild/.cache/R/ExperimentHub/a105d64a0d1c2_7754"
#> focus: "II:1-300,000"
#> resolutions(5): 1000 2000 4000 8000 16000
#> active resolution: 2000
#> interactions: 9748
#> scores(2): count balanced
#> topologicalFeatures: ()
#> pairsFile: N/A
#> metadata(2): hce_list operation
```

## 4.4 Computing ratio between two maps

```
hic_1 <- import(mcool_file_1, format = 'mcool', focus = 'II', resolution = 2000)
hic_2 <- import(mcool_file_2, format = 'mcool', focus = 'II', resolution = 2000)
div_hic <- divide(hic_1, by = hic_2)
div_hic
#> `HiCExperiment` object with 996,154 contacts over 407 regions
#> -------
#> fileName: N/A
#> focus: "II"
#> resolutions(1): 2000
#> active resolution: 2000
#> interactions: 60894
#> scores(6): count.x balanced.x count.by balanced.by balanced.fc balanced.l2fc
#> topologicalFeatures: ()
#> pairsFile: N/A
#> metadata(2): hce_list operation
p <- patchwork::wrap_plots(
    plotMatrix(hic_1, use.scores = 'balanced', scale = 'log10', limits = c(-4, -1)),
    plotMatrix(hic_2, use.scores = 'balanced', scale = 'log10', limits = c(-4, -1)),
    plotMatrix(div_hic, use.scores = 'balanced.fc', scale = 'log2', limits = c(-2, 2), cmap = bwrColors())
)
```

## 4.5 Despeckling (smoothing out) a contact map

```
hic_1_despeckled <- despeckle(hic_1)
hic_1_despeckled5 <- despeckle(hic_1, focal.size = 5)
p <- patchwork::wrap_plots(
    plotMatrix(hic_1, use.scores = 'balanced', scale = 'log10', limits = c(-4, -1)),
    plotMatrix(hic_1_despeckled, use.scores = 'balanced.despeckled', scale = 'log10', limits = c(-4, -1)),
    plotMatrix(hic_1_despeckled5, use.scores = 'balanced.despeckled', scale = 'log10', limits = c(-4, -1))
)
```

# 5 Mapping topological features

## 5.1 Chromosome compartments

```
mcool_file <- HiContactsData('yeast_wt', format = 'mcool')
#> see ?HiContactsData and browseVignettes('HiContactsData') for documentation
#> loading from cache
hic <- import(mcool_file, format = 'mcool', resolution = 16000)

# - Get compartments
hic <- getCompartments(hic, chromosomes = c('XV', 'XVI'))
#> Going through preflight checklist...
#> Parsing intra-chromosomal contacts for each chromosome...
#> Computing eigenvectors for each chromosome...
hic
#> `HiCExperiment` object with 8,757,906 contacts over 763 regions
#> -------
#> fileName: "/home/biocbuild/.cache/R/ExperimentHub/a0be5499b19a5_7752"
#> focus: "whole genome"
#> resolutions(5): 1000 2000 4000 8000 16000
#> active resolution: 16000
#> interactions: 267709
#> scores(2): count balanced
#> topologicalFeatures: compartments(18) borders(0) loops(0) viewpoints(0)
#> pairsFile: N/A
#> metadata(1): eigens

# - Export compartments as bigwig and bed files
export(IRanges::coverage(metadata(hic)$eigens, weight = 'eigen'), 'compartments.bw')
export(
    topologicalFeatures(hic, 'compartments')[topologicalFeatures(hic, 'compartments')$compartment == 'A'],
    'A-compartments.bed'
)
export(
    topologicalFeatures(hic, 'compartments')[topologicalFeatures(hic, 'compartments')$compartment == 'B'],
    'B-compartments.bed'
)

# - Generate saddle plot
plotSaddle(hic)
```

![](data:image/png;base64...)

## 5.2 Diamond insulation score and chromatin domains borders

```
# - Compute insulation score
hic <- refocus(hic, 'II:1-300000') |>
    zoom(resolution = 1000) |>
    getDiamondInsulation(window_size = 8000) |>
    getBorders()
#> Going through preflight checklist...
#> Scan each window and compute diamond insulation score...
#> Annotating diamond score prominence for each window...
hic
#> `HiCExperiment` object with 146,812 contacts over 300 regions
#> -------
#> fileName: "/home/biocbuild/.cache/R/ExperimentHub/a0be5499b19a5_7752"
#> focus: "II:1-300,000"
#> resolutions(5): 1000 2000 4000 8000 16000
#> active resolution: 1000
#> interactions: 18286
#> scores(2): count balanced
#> topologicalFeatures: compartments(18) borders(17) loops(0) viewpoints(0)
#> pairsFile: N/A
#> metadata(2): eigens insulation

# - Export insulation as bigwig track and borders as bed file
export(IRanges::coverage(metadata(hic)$insulation, weight = 'insulation'), 'insulation.bw')
export(topologicalFeatures(hic, 'borders'), 'borders.bed')
```

# 6 Contact map analysis

## 6.1 Virtual 4C

```
mcool_file <- HiContactsData('mESCs', format = 'mcool')
#> see ?HiContactsData and browseVignettes('HiContactsData') for documentation
#> loading from cache
hic <- import(mcool_file, format = 'mcool', focus = 'chr18:20000000-35000000', resolution = 40000)
v4C <- virtual4C(hic, viewpoint = GRanges('chr18:31000000-31050000'))
plot4C(v4C, ggplot2::aes(x = center, y = score))
```

![](data:image/png;base64...)

## 6.2 Cis-trans ratios

```
mcool_file <- HiContactsData('yeast_wt', format = 'mcool')
#> see ?HiContactsData and browseVignettes('HiContactsData') for documentation
#> loading from cache
hic <- import(mcool_file, format = 'mcool', resolution = 1000)
cisTransRatio(hic)
#> # A tibble: 16 × 6
#> # Groups:   chr [16]
#>    chr       cis  trans n_total cis_pct trans_pct
#>    <fct>   <dbl>  <dbl>   <dbl>   <dbl>     <dbl>
#>  1 I      186326  96738  283064   0.658     0.342
#>  2 II     942728 273966 1216694   0.775     0.225
#>  3 III    303980 127087  431067   0.705     0.295
#>  4 IV    1858062 418218 2276280   0.816     0.184
#>  5 V      607090 220873  827963   0.733     0.267
#>  6 VI     280282 127771  408053   0.687     0.313
#>  7 VII   1228532 335909 1564441   0.785     0.215
#>  8 VIII   574086 205122  779208   0.737     0.263
#>  9 IX     474182 179280  653462   0.726     0.274
#> 10 X      834656 259240 1093896   0.763     0.237
#> 11 XI     775240 245899 1021139   0.759     0.241
#> 12 XII   1182742 278065 1460807   0.810     0.190
#> 13 XIII  1084810 296351 1381161   0.785     0.215
#> 14 XIV    852516 256639 1109155   0.769     0.231
#> 15 XV    1274070 351132 1625202   0.784     0.216
#> 16 XVI   1070700 313520 1384220   0.774     0.226
```

## 6.3 P(s)

```
# Without a pairs file
mcool_file <- HiContactsData('yeast_wt', format = 'mcool')
#> see ?HiContactsData and browseVignettes('HiContactsData') for documentation
#> loading from cache
hic <- import(mcool_file, format = 'mcool', resolution = 1000)
ps <- distanceLaw(hic)
#> pairsFile not specified. The P(s) curve will be an approximation.
plotPs(ps, ggplot2::aes(x = binned_distance, y = norm_p))
#> Warning: Removed 18 rows containing missing values or values outside the scale range
#> (`geom_line()`).
```

![](data:image/png;base64...)

```
# With a pairs file
pairsFile(hic) <- HiContactsData('yeast_wt', format = 'pairs.gz')
#> see ?HiContactsData and browseVignettes('HiContactsData') for documentation
#> loading from cache
ps <- distanceLaw(hic)
#> Importing pairs file /home/biocbuild/.cache/R/ExperimentHub/a0be51f203058_7753 in memory. This may take a while...
plotPs(ps, ggplot2::aes(x = binned_distance, y = norm_p))
#> Warning: Removed 67 rows containing missing values or values outside the scale range
#> (`geom_line()`).
```

![](data:image/png;base64...)

```
plotPsSlope(ps, ggplot2::aes(x = binned_distance, y = slope))
#> Warning: Removed 67 rows containing missing values or values outside the scale range
#> (`geom_line()`).
```

![](data:image/png;base64...)

```
# Comparing P(s) curves
c1 <- import(
    HiContactsData('yeast_wt', format = 'mcool'),
    format = 'mcool',
    resolution = 1000,
    pairsFile = HiContactsData('yeast_wt', format = 'pairs.gz')
)
#> see ?HiContactsData and browseVignettes('HiContactsData') for documentation
#> loading from cache
#> see ?HiContactsData and browseVignettes('HiContactsData') for documentation
#> loading from cache
c2 <- import(
    HiContactsData('yeast_eco1', format = 'mcool'),
    format = 'mcool',
    resolution = 1000,
    pairsFile = HiContactsData('yeast_eco1', format = 'pairs.gz')
)
#> see ?HiContactsData and browseVignettes('HiContactsData') for documentation
#> loading from cache
#> see ?HiContactsData and browseVignettes('HiContactsData') for documentation
#> loading from cache
ps_1 <- distanceLaw(c1) |> mutate(sample = 'WT')
#> Importing pairs file /home/biocbuild/.cache/R/ExperimentHub/a0be51f203058_7753 in memory. This may take a while...
ps_2 <- distanceLaw(c2) |> mutate(sample = 'Eco1-AID')
#> Importing pairs file /home/biocbuild/.cache/R/ExperimentHub/a105d7fca4d05_7755 in memory. This may take a while...
ps <- rbind(ps_1, ps_2)
plotPs(ps, ggplot2::aes(x = binned_distance, y = norm_p, group = sample, color = sample))
#> Warning: Removed 134 rows containing missing values or values outside the scale range
#> (`geom_line()`).
```

![](data:image/png;base64...)

```
plotPsSlope(ps, ggplot2::aes(x = binned_distance, y = slope, group = sample, color = sample))
#> Warning: Removed 135 rows containing missing values or values outside the scale range
#> (`geom_line()`).
```

![](data:image/png;base64...)

# 7 Session info

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
#>  [1] InteractionSet_1.38.0       SummarizedExperiment_1.40.0
#>  [3] Biobase_2.70.0              MatrixGenerics_1.22.0
#>  [5] matrixStats_1.5.0           rtracklayer_1.70.0
#>  [7] HiContacts_1.12.0           HiContactsData_1.11.0
#>  [9] ExperimentHub_3.0.0         AnnotationHub_4.0.0
#> [11] BiocFileCache_3.0.0         dbplyr_2.5.1
#> [13] HiCExperiment_1.10.0        GenomicRanges_1.62.0
#> [15] Seqinfo_1.0.0               IRanges_2.44.0
#> [17] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [19] generics_0.1.4              dplyr_1.1.4
#> [21] ggplot2_4.0.0               BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3       strawr_0.0.92            rstudioapi_0.17.1
#>   [4] jsonlite_2.0.0           magrittr_2.0.4           ggbeeswarm_0.7.2
#>   [7] farver_2.1.2             rmarkdown_2.30           BiocIO_1.20.0
#>  [10] vctrs_0.6.5              memoise_2.0.1            Cairo_1.7-0
#>  [13] Rsamtools_2.26.0         RCurl_1.98-1.17          terra_1.8-70
#>  [16] base64enc_0.1-3          htmltools_0.5.8.1        S4Arrays_1.10.0
#>  [19] dynamicTreeCut_1.63-1    curl_7.0.0               Rhdf5lib_1.32.0
#>  [22] SparseArray_1.10.0       Formula_1.2-5            rhdf5_2.54.0
#>  [25] sass_0.4.10              bslib_0.9.0              htmlwidgets_1.6.4
#>  [28] httr2_1.2.1              impute_1.84.0            cachem_1.1.0
#>  [31] GenomicAlignments_1.46.0 lifecycle_1.0.4          iterators_1.0.14
#>  [34] pkgconfig_2.0.3          Matrix_1.7-4             R6_2.6.1
#>  [37] fastmap_1.2.0            digest_0.6.37            colorspace_2.1-2
#>  [40] patchwork_1.3.2          AnnotationDbi_1.72.0     RSpectra_0.16-2
#>  [43] Hmisc_5.2-4              RSQLite_2.4.3            filelock_1.0.3
#>  [46] labeling_0.4.3           httr_1.4.7               abind_1.4-8
#>  [49] compiler_4.5.1           bit64_4.6.0-1            withr_3.0.2
#>  [52] doParallel_1.0.17        backports_1.5.0          htmlTable_2.4.3
#>  [55] S7_0.2.0                 BiocParallel_1.44.0      DBI_1.2.3
#>  [58] rappdirs_0.3.3           DelayedArray_0.36.0      rjson_0.2.23
#>  [61] tools_4.5.1              vipor_0.4.7              foreign_0.8-90
#>  [64] beeswarm_0.4.0           nnet_7.3-20              glue_1.8.0
#>  [67] restfulr_0.0.16          rhdf5filters_1.22.0      grid_4.5.1
#>  [70] checkmate_2.3.3          cluster_2.1.8.1          gtable_0.3.6
#>  [73] tzdb_0.5.0               preprocessCore_1.72.0    tidyr_1.3.1
#>  [76] data.table_1.17.8        hms_1.1.4                WGCNA_1.73
#>  [79] utf8_1.2.6               XVector_0.50.0           BiocVersion_3.22.0
#>  [82] foreach_1.5.2            pillar_1.11.1            stringr_1.5.2
#>  [85] vroom_1.6.6              splines_4.5.1            lattice_0.22-7
#>  [88] survival_3.8-3           bit_4.6.0                tidyselect_1.2.1
#>  [91] GO.db_3.22.0             Biostrings_2.78.0        knitr_1.50
#>  [94] gridExtra_2.3            bookdown_0.45            xfun_0.53
#>  [97] UCSC.utils_1.6.0         stringi_1.8.7            yaml_2.3.10
#> [100] evaluate_1.0.5           codetools_0.2-20         cigarillo_1.0.0
#> [103] archive_1.1.12           tibble_3.3.0             BiocManager_1.30.26
#> [106] cli_3.6.5                rpart_4.1.24             jquerylib_0.1.4
#> [109] GenomeInfoDb_1.46.0      dichromat_2.0-0.1        Rcpp_1.1.0
#> [112] png_0.1-8                XML_3.99-0.19            fastcluster_1.3.0
#> [115] ggrastr_1.0.2            parallel_4.5.1           readr_2.1.5
#> [118] blob_1.2.4               bitops_1.0-9             scales_1.4.0
#> [121] purrr_1.1.0              crayon_1.5.3             rlang_1.1.6
#> [124] KEGGREST_1.50.0
```