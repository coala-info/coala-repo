# Case studies

Martin Morgan1\*

1Roswell Park Comprehensive Cancer Center

\*Martin.Morgan@RoswellPark.org

#### 29 October 2025

#### Abstract

This article summarizes short case studies and solutions arising
from user queries.

#### Package

cellxgenedp 1.14.0

# Contents

* [1 Setup](#setup)
* [2 Case study: authors & datasets](#case-study-authors-datasets)
  + [2.1 Challenge and solution](#challenge-and-solution)
  + [2.2 Areas of interest](#areas-of-interest)
  + [2.3 Collaboration](#collaboration)
  + [2.4 Duplicate collection-author combinations](#duplicate-collection-author-combinations)
    - [2.4.1 What is an ‘author’?](#what-is-an-author)
* [3 Case study: using ontology to identify datasets](#case-study-using-ontology-to-identify-datasets)
* [Session information](#session-information)

# 1 Setup

For each case study, ensure that cellxgenedp (see the
[Bioconductor](https://bioconductor.org/packages/cellxgenedp) package landing page, or
[GitHub.io](https://mtmorgan.github.io/cellxgenedp) site) is installed (additional installation
options are at <https://mtmorgan.github.io/cellxgenedp/>).

```
if (!"BiocManager" %in% rownames(installed.packages()))
    install.packages("BiocManager", repos = "https://CRAN.R-project.org")
BiocManager::install("cellxgenedp")
```

Load the package.

```
library(cellxgenedp)
```

# 2 Case study: authors & datasets

## 2.1 Challenge and solution

This case study arose from a question on the CZI Science Community
Slack. A user asked

> Hi! Is it possible to search CELLxGENE and identify all datasets by
> a specific author or set of authors?

Unfortunately, this is not possible from the [CELLxGENE](https://cellxgene.cziscience.com/) web site –
authors are only associated with collections, and collections can only
be sorted or filtered by title (or publication / tissue / disease /
organism).

A [cellxgenedp](https://mtmorgan.github.io/cellxgenedp) solution uses `authors()` to discover authors and
their collections, and joins this information to `datasets()`.

```
author_datasets <- left_join(
    authors(),
    datasets(),
    by = "collection_id",
    relationship = "many-to-many"
)
author_datasets
#> # A tibble: 63,858 × 36
#>    collection_id  family given consortium dataset_id dataset_version_id donor_id
#>    <chr>          <chr>  <chr> <chr>      <chr>      <chr>              <list>
#>  1 1f0f863f-b69d… Duclos Gran… <NA>       61d327d1-… 5d129809-6384-482… <chr>
#>  2 1f0f863f-b69d… Teixe… Vito… <NA>       61d327d1-… 5d129809-6384-482… <chr>
#>  3 1f0f863f-b69d… Autis… Patr… <NA>       61d327d1-… 5d129809-6384-482… <chr>
#>  4 1f0f863f-b69d… Gesth… Yaro… <NA>       61d327d1-… 5d129809-6384-482… <chr>
#>  5 1f0f863f-b69d… Reind… Marj… <NA>       61d327d1-… 5d129809-6384-482… <chr>
#>  6 1f0f863f-b69d… Terra… Robe… <NA>       61d327d1-… 5d129809-6384-482… <chr>
#>  7 1f0f863f-b69d… Dumas  Yves… <NA>       61d327d1-… 5d129809-6384-482… <chr>
#>  8 1f0f863f-b69d… Liu    Gang  <NA>       61d327d1-… 5d129809-6384-482… <chr>
#>  9 1f0f863f-b69d… Mazzi… Sara… <NA>       61d327d1-… 5d129809-6384-482… <chr>
#> 10 1f0f863f-b69d… Brand… Corr… <NA>       61d327d1-… 5d129809-6384-482… <chr>
#> # ℹ 63,848 more rows
#> # ℹ 29 more variables: assay <list>, batch_condition <list>, cell_count <int>,
#> #   cell_type <list>, citation <chr>, default_embedding <chr>,
#> #   development_stage <list>, disease <list>, embeddings <list>,
#> #   explorer_url <chr>, feature_biotype <list>, feature_count <int>,
#> #   feature_reference <list>, is_primary_data <list>,
#> #   mean_genes_per_cell <dbl>, organism <list>, primary_cell_count <int>, …
```

`author_datasets` provides a convenient point from which to make basic
queries, e.g., finding the authors contributing the most datasets.

```
author_datasets |>
    count(family, given, sort = TRUE)
#> # A tibble: 5,948 × 3
#>    family      given        n
#>    <chr>       <chr>    <int>
#>  1 Teichmann   Sarah A.   359
#>  2 Casper      Tamara     261
#>  3 Dee         Nick       261
#>  4 Chen        Fei        258
#>  5 Murray      Evan       258
#>  6 Keene       C. Dirk    252
#>  7 Hirschstein Daniel     241
#>  8 Macosko     Evan Z.    237
#>  9 Ding        Song-Lin   230
#> 10 Lein        Ed S.      226
#> # ℹ 5,938 more rows
```

Perhaps one is interested in the most prolific authors based on
‘collections’, rather than ‘datasets’. The five most prolific authors
by collection are

```
prolific_authors <-
    authors() |>
    count(family, given, sort = TRUE) |>
    slice(1:5)
prolific_authors
#> # A tibble: 5 × 3
#>   family    given          n
#>   <chr>     <chr>      <int>
#> 1 Teichmann Sarah A.      36
#> 2 Meyer     Kerstin B.    18
#> 3 Polanski  Krzysztof     17
#> 4 Regev     Aviv          16
#> 5 <NA>      <NA>          16
```

The datasets associated with authors are

```
right_join(
    author_datasets,
    prolific_authors,
    by = c("family", "given")
)
#> # A tibble: 928 × 37
#>    collection_id  family given consortium dataset_id dataset_version_id donor_id
#>    <chr>          <chr>  <chr> <chr>      <chr>      <chr>              <list>
#>  1 625f6bf4-2f33… <NA>   <NA>  NHLBI Lun… 3de0ad6d-… b1ba366b-d63b-4fd… <chr>
#>  2 6f6d381a-7701… Meyer  Kers… <NA>       9f222629-… dbb5ad81-1713-4ae… <chr>
#>  3 6f6d381a-7701… Meyer  Kers… <NA>       066943a2-… 4cb45d80-499a-48a… <chr>
#>  4 6f6d381a-7701… <NA>   <NA>  Lung Biol… 9f222629-… dbb5ad81-1713-4ae… <chr>
#>  5 6f6d381a-7701… <NA>   <NA>  Lung Biol… 066943a2-… 4cb45d80-499a-48a… <chr>
#>  6 a48f5033-3438… Regev  Aviv  <NA>       e40c6272-… da9edb77-7e04-45f… <chr>
#>  7 a48f5033-3438… Regev  Aviv  <NA>       d6dfdef1-… d1c4e99e-28ed-45b… <chr>
#>  8 a48f5033-3438… Regev  Aviv  <NA>       6a270451-… 9c123ef4-570c-49c… <chr>
#>  9 7d7cabfd-1d1f… <NA>   <NA>  on behalf… 01ad3cd7-… 2c2b8974-1fb9-4f6… <chr>
#> 10 854c0855-23ad… Meyer  Kers… <NA>       f95d8919-… 26d15fe5-5e25-464… <chr>
#> # ℹ 918 more rows
#> # ℹ 30 more variables: assay <list>, batch_condition <list>, cell_count <int>,
#> #   cell_type <list>, citation <chr>, default_embedding <chr>,
#> #   development_stage <list>, disease <list>, embeddings <list>,
#> #   explorer_url <chr>, feature_biotype <list>, feature_count <int>,
#> #   feature_reference <list>, is_primary_data <list>,
#> #   mean_genes_per_cell <dbl>, organism <list>, primary_cell_count <int>, …
```

Alternatively, one might be interested in specific authors. This is
most easily accomplished with a simple filter on `author_datasets`, e.g.,

```
author_datasets |>
    filter(
        family %in% c("Teichmann", "Regev", "Haniffa")
    )
#> # A tibble: 655 × 36
#>    collection_id  family given consortium dataset_id dataset_version_id donor_id
#>    <chr>          <chr>  <chr> <chr>      <chr>      <chr>              <list>
#>  1 6f6d381a-7701… Teich… Sara… <NA>       9f222629-… dbb5ad81-1713-4ae… <chr>
#>  2 6f6d381a-7701… Teich… Sara… <NA>       066943a2-… 4cb45d80-499a-48a… <chr>
#>  3 a48f5033-3438… Regev  Aviv  <NA>       e40c6272-… da9edb77-7e04-45f… <chr>
#>  4 a48f5033-3438… Regev  Aviv  <NA>       d6dfdef1-… d1c4e99e-28ed-45b… <chr>
#>  5 a48f5033-3438… Regev  Aviv  <NA>       6a270451-… 9c123ef4-570c-49c… <chr>
#>  6 854c0855-23ad… Teich… Sara… <NA>       f95d8919-… 26d15fe5-5e25-464… <chr>
#>  7 854c0855-23ad… Teich… Sara… <NA>       ec062e17-… 5e271d25-febb-41f… <chr>
#>  8 854c0855-23ad… Teich… Sara… <NA>       d86edd6a-… d80b69a7-4b37-4c0… <chr>
#>  9 854c0855-23ad… Teich… Sara… <NA>       cbec7853-… 14f8def5-649c-4e4… <chr>
#> 10 854c0855-23ad… Teich… Sara… <NA>       a20e2f2a-… ad9529a3-0937-417… <chr>
#> # ℹ 645 more rows
#> # ℹ 29 more variables: assay <list>, batch_condition <list>, cell_count <int>,
#> #   cell_type <list>, citation <chr>, default_embedding <chr>,
#> #   development_stage <list>, disease <list>, embeddings <list>,
#> #   explorer_url <chr>, feature_biotype <list>, feature_count <int>,
#> #   feature_reference <list>, is_primary_data <list>,
#> #   mean_genes_per_cell <dbl>, organism <list>, primary_cell_count <int>, …
```

or more carefully by constructing at `data.frame` of family and given
names, and performing a join with `author_datasets`

```
authors_of_interest <-
    tibble(
        family = c("Teichmann", "Regev", "Haniffa"),
        given = c("Sarah A.", "Aviv", "Muzlifah")
    )
right_join(
    author_datasets,
    authors_of_interest,
    by = c("family", "given")
)
#> # A tibble: 569 × 36
#>    collection_id  family given consortium dataset_id dataset_version_id donor_id
#>    <chr>          <chr>  <chr> <chr>      <chr>      <chr>              <list>
#>  1 a48f5033-3438… Regev  Aviv  <NA>       e40c6272-… da9edb77-7e04-45f… <chr>
#>  2 a48f5033-3438… Regev  Aviv  <NA>       d6dfdef1-… d1c4e99e-28ed-45b… <chr>
#>  3 a48f5033-3438… Regev  Aviv  <NA>       6a270451-… 9c123ef4-570c-49c… <chr>
#>  4 854c0855-23ad… Teich… Sara… <NA>       f95d8919-… 26d15fe5-5e25-464… <chr>
#>  5 854c0855-23ad… Teich… Sara… <NA>       ec062e17-… 5e271d25-febb-41f… <chr>
#>  6 854c0855-23ad… Teich… Sara… <NA>       d86edd6a-… d80b69a7-4b37-4c0… <chr>
#>  7 854c0855-23ad… Teich… Sara… <NA>       cbec7853-… 14f8def5-649c-4e4… <chr>
#>  8 854c0855-23ad… Teich… Sara… <NA>       a20e2f2a-… ad9529a3-0937-417… <chr>
#>  9 854c0855-23ad… Teich… Sara… <NA>       74014ef8-… f5d29727-b197-4ff… <chr>
#> 10 854c0855-23ad… Teich… Sara… <NA>       72f4798d-… 0430f6a9-80d1-4ea… <chr>
#> # ℹ 559 more rows
#> # ℹ 29 more variables: assay <list>, batch_condition <list>, cell_count <int>,
#> #   cell_type <list>, citation <chr>, default_embedding <chr>,
#> #   development_stage <list>, disease <list>, embeddings <list>,
#> #   explorer_url <chr>, feature_biotype <list>, feature_count <int>,
#> #   feature_reference <list>, is_primary_data <list>,
#> #   mean_genes_per_cell <dbl>, organism <list>, primary_cell_count <int>, …
```

## 2.2 Areas of interest

There are several interesting questions that suggest themselves, and
several areas where some additional work is required.

It might be interesting to identify authors working on similar
disease, or other areas of interest. The `disease` column in the
`author_datasets` table is a list.

```
author_datasets |>
    select(family, given, dataset_id, disease)
#> # A tibble: 63,858 × 4
#>    family          given      dataset_id                           disease
#>    <chr>           <chr>      <chr>                                <list>
#>  1 Duclos          Grant E.   61d327d1-2227-4c5f-9367-e3559dc79b07 <list [1]>
#>  2 Teixeira        Vitor H.   61d327d1-2227-4c5f-9367-e3559dc79b07 <list [1]>
#>  3 Autissier       Patrick    61d327d1-2227-4c5f-9367-e3559dc79b07 <list [1]>
#>  4 Gesthalter      Yaron B.   61d327d1-2227-4c5f-9367-e3559dc79b07 <list [1]>
#>  5 Reinders-Luinge Marjan A.  61d327d1-2227-4c5f-9367-e3559dc79b07 <list [1]>
#>  6 Terrano         Robert     61d327d1-2227-4c5f-9367-e3559dc79b07 <list [1]>
#>  7 Dumas           Yves M.    61d327d1-2227-4c5f-9367-e3559dc79b07 <list [1]>
#>  8 Liu             Gang       61d327d1-2227-4c5f-9367-e3559dc79b07 <list [1]>
#>  9 Mazzilli        Sarah A.   61d327d1-2227-4c5f-9367-e3559dc79b07 <list [1]>
#> 10 Brandsma        Corry-Anke 61d327d1-2227-4c5f-9367-e3559dc79b07 <list [1]>
#> # ℹ 63,848 more rows
```

This is because a single dataset may involve more than one
disease. Furthermore, each entry in the list contains two elements,
the `label` and `ontology_term_id` of the disease. There are two
approaches to working with this data.

One approach to working with this data uses facilities in
[cellxgenedp](https://mtmorgan.github.io/cellxgenedp) as outlined in an accompanying article. Discover
possible diseases.

```
facets(db(), "disease")
#> # A tibble: 274 × 4
#>    facet   label                                        ontology_term_id     n
#>    <chr>   <chr>                                        <chr>            <int>
#>  1 disease normal                                       PATO:0000461      1646
#>  2 disease COVID-19                                     MONDO:0100096       66
#>  3 disease dementia                                     MONDO:0001627       52
#>  4 disease breast cancer                                MONDO:0007254       38
#>  5 disease colorectal cancer                            MONDO:0005575       35
#>  6 disease myocardial infarction                        MONDO:0005068       30
#>  7 disease diabetic kidney disease                      MONDO:0005016       26
#>  8 disease Alzheimer disease                            MONDO:0004975       25
#>  9 disease autosomal dominant polycystic kidney disease MONDO:0004691       24
#> 10 disease nonpapillary renal cell carcinoma            MONDO:0007763       20
#> # ℹ 264 more rows
```

Focus on `COVID-19`, and use `facets_filter()` to select relevant
author-dataset combinations.

```
author_datasets |>
    filter(facets_filter(disease, "label", "COVID-19"))
#> # A tibble: 1,912 × 36
#>    collection_id  family given consortium dataset_id dataset_version_id donor_id
#>    <chr>          <chr>  <chr> <chr>      <chr>      <chr>              <list>
#>  1 8f126edf-5405… Ahern  Davi… <NA>       ebc2e1ff-… 687c09ff-731a-4e3… <chr>
#>  2 8f126edf-5405… Ai     Zhic… <NA>       ebc2e1ff-… 687c09ff-731a-4e3… <chr>
#>  3 8f126edf-5405… Ainsw… Mark  <NA>       ebc2e1ff-… 687c09ff-731a-4e3… <chr>
#>  4 8f126edf-5405… Allan  Chris <NA>       ebc2e1ff-… 687c09ff-731a-4e3… <chr>
#>  5 8f126edf-5405… Allco… Alice <NA>       ebc2e1ff-… 687c09ff-731a-4e3… <chr>
#>  6 8f126edf-5405… Angus  Brian <NA>       ebc2e1ff-… 687c09ff-731a-4e3… <chr>
#>  7 8f126edf-5405… Ansari M. A… <NA>       ebc2e1ff-… 687c09ff-731a-4e3… <chr>
#>  8 8f126edf-5405… Aranc… Caro… <NA>       ebc2e1ff-… 687c09ff-731a-4e3… <chr>
#>  9 8f126edf-5405… Asche… Domi… <NA>       ebc2e1ff-… 687c09ff-731a-4e3… <chr>
#> 10 8f126edf-5405… Attar  Mous… <NA>       ebc2e1ff-… 687c09ff-731a-4e3… <chr>
#> # ℹ 1,902 more rows
#> # ℹ 29 more variables: assay <list>, batch_condition <list>, cell_count <int>,
#> #   cell_type <list>, citation <chr>, default_embedding <chr>,
#> #   development_stage <list>, disease <list>, embeddings <list>,
#> #   explorer_url <chr>, feature_biotype <list>, feature_count <int>,
#> #   feature_reference <list>, is_primary_data <list>,
#> #   mean_genes_per_cell <dbl>, organism <list>, primary_cell_count <int>, …
```

Authors contributing to these datasets are

```
author_datasets |>
    filter(facets_filter(disease, "label", "COVID-19")) |>
    count(family, given, sort = TRUE)
#> # A tibble: 836 × 3
#>    family       given           n
#>    <chr>        <chr>       <int>
#>  1 Farber       Donna L.       29
#>  2 Guo          Xinzheng V.    28
#>  3 Saqi         Anjali         28
#>  4 Baldwin      Matthew R.     27
#>  5 Chait        Michael        27
#>  6 Connors      Thomas J.      27
#>  7 Davis-Porada Julia          27
#>  8 Dogra        Pranay         27
#>  9 Gray         Joshua I.      27
#> 10 Idzikowski   Emma           27
#> # ℹ 826 more rows
```

A second approach is to follow the practices in [R for Data
Science](https://r4ds.hadley.nz/rectangling), the `disease` column can be ‘unnested’ twice, the
first time to expand the `author_datasets` table for each disease, and
the second time to separate the two columns of each disease.

```
author_dataset_diseases <-
    author_datasets |>
    select(family, given, dataset_id, disease) |>
    tidyr::unnest_longer(disease) |>
    tidyr::unnest_wider(disease)
author_dataset_diseases
#> # A tibble: 89,492 × 5
#>    family          given      dataset_id                  label ontology_term_id
#>    <chr>           <chr>      <chr>                       <chr> <chr>
#>  1 Duclos          Grant E.   61d327d1-2227-4c5f-9367-e3… norm… PATO:0000461
#>  2 Teixeira        Vitor H.   61d327d1-2227-4c5f-9367-e3… norm… PATO:0000461
#>  3 Autissier       Patrick    61d327d1-2227-4c5f-9367-e3… norm… PATO:0000461
#>  4 Gesthalter      Yaron B.   61d327d1-2227-4c5f-9367-e3… norm… PATO:0000461
#>  5 Reinders-Luinge Marjan A.  61d327d1-2227-4c5f-9367-e3… norm… PATO:0000461
#>  6 Terrano         Robert     61d327d1-2227-4c5f-9367-e3… norm… PATO:0000461
#>  7 Dumas           Yves M.    61d327d1-2227-4c5f-9367-e3… norm… PATO:0000461
#>  8 Liu             Gang       61d327d1-2227-4c5f-9367-e3… norm… PATO:0000461
#>  9 Mazzilli        Sarah A.   61d327d1-2227-4c5f-9367-e3… norm… PATO:0000461
#> 10 Brandsma        Corry-Anke 61d327d1-2227-4c5f-9367-e3… norm… PATO:0000461
#> # ℹ 89,482 more rows
```

Author-dataset combinations associated with COVID-19, and contributors
to these datasets, are

```
author_dataset_diseases |>
    filter(label == "COVID-19")

author_dataset_diseases |>
    filter(label == "COVID-19") |>
    count(family, given, sort = TRUE)
```

These computations are the same as the earlier iteration using
functionality in [cellxgenedp](https://mtmorgan.github.io/cellxgenedp).

A further resource that might be of interest is the [OSLr][] package
article illustrating how the ontologies used by CELLxGENE can be
manipulated to, e.g., identify studies with terms that derive from a
common term (e.g., all disease terms related to ‘carcinoma’).

## 2.3 Collaboration

TODO.

It might be interesting to know which authors have collaborated with
one another. This can be computed from the `author_datasets` table,
following approaches developed in the [grantpubcite](https://mtmorgan.github.io/grant) package to
identify collaborations between projects in the NIH-funded ITCR
program. See the graph visualization in the [ITCR collaboration](https://mtmorgan.github.io/grantpubcite/articles/case_study_itcr.html#itcr-collaboration)
section for inspiration.

## 2.4 Duplicate collection-author combinations

Here are the authors

```
authors <- authors()
authors
#> # A tibble: 7,905 × 4
#>    collection_id                        family          given      consortium
#>    <chr>                                <chr>           <chr>      <chr>
#>  1 1f0f863f-b69d-4ba3-8bab-d2727dd0aecf Duclos          Grant E.   <NA>
#>  2 1f0f863f-b69d-4ba3-8bab-d2727dd0aecf Teixeira        Vitor H.   <NA>
#>  3 1f0f863f-b69d-4ba3-8bab-d2727dd0aecf Autissier       Patrick    <NA>
#>  4 1f0f863f-b69d-4ba3-8bab-d2727dd0aecf Gesthalter      Yaron B.   <NA>
#>  5 1f0f863f-b69d-4ba3-8bab-d2727dd0aecf Reinders-Luinge Marjan A.  <NA>
#>  6 1f0f863f-b69d-4ba3-8bab-d2727dd0aecf Terrano         Robert     <NA>
#>  7 1f0f863f-b69d-4ba3-8bab-d2727dd0aecf Dumas           Yves M.    <NA>
#>  8 1f0f863f-b69d-4ba3-8bab-d2727dd0aecf Liu             Gang       <NA>
#>  9 1f0f863f-b69d-4ba3-8bab-d2727dd0aecf Mazzilli        Sarah A.   <NA>
#> 10 1f0f863f-b69d-4ba3-8bab-d2727dd0aecf Brandsma        Corry-Anke <NA>
#> # ℹ 7,895 more rows
```

There are 7905 collection-author combinations. We expect
these to be distinct (each row identifying a unique collection-author
combination). But this is not true

```
nrow(authors) == nrow(distinct(authors))
#> [1] FALSE
```

Duplicated data are

```
authors |>
    count(collection_id, family, given, consortium, sort = TRUE) |>
    filter(n > 1)
#> # A tibble: 24 × 5
#>    collection_id                        family   given      consortium     n
#>    <chr>                                <chr>    <chr>      <chr>      <int>
#>  1 51544e44-293b-4c2b-8c26-560678423380 Betts    Michael R. <NA>           2
#>  2 51544e44-293b-4c2b-8c26-560678423380 Faryabi  Robert B.  <NA>           2
#>  3 51544e44-293b-4c2b-8c26-560678423380 Fasolino Maria      <NA>           2
#>  4 51544e44-293b-4c2b-8c26-560678423380 Feldman  Michael    <NA>           2
#>  5 51544e44-293b-4c2b-8c26-560678423380 Goldman  Naomi      <NA>           2
#>  6 51544e44-293b-4c2b-8c26-560678423380 Golson   Maria L.   <NA>           2
#>  7 51544e44-293b-4c2b-8c26-560678423380 Japp     Alberto S. <NA>           2
#>  8 51544e44-293b-4c2b-8c26-560678423380 Kaestner Klaus H.   <NA>           2
#>  9 51544e44-293b-4c2b-8c26-560678423380 Kondo    Ayano      <NA>           2
#> 10 51544e44-293b-4c2b-8c26-560678423380 Liu      Chengyang  <NA>           2
#> # ℹ 14 more rows
```

Discover details of the first duplicated collection,
`e5f58829-1a66-40b5-a624-9046778e74f5`

```
duplicate_authors <-
    collections() |>
    filter(collection_id == "e5f58829-1a66-40b5-a624-9046778e74f5")
duplicate_authors
#> # A tibble: 1 × 18
#>   collection_id     collection_version_id collection_url consortia contact_email
#>   <chr>             <chr>                 <chr>          <list>    <chr>
#> 1 e5f58829-1a66-40… 6648d872-8ab3-4b3e-9… https://cellx… <chr [2]> angela.olive…
#> # ℹ 13 more variables: contact_name <chr>, curator_name <chr>,
#> #   description <chr>, doi <chr>, links <list>, name <chr>,
#> #   publisher_metadata <list>, revising_in <lgl>, revision_of <lgl>,
#> #   visibility <chr>, created_at <date>, published_at <date>, revised_at <date>
```

The author information comes from the `publisher_metadata` column

```
publisher_metadata <-
    duplicate_authors |>
    pull(publisher_metadata)
```

This is a ‘list-of-lists’, with relevant information as elements in
the first list

```
names(publisher_metadata[[1]])
#> [1] "authors"         "is_preprint"     "journal"         "published_at"
#> [5] "published_day"   "published_month" "published_year"
```

and relevant information in the `authors` field, of which there are 221

```
length(publisher_metadata[[1]][["authors"]])
#> [1] 164
```

Inspection shows that there are four authors with family name `Pisco`
and given name `Angela Oliveira`: it appears that the data provided by
CZI indeed includes duplicate author names.

From a pragmatic perspective, it might make sense to remove duplicate
entries from `authors` before down-stream analysis.

```
deduplicated_authors <- distinct(authors)
```

Tools that I have found useful when working with list-of-lists style
data rare [listviewer::jsonedit()](https://CRAN.r-project.org/package%3Dlistviewer) for visualization, and
[rjsoncons](https://CRAN.r-project.org/package%3Drjsoncons) for filtering and querying these data using JSONpointer,
JSONpath, or JMESpath expression (a more R-centric tool is the
[purrr](https://CRAN.r-project.org/package%3Dpurrr) package).

### 2.4.1 What is an ‘author’?

The combination of family and given name may refer to two (or more)
different individuals (e.g., two individuals named ‘Martin Morgan’),
or a single individual may be recorded under two different names
(e.g., given name sometimes ‘Martin’ and sometimes ‘Martin T.’). It is
not clear how this could be resolved; recording ORCID identifiers
migth help with disambiguation.

# 3 Case study: using ontology to identify datasets

This case study was developed in response to the following Slack
question:

> CELLxGENE’s webpage is using different ontologies and displaying
> them in an easy to interogate manner (choosing amongst 3 possible
> coarseness for cell types, tissues and age) I was wondering if this
> simplified tree of the 3 subgroups for cell type, tissue and age
> categories was available somewhere?

As indicated in the question, CELLxGENE provides some access to
ontologies through a hand-curated three-tiered classification of
specific facets; the tiers can be retrieved from publicly available
code, but one might want to develop a more flexible or principled
approach.

CELLxGENE dataset facets like ‘disease’ and ‘cell type’ use terms from
ontologies. Ontologies arrange terms in directed acyclic graphs, and
use of ontologies can be useful to identify related datasets. For
instance, one might be interesed in cancer-related datasets (derived
from the ‘carcinoma’ term in the corresponding ontology) in general,
rather than, e.g., ‘B-cell non-Hodgkins lymphoma’.

In exploring this question in *R*, I found myself developing the
[OLSr](https://mtmorgan.github.io/OLSr) package to query and process ontologies from the EMBL-EBI
[Ontology Lookup Service](https://www.ebi.ac.uk/ols4/). See the ‘[Case Study: CELLxGENE
Ontologies](https://mtmorgan.github.io/OLSr/articles/b_case_study_cxg.html)’ article in the OLSr package for full
details.

# Session information

```
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
#>  [1] cellxgenedp_1.14.0          dplyr_1.1.4
#>  [3] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#>  [5] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [7] Seqinfo_1.0.0               IRanges_2.44.0
#>  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [11] generics_0.1.4              MatrixGenerics_1.22.0
#> [13] matrixStats_1.5.0           zellkonverter_1.20.0
#> [15] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] dir.expiry_1.18.0   xfun_0.53           bslib_0.9.0
#>  [4] htmlwidgets_1.6.4   rhdf5_2.54.0        lattice_0.22-7
#>  [7] rhdf5filters_1.22.0 vctrs_0.6.5         rjsoncons_1.3.2
#> [10] tools_4.5.1         curl_7.0.0          parallel_4.5.1
#> [13] tibble_3.3.0        pkgconfig_2.0.3     Matrix_1.7-4
#> [16] lifecycle_1.0.4     compiler_4.5.1      httpuv_1.6.16
#> [19] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
#> [22] tidyr_1.3.1         pillar_1.11.1       later_1.4.4
#> [25] jquerylib_0.1.4     DT_0.34.0           DelayedArray_0.36.0
#> [28] cachem_1.1.0        abind_1.4-8         mime_0.13
#> [31] basilisk_1.22.0     tidyselect_1.2.1    digest_0.6.37
#> [34] purrr_1.1.0         bookdown_0.45       fastmap_1.2.0
#> [37] grid_4.5.1          cli_3.6.5           SparseArray_1.10.0
#> [40] magrittr_2.0.4      S4Arrays_1.10.0     h5mread_1.2.0
#> [43] utf8_1.2.6          withr_3.0.2         filelock_1.0.3
#> [46] promises_1.4.0      rmarkdown_2.30      XVector_0.50.0
#> [49] httr_1.4.7          otel_0.2.0          reticulate_1.44.0
#> [52] png_0.1-8           HDF5Array_1.38.0    shiny_1.11.1
#> [55] evaluate_1.0.5      knitr_1.50          rlang_1.1.6
#> [58] Rcpp_1.1.0          xtable_1.8-4        glue_1.8.0
#> [61] BiocManager_1.30.26 jsonlite_2.0.0      Rhdf5lib_1.32.0
#> [64] R6_2.6.1
```