# SpaNorm: Spatially aware library size normalisation

#### Dharmesh D. Bhuva and Agus Salim

#### 30 October 2025

Abstract

This package implements the spatially aware library size normalisation algorithm, SpaNorm. SpaNorm normalises out library size effects while retaining biology through the modelling of smooth functions for each effect. Normalisation is performed in a gene- and cell-/spot- specific manner, yielding library size adjusted data.

* [1 SpaNorm](#spanorm)
* [2 Load count data](#load-count-data)
* [3 Normalise count data](#normalise-count-data)
* [4 Computing alternative adjustments using a precomputed SpaNorm fit](#computing-alternative-adjustments-using-a-precomputed-spanorm-fit)
* [5 Varying model complexity](#varying-model-complexity)
* [6 Enhancing signal](#enhancing-signal)
* [7 Session information](#session-information)
* [References](#references)

# 1 SpaNorm

SpaNorm is a spatially aware library size normalisation method that removes library size effects, while retaining biology. Library sizes need to be removed from molecular datasets to allow comparisons across observations, in this case, across space. Bhuva et al. (Bhuva et al. 2024) and Atta et al. (Atta et al. 2024) have shown that standard single-cell inspired library size normalisation approaches are not appropriate for spatial molecular datasets as they often remove biological signals while doing so. This is because library size confounds biology in spatial molecular data.

![](data:image/png;base64...)

*The SpaNorm workflow: SpaNorm takes the gene expression data and spatial coordinates as inputs. Using a gene-wise model (e.g., Negative Binomial (NB)), SpaNorm decomposes spatially-smooth variation into those unrelated to library size (LS), representing the underlying true biology and those related to library size. The adjusted data is then produced by keeping only the variation unrelated to library size.*

SpaNorm uses a unique approach to spatially constraint modelling approach to model gene expression (e.g., counts) and remove library size effects, while retaining biology. It achieves this through three key innovations:

1. Optmial decomposition of spatial variation into spatially smooth library size associated (technical) and library size independent (biology) variation using generalized linear models (GLMs).
2. Computing spatially smooth functions (using thin plate splines) to represent the gene- and location-/cell-/spot- specific size factors.
3. Adjustment of data using percentile adjusted counts (PAC) (Salim et al. 2022), as well as other adjustment approaches (e.g., Pearson).

The SpaNorm package can be installed as follows:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# release version
BiocManager::install("SpaNorm")
# development version from GitHub
BiocManager::install("bhuvad/SpaNorm")
```

# 2 Load count data

We begin by loading some example 10x Visium data profiling the dorsolateral prefrontal cortex (DLPFC) of the human brain. The data has ~4,000 spots and covers genome-wide measurements. The example data here is filtered to remove lowly expressed genes (using `filterGenes(HumanDLPFC, prop = 0.1)`). This filtering retains genes that are expressed in at least 10% of cells.

```
library(SpaNorm)
library(SpatialExperiment)
library(ggplot2)

# load sample data
data(HumanDLPFC)
# change gene IDs to gene names
rownames(HumanDLPFC) = rowData(HumanDLPFC)$gene_name
HumanDLPFC
#> class: SpatialExperiment
#> dim: 5076 4015
#> metadata(0):
#> assays(1): counts
#> rownames(5076): NOC2L HES4 ... MT-CYB AC007325.4
#> rowData names(2): gene_name gene_biotype
#> colnames(4015): AAACAAGTATCTCCCA-1 AAACACCAATAACTGC-1 ...
#>   TTGTTTCCATACAACT-1 TTGTTTGTGTAAATTC-1
#> colData names(3): cell_count sample_id AnnotatedCluster
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
#> spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
#> imgData names(4): sample_id image_id data scaleFactor

# plot regions
p_region = plotSpatial(HumanDLPFC, colour = AnnotatedCluster, size = 0.5) +
  scale_colour_brewer(palette = "Paired", guide = guide_legend(override.aes = list(shape = 15, size = 5))) +
  ggtitle("Region")
p_region
```

![](data:image/png;base64...)

The `filterGenes` function returns a logical vector indicating which genes should be kept.

```
# filter genes expressed in 20% of spots
keep = filterGenes(HumanDLPFC, 0.2)
table(keep)
#> keep
#> FALSE  TRUE
#>  2568  2508
# subset genes
HumanDLPFC = HumanDLPFC[keep, ]
```

The log-transformed raw counts are visualised below for the gene *MOBP* which is a marker of oligodendrocytes enriched in the white matter (WM) (Maynard et al. 2021). Despite being a marker of this region, we see that it is in fact absent from the white matter region.

```
logcounts(HumanDLPFC) = log2(counts(HumanDLPFC) + 1)

p_counts = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("logCounts")
p_region + p_counts
```

![](data:image/png;base64...)

# 3 Normalise count data

SpaNorm normalises data in two steps: (1) fitting the SpaNorm model of library sizes; (2) adjusting data using the fit model. A single call to the `SpaNorm()` function is enough to run these two steps. To speed up computation, the model is fit using a smaller proportion of spots/cells (default is 0.25). The can be modified using the `sample.p` parameter.

```
set.seed(36)
HumanDLPFC = SpaNorm(HumanDLPFC)
#> (1/2) Fitting SpaNorm model
#> 1004 cells/spots sampled to fit model
#> iter:  1, estimating gene-wise dispersion
#> iter:  1, log-likelihood: -3185991.766198
#> iter:  1, fitting NB model
#> iter:  1, iter:  1, log-likelihood: -3185991.766198
#> iter:  1, iter:  2, log-likelihood: -2567924.376454
#> iter:  1, iter:  3, log-likelihood: -2450277.839835
#> iter:  1, iter:  4, log-likelihood: -2414037.953164
#> iter:  1, iter:  5, log-likelihood: -2398032.009323
#> iter:  1, iter:  6, log-likelihood: -2392568.250076
#> iter:  1, iter:  7, log-likelihood: -2390646.578388
#> iter:  1, iter:  8, log-likelihood: -2389901.755646
#> iter:  1, iter:  9, log-likelihood: -2389539.966963
#> iter:  1, iter: 10, log-likelihood: -2389392.605268 (converged)
#> iter:  2, estimating gene-wise dispersion
#> iter:  2, log-likelihood: -2384797.662723
#> iter:  2, fitting NB model
#> iter:  2, iter:  1, log-likelihood: -2384797.662723
#> iter:  2, iter:  2, log-likelihood: -2383110.298266
#> iter:  2, iter:  2, log-likelihood: -2383110.298266
#> iter:  2, iter:  2, log-likelihood: -2383110.298266
#> iter:  2, iter:  3, log-likelihood: -2383110.298266 (converged)
#> iter:  3, estimating gene-wise dispersion
#> iter:  3, log-likelihood: -2383092.557642
#> iter:  3, fitting NB model
#> iter:  3, iter:  1, log-likelihood: -2383092.557642
#> iter:  3, iter:  2, log-likelihood: -2383073.930991
#> iter:  3, iter:  3, log-likelihood: -2383042.647041 (converged)
#> iter:  4, log-likelihood: -2383042.647041 (converged)
#> (2/2) Normalising data
HumanDLPFC
#> class: SpatialExperiment
#> dim: 2508 4015
#> metadata(1): SpaNorm
#> assays(2): counts logcounts
#> rownames(2508): ISG15 SDF4 ... MT-ND6 MT-CYB
#> rowData names(2): gene_name gene_biotype
#> colnames(4015): AAACAAGTATCTCCCA-1 AAACACCAATAACTGC-1 ...
#>   TTGTTTCCATACAACT-1 TTGTTTGTGTAAATTC-1
#> colData names(3): cell_count sample_id AnnotatedCluster
#> reducedDimNames(0):
#> mainExpName: NULL
#> altExpNames(0):
#> spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
#> imgData names(4): sample_id image_id data scaleFactor
```

The above output (which can be switched off by setting `verbose = FALSE`), shows the two steps of normalisation. In the model fitting step, 1004 cells/spots are used to fit the negative binomial (NB) model. Subsequent output shows that this fit is performed by alternating between estimation of the dispersion parameter and estimation of the NB parameters by fixing the dispersion. The output also shows that each intermediate fit converges, and so does the final fit. The accuracy of the fit can be controlled by modifying the tolerance parameter `tol` (default `1e-4`).

Next, data is adjusted using the fit model. The following approaches are implemented for count data:

1. `adj.method = "logpac"` (default) - percentile adjusted counts (PAC) which estimates the count for each gene at each location/spot/cell using a model that does not contain unwanted effects such as the library size.
2. `adj.method = "person"` - Pearson residuals from factoring out unwanted effects.
3. `adj.method = "meanbio"` - the mean of each gene at each location estimated from the biological component of the model.
4. `adj.method = "medbio"` - the median of each gene at each location estimated from the biological component of the model.

These data are stored in the `logcounts` assay of the SpatialExperiment object. After normalisation, we see that MOBP is enriched in the white matter.

```
p_logpac = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("logPAC")
p_region + p_logpac
```

![](data:image/png;base64...)

# 4 Computing alternative adjustments using a precomputed SpaNorm fit

As no appropriate slot exists for storing model parameters, we currently save them in the metadata slot with the name “SpaNorm”. This also means that subsetting features (i.e., genes) or observations (i.e., cells/spots/loci) does not subset the model. In such an instance, the SpaNorm function will realise that the model no longer matches the data and re-estimates when called. If instead the model is valid for the data, the existing fit is extracted and reused.

The fit can be manually retrieved as below for users wishing to reuse the model outside the SpaNorm framework. Otherwise, calling `SpaNorm()` on an object containing the fit will automatically use it.

```
# manually retrieve model
fit.spanorm = metadata(HumanDLPFC)$SpaNorm
fit.spanorm
#> SpaNormFit
#> Data: 2508 genes, 4015 cells/spots
#> Gene model: nb
#> Degrees of freedom (TPS): 6
#> Spots/cells sampled: 25%
#> Regularisation parameter: 1e-04
#> Batch:  NULL
#> log-likelihood (per-iteration):  num [1:3] -2389393 -2383110 -2383043
#> W:  num [1:4015, 1:73] 0.2645 0.4736 0.0547 -0.1756 0.6039 ...
#> W:  - attr(*, "dimnames")=List of 2
#> W:   ..$ : chr [1:4015] "1" "2" "3" "4" ...
#> W:   ..$ : chr [1:73] "logLS" "bs.xy1" "bs.xy2" "bs.xy3" ...
#> alpha:  num [1:2508, 1:73] 1.01 1.01 1.01 1.01 1.01 ...
#> gmean:  num [1:2508] -1.249 -1.174 -1.266 -1.436 -0.386 ...
#> psi:  num [1:2508] 9.77e-05 1.40e-03 1.99e-04 9.77e-05 1.49e-02 ...
#> wtype:  Factor w/ 3 levels "batch","biology",..: 3 2 2 2 2 2 2 2 2 2 ...
```

When a valid fit exists in the object, only the adjustment step is performed. The model is recomputed if `overwrite = TRUE` or any of the following parameters change: degrees of freedom (`df.tps`), penalty parameters(`lambda.a`), object dimensions, or `batch` specification. Alternative adjustments can be computed as below and stored to the `logcounts` assay.

```
# Pearson residuals
HumanDLPFC = SpaNorm(HumanDLPFC, adj.method = "pearson")
p_pearson = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("Pearson")

# meanbio residuals
HumanDLPFC = SpaNorm(HumanDLPFC, adj.method = "meanbio")
p_meanbio = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("Mean biology")

# meanbio residuals
HumanDLPFC = SpaNorm(HumanDLPFC, adj.method = "medbio")
p_medbio = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("Median biology")

p_region + p_counts + p_logpac + p_pearson + p_meanbio + p_medbio + plot_layout(ncol = 3)
```

![](data:image/png;base64...)

The mean biology adjustment shows a significant enrichment of the *MOBP* gene in the white matter. As the overall counts of this gene are low in this sample, other methods show less discriminative power.

# 5 Varying model complexity

The complexity of the spatial smoothing function is determined by the `df.tps` parameter where larger values result in more complicated functions (default 6).

```
# df.tps = 2
HumanDLPFC_df2 = SpaNorm(HumanDLPFC, df.tps = 2)
p_logpac_2 = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("logPAC (df.tps = 2)")

# df.tps = 6 (default)
p_logpac_6 = p_logpac +
  ggtitle("logPAC (df.tps = 6)")

p_logpac_2 + p_logpac_6
```

![](data:image/png;base64...)

# 6 Enhancing signal

As the counts for the MOBP gene are very low, we see artifacts in the adjusted counts. As we have a model for the genes, we can increase the signal by adjusting all means by a constant factor. Applying a scale factor of 4 shows how the adjusted data are more continuous, with significant enrichment in the white matter.

```
# scale.factor = 1 (default)
HumanDLPFC = SpaNorm(HumanDLPFC, scale.factor = 1)
p_logpac_sf1 = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("logPAC (scale.factor = 1)")

# scale.factor = 4
HumanDLPFC = SpaNorm(HumanDLPFC, scale.factor = 4)
p_logpac_sf4 = plotSpatial(
    HumanDLPFC,
    colour = MOBP,
    what = "expression",
    assay = "logcounts",
    size = 0.5
  ) +
  scale_colour_viridis_c(option = "F") +
  ggtitle("logPAC (scale.factor = 4)")

p_logpac_sf1 + p_logpac_sf4 + plot_layout(ncol = 2)
```

![](data:image/png;base64...)

# 7 Session information

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
#>  [1] SpatialExperiment_1.20.0    SingleCellExperiment_1.32.0
#>  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [7] IRanges_2.44.0              S4Vectors_0.48.0
#>  [9] BiocGenerics_0.56.0         generics_0.1.4
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] patchwork_1.3.2             ggplot2_4.0.0
#> [15] SpaNorm_1.4.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        rjson_0.2.23        xfun_0.53
#>  [4] bslib_0.9.0         lattice_0.22-7      vctrs_0.6.5
#>  [7] tools_4.5.1         parallel_4.5.1      tibble_3.3.0
#> [10] cluster_2.1.8.1     BiocNeighbors_2.4.0 pkgconfig_2.0.3
#> [13] Matrix_1.7-4        RColorBrewer_1.1-3  dqrng_0.4.1
#> [16] S7_0.2.0            lifecycle_1.0.4     compiler_4.5.1
#> [19] farver_2.1.2        prettydoc_0.4.1     statmod_1.5.1
#> [22] BiocStyle_2.38.0    bluster_1.20.0      codetools_0.2-20
#> [25] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
#> [28] pillar_1.11.1       jquerylib_0.1.4     BiocParallel_1.44.0
#> [31] limma_3.66.0        DelayedArray_0.36.0 cachem_1.1.0
#> [34] magick_2.9.0        abind_1.4-8         metapod_1.18.0
#> [37] locfit_1.5-9.12     rsvd_1.0.5          tidyselect_1.2.1
#> [40] digest_0.6.37       BiocSingular_1.26.0 dplyr_1.1.4
#> [43] labeling_0.4.3      splines_4.5.1       fastmap_1.2.0
#> [46] grid_4.5.1          cli_3.6.5           SparseArray_1.10.0
#> [49] magrittr_2.0.4      S4Arrays_1.10.0     dichromat_2.0-0.1
#> [52] edgeR_4.8.0         withr_3.0.2         scales_1.4.0
#> [55] rmarkdown_2.30      XVector_0.50.0      igraph_2.2.1
#> [58] scran_1.38.0        beachmat_2.26.0     ScaledMatrix_1.18.0
#> [61] evaluate_1.0.5      knitr_1.50          irlba_2.3.5.1
#> [64] viridisLite_0.4.2   rlang_1.1.6         Rcpp_1.1.0
#> [67] scuttle_1.20.0      glue_1.8.0          BiocManager_1.30.26
#> [70] jsonlite_2.0.0      R6_2.6.1
```

# References

Atta, Lyla, Kalen Clifton, Manjari Anant, Gohta Aihara, and Jean Fan. 2024. “Gene Count Normalization in Single-Cell Imaging-Based Spatially Resolved Transcriptomics.” *bioRxiv*. <https://doi.org/10.1101/2023.08.30.555624>.

Bhuva, Dharmesh D, Chin Wee Tan, Agus Salim, Claire Marceaux, Marie A Pickering, Jinjin Chen, Malvika Kharbanda, et al. 2024. “Library Size Confounds Biology in Spatial Transcriptomics Data.” *Genome Biology* 25 (1): 99.

Maynard, Kristen R, Leonardo Collado-Torres, Lukas M Weber, Cedric Uytingco, Brianna K Barry, Stephen R Williams, Joseph L Catallini, et al. 2021. “Transcriptome-Scale Spatial Gene Expression in the Human Dorsolateral Prefrontal Cortex.” *Nature Neuroscience* 24 (3): 425–36.

Salim, Agus, Ramyar Molania, Jianan Wang, Alysha De Livera, Rachel Thijssen, and Terence P Speed. 2022. “RUV-III-NB: normalization of single cell RNA-seq data.” *Nucleic Acids Research* 50 (16): e96–e96. <https://doi.org/10.1093/nar/gkac486>.