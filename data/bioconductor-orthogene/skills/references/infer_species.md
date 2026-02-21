# Infer species

#### Author: *Brian M. Schilder*

#### Most recent update: *Jan-05-2026*

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
* [3 Examples](#examples)
  + [3.1 Mouse genes](#mouse-genes)
    - [3.1.1 Infer the species](#infer-the-species)
  + [3.2 Rat genes](#rat-genes)
    - [3.2.1 Create example data](#create-example-data)
    - [3.2.2 Infer the species](#infer-the-species-1)
  + [3.3 Human genes](#human-genes)
    - [3.3.1 Create example data](#create-example-data-1)
    - [3.3.2 Infer the species](#infer-the-species-2)
* [4 Additional `test_species`](#additional-test_species)
* [5 Session Info](#session-info)

# 1 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
     install.packages("BiocManager")
# orthogene is only available on Bioconductor>=3.14
if(BiocManager::version()<"3.14")
  BiocManager::install(update = TRUE, ask = FALSE)

BiocManager::install("orthogene")
```

```
library(orthogene)

data("exp_mouse")
# Setting to "homologene" for the purposes of quick demonstration.
# We generally recommend using method="gprofiler" (default).
method <- "homologene"
```

# 2 Introduction

It’s not always clear whether a dataset is using the
original species gene names,
human gene names, or some other species’ gene names.

`infer_species` takes a list/matrix/data.frame with genes and
infers the species that they best match to!

For the sake of speed, the genes extracted from `gene_df`
are tested against genomes from only the following 6 `test_species` by default:
- human
- monkey
- rat
- mouse
- zebrafish
- fly

However, you can supply your own list of `test_species`, which will
be automatically be mapped and standardised using `map_species`.

# 3 Examples

## 3.1 Mouse genes

### 3.1.1 Infer the species

```
matches <- orthogene::infer_species(gene_df = exp_mouse,
                                    method = method)
```

```
## Preparing gene_df.
```

```
## sparseMatrix format detected.
```

```
## Extracting genes from rownames.
```

```
## 15,259 genes extracted.
```

```
## Testing for gene overlap with: human
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: human
```

```
## Common name mapping found for human
```

```
## 1 organism identified from search: 9606
```

```
## Gene table with 19,129 rows retrieved.
```

```
## Returning all 19,129 genes from human.
```

```
## Testing for gene overlap with: monkey
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: monkey
```

```
## Common name mapping found for monkey
```

```
## 1 organism identified from search: 9544
```

```
## Gene table with 16,843 rows retrieved.
```

```
## Returning all 16,843 genes from monkey.
```

```
## Testing for gene overlap with: rat
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: rat
```

```
## Common name mapping found for rat
```

```
## 1 organism identified from search: 10116
```

```
## Gene table with 20,616 rows retrieved.
```

```
## Returning all 20,616 genes from rat.
```

```
## Testing for gene overlap with: mouse
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: mouse
```

```
## Common name mapping found for mouse
```

```
## 1 organism identified from search: 10090
```

```
## Gene table with 21,207 rows retrieved.
```

```
## Returning all 21,207 genes from mouse.
```

```
## Testing for gene overlap with: zebrafish
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: zebrafish
```

```
## Common name mapping found for zebrafish
```

```
## 1 organism identified from search: 7955
```

```
## Gene table with 20,897 rows retrieved.
```

```
## Returning all 20,897 genes from zebrafish.
```

```
## Testing for gene overlap with: fly
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: fly
```

```
## Common name mapping found for fly
```

```
## 1 organism identified from search: 7227
```

```
## Gene table with 8,438 rows retrieved.
```

```
## Returning all 8,438 genes from fly.
```

```
## Top match:
##   - species: mouse
##   - percent_match: 92%
```

![](data:image/png;base64...)

## 3.2 Rat genes

### 3.2.1 Create example data

To create an example dataset, turn the gene names into rat genes.

```
exp_rat <- orthogene::convert_orthologs(gene_df = exp_mouse,
                                        input_species = "mouse",
                                        output_species = "rat",
                                        method = method)
```

```
## Preparing gene_df.
```

```
## sparseMatrix format detected.
```

```
## Extracting genes from rownames.
```

```
## 15,259 genes extracted.
```

```
## Converting mouse ==> rat orthologs using: homologene
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: mouse
```

```
## Common name mapping found for mouse
```

```
## 1 organism identified from search: 10090
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: rat
```

```
## Common name mapping found for rat
```

```
## 1 organism identified from search: 10116
```

```
## Checking for genes without orthologs in rat.
```

```
## Extracting genes from input_gene.
```

```
## 13,812 genes extracted.
```

```
## Extracting genes from ortholog_gene.
```

```
## 13,812 genes extracted.
```

```
## Checking for genes without 1:1 orthologs.
```

```
## Dropping 486 genes that have multiple input_gene per ortholog_gene (many:1).
```

```
## Dropping 148 genes that have multiple ortholog_gene per input_gene (1:many).
```

```
## Filtering gene_df with gene_map
```

```
## Setting ortholog_gene to rownames.
```

```
##
## =========== REPORT SUMMARY ===========
```

```
## Total genes dropped after convert_orthologs :
##    2,322 / 15,259 (15%)
```

```
## Total genes remaining after convert_orthologs :
##    12,937 / 15,259 (85%)
```

### 3.2.2 Infer the species

```
matches <- orthogene::infer_species(gene_df = exp_rat,
                                    method = method)
```

```
## Preparing gene_df.
```

```
## sparseMatrix format detected.
```

```
## Extracting genes from rownames.
```

```
## 12,937 genes extracted.
```

```
## Testing for gene overlap with: human
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: human
```

```
## Common name mapping found for human
```

```
## 1 organism identified from search: 9606
```

```
## Gene table with 19,129 rows retrieved.
```

```
## Returning all 19,129 genes from human.
```

```
## Testing for gene overlap with: monkey
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: monkey
```

```
## Common name mapping found for monkey
```

```
## 1 organism identified from search: 9544
```

```
## Gene table with 16,843 rows retrieved.
```

```
## Returning all 16,843 genes from monkey.
```

```
## Testing for gene overlap with: rat
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: rat
```

```
## Common name mapping found for rat
```

```
## 1 organism identified from search: 10116
```

```
## Gene table with 20,616 rows retrieved.
```

```
## Returning all 20,616 genes from rat.
```

```
## Testing for gene overlap with: mouse
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: mouse
```

```
## Common name mapping found for mouse
```

```
## 1 organism identified from search: 10090
```

```
## Gene table with 21,207 rows retrieved.
```

```
## Returning all 21,207 genes from mouse.
```

```
## Testing for gene overlap with: zebrafish
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: zebrafish
```

```
## Common name mapping found for zebrafish
```

```
## 1 organism identified from search: 7955
```

```
## Gene table with 20,897 rows retrieved.
```

```
## Returning all 20,897 genes from zebrafish.
```

```
## Testing for gene overlap with: fly
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: fly
```

```
## Common name mapping found for fly
```

```
## 1 organism identified from search: 7227
```

```
## Gene table with 8,438 rows retrieved.
```

```
## Returning all 8,438 genes from fly.
```

```
## Top match:
##   - species: rat
##   - percent_match: 100%
```

![](data:image/png;base64...)

## 3.3 Human genes

### 3.3.1 Create example data

To create an example dataset, turn the gene names into human genes.

```
exp_human <- orthogene::convert_orthologs(gene_df = exp_mouse,
                                          input_species = "mouse",
                                          output_species = "human",
                                          method = method)
```

```
## Preparing gene_df.
```

```
## sparseMatrix format detected.
```

```
## Extracting genes from rownames.
```

```
## 15,259 genes extracted.
```

```
## Converting mouse ==> human orthologs using: homologene
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: mouse
```

```
## Common name mapping found for mouse
```

```
## 1 organism identified from search: 10090
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: human
```

```
## Common name mapping found for human
```

```
## 1 organism identified from search: 9606
```

```
## Checking for genes without orthologs in human.
```

```
## Extracting genes from input_gene.
```

```
## 13,416 genes extracted.
```

```
## Extracting genes from ortholog_gene.
```

```
## 13,416 genes extracted.
```

```
## Checking for genes without 1:1 orthologs.
```

```
## Dropping 46 genes that have multiple input_gene per ortholog_gene (many:1).
```

```
## Dropping 56 genes that have multiple ortholog_gene per input_gene (1:many).
```

```
## Filtering gene_df with gene_map
```

```
## Setting ortholog_gene to rownames.
```

```
##
## =========== REPORT SUMMARY ===========
```

```
## Total genes dropped after convert_orthologs :
##    2,016 / 15,259 (13%)
```

```
## Total genes remaining after convert_orthologs :
##    13,243 / 15,259 (87%)
```

### 3.3.2 Infer the species

```
matches <- orthogene::infer_species(gene_df = exp_human,
                                    method = method)
```

```
## Preparing gene_df.
```

```
## sparseMatrix format detected.
```

```
## Extracting genes from rownames.
```

```
## 13,243 genes extracted.
```

```
## Testing for gene overlap with: human
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: human
```

```
## Common name mapping found for human
```

```
## 1 organism identified from search: 9606
```

```
## Gene table with 19,129 rows retrieved.
```

```
## Returning all 19,129 genes from human.
```

```
## Testing for gene overlap with: monkey
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: monkey
```

```
## Common name mapping found for monkey
```

```
## 1 organism identified from search: 9544
```

```
## Gene table with 16,843 rows retrieved.
```

```
## Returning all 16,843 genes from monkey.
```

```
## Testing for gene overlap with: rat
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: rat
```

```
## Common name mapping found for rat
```

```
## 1 organism identified from search: 10116
```

```
## Gene table with 20,616 rows retrieved.
```

```
## Returning all 20,616 genes from rat.
```

```
## Testing for gene overlap with: mouse
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: mouse
```

```
## Common name mapping found for mouse
```

```
## 1 organism identified from search: 10090
```

```
## Gene table with 21,207 rows retrieved.
```

```
## Returning all 21,207 genes from mouse.
```

```
## Testing for gene overlap with: zebrafish
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: zebrafish
```

```
## Common name mapping found for zebrafish
```

```
## 1 organism identified from search: 7955
```

```
## Gene table with 20,897 rows retrieved.
```

```
## Returning all 20,897 genes from zebrafish.
```

```
## Testing for gene overlap with: fly
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: fly
```

```
## Common name mapping found for fly
```

```
## 1 organism identified from search: 7227
```

```
## Gene table with 8,438 rows retrieved.
```

```
## Returning all 8,438 genes from fly.
```

```
## Top match:
##   - species: human
##   - percent_match: 100%
```

![](data:image/png;base64...)

# 4 Additional `test_species`

You can even supply `test_species` with the name of one of the R packages that
`orthogene` gets orthologs from. This will test against all species available
in that particular R package.

For example, by setting `test_species="homologene"` we automatically test for
% gene matches in each of the 20+ species available in `homologene`.

```
matches <- orthogene::infer_species(gene_df = exp_human,
                                    test_species = method,
                                    method = method)
```

```
## Retrieving all organisms available in homologene.
```

```
## Preparing gene_df.
```

```
## sparseMatrix format detected.
```

```
## Extracting genes from rownames.
```

```
## 13,243 genes extracted.
```

```
## Testing for gene overlap with: Mus musculus
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Mus musculus
```

```
## 1 organism identified from search: 10090
```

```
## Gene table with 21,207 rows retrieved.
```

```
## Returning all 21,207 genes from Mus musculus.
```

```
## Testing for gene overlap with: Rattus norvegicus
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Rattus norvegicus
```

```
## 1 organism identified from search: 10116
```

```
## Gene table with 20,616 rows retrieved.
```

```
## Returning all 20,616 genes from Rattus norvegicus.
```

```
## Testing for gene overlap with: Kluyveromyces lactis
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Kluyveromyces lactis
```

```
## 1 organism identified from search: 28985
```

```
## Gene table with 4,283 rows retrieved.
```

```
## Returning all 4,283 genes from Kluyveromyces lactis.
```

```
## Testing for gene overlap with: Magnaporthe oryzae
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Magnaporthe oryzae
```

```
## 1 organism identified from search: 318829
```

```
## Gene table with 6,598 rows retrieved.
```

```
## Returning all 6,598 genes from Magnaporthe oryzae.
```

```
## Testing for gene overlap with: Eremothecium gossypii
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Eremothecium gossypii
```

```
## 1 organism identified from search: 33169
```

```
## Gene table with 3,874 rows retrieved.
```

```
## Returning all 3,874 genes from Eremothecium gossypii.
```

```
## Testing for gene overlap with: Arabidopsis thaliana
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Arabidopsis thaliana
```

```
## 1 organism identified from search: 3702
```

```
## Gene table with 19,143 rows retrieved.
```

```
## Returning all 19,143 genes from Arabidopsis thaliana.
```

```
## Testing for gene overlap with: Oryza sativa
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Oryza sativa
```

```
## 1 organism identified from search: 4530
```

```
## Gene table with 16,112 rows retrieved.
```

```
## Returning all 16,112 genes from Oryza sativa.
```

```
## Testing for gene overlap with: Schizosaccharomyces pombe
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Schizosaccharomyces pombe
```

```
## 1 organism identified from search: 4896
```

```
## Gene table with 3,018 rows retrieved.
```

```
## Returning all 3,018 genes from Schizosaccharomyces pombe.
```

```
## Testing for gene overlap with: Saccharomyces cerevisiae
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Saccharomyces cerevisiae
```

```
## 1 organism identified from search: 4932
```

```
## Gene table with 4,579 rows retrieved.
```

```
## Returning all 4,579 genes from Saccharomyces cerevisiae.
```

```
## Testing for gene overlap with: Neurospora crassa
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Neurospora crassa
```

```
## 1 organism identified from search: 5141
```

```
## Gene table with 5,807 rows retrieved.
```

```
## Returning all 5,807 genes from Neurospora crassa.
```

```
## Testing for gene overlap with: Caenorhabditis elegans
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Caenorhabditis elegans
```

```
## 1 organism identified from search: 6239
```

```
## Gene table with 7,575 rows retrieved.
```

```
## Returning all 7,575 genes from Caenorhabditis elegans.
```

```
## Testing for gene overlap with: Anopheles gambiae
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Anopheles gambiae
```

```
## 1 organism identified from search: 7165
```

```
## Gene table with 8,428 rows retrieved.
```

```
## Returning all 8,428 genes from Anopheles gambiae.
```

```
## Testing for gene overlap with: Drosophila melanogaster
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Drosophila melanogaster
```

```
## 1 organism identified from search: 7227
```

```
## Gene table with 8,438 rows retrieved.
```

```
## Returning all 8,438 genes from Drosophila melanogaster.
```

```
## Testing for gene overlap with: Danio rerio
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Danio rerio
```

```
## 1 organism identified from search: 7955
```

```
## Gene table with 20,897 rows retrieved.
```

```
## Returning all 20,897 genes from Danio rerio.
```

```
## Testing for gene overlap with: Xenopus (Silurana) tropicalis
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Xenopus (Silurana) tropicalis
```

```
## 1 organism identified from search: 8364
```

```
## Gene table with 18,446 rows retrieved.
```

```
## Returning all 18,446 genes from Xenopus (Silurana) tropicalis.
```

```
## Testing for gene overlap with: Gallus gallus
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Gallus gallus
```

```
## 1 organism identified from search: 9031
```

```
## Gene table with 14,600 rows retrieved.
```

```
## Returning all 14,600 genes from Gallus gallus.
```

```
## Testing for gene overlap with: Macaca mulatta
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Macaca mulatta
```

```
## 1 organism identified from search: 9544
```

```
## Gene table with 16,843 rows retrieved.
```

```
## Returning all 16,843 genes from Macaca mulatta.
```

```
## Testing for gene overlap with: Pan troglodytes
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Pan troglodytes
```

```
## 1 organism identified from search: 9598
```

```
## Gene table with 18,730 rows retrieved.
```

```
## Returning all 18,730 genes from Pan troglodytes.
```

```
## Testing for gene overlap with: Homo sapiens
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Homo sapiens
```

```
## 1 organism identified from search: 9606
```

```
## Gene table with 19,129 rows retrieved.
```

```
## Returning all 19,129 genes from Homo sapiens.
```

```
## Testing for gene overlap with: Canis lupus familiaris
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Canis lupus familiaris
```

```
## 1 organism identified from search: 9615
```

```
## Gene table with 18,117 rows retrieved.
```

```
## Returning all 18,117 genes from Canis lupus familiaris.
```

```
## Testing for gene overlap with: Bos taurus
```

```
## Retrieving all genes using: homologene.
```

```
## Retrieving all organisms available in homologene.
```

```
## Mapping species name: Bos taurus
```

```
## 1 organism identified from search: 9913
```

```
## Gene table with 18,797 rows retrieved.
```

```
## Returning all 18,797 genes from Bos taurus.
```

```
## Top match:
##   - species: Homo sapiens
##   - percent_match: 100%
```

![](data:image/png;base64...)

# 5 Session Info

```
utils::sessionInfo()
```

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
## [1] orthogene_1.16.1 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6              babelgene_22.9
##  [3] xfun_0.55                 bslib_0.9.0
##  [5] ggplot2_4.0.1             htmlwidgets_1.6.4
##  [7] rstatix_0.7.3             lattice_0.22-7
##  [9] vctrs_0.6.5               tools_4.5.2
## [11] generics_0.1.4            yulab.utils_0.2.3
## [13] parallel_4.5.2            tibble_3.3.0
## [15] pkgconfig_2.0.3           Matrix_1.7-4
## [17] data.table_1.18.0         homologene_1.4.68.19.3.27
## [19] ggplotify_0.1.3           RColorBrewer_1.1-3
## [21] S7_0.2.1                  lifecycle_1.0.4
## [23] compiler_4.5.2            farver_2.1.2
## [25] treeio_1.34.0             tinytex_0.58
## [27] carData_3.0-5             ggtree_4.0.4
## [29] gprofiler2_0.2.4          fontLiberation_0.1.0
## [31] fontquiver_0.2.1          ggfun_0.2.0
## [33] htmltools_0.5.9           sass_0.4.10
## [35] yaml_2.3.12               lazyeval_0.2.2
## [37] plotly_4.11.0             Formula_1.2-5
## [39] pillar_1.11.1             car_3.1-3
## [41] ggpubr_0.6.2              jquerylib_0.1.4
## [43] tidyr_1.3.2               cachem_1.1.0
## [45] magick_2.9.0              abind_1.4-8
## [47] fontBitstreamVera_0.1.1   nlme_3.1-168
## [49] tidyselect_1.2.1          aplot_0.2.9
## [51] digest_0.6.39             dplyr_1.1.4
## [53] purrr_1.2.0               bookdown_0.46
## [55] labeling_0.4.3            fastmap_1.2.0
## [57] grid_4.5.2                cli_3.6.5
## [59] magrittr_2.0.4            patchwork_1.3.2
## [61] dichromat_2.0-0.1         broom_1.0.11
## [63] ape_5.8-1                 withr_3.0.2
## [65] gdtools_0.4.4             scales_1.4.0
## [67] backports_1.5.0           rappdirs_0.3.3
## [69] httr_1.4.7                rmarkdown_2.30
## [71] otel_0.2.0                ggsignif_0.6.4
## [73] evaluate_1.0.5            knitr_1.51
## [75] viridisLite_0.4.2         gridGraphics_0.5-1
## [77] rlang_1.1.6               ggiraph_0.9.2
## [79] Rcpp_1.1.0                glue_1.8.0
## [81] tidytree_0.4.6            BiocManager_1.30.27
## [83] jsonlite_2.0.0            R6_2.6.1
## [85] systemfonts_1.3.1         fs_1.6.6
```