To illustrate the functionality of the `dar` package, this study will use the data set from (Noguera-Julian, M., et al. 2016). The authors of this study found that men who have sex with men (MSM) predominantly belonged to the Prevotella-rich enterotype whereas most non-MSM subjects were enriched in Bacteroides, independently of HIV-1 status. This result highlights the potential impact of sexual orientation on the gut microbiome and emphasizes the importance of controlling for such variables in microbiome research. Using the `dar` package, we will conduct a differential abundance analysis to further explore this finding and uncover potential microbial biomarkers associated with this specific population.

## Load dar package and data

```
library(dar)
# suppressPackageStartupMessages(library(plotly))
data("metaHIV_phy")

metaHIV_phy
#> phyloseq-class experiment-level object
#> otu_table()   OTU Table:         [ 451 taxa and 156 samples ]
#> sample_data() Sample Data:       [ 156 samples by 3 sample variables ]
#> tax_table()   Taxonomy Table:    [ 451 taxa by 7 taxonomic ranks ]
```

## Recipe initialization

To begin the analysis process with the `dar` package, the first step is to initialize a `Recipe` object, which is an S4 class. This recipe object serves as a blueprint for the data preparation steps required for the differential abundance analysis. The initialization of the recipe object is done through the function `recipe()`, which takes as inputs a `phyloseq` or `TreeSummarizedExperiment` (TSE) object, the name of the categorical variable of interest and the taxonomic level at which the differential abundance analyses are to be performed. As previously mentioned, we will use the data set from (Noguera-Julian, M., et al. 2016) and the variable of interest “RiskGroup2” containing the categories: men who have sex with men (msm), non-MSM (hts) and people who inject drugs (pwid) and we will perform the analysis at the species level.

```
## Recipe initialization
rec <- recipe(metaHIV_phy, var_info = "RiskGroup2", tax_info = "Species")
rec
#> ── DAR Recipe ──────────────────────────────────────────────────────────────────
#> Inputs:
#>
#>      ℹ phyloseq object with 451 taxa and 156 samples
#>      ℹ variable of interes RiskGroup2 (class: character, levels: hts, msm, pwid)
#>      ℹ taxonomic level Species
```

## Recipe QC and preprocessing steps definition

Once the recipe object has been initialized, the next step is to populate it with steps. Steps are the methods that will be applied to the data stored in the recipe. There are two types of steps: preprocessing (prepro) and differential abundance (da) steps. Initially, we will focus on the prepro steps which are used to modify the data loaded into the recipe, which will then be used for the da steps. The ‘dar’ package includes 3 main preprocessing functionalities: `step_subset_taxa`, which is used for subsetting columns and values in the taxon table connected to the phyloseq object, `step_filter_taxa`, which is used to filter the OTUs, and `step_rarefaction`, which is used to resample the OTU table to ensure that all samples have the same library size. These functionalities allow for a high level of flexibility and customization in the data preparation process before performing the differential abundance analysis.

The `dar` package provides convenient wrappers for the `step_filter_taxa` function, designed to filter Operational Taxonomic Units (OTUs) based on specific criteria: prevalence, variance, abundance, and rarity.

* `step_filter_by_prevalence`: Filters OTUs according to the number of samples in which the OTU appears.
* `step_filter_by_variance`: Filters OTUs based on the variance of the OTU’s presence across samples.
* `step_filter_by_abundance`: Filters OTUs according to the OTU’s abundance across samples.
* `step_filter_by_rarity`: Filters OTUs based on the rarity of the OTU across samples.

In addition to the preprocessing steps, the `dar` package also incorporates the function `phy_qc` which returns a table with a set of metrics that allow for informed decisions to be made about the data preprocessing that will be done. In our case, we decided to use the step\_subset\_taxa function to retain only those observations annotated within the realm of Bacteria and Archaea. We also used the `step_filter_by_prevalence` function to retain only those OTUs with at least 1% of the samples with values greater than 0. This approach ensured that we were working with a high-quality, informative subset of the data, which improved the overall accuracy and reliability of the differential abundance analysis.

