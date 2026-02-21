# Retrieve GO Gene Sets from BioMart

#### Zuguang Gu (z.gu@dkfz.de)

#### 2023-09-27

This vignette demonstrates how to manually collect GO gene sets from [BioMart](https://www.ensembl.org/info/data/biomart/index.html). The source code for retrieving GO gene sets for all supported organisms on BioMart can be found from the following location:

```
system.file("scripts", "biomart_genesets.R", package = "BioMartGOGeneSets")
```

```
## [1] "/tmp/RtmpIqcgO8/Rinst1bc61e499345c6/BioMartGOGeneSets/scripts/biomart_genesets.R"
```

Retrieving GO gene sets from BioMart is a two-step process.

### Step1. Retrieve the relations between GO terms and genes for a specific organism

The relations can be obtained from BioMart with the R package **biomaRt**. First let’s create a “Mart” object which is like a connection to the BioMart web-service. Because this is a gene-related relation, we set argument `biomart` to `"genes"`.

```
library(biomaRt)
ensembl = useEnsembl(biomart = "genes")
ensembl
```

```
## Object of class 'Mart':
##   Using the ENSEMBL_MART_ENSEMBL BioMart database
##   No dataset selected.
```

Please note, if later when you use **biomaRt** and see errors of “timeout”, you can select a different mirror, such as:

```
useEnsembl(biomart = "genes", mirror = "uswest")
```

Next we need to select an organism. In BioMart, it is called a “dataset”. To get a proper value of an organism dataset, we can use `listDatasets()` to get a list of supported datasets.

```
datasets = listDatasets(ensembl)
dim(datasets)
```

```
## [1] 214   3
```

```
head(datasets)
```

```
##                        dataset                           description
## 1 abrachyrhynchus_gene_ensembl Pink-footed goose genes (ASM259213v1)
## 2     acalliptera_gene_ensembl      Eastern happy genes (fAstCal1.2)
## 3   acarolinensis_gene_ensembl       Green anole genes (AnoCar2.0v2)
## 4    acchrysaetos_gene_ensembl       Golden eagle genes (bAquChr1.2)
## 5    acitrinellus_gene_ensembl        Midas cichlid genes (Midas_v5)
## 6    amelanoleuca_gene_ensembl       Giant panda genes (ASM200744v2)
##       version
## 1 ASM259213v1
## 2  fAstCal1.2
## 3 AnoCar2.0v2
## 4  bAquChr1.2
## 5    Midas_v5
## 6 ASM200744v2
```

You can see there are a huge number of organisms supported in BioMart. The first column in `datasets` contains valid values for `dataset` which will be used in later functions.

Sometimes it is not easy to find the dataset of your organism, especially when the organism is not a model organism. The second column in `datasets` contains dataset descriptions, which sometimes can be helpful to find the right one.

In this example, we use the dataset for human `"hsapiens_gene_ensembl"`.

To use the dataset, we specify `dataset` in the function `useDateset()`, which is like adding a flag of which dataset to use.

```
ensembl = useDataset(dataset = "hsapiens_gene_ensembl", mart = ensembl)
ensembl
```

```
## Object of class 'Mart':
##   Using the ENSEMBL_MART_ENSEMBL BioMart database
##   Using the hsapiens_gene_ensembl dataset
```

The dataset is like a giant table with a huge number of columns which provide massive additional information for genes. Here we are only interested in GO-related information. In the dataset, the table columns are called “attributes”. There are a huge number of supported attributes in a dataset. The complete list of attributes can be obtained by the function `listAttributes()`.

```
all_at = listAttributes(mart = ensembl)
dim(all_at)
```

```
## [1] 3169    3
```

```
head(all_at)
```

```
##                            name                  description         page
## 1               ensembl_gene_id               Gene stable ID feature_page
## 2       ensembl_gene_id_version       Gene stable ID version feature_page
## 3         ensembl_transcript_id         Transcript stable ID feature_page
## 4 ensembl_transcript_id_version Transcript stable ID version feature_page
## 5            ensembl_peptide_id            Protein stable ID feature_page
## 6    ensembl_peptide_id_version    Protein stable ID version feature_page
```

To get proper values for the attributes, we need to go through the long table and sometimes this is not an easy task. The three attributes of GO-gene relations are `c("ensembl_gene_id", "go_id", "namespace_1003")`. Now we can use the function `getBM()` to obtain the GO-gene relation table.

```
at = c("ensembl_gene_id", "go_id", "namespace_1003")
go = getBM(attributes = at, mart = ensembl)
```

Check the first several rows in `go`:

```
head(go)
```

```
##   ensembl_gene_id      go_id     namespace_1003
## 1 ENSG00000210049 GO:0030533 molecular_function
## 2 ENSG00000210049 GO:0006412 biological_process
## 3 ENSG00000211459
## 4 ENSG00000210077
## 5 ENSG00000210082 GO:0003735 molecular_function
## 6 ENSG00000210082 GO:0005840 cellular_component
```

For some organisms, the returned table might be huge, or due to the bad internet connection, the data retrieving may exceed the 5 min limit on BioMart, and you might see the following error:

```
Error in curl::curl_fetch_memory(url, handle = handle) :
  Timeout was reached: [uswest.ensembl.org:443] Operation timed out after 300005 milliseconds with 2966434 bytes received
```

In this case, you might need to split the query into blocks and make sure each job query is small.

```
genes = getBM(attributes = "ensembl_gene_id", mart = ensembl)[, 1]
go1 = getBM(attributes = at, mart = ensembl, filter = "ensembl_gene_id", value = genes[1:1000])
go2 = getBM(attributes = at, mart = ensembl, filter = "ensembl_gene_id", value = genes[1001:2000])
...
rbind(go1, go2, ...)
```

In this example, we will only demonstrate the Biological Process Ontology, and we convert the data frame `go` to a list of genes.

```
go = go[go$namespace_1003 == "biological_process", , drop = FALSE]
gs = split(go$ensembl_gene_id, go$go_id)
```

In `gs`, there are a list of vectors where each vector can be thought as a gene set for the corresponding GO term.

### Step 2. Complete genes in GO gene sets

GO has a tree structure where a parent term includes all genes annotated to its child terms. For every GO terms in `gs`, we need to merge genes from all its child or offspring terms to form a complete gene set for this GO term.

The hierarchical structure of GO terms is stored in the **GO.db** package. In the following code, `bp_terms` contains a vector of GO terms only in the Biological Process ontology. The variable `GOBPOFFSPRING` is simply a list where each element vector contains all offspring terms (child and remote downstream terms) of a GO term.

```
library(GO.db)
bp_terms = GOID(GOTERM)[Ontology(GOTERM) == "BP"]
GOBPOFFSPRING = as.list(GOBPOFFSPRING)
```

Now it is quite easy to merge genes from offspring terms. Just note as the final step, empty GO gene sets should be removed.

```
gs2 = lapply(bp_terms, function(nm) {
  go_id = c(nm, GOBPOFFSPRING[[nm]]) # self + offspring
  unique(unlist(gs[go_id]))
})
names(gs2) = bp_terms
gs2 = gs2[sapply(gs2, length) > 0]
```

## Session info

```
sessionInfo()
```

```
## R version 4.3.1 (2023-06-16)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 22.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.18-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
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
## [1] GO.db_3.18.0         AnnotationDbi_1.63.2 IRanges_2.35.2
## [4] S4Vectors_0.39.2     Biobase_2.61.0       BiocGenerics_0.47.0
## [7] biomaRt_2.57.1       knitr_1.44
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.41.4         xfun_0.40               bslib_0.5.1
##  [4] vctrs_0.6.3             tools_4.3.1             bitops_1.0-7
##  [7] generics_0.1.3          curl_5.0.2              tibble_3.2.1
## [10] fansi_1.0.4             RSQLite_2.3.1           blob_1.2.4
## [13] pkgconfig_2.0.3         dbplyr_2.3.3            lifecycle_1.0.3
## [16] GenomeInfoDbData_1.2.10 compiler_4.3.1          stringr_1.5.0
## [19] Biostrings_2.69.2       progress_1.2.2          GenomeInfoDb_1.37.4
## [22] htmltools_0.5.6         sass_0.4.7              RCurl_1.98-1.12
## [25] yaml_2.3.7              pillar_1.9.0            crayon_1.5.2
## [28] jquerylib_0.1.4         cachem_1.0.8            tidyselect_1.2.0
## [31] digest_0.6.33           stringi_1.7.12          purrr_1.0.2
## [34] dplyr_1.1.3             fastmap_1.1.1           cli_3.6.1
## [37] magrittr_2.0.3          XML_3.99-0.14           utf8_1.2.3
## [40] withr_2.5.1             prettyunits_1.2.0       filelock_1.0.2
## [43] rappdirs_0.3.3          bit64_4.0.5             rmarkdown_2.25
## [46] XVector_0.41.1          httr_1.4.7              bit_4.0.5
## [49] png_0.1-8               hms_1.1.3               memoise_2.0.1
## [52] evaluate_0.21           BiocFileCache_2.9.1     rlang_1.1.1
## [55] glue_1.6.2              DBI_1.1.3               xml2_1.3.5
## [58] jsonlite_1.8.7          R6_2.5.1                zlibbioc_1.47.0
```