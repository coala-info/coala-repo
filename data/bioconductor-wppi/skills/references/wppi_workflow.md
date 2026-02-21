# Context specific functional scores for protein-protein interaction networks

#### Ana Galhoz

hmgu
ana.galhoz@helmholtz-muenchen.de

#### Denes Turei

unihd

Abstract

The `wppi` package calculates context specific scores for genes in the network neighborhood of genes of interest. The context specificity is ensured by the selection of the genes of interest and potentially by using a more relevant subset of the ontology annotations, e.g. selecting only the diabetes related categories. The PPI network and the functional annotations are obtained automatically from public databases, though it’s possible to use custom databases. The network is limited to a user defined neighborhood of the genes of interest. The ontology annotations are also filtered to the genes in this subnetwork. Then the adjacency matrix is weighted according to the number of common neighbors and the similarity in functional annotations of each pair of interacting proteins. On this weighted adjacency matrix a random walk with returns is performed. The final score for the genes in the neighborhood is the sum of their scores (probabilities to be visited) in the random walk. The method can be fine tuned by setting the neighborhood range, the restart probability of the random walk and the threshold for the random walk.

* [Dependencies](#dependencies)
* [Complete workflow in a single call](#complete-workflow-in-a-single-call)
* [Workflow step by step](#workflow-step-by-step)
  + [Database knowledge](#database-knowledge)
  + [Converting the interactions to an igraph graph object](#converting-the-interactions-to-an-igraph-graph-object)
  + [Subgraph from the neighborhood of genes of interest](#subgraph-from-the-neighborhood-of-genes-of-interest)
  + [Weighted adjacency matrix](#weighted-adjacency-matrix)
  + [Random walk](#random-walk)
  + [Scoring proteins](#scoring-proteins)
  + [Network visualization](#network-visualization)
* [Session info](#session-info)

# Dependencies

The `wppi` package depends on the `OmnipathR` package. Since it relies on features more recent than the latest Bioconductor version (OmnipathR 2.0.0 in Bioconductor 3.12), until the release of Bioconductor 3.13, it is recommended to install OmnipathR from git.

# Complete workflow in a single call

The `score_candidate_genes_from_PPI` function executes the full wppi workflow. The only mandatory input is a set of genes of interest. As a return, an ordered table with the similarity scores of the new genes within the neighbourhood of the genes of interest is provided. A higher score stands for a higher functional similarity between this new gene and the given ones.

```
library(wppi)
# example gene set
genes_interest <- c(
    'ERCC8', 'AKT3', 'NOL3', 'TTK',
    'GFI1B', 'CDC25A', 'TPX2', 'SHE'
)
scores <- score_candidate_genes_from_PPI(genes_interest)
```

```
## Warning in (function (...) : 'function (...)
## {
##     .Deprecated("post_translational")
##     post_translational(...)
## }' is deprecated.
## Use 'post_translational' instead.
## See help("Deprecated")
```

```
## 'as(<dgCMatrix>, "dgTMatrix")' is deprecated.
## Use 'as(., "TsparseMatrix")' instead.
## See help("Deprecated") and help("Matrix-deprecated").
```

```
scores
# # A tibble: 295 x 3
#    score gene_symbol uniprot
#    <dbl> <chr>       <chr>
#  1 0.247 KNL1        Q8NG31
#  2 0.247 HTRA2       O43464
#  3 0.247 KAT6A       Q92794
#  4 0.247 BABAM1      Q9NWV8
#  5 0.247 SKI         P12755
#  6 0.247 FOXA2       Q9Y261
#  7 0.247 CLK2        P49760
#  8 0.247 HNRNPA1     P09651
#  9 0.247 HK1         P19367
# 10 0.180 SH3RF1      Q7Z6J0
# # . with 285 more rows
```

# Workflow step by step

## Database knowledge

The database knowledge is provided by `wppi_data`. By default all directed protein-protein interactions are used from OmniPath. By passing various options the network can be customized. See more details in the documentation of the `OmnipathR` package, especially the `import_post_translational_interactions` function. For example, to use only the literature curated interactions one can use the `datasets = 'omnipath'` parameter:

```
omnipath_data <- wppi_omnipath_data(datasets = 'omnipath')
```

```
## Warning in (function (...) : 'function (...)
## {
##     .Deprecated("post_translational")
##     post_translational(...)
## }' is deprecated.
## Use 'post_translational' instead.
## See help("Deprecated")
```

The `wppi_data` function retrieves all database data at once. Parameters to customize the network can be passed directly to this function.

```
db <- wppi_data(datasets = c('omnipath', 'kinaseextra'))
```

```
## Warning in (function (...) : 'function (...)
## {
##     .Deprecated("post_translational")
##     post_translational(...)
## }' is deprecated.
## Use 'post_translational' instead.
## See help("Deprecated")
```

```
names(db)
# [1] "hpo"      "go"       "omnipath" "uniprot"
```

Optionally, the Human Phenotype Ontology (HPO) annotations relevant in the context can be selected. For example, to select the annotations related to diabetes:

```
# example HPO annotations set
HPO_data <- wppi_hpo_data()
HPO_interest <- unique(dplyr::filter(HPO_data, grepl('Diabetes', Name))$Name)
```

## Converting the interactions to an igraph graph object

To work further with the interactions we first convert it to an `igraph` graph object:

```
graph_op <- graph_from_op(db$omnipath)
```

## Subgraph from the neighborhood of genes of interest

Then we select a subgraph around the genes of interest. The size of the subgraph is determined by the range of this neighborhood (`sub_level` argument for the `subgraph_op` function).

```
graph_op_1 <- subgraph_op(graph_op, genes_interest)
igraph::vcount(graph_op_1)
# [1] 256
```

## Weighted adjacency matrix

The next step is to assign weights to each interaction. The weights are calculated based on the number of common neighbors and the similarities of the annotations of the interacting partners.

```
w_adj <- weighted_adj(graph_op_1, db$go, db$hpo)
```

## Random walk

The random walk with restarts algorithm uses the edge weights to score the overall connections between pairs of genes. The result takes into accound also the indirect connections, integrating the information in the graph topology.

```
w_rw <- random_walk(w_adj)
```

## Scoring proteins

At the end we can summarize the scores for each protein, taking the sum of all adjacent connections. The resulted table provides us a list of proteins prioritized by their predicted importance in the context of interest (disease or condition).

```
scores <- prioritization_genes(graph_op_1, w_rw, genes_interest)
scores
```

```
# # A tibble: 249 x 3
#    score gene_symbol uniprot
#    <dbl> <chr>       <chr>
#  1 0.251 HTRA2       O43464
#  2 0.251 KAT6A       Q92794
#  3 0.251 BABAM1      Q9NWV8
#  4 0.251 SKI         P12755
#  5 0.251 CLK2        P49760
#  6 0.248 TUBB        P07437
#  7 0.248 KNL1        Q8NG31
#  8 0.189 SH3RF1      Q7Z6J0
#  9 0.189 SRPK2       P78362
# 10 0.150 CSNK1D      P48730
# # . with 239 more rows
```

## Network visualization

The top genes in the first order neighborhood of the genes of interest can be visualized in the PPI network:

`{r fig1,dpi = 300, echo=FALSE, eval = FALSE, fig.cap="PPI network visualization of genes of interest (blue nodes) and their first neighbor with similarity scores (green nodes). "} idx_neighbors <- which(!V(graph_op_1)$Gene_Symbol %in% genes_interest) cols <- rep("lightsteelblue2",vcount(graph_op_1)) cols[idx_neighbors] <- "#57da83" scores.vertex <- rep(1,vcount(graph_op_1)) scores.vertex[idx_neighbors] <- 8*scores[na.omit(match(V(graph_op_1)$Gene_Symbol,scores$gene_symbol)),]$score par(mar=c(0.1,0.1,0.1,0.1)) plot(graph_op_1,vertex.label = ifelse(scores.vertex>=1,V(graph_op_1)$Gene_Symbol,NA), layout = layout.fruchterman.reingold,vertex.color=cols, vertex.size = 7*scores.vertex,edge.width = 0.5,edge.arrow.mode=0, vertex.label.font = 1, vertex.label.cex = 0.45)`

```
library(knitr)
knitr::include_graphics("../figures/fig1.png")
```

# Session info

```
## R version 4.5.2 (2025-10-31)
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
## [1] wppi_1.18.0
##
## loaded via a namespace (and not attached):
##  [1] xfun_0.54         bslib_0.9.0       httr2_1.2.1       websocket_1.4.4
##  [5] processx_3.8.6    lattice_0.22-7    OmnipathR_3.18.2  tzdb_0.5.0
##  [9] bitops_1.0-9      vctrs_0.6.5       tools_4.5.2       ps_1.9.1
## [13] generics_0.1.4    parallel_4.5.2    curl_7.0.0        tibble_3.3.0
## [17] RSQLite_2.4.4     blob_1.2.4        pkgconfig_2.0.3   R.oo_1.27.1
## [21] Matrix_1.7-4      checkmate_2.3.3   readxl_1.4.5      lifecycle_1.0.4
## [25] compiler_4.5.2    stringr_1.6.0     progress_1.2.3    chromote_0.5.1
## [29] htmltools_0.5.8.1 sass_0.4.10       RCurl_1.98-1.17   yaml_2.3.10
## [33] tidyr_1.3.1       later_1.4.4       pillar_1.11.1     crayon_1.5.3
## [37] jquerylib_0.1.4   R.utils_2.13.0    cachem_1.1.0      sessioninfo_1.2.3
## [41] zip_2.3.3         tidyselect_1.2.1  rvest_1.0.5       digest_0.6.39
## [45] stringi_1.8.7     dplyr_1.1.4       purrr_1.2.0       fastmap_1.2.0
## [49] grid_4.5.2        cli_3.6.5         logger_0.4.1      magrittr_2.0.4
## [53] XML_3.99-0.20     withr_3.0.2       readr_2.1.6       prettyunits_1.2.0
## [57] promises_1.5.0    backports_1.5.0   rappdirs_0.3.3    bit64_4.6.0-1
## [61] lubridate_1.9.4   timechange_0.3.0  rmarkdown_2.30    httr_1.4.7
## [65] igraph_2.2.1      bit_4.6.0         otel_0.2.0        cellranger_1.1.0
## [69] R.methodsS3_1.8.2 hms_1.1.4         memoise_2.0.1     evaluate_1.0.5
## [73] knitr_1.50        tcltk_4.5.2       rlang_1.1.6       Rcpp_1.1.0
## [77] glue_1.8.0        DBI_1.2.3         selectr_0.4-2     xml2_1.5.0
## [81] vroom_1.6.6       jsonlite_2.0.0    R6_2.6.1          fs_1.6.6
```