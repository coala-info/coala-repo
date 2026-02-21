# Building PPIs from StringDB

Jonathan Ronen1 and Altuna Akalin1

1Berlin Institute for Medical Systems Biology, Max Delbrück Center

#### 2025-10-30

# 1 Introduction

This vignette demonstrates how a Protein-Protein interaction (PPI) graph may be
constructed from the database [stringDB](https://string-db.org "string-db.org").

# 2 Obtaining network data from stringDB

Other networks can also be used with *netSmooth*. We mostly rely on networks
from stringDB. StringDB has multiple species available such as human, mouse,
zebrafish, *C.elengas* and *D.melanogaster*. It is also possible to prune the
network differently. For our purposes we use the edges that have highest
confidence score. Below, we are showing how to obtain and prune human network
from stringDB. Specifically, we use the work flow below.

1. Get human network/graph from STRINGdb.
2. Prune the network to get only high-confidence edges
3. Create adjacency matrix
4. Map protein ids in the network to Ensembl Gene ids in the adjacency matrix

```
require(STRINGdb)
require(igraph)
require(biomaRt)

# 1. getSTRINGdb for human
string_db <- STRINGdb$new(species=9606)
human_graph <- string_db$get_graph()

# 2. get edges with high confidence score
edge.scores <- E(human_graph)$combined_score
ninetyth.percentile <- quantile(edge.scores, 0.9)
thresh <- data.frame(name='90th percentile',
                     val=ninetyth.percentile)
human_graph <- subgraph.edges(human_graph,
                              E(human_graph)[combined_score > ninetyth.percentile])

# 3. create adjacency matrix
adj_matrix <- as_adjacency_matrix(human_graph)

# 4. map gene ids to protein ids

### get gene/protein ids via Biomart
mart=useMart(host = 'grch37.ensembl.org',
             biomart='ENSEMBL_MART_ENSEMBL',
             dataset='hsapiens_gene_ensembl')

### extract protein ids from the human network
protein_ids <- sapply(strsplit(rownames(adj_matrix), '\\.'),
                      function(x) x[2])

### get protein to gene id mappings
mart_results <- getBM(attributes = c("ensembl_gene_id",
                                     "ensembl_peptide_id"),
                      filters = "ensembl_peptide_id", values = protein_ids,
                      mart = mart)

### replace protein ids with gene ids
ix <- match(protein_ids, mart_results$ensembl_peptide_id)
ix <- ix[!is.na(ix)]

newnames <- protein_ids
newnames[match(mart_results[ix,'ensembl_peptide_id'], newnames)] <-
    mart_results[ix, 'ensembl_gene_id']
rownames(adj_matrix) <- newnames
colnames(adj_matrix) <- newnames

ppi <- adj_matrix[!duplicated(newnames), !duplicated(newnames)]
nullrows <- Matrix::rowSums(ppi)==0
ppi <- ppi[!nullrows,!nullrows] ## ppi is the network with gene ids
```

---

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
## [1] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```