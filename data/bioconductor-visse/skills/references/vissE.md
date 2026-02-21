# vissE: Visualising Set Enrichment Analysis Results.

#### Dharmesh D. Bhuva

#### 30 October 2025

Abstract

This package enables the interpretation and analysis of results from a gene set enrichment analysis using network-based and text-mining approaches. Most enrichment analyses result in large lists of significant gene sets that are difficult to interpret. Tools in this package help build a similarity-based network of significant gene sets from a gene set enrichment analysis that can then be investigated for their biological function using text-mining approaches.

* [1 vissE](#visse)
* [2 Summarising the results of a gene-set enrichment analysis](#summarising-the-results-of-a-gene-set-enrichment-analysis)
  + [2.1 Compute gene-set overlap](#compute-gene-set-overlap)
  + [2.2 Identify clusters of gene-sets](#identify-clusters-of-gene-sets)
  + [2.3 Characterise gene-set clusters](#characterise-gene-set-clusters)
  + [2.4 Visualise gene-level statistics for gene-set clusters](#visualise-gene-level-statistics-for-gene-set-clusters)
  + [2.5 Visualise protein-protein interactions (PPI) in each cluster](#visualise-protein-protein-interactions-ppi-in-each-cluster)
  + [2.6 Combine results to interpret results](#combine-results-to-interpret-results)
* [3 Session information](#session-information)

# 1 vissE

This package implements the vissE algorithm to summarise results of gene-set analyses. Usually, the results of a gene-set enrichment analysis (e.g using limma::fry, singscore or GSEA) consist of a long list of gene-sets. Biologists then have to search through these lists to determines emerging themes to explain the altered biological processes. This task can be labour intensive therefore we need solutions to summarise large sets of results from such analyses.

This package provides an approach to provide summaries of results from gene-set enrichment analyses. It exploits the relatedness between gene-sets and the inherent hierarchical structure that may exist in pathway databases and gene ontologies to cluster results. For each cluster of gene-sets vissE identifies, it performs text-mining to automate characterisation of biological functions and processes represented by the cluster.

An additional power of vissE is to perform a novel type of gene-set enrichment analysis based on the network of similarity between gene-sets. Given a list of genes (e.g. from a DE analysis), vissE can characterise said list by first identifying all other gene-sets that are similar to it, following up with clustering the resulting gene-sets and finally performing text-mining to reveal emerging themes.

In addition to these analyses, it provides visualisations to assist the users in understanding the results of their experiment. This document will demonstrate these functions across the two use-cases. The vissE package can be downloaded as follows:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("vissE")
```

# 2 Summarising the results of a gene-set enrichment analysis

Often, the results of a gene-set enrichment analysis (be it an over representation analysis of a functional class scoring approach) is a list of gene-sets that are accompanied by their statistics and p-values or false discovery rates (FDR). These results are mostly scanned through by biologists who then extract relevant themes pertaining to the experiment of interest. The approach here, vissE, will allow automated extraction of themes.

The example below can be used with the results of any enrichment analysis. The data below is simulated to demonstrate the workflow.

```
library(msigdb)
library(GSEABase)

#load the MSigDB from the msigdb package
msigdb_hs = getMsigdb()
#append KEGG gene-sets - comment out to run
# msigdb_hs = appendKEGG(msigdb_hs)
#select h, c2, and c5 collections (recommended)
msigdb_hs = subsetCollection(msigdb_hs, c('h', 'c2', 'c5'))

#randomly sample gene-sets to simulate the results of an enrichment analysis
set.seed(360)
geneset_res = sample(sapply(msigdb_hs, setName), 2500)

#create a GeneSetCollection using the gene-set analysis results
geneset_gsc = msigdb_hs[geneset_res]
geneset_gsc
#> GeneSetCollection
#>   names: GOMF_RIBOSOME_BINDING, GOCC_CHROMATOID_BODY, ..., BACOLOD_RESISTANCE_TO_ALKYLATING_AGENTS_UP (2500 total)
#>   unique identifiers: C1QBP, EEF2, ..., TMEM220 (20183 total)
#>   types in collection:
#>     geneIdType: SymbolIdentifier (1 total)
#>     collectionType: BroadCollection (1 total)
```

A vissE analysis involves 3 steps:

1. Compute gene-set overlaps and the gene-set overlap network
2. Identify clusters of gene-sets based on their overlap
3. Characterise clusters using text mining
4. (Optional) Visualise gene-level statistics

## 2.1 Compute gene-set overlap

The default approach to computing overlaps is using the Jaccard index. Overlap is computed based on the gene overlap between gene-sets. Alternatively, the overlap coefficient can be used. The latter can be used to highlight hierarchical overlaps (such as those present in the gene ontology).

```
library(vissE)

#compute gene-set overlap
gs_ovlap = computeMsigOverlap(geneset_gsc, thresh = 0.25)
#create an overlap network
gs_ovnet = computeMsigNetwork(gs_ovlap, msigdb_hs)
#plot the network
set.seed(36) #set seed for reproducible layout
plotMsigNetwork(gs_ovnet)
```

![](data:image/png;base64...)

The overlap network plot above is annotated using the MSigDB category. If gene-set statistics are available, they can be projected onto the network too. Gene-set statistics can be passed onto the plotting function as a named vector.

```
#simulate gene-set statistics
geneset_stats = rnorm(2500)
names(geneset_stats) = geneset_res
head(geneset_stats)
#>                              GOMF_RIBOSOME_BINDING
#>                                        -1.21539963
#>                               GOCC_CHROMATOID_BODY
#>                                         0.05103936
#>         GOMF_STRUCTURAL_CONSTITUENT_OF_POSTSYNAPSE
#>                                         0.58275695
#>                                    HP_STREAK_OVARY
#>                                         0.45263705
#>                                     GOBP_MITOPHAGY
#>                                        -0.48239796
#> GOBP_REGULATION_OF_ALPHA-BETA_T_CELL_PROLIFERATION
#>                                         1.27643333

#plot the network and overlay gene-set statistics
set.seed(36) #set seed for reproducible layout
plotMsigNetwork(gs_ovnet, genesetStat = geneset_stats)
```

![](data:image/png;base64...)

## 2.2 Identify clusters of gene-sets

Related gene-sets likely represent related processes. The next step is to identify clusters of gene-sets so that they can be assessed for biological themes. The specific clustering approach can be selected by the user though we recommend graph clustering approaches to use the information provided in the overlap graph. We recommend using the `igraph::cluster_walktrap()` algorithm as it works well with dense graphs. Many other algorithms are implemented in the igraph package and these can be used instead of the walktrap algorithm.

```
library(igraph)

#identify clusters - order based on cluster size and avg gene-set stats
grps = findMsigClusters(gs_ovnet,
                        genesetStat = geneset_stats,
                        alg = cluster_walktrap,
                        minSize = 5)
#plot the top 12 clusters
set.seed(36) #set seed for reproducible layout
plotMsigNetwork(gs_ovnet, markGroups = grps[1:6], genesetStat = geneset_stats)
```

![](data:image/png;base64...)

Instead of exploring the full network of gene-sets, the subgraph of nodes that form part of the groups can be plot. This allows for a more focused investigation into the relatedness of clusters identified using vissE.

```
set.seed(36) #set seed for reproducible layout
plotMsigNetwork(
  gs_ovnet,
  markGroups = grps[1:6],
  genesetStat = geneset_stats,
  rmUnmarkedGroups = TRUE
)
```

![](data:image/png;base64...)

## 2.3 Characterise gene-set clusters

Gene-set clusters identified can be assessed for their biological similarities using text-mining approaches. Here, we perform a frequency analysis (adjusted for using the inverse document frequency) on the gene-set names or their short descriptions to assess recurring biological themes in clusters. These results are then presented as word clouds.

```
#compute and plot the results of text-mining
#using gene-set Names
plotMsigWordcloud(msigdb_hs, grps[1:6], type = 'Name')
```

![](data:image/png;base64...)

```
#using gene-set Short descriptions
plotMsigWordcloud(msigdb_hs, grps[1:6], type = 'Short')
```

![](data:image/png;base64...)

## 2.4 Visualise gene-level statistics for gene-set clusters

Gene-level statistics for each gene-set cluster can be visualised to better understand the genes contributing to significance of gene-sets. Gene-level statistics can be passed onto the plotting function as a named vector. A jitter is applied on the x-axis (due to its discrete nature).

```
library(ggplot2)

#simulate gene statistics
set.seed(36)
genes = unique(unlist(geneIds(geneset_gsc)))
gene_stats = rnorm(length(genes))
names(gene_stats) = genes
head(gene_stats)
#>      C1QBP       EEF2     EIF2S1      EIF5A       ETF1       FMR1
#>  0.3117314  0.8498291  0.7055331  1.6999284 -1.3455710 -0.5698134

#plot the gene-level statistics
plotGeneStats(gene_stats, msigdb_hs, grps[1:6]) +
  geom_hline(yintercept = 0, colour = 2, lty = 2)
```

![](data:image/png;base64...)

## 2.5 Visualise protein-protein interactions (PPI) in each cluster

An alternative line of evidence for a common functional role of genes are the protein-protein interactions between them. Genes involved in a biological process are likely to interact with each other to achieve the desired function. We can therefore investigate protein-protein interactions within each cluster and thus assess evidence of a common process. In vissE, this can be done by inducing the protein-protein interaction of all genes in a gene-set cluster. Furthermore, the individual nodes in the network can be mapped onto properties such as the gene-level statistic. Networks can then be filtered based on the gene-level statistic, the confidence value of each interaction and the frequency of each gene in the cluster (i.e., how many gene-sets it belongs to).

We will retrieve the PPI from the `msigdb` R/Bioconductor package. Setting inferred to TRUE will allow PPIs inferred from across organisms to be used in the analysis.

```
#load PPI from the msigdb package
ppi = getIMEX('hs', inferred = TRUE)
#create the PPI plot
set.seed(36)
plotMsigPPI(
  ppi,
  msigdb_hs,
  grps[1:6],
  geneStat = gene_stats,
  threshStatistic = 0.2,
  threshConfidence = 0.2
)
```

![](data:image/png;base64...)

## 2.6 Combine results to interpret results

Results of a vissE analysis are best presented and interpreted as paneled plots that combine all of the above plots. This allows for collective interpretation of the gene-set clusters.

```
library(patchwork)

#create independent plots
set.seed(36) #set seed for reproducible layout
p1 = plotMsigWordcloud(msigdb_hs, grps[1:6], type = 'Name')
p2 = plotMsigNetwork(gs_ovnet, markGroups = grps[1:6], genesetStat = geneset_stats)
p3 = plotGeneStats(gene_stats, msigdb_hs, grps[1:6]) +
  geom_hline(yintercept = 0, colour = 2, lty = 2)
p4 = plotMsigPPI(
  ppi,
  msigdb_hs,
  grps[1:6],
  geneStat = gene_stats,
  threshStatistic = 0.2,
  threshConfidence = 0.2
)

#combine using functions from ggpubr
p1 + p2 + p3 + p4 + plot_layout(2, 2)
```

![](data:image/png;base64...)

# 3 Session information

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
#>  [1] patchwork_1.3.2      ggplot2_4.0.0        igraph_2.2.1
#>  [4] vissE_1.18.0         GSEABase_1.72.0      graph_1.88.0
#>  [7] annotate_1.88.0      XML_3.99-0.19        AnnotationDbi_1.72.0
#> [10] IRanges_2.44.0       S4Vectors_0.48.0     Biobase_2.70.0
#> [13] BiocGenerics_0.56.0  generics_0.1.4       msigdb_1.17.0
#>
#> loaded via a namespace (and not attached):
#>   [1] qdapRegex_0.7.10     DBI_1.2.3            gridExtra_2.3
#>   [4] httr2_1.2.1          rlang_1.1.6          magrittr_2.0.4
#>   [7] compiler_4.5.1       RSQLite_2.4.3        png_0.1-8
#>  [10] vctrs_0.6.5          reshape2_1.4.4       stringr_1.5.2
#>  [13] pkgconfig_2.0.3      crayon_1.5.3         fastmap_1.2.0
#>  [16] dbplyr_2.5.1         XVector_0.50.0       labeling_0.4.3
#>  [19] ggraph_2.2.2         rmarkdown_2.30       markdown_2.0
#>  [22] purrr_1.1.0          bit_4.6.0            xfun_0.53
#>  [25] cachem_1.1.0         litedown_0.7         textshape_1.7.5
#>  [28] jsonlite_2.0.0       blob_1.2.4           scico_1.5.0
#>  [31] tweenr_2.0.3         syuzhet_1.0.7        parallel_4.5.1
#>  [34] R6_2.6.1             bslib_0.9.0          stringi_1.8.7
#>  [37] RColorBrewer_1.1-3   textclean_0.9.3      jquerylib_0.1.4
#>  [40] Rcpp_1.1.0           Seqinfo_1.0.0        textstem_0.1.4
#>  [43] knitr_1.50           Matrix_1.7-4         tidyselect_1.2.1
#>  [46] sylly_0.1-6          dichromat_2.0-0.1    yaml_2.3.10
#>  [49] viridis_0.6.5        ggwordcloud_0.6.2    curl_7.0.0
#>  [52] lattice_0.22-7       tibble_3.3.0         plyr_1.8.9
#>  [55] withr_3.0.2          KEGGREST_1.50.0      S7_0.2.0
#>  [58] evaluate_1.0.5       polyclip_1.10-7      BiocFileCache_3.0.0
#>  [61] xml2_1.4.1           ExperimentHub_3.0.0  Biostrings_2.78.0
#>  [64] pillar_1.11.1        BiocManager_1.30.26  filelock_1.0.3
#>  [67] lexicon_1.2.1        koRpus_0.13-8        NLP_0.3-2
#>  [70] BiocVersion_3.22.0   commonmark_2.0.0     scales_1.4.0
#>  [73] BiocStyle_2.38.0     xtable_1.8-4         glue_1.8.0
#>  [76] koRpus.lang.en_0.1-4 slam_0.1-55          tools_4.5.1
#>  [79] AnnotationHub_4.0.0  tm_0.7-16            data.table_1.17.8
#>  [82] graphlayouts_1.2.2   tidygraph_1.3.1      grid_4.5.1
#>  [85] tidyr_1.3.1          colorspace_2.1-2     ggforce_0.5.0
#>  [88] cli_3.6.5            rappdirs_0.3.3       viridisLite_0.4.2
#>  [91] dplyr_1.1.4          gtable_0.3.6         sass_0.4.10
#>  [94] digest_0.6.37        ggrepel_0.9.6        org.Hs.eg.db_3.22.0
#>  [97] farver_2.1.2         memoise_2.0.1        htmltools_0.5.8.1
#> [100] lifecycle_1.0.4      prettydoc_0.4.1      httr_1.4.7
#> [103] gridtext_0.1.5       sylly.en_0.1-3       bit64_4.6.0-1
#> [106] MASS_7.3-65
```