```
## QC
phy_qc(rec)
#> # A tibble: 4 × 10
#>   var_levels     n n_zero pct_zero pct_all_zero pct_singletons pct_doubletons
#>   <chr>      <int>  <int>    <dbl>        <dbl>          <dbl>          <dbl>
#> 1 all        70356  57632     81.9          0             20.6           8.87
#> 2 hts        18491  15108     81.7         24.2           22.8           8.43
#> 3 msm        45100  37019     82.1         16.0           20.2           9.53
#> 4 pwid        6765   5505     81.4         41.2           16.6           9.31
#> # ℹ 3 more variables: count_mean <dbl>, count_min <dbl>, count_max <dbl>

## Adding prepro steps
rec <-
  rec |>
  step_subset_taxa(tax_level = "Kingdom", taxa = c("Bacteria", "Archaea")) |>
  step_filter_by_prevalence()

rec
#> ── DAR Recipe ──────────────────────────────────────────────────────────────────
#> Inputs:
#>
#>      ℹ phyloseq object with 451 taxa and 156 samples
#>      ℹ variable of interes RiskGroup2 (class: character, levels: hts, msm, pwid)
#>      ℹ taxonomic level Species
#>
#> Preporcessing steps:
#>
#>      ◉ step_subset_taxa() id = subset_taxa__Apple_strudel
#>      ◉ step_filter_by_prevalence() id = filter_by_prevalence__Djevrek
#>
#> DA steps:
```

## Define Differential Analysis (DA) steps

Once data is preprocessed and cleaned, the next step is to add the da steps. The `dar` package incorporates multiple methods to analyze the data, including: ALDEx2, ANCOM-BC, corncob, DESeq2, Lefse, MAaslin2, MetagenomeSeq, and Wilcox. These methods provide a range of options for uncovering potential microbial biomarkers associated with the variable of interest. To ensure consistency across methods, we decided not to use default parameters, but to set the `min_prevalence` parameter to 0 for MAaslin2, and the `rm_zeros` parameter to 0.01 for MetagenomeSeq, since it was observed that the pct\_all\_zeros value was not equal to 0 in some levels of the categorical variable in the results of `phy_qc()`. This approach ensured that the analysis was consistent across all methods and that the results were interpretable.

Note: to reduce computation time, in this example we will only use the metagenomeSeq and MAaslin2 methods, that are the fastest ones. However, we recommend using all the methods available in the package to ensure a more robust analysis.

```
## DA steps definition
rec <- rec |>
  step_metagenomeseq(rm_zeros = 0.01) |>
  step_maaslin(min_prevalence = 0)

rec
#> ── DAR Recipe ──────────────────────────────────────────────────────────────────
#> Inputs:
#>
#>      ℹ phyloseq object with 451 taxa and 156 samples
#>      ℹ variable of interes RiskGroup2 (class: character, levels: hts, msm, pwid)
#>      ℹ taxonomic level Species
#>
#> Preporcessing steps:
#>
#>      ◉ step_subset_taxa() id = subset_taxa__Apple_strudel
#>      ◉ step_filter_by_prevalence() id = filter_by_prevalence__Djevrek
#>
#> DA steps:
#>
#>      ◉ step_metagenomeseq() id = metagenomeseq__Chouquette
#>      ◉ step_maaslin() id = maaslin__Chou_à_la_crème
```

## Prep recipe

Once the recipe has been defined, the next step is to execute all the steps defined in the recipe. This is done through the function `prep()`. Internally, it first executes the preprocessing steps, which modify the phyloseq object stored in the recipe. Then, using the modified phyloseq, it executes each of the defined differential abundance methods. To speed up the execution time, the `prep()` function includes the option to run in parallel. The resulting object has class `PrepRecipe` and when printed in the terminal, it displays the number of taxa detected as significant in each of the methods and also the total number of taxa shared across all methods. This allows for a provisional overview of the results and a comparison between methods.

```
## Execute in parallel
da_results <- prep(rec, parallel = TRUE)
#> Warning in sqrt(out$s2.post): NaNs produced
#> Warning in sqrt(out$s2.post): NaNs produced
#> Warning in sqrt(out$s2.post): NaNs produced
da_results
#> ── DAR Results ─────────────────────────────────────────────────────────────────
#> Inputs:
#>
#>      ℹ phyloseq object with 355 taxa and 156 samples
#>      ℹ variable of interes RiskGroup2 (class: character, levels: hts, msm, pwid)
#>      ℹ taxonomic level Species
#>
#> Results:
#>
#>      ✔ metagenomeseq__Chouquette diff_taxa = 294
#>      ✔ maaslin__Chou_à_la_crème diff_taxa = 235
#>
#>      ℹ 210 taxa are present in all tested methods
```

