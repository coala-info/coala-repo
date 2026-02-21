# Boolean Nested Effects Models: Inferring the logical signalling of pathways from indirect measurements and biological perturbations.

Martin Pirkl

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
  + [1.1 Installing and loading B-NEM](#installing-and-loading-b-nem)
* [2 Toy example for a DAG](#toy-example-for-a-dag)
* [3 Stimulated and inhibited S-genes can overlap](#stimulated-and-inhibited-s-genes-can-overlap)
  + [3.1 Pre-attach E-genes](#pre-attach-e-genes)
  + [3.2 Visualizing network residuals](#visualizing-network-residuals)
* [4 B-Cell receptor signalling](#b-cell-receptor-signalling)

# 1 Introduction

Boolean Nested Effects Models (B-NEM) are used to infer signalling
pathways. In different experiments (conditions) genes of a pathway
(S-genes) are stimulated or inhibited, alone or in combination. In
each experiment transcriptional targets (E-genes) of the pathway react
differently and are higher or lower expressed depending on the
condition. From these differential expressions B-NEM infers Boolean
functions presented as hyper-edges of a hyper-graph connecting parents
and children in the pathway. For example, if the signal is transduced
by two parents A and B to a child C and the signal can be blocked with
a knock-down of either one, they are connected by a typical
AND-gate. If the signal is still transduced during a single
knock-down, but blocked by the double knock-down of A and B, they
activate C by an OR-gate. In general the state of child C is defined
by a Boolean function
\[f: \left\{0,1\right\}^n \to \left\{0,1\right\},~C = f(A\_1,\dots,A\_n)\]
with its parents \(A\_i, i \in \left\{1,\dots,n\right\}\).

The B-NEM package is based on and uses many functions of the
CellNOptR package of Terfve et al., 2012.

## 1.1 Installing and loading B-NEM

Install the package with the devtools library or via Bioconductor.

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("bnem")
```

Load the Boolean Nested Effects model package.

```
library(bnem)
```

# 2 Toy example for a DAG

We show how to use B-NEM on a toy pathway presented by a directed
acyclic (hyper-)graph (DAG). B-NEM demands several objects as
input. The two main objects are the differential gene expression
(data) and prior knowledge respectively the search space.

The following function creates a DAG, which
is then extended to a full Boolean network. From this network we
sample a subset of edges to define our ground truth. In the last step,
the function generates data given the ground truth.

```
set.seed(9247)
sim <- simBoolGtn(Sgenes = 10, maxEdges = 10, keepsif = TRUE, negation=0.1,
                  layer=1)
fc <- addNoise(sim,sd=1)
expression <- sim$expression
CNOlist <- sim$CNOlist
model <- sim$model
bString <- sim$bString
ERS <- sim$ERS
PKN <- sim$PKN
children <- unique(gsub(".*=|!", "", PKN$reacID))
stimuli <- unique(gsub("=.*|!", "", PKN$reacID))
stimuli <- stimuli[which(!(stimuli %in% children))]
```

The following figure shows the PKN and the ground truth network.

```
library(mnem)
par(mfrow=c(1,2))
plotDnf(PKN$reacID, stimuli = stimuli)
```

```
## A graphNEL graph with directed edges
## Number of Nodes = 10
## Number of Edges = 21
```

```
plotDnf(model$reacID[as.logical(sim$bString)], stimuli = stimuli)
```

![PKN and GTN. The prior knowledge network without any logics  (PKN, left) and the ground truth (GTN, right). Red 'tee' arrows depict repression the others activation of  the child. The stimulated S-genes are diamond shaped. Blue diamond edges  in the PKN depict the existence of activation and repression in one arrow.](data:image/png;base64...)

Figure 1: PKN and GTN
The prior knowledge network without any logics
(PKN, left) and the ground truth (GTN, right). Red ‘tee’ arrows depict
repression the others activation of
the child. The stimulated S-genes are diamond shaped. Blue diamond edges
in the PKN depict the existence of activation and repression in one arrow.

```
## A graphNEL graph with directed edges
## Number of Nodes = 12
## Number of Edges = 14
```

We suggest to take a look at the sif file in the working directory. In
future analyses it is easier to just provide a suitable sif file for
the investigated pathway. In a real application the underlying
ground truth network (GTN) is not known.

B-NEM uses differential expression between experiments to infer the
pathway logics. For example look at the colnames of sim$fc (=foldchanges
of E-genes (rows)) and remember that S0g, S1g are our
stimulated S-genes and the rest possibly inhibited. Thus in the first
column of fc we have the contrast S2g
\(-\) control. In the control no S-genes are perturbed.

We search for the GTN in our restricted network space. Each network is
a sub-graph of the full hyper-graph sim$model$reacID. We initialize
the search with a starting network and greedily search the neighborhood.

We use two different network scores. “s” is the rank correlation and
“cosine” is the cosine similarity (hence no shift invariance).

```
## we start with the empty graph:
initBstring <- reduceGraph(rep(0, length(model$reacID)), model, CNOlist)
## or a fully connected graph:
## initBstring <- reduceGraph(rep(1, length(model$reacID)), model, CNOlist)

## paralellize for several threads on one machine or multiple machines
## see package "snowfall" for details
parallel <- NULL # NULL for serialization
## or distribute to 30 threads on four different machines:
## parallel <- list(c(4,16,8,2), c("machine1", "machine2", "machine3",
## "machine4"))

## greedy search:
greedy <- bnem(search = "greedy",
               fc=fc,
               expression=expression, # not used, if fc is defined
               CNOlist=CNOlist,
               model=model,
               parallel=parallel,
               initBstring=initBstring,
               draw = FALSE, # TRUE: draw network at each step
               verbose = FALSE, # TRUE: print changed (hyper-)edges and
               ## score improvement
               maxSteps = Inf,
               method = "s"
               )

greedy2 <- bnem(search = "greedy",
                fc=fc,
                expression=expression,
                CNOlist=CNOlist,
                model=model,
                parallel=parallel,
                initBstring=initBstring,
                draw = FALSE,
                verbose = FALSE,
                maxSteps = Inf,
                method = "cosine"
                )
```

We compare the binary strings defining the ground truth and the
inferred networks. We first look at the respective scores
(the smaller the better) and then compute sensitivity and
specificity of the edges for both results.

```
greedy$scores # rank correlation = normalized
```

```
## [[1]]
##  [1] -31.96792 -34.09256 -35.49737 -36.50558 -37.35063 -38.17197 -38.94132
##  [8] -39.47262 -39.97767 -40.25966 -40.52911 -40.59341 -40.66502
```

```
greedy2$scores # scaled log foldchanges
```

```
## [[1]]
##  [1] -32.52366 -34.89870 -36.05350 -37.09127 -37.94433 -38.79064 -39.53877
##  [8] -40.01382 -40.40855 -40.78858 -40.96302 -41.06156 -41.08302
```

```
accuracy <- function(gtn,inferred) {
  sens <- sum(gtn == 1 & inferred == 1)/
    (sum(gtn == 1 & inferred == 1) + sum(gtn == 1 & inferred == 0))
  spec <- sum(gtn == 0 & inferred == 0)/
      (sum(gtn == 0 & inferred == 0) + sum(gtn == 0 & inferred == 1))
  return(c(sens,spec))
}

accuracy(bString,greedy$bString)
```

```
## [1] 0.9000000 0.9487179
```

```
accuracy(bString,greedy2$bString)
```

```
## [1] 0.9000000 0.9230769
```

```
resString <- greedy2$bString
```

We take a look at the efficiency of the search algorithm with
sensitivity and specificity of the hyper-edges for the optimized
network and the accuracy of its ERS (similar to the truth
table). Since several networks produce the same ERS, the learned
hyper-graph can differ from the GTN and still be \(100\%\) accurate.

```
par(mfrow=c(1,2))
## GTN:
plotDnf(model$reacID[as.logical(bString)], main = "GTN", stimuli = stimuli)
```

```
## A graphNEL graph with directed edges
## Number of Nodes = 12
## Number of Edges = 14
```

```
## greedy optimum:
plotDnf(model$reacID[as.logical(resString)], main = "greedy optimum",
        stimuli = stimuli)
```

![GTN and greedy optimum. The GTN (left) and the greedy  optmimum (right).](data:image/png;base64...)

Figure 2: GTN and greedy optimum
The GTN (left) and the greedy
optmimum (right).

```
## A graphNEL graph with directed edges
## Number of Nodes = 15
## Number of Edges = 22
```

```
## accuracy of the expected response scheme (can be high even, if
## the networks differ):
ERS.res <- computeFc(CNOlist,
                     t(simulateStatesRecursive(CNOlist, model, resString)))
ERS.res <- ERS.res[, which(colnames(ERS.res) %in% colnames(ERS))]
print(sum(ERS.res == ERS)/length(ERS))
```

```
## [1] 0.9906977
```

After optimization we look at the data and how well the greedy optimum
explains the E-genes. The lower the score the better the fit.

```
fitinfo <- validateGraph(CNOlist, fc=fc, expression=expression, model = model,
                         bString = resString,
                         Sgene = 4, Egenes = 1000, cexRow = 0.8,
                         cexCol = 0.7,
                         xrot = 45,
                         Colv = TRUE, Rowv = TRUE, dendrogram = "both",
                         bordercol = "lightgrey",
                         aspect = "iso", sub = "")
```

![BCR signalling. The PKN (left) and the greedy optimum  with an empty start network (right).](data:image/png;base64...)

Figure 3: BCR signalling
The PKN (left) and the greedy optimum
with an empty start network (right).

The bottom row shows the ERS of S-gene
S0g and the other rows show the
observed response scheme (ORS) of the
S0g-regulated E-genes.
Alternatively to the greedy neighborhood search a genetic algorithm
and exhaustive search are available. The exhaustive search is not
recommended for search spaces with more than 20 hyper-edges.

```
## genetic algorithm:
genetic <- bnem(search = "genetic",
           fc=fc,
           expression=expression,
           parallel = parallel,
           CNOlist=CNOlist,
           model=model,
           initBstring=initBstring,
           popSize = 10,
           stallGenMax = 10,
           draw = FALSE,
           verbose = FALSE
           )
```

```
## exhaustive search:
exhaustive <- bnem(search = "exhaustive",
                   parallel = parallel,
                   CNOlist=CNOlist,
                   fc=fc,
                   expression=expression,
                   model=model
                   )
```

# 3 Stimulated and inhibited S-genes can overlap

In this section we show how to use B-NEM, if stimuli and inhibitors
overlap. Additionally we want to show that B-NEM can resolve
cycles. For this we allow the PKN to have cycles, but no repression,
because repression can lead to an unresolvable ERS. See Pirkl et al.,
2016 for details.

We look for stimuli which are also inhibited. For those we add
additional stimuli S-genes. The stimuli S-gene (parent) and the
inhibitor S-gene (child) are connected by a positive edge. Hence,
if the S-gene is activated, the stimuli is set to 1. If the S-gene
is inhibited the inhibitor S-gene is set to 0.

```
set.seed(9247)
sim <- simBoolGtn(Sgenes = 4, maxEdges = 50, dag = FALSE,
                  negation = 0, allstim = TRUE,frac=0.1)
fc <- addNoise(sim,sd=1)
expression <- sim$expression
CNOlist <- sim$CNOlist
model <- sim$model
bString <- sim$bString
ERS <- sim$ERS
PKN <- sim$PKN
children <- unique(gsub(".*=|!", "", PKN$reacID))
stimuli <- unique(gsub("=.*|!", "", PKN$reacID))
stimuli <- stimuli[which(!(stimuli %in% children))]
```

The next figure shows the cyclic PKN with extra stimuli
S-genes. Notice, this way the inhibition of the S-genes overrules the
stimulation.

```
par(mfrow=c(1,2))
plotDnf(sim$PKN$reacID, stimuli = stimuli)
```

```
## A graphNEL graph with directed edges
## Number of Nodes = 8
## Number of Edges = 16
```

```
plotDnf(sim$model$reacID[as.logical(bString)], stimuli = stimuli)
```

![PKN and GTN. The prior knowledge network without any logics  (PKN, left) and the ground truth (GTN, right). Red 'tee' arrows depict repression the others activation of  the child. The stimulated S-genes are diamond shaped. Blue diamond edges  in the PKN depict the existence of activation and repression in one arrow.](data:image/png;base64...)

Figure 4: PKN and GTN
The prior knowledge network without any logics
(PKN, left) and the ground truth (GTN, right). Red ‘tee’ arrows depict
repression the others activation of
the child. The stimulated S-genes are diamond shaped. Blue diamond edges
in the PKN depict the existence of activation and repression in one arrow.

```
## A graphNEL graph with directed edges
## Number of Nodes = 9
## Number of Edges = 9
```

```
greedy3 <- bnem(search = "greedy",
                CNOlist=CNOlist,
                fc=fc,
                expression=expression,
                model=model,
                parallel=parallel,
                initBstring=bString*0,
                draw = FALSE,
                verbose = FALSE,
                maxSteps = Inf,
                method = "cosine"
                )
resString2 <- greedy3$bString
```

We look at the accuracy again.

```
par(mfrow=c(1,2))
plotDnf(model$reacID[as.logical(bString)], main = "GTN", stimuli = stimuli)
```

```
## A graphNEL graph with directed edges
## Number of Nodes = 9
## Number of Edges = 9
```

```
plotDnf(model$reacID[as.logical(resString2)], main = "greedy optimum",
        stimuli = stimuli)
```

![GTN and greedy optimum. The GTN (left) and the greedy  optmimum (right).](data:image/png;base64...)

Figure 5: GTN and greedy optimum
The GTN (left) and the greedy
optmimum (right).

```
## A graphNEL graph with directed edges
## Number of Nodes = 9
## Number of Edges = 9
```

```
accuracy(bString,resString2)
```

```
## [1] 1 1
```

```
ERS.res <- computeFc(CNOlist, t(simulateStatesRecursive(CNOlist, model,
                                                        resString2)))
ERS.res <- ERS.res[, which(colnames(ERS.res) %in% colnames(ERS))]
print(sum(ERS.res == ERS)/length(ERS))
```

```
## [1] 1
```

## 3.1 Pre-attach E-genes

One additional challenge for B-NEM compared to methods like
CellNetOptimizer is the fact, that B-NEM optimizes the signalling
pathway and simultaneously the attachment of the E-genes. However, it
is possible to include prior knowledge into the search.

We just have to create a list object, which holds prior
information about the E-genes.

```
egenes <- list()

for (i in PKN$namesSpecies) {
    egenes[[i]] <- rownames(fc)[grep(i, rownames(fc))]
}
initBstring <- reduceGraph(rep(0, length(model$reacID)), model, CNOlist)
greedy2b <- bnem(search = "greedy",
                 CNOlist=CNOlist,
                 fc=fc,
                 expression=expression,
                 egenes=egenes,
                 model=model,
                 parallel=parallel,
                 initBstring=initBstring,
                 draw = FALSE,
                 verbose = FALSE,
                 maxSteps = Inf,
                 method = "cosine"
                 )
resString3 <- greedy2b$bString
```

We attach every E-gene to its real parent in the for loop. If an
E-gene is only included once in the egenes object, it’s position is
not learned, but fixed during the optimization of the signalling
pathway. Alternatively, we can include one E-gene several times for
just a subset of S-genes. This way S-genes, which do not have the
E-genes included in their E-gene set are excluded as potential parents.

```
accuracy(bString,resString3)
```

```
## [1] 1 1
```

```
ERS.res <- computeFc(CNOlist,
                     t(simulateStatesRecursive(CNOlist, model, resString3)))
ERS.res <- ERS.res[, which(colnames(ERS.res) %in% colnames(ERS))]
print(sum(ERS.res == ERS)/length(ERS))
```

```
## [1] 1
```

## 3.2 Visualizing network residuals

We can also quantify how well the attached E-genes fit to the learned
network. See the Pirkl, 2016 for more details.

```
residuals <- findResiduals(resString3, CNOlist, model, fc, verbose = FALSE)
## verbose = TRUE plots the residuals matrices
```

Rows denote S-genes in the network. Columns denote Contrasts between
two experiments. Green colors in the left matrix show the score
improves, if no (0) or a negative (-1) response in the network’s ERS
is changed to positive (+1). Red colors show a zero changed to
positive. The right matrix shows the same for switched +1 and -1.

# 4 B-Cell receptor signalling

In this section we analyze the B-Cell receptor (BCR) signalling
data. The data set consists of one stimulated S-gene (BCR), three
S-genes with available single inhibitions (Tak1, Pik3, Erk) and three S-genes
with up to triple inhibitions. See Pirkl et al. 2016 for more details.

```
data(bcr)
## head(fc)
fc <- bcr$fc
expression <- bcr$expression
```

We build a PKN to incorporate biological knowledge and account for
missing combinatorial inhibitions.

```
library(CellNOptR)
negation <- FALSE # what happens if we allow negation?
sifMatrix <- numeric()
for (i in "BCR") {
    sifMatrix <- rbind(sifMatrix, c(i, 1, c("Pi3k")))
    sifMatrix <- rbind(sifMatrix, c(i, 1, c("Tak1")))
    if (negation) {
        sifMatrix <- rbind(sifMatrix, c(i, -1, c("Pi3k")))
        sifMatrix <- rbind(sifMatrix, c(i, -1, c("Tak1")))
    }
}
for (i in c("Pi3k", "Tak1")) {
    for (j in c("Ikk2", "p38", "Jnk", "Erk", "Tak1", "Pi3k")) {
        if (i %in% j) { next() }
        sifMatrix <- rbind(sifMatrix, c(i, 1, j))
        if (negation) {
            sifMatrix <- rbind(sifMatrix, c(i, -1, j))
        }
    }
}
for (i in c("Ikk2", "p38", "Jnk")) {
    for (j in c("Ikk2", "p38", "Jnk")) {
        if (i %in% j) { next() }
        sifMatrix <- rbind(sifMatrix, c(i, 1, j))
        if (negation) {
            sifMatrix <- rbind(sifMatrix, c(i, -1, j))
        }
    }
}
file <- tempfile(pattern="interaction",fileext=".sif")
write.table(sifMatrix, file = file, sep = "\t",
            row.names = FALSE, col.names = FALSE, quote = FALSE)
PKN <- readSIF(file)
```

In the next step, we create the meta information. This ensures, that
we simulate all the conditions, which are actually available in the
data. Furthermore we build our Boolean search space based on the PKN.

```
CNOlist <- dummyCNOlist(stimuli = "BCR",
                        inhibitors = c("Tak1", "Pi3k", "Ikk2",
                                       "Jnk", "p38", "Erk"),
                        maxStim = 1, maxInhibit = 3)

model <- preprocessing(CNOlist, PKN)
```

```
## [1] "The following species are measured: BCR, Erk, Ikk2, Jnk, Pi3k, Tak1, p38"
## [1] "The following species are stimulated: BCR"
## [1] "The following species are inhibited: Erk, Ikk2, Jnk, Pi3k, Tak1, p38"
## [1] "The following species are not observable and/or not controllable: "
```

In the final step we learn the network with the greedy search.

```
initBstring <- rep(0, length(model$reacID))
bcrRes <- bnem(search = "greedy",
                   fc=fc,
                   CNOlist=CNOlist,
                   model=model,
                   parallel=parallel,
                   initBstring=initBstring,
                   draw = FALSE,
                   verbose = FALSE,
                   method = "cosine"
                   )
```

```
par(mfrow=c(1,3))
plotDnf(PKN$reacID, main = "PKN", stimuli = "BCR")
```

```
## A graphNEL graph with directed edges
## Number of Nodes = 7
## Number of Edges = 18
```

```
plotDnf(bcrRes$graph, main = "greedy optimum (empty start)",
        stimuli = "BCR")
```

```
## A graphNEL graph with directed edges
## Number of Nodes = 8
## Number of Edges = 9
```

![BCR signalling. The PKN (left) and the greedy optimum  with an empty start network (right).](data:image/png;base64...)

Figure 6: BCR signalling
The PKN (left) and the greedy optimum
with an empty start network (right).

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
## [1] grid      stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] CellNOptR_1.56.0    rmarkdown_2.30      ggplot2_4.0.0
##  [4] XML_3.99-0.19       Rgraphviz_2.54.0    RCurl_1.98-1.17
##  [7] RBGL_1.86.0         graph_1.88.0        BiocGenerics_0.56.0
## [10] generics_0.1.4      mnem_1.26.0         bnem_1.18.0
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3                ggdendro_0.2.0
##   [3] RcppArmadillo_15.0.2-2            jsonlite_2.0.0
##   [5] BoutrosLab.plotting.general_7.1.2 magrittr_2.0.4
##   [7] magick_2.9.0                      modeltools_0.2-24
##   [9] farver_2.1.2                      vctrs_0.6.5
##  [11] memoise_2.0.1                     fastICA_1.2-7
##  [13] tinytex_0.57                      htmltools_0.5.8.1
##  [15] binom_1.1-1.1                     sass_0.4.10
##  [17] bslib_0.9.0                       naturalsort_0.1.3
##  [19] zoo_1.8-14                        cachem_1.1.0
##  [21] sfsmisc_1.1-22                    igraph_2.2.1
##  [23] lifecycle_1.0.4                   pkgconfig_2.0.3
##  [25] Matrix_1.7-4                      R6_2.6.1
##  [27] fastmap_1.2.0                     MatrixGenerics_1.22.0
##  [29] clue_0.3-66                       digest_0.6.37
##  [31] S4Vectors_0.48.0                  AnnotationDbi_1.72.0
##  [33] RSQLite_2.4.3                     ellipse_0.5.0
##  [35] vegan_2.7-2                       latex2exp_0.9.6
##  [37] gdata_3.0.1                       httr_1.4.7
##  [39] abind_1.4-8                       mgcv_1.9-3
##  [41] compiler_4.5.1                    proxy_0.4-27
##  [43] withr_3.0.2                       bit64_4.6.0-1
##  [45] S7_0.2.0                          BiocParallel_1.44.0
##  [47] DBI_1.2.3                         epiNEM_1.34.0
##  [49] hexbin_1.28.5                     apcluster_1.4.14
##  [51] MASS_7.3-65                       tsne_0.1-3.1
##  [53] corpcor_1.6.10                    gtools_3.9.5
##  [55] permute_0.9-8                     wesanderson_0.3.7
##  [57] snowfall_1.84-6.3                 tools_4.5.1
##  [59] prabclus_2.3-4                    flexclust_1.5.0
##  [61] nnet_7.3-20                       glue_1.8.0
##  [63] pcalg_2.7-12                      nlme_3.1-168
##  [65] Rtsne_0.17                        cluster_2.1.8.1
##  [67] snow_0.4-4                        sva_3.58.0
##  [69] gtable_0.3.6                      class_7.3-23
##  [71] preprocessCore_1.72.0             data.table_1.17.8
##  [73] XVector_0.50.0                    flexmix_2.3-20
##  [75] pillar_1.11.1                     stringr_1.5.2
##  [77] limma_3.66.0                      genefilter_1.92.0
##  [79] robustbase_0.99-6                 splines_4.5.1
##  [81] dplyr_1.1.4                       lattice_0.22-7
##  [83] survival_3.8-3                    bit_4.6.0
##  [85] deldir_2.0-4                      annotate_1.88.0
##  [87] Linnorm_2.34.0                    tidyselect_1.2.1
##  [89] locfit_1.5-9.12                   Biostrings_2.78.0
##  [91] amap_0.8-20                       knitr_1.50
##  [93] gridExtra_2.3                     bookdown_0.45
##  [95] Seqinfo_1.0.0                     IRanges_2.44.0
##  [97] edgeR_4.8.0                       stats4_4.5.1
##  [99] xfun_0.53                         Biobase_2.70.0
## [101] statmod_1.5.1                     diptest_0.77-2
## [103] matrixStats_1.5.0                 DEoptimR_1.1-4
## [105] BoolNet_2.1.9                     stringi_1.8.7
## [107] yaml_2.3.10                       minet_3.68.0
## [109] evaluate_1.0.5                    codetools_0.2-20
## [111] interp_1.1-6                      kernlab_0.9-33
## [113] RcppEigen_0.3.4.0.2               tibble_3.3.0
## [115] BiocManager_1.30.26               cli_3.6.5
## [117] affyio_1.80.0                     xtable_1.8-4
## [119] gmodels_2.19.1                    jquerylib_0.1.4
## [121] dichromat_2.0-0.1                 Rcpp_1.1.0
## [123] png_0.1-8                         bdsmatrix_1.3-7
## [125] fastcluster_1.3.0                 parallel_4.5.1
## [127] ggm_2.5.2                         blob_1.2.4
## [129] mclust_6.1.1                      latticeExtra_0.6-31
## [131] jpeg_0.1-11                       bitops_1.0-9
## [133] scales_1.4.0                      affy_1.88.0
## [135] e1071_1.7-16                      crayon_1.5.3
## [137] fpc_2.2-13                        rlang_1.1.6
## [139] vsn_3.78.0                        KEGGREST_1.50.0
```

***References:***

Pirkl, Martin, Hand, Elisabeth, Kube, Dieter, & Spang,
Rainer. 2016. Analyzing synergistic and non-synergistic interactions
in signalling pathways using Boolean Nested Effect
Models. , 32(6), 893–900.

Pirkl, Martin. 2016. Indirect inference of synergistic and
alternative signalling of intracellular pathways. University of
Regensburg.

Saez-Rodriguez, Julio, Alexopoulos, Leonidas G, Epperlein, Jonathan,
Samaga, Regina, Lauffenburger, Douglas A, Klamt, Steffen, & Sorger,
Peter K. 2009. Discrete logic modelling as a means to link protein
signalling networks with functional analysis of mammalian signal
transduction. Mol Syst Biol, 5, 331.\

C Terfve, T Cokelaer, A MacNamara, D Henriques, E Goncalves, MK
Morris, M van Iersel, DA Lauffenburger, J Saez-Rodriguez. CellNOptR: a
flexible toolkit to train protein signaling networks to data using
multiple logic formalisms. BMC Systems Biology, 2012, 6:133.