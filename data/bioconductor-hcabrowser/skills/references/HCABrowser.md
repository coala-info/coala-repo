# What is the Human Cell Atlas?

From the [Human Cell Atlas (HCA) website](https://www.humancellatlas.org/):

> The cell is the core unit of the human body—the key to understanding the
> biology of health and the ways in which molecular dysfunction leads to disease.
> Yet our characterization of the hundreds of types and subtypes of cells in the
> human body is limited, based partly on techniques that have limited resolution
> and classifications that do not always map neatly to each other. Genomics has
> offered a systematic approach, but it has largely been applied in bulk to many
> cell types at once—masking critical differences between cells—and in isolation
> from other valuable sources of data.
>
> Recent advances in single-cell genomic analysis of cells and tissues have put
> systematic, high-resolution and comprehensive reference maps of all human cells
> within reach. In other words, we can now realistically envision a human cell
> atlas to serve as a basis for both understanding human health and diagnosing,
> monitoring, and treating disease.
>
> At its core, a cell atlas would be a collection of cellular reference maps,
> characterizing each of the thousands of cell types in the human body and where
> they are found. It would be an extremely valuable resource to empower the global
> research community to systematically study the biological changes associated
> with different diseases, understand where genes associated with disease are
> active in our bodies, analyze the molecular mechanisms that govern the
> production and activity of different cell types, and sort out how different cell
> types combine and work together to form tissues.

The Human Cell Atlas facilitates queries on it's [data coordination platform with
a RESTFUL API](https://dss.data.humancellatlas.org/).

## Installation

To install this package, use Bioconductor's `BiocManager` package.

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install('HCABrowser')
```

```
library(HCABrowser)
```

## Connecting to the Human Cell Atlas

The *[HCABrowser](https://bioconductor.org/packages/3.9/HCABrowser)* package relies on having network
connectivety. Also, the HCA's Data Coordination Platform (DCP) must
also be operational.

The `HCABrowser` object serves as the representation of the Human Cell
Atlas. Upon creation, it will automatically peform a cursorary query and
display a small table showing the first few bundles of the entire HCA. This
intial table contains some columns that we have determined are most useful
to users. The output also displays the url of the instance of the HCA DCP being
used, the current query, whether bundles or files are being displayed, and the
number of bundles in the results

By default, ten bundles per page will be displayed in the result and the
default url to the HCA DCP will be used. Currently, the maximum number of
bundles that can be shown per query is ten. These two values can be changed in
the constructor.

If the HCA cannot be reached, an error will be thrown displaying the status of
the request.

```
hca <- HCABrowser(url = 'https://dss.data.humancellatlas.org/v1', per_page = 10)
hca
```

```
## class: HCABrowser
## Using hca-dcp at:
##   https://dss.data.humancellatlas.org/v1
##
## Current Query:
##
## Current Selection:
##   "project_title", "project_short_name", "organ.text"
##
## class: SearchResult
##   bundle 1 - 10 of 695382
##   link: TRUE
##
## Showing bundles with 10 results per page
## # A tibble: 10 x 5
##    project_json.pr… project_json.pr… specimen_from_o… bundle_fqid
##    <chr>            <chr>            <chr>            <fct>
##  1 Tabula Muris     Tabula Muris: T… bladder          ffffba2d-3…
##  2 Tabula Muris     Tabula Muris: T… lung epcam       ffffaf55-f…
##  3 <NA>             <NA>             <NA>             ffffab51-b…
##  4 <NA>             <NA>             <NA>             ffffa79b-9…
##  5 <NA>             <NA>             <NA>             ffffa79b-9…
##  6 <NA>             <NA>             <NA>             ffffa79b-9…
##  7 <NA>             <NA>             <NA>             ffffa79b-9…
##  8 <NA>             <NA>             <NA>             ffffa79b-9…
##  9 Tabula Muris     Tabula Muris: T… thymus           fffee4fc-7…
## 10 <NA>             <NA>             <NA>             fffeddc6-a…
## # … with 1 more variable: bundle_url <fct>
```

Upon displaying the object, multiple fields can be seen:

* The class: `HCABrowser`
* The hca dcp address that is currently being used.
* The current query (assigned using `filter()`)
* The current selection (assigned using `select()`)
  + You may notice that some columns are already selected. These columns are
    automatically selected to allow the user some initial view of the hca.
* The bundles being shown and whether a `link` to more results is availiable
* The number of bundles or files being shown per\_page
* The results `tibble` of the query

The results `tibble` can be obtained using the `results()` method.

```
results(hca)
```

```
## # A tibble: 10 x 5
##    project_json.pr… project_json.pr… specimen_from_o… bundle_fqid
##    <chr>            <chr>            <chr>            <fct>
##  1 Tabula Muris     Tabula Muris: T… bladder          ffffba2d-3…
##  2 Tabula Muris     Tabula Muris: T… lung epcam       ffffaf55-f…
##  3 <NA>             <NA>             <NA>             ffffab51-b…
##  4 <NA>             <NA>             <NA>             ffffa79b-9…
##  5 <NA>             <NA>             <NA>             ffffa79b-9…
##  6 <NA>             <NA>             <NA>             ffffa79b-9…
##  7 <NA>             <NA>             <NA>             ffffa79b-9…
##  8 <NA>             <NA>             <NA>             ffffa79b-9…
##  9 Tabula Muris     Tabula Muris: T… thymus           fffee4fc-7…
## 10 <NA>             <NA>             <NA>             fffeddc6-a…
## # … with 1 more variable: bundle_url <fct>
```

To toggle whether bundles or files are being displayed in the `tibble`, the
`activate()` method can be used to choose which to display.

```
## Bundles are diaplyed be default
nrow(results(hca))
```

```
## [1] 10
```

```
## The HCABrowser object is activated here by 'files'
hca <- hca %>% activate('files')
hca
```

```
## class: HCABrowser
## Using hca-dcp at:
##   https://dss.data.humancellatlas.org/v1
##
## Current Query:
##
## Current Selection:
##   "project_title", "project_short_name", "organ.text"
##
## class: SearchResult
##   bundle 1 - 10 of 695382
##   link: TRUE
##
## Showing files with 10 results per page
## # A tibble: 10 x 5
##    project_json.pr… project_json.pr… specimen_from_o… bundle_fqid
##    <chr>            <chr>            <chr>            <fct>
##  1 Tabula Muris     Tabula Muris: T… bladder          ffffba2d-3…
##  2 Tabula Muris     Tabula Muris: T… lung epcam       ffffaf55-f…
##  3 <NA>             <NA>             <NA>             ffffab51-b…
##  4 <NA>             <NA>             <NA>             ffffa79b-9…
##  5 <NA>             <NA>             <NA>             ffffa79b-9…
##  6 <NA>             <NA>             <NA>             ffffa79b-9…
##  7 <NA>             <NA>             <NA>             ffffa79b-9…
##  8 <NA>             <NA>             <NA>             ffffa79b-9…
##  9 Tabula Muris     Tabula Muris: T… thymus           fffee4fc-7…
## 10 <NA>             <NA>             <NA>             fffeddc6-a…
## # … with 1 more variable: bundle_url <fct>
```

```
nrow(results(hca))
```

```
## [1] 10
```

```
## Revert back to showing bundles with 'bundles'
hca <- hca %>% activate('bundles')
```

To change how many pages are being displayed, the `per_page()` method can be
used.
(Note the hca dcp had a maximum of 10 bundles per page to be shown at a time)

```
#hca2 <- hca %>% per_page(n = 5)
#hca2
```

Since there are far more bundles in the HCA than can be shown, if `link` is
`True`, the next set of bundles can be obtained using the `nextResults` method.

```
hca <- nextResults(hca)
hca
```

```
## class: HCABrowser
## Using hca-dcp at:
##   https://dss.data.humancellatlas.org/v1
##
## Current Query:
##
## Current Selection:
##   "project_title", "project_short_name", "organ.text"
##
## class: SearchResult
##   bundle 11 - 20 of 695382
##   link: TRUE
##
## Showing bundles with 10 results per page
## # A tibble: 10 x 5
##    bundle_fqid bundle_url project_json.pr… project_json.pr…
##    <fct>       <fct>      <chr>            <chr>
##  1 fffeddc6-a… https://d… <NA>             <NA>
##  2 fffeddc6-a… https://d… <NA>             <NA>
##  3 fffeddc6-a… https://d… <NA>             <NA>
##  4 fffeddc6-a… https://d… <NA>             <NA>
##  5 fffe6080-3… https://d… <NA>             <NA>
##  6 fffe6080-3… https://d… <NA>             <NA>
##  7 fffe6080-3… https://d… <NA>             <NA>
##  8 fffe6080-3… https://d… <NA>             <NA>
##  9 fffe6080-3… https://d… <NA>             <NA>
## 10 fffe55c1-1… https://d… Fetal/Maternal … Reconstructing …
## # … with 1 more variable: specimen_from_organism_json.organ.text <chr>
```

## Querying the HCABrowser

To show which fields are available to query, use the `supportedFilters()` method.

```
hca <- HCABrowser()
hca %>% fields
```

```
## # A tibble: 394 x 2
##    abbreviated_names                   field_names
##    <chr>                               <chr>
##  1 address                             files.project_json.contributors.add…
##  2 alcohol_history                     files.donor_organism_json.medical_h…
##  3 analysis_file_json.describedBy      files.analysis_file_json.describedBy
##  4 analysis_file_json.file_core.file_… files.analysis_file_json.file_core.…
##  5 analysis_file_json.schema_type      files.analysis_file_json.schema_type
##  6 analysis_process_json.describedBy   files.analysis_process_json.describ…
##  7 analysis_process_json.schema_type   files.analysis_process_json.schema_…
##  8 analysis_protocol_json.describedBy  files.analysis_protocol_json.descri…
##  9 analysis_protocol_json.protocol_co… files.analysis_protocol_json.protoc…
## 10 analysis_protocol_json.schema_type  files.analysis_protocol_json.schema…
## # … with 384 more rows
```

The `abbreviated_fields` column indicates the shortest possible name that can be
used to reference the field. The `field_names` columns shows the whole schema
name on the json schema.

Availiable values to these fields can be found using the `values()` method.
If the parameter `fields` is specified, it will display values related to those
field. If not specified, the values for all fields will be shown.

```
hca %>% values(c('organ.text', 'library_construction_approach.text'))
```

```
## # A tibble: 23 x 2
##    field_names                                  value
##    <fct>                                        <fct>
##  1 files.specimen_from_organism_json.organ.text pancreas
##  2 files.specimen_from_organism_json.organ.text tumor
##  3 files.specimen_from_organism_json.organ.text embryo
##  4 files.specimen_from_organism_json.organ.text lymph node
##  5 files.specimen_from_organism_json.organ.text Brain
##  6 files.specimen_from_organism_json.organ.text immune system
##  7 files.specimen_from_organism_json.organ.text blood
##  8 files.specimen_from_organism_json.organ.text skin
##  9 files.specimen_from_organism_json.organ.text skin of body
## 10 files.specimen_from_organism_json.organ.text spleen
## # … with 13 more rows
```

The HCA extends the functionality of the *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)* package's `filter()`
and `select()` methods.

The `filter()` method allows the user to query the HCA by relating fields to
certain values. Character fields can be queried using the operators:

* `==`
* `!=`
* `%in%`
* `%startsWith%`
* `%endsWith%`
* `%contains%`

Numeric fields can be queried with the operators:

* `==`
* `!=`
* `%in%`
* `>`
* `<`
* `>=`
* `<=`

Queries can be encompassed by parenthesese

* `()`

Queries can be negated by placing the `!` symbol in front

Combination operators can be used to combine queries

* `&`
* `|`

As an example, in order to find HCA resources associated with the brain. It can
the be seen by looking at the result of the `fields` method, that
`organ.text` can be used to reference `files.specimen_from_organism.organ.text`.
Running `organ.text` through `values`, we see the following:

```
hca %>% values('organ.text')
```

```
## # A tibble: 15 x 2
##    field_names                                  value
##    <fct>                                        <fct>
##  1 files.specimen_from_organism_json.organ.text pancreas
##  2 files.specimen_from_organism_json.organ.text tumor
##  3 files.specimen_from_organism_json.organ.text embryo
##  4 files.specimen_from_organism_json.organ.text lymph node
##  5 files.specimen_from_organism_json.organ.text Brain
##  6 files.specimen_from_organism_json.organ.text immune system
##  7 files.specimen_from_organism_json.organ.text blood
##  8 files.specimen_from_organism_json.organ.text skin
##  9 files.specimen_from_organism_json.organ.text skin of body
## 10 files.specimen_from_organism_json.organ.text spleen
## 11 files.specimen_from_organism_json.organ.text oesophagus
## 12 files.specimen_from_organism_json.organ.text brain
## 13 files.specimen_from_organism_json.organ.text kidney
## 14 files.specimen_from_organism_json.organ.text "bone "
## 15 files.specimen_from_organism_json.organ.text bone
```

Now we see that “brain” and “Brain” are available values. Since these values are
the result of input by other users, there may be errors or inconsistencies. To
be safe, both fields can be queried with the following query:

```
hca2 <- hca %>% filter(organ.text == c('Brain', 'brain'))
hca2 <- hca %>% filter(organ.text %in% c('Brain', 'brain'))
hca2 <- hca %>% filter(organ.text == Brain | organ.text == brain)
hca2
```

```
## class: HCABrowser
## Using hca-dcp at:
##   https://dss.data.humancellatlas.org/v1
##
## Current Query:
##   organ.text == Brain | organ.text == brain
##
## Current Selection:
##   "project_title", "project_short_name", "organ.text"
##   "files.specimen_from_organism_json.organ.text",
##   "files.specimen_from_organism_json.organ.text"
##
## class: SearchResult
##   bundle 1 - 10 of 25462
##   link: TRUE
##
## Showing bundles with 10 results per page
## # A tibble: 10 x 5
##    project_json.pr… project_json.pr… specimen_from_o… bundle_fqid
##    <chr>            <chr>            <chr>            <fct>
##  1 1M Neurons       1.3 Million Bra… Brain            fffcea5e-2…
##  2 Tabula Muris     Tabula Muris: T… brain            fffcc997-3…
##  3 Tabula Muris     Tabula Muris: T… brain            fffb302b-1…
##  4 Tabula Muris     Tabula Muris: T… brain            fff898a9-b…
##  5 Tabula Muris     Tabula Muris: T… brain            fff57cf8-5…
##  6 Tabula Muris     Tabula Muris: T… brain            fff5329f-b…
##  7 Tabula Muris     Tabula Muris: T… brain            ffee0443-1…
##  8 Tabula Muris     Tabula Muris: T… brain            ffe7dee0-2…
##  9 Tabula Muris     Tabula Muris: T… brain            ffe61686-a…
## 10 Tabula Muris     Tabula Muris: T… brain            ffe1d3d3-d…
## # … with 1 more variable: bundle_url <fct>
```

If we also wish to search for results based on the NCBI Taxon ID for mouse,
10090, as well as brain, we can perform this query in a variety of ways.

```
hca2 <- hca %>% filter(organ.text %in% c('Brain', 'brain')) %>%
                filter('specimen_from_organism_json.biomaterial_core.ncbi_taxon_id' == 10090)
hca2 <- hca %>% filter(organ.text %in% c('Brain', 'brain'),
                       'specimen_from_organism_json.biomaterial_core.ncbi_taxon_id' == 10090)
hca <- hca %>% filter(organ.text %in% c('Brain', 'brain') &
                      'specimen_from_organism_json.biomaterial_core.ncbi_taxon_id' == 10090)
hca
```

```
## class: HCABrowser
## Using hca-dcp at:
##   https://dss.data.humancellatlas.org/v1
##
## Current Query:
##   organ.text %in% c("Brain", "brain") & "specimen_from_organism_json.biomaterial_core.ncbi_taxon_id" == 10090
##
## Current Selection:
##   "project_title", "project_short_name", "organ.text"
##   "files.specimen_from_organism_json.organ.text",
##   "files.specimen_from_organism_json.biomaterial_core.ncbi_taxon_id"
##
## class: SearchResult
##   bundle 1 - 10 of 25462
##   link: TRUE
##
## Showing bundles with 10 results per page
## # A tibble: 10 x 6
##    project_json.pr… project_json.pr… specimen_from_o… specimen_from_o…
##    <chr>            <chr>            <chr>            <chr>
##  1 1M Neurons       1.3 Million Bra… 10090            Brain
##  2 Tabula Muris     Tabula Muris: T… 10090            brain
##  3 Tabula Muris     Tabula Muris: T… 10090            brain
##  4 Tabula Muris     Tabula Muris: T… 10090            brain
##  5 Tabula Muris     Tabula Muris: T… 10090            brain
##  6 Tabula Muris     Tabula Muris: T… 10090            brain
##  7 Tabula Muris     Tabula Muris: T… 10090            brain
##  8 Tabula Muris     Tabula Muris: T… 10090            brain
##  9 Tabula Muris     Tabula Muris: T… 10090            brain
## 10 Tabula Muris     Tabula Muris: T… 10090            brain
## # … with 2 more variables: bundle_fqid <fct>, bundle_url <fct>
```

The `HCABrowser` package is able to handle arbitrarily complex queries on the
Human Cell Atlas.

```
hca2 <- hca %>% filter((!organ.text %in% c('Brain', 'blood')) &
                       (files.specimen_from_organism_json.genus_species.text == "Homo sapiens" |
                        library_preparation_protocol_json.library_construction_approach.text == 'Smart-seq2')
                )
hca2
```

```
## class: HCABrowser
## Using hca-dcp at:
##   https://dss.data.humancellatlas.org/v1
##
## Current Query:
##   organ.text %in% c("Brain", "brain") & "specimen_from_organism_json.biomaterial_core.ncbi_taxon_id" == 10090
##   (!organ.text %in% c("Brain", "blood")) & (files.specimen_from_organism_json.genus_species.text == "Homo sapiens" | library_preparation_protocol_json.library_construction_approach.text == "Smart-seq2")
##
## Current Selection:
##   "project_title", "project_short_name", "organ.text"
##   "files.specimen_from_organism_json.organ.text",
##   "files.specimen_from_organism_json.biomaterial_core.ncbi_taxon_id"
##   "files.specimen_from_organism_json.organ.text",
##   "files.specimen_from_organism_json.biomaterial_core.ncbi_taxon_id",
##   "files.specimen_from_organism_json.organ.text",
##   "files.specimen_from_organism_json.genus_species.text",
##   "files.library_preparation_protocol_json.library_construction_approach.text"
##
## class: SearchResult
##   bundle 0 - 0 of 0
##   link: FALSE
##
## Showing bundles with 10 results per page
## # A tibble: 0 x 0
```

The `HCABrowser` object can undo the most recent queries run on it.

```
hca <- hca %>% filter(organ.text == heart)
hca <- hca %>% filter(organ.text != brain)
hca <- hca %>% undoEsQuery(n = 2)
hca
```

```
## class: HCABrowser
## Using hca-dcp at:
##   https://dss.data.humancellatlas.org/v1
##
## Current Query:
##   organ.text %in% c("Brain", "brain") & "specimen_from_organism_json.biomaterial_core.ncbi_taxon_id" == 10090
##
## Current Selection:
##   "project_title", "project_short_name", "organ.text"
##   "files.specimen_from_organism_json.organ.text",
##   "files.specimen_from_organism_json.biomaterial_core.ncbi_taxon_id"
##   "files.specimen_from_organism_json.organ.text",
##   "files.specimen_from_organism_json.biomaterial_core.ncbi_taxon_id"
##
## class: SearchResult
##   bundle 1 - 10 of 25462
##   link: TRUE
##
## Showing bundles with 10 results per page
## # A tibble: 10 x 6
##    project_json.pr… project_json.pr… specimen_from_o… specimen_from_o…
##    <chr>            <chr>            <chr>            <chr>
##  1 1M Neurons       1.3 Million Bra… 10090            Brain
##  2 Tabula Muris     Tabula Muris: T… 10090            brain
##  3 Tabula Muris     Tabula Muris: T… 10090            brain
##  4 Tabula Muris     Tabula Muris: T… 10090            brain
##  5 Tabula Muris     Tabula Muris: T… 10090            brain
##  6 Tabula Muris     Tabula Muris: T… 10090            brain
##  7 Tabula Muris     Tabula Muris: T… 10090            brain
##  8 Tabula Muris     Tabula Muris: T… 10090            brain
##  9 Tabula Muris     Tabula Muris: T… 10090            brain
## 10 Tabula Muris     Tabula Muris: T… 10090            brain
## # … with 2 more variables: bundle_fqid <fct>, bundle_url <fct>
```

If one would want to start from a fresh query but retain the modifications made
to the `HCABrowser` object, the `resetEsQuery()` method can be used.

```
hca <- hca %>% resetEsQuery
hca
```

Using `fields()`, we can find that the fields `paired_end` and
`organ.ontology` are availiable. These fields can be shown in our resulting
`HCABrowser` object using the `select()` method.

```
hca2 <- hca %>% select('paired_end', 'organ.ontology')
#hca2 <- hca %>% select(paired_end, organ.ontology)
hca2 <- hca %>% select(c('paired_end', 'organ.ontology'))
hca2
```

```
## class: HCABrowser
## Using hca-dcp at:
##   https://dss.data.humancellatlas.org/v1
##
## Current Query:
##   organ.text %in% c("Brain", "brain") & "specimen_from_organism_json.biomaterial_core.ncbi_taxon_id" == 10090
##
## Current Selection:
##   "project_title", "project_short_name", "organ.text"
##   "files.specimen_from_organism_json.organ.text",
##   "files.specimen_from_organism_json.biomaterial_core.ncbi_taxon_id"
##   "files.specimen_from_organism_json.organ.text",
##   "files.specimen_from_organism_json.biomaterial_core.ncbi_taxon_id"
##   "paired_end", "organ.ontology"
##
## class: SearchResult
##   bundle 1 - 10 of 25462
##   link: TRUE
##
## Showing bundles with 10 results per page
## # A tibble: 10 x 8
##    project_json.pr… project_json.pr… sequencing_prot… specimen_from_o…
##    <chr>            <chr>            <lgl>            <chr>
##  1 1M Neurons       1.3 Million Bra… FALSE            10090
##  2 Tabula Muris     Tabula Muris: T… TRUE             10090
##  3 Tabula Muris     Tabula Muris: T… TRUE             10090
##  4 Tabula Muris     Tabula Muris: T… TRUE             10090
##  5 Tabula Muris     Tabula Muris: T… TRUE             10090
##  6 Tabula Muris     Tabula Muris: T… TRUE             10090
##  7 Tabula Muris     Tabula Muris: T… TRUE             10090
##  8 Tabula Muris     Tabula Muris: T… TRUE             10090
##  9 Tabula Muris     Tabula Muris: T… TRUE             10090
## 10 Tabula Muris     Tabula Muris: T… TRUE             10090
## # … with 4 more variables:
## #   specimen_from_organism_json.organ.ontology <chr>,
## #   specimen_from_organism_json.organ.text <chr>, bundle_fqid <fct>,
## #   bundle_url <fct>
```

Finally, instead of a using the `filter` and `select` methods, one can query
the Human Cell Atlas by using a json query and the `postSearch()` method.
Note that unabbreviated names must be used for these kinds of queries.

## Obtaining results from the HCABrowser object

Once the user is satisfied with their query, the `results()` method can be
used to create a tibble of the first `n` bundles in the search.
Note that since the maximum page size is `10`, the method will need to make
multiple requests to the hca dcp. This may take some time for large requests.

```
res <- hca %>% results(n = 36)
res
```

```
## # A tibble: 36 x 6
##    project_json.pr… project_json.pr… specimen_from_o… specimen_from_o…
##    <chr>            <chr>            <chr>            <chr>
##  1 1M Neurons       1.3 Million Bra… 10090            Brain
##  2 Tabula Muris     Tabula Muris: T… 10090            brain
##  3 Tabula Muris     Tabula Muris: T… 10090            brain
##  4 Tabula Muris     Tabula Muris: T… 10090            brain
##  5 Tabula Muris     Tabula Muris: T… 10090            brain
##  6 Tabula Muris     Tabula Muris: T… 10090            brain
##  7 Tabula Muris     Tabula Muris: T… 10090            brain
##  8 Tabula Muris     Tabula Muris: T… 10090            brain
##  9 Tabula Muris     Tabula Muris: T… 10090            brain
## 10 Tabula Muris     Tabula Muris: T… 10090            brain
## # … with 26 more rows, and 2 more variables: bundle_fqid <fct>,
## #   bundle_url <fct>
```

One can also simply pull bundles from the HCABrowser object's results.

```
bundle_fqids <- hca %>% pullBundles(n = 1)
bundle_fqids
```

```
## [1] "fffcea5e-2e6c-4ca1-9aa9-c23b90b2e8b8.2019-05-16T211813.059000Z"
```

One can query using just the bundle fqids by using the `showBundles` method.

```
hca <- hca %>% showBundles(bundle_fqids = bundle_fqids)
hca
```

```
## class: HCABrowser
## Using hca-dcp at:
##   https://dss.data.humancellatlas.org/v1
##
## Current Query:
##   organ.text %in% c("Brain", "brain") & "specimen_from_organism_json.biomaterial_core.ncbi_taxon_id" == 10090
##   "uuid" %in% bundle_fqids
##
## Current Selection:
##   "project_title", "project_short_name", "organ.text"
##   "files.specimen_from_organism_json.organ.text",
##   "files.specimen_from_organism_json.biomaterial_core.ncbi_taxon_id"
##   "files.specimen_from_organism_json.organ.text",
##   "files.specimen_from_organism_json.biomaterial_core.ncbi_taxon_id"
##   "files.specimen_from_organism_json.organ.text",
##   "files.specimen_from_organism_json.biomaterial_core.ncbi_taxon_id",
##   "uuid"
##
## class: SearchResult
##   bundle 1 - 1 of 1
##   link: FALSE
##
## Showing bundles with 10 results per page
## # A tibble: 1 x 6
##   project_json.pr… project_json.pr… specimen_from_o… specimen_from_o…
##   <chr>            <chr>            <chr>            <chr>
## 1 1M Neurons       1.3 Million Bra… 10090            Brain
## # … with 2 more variables: bundle_fqid <fct>, bundle_url <fct>
```

```
sessionInfo()
```

```
## R version 3.6.1 (2019-07-05)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.9-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.9-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] HCABrowser_1.0.1 dplyr_0.8.3      BiocStyle_2.12.0 knitr_1.24
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.2          plyr_1.8.4          googleAuthR_0.8.1
##  [4] pillar_1.4.2        compiler_3.6.1      BiocManager_1.30.4
##  [7] dbplyr_1.4.2        tools_3.6.1         zeallot_0.1.0
## [10] digest_0.6.20       bit_1.1-14          jsonlite_1.6
## [13] BiocFileCache_1.8.0 RSQLite_2.1.2       evaluate_0.14
## [16] memoise_1.1.0       tibble_2.1.3        pkgconfig_2.0.2
## [19] rlang_0.4.0         igraph_1.2.4.1      tidygraph_1.1.2
## [22] cli_1.1.0           DBI_1.0.0           parallel_3.6.1
## [25] curl_4.0            yaml_2.2.0          xfun_0.9
## [28] stringr_1.4.0       httr_1.4.1          hms_0.5.1
## [31] vctrs_0.2.0         S4Vectors_0.22.0    rappdirs_0.3.1
## [34] stats4_3.6.1        bit64_0.9-7         tidyselect_0.2.5
## [37] glue_1.3.1          R6_2.4.0            fansi_0.4.0
## [40] rmarkdown_1.15      tidyr_0.8.3         readr_1.3.1
## [43] purrr_0.3.2         blob_1.2.0          magrittr_1.5
## [46] BiocGenerics_0.30.0 backports_1.1.4     htmltools_0.3.6
## [49] assertthat_0.2.1    utf8_1.1.4          stringi_1.4.3
## [52] crayon_1.3.4
```

# Developer notes

* The `S3` object-oriented programming paradigm is used.
* Methods from the `dplyr` package can be used to manipulate objects in the
  `HCABrowser` package.
* In the future, we wish to expand the functionalit of this packages to cover
  the remaining functionality of the hca dcp api.