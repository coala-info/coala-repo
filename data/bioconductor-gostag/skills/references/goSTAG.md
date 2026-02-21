# The goSTAG User’s Guide

Brian D. Bennett and Pierre R. Bushel

#### June 2, 2017

# 1 Introduction

Gene lists derived from the results of genomic analyses are rich in biological information. For instance, differentially expressed genes (DEGs) from a microarray or RNA-Seq analysis are related functionally in terms of their response to a treatment or condition. Gene lists can vary in size, up to several thousand genes, depending on the robustness of the perturbations or how widely different the conditions are biologically. Having a way to associate biological relatedness between hundreds and thousands of genes systematically is impractical by manually curating the annotation and function of each gene. Over-representation analysis (ORA) of genes was developed to identify biological themes. Given a Gene Ontology (GO) and an annotation of genes that indicate the categories each one fits into, significance of the over-representation of the genes within the ontological categories is determined by a Fisher’s exact test or modeling according to a hypergeometric distribution. Comparing a small number of enriched biological categories for a few samples is manageable using Venn diagrams or other means for assessing overlaps. However, with hundreds of enriched categories and many samples, the comparisons are laborious. Furthermore, if there are enriched categories that are shared between samples, trying to represent a common theme across them is highly subjective. goSTAG uses GO subtrees to tag and annotate genes within a set. goSTAG visualizes the similarities between the over-representation of DEGs by clustering the p-values from the enrichment statistical tests and labels clusters with the GO term that has the most paths to the root within the subtree generated from all the GO terms in the cluster.

# 2 Installation

