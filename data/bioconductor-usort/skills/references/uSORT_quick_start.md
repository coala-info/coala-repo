# uSORT: Quick Start

#### 30 October 2025

# Contents

* [1 uSORT workflow](#usort-workflow)
* [2 Run uSORT](#run-usort)
  + [2.1 uSORT GUI](#usort-gui)
  + [2.2 uSORT Main Function](#usort-main-function)
* [3 uSORT Example](#usort-example)
  + [3.1 Result Object and files](#result-object-and-files)
  + [3.2 Preliminary ordering heatmap with signature gene](#preliminary-ordering-heatmap-with-signature-gene)
  + [3.3 Refine ordering heatmap with signature gene](#refine-ordering-heatmap-with-signature-gene)
* [4 Session Information](#session-information)

# 1 uSORT workflow

**uSORT** package is designed to uncover the intrinsic cell progression path from single-cell RNA-seq data. It incorporates data pre-processing, preliminary PCA gene selection, preliminary cell ordering, refined gene selection, refined cell ordering, and post-analysis interpretation and visualization. The schematic overview of the uSORT workflow is shown in the figure below:

![](data:image/png;base64...)

# 2 Run uSORT

The uSORT workflow can be applied through either the user-friendly GUI or calling the main function.

## 2.1 uSORT GUI

After the installation of the uSORT pacakge, the GUI can be easily launched by a single command.

```
require(uSORT)
```

```
## Loading required package: uSORT
```

```
## Loading required package: tcltk
```

```
## No methods found in package 'BiocGenerics' for request: 'clusterEvalQ' when loading 'uSORT'
```

```
## No methods found in package 'BiocGenerics' for request: 'parCapply' when loading 'uSORT'
```

```
## No methods found in package 'BiocGenerics' for request: 'parRapply' when loading 'uSORT'
```

```
# uSORT_GUI()
```

On mac, the GUI will appear as shown below:

![](data:image/png;base64...)

On the GUI, user can choose their input file (currently support TPM and CPM format in txt file), specify the priliminary sorting method and refined sorting method. By click the parameter button, user can further customize the parameters for each method. A parameter panel for `autoSPIN` method appears like below:

![](data:image/png;base64...)

In the main GUI window, give a project name and choose the result path, then click submit. The program will run and details will be printed on the R console. Once the analysis is done, results will be saved under the selected result path.

## 2.2 uSORT Main Function

User can also directly call the main function named `uSORT` of the pacakge. The documentation file can be extracted using command `?uSORT`. The usage and parameters of `uSORT` function is shown below:

```
args(uSORT)
```

```
## function (exprs_file, log_transform = TRUE, remove_outliers = TRUE,
##     preliminary_sorting_method = c("autoSPIN", "sWanderlust",
##         "monocle", "Wanderlust", "SPIN", "none"), refine_sorting_method = c("autoSPIN",
##         "sWanderlust", "monocle", "Wanderlust", "SPIN", "none"),
##     project_name = "uSORT", result_directory = getwd(), nCores = 1,
##     save_results = TRUE, reproduce_seed = 1234, scattering_cutoff_prob = 0.75,
##     driving_force_cutoff = NULL, qval_cutoff_featureSelection = 0.05,
##     pre_data_type = c("linear", "cyclical"), pre_SPIN_option = c("STS",
##         "neighborhood"), pre_SPIN_sigma_width = 1, pre_autoSPIN_alpha = 0.2,
##     pre_autoSPIN_randomization = 20, pre_wanderlust_start_cell = NULL,
##     pre_wanderlust_dfmap_components = 4, pre_wanderlust_l = 15,
##     pre_wanderlust_num_waypoints = 150, pre_wanderlust_waypoints_seed = 2711,
##     pre_wanderlust_flock_waypoints = 2, ref_data_type = c("linear",
##         "cyclical"), ref_SPIN_option = c("STS", "neighborhood"),
##     ref_SPIN_sigma_width = 1, ref_autoSPIN_alpha = 0.2, ref_autoSPIN_randomization = 20,
##     ref_wanderlust_start_cell = NULL, ref_wanderlust_dfmap_components = 4,
##     ref_wanderlust_l = 15, ref_wanderlust_num_waypoints = 150,
##     ref_wanderlust_flock_waypoints = 2, ref_wanderlust_waypoints_seed = 2711)
## NULL
```

# 3 uSORT Example

Runing the pacakge through the GUI is quite straightforward, so here we demo the usage of the main function with an example:

```
dir <- system.file('extdata', package='uSORT')
file <- list.files(dir, pattern='.txt$', full=TRUE)
# uSORT_results <- uSORT(exprs_file = file,
#                        log_transform = TRUE,
#                        remove_outliers = TRUE,
#                        project_name = "uSORT_example",
#                        preliminary_sorting_method = "autoSPIN",
#                        refine_sorting_method = "sWanderlust",
#                        result_directory = getwd(),
#                        save_results = TRUE,
#                        reproduce_seed = 1234)
```

## 3.1 Result Object and files

When the analysis is done, the results will be returned in a list:

```
#str(uSORT_results)

# List of 7
#  $ exp_raw                        : num [1:251, 1:43280] 1.08 0 0 0.62 0 0 0 0.27 1.16 0 ...
#   ..- attr(*, "dimnames")=List of 2
#   .. ..$ : chr [1:251] "RMD119" "RMD087" "RMD078" "RMD225" ...
#   .. ..$ : chr [1:43280] "0610005C13Rik" "0610007P14Rik" "0610009B22Rik" "0610009E02Rik" ...
#  $ trimmed_log2exp                : num [1:241, 1:9918] 4.82 0 0 2.77 5.84 ...
#   ..- attr(*, "dimnames")=List of 2
#   .. ..$ : chr [1:241] "RMD119" "RMD087" "RMD078" "RMD225" ...
#   .. ..$ : chr [1:9918] "0610007P14Rik" "0610009B22Rik" "0610009E02Rik" "0610009O20Rik" ...
#  $ preliminary_sorting_genes      : chr [1:650] "1110038B12Rik" "1190002F15Rik" "2810417H13Rik" "5430435G22Rik" ...
#  $ preliminary_sorting_order      : chr [1:241] "RMD196" "RMD236" "RMD250" "RMD220" ...
#  $ refined_sorting_genes          : chr [1:320] "Mpo" "H2-Aa" "Cd74" "H2-Ab1" ...
#  $ refined_sorting_order          : chr [1:241] "RMD271" "RMD272" "RMD265" "RMD295" ...
#  $ driverGene_refinedOrder_log2exp: num [1:241, 1:320] 13.16 10.77 12.17 9.82 9.77 ...
#   ..- attr(*, "dimnames")=List of 2
#   .. ..$ : chr [1:241] "RMD271" "RMD272" "RMD265" "RMD295" ...
#   .. ..$ : chr [1:320] "Mpo" "H2-Aa" "Cd74" "H2-Ab1" ...
```

And if `save_results = TRUE`, several result files will be saved:

uSORT\_example\_final\_driver\_genes\_profiles.pdf:

![](data:image/png;base64...)

uSORT\_example\_distance\_heatmap\_preliminary.pdf:

![](data:image/png;base64...)

uSORT\_example\_distance\_heatmap\_refined.pdf:

![](data:image/png;base64...)

If the cell type and signature genes are known, the reuslts can be validated with these information:

```
# sig_genes <- read.table(file.path(system.file('extdata', package='uSORT'),  'signature_genes.txt'))
# sig_genes <- as.character(sig_genes[,1])
# spl_annotat <- read.table(file.path(system.file('extdata', package='uSORT'), 'celltype.txt'),header=T)
```

## 3.2 Preliminary ordering heatmap with signature gene

```
pre_log2ex <- uSORT_results$trimmed_log2exp[rev(uSORT_results$preliminary_sorting_order), ]
m <- spl_annotat[match(rownames(pre_log2ex), spl_annotat$SampleID), ]
celltype_color <- c('blue','red','black')
celltype <- c('MDP','CDP','PreDC')
cell_color <- celltype_color[match(m$GroupID, celltype)]
sigGenes_log2ex <- t(pre_log2ex[ ,colnames(pre_log2ex) %in% sig_genes])
fileNm <- paste0(project_name, '_signatureGenes_profiles_preliminary.pdf')
heatmap.2(as.matrix(sigGenes_log2ex),
          dendrogram='row',
          trace='none',
          col = bluered,
          Rowv=T,Colv=F,
          scale = 'row',
          cexRow=1.8,
          ColSideColors=cell_color,
          margins = c(8, 8))

legend("topright",
       legend=celltype,
       col=celltype_color,
       pch=20,
       horiz=T,
       bty= "n",
       inset=c(0,-0.01),
       pt.cex=1.5)
```

![](data:image/png;base64...)

## 3.3 Refine ordering heatmap with signature gene

```
ref_log2ex <- uSORT_results$trimmed_log2exp[uSORT_results$refined_sorting_order, ]
m <- spl_annotat[match(rownames(ref_log2ex), spl_annotat$SampleID), ]
celltype_color <- c('blue','red','black')
celltype <- c('MDP','CDP','PreDC')
cell_color <- celltype_color[match(m$GroupID, celltype)]
sigGenes_log2ex <- t(ref_log2ex[ ,colnames(ref_log2ex) %in% sig_genes])
fileNm <- paste0(project_name, '_signatureGenes_profiles_refine.pdf')
heatmap.2(as.matrix(sigGenes_log2ex),
          dendrogram='row',
          trace='none',
          col = bluered,
          Rowv=T,Colv=F,
          scale = 'row',
          cexRow=1.8,
          ColSideColors=cell_color,
          margins = c(8, 8))

legend("topright",
       legend=celltype,
       col=celltype_color,
       pch=20,
       horiz=T,
       bty= "n",
       inset=c(0,-0.01),
       pt.cex=1.5)
```

![](data:image/png;base64...)

# 4 Session Information

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
## [1] tcltk     stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] uSORT_1.36.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1      viridisLite_0.4.2     dplyr_1.1.4
##  [4] farver_2.1.2          viridis_0.6.5         S7_0.2.0
##  [7] bitops_1.0-9          fastmap_1.2.0         combinat_0.0-8
## [10] fastICA_1.2-7         RANN_2.6.2            digest_0.6.37
## [13] lifecycle_1.0.4       cluster_2.1.8.1       statmod_1.5.1
## [16] magrittr_2.0.4        kernlab_0.9-33        compiler_4.5.1
## [19] rlang_1.1.6           sass_0.4.10           tools_4.5.1
## [22] igraph_2.2.1          yaml_2.3.10           knitr_1.50
## [25] mclust_6.1.1          plyr_1.8.9            RColorBrewer_1.1-3
## [28] KernSmooth_2.23-26    Rtsne_0.17            BiocGenerics_0.56.0
## [31] nnet_7.3-20           grid_4.5.1            stats4_4.5.1
## [34] caTools_1.18.3        ggplot2_4.0.0         scales_1.4.0
## [37] gtools_3.9.5          fpc_2.2-13            MASS_7.3-65
## [40] prabclus_2.3-4        HSMMSingleCell_1.29.0 dichromat_2.0-0.1
## [43] cli_3.6.5             rmarkdown_2.30        generics_0.1.4
## [46] robustbase_0.99-6     RSpectra_0.16-2       reshape2_1.4.4
## [49] cachem_1.1.0          stringr_1.5.2         modeltools_0.2-24
## [52] splines_4.5.1         parallel_4.5.1        DDRTree_0.1.5
## [55] BiocManager_1.30.26   matrixStats_1.5.0     vctrs_0.6.5
## [58] Matrix_1.7-4          jsonlite_2.0.0        VGAM_1.1-13
## [61] slam_0.1-55           bookdown_0.45         irlba_2.3.5.1
## [64] diptest_0.77-2        monocle_2.38.0        limma_3.66.0
## [67] jquerylib_0.1.4       glue_1.8.0            DEoptimR_1.1-4
## [70] stringi_1.8.7         gtable_0.3.6          tibble_3.3.0
## [73] pillar_1.11.1         htmltools_0.5.8.1     gplots_3.2.0
## [76] R6_2.6.1              evaluate_1.0.5        lattice_0.22-7
## [79] Biobase_2.70.0        pheatmap_1.0.13       leidenbase_0.1.35
## [82] bslib_0.9.0           class_7.3-23          Rcpp_1.1.0
## [85] flexmix_2.3-20        gridExtra_2.3         xfun_0.53
## [88] pkgconfig_2.0.3
```