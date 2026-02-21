# Loading gene sets

#### [Gabriel Hoffman](http://gabrielhoffman.github.io)

Icahn School of Medicine at Mount Sinai, New York

The `zenith` package builds on [EnrichmentBrowser](https://bioconductor.org/packages/EnrichmentBrowser/) to provde access to a range of gene set databases. Genesets can take ~1 min to download and load the first time. They are automatically cached on disk, so loading the second time takes just a second.

# Easy loading of gene set databases

Here are some shortcuts to load common databases:

```
library(zenith)

## MSigDB as ENSEMBL genes
# all genesets in MSigDB
gs.msigdb = get_MSigDB()

# only Hallmark gene sets
gs = get_MSigDB('H')

# only C1
gs = get_MSigDB('C1')

# C1 and C2
gs = get_MSigDB(c('C1', 'C2'))

# C1 as gene SYMBOL
gs = get_MSigDB('C1', to="SYMBOL")

# C1 as gene ENTREZ
gs = get_MSigDB('C1', to="ENTREZ")

## Gene Ontology
gs.go = get_GeneOntology()

# load Biological Process and gene SYMBOL
gs.go = get_GeneOntology("BP", to="SYMBOL")
```

# Other databases

[EnrichmentBrowser](https://bioconductor.org/packages/EnrichmentBrowser/) provides additional databases (i.e. [KEGG](https://www.genome.jp/kegg/), [Enrichr](https://maayanlab.cloud/Enrichr/#libraries)), alternate gene identifiers (i.e. ENSEMBL, ENTREZ) or species (i.e. hsa, mmu)

```
library(EnrichmentBrowser)

# KEGG
gs.kegg = getGenesets(org = "hsa",
                      db = "kegg",
                      gene.id.type = "ENSEMBL",
                      return.type = "GeneSetCollection")

## ENRICHR resource
# provides many additional gene set databases
df = showAvailableCollections( org = "hsa", db = "enrichr")

head(df)

# Allen_Brain_Atlas_10x_scRNA_2021
gs.allen = getGenesets( org = "hsa",
                        db = "enrichr",
                        lib = "Allen_Brain_Atlas_10x_scRNA_2021",
                        gene.id.type = "ENSEMBL",
                        return.type = "GeneSetCollection")
```

# Custom gene sets

```
# Load gene sets from GMT file
gmt.file <- system.file("extdata/hsa_kegg_gs.gmt",
                       package = "EnrichmentBrowser")
gs <- getGenesets(gmt.file)
```

# Session Info

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
## [1] knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37     R6_2.6.1          fastmap_1.2.0     xfun_0.53
##  [5] cachem_1.1.0      htmltools_0.5.8.1 rmarkdown_2.30    lifecycle_1.0.4
##  [9] cli_3.6.5         sass_0.4.10       jquerylib_0.1.4   compiler_4.5.1
## [13] tools_4.5.1       evaluate_1.0.5    bslib_0.9.0       yaml_2.3.10
## [17] rlang_1.1.6       jsonlite_2.0.0
```