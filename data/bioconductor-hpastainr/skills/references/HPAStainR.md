# HPAStainR

#### Tim O. Nieuwenhuis

#### 2021-02-09

* [How to install HPAStainR](#how-to-install-hpastainr)
* [Preparing data for HPAStainR](#preparing-data-for-hpastainr)
* [Using HPAStainR](#using-hpastainr)
* [Using the HPAStainR Shiny app](#using-the-hpastainr-shiny-app)
* [Session Info](#session-info)

HPAStainR is a package designed to query the pathologist scored staining data of multiple proteins/genes at once in the Human Protein Atlas (HPA). This vignette will walk you through:

* How to download the data required to run HPAStainR
* How to run HPAStainR as a function
* How to run HPAStainR as a Shiny App

# How to install HPAStainR

Installation can be completed using BiocManager and the code below.

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("HPAStainR")
```

# Preparing data for HPAStainR

## Downloading data from the website

The first step required to run HPAStainR is downloading HPA’s normal tissue staining data and their cancer data. While available online, HPAStainR has a function that can download and load the data for you.

```
library(HPAStainR)
#> Loading required package: dplyr
#>
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#>
#>     filter, lag
#> The following objects are masked from 'package:base':
#>
#>     intersect, setdiff, setequal, union
#> Loading required package: tidyr

HPA_data <- HPA_data_downloader(tissue_type = "both", save_file = FALSE)
```

The above function has downloaded both normal tissue and cancer data. `save_file` was set to `FALSE`, but if it were set to `TRUE` as there was no given argument for `save location`, both files being saved to the current working directory. The data has also been unzipped and loaded into the object HPA\_dat as a list of data frames called `hpa_dat` and `cancer_dat` which hold the normal tissue and cancer tissue data respectively. If the code is run again it would redownload the files unless you had set `save_file` to `TRUE`, in which case it would just load said saved files.

### Head of normal tissue

| Gene | Gene.name | Tissue | Cell.type | Level | Reliability |
| --- | --- | --- | --- | --- | --- |
| ENSG00000000003 | TSPAN6 | adipose tissue | adipocytes | Not detected | Approved |
| ENSG00000000003 | TSPAN6 | adrenal gland | glandular cells | Not detected | Approved |
| ENSG00000000003 | TSPAN6 | appendix | glandular cells | Medium | Approved |
| ENSG00000000003 | TSPAN6 | appendix | lymphoid tissue | Not detected | Approved |
| ENSG00000000003 | TSPAN6 | bone marrow | hematopoietic cells | Not detected | Approved |
| ENSG00000000003 | TSPAN6 | breast | adipocytes | Not detected | Approved |
| ENSG00000000003 | TSPAN6 | breast | glandular cells | High | Approved |
| ENSG00000000003 | TSPAN6 | breast | myoepithelial cells | Not detected | Approved |
| ENSG00000000003 | TSPAN6 | bronchus | respiratory epithelial cells | High | Approved |
| ENSG00000000003 | TSPAN6 | caudate | glial cells | Not detected | Approved |

### Head of cancer tissue (columns 1-7)

| Gene | Gene.name | Cancer | High | Medium | Low | Not.detected |
| --- | --- | --- | --- | --- | --- | --- |
| ENSG00000000003 | TSPAN6 | breast cancer | 1 | 7 | 2 | 2 |
| ENSG00000000003 | TSPAN6 | carcinoid | 0 | 1 | 1 | 2 |
| ENSG00000000003 | TSPAN6 | cervical cancer | 11 | 1 | 0 | 0 |
| ENSG00000000003 | TSPAN6 | colorectal cancer | 0 | 6 | 2 | 2 |
| ENSG00000000003 | TSPAN6 | endometrial cancer | 10 | 2 | 0 | 0 |
| ENSG00000000003 | TSPAN6 | glioma | 0 | 0 | 0 | 11 |
| ENSG00000000003 | TSPAN6 | head and neck cancer | 0 | 3 | 1 | 0 |
| ENSG00000000003 | TSPAN6 | liver cancer | 4 | 5 | 1 | 0 |
| ENSG00000000003 | TSPAN6 | lung cancer | 8 | 4 | 0 | 0 |
| ENSG00000000003 | TSPAN6 | lymphoma | 0 | 0 | 0 | 11 |

# Using HPAStainR

## Using the HPAStainR function

Now that the data is available you can now us the HPAStainR function. This requires a list of proteins or genes you are interested in. In this example, we’re going to use pancreatic enzymes PRSS1, PNLIP, CELA3A, and the hormone PRL.

```
gene_list = c("PRSS1", "PNLIP","CELA3A", "PRL")

stainR_out <- HPAStainR::HPAStainR(gene_list = gene_list,
          hpa_dat = HPA_data$hpa_dat,
          cancer_dat = HPA_data$cancer_dat,
          cancer_analysis = "both",
          stringency = "normal")

head(stainR_out, 10)
#> # A tibble: 10 x 11
#>    cell_type percent_high_ex… percent_medium_… percent_low_exp… percent_not_det…
#>    <chr>                <dbl>            <dbl>            <dbl>            <dbl>
#>  1 PANCREAS…             0.75             0                0                0.25
#>  2 PITUITAR…             0.25             0                0                0
#>  3 DUODENUM…             0                0.25             0                0.75
#>  4 SMALL IN…             0                0.25             0                0.75
#>  5 COLON - …             0                0                0.25             0.75
#>  6 head and…             0                0.07             0                0.93
#>  7 pancreat…             0                0.02             0                0.98
#>  8 ADIPOSE …             0                0                0                1
#>  9 ADRENAL …             0                0                0                1
#> 10 APPENDIX…             0                0                0                1
#> # … with 6 more variables: number_of_proteins <dbl>, tested_proteins <chr>,
#> #   detected_proteins <chr>, staining_score <dbl>, p_val <chr>, p_val_adj <chr>
```

The output of HPAStainR is a tibble with multiple columns. The basic columns include the following:

* **cell\_type:** The cell types/cancers that are tested in the Human Protein Atlas.
* **percent/count\_high/medium/low\_expression**: Either the percent or count of genes from the list that stain either at high levels, medium levels or low levels.
* **percent/count\_not\_detected**: The number or percent of proteins that failed to stain the cell type.
* **number of proteins**: The number of proteins tested in a cell type.
* **tested\_proteins**: A character string of proteins that were tested in the cell type as not all proteins are tested in every cell type.
* **detected\_proteins**: A character string of proteins that were detected in each cell type.
* **enriched\_score**: An arbitrary ranking value further explained below.
* **p\_val**: A p-value denoting an enrichment of rarely staining proteins (stained in <29% of the cell types, see paper [cite] for further details).
* **p\_val\_adjust**: The previous p-value adjusted for multiple testing using “holm”

The **staining score** an arbitrary rank of staining weighted on how highly a protein stained. See the manual for the equation and further information.

# Using the HPAStainR Shiny app

Another way to use HPAStainR is as a [Shiny app](https://32tim32.shinyapps.io/HPAStainR/), and the function shiny\_HPAStainR allows you to run a local version of the app:

**Note:** If you want the tab from the online Shiny that gives you the stained : tested ratio of proteins, make sure to run the below code and insert the resulting object in the third argument (`cell_type_data`) of shiny\_HPAStainR

```
hpa_summary <- HPA_summary_maker(hpa_dat = HPA_data$hpa_dat)
```

## Run the Shiny app

```
shiny_HPAStainR(hpa_dat = HPA_data$hpa_dat,
                cancer_dat = HPA_data$cancer_dat,
                cell_type_data = hpa_summary)
```

### A window should open like that below

![Shiny Output](data:image/png;base64...) You should now be able to query whatever list of proteins you like and can easily rank them on whatever column you wish. Also all of the options from the functions are modifiable on the left hand side panel.

# Session Info

```
sessionInfo()
#> R version 4.0.3 (2020-10-10)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.5 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.12-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.12-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] HPAStainR_1.0.3 tidyr_1.1.2     dplyr_1.0.4
#>
#> loaded via a namespace (and not attached):
#>  [1] Rcpp_1.0.6        pillar_1.4.7      compiler_4.0.3    later_1.1.0.1
#>  [5] highr_0.8         tools_4.0.3       digest_0.6.27     evaluate_0.14
#>  [9] lifecycle_0.2.0   tibble_3.0.6      pkgconfig_2.0.3   rlang_0.4.10
#> [13] cli_2.3.0         shiny_1.6.0       DBI_1.1.1         yaml_2.2.1
#> [17] xfun_0.20         fastmap_1.1.0     stringr_1.4.0     knitr_1.31
#> [21] generics_0.1.0    vctrs_0.3.6       tidyselect_1.1.0  glue_1.4.2
#> [25] data.table_1.13.6 R6_2.5.0          fansi_0.4.2       rmarkdown_2.6
#> [29] purrr_0.3.4       magrittr_2.0.1    scales_1.1.1      promises_1.1.1
#> [33] ellipsis_0.3.1    htmltools_0.5.1.1 assertthat_0.2.1  mime_0.9
#> [37] xtable_1.8-4      colorspace_2.0-0  httpuv_1.5.5      utf8_1.1.4
#> [41] stringi_1.5.3     munsell_0.5.0     crayon_1.4.1
```

Any questions? Feel free to contact me at tnieuwe1[@]jhmi.edu