# Gene regulatory network inference

Fabricio Almeida-Silva1 and Thiago Motta Venancio1

1Universidade Estadual do Norte Fluminense Darcy Ribeiro, RJ, Brazil

#### 29 October 2025

# Contents

* [1 Installation](#installation)
* [2 Introduction and algorithm description](#introduction-and-algorithm-description)
* [3 Data preprocessing](#data-preprocessing)
* [4 Gene regulatory network inference](#gene-regulatory-network-inference)
  + [4.1 Consensus GRN inference](#consensus-grn-inference)
  + [4.2 Algorithm-specific GRN inference](#algorithm-specific-grn-inference)
* [5 Gene regulatory network analysis](#gene-regulatory-network-analysis)
  + [5.1 Hub gene identification](#hub-gene-identification)
  + [5.2 Network visualization](#network-visualization)
* [Session information](#session-information)
* [References](#references)

# 1 Installation

```
if(!requireNamespace('BiocManager', quietly = TRUE))
  install.packages('BiocManager')

BiocManager::install("BioNERO")
```

```
# Load package after installation
library(BioNERO)
set.seed(123) # for reproducibility
```

# 2 Introduction and algorithm description

In the previous vignette, we explored all aspects of gene coexpression
networks (GCNs), which are represented as **undirected weighted graphs**. It
is **undirected** because, for a given link between *gene A* and *gene B*, we
can only say that these genes are coexpressed, but we cannot know
whether *gene A* controls *gene B* or otherwise. Further, **weighted** means
that some coexpression relationships between gene pairs are stronger than
others. In this vignette, we will demonstrate how to infer gene regulatory
networks (GRNs) from expression data with BioNERO. GRNs display interactions
between regulators (e.g., transcription factors or miRNAs) and their targets
(e.g., genes). Hence, they are represented as **directed unweighted graphs**.

Numerous algorithms have been developed to infer GRNs from expression data.
However, the algorithm performances are highly dependent on the benchmark
data set. To solve this uncertainty, Marbach et al. ([2012](#ref-Marbach2012)) proposed the application
of the *“wisdom of the crowds”* principle to GRN inference. This approach
consists in inferring GRNs with different algorithms, ranking the interactions
identified by each method, and calculating the average rank for each
interaction across all algorithms used. This way, we can have consensus,
high-confidence edges to be used in biological interpretations.
For that, `BioNERO` implements three popular algorithms:
GENIE3 (Huynh-Thu et al. [2010](#ref-Huynh-Thu2010)), ARACNE (Margolin et al. [2006](#ref-Margolin2006)) and CLR (Faith et al. [2007](#ref-Faith2007)).

# 3 Data preprocessing

Before inferring the GRN, we will preprocess the expression data the
same way we did in the previous vignette.

```
# Load example data set
data(zma.se)

# Preprocess the expression data
final_exp <- exp_preprocess(
    zma.se,
    min_exp = 10,
    variance_filter = TRUE,
    n = 2000
)
## Number of removed samples: 1
```

# 4 Gene regulatory network inference

`BioNERO` requires only 2 objects for GRN inference: the **expression data**
(SummarizedExperiment, matrix or data frame) and a character vector
of **regulators** (transcription factors or miRNAs). The transcription factors
used in this vignette were downloaded from PlantTFDB 4.0 (Jin et al. [2017](#ref-Jin2017)).

```
data(zma.tfs)
head(zma.tfs)
##              Gene Family
## 6  Zm00001d022525    Dof
## 25 Zm00001d037605   GATA
## 28 Zm00001d049540    NAC
## 45 Zm00001d042287    MYB
## 46 Zm00001d042288    NAC
## 54 Zm00001d039371    TCP
```

## 4.1 Consensus GRN inference

Inferring GRNs based on the *wisdom of the crowds* principle can be done with
a single function: `exp2grn()`. This function will infer GRNs with GENIE3,
ARACNE and CLR, calculate average ranks for each interaction and filter the
resulting network based on the optimal scale-free topology (SFT) fit. In the
filtering step, *n* different networks are created by subsetting the top *n*
quantiles. For instance, if a network of 10,000 edges is given as input
with `nsplit = 10`, 10 different networks will be created: the first
with 1,000 edges, the second with 2,000 edges, and so on, with the last
network being the original input network. Then, for each network, the function
will calculate the SFT fit and select the best fit.

```
# Using 10 trees for demonstration purposes. Use the default: 1000
grn <- exp2grn(
    exp = final_exp,
    regulators = zma.tfs$Gene,
    nTrees = 10
)
## The top number of edges that best fits the scale-free topology is 247
head(grn)
##          Regulator         Target
## 290 Zm00001d041474 Zm00001d018986
## 280 Zm00001d041474 Zm00001d006602
## 281 Zm00001d041474 Zm00001d006942
## 325 Zm00001d044315 Zm00001d043497
## 65  Zm00001d013777 Zm00001d046996
## 252 Zm00001d038832 Zm00001d021147
```

## 4.2 Algorithm-specific GRN inference

This section is directed to users who, for some reason
(e.g., comparison, exploration), want to infer GRNs with particular algorithms.
The available algorithms are:

**GENIE3:** a regression-tree based algorithm that decomposes the
prediction of GRNs for *n* genes into *n* regression problems. For each
regression problem, the expression profile of a target gene is predicted
from the expression profiles of all other genes using random forests (default)
or extra-trees.

```
# Using 10 trees for demonstration purposes. Use the default: 1000
genie3 <- grn_infer(
    final_exp,
    method = "genie3",
    regulators = zma.tfs$Gene,
    nTrees = 10)
head(genie3)
##                Node1          Node2    Weight
## 20352 Zm00001d041474 Zm00001d017881 0.5439514
## 41340 Zm00001d034751 Zm00001d037111 0.5322394
## 13037 Zm00001d034751 Zm00001d012407 0.4348469
## 13207 Zm00001d045323 Zm00001d012513 0.4203583
## 55378 Zm00001d028432 Zm00001d048693 0.4071160
## 50200 Zm00001d013777 Zm00001d044212 0.3957483
dim(genie3)
## [1] 60136     3
```

**ARACNE:** information-theoretic algorithm that aims to remove indirect
interactions inferred by coexpression.

```
aracne <- grn_infer(final_exp, method = "aracne", regulators = zma.tfs$Gene)
head(aracne)
##                Node1          Node2   Weight
## 23861 Zm00001d038832 Zm00001d021147 1.789818
## 1758  Zm00001d038832 Zm00001d000432 1.692232
## 11337 Zm00001d038832 Zm00001d011086 1.692232
## 27014 Zm00001d011139 Zm00001d024274 1.674840
## 51070 Zm00001d011139 Zm00001d045069 1.658043
## 28387 Zm00001d038832 Zm00001d025784 1.641802
dim(aracne)
## [1] 411   3
```

**CLR:** extension of the relevance networks algorithm that uses mutual
information to identify regulatory interactions.

```
clr <- grn_infer(final_exp, method = "clr", regulators = zma.tfs$Gene)
head(clr)
##                Node1          Node2   Weight
## 26302 Zm00001d046937 Zm00001d023376 12.70216
## 11267 Zm00001d046937 Zm00001d011080 12.25336
## 12540 Zm00001d041474 Zm00001d012007 10.74023
## 51019 Zm00001d042263 Zm00001d045042 10.50925
## 17810 Zm00001d041474 Zm00001d015811 10.33216
## 29278 Zm00001d046937 Zm00001d026632 10.20075
dim(clr)
## [1] 26657     3
```

Users can also infer GRNs with the 3 algorithms at once using the
function `exp_combined()`. The resulting edge lists are stored in a list
of 3 elements.111 **NOTE:** Under the hood, `exp2grn()` uses `exp_combined()` followed
by averaging ranks with `grn_average_rank()` and filtering with `grn_filter()`.

```
grn_list <- grn_combined(final_exp, regulators = zma.tfs$Gene, nTrees = 10)
head(grn_list$genie3)
##                Node1          Node2    Weight
## 12013 Zm00001d041474 Zm00001d011541 0.4629469
## 30418 Zm00001d046568 Zm00001d027841 0.4289222
## 33403 Zm00001d041474 Zm00001d030748 0.4140894
## 6910  Zm00001d044315 Zm00001d006725 0.4103733
## 22057 Zm00001d041474 Zm00001d018986 0.4020641
## 45153 Zm00001d034751 Zm00001d039733 0.3935705
head(grn_list$aracne)
##                Node1          Node2   Weight
## 23861 Zm00001d038832 Zm00001d021147 1.789818
## 1758  Zm00001d038832 Zm00001d000432 1.692232
## 11337 Zm00001d038832 Zm00001d011086 1.692232
## 27014 Zm00001d011139 Zm00001d024274 1.674840
## 51070 Zm00001d011139 Zm00001d045069 1.658043
## 28387 Zm00001d038832 Zm00001d025784 1.641802
head(grn_list$clr)
##                Node1          Node2   Weight
## 26302 Zm00001d046937 Zm00001d023376 12.70216
## 11267 Zm00001d046937 Zm00001d011080 12.25336
## 12540 Zm00001d041474 Zm00001d012007 10.74023
## 51019 Zm00001d042263 Zm00001d045042 10.50925
## 17810 Zm00001d041474 Zm00001d015811 10.33216
## 29278 Zm00001d046937 Zm00001d026632 10.20075
```

# 5 Gene regulatory network analysis

After inferring the GRN, `BioNERO` allows users to perform some common
downstream analyses.

## 5.1 Hub gene identification

GRN hubs are defined as the top 10% most highly connected regulators, but
this percentile is flexible in `BioNERO`.222 **NOTE:** Remember: GRNs are represented as **directed** graphs.
This implies that only regulators are taken into account when identifying
hubs. The goal here is to identify regulators (e.g., transcription factors)
that control the expression of several genes. They can be identified
with `get_hubs_grn()`.

```
hubs <- get_hubs_grn(grn)
hubs
##              Gene Degree
## 1  Zm00001d038832     16
## 2  Zm00001d041474     13
## 3  Zm00001d046937     13
## 4  Zm00001d011139     12
## 5  Zm00001d052229     11
## 6  Zm00001d013777     10
## 7  Zm00001d039989     10
## 8  Zm00001d038227     10
## 9  Zm00001d030617     10
## 10 Zm00001d044315      9
## 11 Zm00001d003822      9
## 12 Zm00001d020020      9
## 13 Zm00001d046568      9
## 14 Zm00001d010227      9
## 15 Zm00001d025339      8
## 16 Zm00001d028974      8
## 17 Zm00001d042267      7
## 18 Zm00001d014377      7
## 19 Zm00001d054038      6
## 20 Zm00001d042263      6
## 21 Zm00001d035440      6
## 22 Zm00001d036148      6
## 23 Zm00001d031655      6
## 24 Zm00001d034751      6
## 25 Zm00001d018081      6
## 26 Zm00001d027957      5
```

## 5.2 Network visualization

```
plot_grn(grn)
```

![](data:image/png;base64...)

GRNs can also be visualized interactively for exploratory purposes.

```
plot_grn(grn, interactive = TRUE, dim_interactive = c(500,500))
```

Finally, `BioNERO` can also be used for visualization and hub identification
in protein-protein (PPI) interaction networks. The functions `get_hubs_ppi()`
and `plot_ppi()` work the same way as their equivalents for
GRNs (`get_hubs_grn()` and `plot_grn()`).

# Session information

This vignette was created under the following conditions:

```
sessionInfo()
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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] BioNERO_1.18.0   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          ggdendro_0.2.0
##   [3] rstudioapi_0.17.1           jsonlite_2.0.0
##   [5] shape_1.4.6.1               NetRep_1.2.9
##   [7] magrittr_2.0.4              magick_2.9.0
##   [9] farver_2.1.2                rmarkdown_2.30
##  [11] GlobalOptions_0.1.2         vctrs_0.6.5
##  [13] Cairo_1.7-0                 memoise_2.0.1
##  [15] base64enc_0.1-3             htmltools_0.5.8.1
##  [17] S4Arrays_1.10.0             dynamicTreeCut_1.63-1
##  [19] SparseArray_1.10.0          Formula_1.2-5
##  [21] sass_0.4.10                 bslib_0.9.0
##  [23] htmlwidgets_1.6.4           plyr_1.8.9
##  [25] impute_1.84.0               cachem_1.1.0
##  [27] networkD3_0.4.1             igraph_2.2.1
##  [29] lifecycle_1.0.4             ggnetwork_0.5.14
##  [31] iterators_1.0.14            pkgconfig_2.0.3
##  [33] Matrix_1.7-4                R6_2.6.1
##  [35] fastmap_1.2.0               MatrixGenerics_1.22.0
##  [37] clue_0.3-66                 digest_0.6.37
##  [39] colorspace_2.1-2            patchwork_1.3.2
##  [41] AnnotationDbi_1.72.0        S4Vectors_0.48.0
##  [43] GENIE3_1.32.0               Hmisc_5.2-4
##  [45] GenomicRanges_1.62.0        RSQLite_2.4.3
##  [47] labeling_0.4.3              mgcv_1.9-3
##  [49] httr_1.4.7                  abind_1.4-8
##  [51] compiler_4.5.1              withr_3.0.2
##  [53] bit64_4.6.0-1               doParallel_1.0.17
##  [55] htmlTable_2.4.3             S7_0.2.0
##  [57] backports_1.5.0             BiocParallel_1.44.0
##  [59] DBI_1.2.3                   intergraph_2.0-4
##  [61] MASS_7.3-65                 DelayedArray_0.36.0
##  [63] rjson_0.2.23                tools_4.5.1
##  [65] foreign_0.8-90              nnet_7.3-20
##  [67] glue_1.8.0                  nlme_3.1-168
##  [69] grid_4.5.1                  checkmate_2.3.3
##  [71] cluster_2.1.8.1             reshape2_1.4.4
##  [73] generics_0.1.4              sva_3.58.0
##  [75] gtable_0.3.6                preprocessCore_1.72.0
##  [77] sna_2.8                     data.table_1.17.8
##  [79] WGCNA_1.73                  XVector_0.50.0
##  [81] BiocGenerics_0.56.0         ggrepel_0.9.6
##  [83] foreach_1.5.2               pillar_1.11.1
##  [85] stringr_1.5.2               limma_3.66.0
##  [87] genefilter_1.92.0           circlize_0.4.16
##  [89] splines_4.5.1               dplyr_1.1.4
##  [91] lattice_0.22-7              survival_3.8-3
##  [93] bit_4.6.0                   annotate_1.88.0
##  [95] tidyselect_1.2.1            locfit_1.5-9.12
##  [97] GO.db_3.22.0                ComplexHeatmap_2.26.0
##  [99] Biostrings_2.78.0           knitr_1.50
## [101] gridExtra_2.3               bookdown_0.45
## [103] IRanges_2.44.0              Seqinfo_1.0.0
## [105] edgeR_4.8.0                 SummarizedExperiment_1.40.0
## [107] RhpcBLASctl_0.23-42         stats4_4.5.1
## [109] xfun_0.53                   Biobase_2.70.0
## [111] statmod_1.5.1               matrixStats_1.5.0
## [113] stringi_1.8.7               statnet.common_4.12.0
## [115] yaml_2.3.10                 minet_3.68.0
## [117] evaluate_1.0.5              codetools_0.2-20
## [119] data.tree_1.2.0             tibble_3.3.0
## [121] BiocManager_1.30.26         cli_3.6.5
## [123] rpart_4.1.24                xtable_1.8-4
## [125] jquerylib_0.1.4             network_1.19.0
## [127] dichromat_2.0-0.1           Rcpp_1.1.0
## [129] coda_0.19-4.1               png_0.1-8
## [131] fastcluster_1.3.0           XML_3.99-0.19
## [133] parallel_4.5.1              ggplot2_4.0.0
## [135] blob_1.2.4                  scales_1.4.0
## [137] crayon_1.5.3                GetoptLong_1.0.5
## [139] rlang_1.1.6                 KEGGREST_1.50.0
```

# References

Faith, Jeremiah J., Boris Hayete, Joshua T. Thaden, Ilaria Mogno, Jamey Wierzbowski, Guillaume Cottarel, Simon Kasif, James J. Collins, and Timothy S. Gardner. 2007. “Large-scale mapping and validation of Escherichia coli transcriptional regulation from a compendium of expression profiles.” *PLoS Biology* 5 (1): 0054–0066. <https://doi.org/10.1371/journal.pbio.0050008>.

Huynh-Thu, Vân Anh, Alexandre Irrthum, Louis Wehenkel, and Pierre Geurts. 2010. “Inferring regulatory networks from expression data using tree-based methods.” *PLoS ONE* 5 (9): 1–10. <https://doi.org/10.1371/journal.pone.0012776>.

Jin, J, F Tian, D C Yang, Y Q Meng, L Kong, J Luo, and G Gao. 2017. “PlantTFDB 4.0: toward a central hub for transcription factors and regulatory interactions in plants.” *Nucleic Acids Res* 45 (D1): D1040–D1045. <https://doi.org/10.1093/nar/gkw982>.

Marbach, Daniel, James C. Costello, Robert Küffner, Nicole M. Vega, Robert J. Prill, Diogo M. Camacho, Kyle R. Allison, et al. 2012. “Wisdom of crowds for robust gene network inference.” *Nature Methods* 9 (8): 796–804. <https://doi.org/10.1038/nmeth.2016>.

Margolin, Adam A., Ilya Nemenman, Katia Basso, Chris Wiggins, Gustavo Stolovitzky, Riccardo Dalla Favera, and Andrea Califano. 2006. “ARACNE: An algorithm for the reconstruction of gene regulatory networks in a mammalian cellular context.” *BMC Bioinformatics* 7 (SUPPL.1): 1–15. <https://doi.org/10.1186/1471-2105-7-S1-S7>.