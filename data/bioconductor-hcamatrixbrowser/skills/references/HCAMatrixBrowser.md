# HCAMatrixBrowser Quick Start

#### 28 October 2020

# 1 Installation

## 1.1 HCAMatrixBrowser and HCABrowser

First install the `HCABrowser` to be able to query for `bundle_fqid`
identifiers.

```
if (!requireNamespace("BiocManager", quietly = TRUE)
    install.packages("BiocManager")

BiocManager::install("HCABrowser")
BiocManager::install("HCAMatrixBrowser")
```

Load packages:

```
library(HCABrowser)
library(HCAMatrixBrowser)
```

# 2 Constructing a query using the `HCABrowser`

*Warning*. `HCABrowser` queries under construction.

```
hcabrowser <- HCABrowser::HCABrowser()

res <- hcabrowser %>% filter(
    library_construction_approach.ontology == "EFO:0008931" &
    paired_end == True &
    specimen_from_organism_json.biomaterial_core.ncbi_taxon_id == 9606
)

(bundle_fqids <- res %>% pullBundles)
```

Alternatively, we can provide our own bundle identifiers as a character
vector:

```
bundle_fqids <-
    c("ffd3bc7b-8f3b-4f97-aa2a-78f9bac93775.2019-05-14T122736.345000Z",
    "f69b288c-fabc-4ac8-b50c-7abcae3731bc.2019-05-14T120110.781000Z",
    "f8ba80a9-71b1-4c15-bcfc-c05a50660898.2019-05-14T122536.545000Z",
    "fd202a54-7085-406d-a92a-aad6dd2d3ef0.2019-05-14T121656.910000Z",
    "fffe55c1-18ed-401b-aa9a-6f64d0b93fec.2019-05-17T233932.932000Z")
```

# 3 Downloading HCA expression matrix data

First, we create an HCA Matrix API object with the use of the `HCAMatrix`
function:

```
hca <- HCAMatrix()
```

## 3.1 v0 Service (legacy)

By default, the `loadHCAMatrix` function from `HCAMatrixBrowser` uses
the loom format as output. See the ‘Supported formats’ section below
for more details.

* format: [loom](http://loompy.org/)

```
(lex <- loadHCAMatrix(hca, bundle_fqids = bundle_fqids,
    format = "loom"))
```

```
## class: LoomExperiment
## dim: 58347 5
## metadata(0):
## assays(1): matrix
## rownames: NULL
## rowData names(9): Accession Gene ... genus_species isgene
## colnames(5): 3c2180aa-0aa4-411f-98dc-73ef87b447ed
##   ceae7e4d-6871-4d47-b2af-f3c9a5b3f5db
##   1cfe9423-21d1-4281-9f9d-3aaa07b8e1e8
##   a2a2f604-444c-41b1-befa-25cf7461bf74
##   1c2e0012-28f1-4466-92c7-d11ba756c89b
## colData names(38): CellID barcode ...
##   specimen_from_organism.provenance.document_id total_umis
## rowGraphs(0): NULL
## colGraphs(0): NULL
```

* Column annotations (`colnames`): “CellID”

```
head(colnames(lex))
```

```
## [1] "3c2180aa-0aa4-411f-98dc-73ef87b447ed"
## [2] "ceae7e4d-6871-4d47-b2af-f3c9a5b3f5db"
## [3] "1cfe9423-21d1-4281-9f9d-3aaa07b8e1e8"
## [4] "a2a2f604-444c-41b1-befa-25cf7461bf74"
## [5] "1c2e0012-28f1-4466-92c7-d11ba756c89b"
```

## 3.2 v1 Service

The newer v1 matrix service allows users to apply filters to the matrix
requests. This is convenient for narrowing down the data to a set of
features.

Filters can be created using the API object and the filter function:

```
hca1 <- filter(hca, bundle_uuid == "ffd3bc7b-8f3b-4f97-aa2a-78f9bac93775")
```

We can have a look at the created filters using the `filters` function on
the API object:

```
filters(hca1)
```

```
## $op
## [x] "="
##
## $field
## [1] "bundle_uuid"
##
## $value
## [1] "ffd3bc7b-8f3b-4f97-aa2a-78f9bac93775"
```

To request the download, we can use the `loadHCAMatrix` function as well:

*Note*. Now the bundle\_fqids argument is left empty.

```
loadHCAMatrix(hca1, format = "loom")
```

```
## class: LoomExperiment
## dim: 58347 1
## metadata(0):
## assays(1): matrix
## rownames: NULL
## rowData names(9): Accession Gene ... genus_species isgene
## colnames(1): 3c2180aa-0aa4-411f-98dc-73ef87b447ed
## colData names(44): CellID analysis_protocol.protocol_core.protocol_id
##   ... specimen_from_organism.provenance.document_id total_umis
## rowGraphs(0): NULL
## colGraphs(0): NULL
```

### 3.2.1 Supported formats

The matrix service allows you to request three different file formats:

1. loom (default)
2. mtx
3. csv

These can be requested by changing the `format` argument in the `loadHCAMatrix`
function. For more details, see our “Generating HCAMatrix queries with the API”
vignette.

## 3.3 `filter` operations

Recent changes to the `HCAMatrixBrowser` package, allow us to make use
of the built-in API functionality. We can use one or more filters to
specify a particular query in the HCAMatrix API.

In this example, we use the existing `bundle_fqids` character vector
to generate a filter and apply it to the API class object (`hca`).

```
hca2 <- filter(hca, dss_bundle_fqid %in% bundle_fqids)
```

### 3.3.1 `filters`

We use the `filters` function to get a view of the applied filters.

```
filters(hca2)
```

```
## $op
## [x] "in"
##
## $field
## [1] "dss_bundle_fqid"
##
## $value
## [1] "ffd3bc7b-8f3b-4f97-aa2a-78f9bac93775.2019-05-14T122736.345000Z"
## [2] "f69b288c-fabc-4ac8-b50c-7abcae3731bc.2019-05-14T120110.781000Z"
## [3] "f8ba80a9-71b1-4c15-bcfc-c05a50660898.2019-05-14T122536.545000Z"
## [4] "fd202a54-7085-406d-a92a-aad6dd2d3ef0.2019-05-14T121656.910000Z"
## [5] "fffe55c1-18ed-401b-aa9a-6f64d0b93fec.2019-05-17T233932.932000Z"
```

For more information on filters, see the `HCAMatrix` vignette titled
‘Generating HCAMatrix queries with the API’.

### 3.3.2 Sending the query

Once we have prepared the appropriate filters, we can send the query
off to the HCA Matrix Service to get generate a response.

**Note**. We don’t need to do much more than supplying the HCA API object
and a particular data format (default is `loom`).

```
loadHCAMatrix(hca2)
```

```
## class: LoomExperiment
## dim: 58347 5
## metadata(0):
## assays(1): matrix
## rownames: NULL
## rowData names(9): Accession Gene ... genus_species isgene
## colnames(5): 3c2180aa-0aa4-411f-98dc-73ef87b447ed
##   ceae7e4d-6871-4d47-b2af-f3c9a5b3f5db
##   1cfe9423-21d1-4281-9f9d-3aaa07b8e1e8
##   a2a2f604-444c-41b1-befa-25cf7461bf74
##   1c2e0012-28f1-4466-92c7-d11ba756c89b
## colData names(38): CellID barcode ...
##   specimen_from_organism.provenance.document_id total_umis
## rowGraphs(0): NULL
## colGraphs(0): NULL
```