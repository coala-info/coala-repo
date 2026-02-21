# lionessR

#### Marieke L. Kuijjer

#### 2025-10-30

LIONESS, or Linear Interpolation to Obtain Network Estimates for Single Samples, can be used to reconstruct single-sample networks (<https://arxiv.org/abs/1505.06440>). This package implements the LIONESS equation in R to reconstruct single-sample networks. The default network reconstruction method we use here is based on Pearson correlation. However, lionessR can run on any network reconstruction algorithms that returns a complete, weighted adjacency matrix. lionessR works for both unipartite and bipartite networks.

## Example: single-sample co-expression network analysis in osteosarcoma

As an example of how to model single-sample networks using lionessR, we will reconstruct and analyze co-expression networks for individual osteosarcoma patients. Osteosarcoma is an aggressive primary bone tumor that has a peak incidence in adolescents and young adults. The leading cause of death of osteosarcoma is distant metastases, which develop in 45% of patients. Detection of differential co-expression between osteosarcoma biopsies of patients with short and long metastasis-free survival may help better understand metastasis development, and may point to targets for treatment.

Our example dataset contains gene expression data for pre-treatment biopsies of two groups of patients—one group contains 19 patients who did not develop any metastases within 5 years after diagnosis of the primary tumor (long-term metastasis-free survivors), the other group contains 34 patients who did developed metastases within 5 years (short-term metastasis-free survivors).

For this analysis, we need to load the following packages:

```
library(lionessR)
library(igraph)
library(reshape2)
library(limma)
library(SummarizedExperiment)
```

To start, we load the dataset in R. This dataset contains an object `exp` with expression data for these 53 patients and an object `targets` with information on which patients developed metastases within 5 years. We then construct a SummerizedExperiment object:

```
data(OSdata)
rowData <- DataFrame(row.names = rownames(exp), gene = rownames(exp))
colData <- DataFrame(row.names = targets$sample, sample = as.character(targets$sample), mets = targets$mets)

se <- SummarizedExperiment(assays = list(counts = as.matrix(exp)),
                           colData = colData, rowData = rowData)
```

Because co-expression networks are usually very large, we subset this dataset to the 500 most variably expressed genes. To do this, we will sort the dataset based on the standard deviation of expression levels of each gene, and will select the top 500 genes:

```
nsel=500
cvar <- apply(assay(se), 1, sd)
dat <- se[tail(order(cvar), 500), ]
```

Next, we will make two condition-specific networks, one for the short-term and one for the long-term metastasis-free survival group. We calculate the difference between these condition-specific network adjacency matrices, so that we can use this to select edges that have large absolute differences in their co-expression levels:

```
netyes <- cor(t(assay(dat)[, dat$mets == "yes"]))
netno  <- cor(t(assay(dat)[, dat$mets == "no"]))
netdiff <- netyes-netno
```

We use R packages `igraph` and `reshape2` to convert these adjacency matrices to edgelists. As this is a symmetric adjacency matrix, we takeconvert the upper triangle of the co-expression adjacency matrix into an edge list. We then select those edges that have a difference in Pearson R correlation coefficient of at least 0.5:

```
cormat2 <- rep(1:nsel, each=nsel)
cormat1 <- rep(1:nsel,nsel)
el <- cbind(cormat1, cormat2, c(netdiff))
melted <- melt(upper.tri(netdiff))
melted <- melted[which(melted$value),]
values <- netdiff[which(upper.tri(netdiff))]
melted <- cbind(melted[,1:2], values)
genes <- row.names(netdiff)
melted[,1] <- genes[melted[,1]]
melted[,2] <- genes[melted[,2]]
row.names(melted) <- paste(melted[,1], melted[,2], sep="_")
tosub <- melted
tosel <- row.names(tosub[which(abs(tosub[,3])>0.5),])
```

Next, we’ll model the single-sample networks based on co-expression using lionessR. Note that, depending on the size of the dataset, this could take some time to run. We subset these networks to the selection of edges which we had defined above:

```
cormat <- lioness(dat, netFun)
corsub <- assay(cormat[which(row.names(cormat) %in% tosel), ])
```

We then run a LIMMA analysis on these edges:

```
group <- factor(se$mets)
design <- model.matrix(~0+group)
cont.matrix <- makeContrasts(yesvsno = (groupyes - groupno), levels = design)
fit <- lmFit(corsub, design)
fit2 <- contrasts.fit(fit, cont.matrix)
fit2e <- eBayes(fit2)
toptable <- topTable(fit2e, number=nrow(corsub), adjust="fdr")
```

We select the top 50 most differentially co-expressed edges and convert them into an igraph graph.data.frame object for visualization. We color edges red if they have higher coefficients in the short-term metastasis-free survival group, and blue if they have higher coefficients in the long-term metastasis-free survival group:

```
toptable_edges <- t(matrix(unlist(c(strsplit(row.names(toptable), "_"))),2))
z <- cbind(toptable_edges[1:50,], toptable$logFC[1:50])
g <- graph.data.frame(z, directed=FALSE)
#> Warning: `graph.data.frame()` was deprecated in igraph 2.0.0.
#> ℹ Please use `graph_from_data_frame()` instead.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
E(g)$weight <- as.numeric(z[,3])
E(g)$color[E(g)$weight<0] <- "blue"
E(g)$color[E(g)$weight>0] <- "red"
E(g)$weight <- 1
```

Next, we perform a LIMMA analysis on gene expression so that we can also color nodes based on their differential expression:

```
topgeneslist <- unique(c(toptable_edges[1:50,]))
fit <- lmFit(exp, design)
fit2 <- contrasts.fit(fit, cont.matrix)
fit2e <- eBayes(fit2)
topDE <- topTable(fit2e, number=nrow(exp), adjust="fdr")
topDE <- topDE[which(row.names(topDE) %in% topgeneslist),]
topgenesDE <- cbind(row.names(topDE), topDE$t)
```

We color nodes based on the t-statistic from the LIMMA analysis:

```
# add t-statistic to network nodes
nodeorder <- cbind(V(g)$name, 1:length(V(g)))
nodes <- merge(nodeorder, topgenesDE, by.x=1, by.y=1)
nodes <- nodes[order(as.numeric(as.character(nodes[,2]))),]
nodes[,3] <- as.numeric(as.character(nodes[,3]))
nodes <- nodes[,-2]
V(g)$weight <- nodes[,2]

# make a color palette
mypalette4 <- colorRampPalette(c("blue","white","white","red"), space="Lab")(256)
breaks2a <- seq(min(V(g)$weight), 0, length.out=128)
breaks2b <- seq(0.00001, max(V(g)$weight)+0.1,length.out=128)
breaks4 <- c(breaks2a,breaks2b)

# select bins for colors
bincol <- rep(NA, length(V(g)))
for(i in 1:length(V(g))){
    bincol[i] <- min(which(breaks4>V(g)$weight[i]))
}
bincol <- mypalette4[bincol]

# add colors to nodes
V(g)$color <- bincol
```

Finally, we visualize these results in a network diagram. In this diagram, edges are colored based on whether they have higher weights in patients with poor (red) or better (blue) MFS. Thicker edges represent higher fold changes. Nodes (genes) are colored based on the t-statistic from a differential expression analysis. Nodes with absolute t-statistic < 1.5 are shown in white, nodes in red/blue have higher expression in patients with poor/better MFS, respectively. The target genes we identified that connect to STAT1 were enriched for being annotated to the Gene Ontology term ossification. More importantly, STAT1 is a transcription factor in the interferon signaling pathway—a pathway known to be involved in osteosarcoma.

```
par(mar=c(0,0,0,0))
plot(g, vertex.label.cex=0.7, vertex.size=10, vertex.label.color = "black", vertex.label.font=3, edge.width=10*(abs(as.numeric(z[,3]))-0.7), vertex.color=V(g)$color)
```

![](data:image/png;base64...)

## Session Info

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
#>  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [5] IRanges_2.44.0              S4Vectors_0.48.0
#>  [7] BiocGenerics_0.56.0         generics_0.1.4
#>  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [11] limma_3.66.0                reshape2_1.4.4
#> [13] igraph_2.2.1                lionessR_1.24.0
#>
#> loaded via a namespace (and not attached):
#>  [1] Matrix_1.7-4        jsonlite_2.0.0      crayon_1.5.3
#>  [4] compiler_4.5.1      Rcpp_1.1.0          stringr_1.5.2
#>  [7] jquerylib_0.1.4     yaml_2.3.10         fastmap_1.2.0
#> [10] statmod_1.5.1       lattice_0.22-7      XVector_0.50.0
#> [13] R6_2.6.1            plyr_1.8.9          S4Arrays_1.10.0
#> [16] knitr_1.50          DelayedArray_0.36.0 pillar_1.11.1
#> [19] bslib_0.9.0         rlang_1.1.6         cachem_1.1.0
#> [22] stringi_1.8.7       xfun_0.53           sass_0.4.10
#> [25] SparseArray_1.10.0  cli_3.6.5           magrittr_2.0.4
#> [28] grid_4.5.1          digest_0.6.37       lifecycle_1.0.4
#> [31] vctrs_0.6.5         evaluate_1.0.5      glue_1.8.0
#> [34] abind_1.4-8         rmarkdown_2.30      tools_4.5.1
#> [37] pkgconfig_2.0.3     htmltools_0.5.8.1
```