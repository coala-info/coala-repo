# Simple food over representation analysis (ORA)

Pol Castellano-Escuder1\*

1Duke University

\*polcaes@gmail.com

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Load `fobitools`](#load-fobitools)
* [3 `metaboliteUniverse` and `metaboliteList`](#metaboliteuniverse-and-metabolitelist)
* [4 Network visualization of `metaboliteList` terms](#network-visualization-of-metabolitelist-terms)
* [5 Session Information](#session-information)
* [References](#references)

**Compiled date**: 2025-10-30

**Last edited**: 2022-01-12

**License**: GPL-3

# 1 Installation

Run the following code to install the Bioconductor version of the package.

```
# install.packages("BiocManager")
BiocManager::install("fobitools")
```

# 2 Load `fobitools`

```
library(fobitools)
```

You can also load some additional packages that will be very useful in this vignette.

```
library(dplyr)
library(kableExtra)
```

# 3 `metaboliteUniverse` and `metaboliteList`

In microarrays, for example, we can study almost all the genes of an organism in our sample, so it makes sense to perform an over representation analysis (ORA) considering all the genes present in Gene Ontology (GO). Since most of the GO pathways would be represented by some gene in the microarray.

This is different in nutrimetabolomics. Targeted nutrimetabolomics studies sets of about 200-500 diet-related metabolites, so it would not make sense to use all known metabolites (for example in HMDB or CHEBI) in an ORA, as most of them would not have been quantified in the study.

In nutrimetabolomic studies it may be interesting to study enriched or over represented foods/food groups by the metabolites resulting from the study statistical analysis, rather than the enriched metabolic pathways, as would make more sense in genomics or other metabolomics studies.

The [Food-Biomarker Ontology (FOBI)](https://academic.oup.com/database/article/doi/10.1093/databa/baaa033/5857401) provides a biological knowledge for conducting these enrichment analyses in nutrimetabolomic studies, as FOBI provides the relationships between several foods and their associated dietary metabolites (Castellano-Escuder et al. [2020](#ref-castellano2020fobi)).

Accordingly, to perform an ORA with the `fobitools` package, it is necessary to provide a metabolite universe (all metabolites included in the statistical analysis) and a list of selected metabolites (selected metabolites according to a statistical criterion).

Here is an example:

```
# select 300 random metabolites from FOBI
idx_universe <- sample(nrow(fobitools::idmap), 300, replace = FALSE)
metaboliteUniverse <- fobitools::idmap %>%
  dplyr::slice(idx_universe) %>%
  pull(FOBI)

# select 10 random metabolites from metaboliteUniverse that are associated with 'Red meat' (FOBI:0193),
# 'Lean meat' (FOBI:0185) , 'egg food product' (FOODON:00001274),
# or 'grape (whole, raw)' (FOODON:03301702)
fobi_subset <- fobitools::fobi %>% # equivalent to `parse_fobi()`
  filter(FOBI %in% metaboliteUniverse) %>%
  filter(id_BiomarkerOf %in% c("FOBI:0193", "FOBI:0185", "FOODON:00001274", "FOODON:03301702")) %>%
  dplyr::slice(sample(nrow(.), 10, replace = FALSE))

metaboliteList <- fobi_subset %>%
  pull(FOBI)
```

```
fobitools::ora(metaboliteList = metaboliteList,
               metaboliteUniverse = metaboliteUniverse,
               subOntology = "food",
               pvalCutoff = 0.01)
```

| className | classSize | overlap | pval | padj | overlapMetabolites |
| --- | --- | --- | --- | --- | --- |
| black tea leaf (dry) | 7 | 5 | 0.0000003 | 0.0000176 | FOBI:030…. |
| kale leaf (raw) | 7 | 5 | 0.0000003 | 0.0000176 | FOBI:030…. |
| Red meat | 13 | 6 | 0.0000003 | 0.0000176 | FOBI:030…. |
| apple juice | 8 | 5 | 0.0000007 | 0.0000211 | FOBI:030…. |
| orange juice | 8 | 5 | 0.0000007 | 0.0000211 | FOBI:030…. |
| green tea leaf (dry) | 9 | 5 | 0.0000015 | 0.0000293 | FOBI:030…. |
| red tea | 9 | 5 | 0.0000015 | 0.0000293 | FOBI:030…. |
| red velvet | 9 | 5 | 0.0000015 | 0.0000293 | FOBI:030…. |
| lemon (whole, raw) | 17 | 6 | 0.0000024 | 0.0000398 | FOBI:030…. |
| White fish | 5 | 4 | 0.0000031 | 0.0000398 | FOBI:030…. |
| white bread | 5 | 4 | 0.0000031 | 0.0000398 | FOBI:030…. |
| white wine | 5 | 4 | 0.0000031 | 0.0000398 | FOBI:030…. |
| white sugar | 6 | 4 | 0.0000092 | 0.0001007 | FOBI:030…. |
| cherry (whole, raw) | 12 | 5 | 0.0000092 | 0.0001007 | FOBI:030…. |
| grapefruit (whole, raw) | 13 | 5 | 0.0000148 | 0.0001329 | FOBI:030…. |
| sweet potato vegetable food product | 13 | 5 | 0.0000148 | 0.0001329 | FOBI:030…. |
| tomato (whole, raw) | 13 | 5 | 0.0000148 | 0.0001329 | FOBI:030…. |
| soybean (whole) | 23 | 6 | 0.0000180 | 0.0001526 | FOBI:030…. |
| almond (whole, raw) | 7 | 4 | 0.0000212 | 0.0001703 | FOBI:030…. |
| soybean oil | 3 | 3 | 0.0000269 | 0.0002061 | FOBI:030…. |
| cocoa | 8 | 4 | 0.0000416 | 0.0003032 | FOBI:030…. |
| bread food product | 9 | 4 | 0.0000737 | 0.0004697 | FOBI:030…. |
| rye food product | 9 | 4 | 0.0000737 | 0.0004697 | FOBI:030…. |
| whole bread | 9 | 4 | 0.0000737 | 0.0004697 | FOBI:030…. |
| eggplant (whole, raw) | 4 | 3 | 0.0001058 | 0.0006228 | FOBI:030…. |
| stem or spear vegetable | 4 | 3 | 0.0001058 | 0.0006228 | FOBI:030…. |
| carrot root (whole, raw) | 10 | 4 | 0.0001208 | 0.0006601 | FOBI:030…. |
| dairy food product | 10 | 4 | 0.0001208 | 0.0006601 | FOBI:030…. |
| wine (food product) | 20 | 5 | 0.0001606 | 0.0008471 | FOBI:030…. |
| grain plant | 11 | 4 | 0.0001867 | 0.0008927 | FOBI:030…. |
| grain product | 11 | 4 | 0.0001867 | 0.0008927 | FOBI:030…. |
| oregano (ground) | 11 | 4 | 0.0001867 | 0.0008927 | FOBI:030…. |
| herb | 5 | 3 | 0.0002599 | 0.0012050 | FOBI:030…. |
| olive (whole, ripe) | 13 | 4 | 0.0003913 | 0.0017609 | FOBI:030…. |
| black pepper food product | 6 | 3 | 0.0005106 | 0.0021693 | FOBI:030…. |
| vinegar | 6 | 3 | 0.0005106 | 0.0021693 | FOBI:030…. |
| coffee (liquid drink) | 14 | 4 | 0.0005388 | 0.0021693 | FOBI:030…. |
| cumin seed (whole, dried) | 14 | 4 | 0.0005388 | 0.0021693 | FOBI:030…. |
| strawberry (whole, raw) | 15 | 4 | 0.0007225 | 0.0028345 | FOBI:030…. |
| egg food product | 7 | 3 | 0.0008777 | 0.0033572 | FOBI:030…. |
| chicory (whole, raw) | 2 | 2 | 0.0010033 | 0.0037442 | FOBI:030…. |
| beer | 17 | 4 | 0.0012183 | 0.0043348 | FOBI:030…. |
| flour | 17 | 4 | 0.0012183 | 0.0043348 | FOBI:030…. |
| ale | 8 | 3 | 0.0013793 | 0.0044902 | FOBI:030…. |
| blackberry (whole, raw) | 8 | 3 | 0.0013793 | 0.0044902 | FOBI:030…. |
| blueberry (whole, raw) | 8 | 3 | 0.0013793 | 0.0044902 | FOBI:030…. |
| wheat | 8 | 3 | 0.0013793 | 0.0044902 | FOBI:030…. |
| oil | 19 | 4 | 0.0019184 | 0.0061148 | FOBI:030…. |
| pear (whole, raw) | 9 | 3 | 0.0020322 | 0.0062184 | FOBI:030…. |
| raspberry (whole, raw) | 9 | 3 | 0.0020322 | 0.0062184 | FOBI:030…. |
| black coffee | 3 | 2 | 0.0029562 | 0.0082235 | FOBI:030…. |
| black turtle bean (whole) | 3 | 2 | 0.0029562 | 0.0082235 | FOBI:030…. |
| chickpea (whole) | 3 | 2 | 0.0029562 | 0.0082235 | FOBI:030…. |
| lentil (whole) | 3 | 2 | 0.0029562 | 0.0082235 | FOBI:030…. |
| turnip (whole, raw) | 3 | 2 | 0.0029562 | 0.0082235 | FOBI:030…. |
| black currant (whole, raw) | 11 | 3 | 0.0038505 | 0.0101574 | FOBI:030…. |
| orange (whole, raw) | 11 | 3 | 0.0038505 | 0.0101574 | FOBI:030…. |
| tea food product | 11 | 3 | 0.0038505 | 0.0101574 | FOBI:030…. |
| cauliflower (whole, raw) | 4 | 2 | 0.0058065 | 0.0145638 | FOBI:030…. |
| celery stalk (raw) | 4 | 2 | 0.0058065 | 0.0145638 | FOBI:030…. |
| pea (whole) | 4 | 2 | 0.0058065 | 0.0145638 | FOBI:030…. |
| legume food product | 111 | 8 | 0.0063296 | 0.0156197 | FOBI:030…. |
| grape (whole, raw) | 14 | 3 | 0.0080462 | 0.0192355 | FOBI:030…. |
| meat food product | 14 | 3 | 0.0080462 | 0.0192355 | FOBI:030…. |
| Whole grain cereal products | 117 | 8 | 0.0092659 | 0.0217036 | FOBI:030…. |
| pomegranate (whole, raw) | 5 | 2 | 0.0095042 | 0.0217036 | FOBI:030…. |
| rice grain food product | 5 | 2 | 0.0095042 | 0.0217036 | FOBI:030…. |

# 4 Network visualization of `metaboliteList` terms

Then, with the `fobi_graph` function we can visualize the `metaboliteList` terms with their corresponding FOBI relationships.

```
terms <- fobi_subset %>%
  pull(id_code)

# create the associated graph
fobitools::fobi_graph(terms = terms,
                      get = "anc",
                      labels = TRUE,
                      legend = TRUE)
```

![](data:image/png;base64...)

# 5 Session Information

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
#>  [1] SummarizedExperiment_1.40.0   Biobase_2.70.0
#>  [3] GenomicRanges_1.62.0          Seqinfo_1.0.0
#>  [5] IRanges_2.44.0                S4Vectors_0.48.0
#>  [7] BiocGenerics_0.56.0           generics_0.1.4
#>  [9] MatrixGenerics_1.22.0         matrixStats_1.5.0
#> [11] metabolomicsWorkbenchR_1.20.0 POMA_1.20.0
#> [13] ggrepel_0.9.6                 rvest_1.0.5
#> [15] kableExtra_1.4.0              lubridate_1.9.4
#> [17] forcats_1.0.1                 stringr_1.5.2
#> [19] dplyr_1.1.4                   purrr_1.1.0
#> [21] readr_2.1.5                   tidyr_1.3.1
#> [23] tibble_3.3.0                  ggplot2_4.0.0
#> [25] tidyverse_2.0.0               fobitools_1.18.0
#> [27] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
#>   [3] jsonlite_2.0.0              MultiAssayExperiment_1.36.0
#>   [5] magrittr_2.0.4              magick_2.9.0
#>   [7] farver_2.1.2                rmarkdown_2.30
#>   [9] vctrs_0.6.5                 memoise_2.0.1
#>  [11] tinytex_0.57                BiocBaseUtils_1.12.0
#>  [13] S4Arrays_1.10.0             htmltools_0.5.8.1
#>  [15] curl_7.0.0                  qdapRegex_0.7.10
#>  [17] tictoc_1.2.1                SparseArray_1.10.0
#>  [19] sass_0.4.10                 parallelly_1.45.1
#>  [21] bslib_0.9.0                 impute_1.84.0
#>  [23] RecordLinkage_0.4-12.5      cachem_1.1.0
#>  [25] igraph_2.2.1                lifecycle_1.0.4
#>  [27] pkgconfig_2.0.3             Matrix_1.7-4
#>  [29] R6_2.6.1                    fastmap_1.2.0
#>  [31] future_1.67.0               selectr_0.4-2
#>  [33] digest_0.6.37               syuzhet_1.0.7
#>  [35] ps_1.9.1                    textshaping_1.0.4
#>  [37] RSQLite_2.4.3               labeling_0.4.3
#>  [39] timechange_0.3.0            abind_1.4-8
#>  [41] httr_1.4.7                  polyclip_1.10-7
#>  [43] compiler_4.5.1              proxy_0.4-27
#>  [45] bit64_4.6.0-1               withr_3.0.2
#>  [47] S7_0.2.0                    BiocParallel_1.44.0
#>  [49] viridis_0.6.5               DBI_1.2.3
#>  [51] ggforce_0.5.0               MASS_7.3-65
#>  [53] lava_1.8.1                  DelayedArray_0.36.0
#>  [55] textclean_0.9.3             tools_4.5.1
#>  [57] chromote_0.5.1              otel_0.2.0
#>  [59] future.apply_1.20.0         nnet_7.3-20
#>  [61] glue_1.8.0                  promises_1.4.0
#>  [63] grid_4.5.1                  fgsea_1.36.0
#>  [65] gtable_0.3.6                lexicon_1.2.1
#>  [67] tzdb_0.5.0                  class_7.3-23
#>  [69] websocket_1.4.4             data.table_1.17.8
#>  [71] hms_1.1.4                   XVector_0.50.0
#>  [73] tidygraph_1.3.1             xml2_1.4.1
#>  [75] pillar_1.11.1               limma_3.66.0
#>  [77] vroom_1.6.6                 later_1.4.4
#>  [79] splines_4.5.1               tweenr_2.0.3
#>  [81] lattice_0.22-7              survival_3.8-3
#>  [83] bit_4.6.0                   tidyselect_1.2.1
#>  [85] knitr_1.50                  gridExtra_2.3
#>  [87] bookdown_0.45               svglite_2.2.2
#>  [89] xfun_0.53                   graphlayouts_1.2.2
#>  [91] statmod_1.5.1               stringi_1.8.7
#>  [93] yaml_2.3.10                 evaluate_1.0.5
#>  [95] codetools_0.2-20            evd_2.3-7.1
#>  [97] ggraph_2.2.2                BiocManager_1.30.26
#>  [99] cli_3.6.5                   ontologyIndex_2.12
#> [101] rpart_4.1.24                xtable_1.8-4
#> [103] systemfonts_1.3.1           struct_1.22.0
#> [105] processx_3.8.6              jquerylib_0.1.4
#> [107] dichromat_2.0-0.1           Rcpp_1.1.0
#> [109] globals_0.18.0              parallel_4.5.1
#> [111] blob_1.2.4                  ff_4.5.2
#> [113] listenv_0.9.1               viridisLite_0.4.2
#> [115] ipred_0.9-15                scales_1.4.0
#> [117] prodlim_2025.04.28          e1071_1.7-16
#> [119] crayon_1.5.3                clisymbols_1.2.0
#> [121] rlang_1.1.6                 ada_2.0-5
#> [123] cowplot_1.2.0               fastmatch_1.1-6
```

# References

Castellano-Escuder, Pol, Raúl González-Domı́nguez, David S Wishart, Cristina Andrés-Lacueva, and Alex Sánchez-Pla. 2020. “FOBI: An Ontology to Represent Food Intake Data and Associate It with Metabolomic Data.” *Database* 2020.