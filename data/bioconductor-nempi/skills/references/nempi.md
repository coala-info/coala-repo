# Nested Effects Models-based perturbation inference: Inference of unobserved perturbations from gene expression profiles.

Martin Pirkl, Niko Beerenwinkel

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Installation and loading](#installation-and-loading)
* [3 Small example](#small-example)
  + [3.1 Data simulation](#data-simulation)
  + [3.2 Perturbation inference](#perturbation-inference)
  + [3.3 Prior matrix](#prior-matrix)
  + [3.4 Final perturbation matrix](#final-perturbation-matrix)
* [4 Session information](#session-information)
* [5 References:](#references)
* **Appendix**

# 1 Introduction

If many genes are perturbed in a population of cells, this can lead to
diseases like cancer. The perturbations can happen in different ways,
e.g. via mutations, copy number abberations or methylation. However,
not all perturbations are observed in all samples.

Nested Effects Model-based perturbation inference (NEM\(\pi\)) uses
observed perturbation profiles and gene expression data to infer
unobserved perturbations and augment observed ones. The causal
network of the perturbed genes
(P-genes) is modelled as an adjacency matrix \(\phi\) and the genes with
observed gene expression (E-genes) are modelled with the attachment
\(\theta\) with \(\theta\_{ij}=1\), if E-gene \(j\) is attached to
S-gene \(i\). If E-gene \(j\) is attached to P-gene \(i\), \(j\) shows an effect
for a perturbation of P-gene \(i\). Hence, \(\phi\theta\) predicts gene
expression profiles, which can be compared to the real
data. NEM\(\pi\) iteratively infers a network \(\phi\) based on
gene expression profiles and a perturbation profile, and the
perturbation profile based on a network \(\phi\).

# 2 Installation and loading

Use devtools to install the latest version from github or use the
BiocManahger to install the package from bioconductor.

```
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("nempi")
```

Load the package with the library function.

```
library(nempi)
```

# 3 Small example

We look at a small example for which we first simulate data and then
infer the unobserved perturbations. We draw a random network for the
perturbed genes (P-genes). Then we simulate gene expression for each
sample given the subset of P-genes that has been perturbed in the
sample. E.g., if P-gene A is upstream of P-gene B and P-gene A has
been perturbed, all E-genes attached to B also show an effect.

## 3.1 Data simulation

```
library(mnem)
seed <- 8675309
Pgenes <- 10
Egenes <- 5
samples <- 100
edgeprob <- 0.5
uninform <- floor((Pgenes * Egenes) * 0.1)
Nems <- mw <- 1
noise <- 1
multi <- c(0.2, 0.1)
set.seed(seed)
simmini <- simData(Sgenes = Pgenes, Egenes = Egenes, Nems = Nems, mw = mw, nCells = samples,
    uninform = uninform, multi = multi, badCells = floor(samples * 0.1), edgeprob = edgeprob)
data <- simmini$data
ones <- which(data == 1)
zeros <- which(data == 0)
data[ones] <- rnorm(length(ones), 1, noise)
data[zeros] <- rnorm(length(zeros), -1, noise)
epiNEM::HeatmapOP(data, col = "RdBu", cexRow = 0.75, cexCol = 0.75, bordercol = "transparent",
    xrot = 0, dendrogram = "both")
```

![Heatmap of the simulated log odds. Effects are blue and no effects are red. Rows denote the observed E-genes and columns the samples annoted by P-genes. Each P-gene has been perturbed in many cells. The E-genes are annotated as how they are attached in the ground truth. E.g. E-genes named '1' are attached to S-gene '1' in the ground truth.](data:image/png;base64...)

Figure 1: Heatmap of the simulated log odds
Effects are blue and no effects
are red. Rows denote the observed E-genes and columns the samples annoted by
P-genes. Each P-gene
has been perturbed in many cells. The E-genes are annotated as how they are
attached in the ground truth. E.g. E-genes named ‘1’ are attached to S-gene
‘1’ in the ground truth.

The typical data input for NEM\(\pi\) consists of a data matrix with
samples as columns and E-genes as rows. The
columns are either labeled by their perturbed gene(s)
or unlabeled (default: ""). After the data
simulation all samples are labeled. We unlabel \(50\%\)
of the sample and pretend we do not know, which P-gene
has been perturbed.

```
lost <- sample(1:ncol(data), floor(ncol(data) * 0.5))
colnames(data)[lost] <- ""
```

## 3.2 Perturbation inference

We use NEM\(\pi\) and other methods to infer the perturbations. We
use the area under the precision-recall curve as the two measures of
accuracy. We also plot the NEM\(\pi\) result.

```
res <- nempi(data)
fit <- pifit(res, simmini, data)
print(fit$auc)
```

```
## [1] 0.7788576
```

```
ressvm <- classpi(data)
fit <- pifit(ressvm, simmini, data, propagate = FALSE)
print(fit$auc)
```

```
## [1] 0.7090377
```

```
resnn <- classpi(data, method = "nnet")
fit <- pifit(resnn, simmini, data, propagate = FALSE)
print(fit$auc)
```

```
## [1] 0.6273228
```

```
resrf <- classpi(data, method = "randomForest")
fit <- pifit(resrf, simmini, data, propagate = FALSE)
print(fit$auc)
```

```
## [1] 0.6987766
```

```
col <- rgb(seq(0, 1, length.out = 10), seq(1, 0, length.out = 10), seq(1, 0, length.out = 10))
plot(res, heatlist = list(col = "RdBu"), barlist = list(col = col))
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

Compared to support vector machines (svm), neural nets (nnet) and
random forest (rf) class prediction, NEM\(\pi\) achieves a higher
accuracy.

Note that NEM\(\pi\) is in general more powerful, if the P-genes are
connected in a denser network. The other methods perform equally well
for sparse or even disconnected network \(\phi\). However, they usually
profit from combinatorial perturbations.

## 3.3 Prior matrix

Alternatively, we can also provide NEM\(\pi\) with a probabilistic
perturbation matrix \(\Gamma\) as a prior. In the rows are the potentially
perturbed
genes and in the columns are the samples. The entries are between \(0\)
and \(1\), with the sum of all entries of a sample summing to \(1\).

```
Gamma <- matrix(0, Pgenes, ncol(data))
rownames(Gamma) <- seq_len(Pgenes)
colnames(Gamma) <- colnames(data)
for (i in seq_len(Pgenes)) {
    Gamma[i, grep(paste0("^", i, "_|_", i, "$|_", i, "_|^", i, "$"), colnames(data))] <- 1
}
Gamma <- apply(Gamma, 2, function(x) return(x/sum(x)))
Gamma[is.na(Gamma)] <- 0

epiNEM::HeatmapOP(Gamma, col = "RdBu", cexRow = 0.75, cexCol = 0.75, bordercol = "transparent",
    xrot = 0, dendrogram = "both")
```

![Heatmap of the probabilsitic perturbation matrix.](data:image/png;base64...)

Figure 2: Heatmap of the probabilsitic perturbation matrix

```
colnames(data) <- sample(seq_len(Pgenes), ncol(data), replace = TRUE)
res <- nempi(data, Gamma = Gamma)

fit <- pifit(res, simmini, data)
print(fit$auc)
```

```
## [1] 0.7788576
```

## 3.4 Final perturbation matrix

The final perturbation matrix \(\Omega\) over all samples is slightly
different from the matrix \(\Gamma\) we used as input. \(\Gamma\) only denotes
the most upstream P-gene perturbed. E.g., if A is upstream of B, than
\(\Gamma\) only denotes a perturbation of A, even though B is also perturbed
in every samples in which A is perturbed. We can compute it by the
matrix multiplication \(\Omega = \phi^T \times \Gamma\).

```
Omega <- t(mnem::transitive.closure(res$res$adj)) %*% res$Gamma
epiNEM::HeatmapOP(Omega, col = "RdBu", cexRow = 0.75, cexCol = 0.75, bordercol = "transparent",
    xrot = 0, dendrogram = "both")
```

![](data:image/png;base64...)

# 4 Session information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] nempi_1.18.0     mnem_1.26.0      BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] snowfall_1.84-6.3                 RBGL_1.86.0
##   [3] deldir_2.0-4                      gridExtra_2.3
##   [5] formatR_1.14                      permute_0.9-8
##   [7] rlang_1.1.6                       magrittr_2.0.4
##   [9] clue_0.3-66                       flexclust_1.5.0
##  [11] minet_3.68.0                      matrixStats_1.5.0
##  [13] e1071_1.7-16                      compiler_4.5.1
##  [15] mgcv_1.9-3                        flexmix_2.3-20
##  [17] gdata_3.0.1                       png_0.1-8
##  [19] vctrs_0.6.5                       stringr_1.5.2
##  [21] pkgconfig_2.0.3                   fastmap_1.2.0
##  [23] magick_2.9.0                      BoutrosLab.plotting.general_7.1.2
##  [25] rmarkdown_2.30                    graph_1.88.0
##  [27] tinytex_0.57                      xfun_0.53
##  [29] modeltools_0.2-24                 randomForest_4.7-1.2
##  [31] cachem_1.1.0                      epiNEM_1.34.0
##  [33] jsonlite_2.0.0                    fpc_2.2-13
##  [35] jpeg_0.1-11                       gmodels_2.19.1
##  [37] parallel_4.5.1                    prabclus_2.3-4
##  [39] cluster_2.1.8.1                   R6_2.6.1
##  [41] stringi_1.8.7                     bslib_0.9.0
##  [43] RColorBrewer_1.1-3                limma_3.66.0
##  [45] jquerylib_0.1.4                   diptest_0.77-2
##  [47] Rcpp_1.1.0                        bookdown_0.45
##  [49] knitr_1.50                        zoo_1.8-14
##  [51] snow_0.4-4                        ggm_2.5.2
##  [53] BoolNet_2.1.9                     Matrix_1.7-4
##  [55] splines_4.5.1                     nnet_7.3-20
##  [57] igraph_2.2.1                      tidyselect_1.2.1
##  [59] abind_1.4-8                       dichromat_2.0-0.1
##  [61] yaml_2.3.10                       vegan_2.7-2
##  [63] lattice_0.22-7                    tibble_3.3.0
##  [65] S7_0.2.0                          evaluate_1.0.5
##  [67] Rtsne_0.17                        tsne_0.1-3.1
##  [69] proxy_0.4-27                      RcppEigen_0.3.4.0.2
##  [71] mclust_6.1.1                      kernlab_0.9-33
##  [73] pillar_1.11.1                     BiocManager_1.30.26
##  [75] stats4_4.5.1                      ellipse_0.5.0
##  [77] generics_0.1.4                    ggplot2_4.0.0
##  [79] fastICA_1.2-7                     scales_1.4.0
##  [81] RcppArmadillo_15.0.2-2            gtools_3.9.5
##  [83] class_7.3-23                      apcluster_1.4.14
##  [85] glue_1.8.0                        Linnorm_2.34.0
##  [87] tools_4.5.1                       interp_1.1-6
##  [89] hexbin_1.28.5                     robustbase_0.99-6
##  [91] data.table_1.17.8                 XML_3.99-0.19
##  [93] fastcluster_1.3.0                 grid_4.5.1
##  [95] amap_0.8-20                       bdsmatrix_1.3-7
##  [97] wesanderson_0.3.7                 latticeExtra_0.6-31
##  [99] naturalsort_0.1.3                 sfsmisc_1.1-22
## [101] nlme_3.1-168                      pcalg_2.7-12
## [103] latex2exp_0.9.6                   cli_3.6.5
## [105] ggdendro_0.2.0                    dplyr_1.1.4
## [107] corpcor_1.6.10                    Rgraphviz_2.54.0
## [109] gtable_0.3.6                      DEoptimR_1.1-4
## [111] sass_0.4.10                       digest_0.6.37
## [113] BiocGenerics_0.56.0               farver_2.1.2
## [115] htmltools_0.5.8.1                 lifecycle_1.0.4
## [117] statmod_1.5.1                     MASS_7.3-65
```

# 5 References:

# Appendix

Markowetz, F., Bloch, J., and Spang, R. (2005). Non-transcriptional
pathway features reconstructed from secondary effects
of rna interference. Bioinformatics, 21(21), 4026–4032.

Markowetz, F., Kostka, D., Troyanskaya, O. G., and Spang, R. (2007).
Nested effects models for high-dimensional phenotyping
screens. Bioinformatics, 23(13), i305–i312.

Pirkl, M., Beerenwinkel, N.; Single cell network analysis with a mixture
of Nested Effects Models, Bioinformatics, Volume 34, Issue 17, 1 September
2018,
Pages i964–i971, <https://doi.org/10.1093/bioinformatics/bty602>.

Ritchie ME, Phipson B, Wu D, Hu Y, Law CW, Shi W, Smyth GK (2015).
“limma powers differential expression analyses for RNA-sequencing and
microarray studies.” Nucleic Acids Research, 43(7), e47.