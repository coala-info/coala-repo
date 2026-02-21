# Pathway fingerprint: a tool for biomarker discovery based on gene expression data and pathway knowledge

* [Introduction](#introduction)
  + [Installation](#installation)
* [Analysis Pipeline: Get pathway networks from KEGG](#analysis-pipeline-get-pathway-networks-from-kegg)
  + [Identification of DEGs(differentially expressed genes)](#identification-of-degsdifferentially-expressed-genes)
  + [PFP scores calculation](#pfp-scores-calculation)
  + [Network fingerprint visualization](#network-fingerprint-visualization)
* [Session Information](#session-information)

## Introduction

Traditional methods of analyzing gene expression data in the study of some disease usually compare the disease and normal control groups of samples and find the most differentially expressed genes. But that is hard to discover the disease’s biomarkers and mechanism. To give a quantitative comparison of the complex disease, we achieve *PFP*, a good characterization for a person’s disease based on pathway on the open scientific computing platform **R**. In this package, a pathway-fingerprint (*PFP*) method was introduced to evaluate the importance of a gene set in different pathways to help researchers focus on the most related pathways and genes.It will be used to visually compare and parse different diseases by generating a fingerprint overlay. We collected three types of gene expression data to perform the enrichment analysis in KEGG pathways and make some comparations with other methods. The result indicated that Pathway Fingerprint had better performance than other enrichment tools, which not only picked out the most relevant pathways but also showed strong stability when changing data. we propose a novel, general and systematic method called Pathway Fingerprint to help researchers focus on the fatal pathways and genes by considering the topology knowledge.

The three main features of *PFP*:

* PFP class, the differential genes were mapped to the KEGG pathway and the PFP score was calculated.
* PFPRefnet class, the selected sample in KEGG with network information.
* visualization, a fingerprint overlay.

### Installation

*PFP* requires these packages: *graph*, *igraph*, *KEGGgraph*, *clusterProfiler*, *ggplot2*, *plyr*,*tidy*,*magrittr*, *stats*, *methods* and *utils*. To install *PFP*, some required packages are only available from [Bioconductor](http://bioconductor.org). It also allows users to install the latest development version from github, which requires *devtools* package has been installed on your system or can be installed using `install.packages("devtools")`. Note that devtools sometimes needs some extra non-R software on your system – more specifically, an Rtools download for Windows or Xcode for OS X. There’s more information about devtools [here](https://github.com/hadley/devtools). You can install *PFP* via Bioconductor.

```
## install PFP from github, require biocondutor dependencies
## package pre-installed
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("PFP")
```

You can also install *PFP* via github.

```
## install PFP from github, require biocondutor dependencies
## package pre-installed
if (!require(devtools)) install.packages("devtools")
devtools::install_github("aib-group/PFP")
```

During analysis, you need to install *org.Hs.eg.db*, the installation strategy is as follows.

```
## install PFP from github, require biocondutor dependencies
## package pre-installed
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("org.Hs.eg.db")
```

After installation, the \*{PFP} is ready to load into the current workspace by the following codes to the current workspace by typing or pasting the following codes:

```
library(PFP)
```

## Analysis Pipeline: Get pathway networks from KEGG

In our method, we choose KEGG(<http://www.kegg.jp/>) pathway networks as a reference to generate a Pathway Fingerprint. KEGG provides KGML files of pathways for users, which enables automatic drawing of KEGG pathways and provides facilities for computational analysis and modeling of gene/protein networks and chemical networks. We downloaded the latest (2020.11.8) KGML files of all the human pathways in KEGG and translated the KGML files to network.Then we got a total number of 338 pathway networks for further analysis.

### Identification of DEGs(differentially expressed genes)

There are different methods for the different three types of data to identify DEGs. We processed the microarray data by *limma*, besides, we also selected some cancer samples of the same type of cancer and compared them with the control group by *edgeR*.In both *limma* and *edgeR*, we only chose the genes whose log2 fold change (logFC) was greater than 1 and false discovery rate (FDR) was less than 0.05.

We defined a new S4 class `PFP` to store the score. *PFP* also provides six major methods for this S4 class:

1. `genes_score()`: Gene score, adding function to specified selection group/ pathway.
2. `sub_PFP()`: A portion of the PFP can be selected by group, slice, path name, and ID.
3. `show()`: Display the network group name, group size, and PFP score for each channel
4. `plot_PFP()`: Display PFP fingerprinting.
5. `refnet_names()`: Extract base network group names
6. `rank_PFP()`: To achieve the path weight ranking, the preferred P value, and then the PFP score. Detailed instructions for this five methods refer to package function help.

We also defined a new S4 class `PFPRefnet` to store the reference pathway network information of KEGG, it provides six methods for this S4 class::

1. `network()`: Reference path network of KEGG.
2. `net_info()`: Pathway information.
3. `group()`: Group information.
4. `refnet_names()`: The access information of the reference network.
5. `subnet()`: A portion of the PFPRefnet can be selected by group, slice, path name, and ID.
6. `show()`: Show the number of pathways in each group of the reference network.

### PFP scores calculation

1. Input differential gene list
2. Extract the network information of KEGG base map.
3. The channel fingerprint score was calculated and converted to PFP format.

Then the PFP can be calculated as following:

```
# load the data -- gene list of human; the PFPRefnet object
# of human; the PFP object to test; the list of different
# genes.
data("gene_list_hsa")
data("PFPRefnet_hsa")
data("PFP_test1")
data("data_std")
# Step1: calculate the similarity score of network.
PFP_test <- calc_PFP_score(genes = gene_list_hsa, PFPRefnet = PFPRefnet_hsa)
# Step2: rank the pathway by the PFP score.
rank1 <- rank_PFP(object = PFP_test, total_rank = TRUE, thresh_value = 0.5)
```

We study the target pathway, the pathway with the highest score after ranking.Below is a simple example.

```
# Step1: select the max score of pathway.
pathway_select <- refnet_info(rank1)[1, "id"]
gene_test <- pathways_score(rank1)$genes_score[[pathway_select]]$ENTREZID
# Step2: get the correlation coefficient score of the edge.
edges_coexp <- get_exp_cor_edges(gene_test, data_std)
# Step3: Find the difference genes that are of focus.
gene_list2 <- unique(c(edges_coexp$source, edges_coexp$target))
# Step4: Find the edge to focus on.
edges_kegg <- get_bg_related_kegg(gene_list2, PFPRefnet = PFPRefnet_hsa,
rm_duplicated = TRUE)
# Step5: Find the associated network
require(org.Hs.eg.db)
net_test <- get_asso_net(edges_coexp = edges_coexp, edges_kegg = edges_kegg,
if_symbol = TRUE, gene_info_db = org.Hs.eg.db)
```

### Network fingerprint visualization

*PFP* provides the `plot_PFP()` function to visualize the network fingerprint of a single query network. First we show an example of PFP score.

```
plot_PFP(PFP_test)
```

![](data:image/png;base64...) Plot the scores from high to low.

```
plot_PFP(rank1)
```

![](data:image/png;base64...)

## Session Information

The version number of R and packages loaded for generating the vignette were:

```
#> R version 4.1.0 (2021-05-18)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 20.04.2 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.13-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.13-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] parallel  stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#> [1] org.Hs.eg.db_3.13.0  AnnotationDbi_1.54.0 IRanges_2.26.0
#> [4] S4Vectors_0.30.0     Biobase_2.52.0       BiocGenerics_0.38.0
#> [7] PFP_1.0.0
#>
#> loaded via a namespace (and not attached):
#>   [1] fgsea_1.18.0           colorspace_2.0-1       ggtree_3.0.0
#>   [4] ellipsis_0.3.2         qvalue_2.24.0          XVector_0.32.0
#>   [7] aplot_0.0.6            farver_2.1.0           graphlayouts_0.7.1
#>  [10] ggrepel_0.9.1          bit64_4.0.5            scatterpie_0.1.6
#>  [13] fansi_0.4.2            splines_4.1.0          cachem_1.0.5
#>  [16] GOSemSim_2.18.0        knitr_1.33             polyclip_1.10-0
#>  [19] jsonlite_1.7.2         GO.db_3.13.0           png_0.1-7
#>  [22] graph_1.70.0           ggforce_0.3.3          BiocManager_1.30.15
#>  [25] compiler_4.1.0         httr_1.4.2             rvcheck_0.1.8
#>  [28] assertthat_0.2.1       Matrix_1.3-3           fastmap_1.1.0
#>  [31] lazyeval_0.2.2         tweenr_1.0.2           formatR_1.9
#>  [34] htmltools_0.5.1.1      tools_4.1.0            igraph_1.2.6
#>  [37] gtable_0.3.0           glue_1.4.2             GenomeInfoDbData_1.2.6
#>  [40] reshape2_1.4.4         DO.db_2.9              dplyr_1.0.6
#>  [43] fastmatch_1.1-0        Rcpp_1.0.6             enrichplot_1.12.0
#>  [46] jquerylib_0.1.4        vctrs_0.3.8            Biostrings_2.60.0
#>  [49] ape_5.5                nlme_3.1-152           ggraph_2.0.5
#>  [52] xfun_0.23              stringr_1.4.0          lifecycle_1.0.0
#>  [55] clusterProfiler_4.0.0  XML_3.99-0.6           DOSE_3.18.0
#>  [58] zlibbioc_1.38.0        MASS_7.3-54            scales_1.1.1
#>  [61] tidygraph_1.2.0        KEGGgraph_1.52.0       RColorBrewer_1.1-2
#>  [64] yaml_2.2.1             memoise_2.0.0          gridExtra_2.3
#>  [67] ggplot2_3.3.3          downloader_0.4         sass_0.4.0
#>  [70] stringi_1.6.2          RSQLite_2.2.7          highr_0.9
#>  [73] tidytree_0.3.3         BiocParallel_1.26.0    GenomeInfoDb_1.28.0
#>  [76] rlang_0.4.11           pkgconfig_2.0.3        bitops_1.0-7
#>  [79] evaluate_0.14          lattice_0.20-44        purrr_0.3.4
#>  [82] labeling_0.4.2         treeio_1.16.0          patchwork_1.1.1
#>  [85] shadowtext_0.0.8       cowplot_1.1.1          bit_4.0.4
#>  [88] tidyselect_1.1.1       plyr_1.8.6             magrittr_2.0.1
#>  [91] R6_2.5.0               generics_0.1.0         DBI_1.1.1
#>  [94] pillar_1.6.1           KEGGREST_1.32.0        RCurl_1.98-1.3
#>  [97] tibble_3.1.2           crayon_1.4.1           utf8_1.2.1
#> [100] rmarkdown_2.8          viridis_0.6.1          grid_4.1.0
#> [103] data.table_1.14.0      blob_1.2.1             Rgraphviz_2.36.0
#> [106] digest_0.6.27          tidyr_1.1.3            munsell_0.5.0
#> [109] viridisLite_0.4.0      bslib_0.2.5.1
```