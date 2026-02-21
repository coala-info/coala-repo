# Data visualization with epiregulon.extra

Xiaosai Yao, Tomasz Włodarczyk

#### 29 October 2025

#### Package

epiregulon.extra 1.6.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Data preparation](#data-preparation)
* [4 Calculate TF activity](#calculate-tf-activity)
* [5 Perform differential activity](#perform-differential-activity)
* [6 Visualize the results](#visualize-the-results)
* [7 Geneset enrichment](#geneset-enrichment)
* [8 Network analysis](#network-analysis)
* [9 Differential networks](#differential-networks)
* [10 Session Info](#session-info)

# 1 Introduction

*[epiregulon.extra](https://bioconductor.org/packages/3.22/epiregulon.extra)* is a companion package to *[epiregulon](https://bioconductor.org/packages/3.22/epiregulon)* and provides functions to visualize transcription factor activity and network. It also provides statistical tests to identify transcription factors with differential activity and network topology. This tutorial continues from the reprogram-seq example included in epiregulon. We will use the gene regulatory networks constructed by epiregulon and continue with visualization and network analysis.

For full documentation of the `epiregulon` package, please refer to the [epiregulon book](https://xiaosaiyao.github.io/epiregulon.book/).

# 2 Installation

```
 if (!require("BiocManager", quietly = TRUE))
     install.packages("BiocManager")

 BiocManager::install("epiregulon.extra")
```

# 3 Data preparation

To continue with the visualization functions, we will first need the gene expression matrix. We can download the data from *[scMultiome](https://bioconductor.org/packages/3.22/scMultiome)*.

```
# load the MAE object
library(scMultiome)
```

```
## Loading required package: AnnotationHub
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
## Loading required package: ExperimentHub
```

```
## Loading required package: MultiAssayExperiment
```

```
## Loading required package: SummarizedExperiment
```

```
## Loading required package: MatrixGenerics
```

```
## Loading required package: matrixStats
```

```
##
## Attaching package: 'MatrixGenerics'
```

```
## The following objects are masked from 'package:matrixStats':
##
##     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
##     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
##     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
##     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
##     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
##     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
##     colWeightedMeans, colWeightedMedians, colWeightedSds,
##     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
##     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
##     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
##     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
##     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
##     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
##     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
##     rowWeightedSds, rowWeightedVars
```

```
## Loading required package: GenomicRanges
```

```
## Loading required package: stats4
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
## Loading required package: IRanges
```

```
## Loading required package: Seqinfo
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
##
## Attaching package: 'Biobase'
```

```
## The following object is masked from 'package:MatrixGenerics':
##
##     rowMedians
```

```
## The following objects are masked from 'package:matrixStats':
##
##     anyMissing, rowMedians
```

```
## The following object is masked from 'package:ExperimentHub':
##
##     cache
```

```
## The following object is masked from 'package:AnnotationHub':
##
##     cache
```

```
## Loading required package: SingleCellExperiment
```

```
mae <- scMultiome::reprogramSeq()
```

```
## see ?scMultiome and browseVignettes('scMultiome') for documentation
```

```
## loading from cache
```

```
# expression matrix
GeneExpressionMatrix <- mae[["GeneExpressionMatrix"]]
rownames(GeneExpressionMatrix) <- rowData(GeneExpressionMatrix)$name

reducedDim(GeneExpressionMatrix, "UMAP_Combined") <-
  reducedDim(mae[["TileMatrix500"]], "UMAP_Combined")

# arrange hash_assignment
GeneExpressionMatrix$hash_assignment <- factor(as.character(
  GeneExpressionMatrix$hash_assignment),
  levels = c("HTO10_GATA6_UTR", "HTO2_GATA6_v2", "HTO8_NKX2.1_UTR", "HTO3_NKX2.1_v2",
    "HTO1_FOXA2_v2", "HTO4_mFOXA1_v2", "HTO6_hFOXA1_UTR", "HTO5_NeonG_v2"
  )
)
```

# 4 Calculate TF activity

Next we load the regulon object previously calculated by epiregulon. Here we just use the pruned version of regulon object in which only relevant columns are kept.
Using epiregulon, we can calculate activity of transcription factors included in the regulon object.

```
library(epiregulon)
library(epiregulon.extra)

data(regulon)

score.combine <- calculateActivity(
  expMatrix = GeneExpressionMatrix,
  regulon = regulon,
  mode = "weight",
  method = "weightedMean",
  exp_assay = "normalizedCounts",
  normalize = FALSE
)
```

```
## Warning in calculateActivity(expMatrix = GeneExpressionMatrix, regulon =
## regulon, : Argument 'method' to calculateActivity was deprecated as of
## epiregulon version 2.0.0
```

```
## calculating TF activity from regulon using weightedMean
```

```
## Warning in calculateActivity(expMatrix = GeneExpressionMatrix, regulon = regulon, : The weight column contains multiple subcolumns but no cluster information was provided.
##           Using first column to compute activity...
```

```
## aggregating regulons...
```

```
## creating weight matrix...
```

```
## calculating activity scores...
```

```
## normalize by the number of targets...
```

# 5 Perform differential activity

We perform a differential analysis of transcription factor activity across groups of cells. This function is a wrapper around `findMarkers` from *[scran](https://bioconductor.org/packages/3.22/scran)*.

```
library(epiregulon.extra)
markers <- findDifferentialActivity(
  activity_matrix = score.combine,
  clusters = GeneExpressionMatrix$hash_assignment,
  pval.type = "some",
  direction = "up",
  test.type = "t",
  logvalue = FALSE
)
```

We can specify the top transcription factors of interest

```
markers.sig <- getSigGenes(markers, topgenes = 5)
```

```
## Using a cutoff of 0.022 for class HTO10_GATA6_UTR for direction equal to any
```

```
## Using a cutoff of 0.019 for class HTO2_GATA6_v2 for direction equal to any
```

```
## Using a cutoff of 0.005 for class HTO8_NKX2.1_UTR for direction equal to any
```

```
## Using a cutoff of 0.0016 for class HTO3_NKX2.1_v2 for direction equal to any
```

```
## Using a cutoff of 0.00066 for class HTO1_FOXA2_v2 for direction equal to any
```

```
## Using a cutoff of 9e-04 for class HTO4_mFOXA1_v2 for direction equal to any
```

```
## Using a cutoff of 6e-04 for class HTO6_hFOXA1_UTR for direction equal to any
```

```
## Using a cutoff of 0.00025 for class HTO5_NeonG_v2 for direction equal to any
```

# 6 Visualize the results

We visualize the known differential transcription factors by bubble plot

```
plotBubble(
  activity_matrix = score.combine,
  tf = c("NKX2-1", "GATA6", "FOXA1", "FOXA2"),
  clusters = GeneExpressionMatrix$hash_assignment
)
```

![](data:image/png;base64...)

Then visualize the most differential transcription factors by clusters

```
plotBubble(
  activity_matrix = score.combine,
  tf = markers.sig$tf,
  clusters = GeneExpressionMatrix$hash_assignment
)
```

![](data:image/png;base64...)

Visualize the known differential transcription factors by violin plot.

```
plotActivityViolin(
  activity_matrix = score.combine,
  tf = c("NKX2-1", "GATA6", "FOXA1", "FOXA2", "AR"),
  clusters = GeneExpressionMatrix$hash_assignment
)
```

![](data:image/png;base64...)

Visualize the known differential transcription factors by UMAP

```
options(ggrastr.default.dpi=100)

ActivityPlot <- plotActivityDim(
  sce = GeneExpressionMatrix,
  activity_matrix = score.combine,
  tf = c("NKX2-1", "GATA6", "FOXA1", "FOXA2", "AR"),
  dimtype = "UMAP_Combined",
  label = "Clusters",
  point_size = 0.3,
  ncol = 3,
  rasterise = TRUE
)

ActivityPlot
```

![](data:image/png;base64...)

In contrast, the gene expression of the transcription factors is very sparse

```
options(ggrastr.default.dpi=100)

ActivityPlot <- plotActivityDim(
  sce = GeneExpressionMatrix,
  activity_matrix = counts(GeneExpressionMatrix),
  tf = c("NKX2-1", "GATA6", "FOXA1", "FOXA2", "AR"),
  dimtype = "UMAP_Combined",
  label = "Clusters",
  point_size = 0.3,
  ncol = 3,
  limit = c(0, 2),
  colors = c("grey", "blue"),
  legend.label = "GEX",
  rasterise = TRUE
)
ActivityPlot
```

![](data:image/png;base64...)

Visualize the activity of the selected transcription factors by heat map. Due to the maximum size limit for this vignette, the output is not shown here.

```
plotHeatmapRegulon(
  sce = GeneExpressionMatrix,
  tfs = c("GATA6", "NKX2-1"),
  regulon = regulon,
  regulon_cutoff = 0,
  downsample = 1000,
  cell_attributes = "hash_assignment",
  col_gap = "hash_assignment",
  exprs_values = "normalizedCounts",
  name = "regulon heatmap",
  column_title_rot = 45,
  raster_quality=4
)

plotHeatmapActivity(
  activity = score.combine,
  sce = GeneExpressionMatrix,
  tfs = c("GATA6", "NKX2-1", "FOXA1", "FOXA2"),
  downsample = 5000,
  cell_attributes = "hash_assignment",
  col_gap = "hash_assignment",
  name = "Activity",
  column_title_rot = 45,
  raster_quality=3
)
```

# 7 Geneset enrichment

Sometimes we are interested to know what pathways are enriched in the regulon of a particular TF. We can perform geneset enrichment using the enricher function from *[clusterProfiler](https://bioconductor.org/packages/3.22/clusterProfiler)*.

```
# retrieve genesets
msigdb.hs = msigdb::getMsigdb(org = 'hs', id = 'SYM', version = '7.4')
```

```
## see ?msigdb and browseVignettes('msigdb') for documentation
```

```
## loading from cache
```

```
## require("GSEABase")
```

```
msigdb.hs <- msigdb.hs[unlist(lapply(msigdb.hs, function(x) {GSEABase::bcCategory(GSEABase::collectionType(x)) %in% c("c6", "h")}))]

# convert genesets to be compatible with enricher
gs.list <- do.call(rbind, lapply(names(msigdb.hs), function(x) {
  data.frame(gs = x, genes = GSEABase::geneIds(msigdb.hs[x][[1]]))
}))

enrichresults <- regulonEnrich(
  TF = c("GATA6", "NKX2-1"),
  regulon = regulon,
  weight = "weight",
  weight_cutoff = 0.1,
  genesets = gs.list
)
```

```
## GATA6
```

```
##
```

```
## NKX2-1
```

```
# plot results
enrichPlot(results = enrichresults)
```

![](data:image/png;base64...)

# 8 Network analysis

We can visualize the genesets as a network

```
plotGseaNetwork(
  tf = names(enrichresults),
  enrichresults = enrichresults,
  p.adj_cutoff = 0.1,
  ntop_pathways = 10
)
```

![](data:image/png;base64...)

# 9 Differential networks

We are interested in understanding the differential networks between two conditions and determining which transcription factors account for the differences in the topology of networks. The pruned regulons with cluster-specific test statistics computed by `pruneRegulon` can be used to generate cluster-specific networks based on user-defined cutoffs and to visualize differential networks for transcription factors of interest. In this dataset, the GATA6 gene was only expressed in cluster 1 (C1) and NKX2-1 was only expressed in cluster 3 (C3). If we visualize the target genes of GATA6, we can see that C1 has many more target genes of GATA6 compared to C5, a cluster that does not express GATA6. Similarly, NKX2-1 target genes are confined to C3 which is the only cluster that exogenously expresses NKX2-1.

```
plotDiffNetwork(regulon,
  cutoff = 0.1,
  tf = c("GATA6"),
  weight = "weight",
  clusters = c("C1", "C5"),
  layout = "stress"
)
```

```
## Building graph using weight as edge weights
```

![](data:image/png;base64...)

```
plotDiffNetwork(regulon,
  cutoff = 0.1,
  tf = c("NKX2-1"),
  weight = "weight",
  clusters = c("C3", "C5"),
  layout = "stress"
)
```

```
## Building graph using weight as edge weights
```

![](data:image/png;base64...)

We can also visualize how transcription factors relate to other transcription factors in C1 cluster.

```
selected <- which(regulon$weight[, "C1"] > 0 &
  regulon$tf %in% c("GATA6", "FOXA1", "AR"))

C1_network <- buildGraph(regulon[selected, ],
  weights = "weight",
  cluster = "C1"
  )
```

```
## Building graph using weight as edge weights
```

```
plotEpiregulonNetwork(C1_network,
  layout = "sugiyama",
  tfs_to_highlight = c("GATA6", "FOXA1", "AR")) +
  ggplot2::ggtitle("C1")
```

![](data:image/png;base64...)
To systematically examine the differential network topology between two clusters, we perform an edge subtraction between two graphs, using weights computed by `pruneRegulon`. We then calculate the degree centrality of the weighted differential graphs and if desired, normalize the differential centrality against the total number of edges. The default normalization function is `sqrt` as it preserves both the difference in the number of edges (but scaled by sqrt) and the differences in the weights. If the user only wants to examine the differences in the averaged weights, the `FUN` argument can be changed to `identity`. Finally, we rank the transcription factors by (normalized) differential centrality. For demonstration purpose, the regulon list is truncated but the full list would contain all the transcription factors.

```
# rank by differential centrality
C1_network <- buildGraph(regulon, weights = "weight", cluster = "C1")
```

```
## Building graph using weight as edge weights
```

```
C5_network <- buildGraph(regulon, weights = "weight", cluster = "C5")
```

```
## Building graph using weight as edge weights
```

```
diff_graph <- buildDiffGraph(C1_network, C5_network, abs_diff = FALSE)
diff_graph <- addCentrality(diff_graph)
diff_graph <- normalizeCentrality(diff_graph)
rank_table <- rankTfs(diff_graph)

library(ggplot2)
ggplot(rank_table, aes(x = rank, y = centrality)) +
  geom_point() +
  ggrepel::geom_text_repel(data = rank_table, aes(label = tf)) +
  theme_classic()
```

![](data:image/png;base64...)

# 10 Session Info

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
##  [1] ggplot2_4.0.0               GSEABase_1.72.0
##  [3] graph_1.88.0                annotate_1.88.0
##  [5] XML_3.99-0.19               AnnotationDbi_1.72.0
##  [7] msigdb_1.17.0               epiregulon.extra_1.6.0
##  [9] epiregulon_2.0.0            scMultiome_1.9.0
## [11] SingleCellExperiment_1.32.0 MultiAssayExperiment_1.36.0
## [13] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [15] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [17] IRanges_2.44.0              S4Vectors_0.48.0
## [19] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [21] ExperimentHub_3.0.0         AnnotationHub_4.0.0
## [23] BiocFileCache_3.0.0         dbplyr_2.5.1
## [25] BiocGenerics_0.56.0         generics_0.1.4
## [27] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.1           ggplotify_0.1.3         filelock_1.0.3
##   [4] tibble_3.3.0            R.oo_1.27.1             polyclip_1.10-7
##   [7] lifecycle_1.0.4         httr2_1.2.1             edgeR_4.8.0
##  [10] lattice_0.22-7          MASS_7.3-65             backports_1.5.0
##  [13] magrittr_2.0.4          limma_3.66.0            sass_0.4.10
##  [16] rmarkdown_2.30          jquerylib_0.1.4         yaml_2.3.10
##  [19] ggtangle_0.0.7          metapod_1.18.0          cowplot_1.2.0
##  [22] DBI_1.2.3               RColorBrewer_1.1-3      abind_1.4-8
##  [25] purrr_1.1.0             R.utils_2.13.0          ggraph_2.2.2
##  [28] yulab.utils_0.2.1       tweenr_2.0.3            rappdirs_0.3.3
##  [31] gdtools_0.4.4           enrichplot_1.30.0       ggrepel_0.9.6
##  [34] irlba_2.3.5.1           tidytree_0.4.6          dqrng_0.4.1
##  [37] codetools_0.2-20        DelayedArray_0.36.0     DOSE_4.4.0
##  [40] scuttle_1.20.0          ggforce_0.5.0           tidyselect_1.2.1
##  [43] aplot_0.2.9             farver_2.1.2            ScaledMatrix_1.18.0
##  [46] viridis_0.6.5           jsonlite_2.0.0          BiocNeighbors_2.4.0
##  [49] tidygraph_1.3.1         scater_1.38.0           systemfonts_1.3.1
##  [52] tools_4.5.1             treeio_1.34.0           Rcpp_1.1.0
##  [55] glue_1.8.0              gridExtra_2.3           SparseArray_1.10.0
##  [58] BiocBaseUtils_1.12.0    xfun_0.53               qvalue_2.42.0
##  [61] dplyr_1.1.4             HDF5Array_1.38.0        withr_3.0.2
##  [64] BiocManager_1.30.26     fastmap_1.2.0           rhdf5filters_1.22.0
##  [67] bluster_1.20.0          digest_0.6.37           rsvd_1.0.5
##  [70] gridGraphics_0.5-1      R6_2.6.1                GO.db_3.22.0
##  [73] Cairo_1.7-0             dichromat_2.0-0.1       RSQLite_2.4.3
##  [76] R.methodsS3_1.8.2       h5mread_1.2.0           tidyr_1.3.1
##  [79] fontLiberation_0.1.0    data.table_1.17.8       htmlwidgets_1.6.4
##  [82] graphlayouts_1.2.2      httr_1.4.7              S4Arrays_1.10.0
##  [85] pkgconfig_2.0.3         gtable_0.3.6            blob_1.2.4
##  [88] S7_0.2.0                XVector_0.50.0          clusterProfiler_4.18.0
##  [91] htmltools_0.5.8.1       fontBitstreamVera_0.1.1 bookdown_0.45
##  [94] fgsea_1.36.0            scales_1.4.0            png_0.1-8
##  [97] ggfun_0.2.0             scran_1.38.0            knitr_1.50
## [100] reshape2_1.4.4          nlme_3.1-168            checkmate_2.3.3
## [103] curl_7.0.0              cachem_1.1.0            rhdf5_2.54.0
## [106] stringr_1.5.2           BiocVersion_3.22.0      parallel_4.5.1
## [109] vipor_0.4.7             ggrastr_1.0.2           pillar_1.11.1
## [112] grid_4.5.1              vctrs_0.6.5             BiocSingular_1.26.0
## [115] beachmat_2.26.0         xtable_1.8-4            cluster_2.1.8.1
## [118] beeswarm_0.4.0          evaluate_1.0.5          tinytex_0.57
## [121] magick_2.9.0            cli_3.6.5               locfit_1.5-9.12
## [124] compiler_4.5.1          rlang_1.1.6             crayon_1.5.3
## [127] labeling_0.4.3          plyr_1.8.9              fs_1.6.6
## [130] ggbeeswarm_0.7.2        ggiraph_0.9.2           stringi_1.8.7
## [133] viridisLite_0.4.2       BiocParallel_1.44.0     Biostrings_2.78.0
## [136] lazyeval_0.2.2          fontquiver_0.2.1        scrapper_1.4.0
## [139] GOSemSim_2.36.0         Matrix_1.7-4            patchwork_1.3.2
## [142] bit64_4.6.0-1           Rhdf5lib_1.32.0         KEGGREST_1.50.0
## [145] statmod_1.5.1           igraph_2.2.1            memoise_2.0.1
## [148] bslib_0.9.0             ggtree_4.0.0            fastmatch_1.1-6
## [151] bit_4.6.0               gson_0.1.0              ape_5.8-1
```