## Default results extraction

At this point, we could extract the taxa shared across all methods using the function `bake()` to define a default consensus strategy and then `cool()` to extract the results.

```
## Default DA taxa results
results <-
  bake(da_results) |>
  cool()

results
#> # A tibble: 210 × 2
#>    taxa_id taxa
#>    <chr>   <chr>
#>  1 Otu_70  Bacteroides_sp_CAG_598
#>  2 Otu_73  Bacteroides_sp_D2
#>  3 Otu_369 Dialister_sp_CAG_357
#>  4 Otu_121 Alistipes_sp_An31A
#>  5 Otu_63  Bacteroides_plebeius
#>  6 Otu_216 Clostridium_sp_CAG_632
#>  7 Otu_257 Butyrivibrio_sp_CAG_318
#>  8 Otu_137 Enterococcus_avium
#>  9 Otu_49  Bacteroides_coprocola
#> 10 Otu_441 Brachyspira_sp_CAG_700
#> # ℹ 200 more rows
```

However, `dar` allows for complex consensus strategies based on the obtained results. To that end, the user has access to different functions to graphically represent different types of information. This feature allows for a more in-depth analysis of the results and a better understanding of the underlying patterns in the data.

## Exploration for consensus strategie definition

For example, `intersection_plt()` gives an overview of the overlaps between methods by creating an upSet plot. In our case, this function has shown that 210 taxa are shared across all the methods used.

```
## Intersection plot
intersection_plt(da_results, ordered_by = "degree", font_size = 1)
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the UpSetR package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the UpSetR package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: The `size` argument of `element_line()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> ℹ The deprecated feature was likely used in the UpSetR package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

In addition to the `intersection_plt()` function, `dar` also has the function `exclusion_plt()` which provides information about the number of OTUs shared between methods. This function allows to identify the OTUs that are specific to each method and also the ones that are not shared among any method.

```
## Exclusion plot
exclusion_plt(da_results)
```

![](data:image/png;base64...)

Besides to the previously mentioned functions, `dar` also includes the function `corr_heatmap()`, which allows for visualization of the overlap of significant OTUs between tested methods. This function can provide similar information to the previous plots, but in some cases it may be easier to interpret. comprehensive view of the results.

```
## Correlation heatmap
corr_heat <- corr_heatmap(da_results, font_size = 10)
corr_heat
```

Finally, `dar` also includes the function `mutual_plt()`, which plots the number of differential abundant features mutually found by a defined number of methods, colored by the differential abundance direction and separated by comparison. The resulting graph allows us to see that the features detected correspond mainly to the comparisons between hts vs msm and msm vs pwid. Additionally, the graph also allows us to observe the direction of the effect; whether a specific OTU is enriched or depleted for each comparison.

```
## Mutual plot
mutual_plt(
  da_results,
  count_cutoff = length(steps_ids(da_results, type = "da"))
)
```

![](data:image/png;base64...)

## Define a consesus strategy using bake

After visually inspecting the results from running all the differential analysis methods on our data, we have the necessary information to define a consensus strategy that fits our dataset. In our case, we will retain all the methods. However if one or more methods are not desired, the `bake()` function includes the `exclude` parameter, which allows to exclude specific methods.

Additionally, the `bake()` function allows to further refine the consensus strategy through its parameters, such as `count_cutoff`, which indicates the minimum number of methods in which an OTU must be present, and `weights`, a named vector with the ponderation value for each method. However, for simplicity, these parameters are not used in this example.

```
## Define consensus strategy
da_results <- bake(da_results)
da_results
#> ── DAR Results ─────────────────────────────────────────────────────────────────
#> Inputs:
#>
#>      ℹ phyloseq object with 355 taxa and 156 samples
#>      ℹ variable of interes RiskGroup2 (class: character, levels: hts, msm, pwid)
#>      ℹ taxonomic level Species
#>
#> Results:
#>
#>      ✔ metagenomeseq__Chouquette diff_taxa = 294
#>      ✔ maaslin__Chou_à_la_crème diff_taxa = 235
#>
#>      ℹ 210 taxa are present in all tested methods
#>
#> Bakes:
#>
#>      ◉ 1 -> count_cutoff: NULL, weights: NULL, exclude: NULL, id: bake__Ensaïmada
```