The goSTAG package is available through Bioconductor and you can install it by running:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("goSTAG")
```

Once the library is installed, you can load it by running:

```
library("goSTAG")
```

# 3 Preparing Data for Analysis

This section describes how to prepare your data to perform a goSTAG analysis.

## 3.1 Gene Lists

The key input data that goSTAG requires is a set of gene lists. These gene lists can be derived from any type of gene-based analysis, such as differential expression analysis or ChIP-seq peak targets. They can be generated within R using another package, or using an external tool and then loaded into R.

Once you have generated your gene lists and loaded them into R, you must convert them into the format that goSTAG requires, which is a list of vectors. Each element of the list corresponds to a gene list, and the vectors contain the genes in the gene list.

We provide an example set of gene lists in the goSTAG package.

```
data( goSTAG_example_gene_lists )
head( lapply( goSTAG_example_gene_lists, head ) )
```

```
## $Day1
## [1] "CNN2"    "GHDC"    "GALNT10" "LIPT1"   "TPP1"    "TBPL2"
##
## $Day2
## [1] "GPR37L1"  "TNFSF13B" "OLAH"     "WWC1"     "NYNRIN"   "MRGPRX4"
##
## $Day3
## [1] "MAD2L1BP"      "MRPL47"        "SLIRP"         "MEF2BNB-MEF2B"
## [5] "TMEM245"       "UBA6"
```

For convienience, we have provided a function for loading external gene lists.

The first option is to put your gene lists into a single GMT file. This GMT file is a tab-delimited file containing one gene list per line. The first entry in the line is the name of the gene list, the second entry in the line is a description of the gene list (which goSTAG ignores), and the rest of the entries are the genes. For more information on the GMT format, see [here](http://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Data_formats#GMT:_Gene_Matrix_Transposed_file_format_.28.2A.gmt.29).

Once you have created your GMT file, you can load it using the `loadGeneLists` function.

```
gene_lists <- loadGeneLists( "gene_lists.gmt" )
```

The second option is to have your gene lists in separate tab-delimited text files within a directory.

You can load the gene lists within this directory using the `loadGeneLists` function with the `type` argument set to `"DIR"`.

```
gene_lists <- loadGeneLists( "/gene/lists/directory", type = "DIR" )
```

By default, the `loadGeneLists` function expects the files in this directory to have no header and to have the genes in the first column. You can modify this behavior using the `header` argument and the `col` argument.

In this example, the files contain a header that needs to be ignored, and the genes are in the 7th column.

```
gene_lists <- loadGeneLists( "/gene/lists/directory", type = "DIR", header = TRUE, col = 7 )
```

## 3.2 GO Terms

The second input data required by goSTAG is a set of GO terms and the genes associated with those GO terms. The GO terms should all belong to the same GO domain (either biological process, cellular component, or molecular function). The expected format is a list of vectors, where each list corresponds to a GO term, and the vectors contain the genes associated with the GO terms. The names of the lists should be the GO IDs of the GO terms. The list must also have an additional element named “ALL”, which is a vector that contains all annotated genes.

The goSTAG package provides the `loadGOTerms` function for loading the GO terms and gene associations from BioMart using the `biomaRt` package.

```
go_terms <- loadGOTerms()
head( lapply( go_terms, head ) )
```

```
## $`GO:0006810`
## [1] "SLC25A26" "GJA3"     "GJB2"     "HERC1"    "SLC35A2"  "BAG6"
##
## $`GO:0048011`
## [1] "BTC"   "FGF7"  "FURIN" "APH1B" "NDN"   "AGO2"
##
## $`GO:0007173`
## [1] "BTC"     "FGF7"    "AGO2"    "FGF9"    "MAPKAP1" "FGF2"
##
## $`GO:0008543`
## [1] "BTC"     "FGF7"    "AGO2"    "FGF9"    "MAPKAP1" "FGF2"
##
## $`GO:0048015`
## [1] "BTC"     "FGF7"    "UBE2C"   "AGO2"    "FGF9"    "MAPKAP1"
##
## $`GO:0008284`
## [1] "BTC"   "FGF7"  "EDN3"  "RPS4X" "AVP"   "FGF9"
```

```
head( go_terms[["ALL"]] )
```

```
## [1] "SLC25A26" "BTC"      "GAST"     "HAP1"     "JUP"      "FKBP10"
```

Since loading the GO terms from BioMart can take several minutes, the default behavior of the `loadGOTerms` function is to use a previously generated version that has been archived in the goSTAG package, which is much faster.

You can load the most recent version of the GO terms and gene associations directly from BioMart by setting the `use_archived` argument to `FALSE`.

```
go_terms <- loadGOTerms( use_archived = FALSE )
```

By default, the `loadGOTerms` function will associate genes based on the annotation for human. It will also load GO terms for the biological process domain and remove any GO terms that has fewer than 5 genes associated with it. To modify this behavior, use the `species`, `domain`, and `min_num_genes` arguments. Currently, the supported options for the `species` argument are “human”, “mouse”, or “rat”. Acceptable options for the `domain` argument are “BP” (biological process), “CC” (cellular component), or “MF” (molecular function).

This example will load GO terms for mouse, using the molecular function domain, and remove any GO terms with fewer than 10 genes.

```
go_terms_mouse <- loadGOTerms( species = "mouse", domain = "MF", min_num_genes = 10 )
```

# 4 Running goSTAG

Once your gene lists and GO terms are loaded, you are ready to perform a goSTAG analysis. This section will detail the four steps in the goSTAG analysis.

## 4.1 Generating the Enrichment Matrix

The first step is to create a matrix of GO enrichment scores. The goSTAG package calculates an enrichment score for each gene list and GO term using the hypergeometric test. It will remove any GO term that has no samples with significant enrichment. The enrichment score is calculated as the -log10 p-value of the hypergeometric test. For tests without significant enrichment, the enrichment score is set to 0.

To generate an enrichment matrix from your gene lists and GO terms, use the `performGOEnrichment` function.

```
enrichment_matrix <- performGOEnrichment( goSTAG_example_gene_lists, go_terms )
head(enrichment_matrix)
```

```
##                Day1     Day2     Day3
## GO:0007165 0.000000 0.000000 1.343007
## GO:0007369 0.000000 0.000000 1.389698
## GO:0042127 0.000000 0.000000 1.729184
## GO:0007249 1.862509 1.766861 1.654304
## GO:0008380 1.345807 0.000000 1.306134
## GO:0016049 0.000000 1.436532 0.000000
```

This function produces a matrix of enrichment scores, where columns are gene lists and rows are GO terms.

By default, this function will remove any GO term where none of the samples have a p-value of less than 0.05. You can specify whether to use a nominal p-value or an adjusted p-value using the `filter_method` argument, and you can change the significance threshold using the `significance_threshold` argument. This function uses the `p.adjust` method to adjust the p-value, and you can specify the method used to adjust the p-values with the `p.adjust_method` argument. See the `method` argument for the `p.adjust` function for available options.

This example generates the enrichment matrix and uses a Benjamini-Hochberg FDR of 0.3 to filter the GO terms.

```
enrichment_matrix_FDR <- performGOEnrichment( goSTAG_example_gene_lists, go_terms, filter_method = "p.adjust", significance_threshold = 0.3, p.adjust_method = "BH" )
```

## 4.2 Hierarchical Clustering

After generating the enrichment matrix, the next step is to cluster the GO terms. Before clustering the GO terms into groups, you must first perform hierarchical clustering.

You can perform the hierarchical clustering using the `performHierarchicalClustering` function.

```
hclust_results <- performHierarchicalClustering( enrichment_matrix )
hclust_results
```

```
##
## Call:
## hclust(d = as.dist(1 - abs(cor(t(final_matrix)))), method = clustering_method)
##
## Cluster method   : average
## Number of objects: 146
```

This function uses the `hclust` function and returns an object of class `hclust` containing the hierarchical clustering tree.

By default, this function uses one minus the absolute value of the correlation to measure distance. You can change this behavior using the `distance_method` argument. Specifying anything other than `correlation` will cause this function to use the `dist` function to measure distance. The method specified in the `distance_method` argument is the method that the `dist` function will use. See the `method` argument for the `dist` function for available options.

This function uses the `hclust` function to perform the hierarchical clustering, with a default agglomeration method of `average`. You can change this by specifying the `clustering_method` argument.

This example performs hierarchical clustering on the GO terms using Euclidean distance and complete agglomeration.

```
hclust_results_euclidean <- performHierarchicalClustering( enrichment_matrix, distance_method = "euclidean", clustering_method = "complete" )
```

You can also perform hierarchical clustering on the samples by setting the `feature` argument to `col`.

```
sample_hclust_results <- performHierarchicalClustering( enrichment_matrix, feature = "col" )
```

## 4.3 Grouping the Clusters

After the hierarchical clustering is complete, you can group the GO terms into clusters using the `groupClusters` function.

```
clusters <- groupClusters( hclust_results_euclidean )
lapply( head( clusters ), head )
```

```
## $Cluster1
## [1] "GO:0006417"
##
## $Cluster2
## [1] "GO:0045760" "GO:0090316"
##
## $Cluster3
## [1] "GO:0002224"
##
## $Cluster4
## [1] "GO:0002042" "GO:0048536" "GO:0030220"
##
## $Cluster5
## [1] "GO:0010628" "GO:0007599"
##
## $Cluster6
## [1] "GO:0035195"
```

This function produces a list of vectors, where each list corresponds to a cluster, and the vectors are the GO terms in the clusters.

By default, this function will group GO terms whose distance to each other is less than 0.2. This threshold can be adjusted by changing the `distance_threshold` argument. A larger distance threshold will produce fewer clusters with more GO terms, whereas a smaller one will produce more clusters with fewer GO terms.

The default distance threshold of 0.2 produces a moderate number of clusters.

```
length( clusters )
```

```
## [1] 33
```

Increasing the distance threshold to 0.5 produces fewer clusters, but with more GO terms on average.

```
clusters_larger_threshold <- groupClusters( hclust_results_euclidean, distance_threshold = 0.5 )
length( clusters_larger_threshold )
```

```
## [1] 19
```

Whereas decreasing the distance threshold to 0.05 produces more clusters, but with fewer GO terms on average.

```
clusters_smaller_threshold <- groupClusters( hclust_results_euclidean, distance_threshold = 0.05 )
length( clusters_smaller_threshold )
```

```
## [1] 58
```

## 4.4 Annotating the Clusters

The final step is to annotate each of the clusters using the GO term within each cluster’s subtree that has the most paths back to the root.

You can annotate the clusters using this method with the `annotateClusters` function.

```
cluster_labels <- annotateClusters( clusters )
head( cluster_labels )
```

```
##                                               GO:0006417
##                              "regulation of translation"
##                                               GO:0090316
## "positive regulation of intracellular protein transport"
##                                               GO:0002224
##                   "toll-like receptor signaling pathway"
##                                               GO:0030220
##                                     "platelet formation"
##                                               GO:0010628
##                 "positive regulation of gene expression"
##                                               GO:0035195
##     "miRNA-mediated post-transcriptional gene silencing"
```

This returns a vector containing the descriptions of the GO terms tagged to each cluster.

# 5 Plotting a Heatmap

After performing a goSTAG analysis, you can plot a heatmap of the results using the `plotHeatmap` function.

```
plotHeatmap( enrichment_matrix, hclust_results_euclidean, clusters, cluster_labels )
```

![](data:image/png;base64...)

You can add the hierarchical clustering of the samples to the plot using the `sample_hclust_results` argument.

```
plotHeatmap( enrichment_matrix, hclust_results_euclidean, clusters, cluster_labels, sample_hclust_results = sample_hclust_results )
```

![](data:image/png;base64...)

By default, this function will only label clusters with 10 or more GO terms. You can change this by modifying the `min_num_terms` argument.

This example has the minimum number of GO terms decreased to 5, which increases the number of clusters that are labeled.

```
plotHeatmap( enrichment_matrix, hclust_results_euclidean, clusters, cluster_labels, min_num_terms = 5 )
```

![](data:image/png;base64...)

There are many additional graphical arguments that adjust the color, contrast, shape, and size of the heatmap, including `maximum_heatmap_value`, `heatmap_colors`, `sample_colors`, `margin_size`, `dendrogram_width`, `cluster_label_width`, `header_height`, `sample_label_height`, `dendrogram_lwd`, `header_lwd`, `cluster_label_cex`, `sample_label_cex`. For more information about these parameters, see the `plotHeatmap` documentation.

The produce a better quality heatmap image, we recommend creating a high resolution image. When using a higher resolution, we also recommend increasing the line thickness using the `dendrogram_lwd` and `header_lwd` arguments, and the text size using the `cluster_label_cex` and `sample_label_cex` arguments.

Here is example that creates a higher reolution and better quality image.

```
png( "heatmap.png", width = 1600, height = 1200 )
plotHeatmap( enrichment_matrix, hclust_results_euclidean, clusters, cluster_labels, dendrogram_lwd = 2, header_lwd = 2, cluster_label_cex = 2, sample_label_cex = 2 )
dev.off()
```

# 6 Citing goSTAG

```
citation("goSTAG")
```

```
## Please use the following citation when using goSTAG for your research:
##
##   Bennett BD and Bushel PR. goSTAG: Gene Ontology Subtrees to Tag and
##   Annotate Genes within a set. Source Code Biol Med. 2017 Apr 13.
##
## A BibTeX entry for LaTeX users is
##
##   @Article{,
##     author = {Brian D. Bennett and Pierre R. Bushel},
##     title = {goSTAG: Gene Ontology Subtrees to Tag and Annotate Genes within a set},
##     journal = {Source Code Biol Med},
##     year = {2017},
##   }
```

You can contact the authors through email.

Brian D. Bennett: brian.bennett@nih.gov

Pierre R. Bushel: bushel@niehs.nih.gov

# 7 Session Info

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
## [1] goSTAG_1.34.0    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3       sass_0.4.10          generics_0.1.4
##  [4] stringi_1.8.7        RSQLite_2.4.3        hms_1.1.4
##  [7] digest_0.6.37        magrittr_2.0.4       evaluate_1.0.5
## [10] bookdown_0.45        GO.db_3.22.0         fastmap_1.2.0
## [13] blob_1.2.4           jsonlite_2.0.0       progress_1.2.3
## [16] AnnotationDbi_1.72.0 DBI_1.2.3            tinytex_0.57
## [19] BiocManager_1.30.26  httr_1.4.7           Biostrings_2.78.0
## [22] httr2_1.2.1          jquerylib_0.1.4      cli_3.6.5
## [25] rlang_1.1.6          crayon_1.5.3         dbplyr_2.5.1
## [28] XVector_0.50.0       Biobase_2.70.0       bit64_4.6.0-1
## [31] cachem_1.1.0         yaml_2.3.10          tools_4.5.1
## [34] memoise_2.0.1        dplyr_1.1.4          filelock_1.0.3
## [37] BiocGenerics_0.56.0  curl_7.0.0           vctrs_0.6.5
## [40] R6_2.6.1             png_0.1-8            magick_2.9.0
## [43] stats4_4.5.1         lifecycle_1.0.4      BiocFileCache_3.0.0
## [46] stringr_1.5.2        KEGGREST_1.50.0      Seqinfo_1.0.0
## [49] S4Vectors_0.48.0     IRanges_2.44.0       bit_4.6.0
## [52] pkgconfig_2.0.3      bslib_0.9.0          pillar_1.11.1
## [55] Rcpp_1.1.0           glue_1.8.0           xfun_0.53
## [58] tibble_3.3.0         tidyselect_1.2.1     knitr_1.50
## [61] htmltools_0.5.8.1    rmarkdown_2.30       compiler_4.5.1
## [64] prettyunits_1.2.0    biomaRt_2.66.0
```