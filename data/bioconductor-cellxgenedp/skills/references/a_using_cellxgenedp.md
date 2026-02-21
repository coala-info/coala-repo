# Discovery and retrieval

Martin Morgan1\*

1Roswell Park Comprehensive Cancer Center

\*Martin.Morgan@RoswellPark.org

#### 29 October 2025

#### Abstract

The CELLxGENE data portal (<https://cellxgene.cziscience.com/>) provides a
graphical user interface to collections of single-cell sequence data
processed in standard ways to ‘count matrix’ summaries. The cellxgenedp
package provides an alternative, R-based inteface, allowing flexible data
discovery, viewing, and retrieval.

#### Package

cellxgenedp 1.14.0

# Contents

* [1 Installation and use](#installation-and-use)
* [2 `cxg()` Provides a ‘shiny’ interface](#cxg-provides-a-shiny-interface)
* [3 Collections, datasets and files](#collections-datasets-and-files)
  + [3.1 Using `dplyr` to navigate data](#using-dplyr-to-navigate-data)
  + [3.2 `facets()` provides information on ‘levels’ present in specific columns](#facets-provides-information-on-levels-present-in-specific-columns)
  + [3.3 Filtering faceted columns](#filtering-faceted-columns)
  + [3.4 Publication and other external data](#publication-and-other-external-data)
* [4 Visualizing data in `cellxgene`](#visualizing-data-in-cellxgene)
* [5 File download and use](#file-download-and-use)
* [6 Next steps](#next-steps)
* [7 API changes](#api-changes)
* [Session info](#session-info)

NOTE: The interface to CELLxGENE has changed; versions of
[cellxgenedp](https://mtmorgan.github.io/cellxgenedp) prior to 1.4.1 / 1.5.2 will cease to work when
CELLxGENE removes the previous interface. See the vignette section
‘API changes’ for additional details.

# 1 Installation and use

This package is available in *Bioconductor* version 3.15 and
later. The following code installs [cellxgenedp](https://bioconductor.org/packages/cellxgenedp)
from *Bioconductor*

```
if (!"BiocManager" %in% rownames(installed.packages()))
    install.packages("BiocManager", repos = "https://CRAN.R-project.org")
BiocManager::install("cellxgenedp")
```

Alternatively, install the ‘development’ version from GitHub (see
[GitHub.io](https://mtmorgan.github.io/cellxgenedp) for current documentation)

```
if (!"remotes" %in% rownames(installed.packages()))
    install.packages("remotes", repos = "https://CRAN.R-project.org")
remotes::install_github("mtmorgan/cellxgenedp")
```

To also install additional packages required for this vignette, use

```
pkgs <- c("tidyr", "zellkonverter", "SingleCellExperiment", "HDF5Array")
required_pkgs <- pkgs[!pkgs %in% rownames(installed.packages())]
BiocManager::install(required_pkgs)
```

Load the package into your current *R* session. We make extensive use
of the dplyr packages, and at the end of the vignette use
SingleCellExperiment and zellkonverter, so load those as well.

```
library(zellkonverter)
library(SingleCellExperiment) # load early to avoid masking dplyr::count()
library(dplyr)
library(cellxgenedp)
```

# 2 `cxg()` Provides a ‘shiny’ interface

The following sections outline how to use the [cellxgenedp](https://mtmorgan.github.io/cellxgenedp) package
in an *R* script; most functionality is also available in the `cxg()`
shiny application, providing an easy way to identify, download, and
visualize one or several datasets. Start the app

```
cxg()
```

choose a project on the first tab, and a dataset for visualization, or
one or more datasets for download!

# 3 Collections, datasets and files

Retrieve metadata about resources available at the cellxgene data
portal using `db()`:

```
db <- db()
```

```
## Collections ■                                  1% | ETA:  2m
```

```
## Collections ■■                                 4% | ETA:  1m
```

```
## Collections ■■■■                               9% | ETA:  1m
```

```
## Collections ■■■■■                             15% | ETA:  1m
```

```
## Collections ■■■■■■                            18% | ETA:  1m
```

```
## Collections ■■■■■■■■                          22% | ETA:  1m
```

```
## Collections ■■■■■■■■                          23% | ETA:  1m
```

```
## Collections ■■■■■■■■■                         27% | ETA:  1m
```

```
## Collections ■■■■■■■■■■■                       32% | ETA:  1m
```

```
## Collections ■■■■■■■■■■■                       33% | ETA:  1m
```

```
## Collections ■■■■■■■■■■■■                      38% | ETA: 49s
```

```
## Collections ■■■■■■■■■■■■■■                    42% | ETA: 45s
```

```
## Collections ■■■■■■■■■■■■■■                    45% | ETA: 45s
```

```
## Collections ■■■■■■■■■■■■■■■■                  50% | ETA: 39s
```

```
## Collections ■■■■■■■■■■■■■■■■■                 52% | ETA: 38s
```

```
## Collections ■■■■■■■■■■■■■■■■■■                57% | ETA: 34s
```

```
## Collections ■■■■■■■■■■■■■■■■■■■               61% | ETA: 31s
```

```
## Collections ■■■■■■■■■■■■■■■■■■■■              65% | ETA: 28s
```

```
## Collections ■■■■■■■■■■■■■■■■■■■■■■            71% | ETA: 22s
```

```
## Collections ■■■■■■■■■■■■■■■■■■■■■■■■          76% | ETA: 18s
```

```
## Collections ■■■■■■■■■■■■■■■■■■■■■■■■■         79% | ETA: 16s
```

```
## Collections ■■■■■■■■■■■■■■■■■■■■■■■■■■        84% | ETA: 12s
```

```
## Collections ■■■■■■■■■■■■■■■■■■■■■■■■■■■■      88% | ETA:  9s
```

```
## Collections ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■     93% | ETA:  5s
```

```
## Collections ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■    96% | ETA:  3s
```

```
## Collections ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■   99% | ETA:  1s
```

```
## Collections ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100% | ETA:  0s
```

Printing the `db` object provides a brief overview of the available
data, as well as hints, in the form of functions like `collections()`,
for further exploration.

```
db
```

```
## cellxgene_db
## number of collections(): 328
## number of datasets(): 1959
## number of files(): 1993
```

The portal organizes data hierarchically, with ‘collections’
(research studies, approximately), ‘datasets’, and ‘files’. Discover
data using the corresponding functions.

```
collections(db)
```

```
## # A tibble: 328 × 18
##    collection_id    collection_version_id collection_url consortia contact_email
##    <chr>            <chr>                 <chr>          <list>    <chr>
##  1 1f0f863f-b69d-4… 51d29a70-0292-4486-8… https://cellx… <lgl [1]> jbeane@bu.edu
##  2 db468083-041c-4… 1fa56b68-c9b7-43d6-9… https://cellx… <chr [1]> szhong@eng.u…
##  3 8f126edf-5405-4… 8048e6a4-ac23-4d45-9… https://cellx… <lgl [1]> julian.knigh…
##  4 4cbb929b-b03b-4… e7bf443a-ee39-47b6-b… https://cellx… <chr [2]> emereu@carre…
##  5 625f6bf4-2f33-4… 41222d84-f6cc-4705-b… https://cellx… <chr [1]> a5wang@healt…
##  6 ed9185e3-5b82-4… 89a03681-3d46-425c-8… https://cellx… <lgl [1]> john.tsang@n…
##  7 7651ac1a-f947-4… 46115989-5366-42bd-9… https://cellx… <chr [2]> shalev.itzko…
##  8 05e3d0fc-c9dd-4… d5dac132-d661-43bc-8… https://cellx… <chr [1]> ruic20@hs.uc…
##  9 558385a4-b7b7-4… 131fa50e-3ecd-4fb7-9… https://cellx… <lgl [1]> spyros.darma…
## 10 4195ab4c-20bd-4… 8902b118-2c3e-4b36-8… https://cellx… <chr [1]> nnavin@mdand…
## # ℹ 318 more rows
## # ℹ 13 more variables: contact_name <chr>, curator_name <chr>,
## #   description <chr>, doi <chr>, links <list>, name <chr>,
## #   publisher_metadata <list>, revising_in <lgl>, revision_of <lgl>,
## #   visibility <chr>, created_at <date>, published_at <date>, revised_at <date>
```

```
datasets(db)
```

```
## # A tibble: 1,959 × 33
##    dataset_id   dataset_version_id collection_id donor_id assay  batch_condition
##    <chr>        <chr>              <chr>         <list>   <list> <list>
##  1 61d327d1-22… 5d129809-6384-482… 1f0f863f-b69… <chr>    <list> <lgl [1]>
##  2 6cda3b13-72… 9349c6fb-758d-483… db468083-041… <chr>    <list> <lgl [1]>
##  3 42b6a476-c5… a4a32eaa-9828-417… db468083-041… <chr>    <list> <lgl [1]>
##  4 ebc2e1ff-c8… 687c09ff-731a-4e3… 8f126edf-540… <chr>    <list> <lgl [1]>
##  5 60a29d0b-1a… b6da1a8e-2d81-42e… 4cbb929b-b03… <chr>    <list> <lgl [1]>
##  6 09b518f9-da… a14c154d-b867-486… 4cbb929b-b03… <chr>    <list> <lgl [1]>
##  7 3de0ad6d-43… b1ba366b-d63b-4fd… 625f6bf4-2f3… <chr>    <list> <lgl [1]>
##  8 30cd5311-6c… 73024e1c-c5e4-48d… ed9185e3-5b8… <chr>    <list> <lgl [1]>
##  9 21d3e683-80… e6ef9f09-bf7f-49b… ed9185e3-5b8… <chr>    <list> <lgl [1]>
## 10 3f32121d-12… cece25a7-9d37-475… 7651ac1a-f94… <chr>    <list> <lgl [1]>
## # ℹ 1,949 more rows
## # ℹ 27 more variables: cell_count <int>, cell_type <list>, citation <chr>,
## #   default_embedding <chr>, development_stage <list>, disease <list>,
## #   embeddings <list>, explorer_url <chr>, feature_biotype <list>,
## #   feature_count <int>, feature_reference <list>, is_primary_data <list>,
## #   mean_genes_per_cell <dbl>, organism <list>, primary_cell_count <int>,
## #   raw_data_location <chr>, schema_version <chr>, …
```

```
files(db)
```

```
## # A tibble: 1,993 × 4
##    dataset_id                             filesize filetype      url
##    <chr>                                     <dbl> <chr>         <chr>
##  1 61d327d1-2227-4c5f-9367-e3559dc79b07   24344739 H5AD          https://datase…
##  2 6cda3b13-7257-45b9-ac20-0a7e6697e4f2  421889692 H5AD          https://datase…
##  3 42b6a476-c51d-4f8b-b68b-44941b3a11bf  122028257 H5AD          https://datase…
##  4 ebc2e1ff-c8f9-466a-acf4-9d291afaf8b3 5596065012 H5AD          https://datase…
##  5 60a29d0b-1a37-4447-ac32-00d701580b47 1405501762 H5AD          https://datase…
##  6 09b518f9-da64-44cc-aec8-70a89d55611f 4225165231 ATAC_FRAGMENT https://datase…
##  7 09b518f9-da64-44cc-aec8-70a89d55611f    1521345 ATAC_INDEX    https://datase…
##  8 09b518f9-da64-44cc-aec8-70a89d55611f  303800490 H5AD          https://datase…
##  9 3de0ad6d-4378-4f62-b37b-ec0b75a50d94  340446069 H5AD          https://datase…
## 10 30cd5311-6c09-46c9-94f1-71fe4b91813c  971632728 H5AD          https://datase…
## # ℹ 1,983 more rows
```

Each of these resources has a unique primary identifier (e.g.,
`file_id`) as well as an identifier describing the relationship of the
resource to other components of the database (e.g.,
`dataset_id`). These identifiers can be used to ‘join’ information
across tables.

## 3.1 Using `dplyr` to navigate data

A collection may have several datasets, and datasets may have several
files. For instance, here is the collection with the most datasets

```
collection_with_most_datasets <-
    datasets(db) |>
    count(collection_id, sort = TRUE) |>
    slice(1)
```

We can find out about this collection by joining with the
`collections()` table.

```
left_join(
    collection_with_most_datasets |> select(collection_id),
    collections(db),
    by = "collection_id"
) |> glimpse()
```

```
## Rows: 1
## Columns: 18
## $ collection_id         <chr> "283d65eb-dd53-496d-adb7-7570c7caa443"
## $ collection_version_id <chr> "cd2b2f20-8bad-4fe9-9146-9d54e6ce89fe"
## $ collection_url        <chr> "https://cellxgene.cziscience.com/collections/28…
## $ consortia             <list> <"BRAIN Initiative", "CZI Cell Science">
## $ contact_email         <chr> "kimberly.siletti@ki.se"
## $ contact_name          <chr> "Kimberly Siletti"
## $ curator_name          <chr> "James Chaffer"
## $ description           <chr> "First draft atlas of human brain transcriptomic…
## $ doi                   <chr> "10.1126/science.add7046"
## $ links                 <list> [["", "RAW_DATA", "http://data.nemoarchive.org/b…
## $ name                  <chr> "Human Brain Cell Atlas v1.0"
## $ publisher_metadata    <list> [[["Siletti", "Kimberly"], ["Hodge", "Rebecca"]…
## $ revising_in           <lgl> NA
## $ revision_of           <lgl> NA
## $ visibility            <chr> "PUBLIC"
## $ created_at            <date> 2025-10-20
## $ published_at          <date> 2022-12-09
## $ revised_at            <date> 2025-10-24
```

We can take a similar strategy to identify all datasets belonging to
this collection

```
left_join(
    collection_with_most_datasets |> select(collection_id),
    datasets(db),
    by = "collection_id"
)
```

```
## # A tibble: 138 × 33
##    collection_id   dataset_id dataset_version_id donor_id assay  batch_condition
##    <chr>           <chr>      <chr>              <list>   <list> <list>
##  1 283d65eb-dd53-… ff7d15fa-… f0e3a9cf-d40d-488… <chr>    <list> <chr [1]>
##  2 283d65eb-dd53-… fe1a73ab-… 17060c76-b604-4b1… <chr>    <list> <chr [1]>
##  3 283d65eb-dd53-… fbf173f9-… 6c815b29-1fb1-490… <chr>    <list> <chr [1]>
##  4 283d65eb-dd53-… fa554686-… f7cd078d-ebdc-450… <chr>    <list> <chr [1]>
##  5 283d65eb-dd53-… f9034091-… afa4c852-330a-44e… <chr>    <list> <chr [1]>
##  6 283d65eb-dd53-… f8dda921-… bbc44062-fbd5-4e5… <chr>    <list> <chr [1]>
##  7 283d65eb-dd53-… f7d003d4-… be0d32e2-a47e-470… <chr>    <list> <chr [1]>
##  8 283d65eb-dd53-… f6d9f2ad-… 7f6c1d7a-0c80-4f9… <chr>    <list> <chr [1]>
##  9 283d65eb-dd53-… f5a04dff-… dadf0e5c-7c2b-4bc… <chr>    <list> <chr [1]>
## 10 283d65eb-dd53-… f502c312-… e5345f1e-3da6-491… <chr>    <list> <chr [1]>
## # ℹ 128 more rows
## # ℹ 27 more variables: cell_count <int>, cell_type <list>, citation <chr>,
## #   default_embedding <chr>, development_stage <list>, disease <list>,
## #   embeddings <list>, explorer_url <chr>, feature_biotype <list>,
## #   feature_count <int>, feature_reference <list>, is_primary_data <list>,
## #   mean_genes_per_cell <dbl>, organism <list>, primary_cell_count <int>,
## #   raw_data_location <chr>, schema_version <chr>, …
```

## 3.2 `facets()` provides information on ‘levels’ present in specific columns

Notice that some columns are ‘lists’ rather than atomic vectors like
‘character’ or ‘integer’.

```
datasets(db) |>
    select(where(is.list))
```

```
## # A tibble: 1,959 × 16
##    donor_id    assay      batch_condition cell_type   development_stage disease
##    <list>      <list>     <list>          <list>      <list>            <list>
##  1 <chr [12]>  <list [1]> <lgl [1]>       <list [9]>  <list [11]>       <list>
##  2 <chr [1]>   <list [1]> <lgl [1]>       <list [1]>  <list [1]>        <list>
##  3 <chr [4]>   <list [1]> <lgl [1]>       <list [2]>  <list [4]>        <list>
##  4 <chr [124]> <list [1]> <lgl [1]>       <list [17]> <list [8]>        <list>
##  5 <chr [18]>  <list [3]> <lgl [1]>       <list [35]> <list [15]>       <list>
##  6 <chr [10]>  <list [1]> <lgl [1]>       <list [33]> <list [9]>        <list>
##  7 <chr [9]>   <list [1]> <lgl [1]>       <list [28]> <list [3]>        <list>
##  8 <chr [46]>  <list [1]> <lgl [1]>       <list [10]> <list [32]>       <list>
##  9 <chr [46]>  <list [1]> <lgl [1]>       <list [14]> <list [32]>       <list>
## 10 <chr [6]>   <list [2]> <lgl [1]>       <list [10]> <list [3]>        <list>
## # ℹ 1,949 more rows
## # ℹ 10 more variables: embeddings <list>, feature_biotype <list>,
## #   feature_reference <list>, is_primary_data <list>, organism <list>,
## #   self_reported_ethnicity <list>, sex <list>, spatial <list>,
## #   suspension_type <list>, tissue <list>
```

This indicates that at least some of the datasets had more than one
type of `assay`, `cell_type`, etc. The `facets()` function provides a
convenient way of discovering possible levels of each column, e.g.,
`assay`, `organism`, `self_reported_ethnicity`, or `sex`, and the
number of datasets with each label.

```
facets(db, "assay")
```

```
## # A tibble: 47 × 4
##    facet label                             ontology_term_id     n
##    <chr> <chr>                             <chr>            <int>
##  1 assay 10x 3' v3                         EFO:0009922        970
##  2 assay 10x 3' v2                         EFO:0009899        424
##  3 assay Visium Spatial Gene Expression V1 EFO:0022857        317
##  4 assay Slide-seqV2                       EFO:0030062        240
##  5 assay 10x 5' v1                         EFO:0011025        140
##  6 assay 10x 5' v2                         EFO:0009900         99
##  7 assay 10x multiome                      EFO:0030059         87
##  8 assay sci-RNA-seq3                      EFO:0030028         81
##  9 assay Smart-seq2                        EFO:0008931         78
## 10 assay 10x 5' transcription profiling    EFO:0030004         37
## # ℹ 37 more rows
```

```
facets(db, "self_reported_ethnicity")
```

```
## # A tibble: 39 × 4
##    facet                   label                          ontology_term_id     n
##    <chr>                   <chr>                          <chr>            <int>
##  1 self_reported_ethnicity unknown                        unknown           1342
##  2 self_reported_ethnicity na                             na                 473
##  3 self_reported_ethnicity Asian                          HANCESTRO:0847     279
##  4 self_reported_ethnicity African American               HANCESTRO:0568     187
##  5 self_reported_ethnicity European American              HANCESTRO:0590     172
##  6 self_reported_ethnicity Hispanic or Latin              HANCESTRO:0612     158
##  7 self_reported_ethnicity British                        HANCESTRO:0462      60
##  8 self_reported_ethnicity Hispanic or Latin || Native A… HANCESTRO:0612 …    50
##  9 self_reported_ethnicity South Asian                    HANCESTRO:0848      39
## 10 self_reported_ethnicity Middle Eastern                 HANCESTRO:0852      29
## # ℹ 29 more rows
```

```
facets(db, "sex")
```

```
## # A tibble: 4 × 4
##   facet label   ontology_term_id     n
##   <chr> <chr>   <chr>            <int>
## 1 sex   male    PATO:0000384      1396
## 2 sex   female  PATO:0000383      1205
## 3 sex   unknown unknown            354
## 4 sex   na      na                   5
```

## 3.3 Filtering faceted columns

Suppose we were interested in finding datasets from the 10x 3’ v3
assay (`ontology_term_id` of `EFO:0009922`) containing individuals of
African American ethnicity, and female sex. Use the `facets_filter()`
utility function to filter data sets as needed

```
african_american_female <-
    datasets(db) |>
    filter(
        facets_filter(assay, "ontology_term_id", "EFO:0009922"),
        facets_filter(self_reported_ethnicity, "label", "African American"),
        facets_filter(sex, "label", "female")
    )
```

Use `nrow(african_american_female)` to find the number of datasets
satisfying our criteria. It looks like there are up to

```
african_american_female |>
    summarise(total_cell_count = sum(cell_count))
```

```
## # A tibble: 1 × 1
##   total_cell_count
##              <int>
## 1         39211886
```

cells sequenced (each dataset may contain cells from several
ethnicities, as well as males or individuals of unknown gender, so we
do not know the actual number of cells available without downloading
files). Use `left_join` to identify the corresponding collections:

```
## collections
left_join(
    african_american_female |> select(collection_id) |> distinct(),
    collections(db),
    by = "collection_id"
)
```

```
## # A tibble: 46 × 18
##    collection_id    collection_version_id collection_url consortia contact_email
##    <chr>            <chr>                 <chr>          <list>    <chr>
##  1 4cbb929b-b03b-4… e7bf443a-ee39-47b6-b… https://cellx… <chr [2]> emereu@carre…
##  2 625f6bf4-2f33-4… 41222d84-f6cc-4705-b… https://cellx… <chr [1]> a5wang@healt…
##  3 05e3d0fc-c9dd-4… d5dac132-d661-43bc-8… https://cellx… <chr [1]> ruic20@hs.uc…
##  4 4195ab4c-20bd-4… 8902b118-2c3e-4b36-8… https://cellx… <chr [1]> nnavin@mdand…
##  5 a98b828a-622a-4… dfde5ac8-f043-46fe-b… https://cellx… <chr [1]> markusbi@med…
##  6 cee845e3-ec04-4… cef9f335-2adb-4165-8… https://cellx… <chr [1]> yuw1@chop.edu
##  7 b953c942-f5d8-4… bfe48a3b-68bd-4b85-b… https://cellx… <lgl [1]> icobos@stanf…
##  8 58e85c2f-d52e-4… 610a8250-6e53-42f5-b… https://cellx… <lgl [1]> efthymios.mo…
##  9 4f30b962-d49b-4… 26bc3871-ff3b-4ec9-b… https://cellx… <chr [1]> res2003@med.…
## 10 77f9d7e9-5675-4… 4a28bfb8-c6e5-42fe-b… https://cellx… <lgl [1]> claire.gusta…
## # ℹ 36 more rows
## # ℹ 13 more variables: contact_name <chr>, curator_name <chr>,
## #   description <chr>, doi <chr>, links <list>, name <chr>,
## #   publisher_metadata <list>, revising_in <lgl>, revision_of <lgl>,
## #   visibility <chr>, created_at <date>, published_at <date>, revised_at <date>
```

## 3.4 Publication and other external data

Many collections include publication information and other external
data. This information is available in the return value of
`collections()`, but the helper function `publisher_metadata()`,
`authors()`, and `links()` may facilitate access.

Suppose one is interested in the publication “A single-cell atlas of
the healthy breast tissues reveals clinically relevant clusters of
breast epithelial cells”. Discover it in the collections

```
title_of_interest <- paste(
    "A single-cell atlas of the healthy breast tissues reveals clinically",
    "relevant clusters of breast epithelial cells"
)
collection_of_interest <-
    collections(db) |>
    dplyr::filter(startsWith(name, title_of_interest))
collection_of_interest |>
    glimpse()
```

```
## Rows: 1
## Columns: 18
## $ collection_id         <chr> "c9706a92-0e5f-46c1-96d8-20e42467f287"
## $ collection_version_id <chr> "6fbed02d-b2b9-4e6d-8417-93f9396b265b"
## $ collection_url        <chr> "https://cellxgene.cziscience.com/collections/c9…
## $ consortia             <list> "CZI Cell Science"
## $ contact_email         <chr> "hnakshat@iupui.edu"
## $ contact_name          <chr> "Harikrishna Nakshatri"
## $ curator_name          <chr> "Jennifer Yu-Sheng Chien"
## $ description           <chr> "Single-cell RNA sequencing (scRNA-seq) is an ev…
## $ doi                   <chr> "10.1016/j.xcrm.2021.100219"
## $ links                 <list> [["", "RAW_DATA", "https://explore.data.humancel…
## $ name                  <chr> "A single-cell atlas of the healthy breast tiss…
## $ publisher_metadata    <list> [[["Bhat-Nakshatri", "Poornima"], ["Gao", "Hongy…
## $ revising_in           <lgl> NA
## $ revision_of           <lgl> NA
## $ visibility            <chr> "PUBLIC"
## $ created_at            <date> 2025-10-21
## $ published_at          <date> 2021-03-25
## $ revised_at            <date> 2025-10-24
```

Use the `collection_id` to extract publisher metadata (including a DOI
if available) and author information

```
collection_id_of_interest <- pull(collection_of_interest, "collection_id")
publisher_metadata(db) |>
    filter(collection_id == collection_id_of_interest) |>
    glimpse()
```

```
## Rows: 1
## Columns: 9
## $ collection_id   <chr> "c9706a92-0e5f-46c1-96d8-20e42467f287"
## $ name            <chr> "A single-cell atlas of the healthy breast tissues rev…
## $ is_preprint     <lgl> FALSE
## $ journal         <chr> "Cell Reports Medicine"
## $ published_at    <date> 2021-03-01
## $ published_year  <int> 2021
## $ published_month <int> 3
## $ published_day   <int> 1
## $ doi             <chr> NA
```

```
authors(db) |>
    filter(collection_id == collection_id_of_interest)
```

```
## # A tibble: 12 × 4
##    collection_id                        family         given       consortium
##    <chr>                                <chr>          <chr>       <chr>
##  1 c9706a92-0e5f-46c1-96d8-20e42467f287 Bhat-Nakshatri Poornima    <NA>
##  2 c9706a92-0e5f-46c1-96d8-20e42467f287 Gao            Hongyu      <NA>
##  3 c9706a92-0e5f-46c1-96d8-20e42467f287 Sheng          Liu         <NA>
##  4 c9706a92-0e5f-46c1-96d8-20e42467f287 McGuire        Patrick C.  <NA>
##  5 c9706a92-0e5f-46c1-96d8-20e42467f287 Xuei           Xiaoling    <NA>
##  6 c9706a92-0e5f-46c1-96d8-20e42467f287 Wan            Jun         <NA>
##  7 c9706a92-0e5f-46c1-96d8-20e42467f287 Liu            Yunlong     <NA>
##  8 c9706a92-0e5f-46c1-96d8-20e42467f287 Althouse       Sandra K.   <NA>
##  9 c9706a92-0e5f-46c1-96d8-20e42467f287 Colter         Austyn      <NA>
## 10 c9706a92-0e5f-46c1-96d8-20e42467f287 Sandusky       George      <NA>
## 11 c9706a92-0e5f-46c1-96d8-20e42467f287 Storniolo      Anna Maria  <NA>
## 12 c9706a92-0e5f-46c1-96d8-20e42467f287 Nakshatri      Harikrishna <NA>
```

Collections may have links to additional external data, in this case a
DOI and two links to `RAW_DATA`.

```
external_links <- links(db)
external_links
```

```
## # A tibble: 1,086 × 4
##    collection_id                        link_name       link_type link_url
##    <chr>                                <chr>           <chr>     <chr>
##  1 1f0f863f-b69d-4ba3-8bab-d2727dd0aecf GSE131391       RAW_DATA  https://www.n…
##  2 db468083-041c-41ca-8f6f-bf991a070adf GSE135357       RAW_DATA  https://www.n…
##  3 db468083-041c-41ca-8f6f-bf991a070adf <NA>            RAW_DATA  https://explo…
##  4 db468083-041c-41ca-8f6f-bf991a070adf <NA>            OTHER     https://githu…
##  5 8f126edf-5405-4731-8374-b5ce11f53e82 <NA>            OTHER     http://cells.…
##  6 8f126edf-5405-4731-8374-b5ce11f53e82 zenodo.org      OTHER     https://doi.o…
##  7 8f126edf-5405-4731-8374-b5ce11f53e82 <NA>            RAW_DATA  https://ega-a…
##  8 8f126edf-5405-4731-8374-b5ce11f53e82 Consortium Site OTHER     https://www.c…
##  9 8f126edf-5405-4731-8374-b5ce11f53e82 <NA>            OTHER     https://explo…
## 10 625f6bf4-2f33-4942-962e-35243d284837 GSE161382       OTHER     https://www.n…
## # ℹ 1,076 more rows
```

```
external_links |>
    count(link_type)
```

```
## # A tibble: 5 × 2
##   link_type       n
##   <chr>       <int>
## 1 DATA_SOURCE    78
## 2 LAB_WEBSITE    58
## 3 OTHER         471
## 4 PROTOCOL       58
## 5 RAW_DATA      421
```

```
external_links |>
    filter(collection_id == collection_id_of_interest)
```

```
## # A tibble: 2 × 4
##   collection_id                        link_name link_type link_url
##   <chr>                                <chr>     <chr>     <chr>
## 1 c9706a92-0e5f-46c1-96d8-20e42467f287 <NA>      RAW_DATA  https://explore.data…
## 2 c9706a92-0e5f-46c1-96d8-20e42467f287 <NA>      RAW_DATA  https://www.ncbi.nlm…
```

Conversely, knowledge of a DOI, etc., can be used to discover details
of the corresponding collection.

```
doi_of_interest <- "https://doi.org/10.1016/j.stem.2018.12.011"
links(db) |>
    filter(link_url == doi_of_interest) |>
    left_join(collections(db), by = "collection_id") |>
    glimpse()
```

```
## Rows: 1
## Columns: 21
## $ collection_id         <chr> "b1a879f6-5638-48d3-8f64-f6592c1b1561"
## $ link_name             <chr> "PSC-ATO protocol"
## $ link_type             <chr> "PROTOCOL"
## $ link_url              <chr> "https://doi.org/10.1016/j.stem.2018.12.011"
## $ collection_version_id <chr> "915b5425-ac92-470a-a975-d5e00d11ff7f"
## $ collection_url        <chr> "https://cellxgene.cziscience.com/collections/b1…
## $ consortia             <list> <"CZI Cell Science", "Wellcome HCA Strategic Sci…
## $ contact_email         <chr> "st9@sanger.ac.uk"
## $ contact_name          <chr> "Sarah Teichmann"
## $ curator_name          <chr> "Jennifer Yu-Sheng Chien"
## $ description           <chr> "Single-cell genomics studies have decoded the i…
## $ doi                   <chr> "10.1126/science.abo0510"
## $ links                 <list> [["scVI Models", "DATA_SOURCE", "https://develop…
## $ name                  <chr> "Mapping the developing human immune system acro…
## $ publisher_metadata    <list> [[["Suo", "Chenqu"], ["Dann", "Emma"], ["Goh", "…
## $ revising_in           <lgl> NA
## $ revision_of           <lgl> NA
## $ visibility            <chr> "PUBLIC"
## $ created_at            <date> 2025-10-20
## $ published_at          <date> 2022-10-04
## $ revised_at            <date> 2025-10-24
```

# 4 Visualizing data in `cellxgene`

Visualization is straight-forward once `dataset_id` is available. For
example, to visualize the first dataset in `african_american_female`,
use

```
african_american_female |>
    ## use criteria to identify a single dataset (here just the
    ## 'first' dataset), then visualize
    slice(1) |>
    datasets_visualize()
```

Visualization is an interactive process, so `datasets_visualize()`
will only open up to 5 browser tabs per call.

# 5 File download and use

Datasets usually contain `H5AD` (files produced by the python AnnData
module), and `Rds` (serialized files produced by the *R* Seurat
package). The `Rds` files may be unreadable if the version of Seurat
used to create the file is different from the version used to read the
file. We therefore focus on the `H5AD` files.

For illustration, we find all files associated with studies with
African American females

download one of our selected files.

```
selected_files <-
    left_join(
        african_american_female |> select(dataset_id),
        files(db),
        by = "dataset_id"
    )
```

And then choose a single dataset and its H5AD file for download

```
local_file <-
    selected_files |>
    filter(
        dataset_id == "de985818-285f-4f59-9dbd-d74968fddba3",
        filetype == "H5AD"
    ) |>
    files_download(dry.run = FALSE)
basename(local_file)
```

```
## [1] "c41c8e10-b10a-428c-b6e7-a770ef988bab.h5ad"
```

These are downloaded to a local cache (use the internal function
`cellxgenedp:::.cellxgenedb_cache_path()` for the location of the
cache), so the process is only time-consuming the first time.

`H5AD` files can be converted to *R* / *Bioconductor* objects using
the [zellkonverter](https://bioconductor.org/packages/zelkonverter) package.

```
h5ad <- readH5AD(local_file, use_hdf5 = TRUE, reader = "R")
```

```
## For native R and reading and writing of H5AD files, an R <AnnData> object, and
## conversion to <SingleCellExperiment> or <Seurat> objects, check out the
## anndataR package:
## ℹ Install it from Bioconductor with `BiocManager::install("anndataR")`
## ℹ See more at <https://bioconductor.org/packages/anndataR/>
## This message is displayed once per session.
```

```
h5ad
```

```
## class: SingleCellExperiment
## dim: 32397 31696
## metadata(7): citation default_embedding ... schema_version title
## assays(1): X
## rownames(32397): ENSG00000243485 ENSG00000237613 ... ENSG00000277475
##   ENSG00000268674
## rowData names(6): feature_is_filtered feature_name ... feature_length
##   feature_type
## colnames(31696): CMGpool_AAACCCAAGGACAACC CMGpool_AAACCCACAATCTCTT ...
##   K109064_TTTGTTGGTTGCATCA K109064_TTTGTTGGTTGGACCC
## colData names(43): mapped_reference_annotation donor_id ...
##   development_stage observation_joinid
## reducedDimNames(3): X_pca X_tsne X_umap
## mainExpName: NULL
## altExpNames(0):
```

The `SingleCellExperiment` object is a matrix-like object with rows
corresponding to genes and columns to cells. Thus we can easily
explore the cells present in the data.

```
h5ad |>
    colData(h5ad) |>
    as_tibble() |>
    count(sex, donor_id)
```

```
## # A tibble: 7 × 3
##   sex    donor_id                     n
##   <fct>  <fct>                    <int>
## 1 female D1                        2303
## 2 female D2                         864
## 3 female D3                        2517
## 4 female D4                        1771
## 5 female D5                        2244
## 6 female D11                       7454
## 7 female pooled [D9,D7,D8,D10,D6] 14543
```

# 6 Next steps

The [Orchestrating Single-Cell Analysis with Bioconductor](https://bioconductor.org/books/OSCA)
online resource provides an excellent introduction to analysis and
visualization of single-cell data in *R* / *Bioconductor*. Extensive
opportunities for working with AnnData objects in *R* but using the
native python interface are briefly described in, e.g., `?AnnData2SCE`
help page of [zellkonverter](https://bioconductor.org/packages/zelkonverter).

The [hca](https://bioconductor.org/packages/hca) package provides programmatic access to the Human Cell
Atlas [data portal](https://data.humancellatlas.org/explore), allowing retrieval of primary as well
as derived single-cell data files.

# 7 API changes

Data access provided by CELLxGENE has changed to a new ‘Discover’
[API](https://api.cellxgene.cziscience.com/curation/ui/). The main functionality of the [cellxgenedp](https://mtmorgan.github.io/cellxgenedp) package has not
changed, but specific columns have been removed, replaced or added, as
follows:

`collections()`

* Removed: `access_type`, `data_submission_policy_version`
* Replaced: `updated_at` replaced with `revised_at`
* Added: `collection_version_id`, `collection_url`, `doi`,
  `revising_in`, `revision_of`

`datasets()`

* Removed: `is_valid`, `processing_status`, `published`, `revision`,
  `created_at`
* Replaced: `dataset_deployments` replaced with `explorer_url`, `name`
  replaced with `title`, `updated_at` replaced with `revised_at`
* Added: `dataset_version_id`, `batch_condition`,
  `x_approximate_distribution`

`files()`

* Removed: `file_id`, `filename`, `s3_uri`, `user_submitted`,
  `created_at`, `updated_at`
* Added: `filesize`, `url`

# Session info

```
## R version 4.5.1 Patched (2025-08-23 r88802)
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] cellxgenedp_1.14.0          dplyr_1.1.4
##  [3] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           zellkonverter_1.20.0
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] dir.expiry_1.18.0   xfun_0.53           bslib_0.9.0
##  [4] htmlwidgets_1.6.4   rhdf5_2.54.0        lattice_0.22-7
##  [7] rhdf5filters_1.22.0 vctrs_0.6.5         rjsoncons_1.3.2
## [10] tools_4.5.1         curl_7.0.0          parallel_4.5.1
## [13] tibble_3.3.0        pkgconfig_2.0.3     Matrix_1.7-4
## [16] lifecycle_1.0.4     compiler_4.5.1      httpuv_1.6.16
## [19] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
## [22] pillar_1.11.1       later_1.4.4         jquerylib_0.1.4
## [25] DT_0.34.0           DelayedArray_0.36.0 cachem_1.1.0
## [28] abind_1.4-8         mime_0.13           basilisk_1.22.0
## [31] tidyselect_1.2.1    digest_0.6.37       bookdown_0.45
## [34] fastmap_1.2.0       grid_4.5.1          cli_3.6.5
## [37] SparseArray_1.10.0  magrittr_2.0.4      S4Arrays_1.10.0
## [40] h5mread_1.2.0       utf8_1.2.6          withr_3.0.2
## [43] filelock_1.0.3      promises_1.4.0      rmarkdown_2.30
## [46] XVector_0.50.0      httr_1.4.7          otel_0.2.0
## [49] reticulate_1.44.0   png_0.1-8           HDF5Array_1.38.0
## [52] shiny_1.11.1        evaluate_1.0.5      knitr_1.50
## [55] rlang_1.1.6         Rcpp_1.1.0          xtable_1.8-4
## [58] glue_1.8.0          BiocManager_1.30.26 jsonlite_2.0.0
## [61] Rhdf5lib_1.32.0     R6_2.6.1
```