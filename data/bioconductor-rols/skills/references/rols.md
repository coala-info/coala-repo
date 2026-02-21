# An R interface to the Ontology Lookup Service

Laurent Gatto1

1https://lgatto.github.io/about/

#### 11 December 2025

#### Abstract

How to query the Ontology Lookup Service directly from R and how to create and parse controlled vocabulary.

#### Package

rols 3.6.1

# 1 Introduction

## 1.1 Installation

*[rols](https://bioconductor.org/packages/3.22/rols)* is a Bioconductor package and should hence be
installed using the dedicated functionality

```
## try http:// if https:// URLs are not supported
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("rols")
```

## 1.2 Getting help

To get help, either post your question on the [Bioconductor support
site](https://support.bioconductor.org/) or open an issue on the `r Biocpkg("rols")` [github page](https://github.com/lgatto/rols/issues).

## 1.3 The resource

The [Ontology Lookup Service](http://www.ebi.ac.uk/ontology-lookup/)
(OLS)
[[1](http://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-7-97),
[2](http://nar.oxfordjournals.org/content/36/suppl_2/W372)] is
originally spin-off of the [PRoteomics
IDEntifications](http://www.ebi.ac.uk/pride/archive/) database (PRIDE)
service, located at the EBI, and is now developed and maintained by
the [Samples, Phenotypes and
Ontologies](http://www.ebi.ac.uk/about/spot-team) team at EMBL-EBI.

## 1.4 The package

The OLS provides a REST interface to hundreds of ontologies from a
single location with a unified output format. The *[rols](https://bioconductor.org/packages/3.22/rols)*
package make this possible from within R. Do do so, it relies on the
*[httr2](https://CRAN.R-project.org/package%3Dhttr2)* package to query the REST interface, and access
and retrieve data.

There are 279 ontologies available in the OLS, listed in the
table below. Their name is to be use to defined which ontology to
query.

# 2 A Brief rols overview

The *[rols](https://bioconductor.org/packages/3.22/rols)* package is build around a few classes that
enable to query the OLS and retrieve, store and manipulate data. Each
of these classes are described in more details in their respective
manual pages. We start by loading the package.

```
library("rols")
```

## 2.1 Ontologies

The `Ontology` and `Ontologies` classes can store information about
single of multiple ontologies. The latter can be easily subset using
`[` and `[[`, as one would for lists.

```
ol <- olsOntologies()
```

```
## ⠙ iterating 4 done (1.8/s) | 2.2s
```

```
## ⠹ iterating 8 done (1.7/s) | 4.7s
```

```
## ⠸ iterating 13 done (1.7/s) | 7.7s
```

```
## ⠸ iterating 14 done (1.7/s) | 8.4s
```

```
ol
```

```
## Object of class 'olsOntologies' with 279 entries
##    ADO, AfPO ... NULL, NULL
```

```
head(olsNamespace(ol))
```

```
## [1] "ado"   "afpo"  "agro"  "aism"  "amphx" "apo"
```

```
ol[["bspo"]]
```

```
## olsOntology: Biological Spatial Ontology (bspo)
##   An ontology for respresenting spatial concepts, anatomical axes,
##   gradients, regions, planes, sides and surfaces. These concepts can be
##   used at multiple biological scales and in a diversity of taxa,
##   including plants, animals and fungi. The BSPO is used to provide a
##   source of anatomical location descriptors for logically defining
##   anatomical entity classes in anatomy ontologies.
##    Loaded: 2025-12-10 Updated: 2025-12-10 Version: 2023-05-27
##    169 terms  236 properties  18 individuals
```

It is also possible to initialise a single ontology

```
bspo <- olsOntology("bspo")
bspo
```

```
## olsOntology: Biological Spatial Ontology (bspo)
##   An ontology for respresenting spatial concepts, anatomical axes,
##   gradients, regions, planes, sides and surfaces. These concepts can be
##   used at multiple biological scales and in a diversity of taxa,
##   including plants, animals and fungi. The BSPO is used to provide a
##   source of anatomical location descriptors for logically defining
##   anatomical entity classes in anatomy ontologies.
##    Loaded: 2025-12-10 Updated: 2025-12-10 Version: 2023-05-27
##    169 terms  236 properties  18 individuals
```

## 2.2 Terms

Single ontology terms are stored in `olsTerm` objects. When more terms
need to be manipulated, they are stored as `olsTerms` objects. It is easy
to obtain all terms of an ontology of interest, and the resulting
`olsTerms` object can be subset using `[` and `[[`, as one would for
lists.

```
bspotrms <- olsTerms(bspo) ## or olsTerms("bspo")
```

```
## ⠙ iterating 1 done (0.43/s) | 2.3s
```

```
bspotrms
```

```
## Object of class 'olsTerms' with 169 entries
##  From the BSPO ontology
##   BFO:0000002, BFO:0000003 ... IAO:0000409, PATO:0000001
```

```
bspotrms[1:10]
```

```
## Object of class 'olsTerms' with 10 entries
##  From the BSPO ontology
##   BFO:0000002, BFO:0000003 ... BFO:0000023, BFO:0000031
```

```
bspotrms[["BSPO:0000092"]]
```

```
## A olsTerm from the BSPO ontology: BSPO:0000092
##  Label: anatomical compartment boundary
##   to be merged into CARO
```

It is also possible to initialise a single term

```
trm <- olsTerm(bspo, "BSPO:0000092")
termId(trm)
```

```
## [1] "BSPO:0000092"
```

```
termLabel(trm)
```

```
## [1] "anatomical compartment boundary"
```

It is then possible to extract the `ancestors`, `descendants`,
`parents` and `children` terms. Each of these functions return a
`olsTerms` object

```
parents(trm)
```

```
## Object of class 'olsTerms' with 1 entries
##  From the BSPO ontology
## CARO:0000010
```

```
children(trm)
```

```
## Object of class 'olsTerms' with 6 entries
##  From the BSPO ontology
##   BSPO:0000094, BSPO:0000093 ... BSPO:0000041, BSPO:0000040
```

Finally, a single term or terms object can be coerced to a
`data.frame` using `as(x, "data.frame")`.

## 2.3 Properties

Properties (relationships) of single or multiple terms or complete
ontologies can be queries with the `properties` method, as briefly
illustrated below.

```
trm <- olsTerm("uberon", "UBERON:0002107")
trm
```

```
## A olsTerm from the UBERON ontology: UBERON:0002107
##  Label: liver
##   An exocrine gland which secretes bile and functions in metabolism of
##   protein and carbohydrate and fat, synthesizes substances involved in
##   the clotting of the blood, synthesizes vitamin A, detoxifies poisonous
##   substances, stores glycogen, and breaks down worn-out erythrocytes[GO].
```

```
p <- olsProperties(trm)
p
```

```
## Object of class 'olsProperties' with 164 entries
##  From the UBERON ontology
##   endocrine system, digestive system ... quadrate lobe of liver, hepatic portal fibroblast
```

```
p[[1]]
```

```
## A olsProperty from the UBERON ontology: UBERON:0000949
##  Label: endocrine system
```

```
termLabel(p[[1]])
```

```
## [1] "endocrine system"
```

# 3 Use case

A researcher might be interested in the trans-Golgi network. Searching
the OLS is assured by the `OlsSearch` and `olsSearch`
classes/functions. The first step is to defined the search query with
`OlsSearch`, as shown below. This creates an search object of class
`OlsSearch` that stores the query and its parameters. In records the
number of requested results (default is 20) and the total number of
possible results (there are 21493 results across all
ontologies, in this case). At this stage, the results have not yet
been downloaded, as shown by the 0 responses.

```
OlsSearch(q = "trans-golgi network")
```

```
## Object of class 'OlsSearch':
##   query: trans-golgi network
##   requested: 20 (out of 21493)
##   response(s): 0
```

21493 results are probably too many to be
relevant. Below we show how to perform an exact search by setting
`exact = TRUE`, and limiting the search the the GO ontology by
specifying `ontology = "GO"`, or doing both.

```
OlsSearch(q = "trans-golgi network", exact = TRUE)
```

```
## Object of class 'OlsSearch':
##   query: trans-golgi network
##   requested: 20 (out of 258)
##   response(s): 0
```

```
OlsSearch(q = "trans-golgi network", ontology = "GO")
```

```
## Object of class 'OlsSearch':
##   ontolgy: GO
##   query: trans-golgi network
##   requested: 20 (out of 1086)
##   response(s): 0
```

```
OlsSearch(q = "trans-golgi network", ontology = "GO", exact = TRUE)
```

```
## Object of class 'OlsSearch':
##   ontolgy: GO
##   query: trans-golgi network
##   requested: 20 (out of 29)
##   response(s): 0
```

One case set the `rows` argument to set the number of desired results.

```
OlsSearch(q = "trans-golgi network", ontology = "GO", rows = 200)
```

```
## Object of class 'OlsSearch':
##   ontolgy: GO
##   query: trans-golgi network
##   requested: 200 (out of 1086)
##   response(s): 0
```

See `?OlsSearch` for details about retrieving many results.

Let’s proceed with the exact search and retrieve the results. Even if
we request the default 20 results, only the 258 relevant
result will be retrieved. The `olsSearch` function updates the
previously created object (called `qry` below) by adding the results
to it.

```
qry <- OlsSearch(q = "trans-golgi network", exact = TRUE)
(qry <- olsSearch(qry))
```

```
## Object of class 'OlsSearch':
##   query: trans-golgi network
##   requested: 20 (out of 258)
##   response(s): 20
```

We can now transform this search result object into a fully fledged
`olsTerms` object or a `data.frame`.

```
(qtrms <- as(qry, "olsTerms"))
```

```
## Warning in asMethod(object): 11 term failed to be instantiated.
```

```
## Object of class 'olsTerms' with 9 entries
##  From  7 ontologies
##   GO:0005802, NCIT:C33802 ... GO:0160282, GO:0032588
```

```
str(qdrf <- as(qry, "data.frame"))
```

```
## 'data.frame':    20 obs. of  8 variables:
##  $ iri            : chr  "http://purl.obolibrary.org/obo/GO_0005802" "http://purl.obolibrary.org/obo/NCIT_C33802" "http://purl.obolibrary.org/obo/OMIT_0020822" "http://id.nlm.nih.gov/mesh/D021601" ...
##  $ ontology_name  : chr  "go" "ncit" "omit" "mesh" ...
##  $ ontology_prefix: chr  "GO" "NCIT" "OMIT" "mesh" ...
##  $ short_form     : chr  "GO_0005802" "NCIT_C33802" "OMIT_0020822" "mesh_D021601" ...
##  $ description    :List of 20
##   ..$ : chr  "The network of interconnected tubular and cisternal structures located within the Golgi apparatus on the side d"| __truncated__ "There are different opinions about whether the TGN should be considered part of the Golgi apparatus or not. We "| __truncated__
##   ..$ : chr "A network of membrane components where vesicles bud off the Golgi apparatus to bring proteins, membranes and ot"| __truncated__
##   ..$ : chr
##   ..$ : chr "A network of membrane compartments, located at the cytoplasmic side of the GOLGI APPARATUS, where proteins and "| __truncated__
##   ..$ : chr  "The network of interconnected tubular and cisternal structures located within the Golgi apparatus on the side d"| __truncated__ "There are different opinions about whether the TGN should be considered part of the Golgi apparatus or not.  We"| __truncated__
##   ..$ : chr  "The network of interconnected tubular and cisternal structures located within the Golgi apparatus on the side d"| __truncated__ "There are different opinions about whether the TGN should be considered part of the Golgi apparatus or not. We "| __truncated__
##   ..$ : chr
##   ..$ : chr "The network of interconnected tubular and cisternal structures located within the Golgi apparatus on the side d"| __truncated__
##   ..$ : chr "The network of interconnected tubular and cisternal structures located within the Golgi apparatus on the side d"| __truncated__
##   ..$ : chr "The network of interconnected tubular and cisternal structures located within the Golgi apparatus on the side d"| __truncated__
##   ..$ : chr "The network of interconnected tubular and cisternal structures located within the Golgi apparatus on the side d"| __truncated__
##   ..$ : chr  "A trans-Golgi network integral membrane protein 2 that is encoded in the genome of human." "Category=organism-gene."
##   ..$ : chr "The membrane leaflet of the trans-Golgi network membrane that faces the Golgi lumen."
##   ..$ : chr "The lipid bilayer surrounding any of the compartments that make up the trans-Golgi network."
##   ..$ : chr "trans-golgi network protein 2"
##   ..$ : chr
##   ..$ : chr
##   ..$ : chr
##   ..$ : chr "trans-golgi network vesicle protein 23 homolog C"
##   ..$ : chr "trans-golgi network vesicle protein 23 homolog A"
##  $ label          : chr  "trans-Golgi network" "Trans-Golgi Network" "trans-Golgi Network" "trans-Golgi Network" ...
##  $ obo_id         : chr  "GO:0005802" "NCIT:C33802" "OMIT:0020822" "mesh:D021601" ...
##  $ type           : chr  "class" "class" "class" "class" ...
```

In this case, we can see that we actually retrieve the same term used
across different ontologies. In such cases, it might be useful to keep
only non-redundant term instances. Here, this would have been
equivalent to searching the go, ncit, omit, pr, go, go ontology

```
qtrms <- unique(qtrms)
termOntology(qtrms)
```

```
##   GO:0005802  NCIT:C33802 OMIT:0020822    PR:O43493   GO:0160282   GO:0032588
##         "go"       "ncit"       "omit"         "pr"         "go"         "go"
```

```
termNamespace(qtrms)
```

```
## $`GO:0005802`
## [1] "cellular_component"
##
## $`NCIT:C33802`
## NULL
##
## $`OMIT:0020822`
## NULL
##
## $`PR:O43493`
## [1] "protein"
##
## $`GO:0160282`
## [1] "cellular_component"
##
## $`GO:0032588`
## [1] "cellular_component"
```

Below, we execute the same query using the *[GO.db](https://bioconductor.org/packages/3.22/GO.db)* package.

```
library("GO.db")
GOTERM[["GO:0005802"]]
```

```
## GOID: GO:0005802
## Term: trans-Golgi network
## Ontology: CC
## Definition: The network of interconnected tubular and cisternal
##     structures located within the Golgi apparatus on the side distal to
##     the endoplasmic reticulum, from which secretory vesicles emerge.
##     The trans-Golgi network is important in the later stages of protein
##     secretion where it is thought to play a key role in the sorting and
##     targeting of secreted proteins to the correct destination.
## Synonym: TGN
## Synonym: trans Golgi network
## Synonym: Golgi trans face
## Synonym: Golgi trans-face
## Synonym: late Golgi
## Synonym: maturing face
## Synonym: trans face
```

# 4 On-line vs. off-line data

It is possible to observe different results with *[rols](https://bioconductor.org/packages/3.22/rols)*
and *[GO.db](https://bioconductor.org/packages/3.22/GO.db)*, as a result of the different ways they
access the data. *[rols](https://bioconductor.org/packages/3.22/rols)* or *[biomaRt](https://bioconductor.org/packages/3.22/biomaRt)*
perform direct online queries, while *[GO.db](https://bioconductor.org/packages/3.22/GO.db)* and other
annotation packages use database snapshot that are updated every
release.

Both approaches have advantages. While online queries allow to obtain
the latest up-to-date information, such approaches rely on network
availability and quality. If reproducibility is a major issue, the
version of the database to be queried can easily be controlled with
off-line approaches. In the case of *[rols](https://bioconductor.org/packages/3.22/rols)*, although the
load date of a specific ontology can be queried with `olsVersion`, it
is not possible to query a specific version of an ontology.

# 5 Changes

## 5.1 Version 2.0

*[rols](https://bioconductor.org/packages/3.22/rols)* 2.0 has substantially changed. While the table
below shows some correspondence between the old and new interface,
this is not always the case. The new interface relies on the
`Ontology`/`Ontologies`, `olsTerm`/`olsTerms` and `OlsSearch` classes, that
need to be instantiated and can then be queried, as described above.

| version < 1.99 | version >= 1.99 |
| --- | --- |
| `ontologyLoadDate` | `olsLoaded` and `olsUpdated` |
| `ontologyNames` | `Ontologies` |
| `olsVersion` | `olsVersion` |
| `allIds` | `terms` |
| `isIdObsolete` | `isObsolete` |
| `rootId` | `olsRoot` |
| `olsQuery` | `OlsSearch` and `olsSearch` |

Not all functionality is currently available. If there is anything
that you need but not available in the new version, please contact the
maintained by opening an
[issue](https://github.com/lgatto/rols/issues) on the package
development site.

# 6 Version 2.99

* `rols` version >= 2.99 has been refactored to use the OLS4 REST API.
* REST queries now use [httr2](https://httr2.r-lib.org/) instead of
  superseded `httr`.
* The term(s) constructors are capitalised as `olsTerm()` and
  `olsTerms()`.
* The properties constructor is capitalised as `Properties()`.
* Some class definitions have been updated to accomodate changes in
  the data received by OLS. Some function have been dropped.
* The `Ontology` and `Ontologies` classes and constructors have been
  renames `olsOntology` and `olsOntologies` to avoid clashes with
  `AnnontationDbi::Ontology()`.
* The `Term` and `Terms` classes and constructors have been renames
  `olsTerm` and `olsTerms` to avoid clashes with
  `AnnontationDbi::Term()`.

# 7 CVParams

The `CVParam` class is used to handle controlled vocabulary. It can be
used for user-defined parameters

```
CVParam(name = "A user param", value = "the value")
```

```
## [, , A user param, the value]
```

or official controlled vocabulary (which triggers a query to the OLS
service)

```
CVParam(label = "GO", accession = "GO:0035145")
```

```
## [GO, GO:0035145, exon-exon junction complex, ]
```

See `?CVParam` for more details and examples.

# 8 Session information

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] DT_0.34.0            rols_3.6.1           GO.db_3.22.0
##  [4] AnnotationDbi_1.72.0 IRanges_2.44.0       S4Vectors_0.48.0
##  [7] Biobase_2.70.0       BiocGenerics_0.56.0  generics_0.1.4
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3      sass_0.4.10         RSQLite_2.4.5
##  [4] digest_0.6.39       magrittr_2.0.4      evaluate_1.0.5
##  [7] bookdown_0.46       fastmap_1.2.0       blob_1.2.4
## [10] jsonlite_2.0.0      DBI_1.2.3           BiocManager_1.30.27
## [13] httr_1.4.7          crosstalk_1.2.2     Biostrings_2.78.0
## [16] httr2_1.2.2         jquerylib_0.1.4     cli_3.6.5
## [19] rlang_1.1.6         crayon_1.5.3        XVector_0.50.0
## [22] bit64_4.6.0-1       withr_3.0.2         cachem_1.1.0
## [25] yaml_2.3.12         otel_0.2.0          tools_4.5.2
## [28] memoise_2.0.1       curl_7.0.0          vctrs_0.6.5
## [31] R6_2.6.1            png_0.1-8           lifecycle_1.0.4
## [34] KEGGREST_1.50.0     Seqinfo_1.0.0       htmlwidgets_1.6.4
## [37] bit_4.6.0           pkgconfig_2.0.3     bslib_0.9.0
## [40] glue_1.8.0          xfun_0.54           knitr_1.50
## [43] htmltools_0.5.9     rmarkdown_2.30      compiler_4.5.2
```