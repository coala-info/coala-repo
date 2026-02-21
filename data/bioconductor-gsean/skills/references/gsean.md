# Gene Set Enrichment Analysis with Networks

#### Dongmin Jung

#### April 29, 2019

* [1 Introduction](#introduction)
* [2 Example](#example)
  + [2.1 GSEA with the list of genes, based on the label propagation](#gsea-with-the-list-of-genes-based-on-the-label-propagation)
  + [2.2 GSEA with statistics, based on the degree centrality](#gsea-with-statistics-based-on-the-degree-centrality)
* [3 Session info](#session-info)
* [4 References](#references)

# 1 Introduction

Biological molecules in a living organism seldom work individually. They usually interact each other in a cooperative way. Biological process is too complicated to understand without considering such interactions. These associations can be conveniently represented as networks (graphs) with nodes (vertices) for molecules and links (edges) for interactions between them. Thus, network-based procedures can be seen as powerful methods for studying complex process. For example, cancer may be better characterized by frequently mutated or dysregulated pathways than driver mutations. However, many methods are devised for analyzing individual genes. It is said that techniques based on biological networks such as gene co-expression are more precise ways to represent information than those using lists of genes only. This package is aimed to integrate the gene expression and biological network. A biological network is constructed from gene expression data and it is used for Gene Set Enrichment Analysis.

Recently, network module-based methods have been proposed as a powerful tool to analyze and interpret gene expression data. For example, a co-expression gene network exhibit distinctive connection structures, including their topologies. In particular, the highly connected genes, or hub genes located at the functional center of the network, should have a high tendency to be associated with their phenotypic outcome. In case that a pathway is represented as a network with nodes and edges, its topology is essential for evaluating the importance of the pathway. However, the widely used statistical methods were designed for individual genes, which may detect too many irrelevant significantly genes or too few genes to describe the phenotypic changes. One possible reason is that most of the existing functional enrichment analyses ignore topological information. Therfore, they are limited for applicability. To overcome this limitation, the original functional enrichment method is extended by assigning network centralities such as node weights. The rationale behind this is that all nodes are not equally important because of hub genes. A fundamental problem in the analysis of complex networks is the determination of how important a certain node is. Centrality measures such as node strength show how influential that node is in the overall network. It assigns relative scores to all nodes within the graph. For simplicity, degree centrality or node strength is used as a centrality measure by default. For over-representation analysis, the label propagation algorithm is employed to score nodes in this package.

# 2 Example

## 2.1 GSEA with the list of genes, based on the label propagation

Label propagation is a semi-supervised learning that assigns labels for unlabelled nodes in a network. Each node will be labeled, based on the corresponding score. These score can be used as a statistic for GSEA. Thus ORA can be performed by GSEA. For the example of GSEA for the label propagation, consider Lung Adenocarcinoma data from TCGA. We have set our threshold to 0.7, so only those nodes with similarities higher than 0.7 will be considered neighbors. Consider recurrently mutated genes from MutSig and KEGG pathways. In the result, we can see that these mutated genes are enriched at cancer relevant signaling pathways such as ERBB and MAPK pathways. The warning message indicates that there are many genes that have the same score and so are ranked equally, which means that they are not affected by recurrently mutated genes.

```
library(gsean)
library(TCGAbiolinks)
library(SummarizedExperiment)
# TCGA LUAD
query <- GDCquery(project = "TCGA-LUAD",
                  data.category = "Gene expression",
                  data.type = "Gene expression quantification",
                  platform = "Illumina HiSeq",
                  file.type  = "normalized_results",
                  experimental.strategy = "RNA-Seq",
                  legacy = TRUE)
GDCdownload(query, method = "api")
invisible(capture.output(data <- GDCprepare(query)))
exprs.LUAD <- assay(data)
# remove duplicated gene names
exprs.LUAD <- exprs.LUAD[-which(duplicated(rownames(exprs.LUAD))),]
# list of genes
recur.mut.gene <- c("KRAS", "TP53", "STK11", "RBM10", "SPATA31C1", "KRTAP4-11",
                    "DCAF8L2", "AGAP6", "KEAP1", "SETD2", "ZNF679", "FSCB",
                    "BRAF", "ZNF770", "U2AF1", "SMARCA4", "HRNR", "EGFR")

# KEGG_hsa
load(system.file("data", "KEGG_hsa.rda", package = "gsean"))

# GSEA
set.seed(1)
result.GSEA <- gsean(KEGG_hsa, recur.mut.gene, exprs.LUAD, threshold = 0.7)
invisible(capture.output(p <- GSEA.barplot(result.GSEA, category = 'pathway',
                                           score = 'NES', pvalue = 'padj',
                                           sort = 'padj', top = 20)))
p <- GSEA.barplot(result.GSEA, category = 'pathway', score = 'NES',
                  pvalue = 'padj', sort = 'padj', top = 20)
p + theme(plot.margin = margin(10, 10, 10, 75))
```

## 2.2 GSEA with statistics, based on the degree centrality

Gene expression data are analyzed to identify differentially expressed genes. Consider *pasilla* RNA-seq count data. By using the Wald statistic in this example, GSEA can be performed with Gene Ontology terms from <http://www.go2msig.org/cgi-bin/prebuilt.cgi?taxid=7227>. Thus, it is expected that we may find the biological functions related to change in phenotype from the network, rather than individual genes.

```
library(gsean)
library(pasilla)
library(DESeq2)
# pasilla count data
pasCts <- system.file("extdata", "pasilla_gene_counts.tsv",
                      package = "pasilla", mustWork = TRUE)
cts <- as.matrix(read.csv(pasCts, sep="\t", row.names = "gene_id"))
condition <- factor(c(rep("untreated", 4), rep("treated", 3)))
dds <- DESeqDataSetFromMatrix(
  countData = cts,
  colData   = data.frame(condition),
  design    = ~ 0 + condition)
# filtering
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]
# differentially expressed genes
dds <- DESeq(dds)
resultsNames(dds)
```

```
## [1] "conditiontreated"   "conditionuntreated"
```

```
res <- results(dds, contrast = list("conditiontreated", "conditionuntreated"), listValues = c(1, -1))
statistic <- res$stat
names(statistic) <- rownames(res)
exprs.pasilla <- counts(dds, normalized = TRUE)

# convert gene id
library(org.Dm.eg.db)
gene.id <- AnnotationDbi::select(org.Dm.eg.db, names(statistic), "ENTREZID", "FLYBASE")
names(statistic) <- gene.id[,2]
rownames(exprs.pasilla) <- gene.id[,2]

# GO_dme
load(system.file("data", "GO_dme.rda", package = "gsean"))

# GSEA
set.seed(1)
result.GSEA <- gsean(GO_dme, statistic, exprs.pasilla)
```

```
## log2 transformed for correlation
```

```
invisible(capture.output(p <- GSEA.barplot(result.GSEA, category = 'pathway',
                                           score = 'NES', top = 50, pvalue = 'padj',
                                           sort = 'padj', numChar = 110) +
  theme(plot.margin = margin(10, 10, 10, 50))))
plotly::ggplotly(p)
```

# 3 Session info

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
##  [1] org.Dm.eg.db_3.22.0         pasilla_1.37.0
##  [3] DEXSeq_1.56.0               RColorBrewer_1.1-3
##  [5] AnnotationDbi_1.72.0        DESeq2_1.50.0
##  [7] SummarizedExperiment_1.40.0 GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           Biobase_2.70.0
## [15] BiocParallel_1.44.0         gsean_1.30.0
## [17] PPInfer_1.36.0              yeastExpData_0.55.0
## [19] graph_1.88.0                BiocGenerics_0.56.0
## [21] generics_0.1.4              STRINGdb_2.22.0
## [23] igraph_2.2.1                ggplot2_4.0.0
## [25] kernlab_0.9-33              biomaRt_2.66.0
## [27] fgsea_1.36.0
##
## loaded via a namespace (and not attached):
##   [1] rstudioapi_0.17.1     jsonlite_2.0.0        magrittr_2.0.4
##   [4] farver_2.1.2          rmarkdown_2.30        vctrs_0.6.5
##   [7] memoise_2.0.1         Rsamtools_2.26.0      base64enc_0.1-3
##  [10] htmltools_0.5.8.1     S4Arrays_1.10.0       progress_1.2.3
##  [13] dynamicTreeCut_1.63-1 plotrix_3.8-4         curl_7.0.0
##  [16] SparseArray_1.10.0    Formula_1.2-5         sass_0.4.10
##  [19] KernSmooth_2.23-26    bslib_0.9.0           htmlwidgets_1.6.4
##  [22] gsubfn_0.7            plyr_1.8.9            httr2_1.2.1
##  [25] plotly_4.11.0         impute_1.84.0         cachem_1.1.0
##  [28] lifecycle_1.0.4       iterators_1.0.14      pkgconfig_2.0.3
##  [31] Matrix_1.7-4          R6_2.6.1              fastmap_1.2.0
##  [34] digest_0.6.37         colorspace_2.1-2      chron_2.3-62
##  [37] geneplotter_1.88.0    crosstalk_1.2.2       Hmisc_5.2-4
##  [40] RSQLite_2.4.3         hwriter_1.3.2.1       labeling_0.4.3
##  [43] filelock_1.0.3        httr_1.4.7            abind_1.4-8
##  [46] compiler_4.5.1        bit64_4.6.0-1         withr_3.0.2
##  [49] doParallel_1.0.17     backports_1.5.0       htmlTable_2.4.3
##  [52] S7_0.2.0              DBI_1.2.3             gplots_3.2.0
##  [55] rappdirs_0.3.3        DelayedArray_0.36.0   gtools_3.9.5
##  [58] caTools_1.18.3        tools_4.5.1           foreign_0.8-90
##  [61] nnet_7.3-20           glue_1.8.0            grid_4.5.1
##  [64] checkmate_2.3.3       cluster_2.1.8.1       gtable_0.3.6
##  [67] preprocessCore_1.72.0 tidyr_1.3.1           data.table_1.17.8
##  [70] hms_1.1.4             WGCNA_1.73            XVector_0.50.0
##  [73] foreach_1.5.2         pillar_1.11.1         stringr_1.5.2
##  [76] genefilter_1.92.0     splines_4.5.1         dplyr_1.1.4
##  [79] BiocFileCache_3.0.0   lattice_0.22-7        survival_3.8-3
##  [82] bit_4.6.0             annotate_1.88.0       tidyselect_1.2.1
##  [85] GO.db_3.22.0          locfit_1.5-9.12       Biostrings_2.78.0
##  [88] knitr_1.50            gridExtra_2.3         sqldf_0.4-11
##  [91] xfun_0.53             statmod_1.5.1         proto_1.0.0
##  [94] stringi_1.8.7         lazyeval_0.2.2        yaml_2.3.10
##  [97] evaluate_1.0.5        codetools_0.2-20      tibble_3.3.0
## [100] hash_2.2.6.3          cli_3.6.5             rpart_4.1.24
## [103] xtable_1.8-4          jquerylib_0.1.4       dichromat_2.0-0.1
## [106] Rcpp_1.1.0            dbplyr_2.5.1          png_0.1-8
## [109] XML_3.99-0.19         fastcluster_1.3.0     parallel_4.5.1
## [112] blob_1.2.4            prettyunits_1.2.0     bitops_1.0-9
## [115] viridisLite_0.4.2     scales_1.4.0          purrr_1.1.0
## [118] crayon_1.5.3          rlang_1.1.6           cowplot_1.2.0
## [121] fastmatch_1.1-6       KEGGREST_1.50.0
```

# 4 References

Gu, Z., Liu, J., Cao, K., Zhang, J., & Wang, J. (2012). Centrality-based pathway enrichment: a systematic approach for finding significant pathways dominated by key genes. BMC systems biology, 6(1), 56.

Wu, J. (2016). Transcriptomics and Gene Regulation. Springer.

Zhang, W., Chien, J., Yong, J., & Kuang, R. (2017). Network-based machine learning and graph theory algorithms for precision oncology. npj Precision Oncology, 1(1), 25.