## Extract results

To conclude, we can extract the final results using the `cool()` function. This function takes a `PrepRecipe` object and the ID of the bake to be used as input (by default it is 1, but if you have multiple consensus strategies, you can change it to extract the desired results).

```
## Extract results for bake id 1
f_results <- cool(da_results, bake = 1)

f_results
#> # A tibble: 210 × 2
#>    taxa_id taxa
#>    <chr>   <chr>
#>  1 Otu_70  Bacteroides_sp_CAG_598
#>  2 Otu_73  Bacteroides_sp_D2
#>  3 Otu_369 Dialister_sp_CAG_357
#>  4 Otu_121 Alistipes_sp_An31A
#>  5 Otu_63  Bacteroides_plebeius
#>  6 Otu_216 Clostridium_sp_CAG_632
#>  7 Otu_257 Butyrivibrio_sp_CAG_318
#>  8 Otu_137 Enterococcus_avium
#>  9 Otu_49  Bacteroides_coprocola
#> 10 Otu_441 Brachyspira_sp_CAG_700
#> # ℹ 200 more rows
```

To further visualize the results, the `abundance_plt()` function can be utilized to visualize the differences in abundance of the differential abundant taxa.

```
## Ids for Bacteroide and Provotella species
ids <-
  f_results |>
  dplyr::filter(stringr::str_detect(taxa, "Bacteroi.*|Prevote.*")) |>
  dplyr::pull(taxa_id)

## Abundance plot as boxplot
abundance_plt(da_results, taxa_ids = ids, type = "boxplot")
```

