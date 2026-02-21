# hmdbQuery: working with Human Metabolome Database (hmdb.ca)

#### Vincent J. Carey, stvjc at channing.harvard.edu

#### October 30, 2025

* [1 Initial remarks](#initial-remarks)
* [2 Key utilities of the package](#key-utilities-of-the-package)
* [3 Working with the metadata](#working-with-the-metadata)
  + [3.1 Disease associations](#disease-associations)
  + [3.2 Biospecimen and tissue location metadata](#biospecimen-and-tissue-location-metadata)

# 1 Initial remarks

The human metabolomics database (HMDB, <http://www.hmdb.ca>) includes XML documents describing 114000 metabolites. We will show how to manipulate the metadata on metabolites fairly flexibly.

# 2 Key utilities of the package

The hmdbQuery package includes a function for querying HMDB directly over HTTP:

```
library(hmdbQuery)
lk1 = HmdbEntry(prefix = "http://www.hmdb.ca/metabolites/",
       id = "HMDB0000001")
```

The result is parsed and encapsulated in an S4 object

```
lk1
```

```
## HMDB metabolite metadata for 1-Methylhistidine:
## There are 10 diseases annotated.
## Direct association reported for 4 biospecimens and 1 tissues.
## Use diseases(), biospecimens(), tissues() for more information.
```

The size of the complete import of information about a single metabolite suggests that it would not be too convenient to have comprehensive information about all HMDB constituents in memory. The most effective approach to managing the metadata will depend upon use cases to be developed over the long run.

Note however that this package does provide snapshots of certain direct associations derived from all available information as of Sept. 23 2017. Information about direct associations reported in the database is present in tables `hmdb_disease`, `hmdb_gene`, `hmdb_protein`, `hmdb_omim`. For example

```
data(hmdb_disease)
hmdb_disease
```

```
## DataFrame with 75360 rows and 3 columns
##         accession                   name                disease
##       <character>            <character>            <character>
## 1     HMDB0000001      1-Methylhistidine    Alzheimer's disease
## 2     HMDB0000001      1-Methylhistidine Diabetes mellitus ty..
## 3     HMDB0000001      1-Methylhistidine         Kidney disease
## 4     HMDB0000001      1-Methylhistidine                Obesity
## 5     HMDB0000002     1,3-Diaminopropane Perillyl alcohol adm..
## ...           ...                    ...                    ...
## 75356 HMDB0094706            Serylvaline                     NA
## 75357 HMDB0094708   Tetraethylene glycol                     NA
## 75358 HMDB0094712           Serylleucine                     NA
## 75359 HMDB0100002 TG(i-14:0/17:0/i-13:0)                     NA
## 75360 HMDB0101657 TG(15:0/i-14:0/a-21:..                     NA
```

# 3 Working with the metadata

## 3.1 Disease associations

Some HMDB metabolites have been mapped to diseases.

```
d1 = diseases(lk1) # data.frame
pmids = unlist(d1["references", 5][[1]][2,])
library(annotate)
```

```
## Loading required package: AnnotationDbi
```

```
## Loading required package: stats4
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
## Loading required package: IRanges
```

```
## Loading required package: S4Vectors
```

```
##
## Attaching package: 'S4Vectors'
```

```
## The following object is masked from 'package:utils':
##
##     findMatches
```

```
## The following objects are masked from 'package:base':
##
##     I, expand.grid, unname
```

```
pm = pubmed(pmids[1])
ab = buildPubMedAbst(xmlRoot(pm)[[1]])
ab
```

```
## An object of class 'pubMedAbst':
## Title: Free amino acid and dipeptide changes in the body fluids from
##      Alzheimer's disease subjects.
## PMID: 17031479
## Authors: AN Fonteh, RJ Harrington, A Tsai, P Liao, MG Harrington
## Journal: Amino Acids
## Date: Feb 2007
```

## 3.2 Biospecimen and tissue location metadata

Note that pre HMDB v 4.0, biospecimens were called biofluids.

There are arbitrarily many biospecimen and tissue associations provided for each HMDB entry. We have direct accessors, and by default we capture all metadata, available through the `store` method.

```
biospecimens(lk1)
```

```
## [1] "Blood"                     "Cerebrospinal Fluid (CSF)"
## [3] "Feces"                     "Urine"
```

```
tissues(lk1)
```

```
## [1] "Skeletal Muscle"
```

```
st = store(lk1)
head(names(st))
```

```
## [1] "version"              "creation_date"        "update_date"
## [4] "accession"            "status"               "secondary_accessions"
```

```
length(names(st))
```

```
## [1] 46
```

```
st$protein_assoc["name",]
```

```
## $protein
## [1] "Beta-Ala-His dipeptidase"
##
## $protein
## [1] "Protein arginine N-methyltransferase 3"
##
## $protein
## [1] "Protein-L-histidine N-pros-methyltransferase"
```

```
st$protein_assoc["gene_name",]
```

```
## $protein
## [1] "CNDP1"
##
## $protein
## [1] "PRMT3"
##
## $protein
## [1] "METTL9"
```