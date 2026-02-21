# metaboliteIDmapping

### Mapping table for various metabolite ID formats

Sebastian Canzler1

1Helmholtz-Centre for Environmental Research - UFZ, Leipzig, Germany

#### May 12, 2020

#### Package

metaboliteIDmapping 1.0.0

# 1 Introduction

The `metaboliteIDmapping` AnnotationHub package provides a
comprehensive ID mapping for various metabolite ID formats. Within
this annotation package, nine different ID formats and metabolite
common names are merged in one large mapping table. ID formats include
[Comptox Chemical Dashboard](https://comptox.epa.gov/dashboard) IDs
(DTXCID, DTXSID), [Pubchem](https://pubchem.ncbi.nlm.nih.gov/) IDs
(CID, SID), [CAS Registry
numbers](https://www.cas.org/support/documentation/references)
(CAS-RN), [Human Metabolome Database](https://hmdb.ca/) (HMDB),
[Chemical Entities of Biological
Interest](https://www.ebi.ac.uk/chebi/) (ChEBI), [KEGG
Compounds](https://www.genome.jp/kegg/compound/) (KEGG), and
[Drugbank](https://www.drugbank.ca/) (Drugbank)

The metabolite IDs and names were retrieved from four different
publicly available sources and merged into one mapping table by means
of the R script that is distributed alongside the AnnotationHub
package. The script is located in `system.file( package = "metaboliteIDmapping", "/scripts/make-data.R")`

A brief description of the utilized data sources is given in the following section.

# 2 Data sources

Four publicly available sources were queried to retrieved nine different metabolite
ID formats. As short description of those sources is listed below:

## 2.1 The Human Metabolome Database (HMDB)

```
* Website: https://hmdb.ca/
* Current version: 4.0
* Download link: https://hmdb.ca/system/downloads/current/hmdb_metabolites.zip
* File format: XML
* ID formats: HMDB, CAS, Pubchem CID, KEGG, ChEBi, Drugbank
* Number of metabolites: 114100
```

## 2.2 Chemical Entities of Biological Interest (ChEBI)

```
* Website: https://www.ebi.ac.uk/chebi/
* Current version: Jan 5, 2020
* Download link: ftp://ftp.ebi.ac.uk/pub/databases/chebi/Flat_file_tab_delimited/database_accession.tsv
* File format: TSV
* ID formats: ChEBI, CAS, KEGG
* Number of metabolites: 17227
```

## 2.3 Comptox Chemical Dashboard

```
* Website: https://comptox.epa.gov/dashboard
* Comptox Chemical Dashboard supplied us with two separate files,
one linking to Pubchem IDs and other linking to CAS numbers.
```

### 2.3.1 Linking to Pubchem

```
* Download link: ftp://newftp.epa.gov/COMPTOX/Sustainable_Chemistry_Data/Chemistry_Dashboard/PubChem_DTXSID_mapping_file.txt
* Current version: Nov 14, 2016
* File format: TSV
* ID formats: DTXSID, CID, SID
* Number of metabolites: 735553
```

### 2.3.2 Linking to CAS registry numbers

```
* Download link: ftp://newftp.epa.gov/COMPTOX/Sustainable_Chemistry_Data/Chemistry_Dashboard/2019/April/DSSTox_Identifiers_and_CASRN.xlsx
* Current version: Apr, 2019
* File format: XLSX
* ID formats: DTXCID, DTXSID, CAS
* Number of metabolites: 875755
```

### 2.3.3 Full-join on both tables based on DTXSID

```
* ID formats: DTXCID, DTXSID, CAS, CID, SID
* Number of combined metabolites: 875796
```

## 2.4 `graphite` R package

```
* Website: https://www.bioconductor.org/packages/release/bioc/html/graphite.html
* Current Version: Bioconductor release 3.11
* Data structure: date.frame
* Access from R package: `graphite:::loadMetaboliteDb()@table`
* ID formats: KEGG, ChEBI, CAS, Pubchem CID
* Number of metabolites: 155651
```

# 3 Usage

There are two different ways to load the mapping ID table from this package.

First, simply load the `metaboliteIDmapping` package into your R session.
When the package is loaded, the data will be available as tibble:

```
library( metaboliteIDmapping)
```

```
## snapshotDate(): 2021-05-06
```

```
## loading from cache
```

```
metabolitesMapping
```

```
## # A tibble: 1,012,267 x 10
##    CAS    DTXSID   DTXCID  SID    CID   KEGG  ChEBI HMDB   Drugbank Name
##    <chr>  <chr>    <chr>   <chr>  <chr> <chr> <chr> <chr>  <chr>    <chr>
##  1 18523… DTXSID2… DTXCID… 31567… 4415… <NA>  <NA>  <NA>   <NA>     Acetone[4-(…
##  2 75-05… DTXSID7… DTXCID… 31567… 6342  <NA>  38472 HMDB0… <NA>     Acetonitrile
##  3 65734… DTXSID6… DTXCID… 31567… 1079… <NA>  <NA>  <NA>   <NA>     N'-Acetyl-4…
##  4 520-4… DTXSID6… DTXCID… 31567… 1229… <NA>  1374… <NA>   <NA>     Dehydroacet…
##  5 114-8… DTXSID1… DTXCID… 31567… 8247  <NA>  <NA>  <NA>   <NA>     1-Acetyl-2-…
##  6 28314… DTXSID1… DTXCID… 31567… 34209 <NA>  <NA>  <NA>   <NA>     1-Acetylami…
##  7 28322… DTXSID1… DTXCID… 31567… 34210 <NA>  76343 <NA>   <NA>     4-Acetylami…
##  8 18699… DTXSID0… DTXCID… 31567… 2018  <NA>  31173 <NA>   <NA>     4-Acetylami…
##  9 3054-… DTXSID0… DTXCID… 31567… 62477 <NA>  <NA>  <NA>   <NA>     Acrolein di…
## 10 5314-… DTXSID5… DTXCID… 31567… 9577… <NA>  <NA>  <NA>   <NA>     Acrolein ox…
## # … with 1,012,257 more rows
```

Second, search for the mapping table in the AnnotationHub resource interface:

```
library( AnnotationHub)
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: parallel
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:parallel':
##
##     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
##     clusterExport, clusterMap, parApply, parCapply, parLapply,
##     parLapplyLB, parRapply, parSapply, parSapplyLB
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, intersect, is.unsorted,
##     lapply, mapply, match, mget, order, paste, pmax, pmax.int, pmin,
##     pmin.int, rank, rbind, rownames, sapply, setdiff, sort, table,
##     tapply, union, unique, unsplit, which.max, which.min
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
ah <- AnnotationHub()
```

```
## snapshotDate(): 2021-05-06
```

```
datasets <- query( ah, "metaboliteIDmapping")

datasets[1]
```

```
## AnnotationHub with 1 record
## # snapshotDate(): 2021-05-06
## # names(): AH79817
## # $dataprovider: HMDB, EMBL-EBI, EPA
## # $species: NA
## # $rdataclass: Tibble
## # $rdatadateadded: 2020-05-11
## # $title: Metabolite ID mapping from different sources
## # $description: Large mapping table including 9 distinct metabolite ID forma...
## # $taxonomyid: NA
## # $genome: NA
## # $sourcetype: TSV
## # $sourceurl: https://github.com/yigbt/metaboliteIDmapping/blob/master/inst/...
## # $sourcesize: NA
## # $tags: c("CAS", "ChEBI", "Comptox", "Drugbank", "HMDB", "KEGG",
## #   "mapping", "metaboliteIDmapping", "metabolites", "Pubchem")
## # retrieve record with 'object[["AH79817"]]'
```

```
datasets[2]
```

```
## AnnotationHub with 1 record
## # snapshotDate(): 2021-05-06
## # names(): AH83115
## # $dataprovider: HMDB, EMBL-EBI, EPA
## # $species: NA
## # $rdataclass: Tibble
## # $rdatadateadded: 2020-06-18
## # $title: Mapping table of metabolite IDs and common names from different so...
## # $description: Large mapping table including metabolite common names and 9 ...
## # $taxonomyid: NA
## # $genome: NA
## # $sourcetype: TSV
## # $sourceurl: https://github.com/yigbt/metaboliteIDmapping/blob/master/inst/...
## # $sourcesize: NA
## # $tags: c("CAS", "ChEBI", "Comptox", "Drugbank", "HMDB", "KEGG",
## #   "mapping", "metaboliteIDmapping", "metabolites", "Pubchem")
## # retrieve record with 'object[["AH83115"]]'
```

Currently, there are two versions of the mapping table.

* AH79817 represents the original ID mapping containing 9 different ID formats
* AH83115 mapping table which also includes common names for each compound
* AH91792 current version of the mapping table that also accounts for tautomers

For implanting this data in your code, it is recommended to use the
AHid for retrieval:

```
data <- ah[["AH91792"]]
```

```
## loading from cache
```

```
data
```

```
## # A tibble: 1,012,267 x 10
##    CAS    DTXSID   DTXCID  SID    CID   KEGG  ChEBI HMDB   Drugbank Name
##    <chr>  <chr>    <chr>   <chr>  <chr> <chr> <chr> <chr>  <chr>    <chr>
##  1 18523… DTXSID2… DTXCID… 31567… 4415… <NA>  <NA>  <NA>   <NA>     Acetone[4-(…
##  2 75-05… DTXSID7… DTXCID… 31567… 6342  <NA>  38472 HMDB0… <NA>     Acetonitrile
##  3 65734… DTXSID6… DTXCID… 31567… 1079… <NA>  <NA>  <NA>   <NA>     N'-Acetyl-4…
##  4 520-4… DTXSID6… DTXCID… 31567… 1229… <NA>  1374… <NA>   <NA>     Dehydroacet…
##  5 114-8… DTXSID1… DTXCID… 31567… 8247  <NA>  <NA>  <NA>   <NA>     1-Acetyl-2-…
##  6 28314… DTXSID1… DTXCID… 31567… 34209 <NA>  <NA>  <NA>   <NA>     1-Acetylami…
##  7 28322… DTXSID1… DTXCID… 31567… 34210 <NA>  76343 <NA>   <NA>     4-Acetylami…
##  8 18699… DTXSID0… DTXCID… 31567… 2018  <NA>  31173 <NA>   <NA>     4-Acetylami…
##  9 3054-… DTXSID0… DTXCID… 31567… 62477 <NA>  <NA>  <NA>   <NA>     Acrolein di…
## 10 5314-… DTXSID5… DTXCID… 31567… 9577… <NA>  <NA>  <NA>   <NA>     Acrolein ox…
## # … with 1,012,257 more rows
```