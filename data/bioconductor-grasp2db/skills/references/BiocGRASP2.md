# Notes on Bioconductor’s GRASP2 database curation

# Contents

* [1 Introduction](#introduction)
* [2 Processing](#processing)
  + [2.1 Standardizing column names](#standardizing-column-names)
  + [2.2 Data cleaning](#data-cleaning)
    - [2.2.1 Outstanding issues](#outstanding-issues)
  + [2.3 SQLite representation](#sqlite-representation)
* [3 Use](#use)

Package: `grasp2db`
 Author: Martin Morgan
 Modification date: 2014-12-31
 Compilation date: 2017-06-29

# 1 Introduction

This document outlines steps taken to create Bioconductor’s version of the GRASP2 data base. [GRASP](http://apps.nhlbi.nih.gov/Grasp/Overview.aspx) (Genome-Wide Repository of Associations Between SNPs and Phenotypes) v2.0 was released in September 2014. The Bioconductor AnnotationHub resource is derived from the [v 2.0.0.0 release](https://s3.amazonaws.com/NHLBI_public/GRASP/GraspFullDataset2.zip).

The primary reference for version 2 is: Eicher JD, Landowski C, Stackhouse B, Sloan A, Chen W, Jensen N, Lien J-P, Leslie R, Johnson AD (2014) GRASP v 2.0: an update to the genome-wide repository of associations between SNPs and phenotypes. Nucl Acids Res, published online Nov 26, 2014 PMID 25428361.

Other vignettes in the grasp2db package contain details of the GRASP2 data base.

# 2 Processing

The script `system.file(package="grasp2db", "scripts", "grasp2AnnotationHub.R")` processes GRASP2 to the Bioconductor sqlite representation. The script downloads the [ZIP](https://s3.amazonaws.com/NHLBI_public/GRASP/GraspFullDataset2.zip) file, uncompresses the contents to a single tab-delimited text file, performs some necessary data cleaning, and stores the data in a partially normalized sqlite data base. The sqlite data base is distributed using the Bioconductor *[AnnotationHub](http://bioconductor.org/packages/AnnotationHub)* package.

Data cleaning and transformation to sqlite are performed by the `grasp2db:::.db_create()` function. The major steps include

1. Standardizing column names
2. Standardizing some aspects of data representation
3. Output to 3 sqlite tables.

## 2.1 Standardizing column names

Column names are standardized using `grasp2db:::.db_clean_colnames()`. The following columns are renamed:

| Original | Standardized |
| --- | --- |
| SNPid(dbSNP134) | SNPid\_dbSNP134 |
| chr(hg19) | chr\_hg19 |
| pos(hg19) | pos\_hg19 |
| SNPid(in paper) | SNPidInPaper |
| InNHGRIcat(as of 3/31/12) | InNHGRIcat\_3\_31\_12 |
| Initial Sample Description | DiscoverySampleDescription |
| LS SNP | LS\_SNP |

All other column names were transformed to CamelCase by removing non-alphabetical characters and capitalizing the subsequent letter, e.g., `Exclusively Male/Female` becomes `ExclusivelyMaleFemale`.

## 2.2 Data cleaning

`grasp2db:::.db_clean_chunk()` standardized data.

NHLBIkey is supposed to be a unique integer-valued identifier, but the GRASP2fullDataset file contains 47 rows with keys `2.36501E+14` or `2.29412E+14`. These rows have been removed.

Columns `TotalSamples(discovery+replication)`, `TotalDiscoverySamples`, and `Total replication samples` were removed (these values are easily calculated if desired).

A column `NegativeLog10PBin` was created to represent decades of increasing log10 significance, `round(-log10(Pvalue))`.

The `CreationDate` and `LastCurationDate` columns were standardized so that the dates `8/17/12` and `8/17/2012` are represented consistently as `8/17/2012`.

The `HUBfield` date formats refering to `Jan2014` or `14-Jan` were standardized to `1/1/2014`.

The `LocationWithinPaper` entries without a space between `Table12`, `Figure12`, or `FullData` were replaced with a space equivalent, e.g., `Table 12`.

The `dbSNPvalidation` column replaced `""`, `"NO"`, `"YES"` with logical `NA`, `FALSE`, `TRUE`.

The `dbSNPClinStatus` column entries were standardized to lower case.

### 2.2.1 Outstanding issues

The `Phenotype` (and other?) column contains string representations (apparently) using the CP1250 encoding, as well as variants differing only by character case. In R and on platforms supporting CP1250 encoding, offending vectors can be transformed to their portable and cannonical representation using

```
P = iconv(Phenotype, "CP1250", "UTF-8")
p = tolower(P)
Phenotype = P[match(p, p)]
```

## 2.3 SQLite representation

Data were partially normalized into 3 tables.

`study` contains information on each publication present in the data base, using `PMID` as a unique key. See `grasp2db:::.db_accumulate_study()`.

`count` contains the number of samples each variant was found in, summarized by sample (`Discovery` or `Replication`) and population (e.g., `European`, `Hispanic`), using `NHLBIkey` as a unique key. See `grasp2db:::.db_write_count()`.

`variant` contains information about each variant, and in particular `NHLBIkey` and `PMID` to relate this table to the `study` and `count` tables. See `grasp2db:::.db_write_variant()`.

Indexes were created on PMID (variant and study tables) and NHLBIkey (variant and count tables) fields, and on the Phenotype, dbSNPid, chromosome and position, and NegativeLog10PBin fields (variant table).

# 3 Use

The database is available for use in this package as

```
library(grasp2db)
GRASP2()           # dbplyr representation
```

or more directly as

```
library(AnnotationHub)
db <- AnnotationHub()[["AH21414"]]
```

In both cases, the (large) data base is downloaded to a local cache (see documentation in the *[AnnotationHub](http://bioconductor.org/packages/AnnotationHub)* package); this can take several minutes the first time the data base is used.