# orthogene: Getting Started

#### Author: *Brian M. Schilder*

#### Most recent update: *Jan-05-2026*

# Contents

* [0.1 `orthogene`: Interspecies gene mapping](#orthogene-interspecies-gene-mapping)
* [1 Installation](#installation)
* [2 Examples](#examples)
  + [2.1 Convert orthologs](#convert-orthologs)
    - [2.1.1 Note on non-1:1 orthologs](#note-on-non-11-orthologs)
  + [2.2 Map species](#map-species)
  + [2.3 Report orthologs](#report-orthologs)
  + [2.4 Map genes](#map-genes)
  + [2.5 Aggregate mapped genes](#aggregate-mapped-genes)
  + [2.6 Get all genes](#get-all-genes)
* [3 Session Info](#session-info)

## 0.1 `orthogene`: Interspecies gene mapping

`orthogene` is an R package for easy mapping of orthologous genes
across hundreds of species.
It pulls up-to-date interspecies gene ortholog mappings across 700+ organisms.

It also provides various utility functions to map common objects
(e.g. data.frames, gene expression matrices, lists)
onto 1:1 gene orthologs from any other species.

In brief, `orthogene` lets you easily:

* [**`convert_orthologs`** between any two species](https://neurogenomics.github.io/orthogene/articles/orthogene#convert-orthologs)
* [**`map_species`** names onto standard taxonomic ontologies](https://neurogenomics.github.io/orthogene/articles/orthogene#map-species)
* [**`report_orthologs`** between any two species](https://neurogenomics.github.io/orthogene/articles/orthogene#report-orthologs)
* [**`map_genes`** onto standard ontologies](https://neurogenomics.github.io/orthogene/articles/orthogene#map-genes)
* [**`aggregate_mapped_genes`** in a matrix.](https://neurogenomics.github.io/orthogene/articles/orthogene#aggregate-mapped-genes)
* [get **`all_genes`** from any species](https://neurogenomics.github.io/orthogene/articles/orthogene#get-all-genes)

# 1 Installation

```
if (!requireNamespace("BiocManager", quietly = TRUE))
     install.packages("BiocManager")
# orthogene is only available on Bioconductor>=3.14
if(BiocManager::version()<"3.14") BiocManager::install(version = "3.14")

BiocManager::install("orthogene")
```

```
library(orthogene)

data("exp_mouse")
# Setting to "homologene" for the purposes of quick demonstration.
# We generally recommend using method="gprofiler" (default).
method <- "homologene"
```

# 2 Examples

## 2.1 Convert orthologs

[`convert_orthologs`](https://neurogenomics.github.io/orthogene/reference/convert_orthologs.html) is very flexible with what users can supply as `gene_df`,
and can take a `data.frame`/`data.table`/`tibble`, (sparse) `matrix`,
or `list`/`vector` containing genes.

Genes, transcripts, proteins, SNPs, or genomic ranges will be recognised
in most formats (HGNC, Ensembl, RefSeq, UniProt, etc.)
and can even be a mixture of different formats.

All genes will be mapped to gene symbols, unless specified otherwise with the
`...` arguments (see `?orthogene::convert_orthologs` or [here](https://neurogenomics.github.io/orthogene/reference/convert_orthologs.html) for details).

### 2.1.1 Note on non-1:1 orthologs

A key feature of [`convert_orthologs`](https://neurogenomics.github.io/orthogene/reference/convert_orthologs.html) is that it handles the issue of genes with many-to-many
mappings across species. This can occur due to evolutionary divergence,
and the function of these genes tends to be less conserved and less translatable.
Users can address this using different strategies via `non121_strategy=`:

1. `"drop_both_species"` : Drop genes that have duplicate mappings in either the input\_species or output\_species, (*DEFAULT*).
2. `"drop_input_species"` : Only drop genes that have duplicate mappings in `input_species`.
3. `"drop_output_species"` : Only drop genes that have duplicate mappings in the `output_species`.
4. `"keep_both_species"` : Keep all genes regardless of whether they have duplicate mappings in either species.
5. `"keep_popular"` : Return only the most “popular” interspecies ortholog mappings. This procedure tends to yield a greater number of returned genes but at the cost of many of them not being true biological 1:1 orthologs.

When `gene_df` is a matrix. These strategies can be used together with `agg_fun`. This feature automatically performs both ortholog aggregation (many:1 mappings) and expansion (1:many mappings) of matrices, depending on the situation. This means that you have the option to keep non-1:1 ortholog genes, and still produce a matrix with only 1 gene per row.
Options include:
1. `"sum"`
2. `"mean"`
3. `"median"`
4. `"min"`
5. `"max"`

For more information on how `orthogene` performs matrix aggregation/expansion, see the documentation for the underlying function: `?orthogene:::many2many_rows`

```
gene_df <- orthogene::convert_orthologs(gene_df = exp_mouse,
                                        gene_input = "rownames",
                                        gene_output = "rownames",
                                        input_species = "mouse",
                                        output_species = "human",
                                        non121_strategy = "drop_both_species",
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

```
knitr::kable(as.matrix(head(gene_df)))
```

|  | astrocytes\_ependymal | endothelial-mural | interneurons | microglia | oligodendrocytes | pyramidal CA1 | pyramidal SS |
| --- | --- | --- | --- | --- | --- | --- | --- |
| TSPAN12 | 0.3303571 | 0.5872340 | 0.6413793 | 0.1428571 | 0.1207317 | 0.2864750 | 0.1453634 |
| TSHZ1 | 0.4285714 | 0.4468085 | 1.1551724 | 0.4387755 | 0.3621951 | 0.0692226 | 0.8320802 |
| ADAMTS15 | 0.0089286 | 0.0978723 | 0.2206897 | 0.0000000 | 0.0231707 | 0.0117146 | 0.0375940 |
| CLDN12 | 0.2232143 | 0.1148936 | 0.5517241 | 0.0510204 | 0.2609756 | 0.4376997 | 0.6842105 |
| RXFP1 | 0.0000000 | 0.0127660 | 0.2551724 | 0.0000000 | 0.0158537 | 0.0511182 | 0.0751880 |
| SEMA3C | 0.1964286 | 0.9957447 | 8.6379310 | 0.2040816 | 0.1853659 | 0.1608094 | 0.2280702 |

## 2.2 Map species

[`map_species`](https://neurogenomics.github.io/orthogene/reference/map_species.html) lets you standardise species names from a wide variety of identifiers
(e.g. common name, taxonomy ID, Latin name, partial match).

All exposed `orthogene` functions (including [`convert_orthologs`](https://neurogenomics.github.io/orthogene/reference/convert_orthologs.html))
use `map_species` under the hood, so you don’t have to worry about
getting species names exactly right.

You can check the full list of available species by simply running
`map_species()` with no arguments,
or checking [here](https://biit.cs.ut.ee/gprofiler/page/organism-list).

```
species <- orthogene::map_species(species = c("human",9544,"mus musculus",
                                              "fruit fly","Celegans"),
                                  output_format = "scientific_name")
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
## 1 organism identified from search: Homo sapiens
```

```
## Mapping species name: 9544
```

```
## 1 organism identified from search: Macaca mulatta
```

```
## Mapping species name: mus musculus
```

```
## 1 organism identified from search: Mus musculus
```

```
## Mapping species name: fruit fly
```

```
## Common name mapping found for fruit fly
```

```
## 1 organism identified from search: Drosophila melanogaster
```

```
## Mapping species name: Celegans
```

```
## 1 organism identified from search: Caenorhabditis elegans
```

```
print(species)
```

```
##                     human                      9544              mus musculus
##            "Homo sapiens"          "Macaca mulatta"            "Mus musculus"
##                 fruit fly                  Celegans
## "Drosophila melanogaster"  "Caenorhabditis elegans"
```

## 2.3 Report orthologs

It may be helpful to know the maximum expected number of orthologous
gene mappings from one species to another.

[`ortholog_report`](https://neurogenomics.github.io/orthogene/reference/report_orthologs.html) generates a report that tells you this information
genome-wide.

```
orth_zeb <- orthogene::report_orthologs(target_species = "zebrafish",
                                        reference_species = "human",
                                        method_all_genes = method,
                                        method_convert_orthologs = method)
```

```
## Gathering ortholog reports.
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
## Warning in system2(sprintf("echo \"%s\"", paste0(..., collapse = ""))): error
## in running command
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
## --
## --
```

```
## Preparing gene_df.
```

```
## data.frame format detected.
```

```
## Extracting genes from Gene.Symbol.
```

```
## 20,897 genes extracted.
```

```
## Converting zebrafish ==> human orthologs using: homologene
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
## 14,768 genes extracted.
```

```
## Extracting genes from ortholog_gene.
```

```
## 14,768 genes extracted.
```

```
## Checking for genes without 1:1 orthologs.
```

```
## Dropping 46 genes that have multiple input_gene per ortholog_gene (many:1).
```

```
## Dropping 2,707 genes that have multiple ortholog_gene per input_gene (1:many).
```

```
## Filtering gene_df with gene_map
```

```
## Adding input_gene col to gene_df.
```

```
## Adding ortholog_gene col to gene_df.
```

```
##
## =========== REPORT SUMMARY ===========
```

```
## Total genes dropped after convert_orthologs :
##    1.034e+04 / 20,895 (49%)
```

```
## Total genes remaining after convert_orthologs :
##    10,557 / 20,895 (51%)
```

```
## --
```

```
##
## =========== REPORT SUMMARY ===========
```

```
## 10,557 / 20,895 (50.52%) target_species genes remain after ortholog conversion.
```

```
## 10,557 / 19,129 (55.19%) reference_species genes remain after ortholog conversion.
```

```
knitr::kable(head(orth_zeb$map))
```

| input\_species | target\_species | reference\_species | input\_gene | ortholog\_gene |
| --- | --- | --- | --- | --- |
| zebrafish | danio rerio | homo sapiens | acadm | ACADM |
| zebrafish | danio rerio | homo sapiens | acadvl | ACADVL |
| zebrafish | danio rerio | homo sapiens | acat1 | ACAT1 |
| zebrafish | danio rerio | homo sapiens | acvr1l | ACVR1 |
| zebrafish | danio rerio | homo sapiens | adsl | ADSL |
| zebrafish | danio rerio | homo sapiens | aga | AGA |

```
knitr::kable(orth_zeb$report)
```

| input\_species | target\_species | target\_total\_genes | reference\_species | reference\_total\_genes | one2one\_orthologs | target\_percent | reference\_percent |
| --- | --- | --- | --- | --- | --- | --- | --- |
| zebrafish | danio rerio | 20895 | homo sapiens | 19129 | 10557 | 50.52 | 55.19 |

## 2.4 Map genes

[`map_genes`](https://neurogenomics.github.io/orthogene/reference/map_genes.html) finds matching *within-species* synonyms across a wide variety of gene naming conventions (HGNC, Ensembl, RefSeq, UniProt, etc.) and returns a table with standardised gene symbols (or whatever output format you prefer).

```
genes <-  c("Klf4", "Sox2", "TSPAN12","NM_173007","Q8BKT6",9999,
             "ENSMUSG00000012396","ENSMUSG00000074637")
mapped_genes <- orthogene::map_genes(genes = genes,
                                     species = "mouse",
                                     drop_na = FALSE)
```

```
## Retrieving all organisms available in gprofiler.
```

```
## Using stored `gprofiler_orgs`.
```

```
## Mapping species name: mouse
```

```
## Common name mapping found for mouse
```

```
## 1 organism identified from search: mmusculus
```

```
## 7 / 8 (87.5%) genes mapped.
```

```
knitr::kable(head(mapped_genes))
```

| input\_number | input | target\_number | target | name | description | namespace |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | Klf4 | 1.1 | ENSMUSG00000003032 | Klf4 | Kruppel-like transcription factor 4 (gut) [Source:MGI Symbol;Acc:MGI:1342287] | ENTREZGENE,MGI,UNIPROT\_GN,WIKIGENE |
| 2 | Sox2 | 2.1 | ENSMUSG00000074637 | Sox2 | SRY (sex determining region Y)-box 2 [Source:MGI Symbol;Acc:MGI:98364] | ENTREZGENE,MGI,UNIPROT\_GN,WIKIGENE |
| 3 | TSPAN12 | 3.1 | ENSMUSG00000029669 | Tspan12 | tetraspanin 12 [Source:MGI Symbol;Acc:MGI:1889818] | ENTREZGENE,MGI,UNIPROT\_GN,WIKIGENE |
| 4 | NM\_173007 | 4.1 | ENSMUSG00000029669 | Tspan12 | tetraspanin 12 [Source:MGI Symbol;Acc:MGI:1889818] | REFSEQ\_MRNA\_ACC |
| 5 | Q8BKT6 | 5.1 | ENSMUSG00000029669 | Tspan12 | tetraspanin 12 [Source:MGI Symbol;Acc:MGI:1889818] | UNIPROTSWISSPROT\_ACC,UNIPROT\_GN\_ACC |
| 6 | 9999 | 6.1 | NA | NA | NA |  |

## 2.5 Aggregate mapped genes

`aggregate_mapped_genes` does the following:

1. Uses `map_genes` to identify *within-species* many-to-one gene mappings (e.g. Ensembl transcript IDs ==> gene symbols). Alternatively, can map *across species* if output from `map_orthologs` is supplied to `gene_map` argument (and `gene_map_col="ortholog_gene"`).
2. Drops all non-mappable genes.
3. Aggregates the values of matrix `gene_df` using `"sum"`,`"mean"`,`"median"`,`"min"` or `"max"`.

Note, this only works when the input data (`gene_df`) is a sparse or dense matrix, and the genes are row names.

```
data("exp_mouse_enst")
knitr::kable(tail(as.matrix(exp_mouse_enst)))
```

|  | astrocytes\_ependymal | endothelial-mural | interneurons | microglia | oligodendrocytes | pyramidal CA1 | pyramidal SS |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ENSMUST00000102875 | 2.8258910 | 0.4041560 | 1.3171987 | 0.3774840 | 1.3426606 | 1.0403481 | 1.0876508 |
| ENSMUST00000133343 | 2.8259032 | 0.4042189 | 1.3171312 | 0.3774038 | 1.3425772 | 1.0403432 | 1.0876385 |
| ENSMUST00000143890 | 2.8258554 | 0.4041963 | 1.3171145 | 0.3774192 | 1.3426119 | 1.0403496 | 1.0876334 |
| ENSMUST00000005053 | 0.4597978 | 0.3403299 | 0.9067953 | 0.2958589 | 0.7254482 | 0.4813420 | 0.7418000 |
| ENSMUST00000185896 | 0.4596631 | 0.3403637 | 0.9067538 | 0.2958896 | 0.7255006 | 0.4812783 | 0.7417918 |
| ENSMUST00000188282 | 0.4597399 | 0.3403441 | 0.9067727 | 0.2957819 | 0.7255681 | 0.4811978 | 0.7417924 |

```
exp_agg <- orthogene::aggregate_mapped_genes(gene_df=exp_mouse_enst,
                                             input_species="mouse",
                                             agg_fun = "sum")
```

```
## Retrieving all organisms available in gprofiler.
```

```
## Using stored `gprofiler_orgs`.
```

```
## Mapping species name: mouse
```

```
## Common name mapping found for mouse
```

```
## 1 organism identified from search: mmusculus
```

```
## 473 / 482 (98.13%) genes mapped.
```

```
## Aggregating rows using: monocle3
```

```
## Converting obj to sparseMatrix.
```

```
## Matrix aggregated:
##   - Input: 482 x 7
##   - Output: 92 x 7
```

```
knitr::kable(tail(as.matrix(exp_agg)))
```

|  | astrocytes\_ependymal | endothelial-mural | interneurons | microglia | oligodendrocytes | pyramidal CA1 | pyramidal SS |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Tspan12 | 1.9815939 | 3.5228954 | 3.847706 | 0.8565873 | 0.7237384 | 1.7184690 | 0.8716624 |
| Ugp2 | 11.3034339 | 1.6167531 | 5.268556 | 1.5096830 | 5.3705113 | 4.1614945 | 4.3505804 |
| Usp28 | 1.5615450 | 1.4885072 | 12.481956 | 0.9176950 | 1.0237324 | 5.5261972 | 6.4652509 |
| Vat1l | 0.1781170 | 0.0337314 | 1.199619 | 0.0812187 | 0.1165772 | 0.2339571 | 0.4006268 |
| Wtap | 2.6913832 | 2.4118074 | 12.289111 | 3.5809075 | 3.2808114 | 9.3443456 | 8.6384533 |
| Zfp1006 | 0.4012512 | 0.7910314 | 2.523325 | 0.2444053 | 0.7603213 | 1.9355976 | 1.9392834 |

## 2.6 Get all genes

You can also quickly get all known genes from the genome of a given species with [`all_genes`](https://neurogenomics.github.io/orthogene/reference/all_genes.html).

```
genome_mouse <- orthogene::all_genes(species = "mouse",
                                     method = method)
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
knitr::kable(head(genome_mouse))
```

|  | HID | Gene.ID | Gene.Symbol | taxonomy\_id |
| --- | --- | --- | --- | --- |
| 6 | 3 | 11364 | Acadm | 10090 |
| 18 | 5 | 11370 | Acadvl | 10090 |
| 29 | 6 | 110446 | Acat1 | 10090 |
| 52 | 7 | 11477 | Acvr1 | 10090 |
| 64 | 9 | 20391 | Sgca | 10090 |
| 71 | 12 | 11564 | Adsl | 10090 |

# 3 Session Info

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
##  [1] ggiraph_0.9.2             tidyselect_1.2.1
##  [3] viridisLite_0.4.2         dplyr_1.1.4
##  [5] farver_2.1.2              S7_0.2.1
##  [7] bitops_1.0-9              fastmap_1.2.0
##  [9] lazyeval_0.2.2            RCurl_1.98-1.17
## [11] homologene_1.4.68.19.3.27 fontquiver_0.2.1
## [13] digest_0.6.39             lifecycle_1.0.4
## [15] tidytree_0.4.6            magrittr_2.0.4
## [17] compiler_4.5.2            rlang_1.1.6
## [19] sass_0.4.10               tools_4.5.2
## [21] yaml_2.3.12               data.table_1.18.0
## [23] knitr_1.51                ggsignif_0.6.4
## [25] labeling_0.4.3            htmlwidgets_1.6.4
## [27] curl_7.0.0                RColorBrewer_1.1-3
## [29] aplot_0.2.9               abind_1.4-8
## [31] babelgene_22.9            withr_3.0.2
## [33] purrr_1.2.0               grid_4.5.2
## [35] ggpubr_0.6.2              gdtools_0.4.4
## [37] ggplot2_4.0.1             scales_1.4.0
## [39] dichromat_2.0-0.1         tinytex_0.58
## [41] cli_3.6.5                 rmarkdown_2.30
## [43] treeio_1.34.0             generics_0.1.4
## [45] otel_0.2.0                ggtree_4.0.4
## [47] httr_1.4.7                gprofiler2_0.2.4
## [49] ape_5.8-1                 cachem_1.1.0
## [51] parallel_4.5.2            ggplotify_0.1.3
## [53] BiocManager_1.30.27       yulab.utils_0.2.3
## [55] vctrs_0.6.5               Matrix_1.7-4
## [57] jsonlite_2.0.0            fontBitstreamVera_0.1.1
## [59] carData_3.0-5             bookdown_0.46
## [61] car_3.1-3                 gridGraphics_0.5-1
## [63] patchwork_1.3.2           rstatix_0.7.3
## [65] Formula_1.2-5             systemfonts_1.3.1
## [67] magick_2.9.0              plotly_4.11.0
## [69] tidyr_1.3.2               jquerylib_0.1.4
## [71] glue_1.8.0                gtable_0.3.6
## [73] tibble_3.3.0              pillar_1.11.1
## [75] rappdirs_0.3.3            htmltools_0.5.9
## [77] R6_2.6.1                  evaluate_1.0.5
## [79] lattice_0.22-7            backports_1.5.0
## [81] broom_1.0.11              ggfun_0.2.0
## [83] fontLiberation_0.1.0      bslib_0.9.0
## [85] Rcpp_1.1.0                nlme_3.1-168
## [87] xfun_0.55                 fs_1.6.6
## [89] pkgconfig_2.0.3
```