![](data:image/png;base64...)

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
#>  package      * version date (UTC) lib source
#>  ade4           1.7-23  2025-02-14 [2] CRAN (R 4.5.1)
#>  ape            5.8-1   2024-12-16 [2] CRAN (R 4.5.1)
#>  assertthat     0.2.1   2019-03-21 [2] CRAN (R 4.5.1)
#>  Biobase        2.70.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics   0.56.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  biomformat     1.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings     2.78.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  brio           1.1.5   2024-04-24 [2] CRAN (R 4.5.1)
#>  bslib          0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  ca             0.71.1  2020-01-24 [2] CRAN (R 4.5.1)
#>  cachem         1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  cli            3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  cluster        2.1.8.1 2025-03-12 [3] CRAN (R 4.5.1)
#>  codetools      0.2-20  2024-03-31 [3] CRAN (R 4.5.1)
#>  crayon         1.5.3   2024-06-20 [2] CRAN (R 4.5.1)
#>  crosstalk      1.2.2   2025-08-26 [2] CRAN (R 4.5.1)
#>  dar          * 1.6.0   2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  data.table     1.17.8  2025-07-10 [2] CRAN (R 4.5.1)
#>  dendextend     1.19.1  2025-07-15 [2] CRAN (R 4.5.1)
#>  devtools       2.4.6   2025-10-03 [2] CRAN (R 4.5.1)
#>  dichromat      2.0-0.1 2022-05-02 [2] CRAN (R 4.5.1)
#>  digest         0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr          1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
#>  ellipsis       0.3.2   2021-04-29 [2] CRAN (R 4.5.1)
#>  evaluate       1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  farver         2.1.2   2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap        1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  foreach        1.5.2   2022-02-02 [2] CRAN (R 4.5.1)
#>  fs             1.6.6   2025-04-12 [2] CRAN (R 4.5.1)
#>  furrr          0.3.1   2022-08-15 [2] CRAN (R 4.5.1)
#>  future         1.67.0  2025-07-29 [2] CRAN (R 4.5.1)
#>  generics       0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  ggplot2        4.0.0   2025-09-11 [2] CRAN (R 4.5.1)
#>  globals        0.18.0  2025-05-08 [2] CRAN (R 4.5.1)
#>  glue           1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
#>  gridExtra      2.3     2017-09-09 [2] CRAN (R 4.5.1)
#>  gtable         0.3.6   2024-10-25 [2] CRAN (R 4.5.1)
#>  heatmaply      1.6.0   2025-07-12 [2] CRAN (R 4.5.1)
#>  htmltools      0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets    1.6.4   2023-12-06 [2] CRAN (R 4.5.1)
#>  httr           1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
#>  igraph         2.2.1   2025-10-27 [2] CRAN (R 4.5.1)
#>  IRanges        2.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iterators      1.0.14  2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib      0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite       2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr          1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling       0.4.3   2023-08-29 [2] CRAN (R 4.5.1)
#>  lattice        0.22-7  2025-04-02 [3] CRAN (R 4.5.1)
#>  lazyeval       0.2.2   2019-03-15 [2] CRAN (R 4.5.1)
#>  lifecycle      1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  listenv        0.9.1   2024-01-29 [2] CRAN (R 4.5.1)
#>  magrittr       2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
#>  MASS           7.3-65  2025-02-28 [3] CRAN (R 4.5.1)
#>  Matrix         1.7-4   2025-08-28 [3] CRAN (R 4.5.1)
#>  memoise        2.0.1   2021-11-26 [2] CRAN (R 4.5.1)
#>  mgcv           1.9-3   2025-04-04 [3] CRAN (R 4.5.1)
#>  microbiome     1.32.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  multtest       2.66.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  nlme           3.1-168 2025-03-31 [3] CRAN (R 4.5.1)
#>  parallelly     1.45.1  2025-07-24 [2] CRAN (R 4.5.1)
#>  permute        0.9-8   2025-06-25 [2] CRAN (R 4.5.1)
#>  phyloseq       1.54.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  pillar         1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgbuild       1.4.8   2025-05-26 [2] CRAN (R 4.5.1)
#>  pkgconfig      2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
#>  pkgload        1.4.1   2025-09-23 [2] CRAN (R 4.5.1)
#>  plotly         4.11.0  2025-06-19 [2] CRAN (R 4.5.1)
#>  plyr           1.8.9   2023-10-02 [2] CRAN (R 4.5.1)
#>  purrr          1.1.0   2025-07-10 [2] CRAN (R 4.5.1)
#>  R6             2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  RColorBrewer   1.1-3   2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp           1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
#>  registry       0.5-1   2019-03-05 [2] CRAN (R 4.5.1)
#>  remotes        2.5.0   2024-03-17 [2] CRAN (R 4.5.1)
#>  reshape2       1.4.4   2020-04-09 [2] CRAN (R 4.5.1)
#>  rhdf5          2.54.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  rhdf5filters   1.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Rhdf5lib       1.32.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  rlang          1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown      2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  Rtsne          0.17    2023-12-07 [2] CRAN (R 4.5.1)
#>  S4Vectors      0.48.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7             0.2.0   2024-11-07 [2] CRAN (R 4.5.1)
#>  sass           0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  scales         1.4.0   2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo        1.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  seriation      1.5.8   2025-08-20 [2] CRAN (R 4.5.1)
#>  sessioninfo    1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  stringi        1.8.7   2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr        1.5.2   2025-09-08 [2] CRAN (R 4.5.1)
#>  survival       3.8-3   2024-12-17 [3] CRAN (R 4.5.1)
#>  testthat       3.2.3   2025-01-13 [2] CRAN (R 4.5.1)
#>  tibble         3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr          1.3.1   2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect     1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
#>  TSP            1.2-5   2025-05-27 [2] CRAN (R 4.5.1)
#>  UpSetR         1.4.0   2019-05-22 [2] CRAN (R 4.5.1)
#>  usethis        3.2.1   2025-09-06 [2] CRAN (R 4.5.1)
#>  utf8           1.2.6   2025-06-08 [2] CRAN (R 4.5.1)
#>  vctrs          0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
#>  vegan          2.7-2   2025-10-08 [2] CRAN (R 4.5.1)
#>  viridis        0.6.5   2024-01-29 [2] CRAN (R 4.5.1)
#>  viridisLite    0.4.2   2023-05-02 [2] CRAN (R 4.5.1)
#>  webshot        0.5.5   2023-06-26 [2] CRAN (R 4.5.1)
#>  withr          3.0.2   2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun           0.53    2025-08-19 [2] CRAN (R 4.5.1)
#>  XVector        0.50.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml           2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpxvaRZh/Rinst3e30fb71cf6981
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```