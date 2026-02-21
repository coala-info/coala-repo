# pogos – PharmacOGenomics Ontology Support

Vincent J. Carey, stvjc at channing.harvard.edu

#### October 30, 2025

# 1 Introduction

bhklab’s PharmacoDB unites multiple drug sensitivity databases.
A REST API is available and interfaces to some basic endpoints are
provided in this package. We also provide some basic
support for working with the Cell Line Ontology and ChEBI.

A basic purpose of this package is to support exploration of
the completeness and utility
of available ontologies for cell lines and drugs.
A relevant study of the possibility of “drug set
enrichment analysis” has been published
by [Napolitano and colleagues](https://www.ncbi.nlm.nih.gov/pubmed/26415724).

We note that detailed RESTful interrogation of many ontologies
is supported by the *[rols](https://bioconductor.org/packages/3.22/rols)* package. In the long
run we would like to make use of the EBI Ontology Lookup System
as a central resource of this package, but to develop concepts
at these early stages, static images of ontologies are employed.

# 2 Basic software design for pogos

This package attacks two problems: organization of data on
cell-line response to treatments by diverse compounds, and
communication with PharmacoDb.

## 2.1 Data structures for pharmacogenomics

This package provides two key data structures for managing pharmacogenomic
experimental results

* `DRTraceSet`: for a given dosage schedule for a given compound, manage the
  dose-response profiles for a number of cell lines.
  An example is

```
iric = iriCCLE()
iric
```

```
## DRTraceSet for 5 cell lines, drug Irinotecan, dataset CCLE
```

* `DRProfSet`: for a given cell line, provide the dose-response profiles for
  a number of compounds. Example:

```
drp = try(DRProfSet())
```

```
## Error in fromJSON(readBin(xx$content, what = "character")) :
##   not all data was parsed (0 chars were parsed out of a total of 106 chars)
```

```
if (!inherits(drp, "try-error"))
 drp
```

This may fail if pharmacdb.pmgenomics.ca is down.

The `plot` method reveals a basic motivation for `DRTraceSet`.

```
plot(iric)
```

![](data:image/png;base64...)

The plot method for DRProfSet has a complementary purpose.

```
if (!inherits(drp, "try-error"))
  plot(drp)
```

## 2.2 Interrogating PharmacoDb

The communications part of the package is somewhat
fragile, as changes to the upstream service at
Princess Margaret can lead to failures here.

The heart of the query facility is shown here,
unevaluated. The `datasetCodes` and `cellLineCodes`
are extracted from reference data that may itself
go out of date.

```
    xx = GET(sprintf("https://pharmacodb.pmgenomics.ca/api/v1/intersections/2/%d/%d?indent=true",
        cellLineCodes[cell_line], datasetCodes[dataset]))
    ans = fromJSON(readBin(xx$content, what = "character"))
    ans = lapply(ans, function(comb) {
        new("DRProfile", cell_line = cell_line, dataset = dataset,
            drug = comb$compound$name, drug_code = comb$compound$id,
            cell_line_code = comb$cell_line$id, doses = vapply(comb$dose_responses,
                function(x) x$dose, numeric(1)), responses = vapply(comb$dose_responses,
                function(x) x$response, numeric(1)))
    })
```

# 3 Some stored reference data

We precomputed tables for cell lines, compounds, and tissues.
These are available as DataFrame instances as
`cell_lines_v1`, `compounds_v1`, `datasets_v1`, and `tissues_v1`, in
the data element of the package.

Numerical ids are defined by the PharmacoDB.

## 3.1 Cell lines

## 3.2 Compounds

## 3.3 Datasets

## 3.4 Coverage of pharmacogenomic compound names by ChEBI

As an illustration of long-term intention of this package, consider
the following snapshot of a slice of ChEBI.

```
library(ontoProc)
```

```
## Loading required package: ontologyIndex
```

```
cc = getOnto("chebi_full")
```

```
## loading from cache
```

```
library(ontologyPlot)
onto_plot(cc,
  c("CHEBI:134109", "CHEBI:61115", "CHEBI:75603", "CHEBI:37699",
       "CHEBI:68481", "CHEBI:71178"), fontsize=24, shape="rect")
```

![](data:image/png;base64...)
It is natural to map the compounds studied in pharmacogenomics to these
compound classes as a step towards understanding common and distinct
mechanisms of action. But in the following display, we see
that some common chemotherapeutic agents are characterized in very
generic terms:

```
onto_plot(cc, c("CHEBI:134109", "CHEBI:61115", "CHEBI:75603", "CHEBI:37699",
   "CHEBI:68481", "CHEBI:71178", "CHEBI:52172", "CHEBI:64310",
   "CHEBI:63632", "CHEBI:45863"), fontsize=28, shape="rect")
```

![](data:image/png;base64...)

Should paclitaxel be identified as an “organic molecular entity”
with no additional detail? Is there additional information in
ChEBI or related ontologies to help organize information on
related compounds?

## 3.5 Relationships among cell lines

Cell line nomenclature is often unnatural. The Cell Line
Ontology should be helpful in systematizing cell lines
used in pharmacogenomics. Nevertheless there is
some apparent lack of consistency.

```
clo = getOnto("cellLineOnto", year_added="2022")
```

```
## loading from cache
```

```
smoc = c("CLO:0000517", "CLO:0000560", "CLO:0000563", "CLO:0001072",
"CLO:0001088", "CLO:0001138", "CLO:0007606")
onto_plot(clo, smoc)
```

![](data:image/png;base64...)

The MCF7 line should probably be annotated as related to human
mammary tissue.

# 4 Working with specific elements

We want to maximize utility of institutionally curated
terminology for components of pharmacodb.

## 4.1 Cell line identifiers

### 4.1.1 Bridging to Cell Line Ontology

The following identifiers are available in the PharmacoDB cell lines:

```
c("143B", "1321N1", "184B5")
```

What are they? What organs do they represent? One way
to proceed is through parent terms in Cell Line Ontology.

```
library(ontoProc)
clo = getOnto("cellLineOnto", year_added="2022")
```

```
## loading from cache
```

```
minds = which(clo$name %in% c("143B cell", "1321N1 cell", "184B5 cell"))
tags = clo$id[minds]
clo$name[ unlist(clo$parent[tags]) ]
```

```
##                                     cancer_cell_line
##                                   "cancer cell line"
##                                          CLO:0000020
##                      "immortal human cell line cell"
##                                          CLO:0000517
##        "immortal human brain-derived cell line cell"
##                                     cancer_cell_line
##                                   "cancer cell line"
##                                          CLO:0000020
##                      "immortal human cell line cell"
##                                          CLO:0000560
## "immortal human bone element-derived cell line cell"
##                                          CLO:0000020
##                      "immortal human cell line cell"
##                                          CLO:0000563
##           "immortal human epithelial cell line cell"
```

TODO: how can we connect the anatomic vocabulary in these terms
to formal anatomical terms in UBERON or CARO?

### 4.1.2 Vocabularies of anatomy

The Experimental Factor Ontology unifies various ontologies and
includes terms related to anatomic systems. At least with the
infrastructure available in *[ontologyIndex](https://CRAN.R-project.org/package%3DontologyIndex)* and
*[ontologyPlot](https://CRAN.R-project.org/package%3DontologyPlot)*, it seems there are opportunities to
add meaningful connections.

```
ee = getOnto("efoOnto")
```

```
## loading from cache
```

```
onto_plot(ee, c("UBERON:0000474", "UBERON:0000079",
  "UBERON:0000990", "UBERON:0000995", "UBERON:0003982",
  "UBERON:0000310", "UBERON:0002107", "UBERON:0001264",
  "UBERON:0002113", "UBERON:0001007", "UBERON:0002530",
  "UBERON:6007435", "UBERON:0004122", "UBERON:0001008"))
```

![](data:image/png;base64...)

It is likely important to remember the distinction between an
ontology, a structured collection of concept terms, and a
curated vocabulary or ontology annotation, which covers
concept “instances”.

## 4.2 Compounds

### 4.2.1 Bridging to ChEBI

This will involve more work. We have the compounds in PharmacoDB.
How many match the compound names in Chebi?

```
chl = getOnto("chebi_full")
```

```
## loading from cache
```

```
allch = chl$name
mm = allch[match(tolower(compounds_v1[,2]), tolower(allch), nomatch=0)]
round(length(mm)/nrow(compounds_v1),2) # not high
```

```
## [1] 0.23
```

```
datatable(data.frame(id=names(mm), comp=as.character(mm)))
```

Direct matches are relatively rare. Attempts to use approximate
matching with agrep have so far been unproductive. As an
example, which we do not run:

```
notin = setdiff(compounds_v1$name, mm)
library(parallel)
options(mc.cores=2)
allch = tolower(allch)
notin = tolower(notin)
lk50 = mclapply(notin[1:50], function(x) { cat(x);
       order(adist(x, allch))[1:5]})
names(lk50) = notin[1:50]
aa = do.call(cbind, lk50[1:50])
ttt = t(apply(aa,2,function(x) allch[x])[1:3,])
```

# 5 Retrieving dose-response data for cell-line/compound intersections

Given a cell-line code and a database, we can retrieve all the experiments
associated with it in that database.

CCLE for MCF-7:

```
library(rjson)
library(httr)
xx = GET("https://pharmacodb.pmgenomics.ca/api/v1/intersections/2/895/1?indent=true")
if (as.numeric(xx$status_code) == 200) {
 ans = fromJSON(readBin(xx$content, what="character"))
 doses1 = sapply(ans[[1]]$dose_responses, function(x) x[[1]])
 resp1 =  sapply(ans[[1]]$dose_responses, function(x) x[[2]])
 }
```

This code only runs if pharmacodb.pmgenomics.ca is responsive.

The `compoundsByCell` function employs this pattern to establish
lists of experiments per cell type.

We can recreate (approximately: the dose and response units
need to be clarified) Figure 4b from Barretina et al. 2012
as follows (defaults to DRTraceSet are specifically chosen
to compute this figure):

```
library(ggplot2)
drt = try(DRTraceSet(dataset="CCLE"))
```

```
## Error in DRTraceSet(dataset = "CCLE") : no data for requested cell lines
```

```
if (!inherits(drt, "try-error")) plot(drt)
```

This code only runs if pharmacodb.pmgenomics.ca is responsive.