# brendaDb

Yi Zhou1\*

1Institute of Bioinformatics, University of Georgia

\*Yi.Zhou@uga.edu

#### 2025-10-29

# 1 Overview

*[brendaDb](https://bioconductor.org/packages/3.22/brendaDb)* aims to make importing and analyzing data from the [BRENDA database](https://www.brenda-enzymes.org) easier. The main functions include:

* Read [text file downloaded from BRENDA](https://www.brenda-enzymes.org/download_brenda_without_registration.php) into an R `tibble`
* Retrieve information for specific enzymes
* Query enzymes using their synonyms, gene symbols, etc.
* Query enzyme information for specific [BioCyc](https://biocyc.org) pathways

For bug reports or feature requests, please go to the [GitHub repository](https://github.com/y1zhou/brendaDb/issues).

# 2 Installation

*[brendaDb](https://bioconductor.org/packages/3.22/brendaDb)* is a *Bioconductor* package and can be installed through `BiocManager::install()`.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("brendaDb", dependencies=TRUE)
```

Alternatively, install the development version from GitHub.

```
if(!requireNamespace("brendaDb")) {
  devtools::install_github("y1zhou/brendaDb")
}
```

After the package is installed, it can be loaded into the *R* workspace by

```
library(brendaDb)
```

# 3 Getting Started

## 3.1 Downloading the BRENDA Text File

Download the BRENDA database as [a text file](https://www.brenda-enzymes.org/download_brenda_without_registration.php) here. Alternatively, download the file in R (file updated 2019-04-24):

```
brenda.filepath <- DownloadBrenda()
#> Please read the license agreement in the link below.
#>
#> https://www.brenda-enzymes.org/download_brenda_without_registration.php
#>
#> Found zip file in cache.
#> Extracting zip file...
```

The function downloads the file to a local cache directory. Now the text file can be loaded into R as a `tibble`:

```
df <- ReadBrenda(brenda.filepath)
#> Reading BRENDA text file...
#> Converting text into a list. This might take a while...
#> Converting list to tibble and removing duplicated entries...
#> If you're going to use this data again, consider saving this table using data.table::fwrite().
```

As suggested in the function output, you may save the `df` object to a text file using `data.table::fwrite()` or to an R object using `save(df)`, and load the table using `data.table::fread()` or `load()`111 This requires the R package *[data.table](https://CRAN.R-project.org/package%3Ddata.table)* to be installed.. Both methods should be much faster than reading the raw text file again using `ReadBrenda()`.

# 4 Making Queries

Since BRENDA is a database for enzymes, all final queries are based on EC numbers.

## 4.1 Query for Multiple Enzymes

If you already have a list of EC numbers in mind, you may call `QueryBrenda` directly:

```
brenda_txt <- system.file("extdata", "brenda_download_test.txt",
                          package = "brendaDb")
df <- ReadBrenda(brenda_txt)
#> Reading BRENDA text file...
#> Converting text into a list. This might take a while...
#> Converting list to tibble and removing duplicated entries...
#> If you're going to use this data again, consider saving this table using data.table::fwrite().
res <- QueryBrenda(df, EC = c("1.1.1.1", "6.3.5.8"), n.core = 2)

res
#> A list of 2 brenda.entry object(s) with:
#>  - 1 regular brenda.entry object(s)
#>    1.1.1.1
#> - 1 transferred or deleted object(s)
#>    6.3.5.8

res[["1.1.1.1"]]
#> Entry 1.1.1.1
#> ├── nomenclature
#> |    ├── ec: 1.1.1.1
#> |    ├── systematic.name: alcohol:NAD+ oxidoreductase
#> |    ├── recommended.name: alcohol dehydrogenase
#> |    ├── synonyms: A tibble with 128 rows
#> |    ├── reaction: A tibble with 2 rows
#> |    └── reaction.type: A tibble with 3 rows
#> ├── interactions
#> |    ├── substrate.product: A tibble with 772 rows
#> |    ├── natural.substrate.product: A tibble with 20 rows
#> |    ├── cofactor: A tibble with 7 rows
#> |    ├── metals.ions: A tibble with 20 rows
#> |    ├── inhibitors: A tibble with 207 rows
#> |    └── activating.compound: A tibble with 22 rows
#> ├── parameters
#> |    ├── km.value: A tibble with 878 rows
#> |    ├── turnover.number: A tibble with 495 rows
#> |    ├── ki.value: A tibble with 34 rows
#> |    ├── pi.value: A tibble with 11 rows
#> |    ├── ph.optimum: A tibble with 55 rows
#> |    ├── ph.range: A tibble with 28 rows
#> |    ├── temperature.optimum: A tibble with 29 rows
#> |    ├── temperature.range: A tibble with 20 rows
#> |    ├── specific.activity: A tibble with 88 rows
#> |    └── ic50: A tibble with 2 rows
#> ├── organism
#> |    ├── organism: A tibble with 159 rows
#> |    ├── source.tissue: A tibble with 63 rows
#> |    └── localization: A tibble with 9 rows
#> ├── molecular
#> |    ├── stability
#> |    |    ├── general.stability: A tibble with 15 rows
#> |    |    ├── storage.stability: A tibble with 15 rows
#> |    |    ├── ph.stability: A tibble with 20 rows
#> |    |    ├── organic.solvent.stability: A tibble with 25 rows
#> |    |    ├── oxidation.stability: A tibble with 3 rows
#> |    |    └── temperature.stability: A tibble with 36 rows
#> |    ├── purification: A tibble with 48 rows
#> |    ├── cloned: A tibble with 46 rows
#> |    ├── engineering: A tibble with 60 rows
#> |    ├── renatured: A tibble with 1 rows
#> |    └── application: A tibble with 5 rows
#> ├── structure
#> |    ├── molecular.weight: A tibble with 119 rows
#> |    ├── subunits: A tibble with 11 rows
#> |    ├── posttranslational.modification: A tibble with 2 rows
#> |    └── crystallization: A tibble with 22 rows
#> └── bibliography
#> |    └── reference: A tibble with 285 rows
```

## 4.2 Query Specific Fields

You can also query for certain fields to reduce the size of the returned object.

```
ShowFields(df)
#> # A tibble: 40 × 2
#>    field                     acronym
#>    <chr>                     <chr>
#>  1 PROTEIN                   PR
#>  2 RECOMMENDED_NAME          RN
#>  3 SYSTEMATIC_NAME           SN
#>  4 SYNONYMS                  SY
#>  5 REACTION                  RE
#>  6 REACTION_TYPE             RT
#>  7 SOURCE_TISSUE             ST
#>  8 LOCALIZATION              LO
#>  9 NATURAL_SUBSTRATE_PRODUCT NSP
#> 10 SUBSTRATE_PRODUCT         SP
#> # ℹ 30 more rows

res <- QueryBrenda(df, EC = "1.1.1.1", fields = c("PROTEIN", "SUBSTRATE_PRODUCT"))
res[["1.1.1.1"]][["interactions"]][["substrate.product"]]
#> # A tibble: 772 × 7
#>    proteinID substrate             product commentarySubstrate commentaryProduct
#>    <chr>     <chr>                 <chr>   <chr>               <chr>
#>  1 10        n-propanol + NAD+     n-prop… <NA>                <NA>
#>  2 10        2-propanol + NAD+     aceton… <NA>                <NA>
#>  3 10        n-hexanol + NAD+      n-hexa… <NA>                <NA>
#>  4 10        (S)-2-butanol + NAD+  2-buta… <NA>                <NA>
#>  5 10        ethylenglycol + NAD+  ? + NA… <NA>                <NA>
#>  6 10        n-butanol + NAD+      butyra… <NA>                <NA>
#>  7 10        n-decanol + NAD+      n-deca… <NA>                <NA>
#>  8 10        Tris + NAD+           ? + NA… <NA>                <NA>
#>  9 10        isopropanol + NAD+    aceton… <NA>                <NA>
#> 10 10        5-hydroxymethylfurfu… (furan… #10# mutant enzyme… <NA>
#> # ℹ 762 more rows
#> # ℹ 2 more variables: reversibility <chr>, refID <chr>
```

It should be noted that most fields contain a `fieldInfo` column and a `commentary` column. The `fieldInfo` column is what’s extracted by BRENDA from the literature, and the `commentary` column is usually some context from the original paper. `#` symbols in the commentary correspond to the `proteinID`s, and `<>` enclose the corresponding `refID`s. For further information, please see [the README file from BRENDA](https://www.brenda-enzymes.org/download_brenda_without_registration.php).

## 4.3 Query Specific Organisms

Note the difference in row numbers in the following example and in the one where we queried for [all organisms](#query-for-multiple-enzymes).

```
res <- QueryBrenda(df, EC = "1.1.1.1", organisms = "Homo sapiens")
res$`1.1.1.1`
#> Entry 1.1.1.1
#> ├── nomenclature
#> |    ├── ec: 1.1.1.1
#> |    ├── systematic.name: alcohol:NAD+ oxidoreductase
#> |    ├── recommended.name: alcohol dehydrogenase
#> |    ├── synonyms: A tibble with 41 rows
#> |    ├── reaction: A tibble with 2 rows
#> |    └── reaction.type: A tibble with 3 rows
#> ├── interactions
#> |    ├── substrate.product: A tibble with 102 rows
#> |    ├── natural.substrate.product: A tibble with 9 rows
#> |    ├── cofactor: A tibble with 2 rows
#> |    ├── metals.ions: A tibble with 2 rows
#> |    └── inhibitors: A tibble with 36 rows
#> ├── parameters
#> |    ├── km.value: A tibble with 163 rows
#> |    ├── turnover.number: A tibble with 64 rows
#> |    ├── ki.value: A tibble with 8 rows
#> |    ├── ph.optimum: A tibble with 15 rows
#> |    ├── ph.range: A tibble with 2 rows
#> |    ├── temperature.optimum: A tibble with 2 rows
#> |    └── specific.activity: A tibble with 5 rows
#> ├── organism
#> |    ├── organism: A tibble with 3 rows
#> |    ├── source.tissue: A tibble with 21 rows
#> |    └── localization: A tibble with 1 rows
#> ├── molecular
#> |    ├── stability
#> |    |    ├── general.stability: A tibble with 1 rows
#> |    |    ├── storage.stability: A tibble with 4 rows
#> |    |    ├── ph.stability: A tibble with 1 rows
#> |    |    ├── organic.solvent.stability: A tibble with 1 rows
#> |    |    └── temperature.stability: A tibble with 2 rows
#> |    ├── purification: A tibble with 7 rows
#> |    ├── cloned: A tibble with 5 rows
#> |    ├── engineering: A tibble with 3 rows
#> |    └── application: A tibble with 1 rows
#> ├── structure
#> |    ├── molecular.weight: A tibble with 12 rows
#> |    ├── subunits: A tibble with 3 rows
#> |    └── crystallization: A tibble with 2 rows
#> └── bibliography
#> |    └── reference: A tibble with 285 rows
```

## 4.4 Extract Information in Query Results

To transform the `brenda.entries` structure into a table, use the helper function `ExtractField()`.

```
res <- QueryBrenda(df, EC = c("1.1.1.1", "6.3.5.8"), n.core = 2)
ExtractField(res, field = "parameters$ph.optimum")
#> Deprecated entries in the res object will be removed.
#> # A tibble: 158 × 9
#>    ec      organism       proteinID uniprot org.commentary description fieldInfo
#>    <chr>   <chr>          <chr>     <chr>   <chr>          <chr>       <lgl>
#>  1 1.1.1.1 Acetobacter p… 60        <NA>    <NA>           5.5         NA
#>  2 1.1.1.1 Acetobacter p… 60        <NA>    <NA>           6           NA
#>  3 1.1.1.1 Acetobacter p… 60        <NA>    <NA>           8.5         NA
#>  4 1.1.1.1 Acinetobacter… 28        <NA>    <NA>           5.9         NA
#>  5 1.1.1.1 Aeropyrum per… 131       Q9Y9P9  <NA>           10.5        NA
#>  6 1.1.1.1 Aeropyrum per… 131       Q9Y9P9  <NA>           8           NA
#>  7 1.1.1.1 Arabidopsis t… 20        <NA>    <NA>           10.5        NA
#>  8 1.1.1.1 Aspergillus n… 14        <NA>    <NA>           8.1         NA
#>  9 1.1.1.1 Brevibacteriu… 46        <NA>    <NA>           10.4        NA
#> 10 1.1.1.1 Brevibacteriu… 46        <NA>    <NA>           6           NA
#> # ℹ 148 more rows
#> # ℹ 2 more variables: commentary <chr>, refID <chr>
```

As shown above, the returned table consists of three parts: the EC number, organism-related information (organism, protein ID, uniprot ID, and commentary on the organism), and extracted field information (description, commentary, etc.).

# 5 Foreign ID Retrieval

## 5.1 Querying Synonyms

A lot of the times we have a list of gene symbols or enzyme names instead of EC numbers. In this case, a helper function can be used to find the corresponding EC numbers:

```
ID2Enzyme(brenda = df, ids = c("ADH4", "CD38", "pyruvate dehydrogenase"))
#> # A tibble: 4 × 5
#>   ID                     EC        RECOMMENDED_NAME     SYNONYMS SYSTEMATIC_NAME
#>   <chr>                  <chr>     <chr>                <chr>    <chr>
#> 1 ADH4                   1.1.1.1   <NA>                 "aldehy… <NA>
#> 2 CD38                   2.4.99.20 <NA>                 "#1,3,4… <NA>
#> 3 pyruvate dehydrogenase 1.2.1.51  pyruvate dehydrogen… "#1,2# … <NA>
#> 4 pyruvate dehydrogenase 2.7.11.2  [pyruvate dehydroge… "kinase… ATP:[pyruvate …
```

The `EC` column can be then handpicked and used in `QueryBrenda()`.

## 5.2 BioCyc Pathways

Often we are interested in the enzymes involved in a specific [BioCyc](https://biocyc.org) pathway. As BioCyc now requires login credentials
for using their web service, users are recommended to use the [metabolike](https://github.com/y1zhou/metabolike) package for more advanced queries.

# Additional Information

By default `QueryBrenda` uses all available cores, but often limiting `n.core` could give better performance as it reduces the overhead. The following are results produced on a machine with 40 cores (2 Intel Xeon CPU E5-2640 v4 @ 3.4GHz), and 256G of RAM:

```
EC.numbers <- head(unique(df$ID), 100)
system.time(QueryBrenda(df, EC = EC.numbers, n.core = 0))  # default
#  user  system elapsed
# 4.528   7.856  34.567
system.time(QueryBrenda(df, EC = EC.numbers, n.core = 1))
#  user  system elapsed
# 22.080   0.360  22.438
system.time(QueryBrenda(df, EC = EC.numbers, n.core = 2))
#  user  system elapsed
# 0.552   0.400  13.597
system.time(QueryBrenda(df, EC = EC.numbers, n.core = 4))
#  user  system elapsed
# 0.688   0.832   9.517
system.time(QueryBrenda(df, EC = EC.numbers, n.core = 8))
#  user  system elapsed
# 1.112   1.476  10.000
```

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
#> [1] brendaDb_1.24.0  BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] utf8_1.2.6          rappdirs_0.3.3      sass_0.4.10
#>  [4] generics_0.1.4      tidyr_1.3.1         RSQLite_2.4.3
#>  [7] stringi_1.8.7       digest_0.6.37       magrittr_2.0.4
#> [10] evaluate_1.0.5      bookdown_0.45       fastmap_1.2.0
#> [13] blob_1.2.4          jsonlite_2.0.0      DBI_1.2.3
#> [16] BiocManager_1.30.26 purrr_1.1.0         codetools_0.2-20
#> [19] httr2_1.2.1         jquerylib_0.1.4     cli_3.6.5
#> [22] rlang_1.1.6         crayon_1.5.3        dbplyr_2.5.1
#> [25] bit64_4.6.0-1       withr_3.0.2         cachem_1.1.0
#> [28] yaml_2.3.10         tools_4.5.1         parallel_4.5.1
#> [31] BiocParallel_1.44.0 memoise_2.0.1       dplyr_1.1.4
#> [34] filelock_1.0.3      curl_7.0.0          vctrs_0.6.5
#> [37] R6_2.6.1            BiocFileCache_3.0.0 lifecycle_1.0.4
#> [40] stringr_1.5.2       bit_4.6.0           pkgconfig_2.0.3
#> [43] pillar_1.11.1       bslib_0.9.0         glue_1.8.0
#> [46] Rcpp_1.1.0          xfun_0.53           tibble_3.3.0
#> [49] tidyselect_1.2.1    knitr_1.50          htmltools_0.5.8.1
#> [52] rmarkdown_2.30      compiler_4.5.1
```