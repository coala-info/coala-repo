# ssrch: selectize-based search engine for corpora of modest size

Vincent J. Carey, stvjc at channing.harvard.edu

#### October 30, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Illustration](#illustration)
  + [2.1 Diversity of field names](#diversity-of-field-names)
  + [2.2 Managing tokenized metadata](#managing-tokenized-metadata)
  + [2.3 Querying the corpus](#querying-the-corpus)
* [3 A prototypical app](#a-prototypical-app)
* [4 Further work](#further-work)

# 1 Introduction

Metadata are crucial to all forms of statistical analysis.
Metadata are used to define formal steps of
upstream data preprocessing, to annotate outcomes and covariates,
and to interpret inferential results.

The ssrch package was developed to provide a lightweight
approach to searching a metadata corpus with R. There are three
basic steps:

* tokenize corpus elements syntactically,
* filter tokens into hashed environments,
* use selectize.js to achieve a predictive, autocompleted search interface.

We illustrate the system using a collection of tables of metadata
about cancer transcriptomics.

# 2 Illustration

To provide a sense of what is at stake, we work with 68 CSV files
derived from the NCBI Sequence Read Archive metadata.
The files consist of contents of the `sample.attribute` subtable of study metadata
retrieved using the SRAdbV2 package at github.com:seandavi/SRAdbV2.
The CSV files
are lodged in a zip file
`canc68.zip` with the `ssrch` package in `inst/cancer_corpus`.

The CSV files have been indexed in an S4 object of class
`DocSet`.

```
data(docset_cancer68)
docset_cancer68
```

```
## ssrch DocSet resource:
##  68 documents, 9934 records
## some titles:
##   Single cell analysis of lung adenocarcinoma cell lines ... (DRP001358)
##   Single cell analysis of lung adenocarcinoma cell lines ... (DRP002586)
##   Integrative systematic analyses of mutational and trans... (ERP010142)
##   Identification_and_molecular_charaterization_of_new_tum... (ERP012527)
##   Whole transcriptome profiling of Esophageal adenocarcin... (ERP013206)
##   Transcriptional landscape of human tissue lymphocytes u... (ERP013260)
```

A single document can be retrieved with the `retrieve_doc`
function, given the study accession number.

```
retrieve_doc("ERP010142", docset_cancer68)[1:3,1:5]
```

```
##   X study.accession experiment.accession    Bcl.2 Colletion.date
## 1 1       ERP010142            ERX943467 Negative     2001-10-10
## 2 2       ERP010142            ERX943327 Positive     2005-12-23
## 3 3       ERP010142            ERX943378 Negative     2001-07-11
```

## 2.1 Diversity of field names

There is partial standardization of field names in this corpus,
but there is considerable variation among studies in the number
and types of fields used.

```
docids = ls(envir=docs2kw(docset_cancer68))
allc = lapply(docids,
   function(x) try(retrieve_doc(x, docset_cancer68)))
summary(sapply(allc,ncol))
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   4.000   6.000   8.000   9.221  10.000  25.000
```

```
lapply(allc[c(11,55)], names)
```

```
## [[1]]
##  [1] "X"                     "study.accession"       "experiment.accession"
##  [4] "source_name"           "tissue"                "tissue.archive.method"
##  [7] "cell.line"             "cell.type"             "development.stage"
## [10] "disease.status"
##
## [[2]]
## [1] "X"                    "study.accession"      "experiment.accession"
## [4] "source_name"          "tissue"               "cell.type"
## [7] "cell.activation"      "cell.category"        "barcode"
```

The `ssrch` package provides
tools for identifying studies in which a given
field is used, and in which given values are recorded.

A motivating example is determining what studies involve
measurements on normal tissue adjacent to tumor. In
our collection, this can be assessed via:

```
library(ssrch)
searchDocs("Adjacent", docset_cancer68, ignore.case=TRUE)
```

```
##                     hits      docs
## 1               Adjacent SRP056696
## 2               Adjacent SRP111343
## 3 Adjacent Normal tissue SRP056696
## 4        Adjacent normal SRP111343
## 5               adjacent SRP069212
## 6               adjacent SRP073447
## 7        adjacent normal SRP069212
## 8        adjacent normal SRP073447
## 9        benign_adjacent SRP011439
```

## 2.2 Managing tokenized metadata

Before getting into the details of search engine
construction, we review some high-level concepts and methods.

First, we have the container for managing our search resource.

```
getClass(class(docset_cancer68))
```

```
## Class "DocSet" [package "ssrch"]
##
## Slots:
##
## Name:        kw2docs     docs2recs       docs2kw        titles          urls
## Class:   environment   environment   environment     character     character
##
## Name:  doc_retriever
## Class:      function
```

`docset_cancer68` is the result of using the `ssrch` function `parseDoc`
in conjunction with the CSV files zipped in `ssrch/inst/cancer_corpus`.
It is an S4 class instance that manages environments mapping
from keywords to documents, documents to records, documents to keywords,

Furthermore, `DocSet` instances can have a component that
retrieves parsed documents from the corpus.

## 2.3 Querying the corpus

We’ll search for the phrase `Non Small Cell` with an optional hyphen,
ignoring character case of possible hits, including as well
the abbreviation for Non-small cell lung cancer.

```
NSChits = searchDocs("Non.Small Cell|NSCLC$", docset_cancer68, ignore.case=TRUE)
NSChits
```

```
##                                 hits      docs
## 1                              NSCLC SRP093349
## 2         Non Small Cell Lung Cancer ERP013260
## 3 Non-Small Cell Lung Cancer (NSCLC) SRP107198
```

Three studies, three different patterns matched by the query string.
We can use `retrieve_doc` to look at the contents
of the metadata tables for these studies.

```
NSCdocs = lapply(unique(NSChits$docs),
   function(x) retrieve_doc(x, docset_cancer68))
names(NSCdocs) = NSChits$docs
datatable(NSCdocs[[1]], options=list(lengthMenu=c(3,5,10)))
```

```
datatable(NSCdocs[[2]], options=list(lengthMenu=c(3,5,10)))
```

```
datatable(NSCdocs[[3]], options=list(lengthMenu=c(3,5,10)))
```

# 3 A prototypical app

The `ctxsearch` function starts a shiny app that
provides access to full attribute data via a selectize
input that uses all tokens in the corpus (filtered).

![](data:image/png;base64...)

ctxsearch illustration

# 4 Further work

The tab set should be prunable.

This will be the basis of an interactive interface to the
human transcriptome compendium