Code

* Show All Code
* Hide All Code

# tidyFlowCore

Timothy Keyes1\*

1Stanford University School of Medicine

\*tkeyes@stanford.edu

#### 30 October 2025

#### Package

tidyFlowCore 1.4.0

# 1 Basics

## 1.1 Installing `tidyFlowCore`

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages. *[tidyFlowCore](https://bioconductor.org/packages/3.22/tidyFlowCore)* is an `R` package available via [Bioconductor](http://bioconductor.org), an open-source repository for R packages related to biostatistics and biocomputing.

`R` can be installed on any operating system from [CRAN](https://cran.r-project.org/), after which you can install *[tidyFlowCore](https://bioconductor.org/packages/3.22/tidyFlowCore)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
      install.packages("BiocManager")
  }

BiocManager::install("tidyFlowCore")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.2 Preliminaries

*[tidyFlowCore](https://bioconductor.org/packages/3.22/tidyFlowCore)* adopts the so-called “tidy” functional programming paradigm developed by Wickham et al. in the `tidyverse` ecosystem of R packages (Wickham, François, Henry, Müller, and Vaughan, 2023). For information about the `tidyverse` ecosytem broadly, feel free to reference the (free) [R for Data Science](https://r4ds.hadley.nz/) book, the [tidyverse website](https://www.tidyverse.org/), or [this paper](https://www.biorxiv.org/content/10.1101/2023.09.10.557072v2) describing the larger `tidyomics` project.

*[tidyFlowCore](https://bioconductor.org/packages/3.22/tidyFlowCore)* integrates the `flowCore` Bioconductor package’s data analysis capabilities with those of the `tidyverse`. If you’re relatively unfamiliar with the Bioconductor project, you might be interested in [this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).

## 1.3 Asking for help

Learning to use `R` and `Bioconductor` can be challenging, so it’s important to know where to get help. The main place to ask questions about `tidyFlowCore` is the [Bioconductor support site](https://support.bioconductor.org/). Use the `tidyFlowCore` tag there and look at [previous posts](https://support.bioconductor.org/tag/tidyFlowCore/).

You can also ask questions on GitHub or Twitter. But remember, if you’re asking for help, follow the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). Make sure to include a simple example that reproduces your issue (a [“reprex”](https://reprex.tidyverse.org/articles/learn-reprex.html)) and your session info to help developers understand and solve your problem.

## 1.4 Citing `tidyFlowCore`

If you use *[tidyFlowCore](https://bioconductor.org/packages/3.22/tidyFlowCore)* for your research, please use the following citation.

```
citation("tidyFlowCore")
#> Warning in person1(given = given[[i]], family = family[[i]], middle =
#> middle[[i]], : It is recommended to use 'given' instead of 'middle'.
#> To cite package 'tidyFlowCore' in publications use:
#>
#>   Keyes TJ (2025). _tidyFlowCore: Bringing flowCore to the tidyverse_.
#>   doi:10.18129/B9.bioc.tidyFlowCore
#>   <https://doi.org/10.18129/B9.bioc.tidyFlowCore>,
#>   https://github.com/keyes-timothy/tidyflowCore/tidyFlowCore - R
#>   package version 1.4.0,
#>   <http://www.bioconductor.org/packages/tidyFlowCore>.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Manual{,
#>     title = {tidyFlowCore: Bringing flowCore to the tidyverse},
#>     author = {Timothy J Keyes},
#>     year = {2025},
#>     url = {http://www.bioconductor.org/packages/tidyFlowCore},
#>     note = {https://github.com/keyes-timothy/tidyflowCore/tidyFlowCore - R package version 1.4.0},
#>     doi = {10.18129/B9.bioc.tidyFlowCore},
#>   }
```

# 2 `tidyFlowCore` quick start

`tidyFlowCore` allows you to treat `flowCore` data structures like tidy `data.frame`s or `tibbles`. It does so by implementing dplyr, tidyr, and ggplot2 verbs that can be deployed directly on the `flowFrame` and `flowSet` S4 classes.

In this section, we give a brief example of how `tidyFlowCore` can enable a data analysis pipeline to use all the useful functions of the `flowCore` package and many of the functions of the `dplyr`, `tidyr`, and `ggplot2` packages.

## 2.1 Load required packages

```
library(tidyFlowCore)
library(flowCore)
```

## 2.2 Read data

For our example here, we download some publicly available mass cytometry (CyTOF) data downloadable through the (Weber, M, Soneson, and Charlotte, 2019) package. These data are made available as a `flowCore::flowSet` S4 object, `Bioconductor`’s standard data structure for cytometry data.

```
# read data from the HDCytoData package
bcr_flowset <- HDCytoData::Bodenmiller_BCR_XL_flowSet()
#> see ?HDCytoData and browseVignettes('HDCytoData') for documentation
#> loading from cache
#> Warning in updateObjectFromSlots(object, ..., verbose = verbose): dropping
#> slot(s) 'colnames' from object = 'flowSet'
```

To read more about this dataset, run the following command:

```
?HDCytoData::Bodenmiller_BCR_XL_flowSet
```

## 2.3 Data transformation

The `flowCore` package natively supports multiple types of data preprocessing and transformations for cytometry data through the use of its `tranform` class.

For example, if we want to apply the standard arcsinh transformation often used for CyTOF data to our current dataset, we could use the following code:

```
asinh_transformation <- flowCore::arcsinhTransform(a = 0, b = 1/5, c = 0)
transformation_list <-
  flowCore::transformList(
    colnames(bcr_flowset),
    asinh_transformation
  )

transformed_bcr_flowset <- flowCore::transform(bcr_flowset, transformation_list)
```

Alternatively, we can also use the `tidyverse`’s functional programming paradigm to perform the same transformation. For this, we use the `mutate`-`across` framework via `tidyFlowCore`:

```
transformed_bcr_flowset <-
  bcr_flowset |>
  dplyr::mutate(across(-ends_with("_id"), \(.x) asinh(.x / 5)))
```

## 2.4 Cell type counting

Suppose we’re interested in counting the number of cells that belong to each cell type (encoded in the `population_id` column of `bcr_flowset`) in our dataset. Using standard `flowCore` functions, we could perform this calculation in a few steps:

```
# extract all expression matrices from our flowSet
combined_matrix <- flowCore::fsApply(bcr_flowset, exprs)

# take out the concatenated population_id column
combined_population_id <- combined_matrix[, 'population_id']

# perform the calculation
table(combined_population_id)
#> combined_population_id
#>     1     2     3     4     5     6     7     8
#>  3265  6651 62890 51150  1980 18436 24518  3901
```

`tidyFlowCore` allows us to perform the same operation simply using the `dplyr` package’s `count` function, with output provided in the convenient form of a `tibble`:

```
bcr_flowset |>
  dplyr::count(population_id)
#> # A tibble: 8 × 2
#>   population_id     n
#>           <dbl> <int>
#> 1             1  3265
#> 2             2  6651
#> 3             3 62890
#> 4             4 51150
#> 5             5  1980
#> 6             6 18436
#> 7             7 24518
#> 8             8  3901
```

`tidyFlowCore` also makes it easy to perform the counting after grouping by other variables in our metadata. For example, we can see that `bcr_flowset` contains data from multiple .FCS files, each of which is associated with a file name.

```
flowCore::pData(object = bcr_flowset)
#>                                                                  name
#> PBMC8_30min_patient1_BCR-XL.fcs       PBMC8_30min_patient1_BCR-XL.fcs
#> PBMC8_30min_patient1_Reference.fcs PBMC8_30min_patient1_Reference.fcs
#> PBMC8_30min_patient2_BCR-XL.fcs       PBMC8_30min_patient2_BCR-XL.fcs
#> PBMC8_30min_patient2_Reference.fcs PBMC8_30min_patient2_Reference.fcs
#> PBMC8_30min_patient3_BCR-XL.fcs       PBMC8_30min_patient3_BCR-XL.fcs
#> PBMC8_30min_patient3_Reference.fcs PBMC8_30min_patient3_Reference.fcs
#> PBMC8_30min_patient4_BCR-XL.fcs       PBMC8_30min_patient4_BCR-XL.fcs
#> PBMC8_30min_patient4_Reference.fcs PBMC8_30min_patient4_Reference.fcs
#> PBMC8_30min_patient5_BCR-XL.fcs       PBMC8_30min_patient5_BCR-XL.fcs
#> PBMC8_30min_patient5_Reference.fcs PBMC8_30min_patient5_Reference.fcs
#> PBMC8_30min_patient6_BCR-XL.fcs       PBMC8_30min_patient6_BCR-XL.fcs
#> PBMC8_30min_patient6_Reference.fcs PBMC8_30min_patient6_Reference.fcs
#> PBMC8_30min_patient7_BCR-XL.fcs       PBMC8_30min_patient7_BCR-XL.fcs
#> PBMC8_30min_patient7_Reference.fcs PBMC8_30min_patient7_Reference.fcs
#> PBMC8_30min_patient8_BCR-XL.fcs       PBMC8_30min_patient8_BCR-XL.fcs
#> PBMC8_30min_patient8_Reference.fcs PBMC8_30min_patient8_Reference.fcs
```

`tidyFlowCore` makes it easy to perform grouped tidy operations, like counting, using information in our `flowSet`’s metadata:

```
bcr_flowset |>
  # use the .tidyFlowCore_identifier pronoun to access the name of
  # each experiment in the flowSet
  dplyr::count(.tidyFlowCore_identifier, population_id)
#> # A tibble: 128 × 3
#>    .tidyFlowCore_identifier           population_id     n
#>    <chr>                                      <dbl> <int>
#>  1 PBMC8_30min_patient1_BCR-XL.fcs                1    31
#>  2 PBMC8_30min_patient1_BCR-XL.fcs                2   112
#>  3 PBMC8_30min_patient1_BCR-XL.fcs                3   761
#>  4 PBMC8_30min_patient1_BCR-XL.fcs                4  1307
#>  5 PBMC8_30min_patient1_BCR-XL.fcs                5     5
#>  6 PBMC8_30min_patient1_BCR-XL.fcs                6   127
#>  7 PBMC8_30min_patient1_BCR-XL.fcs                7   444
#>  8 PBMC8_30min_patient1_BCR-XL.fcs                8    51
#>  9 PBMC8_30min_patient1_Reference.fcs             1    52
#> 10 PBMC8_30min_patient1_Reference.fcs             2   132
#> # ℹ 118 more rows
```

## 2.5 Nesting and unnesting

`flowFrame` and `flowSet` data objects have a clear relationship with one another in the `flowCore` application programming interface (API). Essentially, `flowSet`s are nested `flowFrame`s - or, in other words, `flowSet`s are made up of multiple `flowFrame`s!

`tidyFlowCore` provides a useful API for converting between `flowSet` and `flowFrame` data structures at various degrees of nesting using the `group`/`nest` and `ungroup`/`unnest` verbs. Note that in the `dplyr` and `tidyr` APIs, `group`/`nest` and `ungroup`/`unnest` are **not** synonyms (grouped `data.frames` are different from nested `data.frames`). However, because of how `flowFrame`s and `flowSet`s are structured, `tidyFlowCore`’s `group`/`nest` and `ungroup`/`unnest` functions have identical behavior, respectively.

```
# unnesting a flowSet results in a flowFrame with an additional column,
# 'tidyFlowCore_name` that identifies cells based on which experiment in the
# original flowSet they come from
bcr_flowset |>
  dplyr::ungroup()
#> flowFrame object 'file3792f34ffa10e2'
#> with 172791 cells and 40 observables:
#>                    name               desc     range  minRange  maxRange
#> $P1                Time               Time   2399633    0.0000   2399632
#> $P2         Cell_length        Cell_length        69    0.0000        68
#> $P3      CD3(110:114)Dd     CD3(110:114)Dd      9383  -61.6796      9382
#> $P4       CD45(In115)Dd      CD45(In115)Dd      5035    0.0000      5034
#> $P5        BC1(La139)Dd       BC1(La139)Dd     14306 -100.8797     14305
#> ...                 ...                ...       ...       ...       ...
#> $P36           group_id           group_id         3         0         2
#> $P37         patient_id         patient_id         9         0         8
#> $P38          sample_id          sample_id        17         0        16
#> $P39      population_id      population_id         9         0         8
#> $P40 .tidyFlowCore_name .tidyFlowCore_name        17         0        16
#> 297 keywords are stored in the 'description' slot
```

```
# flowSets can be unnested and re-nested for various analyses
bcr_flowset |>
  dplyr::ungroup() |>
  # group_by cell type
  dplyr::group_by(population_id) |>
  # calculate the mean HLA-DR expression of each cell population
  dplyr::summarize(mean_hladr_expression = mean(`HLA-DR(Yb174)Dd`)) |>
  dplyr::select(population_id, mean_hladr_expression)
#> # A tibble: 8 × 2
#>   population_id mean_hladr_expression
#>           <dbl>                 <dbl>
#> 1             3                  3.67
#> 2             7                  3.33
#> 3             4                  4.33
#> 4             2                 87.1
#> 5             6                 88.2
#> 6             8                  3.12
#> 7             1                 51.4
#> 8             5                 18.0
```

## 2.6 Plotting

`tidyFlowCore` also provides a direct interface between `ggplot2` and `flowFrame` or `flowSet` data objects. For example…

```
# cell population names, from the HDCytoData documentation
population_names <-
  c(
    "B-cells IgM-",
    "B-cells IgM+",
    "CD4 T-cells",
    "CD8 T-cells",
    "DC",
    "monocytes",
    "NK cells",
    "surface-"
  )

# calculate mean CD20 expression across all cells
mean_cd20_expression <-
  bcr_flowset |>
  dplyr::ungroup() |>
  dplyr::summarize(mean_expression = mean(asinh(`CD20(Sm147)Dd` / 5))) |>
  dplyr::pull(mean_expression)

# calculate mean CD4 expression across all cells
mean_cd4_expression <-
  bcr_flowset |>
  dplyr::ungroup() |>
  dplyr::summarize(mean_expression = mean(asinh(`CD4(Nd145)Dd` / 5))) |>
  dplyr::pull(mean_expression)

bcr_flowset |>
  # preprocess all columns that represent protein measurements
  dplyr::mutate(dplyr::across(-ends_with("_id"), \(.x) asinh(.x / 5))) |>
  # plot a CD4 vs. CD45 scatterplot
  ggplot2::ggplot(ggplot2::aes(x = `CD20(Sm147)Dd`, y = `CD4(Nd145)Dd`)) +
  # add some reference lines
  ggplot2::geom_hline(
    yintercept = mean_cd4_expression,
    color = "red",
    linetype = "dashed"
  ) +
  ggplot2::geom_vline(
    xintercept = mean_cd20_expression,
    color = "red",
    linetype = "dashed"
  ) +
  ggplot2::geom_point(size = 0.1, alpha = 0.1) +
  # facet by cell population
  ggplot2::facet_wrap(
    facets = ggplot2::vars(population_id),
    labeller =
      ggplot2::as_labeller(
        \(population_id) population_names[as.numeric(population_id)]
      )
  ) +
  # axis labels
  ggplot2::labs(
    x = "CD20 expression (arcsinh)",
    y = "CD4 expression (arcsinh)"
  )
```

![](data:image/png;base64...)

Using some standard functions from the `ggplot2` library, we can create a scatterplot of CD4 vs. CD20 expression in the different cell populations included in the `bcr_flowset` `flowSet`. We can see, unsurprisingly, that both B-cell populations are highest for CD20 expression, whereas CD4+ T-helper cells are highest for CD4 expression.

# 3 Reproducibility

The *[tidyFlowCore](https://bioconductor.org/packages/3.22/tidyFlowCore)* package (Keyes, 2025) was made possible thanks to the following:

* R (R Core Team, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)
* *[tidyverse](https://CRAN.R-project.org/package%3Dtidyverse)* (Wickham, François, Henry et al., 2023)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.22/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("tidyFlowCore.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("tidyFlowCore.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-10-30 02:56:41 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 39.54 secs
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package              * version date (UTC) lib source
#>  abind                  1.4-8   2024-09-12 [2] CRAN (R 4.5.1)
#>  AnnotationDbi          1.72.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationHub        * 4.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  backports              1.5.0   2024-05-23 [2] CRAN (R 4.5.1)
#>  bibtex                 0.5.1   2023-01-26 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.70.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocFileCache        * 3.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocStyle            * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocVersion            3.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.78.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0   2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1 2025-01-16 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4   2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown               0.45    2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  crayon                 1.5.3   2024-06-20 [2] CRAN (R 4.5.1)
#>  curl                   7.0.0   2025-08-19 [2] CRAN (R 4.5.1)
#>  cytolib                2.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  DBI                    1.2.3   2024-06-02 [2] CRAN (R 4.5.1)
#>  dbplyr               * 2.5.1   2025-09-10 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  dichromat              2.0-0.1 2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  ExperimentHub        * 3.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  farver                 2.1.2   2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  filelock               1.0.3   2023-12-11 [2] CRAN (R 4.5.1)
#>  flowCore             * 2.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  generics             * 0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges        * 1.62.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ggplot2                4.0.0   2025-09-11 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6   2024-10-25 [2] CRAN (R 4.5.1)
#>  HDCytoData           * 1.29.1  2025-10-28 [2] Bioconductor 3.22 (R 4.5.1)
#>  htmltools              0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2                  1.2.1   2025-07-22 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  jquerylib              0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.50.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling               0.4.3   2023-08-29 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7  2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle              1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  lubridate              1.9.4   2024-12-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4   2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0   2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1   2021-11-26 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9   2023-10-02 [2] CRAN (R 4.5.1)
#>  png                    0.1-8   2022-11-29 [2] CRAN (R 4.5.1)
#>  purrr                  1.1.0   2025-07-10 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs               0.3.3   2021-01-31 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3   2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
#>  RefManageR           * 1.4.0   2022-09-30 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  RProtoBufLib           2.22.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  RSQLite                2.4.3   2025-08-20 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0   2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0   2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo              * 1.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo          * 1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  SparseArray            1.10.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  stringi                1.8.7   2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2   2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment * 1.40.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyFlowCore         * 1.4.0   2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  tidyr                  1.3.1   2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange             0.3.0   2024-01-18 [2] CRAN (R 4.5.1)
#>  utf8                   1.2.6   2025-06-08 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2   2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.53    2025-08-19 [2] CRAN (R 4.5.1)
#>  xml2                   1.4.1   2025-10-27 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpHL49F3/Rinst3791d615703c78
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 4 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-keyes2025tidyflowcore)
T. J. Keyes.
*tidyFlowCore: Bringing flowCore to the tidyverse*.
<https://github.com/keyes-timothy/tidyflowCore/tidyFlowCore> - R package version 1.4.0.
2025.
DOI: [10.18129/B9.bioc.tidyFlowCore](https://doi.org/10.18129/B9.bioc.tidyFlowCore).
URL: <http://www.bioconductor.org/packages/tidyFlowCore>.

[[3]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[4]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[5]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[6]](#cite-weber2019hdcytodata)
Weber, L. M, Soneson, et al.
“HDCytoData: Collection of high-dimensional cytometry benchmark datasets in Bioconductor object formats”.
In: *F1000Research* 8.v2 (2019), p. 1459.

[[7]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[8]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[9]](#cite-wickham2023dplyr)
H. Wickham, R. François, L. Henry, et al.
*dplyr: A Grammar of Data Manipulation*.
R package version 1.1.4.
2023.
DOI: [10.32614/CRAN.package.dplyr](https://doi.org/10.32614/CRAN.package.dplyr).
URL: [https://CRAN.R-project.org/package=dplyr](https://CRAN.R-project.org/package%3Ddplyr).

[[10]](#cite-xie2025knitr)
Y. Xie.
*knitr: A General-Purpose Package for Dynamic Report Generation in R*.
R package version 1.50.
2025.
URL: <https://yihui.org/knitr/>.