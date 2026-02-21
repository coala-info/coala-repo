# Visualizing the structure of RNA-seq expression data using Grade of Membership Models

Kushal K Dey1, Chiaowen Joyce Hsiao2 and Matthew Stephens1,2\*

1Department of Statistics, University of Chicago
2Department of Human Genetics, University of Chicago

\*mstephens@uchicago.edu

#### *2019-01-04*

#### Abstract

Grade of membership or GoM models (also known as admixture models or “Latent Dirichlet Allocation”) are a generalization of cluster models that allow each sample to have membership in multiple clusters. It is widely used to model ancestry of individuals in population genetics based on SNP microsatellite data and also in natural language processing for modeling documents [(**???**); Pritchard2000]. This R package implements tools to visualize the clusters obtained from fitting topic models using a Structure plot (Rosenberg et al. 2002) and extract the top features/genes that distinguish the clusters. In presence of known technical or batch effects, the package also allows for correction of these confounding effects.

#### Package

CountClust 1.10.1

# Contents

* [1 Introduction](#introduction)
* [2 CountClust Installation](#countclust-installation)
* [3 Data Preparation](#data-preparation)
  + [3.1 Deng et al 2014](#deng-et-al-2014)
  + [3.2 GTEx V6 Brain](#gtex-v6-brain)
* [4 Fitting the GoM Model](#fitting-the-gom-model)
* [5 Structure plot visualization](#structure-plot-visualization)
* [6 Cluster Annotations](#cluster-annotations)
* [7 Supplementary analysis](#supplementary-analysis)
* [8 Acknowledgements](#acknowledgements)
* [9 Session Info](#session-info)
* [References](#references)

# 1 Introduction

In the context of RNA-seq expression (bulk or singlecell seq) data, the grade of membership model allows each sample (usually a tissue sample or a single cell) to have some proportion of its RNA-seq reads coming from each cluster. For typical bulk RNA-seq experiments this assumption
can be argued as follows: each tissue sample is a mixture of different cell types, and so clusters could represent cell types (which are determined by the expression patterns of the genes), and the membership of a sample in each cluster could represent the proportions of each cell type present in that sample.

Many software packages available for document clustering are applicable to modeling RNA-seq data. Here, we use the R package *[maptpx](https://CRAN.R-project.org/package%3Dmaptpx)* (Taddy - International Conference on Artificial Intelligence and and 2012 2012) to fit these models, and add functionality for visualizing the results and annotating clusters by their most distinctive genes to help biological interpretation. We also provide additional functionality to correct for batch effects and also compare the outputs from two different grade of membership model fits to the same set of samples but different in terms of feature description or model assumptions.

---

# 2 CountClust Installation

*[CountClust](https://bioconductor.org/packages/3.8/CountClust)* requires the following CRAN-R packages: *[maptpx](https://CRAN.R-project.org/package%3Dmaptpx)*, *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)*, *[cowplot](https://CRAN.R-project.org/package%3Dcowplot)*, *[parallel](https://CRAN.R-project.org/package%3Dparallel)*, *[reshape2](https://CRAN.R-project.org/package%3Dreshape2)*, *[RColorBrewer](https://CRAN.R-project.org/package%3DRColorBrewer)*, *[flexmix](https://CRAN.R-project.org/package%3Dflexmix)*,*[gtools](https://CRAN.R-project.org/package%3Dgtools)*, *[devtools](https://CRAN.R-project.org/package%3Ddevtools)* along with the Bioconductor package: *[limma](https://bioconductor.org/packages/3.8/limma)*.

Before installing , pelase install the latest version of the *[maptpx](https://CRAN.R-project.org/package%3Dmaptpx)* package on Github.

```
library(devtools)
install_github("TaddyLab/maptpx")
```

```
##
##
   checking for file ‘/tmp/RtmpGZv6Uk/remotes1d604d210a6a/TaddyLab-maptpx-089f681/DESCRIPTION’ ...

✔  checking for file ‘/tmp/RtmpGZv6Uk/remotes1d604d210a6a/TaddyLab-maptpx-089f681/DESCRIPTION’
##

─  preparing ‘maptpx’:
##

   checking DESCRIPTION meta-information ...

✔  checking DESCRIPTION meta-information
##

─  cleaning src
##

─  checking for LF line-endings in source and make files and shell scripts
##

─  checking for empty or unneeded directories
##

─  building ‘maptpx_1.9-5.tar.gz’
##

##
```

Then one can install the package from Bioc as follows

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("CountClust")
```

The development version of the *[CountClust](https://bioconductor.org/packages/3.8/CountClust)* package is available on Github, along with some data packages used in examples for this vignette.

```
install_github('kkdey/CountClust')
```

Then load the package with:

```
library(CountClust)
```

---

# 3 Data Preparation

We install data packages as `expressionSet` objects for bulk RNA-seq reads data from Brain tissue samples of human donors under GTEx (Genotype Tissue Expression) V6 Project (GTEx Consortium, 2013) (GTEx Consortium 2013 )and a singlecell RNA-seq reads data across developmental stages in mouse embryo due to Deng *et al* 2014 (Deng et al. 2014).

`Deng et al 2014` *singleCellRNASeqMouseDeng2014* data package is a processed version of the data publicly available at Gene Expression Omnibus (GEO:GSE45719)[<http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE45719>].

```
library(devtools)

read.data1 = function() {
x = tempfile()
download.file(
'https://cdn.rawgit.com/kkdey/singleCellRNASeqMouseDeng2014/master/data/Deng2014MouseEsc.rda',
destfile=x, quiet=TRUE)
z = get(load((x)))
return(z)
}

Deng2014MouseESC <- read.data1()
## Alternatively,
# install_github('kkdey/singleCellRNASeqMouseDeng2014')
```

`GTExV6Brain` The data package for GTEx V6 Brain sample data is also a processed version of the data publicly available at the [GTEx Portal](http://www.gtexportal.org/home/) (dbGaP accession phs000424.v6.p1, release date: Oct 19, 2015).

```
read.data2 = function() {
x = tempfile()
download.file(
'https://cdn.rawgit.com/kkdey/GTExV6Brain/master/data/GTExV6Brain.rda',
destfile = x, quiet=TRUE)
z = get(load((x)))
return(z)
}

GTExV6Brain <- read.data2()
## Alternatively
# install_github('kkdey/GTExV6Brain')
```

## 3.1 Deng et al 2014

Load the scRNA-seq data due to Deng *et al* 2014.

```
deng.counts <- Biobase::exprs(Deng2014MouseESC)
deng.meta_data <- Biobase::pData(Deng2014MouseESC)
deng.gene_names <- rownames(deng.counts)
```

## 3.2 GTEx V6 Brain

Load the bulk-RNA seq data from GTEx V6 brain data.

```
gtex.counts <- Biobase::exprs(GTExV6Brain)
gtex.meta_data <- Biobase::pData(GTExV6Brain)
gtex.gene_names <- rownames(gtex.counts)
```

---

# 4 Fitting the GoM Model

We use a wrapper function of the `topics()` function in the *[maptpx](https://CRAN.R-project.org/package%3Dmaptpx)* due to Matt Taddy (Taddy - International Conference on Artificial Intelligence and and 2012 2012).

As an example, we fit the topic model for `k=4` on the GTEx V6 Brain data and save the GoM model output file to user-defined directory.

```
FitGoM(t(gtex.counts),
            K=4, tol=1,
            path_rda="../data/GTExV6Brain.FitGoM.rda")
```

One can also input a vector of clusters under `nclus_vec` as we do for a list of cluster numbers from \(2\) to \(7\) for Deng *et al* 2014 data.

```
FitGoM(t(deng.counts),
            K=2:7, tol=0.1,
            path_rda="../data/MouseDeng2014.FitGoM.rda")
```

---

# 5 Structure plot visualization

Now we perform the visualization for `k=6` for the Deng *et al* 2014 data.

We load the GoM fit for `k=6`.

```
data("MouseDeng2014.FitGoM")
names(MouseDeng2014.FitGoM$clust_6)
```

```
## [1] "K"     "theta" "omega" "BF"    "D"
```

```
omega <- MouseDeng2014.FitGoM$clust_6$omega
```

We prepare the annotations for the visualization.

```
annotation <- data.frame(
  sample_id = paste0("X", c(1:NROW(omega))),
  tissue_label = factor(rownames(omega),
                        levels = rev( c("zy", "early2cell",
                                        "mid2cell", "late2cell",
                                        "4cell", "8cell", "16cell",
                                        "earlyblast","midblast",
                                         "lateblast") ) ) )

rownames(omega) <- annotation$sample_id;
```

Now we perform the visualization.

```
StructureGGplot(omega = omega,
                annotation = annotation,
                palette = RColorBrewer::brewer.pal(8, "Accent"),
                yaxis_label = "Development Phase",
                order_sample = TRUE,
                axis_tick = list(axis_ticks_length = .1,
                                 axis_ticks_lwd_y = .1,
                                 axis_ticks_lwd_x = .1,
                                 axis_label_size = 7,
                                 axis_label_face = "bold"))
```

![](data:image/png;base64...)

In the above plot, the samples in each batch have been sorted by the proportional memebership of the most representative cluster in that batch. One can also use `order_sample=FALSE` for the un-ordered version, which retains the order as in the data (see Supplementary analysis for example).

Now we perform the Structure plot visualization for `k=4` for GTEx V6 data for Brain samples .

We load the GoM fit for `k=4`.

```
data("GTExV6Brain.FitGoM")
omega <- GTExV6Brain.FitGoM$omega;
dim(omega)
```

```
## [1] 1259    4
```

```
colnames(omega) <- c(1:NCOL(omega))
```

We now prepare the annotations for visualization GTEx brain tissue results.

```
tissue_labels <- gtex.meta_data[,3];

annotation <- data.frame(
    sample_id = paste0("X", 1:length(tissue_labels)),
    tissue_label = factor(tissue_labels,
                          levels = rev(unique(tissue_labels) ) ) );

cols <- c("blue", "darkgoldenrod1", "cyan", "red")
```

Now we perform the visualization.

```
StructureGGplot(omega = omega,
                annotation= annotation,
                palette = cols,
                yaxis_label = "",
                order_sample = TRUE,
                split_line = list(split_lwd = .4,
                                  split_col = "white"),
                axis_tick = list(axis_ticks_length = .1,
                                 axis_ticks_lwd_y = .1,
                                 axis_ticks_lwd_x = .1,
                                 axis_label_size = 7,
                                 axis_label_face = "bold"))
```

![](data:image/png;base64...)

---

# 6 Cluster Annotations

We extract the top genes driving each cluster using the `ExtractTopFeatures` functionality of the *[CountClust](https://bioconductor.org/packages/3.8/CountClust)* package. We first perform the cluster annotations from the GoM model fit with $k=6` on the single cell RNA-seq data due to Deng *et al*.

```
data("MouseDeng2014.FitGoM")
theta_mat <- MouseDeng2014.FitGoM$clust_6$theta;
top_features <- ExtractTopFeatures(theta_mat, top_features=100,
                                   method="poisson", options="min");
gene_list <- do.call(rbind, lapply(1:dim(top_features$indices)[1],
                        function(x) deng.gene_names[top_features$indices[x,]]))
```

We tabulate the top \(5\) genes for these \(6\) clusters.

```
tmp <- do.call(rbind, lapply(1:5, function(i) toString(gene_list[,i])))
rownames(tmp) <- paste("Cluster", c(1:5))
tmp %>%
  kable("html") %>%
  kable_styling()
```

|  |  |
| --- | --- |
| Cluster 1 | Timd2, Upp1, Actb, Rtn2, LOC100502936, Obox3 |
| Cluster 2 | Isyna1, Tdgf1, Krt18, Ebna1bp2, Bcl2l10, Zfp352 |
| Cluster 3 | Alppl2, Aqp8, Fabp3, Zfp259, Tcl1, Gm8300 |
| Cluster 4 | Pramel5, Fabp5, Id2, Nasp, E330034G19Rik, Usp17l5 |
| Cluster 5 | Hsp90ab1, Tat, Tspan8, Cenpe, Oas1d, BB287469 |

We next perform the same for the topic model fit on the GTEx V6 Brain samples data with `k=4` clusters.

```
data("GTExV6Brain.FitGoM")
theta_mat <- GTExV6Brain.FitGoM$theta;
top_features <- ExtractTopFeatures(theta_mat, top_features=100,
                                   method="poisson", options="min");
gene_list <- do.call(rbind, lapply(1:dim(top_features$indices)[1],
                        function(x) gtex.gene_names[top_features$indices[x,]]))
```

The top \(3\) genes (ensemble IDs) driving these \(4\) clusters.

```
tmp <- do.call(rbind, lapply(1:3, function(i) toString(gene_list[,i])))
rownames(tmp) <- paste("Cluster", c(1:3))
tmp %>%
  kable("html") %>%
  kable_styling()
```

|  |  |
| --- | --- |
| Cluster 1 | ENSG00000120885.15, ENSG00000171617.9, ENSG00000112139.10, ENSG00000197971.10 |
| Cluster 2 | ENSG00000130203.5, ENSG00000160014.12, ENSG00000139899.6, ENSG00000266844.1 |
| Cluster 3 | ENSG00000131771.9, ENSG00000154146.8, ENSG00000008710.13, ENSG00000237973.1 |

---

# 7 Supplementary analysis

As an additional analysis, we apply the *[CountClust](https://bioconductor.org/packages/3.8/CountClust)* tools on another single-cell RNA-seq data from mouse spleen due to Jaitin *et al* 2014 (Jaitin et al. 2014). The data had technical effects in the form of `amplification batch` which the user may want to correct for.

We first install and load the data.

```
read.data3 = function() {
x = tempfile()
download.file(
'https://cdn.rawgit.com/jhsiao999/singleCellRNASeqMouseJaitinSpleen/master/data/MouseJaitinSpleen.rda',
destfile = x, quiet=TRUE)
z = get(load((x)))
return(z)
}

MouseJaitinSpleen <- read.data3()
## Alternatively
# devtools::install_github('jhsiao999/singleCellRNASeqMouseJaitinSpleen')
```

```
jaitin.counts <- Biobase::exprs(MouseJaitinSpleen)
jaitin.meta_data <- Biobase::pData(MouseJaitinSpleen)
jaitin.gene_names <- rownames(jaitin.counts)
```

Extracting the non-ERCC genes satisfying some quality measures.

```
ENSG_genes_index <- grep("ERCC", jaitin.gene_names, invert = TRUE)
jaitin.counts_ensg <- jaitin.counts[ENSG_genes_index, ]
filter_genes <- c("M34473","abParts","M13680","Tmsb4x",
                  "S100a4","B2m","Atpase6","Rpl23","Rps18",
                  "Rpl13","Rps19","H2-Ab1","Rplp1","Rpl4",
                  "Rps26","EF437368")
fcounts <- jaitin.counts_ensg[ -match(filter_genes, rownames(jaitin.counts_ensg)), ]
sample_counts <- colSums(fcounts)

filter_sample_index <- which(jaitin.meta_data$number_of_cells == 1 &
                              jaitin.meta_data$group_name == "CD11c+" &
                                 sample_counts > 600)
fcounts.filtered <- fcounts[,filter_sample_index];
```

We filter the metadata likewise.

```
jaitin.meta_data_filtered <- jaitin.meta_data[filter_sample_index, ]
```

We fit the GoM model for `k=7` and plot the Structure plot visualization to show that the amplification batch indeed drives the clustering patterns.

```
StructureObj(t(fcounts),
            nclus_vec=7, tol=0.1,
             path_rda="../data/MouseJaitinSpleen.FitGoM.rda")
```

Load results of completed analysis.

```
data("MouseJaitinSpleen.FitGoM")
names(MouseJaitinSpleen.FitGoM$clust_7)
```

```
## [1] "K"     "theta" "omega" "BF"    "D"     "X"
```

```
omega <- MouseJaitinSpleen.FitGoM$clust_7$omega

amp_batch <- as.numeric(jaitin.meta_data_filtered[ , "amplification_batch"])
annotation <- data.frame(
    sample_id = paste0("X", c(1:NROW(omega)) ),
    tissue_label = factor(amp_batch,
                          levels = rev(sort(unique(amp_batch))) ) )
```

Visualize the sample expression profile.

```
StructureGGplot(omega = omega,
                annotation = annotation,
                palette = RColorBrewer::brewer.pal(9, "Set1"),
                yaxis_label = "Amplification batch",
                order_sample = FALSE,
                axis_tick = list(axis_ticks_length = .1,
                                 axis_ticks_lwd_y = .1,
                                 axis_ticks_lwd_x = .1,
                                 axis_label_size = 7,
                                 axis_label_face = "bold"))
```

![](data:image/png;base64...)

It seems from the above Structure plot that `amplification batch` drives the clusters. To remove the effect of amplification batch, one can use. For this, we use the `BatchCorrectedCounts()` functionality of the package.

```
batchcorrect.fcounts <- BatchCorrectedCounts(t(fcounts.filtered),
                                          amp_batch, use_parallel = FALSE);
dim(batchcorrect.fcounts)
```

---

# 8 Acknowledgements

We would like to thank Deng *et al* and the GTEx Consortium for having making the data publicly available. We would like to thank Matt Taddy, Amos Tanay, Po Yuan Tung and Raman Shah for helpful discussions related to the project and the package.

---

# 9 Session Info

```
sessionInfo()
```

```
## R version 3.5.2 (2018-12-20)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] CountClust_1.10.1 ggplot2_3.1.0     usethis_1.4.0     devtools_2.0.1
## [5] kableExtra_0.9.0  knitr_1.21        BiocStyle_2.10.0
##
## loaded via a namespace (and not attached):
##  [1] maptpx_1.9-5        nlme_3.1-137        fs_1.2.6
##  [4] RColorBrewer_1.1-2  httr_1.4.0          rprojroot_1.3-2
##  [7] tools_3.5.2         backports_1.1.3     R6_2.3.0
## [10] vegan_2.5-3         lazyeval_0.2.1      BiocGenerics_0.28.0
## [13] mgcv_1.8-26         colorspace_1.3-2    permute_0.9-4
## [16] nnet_7.3-12         withr_2.1.2         tidyselect_0.2.5
## [19] prettyunits_1.0.2   processx_3.2.1      curl_3.2
## [22] compiler_3.5.2      cli_1.0.1           rvest_0.3.2
## [25] Biobase_2.42.0      xml2_1.2.0          desc_1.2.0
## [28] bookdown_0.9        slam_0.1-44         scales_1.0.0
## [31] SQUAREM_2017.10-1   readr_1.3.1         callr_3.1.1
## [34] stringr_1.3.1       digest_0.6.18       rmarkdown_1.11
## [37] pkgconfig_2.0.2     htmltools_0.3.6     sessioninfo_1.1.1
## [40] limma_3.38.3        highr_0.7           rlang_0.3.0.1
## [43] rstudioapi_0.8      bindr_0.1.1         gtools_3.8.1
## [46] dplyr_0.7.8         magrittr_1.5        modeltools_0.2-22
## [49] Matrix_1.2-15       Rcpp_1.0.0          munsell_0.5.0
## [52] ape_5.2             stringi_1.2.4       yaml_2.2.0
## [55] MASS_7.3-51.1       flexmix_2.3-14      pkgbuild_1.0.2
## [58] plyr_1.8.4          grid_3.5.2          parallel_3.5.2
## [61] crayon_1.3.4        lattice_0.20-38     cowplot_0.9.3
## [64] hms_0.4.2           ps_1.3.0            pillar_1.3.1
## [67] boot_1.3-20         reshape2_1.4.3      stats4_3.5.2
## [70] pkgload_1.0.2       picante_1.7         glue_1.3.0
## [73] evaluate_0.12       remotes_2.0.2       BiocManager_1.30.4
## [76] testthat_2.0.1      gtable_0.2.0        purrr_0.2.5
## [79] assertthat_0.2.0    xfun_0.4            viridisLite_0.3.0
## [82] tibble_2.0.0        memoise_1.1.0       bindrcpp_0.2.2
## [85] cluster_2.0.7-1
```

---

# References

Deng, Qiaolin, Daniel Ramsköld, Björn Reinius, and Rickard Sandberg. 2014. “Single-Cell RNA-seq Reveals Dynamic, Random Monoallelic Gene Expression in Mammalian Cells.” *Science* 343 (6167):193–96.

GTEx Consortium. 2013. “The Genotype-Tissue Expression (GTEx) Project.” *Nat. Genet.* 45 (6):580–85.

Jaitin, Diego Adhemar, Ephraim Kenigsberg, Hadas Keren-Shaul, Naama Elefant, Franziska Paul, Irina Zaretsky, Alexander Mildner, et al. 2014. “Massively Parallel Single-Cell RNA-seq for Marker-Free Decomposition of Tissues into Cell Types.” *Science* 343 (6172):776–79.

Rosenberg, Noah A, Jonathan K Pritchard, James L Weber, Howard M Cann, Kenneth K Kidd, Lev A Zhivotovsky, and Marcus W Feldman. 2002. “Genetic Structure of Human Populations.” *Science* 298 (5602):2381–5.

Taddy - International Conference on Artificial Intelligence and, M, and 2012. 2012. “On Estimation and Selection for Topic Models.” *Jmlr.org*.