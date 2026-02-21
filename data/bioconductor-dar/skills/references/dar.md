# Introduction to dar

## An Example

The package includes a dataset from a study by [Noguera-Julian, M., et al. 2016](https://doi.org/10.1016/j.ebiom.2016.01.032), which investigated the differential abundance of microbial species between men who have sex with men (MSM) and non-MSM (hts). This data is stored as an object of the `phyloseq` class, a standard input format for creating recipes with dar in conjunction with `TreeSummarizedExperiment`. To begin the analysis, we first load and inspect the data:

```
library(dar)

data("metaHIV_phy", package = "dar")

metaHIV_phy
#> phyloseq-class experiment-level object
#> otu_table()   OTU Table:         [ 451 taxa and 156 samples ]
#> sample_data() Sample Data:       [ 156 samples by 3 sample variables ]
#> tax_table()   Taxonomy Table:    [ 451 taxa by 7 taxonomic ranks ]
```

## An Initial Recipe

First, we will create a recipe object from the original data and then specify the processing and differential analysis steps.

Recipes can be created manually by sequentially adding roles to variables in a data set.

The easiest way to create the initial recipe is:

```
rec_obj <- recipe(metaHIV_phy, var_info = "RiskGroup2", tax_info = "Species")
rec_obj
#> ── DAR Recipe ──────────────────────────────────────────────────────────────────
#> Inputs:
#>
#>      ℹ phyloseq object with 451 taxa and 156 samples
#>      ℹ variable of interes RiskGroup2 (class: character, levels: hts, msm, pwid)
#>      ℹ taxonomic level Species
```

The `var_info` argument corresponds to the variable to be considered in the modeling process and `tax_info` indicates the taxonomic level that will be used for the analyses.

## Preprocessing Steps

From here, preprocessing steps for some step X can be added sequentially in one of two ways:

```
rec_obj <- step_{X}(rec_obj, arguments)
## or
rec_obj <- rec_obj |> step_{X}(arguments)
```

Note that all `step_ancom` and the other functions will always return updated recipes.

We have two types of steps, those in charge of processing (prepro) and those destined to define the methods of differential analysis (da).

The prepro steps are used to modify the data loaded into the recipe which will then be used for the da steps. The `dar` package include 3 main preprocessing functionalities.

* `step_subset_taxa`: Is used for subsetting the columns and values within the tax\_table.
* `step_filter_taxa`: Is used for filtering OTUs from recipe objects.
* `step_rarefaction`: Is used to resample an OTU table such that all samples have the same library size.

Additionally, the `dar` package provides convenient wrappers for the `step_filter_taxa` function, designed to filter Operational Taxonomic Units (OTUs) based on specific criteria: prevalence, variance, abundance, and rarity.

* `step_filter_by_prevalence`: Filters OTUs according to the number of samples in which the OTU appears.
* `step_filter_by_variance`: Filters OTUs based on the variance of the OTU’s presence across samples.
* `step_filter_by_abundance`: Filters OTUs according to the OTU’s abundance across samples.
* `step_filter_by_rarity`: Filters OTUs based on the rarity of the OTU across samples.

For our data, we can add an operation to preprocessing the data stored in the initial recpie. First, we will use `step_subset_taxa` to retain only Bacteria and Archaea OTUs from the Kingdom taxonomic level. We will then filter out OTUs where at least 3% of the samples have counts greater than 0.

```
rec_obj <- rec_obj |>
  step_subset_taxa(tax_level = "Kingdom", taxa = c("Bacteria", "Archaea")) |>
  step_filter_by_prevalence(0.03)

rec_obj
#> ── DAR Recipe ──────────────────────────────────────────────────────────────────
#> Inputs:
#>
#>      ℹ phyloseq object with 451 taxa and 156 samples
#>      ℹ variable of interes RiskGroup2 (class: character, levels: hts, msm, pwid)
#>      ℹ taxonomic level Species
#>
#> Preporcessing steps:
#>
#>      ◉ step_subset_taxa() id = subset_taxa__Zlebia
#>      ◉ step_filter_by_prevalence() id = filter_by_prevalence__Vol_au_vent
#>
#> DA steps:
```

## Differential Analysis

Now that we have defined the preprocessing of the input data for all the da methods that will be used, we need to define them. For this introduction we will use **metagenomeSeq** and **maaslin2** methods with default parameters (those defined by the authors of each method).

```
rec_obj <- rec_obj |>
  step_deseq() |>
  step_metagenomeseq(rm_zeros = 0.01) |>
  step_maaslin()

rec_obj
#> ── DAR Recipe ──────────────────────────────────────────────────────────────────
#> Inputs:
#>
#>      ℹ phyloseq object with 451 taxa and 156 samples
#>      ℹ variable of interes RiskGroup2 (class: character, levels: hts, msm, pwid)
#>      ℹ taxonomic level Species
#>
#> Preporcessing steps:
#>
#>      ◉ step_subset_taxa() id = subset_taxa__Zlebia
#>      ◉ step_filter_by_prevalence() id = filter_by_prevalence__Vol_au_vent
#>
#> DA steps:
#>
#>      ◉ step_deseq() id = deseq__Jachnun
#>      ◉ step_metagenomeseq() id = metagenomeseq__Makmur
#>      ◉ step_maaslin() id = maaslin__Milk_cream_strudel
```

The `dar` package includes more da steps than those defined above. Below is the full list:

```
grep(
  "_new|_to_expr|filter|subset|rarefaction",
  grep("^step_", ls("package:dar"), value = TRUE),
  value = TRUE,
  invert = TRUE
)
#> [1] "step_aldex"         "step_ancom"         "step_corncob"
#> [4] "step_deseq"         "step_lefse"         "step_maaslin"
#> [7] "step_metagenomeseq" "step_wilcox"
```

## Prep

To ensure the reproducibility and consistency of the generated results, all the steps defined in the recipe are executed at the same time using the `prep` function.

```
da_results <- prep(rec_obj, parallel = TRUE)
da_results
#> ── DAR Results ─────────────────────────────────────────────────────────────────
#> Inputs:
#>
#>      ℹ phyloseq object with 278 taxa and 156 samples
#>      ℹ variable of interes RiskGroup2 (class: character, levels: hts, msm, pwid)
#>      ℹ taxonomic level Species
#>
#> Results:
#>
#>      ✔ deseq__Jachnun diff_taxa = 166
#>      ✔ metagenomeseq__Makmur diff_taxa = 236
#>      ✔ maaslin__Milk_cream_strudel diff_taxa = 146
#>
#>      ℹ 65 taxa are present in all tested methods
```

Note that the resulting object print shows information about the amount of differentially abundant OTUs in each of the methods, as well as the number of OTUs that have been detected by all methods (consensus).

## Bake and cool

Now that we have the results we need to extract them, however for this we first need to define a consensus strategy with the `bake`. For this example we are only interested in those OTUs detected as differentially abundant in the three methods used.

```
## Number of used methods
count <- steps_ids(da_results, type = "da") |> length()

## Define the bake
da_results <- bake(da_results, count_cutoff = count)
```

Finally we can extract the table with the results using the `cool` function.

```
cool(da_results)
#> # A tibble: 65 × 2
#>    taxa_id taxa
#>    <chr>   <chr>
#>  1 Otu_15  Bifidobacterium_catenulatum
#>  2 Otu_34  Olsenella_scatoligenes
#>  3 Otu_35  Collinsella_aerofaciens
#>  4 Otu_37  Collinsella_stercoris
#>  5 Otu_38  Enorma_massiliensis
#>  6 Otu_45  Slackia_isoflavoniconvertens
#>  7 Otu_47  Bacteroides_cellulosilyticus
#>  8 Otu_48  Bacteroides_clarus
#>  9 Otu_63  Bacteroides_plebeius
#> 10 Otu_69  Bacteroides_sp_CAG_530
#> # ℹ 55 more rows
```

## Session info

```
devtools::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-29
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package        * version date (UTC) lib source
#>  ade4             1.7-23  2025-02-14 [2] CRAN (R 4.5.1)
#>  ape              5.8-1   2024-12-16 [2] CRAN (R 4.5.1)
#>  assertthat       0.2.1   2019-03-21 [2] CRAN (R 4.5.1)
#>  Biobase          2.70.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics     0.56.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  biomformat       1.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings       2.78.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bitops           1.0-9   2024-10-03 [2] CRAN (R 4.5.1)
#>  brio             1.1.5   2024-04-24 [2] CRAN (R 4.5.1)
#>  bslib            0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  ca               0.71.1  2020-01-24 [2] CRAN (R 4.5.1)
#>  cachem           1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  Cairo            1.7-0   2025-10-29 [2] CRAN (R 4.5.1)
#>  caTools          1.18.3  2024-09-04 [2] CRAN (R 4.5.1)
#>  circlize         0.4.16  2024-02-20 [2] CRAN (R 4.5.1)
#>  cli              3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  clue             0.3-66  2024-11-13 [2] CRAN (R 4.5.1)
#>  cluster          2.1.8.1 2025-03-12 [3] CRAN (R 4.5.1)
#>  codetools        0.2-20  2024-03-31 [3] CRAN (R 4.5.1)
#>  colorspace       2.1-2   2025-09-22 [2] CRAN (R 4.5.1)
#>  ComplexHeatmap   2.26.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  crayon           1.5.3   2024-06-20 [2] CRAN (R 4.5.1)
#>  crosstalk        1.2.2   2025-08-26 [2] CRAN (R 4.5.1)
#>  dar            * 1.6.0   2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  data.table       1.17.8  2025-07-10 [2] CRAN (R 4.5.1)
#>  dendextend       1.19.1  2025-07-15 [2] CRAN (R 4.5.1)
#>  devtools         2.4.6   2025-10-03 [2] CRAN (R 4.5.1)
#>  dichromat        2.0-0.1 2022-05-02 [2] CRAN (R 4.5.1)
#>  digest           0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  doParallel       1.0.17  2022-02-07 [2] CRAN (R 4.5.1)
#>  dplyr            1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
#>  ellipsis         0.3.2   2021-04-29 [2] CRAN (R 4.5.1)
#>  evaluate         1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  farver           2.1.2   2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap          1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  foreach          1.5.2   2022-02-02 [2] CRAN (R 4.5.1)
#>  fs               1.6.6   2025-04-12 [2] CRAN (R 4.5.1)
#>  furrr            0.3.1   2022-08-15 [2] CRAN (R 4.5.1)
#>  future           1.67.0  2025-07-29 [2] CRAN (R 4.5.1)
#>  generics         0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  GetoptLong       1.0.5   2020-12-15 [2] CRAN (R 4.5.1)
#>  ggplot2          4.0.0   2025-09-11 [2] CRAN (R 4.5.1)
#>  GlobalOptions    0.1.2   2020-06-10 [2] CRAN (R 4.5.1)
#>  globals          0.18.0  2025-05-08 [2] CRAN (R 4.5.1)
#>  glue             1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
#>  gplots           3.2.0   2024-10-05 [2] CRAN (R 4.5.1)
#>  gridExtra        2.3     2017-09-09 [2] CRAN (R 4.5.1)
#>  gtable           0.3.6   2024-10-25 [2] CRAN (R 4.5.1)
#>  gtools           3.9.5   2023-11-20 [2] CRAN (R 4.5.1)
#>  heatmaply        1.6.0   2025-07-12 [2] CRAN (R 4.5.1)
#>  htmltools        0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets      1.6.4   2023-12-06 [2] CRAN (R 4.5.1)
#>  httr             1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
#>  igraph           2.2.1   2025-10-27 [2] CRAN (R 4.5.1)
#>  IRanges          2.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iterators        1.0.14  2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib        0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite         2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  KernSmooth       2.23-26 2025-01-01 [3] CRAN (R 4.5.1)
#>  knitr            1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling         0.4.3   2023-08-29 [2] CRAN (R 4.5.1)
#>  lattice          0.22-7  2025-04-02 [3] CRAN (R 4.5.1)
#>  lazyeval         0.2.2   2019-03-15 [2] CRAN (R 4.5.1)
#>  lifecycle        1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  listenv          0.9.1   2024-01-29 [2] CRAN (R 4.5.1)
#>  magick           2.9.0   2025-09-08 [2] CRAN (R 4.5.1)
#>  magrittr         2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
#>  MASS             7.3-65  2025-02-28 [3] CRAN (R 4.5.1)
#>  Matrix           1.7-4   2025-08-28 [3] CRAN (R 4.5.1)
#>  matrixStats      1.5.0   2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise          2.0.1   2021-11-26 [2] CRAN (R 4.5.1)
#>  mgcv             1.9-3   2025-04-04 [3] CRAN (R 4.5.1)
#>  microbiome       1.32.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  multtest         2.66.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  nlme             3.1-168 2025-03-31 [3] CRAN (R 4.5.1)
#>  parallelly       1.45.1  2025-07-24 [2] CRAN (R 4.5.1)
#>  permute          0.9-8   2025-06-25 [2] CRAN (R 4.5.1)
#>  phyloseq         1.54.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  pillar           1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgbuild         1.4.8   2025-05-26 [2] CRAN (R 4.5.1)
#>  pkgconfig        2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
#>  pkgload          1.4.1   2025-09-23 [2] CRAN (R 4.5.1)
#>  plotly           4.11.0  2025-06-19 [2] CRAN (R 4.5.1)
#>  plyr             1.8.9   2023-10-02 [2] CRAN (R 4.5.1)
#>  png              0.1-8   2022-11-29 [2] CRAN (R 4.5.1)
#>  purrr            1.1.0   2025-07-10 [2] CRAN (R 4.5.1)
#>  R6               2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  RColorBrewer     1.1-3   2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp             1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
#>  registry         0.5-1   2019-03-05 [2] CRAN (R 4.5.1)
#>  remotes          2.5.0   2024-03-17 [2] CRAN (R 4.5.1)
#>  reshape2         1.4.4   2020-04-09 [2] CRAN (R 4.5.1)
#>  rhdf5            2.54.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  rhdf5filters     1.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Rhdf5lib         1.32.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  rjson            0.2.23  2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang            1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown        2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  Rtsne            0.17    2023-12-07 [2] CRAN (R 4.5.1)
#>  S4Vectors        0.48.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7               0.2.0   2024-11-07 [2] CRAN (R 4.5.1)
#>  sass             0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  scales           1.4.0   2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo          1.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  seriation        1.5.8   2025-08-20 [2] CRAN (R 4.5.1)
#>  sessioninfo      1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  shape            1.4.6.1 2024-02-23 [2] CRAN (R 4.5.1)
#>  stringi          1.8.7   2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr          1.5.2   2025-09-08 [2] CRAN (R 4.5.1)
#>  survival         3.8-3   2024-12-17 [3] CRAN (R 4.5.1)
#>  testthat         3.2.3   2025-01-13 [2] CRAN (R 4.5.1)
#>  tibble           3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr            1.3.1   2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect       1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
#>  TSP              1.2-5   2025-05-27 [2] CRAN (R 4.5.1)
#>  UpSetR           1.4.0   2019-05-22 [2] CRAN (R 4.5.1)
#>  usethis          3.2.1   2025-09-06 [2] CRAN (R 4.5.1)
#>  utf8             1.2.6   2025-06-08 [2] CRAN (R 4.5.1)
#>  vctrs            0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
#>  vegan            2.7-2   2025-10-08 [2] CRAN (R 4.5.1)
#>  viridis          0.6.5   2024-01-29 [2] CRAN (R 4.5.1)
#>  viridisLite      0.4.2   2023-05-02 [2] CRAN (R 4.5.1)
#>  webshot          0.5.5   2023-06-26 [2] CRAN (R 4.5.1)
#>  withr            3.0.2   2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun             0.53    2025-08-19 [2] CRAN (R 4.5.1)
#>  XVector          0.50.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml             2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpxvaRZh/Rinst3e30fb71cf6981
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```