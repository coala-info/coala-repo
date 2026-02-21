# Dietary text annotation

Pol Castellano-Escuder1\*

1Duke University

\*polcaes@gmail.com

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Load packages](#load-packages)
* [3 Load food items from a food frequency questionnaire (FFQ) sample data](#load-food-items-from-a-food-frequency-questionnaire-ffq-sample-data)
* [4 Automatic dietary text anotation](#automatic-dietary-text-anotation)
  + [4.1 The similarity argument](#the-similarity-argument)
    - [4.1.1 Network visualization of the annotated terms](#network-visualization-of-the-annotated-terms)
  + [4.2 How do I know which compounds are associated with my study food items?](#how-do-i-know-which-compounds-are-associated-with-my-study-food-items)
* [5 Limitations](#limitations)
* [6 Session Information](#session-information)
* [References](#references)

**Compiled date**: 2025-10-30

**Last edited**: 2022-01-12

**License**: GPL-3

# 1 Installation

Run the following code to install the Bioconductor version of the package.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("fobitools")
```

# 2 Load packages

```
library(fobitools)
```

We will also need some additional [CRAN](https://cran.r-project.org) packages that will be very useful in this vignette.

```
library(tidyverse)
library(kableExtra)
```

# 3 Load food items from a food frequency questionnaire (FFQ) sample data

In nutritional studies, dietary data are usually collected by using different questionnaires such as FFQs (food frequency questionnaires) or 24h-DRs (24 hours dietary recall). Commonly, the text collected in these questionnaires require a manual preprocessing step before being analyzed.

This is an example of how an FFQ could look like in a common nutritional study.

```
load("data/sample_ffq.rda")

sample_ffq %>%
  dplyr::slice(1L:10L) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))
```

| ID | Name |
| --- | --- |
| ID\_001 | Beef: roast, steak, mince, stew casserole, curry or bolognese |
| ID\_002 | Beefburgers |
| ID\_003 | Pork: roast, chops, stew, slice or curry |
| ID\_004 | Lamb: roast, chops, stew or curry |
| ID\_005 | Chicken, turkey or other poultry: including fried, casseroles or curry |
| ID\_006 | Bacon |
| ID\_007 | Ham |
| ID\_008 | Corned beef, Spam, luncheon meats |
| ID\_009 | Sausages |
| ID\_0010 | Savoury pies, e.g. meat pie, pork pie, pasties, steak & kidney pie, sausage rolls, scotch egg |

# 4 Automatic dietary text anotation

The `fobitools::annotate_foods()` function allows the automatic annotation of free nutritional text using the FOBI ontology (Castellano-Escuder et al. [2020](#ref-castellano2020fobi)). This function provides users with a table of food IDs, food names, FOBI IDs and FOBI names of the FOBI terms that match the input text. The input should be structured as a two column data frame, indicating the food IDs (first column) and food names (second column). Note that food names can be provided both as words and complex strings.

This function includes a text mining algorithm composed of 5 sequential layers. In this process, singulars and plurals are analyzed, irrelevant words are removed, each string of the text input is tokenized and each word is analyzed independently, and the semantic similarity between input text and FOBI items is computed. Finally, this function also shows the percentage of the annotated input text.

```
annotated_text <- fobitools::annotate_foods(sample_ffq)
#> 89.57% annotated
#> 3.271 sec elapsed

annotated_text$annotated %>%
  dplyr::slice(1L:10L) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))
```

| FOOD\_ID | FOOD\_NAME | FOBI\_ID | FOBI\_NAME |
| --- | --- | --- | --- |
| ID\_00100 | Oranges, satsumas, mandarins, tangerines, clementines | FOODON:03309832 | orange (whole, raw) |
| ID\_00101 | Grapefruit | FOODON:03301702 | grapefruit (whole, raw) |
| ID\_00102 | Bananas | FOODON:03311513 | banana (whole, ripe) |
| ID\_00103 | Grapes | FOODON:03301123 | grape (whole, raw) |
| ID\_00104 | Melon | FOODON:03301593 | melon (raw) |
| ID\_00105 | \*Peaches, plums, apricots, nectarines | FOODON:03301107 | nectarine (whole, raw) |
| ID\_00106 | \*Strawberries, raspberries, kiwi fruit | FOODON:03305656 | fruit (dried) |
| ID\_00106 | \*Strawberries, raspberries, kiwi fruit | FOODON:03414363 | kiwi |
| ID\_00106 | \*Strawberries, raspberries, kiwi fruit | FOODON:00001057 | plant fruit food product |
| ID\_00107 | Tinned fruit | FOODON:03305656 | fruit (dried) |

## 4.1 The similarity argument

Additionally, the *similarity* argument indicates the semantic similarity cutoff used at the last layer of the text mining pipeline. It is a numeric value between 1 (exact match) and 0 (very poor match). Users can modify this value to obtain more or less accurated annotations. Authors do not recommend values below 0.85 (default).

```
annotated_text_95 <- fobitools::annotate_foods(sample_ffq, similarity = 0.95)
#> 86.5% annotated
#> 3.645 sec elapsed

annotated_text_95$annotated %>%
  dplyr::slice(1L:10L) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))
```

| FOOD\_ID | FOOD\_NAME | FOBI\_ID | FOBI\_NAME |
| --- | --- | --- | --- |
| ID\_00100 | Oranges, satsumas, mandarins, tangerines, clementines | FOODON:03309832 | orange (whole, raw) |
| ID\_00101 | Grapefruit | FOODON:03301702 | grapefruit (whole, raw) |
| ID\_00102 | Bananas | FOODON:03311513 | banana (whole, ripe) |
| ID\_00103 | Grapes | FOODON:03301123 | grape (whole, raw) |
| ID\_00104 | Melon | FOODON:03301593 | melon (raw) |
| ID\_00105 | \*Peaches, plums, apricots, nectarines | FOODON:03301107 | nectarine (whole, raw) |
| ID\_00106 | \*Strawberries, raspberries, kiwi fruit | FOODON:03305656 | fruit (dried) |
| ID\_00106 | \*Strawberries, raspberries, kiwi fruit | FOODON:03414363 | kiwi |
| ID\_00106 | \*Strawberries, raspberries, kiwi fruit | FOODON:00001057 | plant fruit food product |
| ID\_00107 | Tinned fruit | FOODON:03305656 | fruit (dried) |

See that by increasing the similarity value from 0.85 (default value) to 0.95 (a more accurate annotation), the percentage of annotated terms decreases from 89.57% to 86.5%. Let’s check those food items annotated with `similarity = 0.85` but not with `similarity = 0.95`.

```
annotated_text$annotated %>%
  filter(!FOOD_ID %in% annotated_text_95$annotated$FOOD_ID) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))
```

| FOOD\_ID | FOOD\_NAME | FOBI\_ID | FOBI\_NAME |
| --- | --- | --- | --- |
| ID\_00124 | Beansprouts…130 | FOODON:00002753 | bean (whole) |
| ID\_00127 | Watercress | FOODON:00002340 | water food product |
| ID\_00140 | Beansprouts…171 | FOODON:00002753 | bean (whole) |
| ID\_00143 | Brocoli | FOODON:03301713 | broccoli floret (whole, raw) |
| ID\_002 | Beefburgers | FOODON:00002737 | beef hamburger (dish) |

### 4.1.1 Network visualization of the annotated terms

Then, with the `fobitools::fobi_graph()` function we can visualize the annotated food terms with their corresponding FOBI relationships.

```
terms <- annotated_text$annotated %>%
  pull(FOBI_ID)

fobitools::fobi_graph(terms = terms,
                      get = NULL,
                      layout = "lgl",
                      labels = TRUE,
                      legend = TRUE,
                      labelsize = 6,
                      legendSize = 20)
```

![](data:image/png;base64...)

## 4.2 How do I know which compounds are associated with my study food items?

Most likely we may be interested in knowing the food-related compounds in our study. Well, if so, once the foods are annotated we can obtain the metabolites associated with the annotated foods as follows:

```
inverse_rel <- fobitools::fobi %>%
  filter(id_BiomarkerOf %in% annotated_text$annotated$FOBI_ID) %>%
  dplyr::select(id_code, name, id_BiomarkerOf, FOBI) %>%
  dplyr::rename(METABOLITE_ID = 1, METABOLITE_NAME = 2, FOBI_ID = 3, METABOLITE_FOBI_ID = 4)

annotated_foods_and_metabolites <- left_join(annotated_text$annotated, inverse_rel, by = "FOBI_ID")

annotated_foods_and_metabolites %>%
  filter(!is.na(METABOLITE_ID)) %>%
  dplyr::slice(1L:10L) %>%
  kbl(row.names = FALSE, booktabs = TRUE) %>%
  kable_styling(latex_options = c("striped"))
```

| FOOD\_ID | FOOD\_NAME | FOBI\_ID | FOBI\_NAME | METABOLITE\_ID | METABOLITE\_NAME | METABOLITE\_FOBI\_ID |
| --- | --- | --- | --- | --- | --- | --- |
| ID\_00100 | Oranges, satsumas, mandarins, tangerines, clementines | FOODON:03309832 | orange (whole, raw) | CHEBI:15600 | (+)-catechin | FOBI:030460 |
| ID\_00100 | Oranges, satsumas, mandarins, tangerines, clementines | FOODON:03309832 | orange (whole, raw) | CHEBI:15864 | luteolin | FOBI:030555 |
| ID\_00100 | Oranges, satsumas, mandarins, tangerines, clementines | FOODON:03309832 | orange (whole, raw) | CHEBI:16243 | quercetin | FOBI:030558 |
| ID\_00100 | Oranges, satsumas, mandarins, tangerines, clementines | FOODON:03309832 | orange (whole, raw) | CHEBI:17620 | ferulic acid | FOBI:030406 |
| ID\_00100 | Oranges, satsumas, mandarins, tangerines, clementines | FOODON:03309832 | orange (whole, raw) | CHEBI:17620 | ferulic acid | FOBI:030406 |
| ID\_00100 | Oranges, satsumas, mandarins, tangerines, clementines | FOODON:03309832 | orange (whole, raw) | CHEBI:18388 | apigenin | FOBI:030553 |
| ID\_00100 | Oranges, satsumas, mandarins, tangerines, clementines | FOODON:03309832 | orange (whole, raw) | CHEBI:28499 | kaempferol | FOBI:030565 |
| ID\_00100 | Oranges, satsumas, mandarins, tangerines, clementines | FOODON:03309832 | orange (whole, raw) | CHEBI:6052 | isorhamnetin | FOBI:030562 |
| ID\_00100 | Oranges, satsumas, mandarins, tangerines, clementines | FOODON:03309832 | orange (whole, raw) | CHEBI:77131 | sinapic acid | FOBI:030412 |
| ID\_00100 | Oranges, satsumas, mandarins, tangerines, clementines | FOODON:03309832 | orange (whole, raw) | CHEBI:77131 | sinapic acid | FOBI:030412 |

# 5 Limitations

The FOBI ontology is currently in its first release version, so it does not yet include information on many metabolites, foods and food relationships. All future efforts will be directed at expanding this ontology, leading to a significant increase in the number of metabolites, foods (from FoodOn ontology (Dooley et al. [2018](#ref-dooley2018foodon))) and metabolite-food relationships. The `fobitools` package provides the methodology for easy use of the FOBI ontology regardless of the amount of information it contains. Therefore, future FOBI improvements will also have a direct impact on the `fobitools` package, increasing its utility and allowing to perform, among others, more accurate, complete and robust dietary text annotations.

# 6 Session Information

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#>  [1] kableExtra_1.4.0 lubridate_1.9.4  forcats_1.0.1    stringr_1.5.2
#>  [5] dplyr_1.1.4      purrr_1.1.0      readr_2.1.5      tidyr_1.3.1
#>  [9] tibble_3.3.0     ggplot2_4.0.0    tidyverse_2.0.0  fobitools_1.18.0
#> [13] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.3              ada_2.0-5              qdapRegex_0.7.10
#>   [4] gridExtra_2.3          rlang_1.1.6            magrittr_2.0.4
#>   [7] e1071_1.7-16           compiler_4.5.1         RSQLite_2.4.3
#>  [10] systemfonts_1.3.1      vctrs_0.6.5            pkgconfig_2.0.3
#>  [13] crayon_1.5.3           fastmap_1.2.0          magick_2.9.0
#>  [16] labeling_0.4.3         ggraph_2.2.2           rmarkdown_2.30
#>  [19] prodlim_2025.04.28     tzdb_0.5.0             tinytex_0.57
#>  [22] bit_4.6.0              xfun_0.53              cachem_1.1.0
#>  [25] jsonlite_2.0.0         blob_1.2.4             tictoc_1.2.1
#>  [28] BiocParallel_1.44.0    tweenr_2.0.3           syuzhet_1.0.7
#>  [31] parallel_4.5.1         R6_2.6.1               bslib_0.9.0
#>  [34] stringi_1.8.7          RColorBrewer_1.1-3     textclean_0.9.3
#>  [37] parallelly_1.45.1      rpart_4.1.24           jquerylib_0.1.4
#>  [40] Rcpp_1.1.0             bookdown_0.45          knitr_1.50
#>  [43] future.apply_1.20.0    clisymbols_1.2.0       timechange_0.3.0
#>  [46] Matrix_1.7-4           splines_4.5.1          nnet_7.3-20
#>  [49] igraph_2.2.1           tidyselect_1.2.1       rstudioapi_0.17.1
#>  [52] dichromat_2.0-0.1      yaml_2.3.10            viridis_0.6.5
#>  [55] codetools_0.2-20       listenv_0.9.1          lattice_0.22-7
#>  [58] withr_3.0.2            S7_0.2.0               evaluate_1.0.5
#>  [61] ontologyIndex_2.12     future_1.67.0          survival_3.8-3
#>  [64] proxy_0.4-27           polyclip_1.10-7        xml2_1.4.1
#>  [67] pillar_1.11.1          BiocManager_1.30.26    lexicon_1.2.1
#>  [70] generics_0.1.4         vroom_1.6.6            hms_1.1.4
#>  [73] scales_1.4.0           ff_4.5.2               globals_0.18.0
#>  [76] xtable_1.8-4           class_7.3-23           glue_1.8.0
#>  [79] RecordLinkage_0.4-12.5 tools_4.5.1            data.table_1.17.8
#>  [82] fgsea_1.36.0           graphlayouts_1.2.2     fastmatch_1.1-6
#>  [85] tidygraph_1.3.1        cowplot_1.2.0          grid_4.5.1
#>  [88] ipred_0.9-15           ggforce_0.5.0          cli_3.6.5
#>  [91] evd_2.3-7.1            textshaping_1.0.4      viridisLite_0.4.2
#>  [94] svglite_2.2.2          lava_1.8.1             gtable_0.3.6
#>  [97] sass_0.4.10            digest_0.6.37          ggrepel_0.9.6
#> [100] farver_2.1.2           memoise_2.0.1          htmltools_0.5.8.1
#> [103] lifecycle_1.0.4        bit64_4.6.0-1          MASS_7.3-65
```

# References

Castellano-Escuder, Pol, Raúl González-Domı́nguez, David S Wishart, Cristina Andrés-Lacueva, and Alex Sánchez-Pla. 2020. “FOBI: An Ontology to Represent Food Intake Data and Associate It with Metabolomic Data.” *Database* 2020.

Dooley, Damion M, Emma J Griffiths, Gurinder S Gosal, Pier L Buttigieg, Robert Hoehndorf, Matthew C Lange, Lynn M Schriml, Fiona SL Brinkman, and William WL Hsiao. 2018. “FoodOn: A Harmonized Food Ontology to Increase Global Food Traceability, Quality Control and Data Integration.” *Npj Science of Food* 2 (1): 1–10.