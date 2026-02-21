# Find Data on CGC via Data Browser and Datasets API

#### 2025-10-30

# 1 Introdution

There are currently three ways to find the data you need on CGC:

* Most easy: use our powerful and pretty GUI called ‘data explorer’ interactively on the platform, please read the tutorial [here](http://docs.cancergenomicscloud.org/docs/about-the-data-browser).
* Most advanced: for advanced user, please SPARQL query directly [tutorial](http://docs.cancergenomicscloud.org/docs/query-via-sparql).
* Most sweet: use CGC Datasets API, by creating a query list in R (comming soon).

# 2 Graphical Data Browser

Please read the tutorial [here](http://docs.cancergenomicscloud.org/docs/about-the-data-browser).

# 3 Datasets API

Please read the [tutorials](http://docs.cancergenomicscloud.org/docs/datasets-api-overview) first.

## 3.1 Browse TCGA via the Datasets API

Doing a HTTP `GET` on this endpoint one will get a resource with links to all entities in the dataset. Following these links (doing an HTTP `GET` on them) one will go to a list of entities (for example `/files`) from TCGA dataset identified with their proper URL. Further following one of these links you’ll get a particular resource (if we went to `/files`, we’ll get a description of a particular file) with all specific properties like id, label, etc. and links to other entities that are connected to a specific resource (for example `/cases`) that you can explore further. From there on, the process repeats as long as you follow the links.

### 3.1.1 Return datasets accessible trough the CGC

Create an Auth object with your token, make sure you are using the correct URL.

* `https://cgc-datasets-api.sbgenomics.com/`

use `Auth$api()` method so there is no need to type base URL or token again.

```
library("sevenbridges")
# create an Auth object
a <- Auth(
  url = "https://cgc-datasets-api.sbgenomics.com/",
  token = "your_cgc_token"
)
a$api(path = "datasets")
```

### 3.1.2 Return list of all TCGA entities

You can issue another `GET` request to the href of the tcga object, if you want to access TCGA data.

```
a <- Auth(
  url = "https://cgc-datasets-api.sbgenomics.com/datasets/tcga/v0",
  token = "your_cgc_token"
)
(res <- a$api()) # default method is GET
# list all resources/entities
names(res$"_links")
```

### 3.1.3 Interpreting the list of all entities

For example, to see a list of all TCGA files, send the request:

```
(res <- a$api(path = "files"))
```

For example, to see the **metadata schema** for files send the request:

```
a$api(path = "files/schema")
```

### 3.1.4 Copy files to you project

Get file id from Datasets API, then use public API to copy files. Make sure your project is “TCGA” compatible, otherwise if you are trying to copy controlled access data to your non-TCGA project, you will get

```
"HTTP Status 403: Insufficient privileges to access the requested file."
```

```
(res <- a$api(path = "files"))

get_id <- function(obj) sapply(obj$"_embedded"$files, function(x) x$id)
ids <- get_id(res)

# create CGC auth
a_cgc <- Auth(platform = "cgc", token = a$token)
a_cgc$copyFile(id = ids, project = "RFranklin/tcga-demo")
```

## 3.2 Post with query

endpoint user can filter collection resources by using a DSL in JSON format that translates as a subset of SPARQL. Main advantage here is that an end user gets the subset SPARQL expressiveness without the need to learn SPARQL specification.

### 3.2.1 Find samples connected to a case

```
body <- list(
  entity = "samples",
  hasCase = "0004D251-3F70-4395-B175-C94C2F5B1B81"
)
a$api(path = "query", body = body, method = "POST")
```

Count samples connected to a case

```
a$api(path = "query/total", body = body, method = "POST")
```

Issuing a `GET` request to the href path will return the following data:

Note: `api` function is a light layer of httr package, it’s different from `Auth$api` call.

```
httr::content(
  api(
    token = a$token,
    base_url = "https://cgc-datasets-api.sbgenomics.com/datasets/tcga/v0/samples/9259E9EE-7279-4B62-8512-509CB705029C"
  )
)
```

### 3.2.2 Find cases with given age at diagnosis

Suppose you want to see all cases for which the age at diagnosis is between 10 and 50. Then, you use the following query.

Note that the value of the metadata field hasAgeAtDiagnosis is a dictionary containing the keyfilter, whose value is a further dictionary with keysgt(greater than) and lt (less than) for the upper and lower bounds to filter by.

```
body <- list(
  "entity" = "cases",
  "hasAgeAtDiagnosis" = list(
    "filter" = list(
      "gt" = 10,
      "lt" = 50
    )
  )
)
a$api(path = "query", body = body, method = "POST")
```

### 3.2.3 Find cases with a given age at diagnosis and disease

Suppose you want to see all cases that, as in the example, ([Find cases with given age at diagnosis](#find-cases-with-given-age-at-diagnosis))(doc:find-all-cases-with-a-given-age-at-diagnosis), have an age at diagnosis of between 10 and 50, but that also have the disease “Kidney Chromophobe”. Then, use the following query:

```
body <- list(
  "entity" = "cases",
  "hasAgeAtDiagnosis" = list(
    "filter" = list(
      "gt" = 10,
      "lt" = 50
    )
  ),
  "hasDiseaseType" = "Kidney Chromophobe"
)
a$api(path = "query", body = body, method = "POST")
```

### 3.2.4 Complex example for filtering TCGA data

```
body <- list(
  "entity" = "cases",
  "hasSample" = list(
    "hasSampleType" = "Primary Tumor",
    "hasPortion" = list(
      "hasPortionNumber" = 11
    )
  ),
  "hasNewTumorEvent" = list(
    "hasNewTumorAnatomicSite" = c("Liver", "Pancreas"),
    "hasNewTumorEventType" = list(
      "filter" = list(
        "contains" = "Recurrence"
      )
    )
  )
)
a$api(path = "query", body = body, method = "POST")
```

Issuing a `GET` request to the href path

```
httr::content(
  api(
    token = a$token,
    base_url = "https://cgc-datasets-api.sbgenomics.com/datasets/tcga/v0/cases/0004D251-3F70-4395-B175-C94C2F5B1B81"
  )
)
```

### 3.2.5 Query with multiple filters on a case

```
get_id <- function(obj) sapply(obj$"_embedded"$files, function(x) x$id)
names(res)

body <- list(
  "entity" = "cases",
  "hasSample" = list(
    "hasSampleType" = "Primary Tumor",
    "hasPortion" = list(
      "hasPortionNumber" = 11,
      "hasID" = "TCGA-DD-AAVP-01A-11"
    )
  ),
  "hasNewTumorEvent" = list(
    "hasNewTumorAnatomicSite" = "Liver",
    "hasNewTumorEventType" = "Intrahepatic Recurrence"
  )
)

(res <- a$api(path = "files", body = body))
get_id(res)
```