# Introduction to SomaScan.db

#### 24 April 2024

#### Package

SomaScan.db 0.99.10

# 1 Introduction

The `SomaScan.db` package provides extended biological annotations to be used
in conjunction with the results of SomaLogic’s SomaScan assay, a
fee-for-service proteomic technology platform designed to detect proteins
across numerous biological pathways.

This vignette describes how to use the `SomaScan.db`
package to annotate SomaScan data, i.e. add additional information to an ADAT
file that will give biological context (at the gene level) to the platform’s
reagents and their protein targets. `SomaScan.db` performs annotation by
mapping SomaScan reagent IDs (`SeqIds`) to their corresponding protein(s) and
gene(s), as well as biological pathways (GO, KEGG, etc.) and identifiers from
other public data repositories.

`SomaScan.db` utilizes the same methods and setup as other Bioconductor
annotation packages, and therefore the methods should be familiar if you’ve
worked with such packages previously.

# 2 Package Installation

To begin, install and load the `SomaScan.db` package:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("SomaScan.db", version = remotes::bioc_version())
```

Once installed, the package can be loaded as follows:

```
library(SomaScan.db)
```

# 3 Package Overview

Loading this package will expose an annotation object with the same name
as the package, `SomaScan.db`. This object is a [SQLite database](https://www.sqlite.org/index.html)
containing annotation data for the SomaScan assay derived from popular public
repositories. Viewing the object will present a metadata table containing
information about the annotations and where they were obtained:

```
SomaScan.db
```

```
## SomaDb object:
## | DBSCHEMAVERSION: 2.1
## | Db type: ChipDb
## | Supporting package: SomaScan.db
## | DBSCHEMA: HUMANCHIP_DB
## | ORGANISM: Homo sapiens
## | SPECIES: Human
## | MANUFACTURER: SomaLogic
## | CHIPNAME: SomaScan
## | MANUFACTURERURL: https://somalogic.com/somascan-platform/
## | EGSOURCEDATE: 2023-Sep11
## | EGSOURCENAME: Entrez Gene
## | EGSOURCEURL: ftp://ftp.ncbi.nlm.nih.gov/gene/DATA
## | CENTRALID: ENTREZID
## | TAXID: 9606
## | GOSOURCENAME: Gene Ontology
## | GOSOURCEURL: http://current.geneontology.org/ontology/go-basic.obo
## | GOSOURCEDATE: 2023-07-27
## | GOEGSOURCEDATE: 2023-Sep11
## | GOEGSOURCENAME: Entrez Gene
## | GOEGSOURCEURL: ftp://ftp.ncbi.nlm.nih.gov/gene/DATA
## | KEGGSOURCENAME: KEGG GENOME
## | KEGGSOURCEURL: ftp://ftp.genome.jp/pub/kegg/genomes
## | KEGGSOURCEDATE: 2011-Mar15
## | GPSOURCENAME: UCSC Genome Bioinformatics (Homo sapiens)
## | GPSOURCEURL:
## | GPSOURCEDATE: 2023-Aug20
## | ENSOURCEDATE: 2023-May10
## | ENSOURCENAME: Ensembl
## | ENSOURCEURL: ftp://ftp.ensembl.org/pub/current_fasta
## | UPSOURCENAME: Uniprot
## | UPSOURCEURL: http://www.UniProt.org/
## | UPSOURCEDATE: Mon Sep 18 16:12:39 2023
```

```
##
## Please see: help('select') for usage information
```

The same information can be retrieved as a data frame by calling
`metadata(SomaScan.db)`.

Moving forward, this database object (`SomaScan.db`) will be used throughout
the vignette to retrieve SomaScan annotations and map between identifiers.

For reference, the species information for the database can directly be
retrieved with the following methods:

```
species(SomaScan.db)
```

```
## [1] "Homo sapiens"
```

```
taxonomyId(SomaScan.db)
```

```
## [1] 9606
```

It’s also possible to pull a more detailed summary of annotations and resource
identifiers (aka keys) by calling the package as a function, with the `.db`
extension removed:

```
SomaScan()
```

```
## Quality control information for SomaScan:
##
##
## This package has the following mappings:
##
## SomaScanALIAS2PROBE has 38839 mapped keys (of 260786 keys)
## SomaScanENSEMBL has 10596 mapped keys (of 10731 keys)
## SomaScanENSEMBL2PROBE has 11012 mapped keys (of 40851 keys)
## SomaScanENTREZID has 10609 mapped keys (of 10731 keys)
## SomaScanENZYME has 1712 mapped keys (of 10731 keys)
## SomaScanENZYME2PROBE has 809 mapped keys (of 975 keys)
## SomaScanGENENAME has 10609 mapped keys (of 10731 keys)
## SomaScanGO has 10499 mapped keys (of 10731 keys)
## SomaScanGO2ALLPROBES has 20327 mapped keys (of 22561 keys)
## SomaScanGO2PROBE has 16066 mapped keys (of 18692 keys)
## SomaScanMAP has 10607 mapped keys (of 10731 keys)
## SomaScanOMIM has 9766 mapped keys (of 10731 keys)
## SomaScanPATH has 4099 mapped keys (of 10731 keys)
## SomaScanPATH2PROBE has 229 mapped keys (of 229 keys)
## SomaScanPMID has 10607 mapped keys (of 10731 keys)
## SomaScanPMID2PROBE has 605433 mapped keys (of 790941 keys)
## SomaScanREFSEQ has 10605 mapped keys (of 10731 keys)
## SomaScanSYMBOL has 10609 mapped keys (of 10731 keys)
## SomaScanUNIPROT has 10545 mapped keys (of 10731 keys)
##
##
## Additional Information about this package:
##
## DB schema: HUMANCHIP_DB
## DB schema version: 2.1
## Organism: Homo sapiens
## Date for NCBI data: 2023-Sep11
## Date for GO data: 2023-07-27
## Date for KEGG data: 2011-Mar15
## Date for Golden Path data: 2023-Aug20
## Date for Ensembl data: 2023-May10
```

*Note*: Keys will be explained in greater detail later in this vignette.

# 4 Retrieve Annotation Data

The `SomaScan.db` package has 5 primary methods that can be used to query the
database:

* `keys`
* `keytypes`
* `columns`
* `select`
* `mapIds`

This vignette will describe how each of these methods can be used to obtain
annotation data from `SomaScan.db`.

---

## 4.1 `keys` method

This annotation package is platform-based, meaning it was built around the
unique identifiers from a specific platform (in this case, SomaLogic’s
SomaScan platform). That identifier corresponds to each of the assay’s
analytes, and therefore the analyte identifiers (`SeqIds`) are the primary
term used to query the database (aka “key”).

All keys in the database can be retrieved using `keys`:

```
# Short list of primary keys
keys(SomaScan.db) |> head(10L)
```

```
##  [1] "10000-28"  "10001-7"   "10003-15"  "10006-25"  "10008-43"  "10010-10"
##  [7] "10011-65"  "10012-5"   "10014-31"  "10015-119"
```

Each key retrieved in the output above corresponds to one of the assay’s
unique analytes.

---

## 4.2 `keytype` method

When querying the database, we can also specify the type of key (“keytype”)
being used. The keytype refers to the type of identifier that is used to
generate a database query. While the database is centered around the SomaLogic
`SeqId`, other identifiers can still be used to query the database.

We can list all available datatypes that can be used as query keys using
`keytypes()`:

```
## List all of the supported key types.
keytypes(SomaScan.db)
```

```
##  [1] "ACCNUM"       "ALIAS"        "ENSEMBL"      "ENSEMBLPROT"  "ENSEMBLTRANS"
##  [6] "ENTREZID"     "ENZYME"       "EVIDENCE"     "EVIDENCEALL"  "GENENAME"
## [11] "GENETYPE"     "GO"           "GOALL"        "IPI"          "MAP"
## [16] "OMIM"         "ONTOLOGY"     "ONTOLOGYALL"  "PATH"         "PFAM"
## [21] "PMID"         "PROBEID"      "PROSITE"      "REFSEQ"       "SYMBOL"
## [26] "UCSCKG"       "UNIPROT"
```

*Note:* the SomaScan assay analyte identifiers (`SeqIds`) are stored as the
“PROBEID” keytype.

`keytypes` can also be used in conjunction with `keys` to retrieve all
identifiers associated with the specified keytype. The example below will
retrieve all UniProt IDs in `SomaScan.db`:

```
keys(SomaScan.db, keytype = "UNIPROT") |> head(20L)
```

```
##  [1] "A8K052" "P04217" "Q68CK0" "Q8IYJ6" "Q96P39" "V9HWD8" "P01023" "Q13677"
##  [9] "Q59F47" "Q5QTS0" "Q68DN2" "Q6PIY3" "Q6PN97" "A8K4E7" "O15159" "O15300"
## [17] "P18440" "Q546N1" "Q96TE9" "Q9HAQ5"
```

---

## 4.3 `columns` method

All available external annotations, corresponding to “columns” of the
database, can be listed using `columns()`:

```
columns(SomaScan.db)
```

```
##  [1] "ACCNUM"       "ALIAS"        "ENSEMBL"      "ENSEMBLPROT"  "ENSEMBLTRANS"
##  [6] "ENTREZID"     "ENZYME"       "EVIDENCE"     "EVIDENCEALL"  "GENENAME"
## [11] "GENETYPE"     "GO"           "GOALL"        "IPI"          "MAP"
## [16] "OMIM"         "ONTOLOGY"     "ONTOLOGYALL"  "PATH"         "PFAM"
## [21] "PMID"         "PROBEID"      "PROSITE"      "REFSEQ"       "SYMBOL"
## [26] "UCSCKG"       "UNIPROT"
```

*Note:* the SomaScan assay analyte identifiers (`SeqIds`) are stored in the
“PROBEID” column.

This list may look very similar (or even identical) to the `columns` output.
If identical, all columns can be used as query keys. For a more in-depth
explanation of what each of these columns contains, consult the manual:

```
help("OMIM") # Example help call
```

Each `columns` entry also has a mapping object that contains the information
connecting SeqIds → the annotation’s identifiers. To read further
documentation about the object and the resource used to make it, check out the
manual page for the mapping itself:

```
?SomaScanOMIM
```

---

## 4.4 `select` method

The list of columns returned by `columns` informs us as to what types of data
are available; therefore, the column values can be used to retrieve specific
pieces of information from the database. You can think of keys and columns as:

* **Keys**: the information you already have (`SeqIds`/probe IDs), aka *rows*
  of the database
* **Columns**: data types for which you want to retrieve information, aka
  *columns* of the database

The `SomaScan.db` database can be queried via `select`, using both the keys
and columns.

When selecting columns and keys using the `select` method, the keys are
returned in the left-most column of the output, in the `PROBEID` column. The
results will be in the exact same order as the input keys:

```
# Randomly select a set of keys
example_keys <- withr::with_seed(101L, sample(keys(SomaScan.db),
                                              size = 5L,
                                              replace = FALSE
))

# Query keys in the database
select(SomaScan.db,
       keys = example_keys,
       columns = c("ENTREZID", "SYMBOL", "GENENAME")
)
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
##    PROBEID ENTREZID  SYMBOL                                        GENENAME
## 1 34799-31    81563 C1orf21              chromosome 1 open reading frame 21
## 2 20520-14    10447   FAM3C FAM3 metabolism regulating signaling molecule C
## 3  9123-18   255057   CBARP CACN subunit beta associated regulatory protein
## 4 21707-15   389941   C1QL3                           complement C1q like 3
## 5 29325-43    11102   RPP14                  ribonuclease P/MRP subunit p14
```

**Note:** The message above
(**‘select()’ returned 1:1 mapping between keys and columns**) will be
described in detail in the next section of this vignette.

The data that is returned will always be in the same order as the provided
keys. If `select` cannot find a mapping for a specific key, an `NA` value will
be returned to retain the original query order.

```
# Inserting a new key that won't be found in the annotations ("TEST")
test_keys <- c(example_keys[1], "TEST")

select(SomaScan.db, keys = test_keys, columns = c("PROBEID", "ENTREZID"))
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
##    PROBEID ENTREZID
## 1 34799-31    81563
## 2     <NA>     <NA>
```

In the example above, a “PROBEID” and “ENTREZID” value couldn’t be found for
the character string “TEST”, so an `NA` was returned in its place.

### 4.4.1 One-to-Many Relationships

When using `select`, a message indicating the relationship between query keys
and column data will be displayed along with the query results.
This message will describe one of the three relationships below:

* `1:1 mapping between keys and columns`
* `1:many mapping between keys and columns`
* `many:many mapping between keys and columns`

These messages describe the very real possibility that there are multiple
identifiers associated with each key in a query. This can cause the number of
rows returned by `select()` to exceed the number of keys used to retrieve the
data; this is what is meant by the message “‘select()’ returned 1:many mapping
between keys and columns”.

In these cases, you will still see concordance between the order of the
provided keys and outputted results rows, but you should be aware that new
rows were inserted into the results. This message is not an error, merely an
informative notification to the user making it clear that more output rows
than input items should be expected. Importantly, this message also does not
relay information about the SomaScan menu itself or advice on how to handle
many-to-one relationships between SomaScan reagents and their corresponding
protein targets; rather, the message is directly related to this package’s
`select` method and how it retrieves information from the database.

Because some columns may have a many-to-many relationship to each key, it is
generally best practice to retrieve the **minimum number of columns needed**
for a query. Additionally, when retrieving a column that is *known* to have a
many-to-one relationship to each key, like GO terms, it’s best to request that
information in its own query, like so:

```
# Good
select(SomaScan.db, keys = example_keys[3L], columns = "GO")
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
##    PROBEID         GO EVIDENCE ONTOLOGY
## 1  9123-18 GO:0005886      IBA       CC
## 2  9123-18 GO:0005886      ISS       CC
## 3  9123-18 GO:0030141      IBA       CC
## 4  9123-18 GO:0030141      ISS       CC
## 5  9123-18 GO:0030426      ISS       CC
## 6  9123-18 GO:0030672      IEA       CC
## 7  9123-18 GO:0044325      IBA       MF
## 8  9123-18 GO:0044325      ISS       MF
## 9  9123-18 GO:0045955      IBA       BP
## 10 9123-18 GO:0045955      ISS       BP
## 11 9123-18 GO:1901386      IBA       BP
## 12 9123-18 GO:1901386      ISS       BP
## 13 9123-18 GO:1903170      ISS       BP
```

```
# Bad
select(SomaScan.db,
       keys = example_keys[3L],
       columns = c("UNIPROT", "ENSEMBL", "GO", "PATH", "IPI")
) |> tibble::as_tibble()
```

```
## Warning: You have selected the following columns that can have a many to one
##   relationship with the primary key: UNIPROT, ENSEMBL, GO, PATH, IPI .
##   Because you have selected more than a few such columns there is a
##   risk that this selection may balloon up into a very large result as
##   the number of rows returned multiplies accordingly. To experience
##   smaller/more manageable results and faster retrieval times, you might
##   want to consider selecting these columns separately.
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
## # A tibble: 104 × 8
##    PROBEID UNIPROT    ENSEMBL         GO         EVIDENCE ONTOLOGY PATH  IPI
##    <chr>   <chr>      <chr>           <chr>      <chr>    <chr>    <chr> <chr>
##  1 9123-18 A0A140LJL2 ENSG00000099625 GO:0005886 IBA      CC       <NA>  IPI001…
##  2 9123-18 A0A140LJL2 ENSG00000099625 GO:0005886 IBA      CC       <NA>  IPI004…
##  3 9123-18 A0A140LJL2 ENSG00000099625 GO:0005886 ISS      CC       <NA>  IPI001…
##  4 9123-18 A0A140LJL2 ENSG00000099625 GO:0005886 ISS      CC       <NA>  IPI004…
##  5 9123-18 A0A140LJL2 ENSG00000099625 GO:0030141 IBA      CC       <NA>  IPI001…
##  6 9123-18 A0A140LJL2 ENSG00000099625 GO:0030141 IBA      CC       <NA>  IPI004…
##  7 9123-18 A0A140LJL2 ENSG00000099625 GO:0030141 ISS      CC       <NA>  IPI001…
##  8 9123-18 A0A140LJL2 ENSG00000099625 GO:0030141 ISS      CC       <NA>  IPI004…
##  9 9123-18 A0A140LJL2 ENSG00000099625 GO:0030426 ISS      CC       <NA>  IPI001…
## 10 9123-18 A0A140LJL2 ENSG00000099625 GO:0030426 ISS      CC       <NA>  IPI004…
## # ℹ 94 more rows
```

The example above illustrates why it is preferred to request as few columns as
possible, especially when working with GO terms.

### 4.4.2 Specifying Keytype

In `SomaScan.db`, the default keytype for `select` is the probe ID. This means
that when using a `SeqId` (aka “PROBEID”) to retrieve annotations,
the `keytype=` argument does *not* need to be defined, and can be left
out of the `select` call entirely. The default (`PROBEID`) will be used.

```
select(SomaScan.db, keys = example_keys, columns = c("ENTREZID", "UNIPROT"))
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
##     PROBEID ENTREZID    UNIPROT
## 1  34799-31    81563     B2R551
## 2  34799-31    81563     Q9H246
## 3  20520-14    10447     A6NDN2
## 4  20520-14    10447     A8K3R7
## 5  20520-14    10447     Q92520
## 6   9123-18   255057 A0A140LJL2
## 7   9123-18   255057     K7EJP2
## 8   9123-18   255057     O43385
## 9   9123-18   255057     Q8N350
## 10 21707-15   389941 A0A3B0J0F3
## 11 21707-15   389941     A0PJY4
## 12 21707-15   389941     A0PJY5
## 13 21707-15   389941     Q5VWW1
## 14 29325-43    11102     O95059
## 15 29325-43    11102     Q53X97
```

However, the database can be searched using more than just `SeqIds`.

For example, you may want to retrieve a list of `SeqIds` that are associated
with a specific gene of interest - let’s use SMAD2 as an example. You can work
“backwards” to retrieve the `SeqIds` associated with SMAD2 by setting the
`keytype="SYMBOL"`:

```
select(SomaScan.db,
       columns = c("PROBEID", "ENTREZID"),
       keys = "SMAD2", keytype = "SYMBOL"
)
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
##   SYMBOL   PROBEID ENTREZID
## 1  SMAD2   10364-6     4087
## 2  SMAD2 11353-143     4087
```

Sometimes, this may *appear* not to work. Let’s use CASC4 as an example:

```
select(SomaScan.db,
       columns = c("PROBEID", "ENTREZID"),
       keys = "CASC4", keytype = "SYMBOL"
)
```

```
## Error in .testForValidKeys(x, keys, keytype, fks): None of the keys entered are valid keys for 'SYMBOL'. Please use the keys method to see a listing of valid arguments.
```

The error message above implies that `CASC4` is not a valid key for the
“SYMBOL” keytype, which means that no entry for CASC4 was found in the
“SYMBOL” column. However, genes can be tricky to search, and in some cases
have many common names. We can improve this using `keytype="ALIAS"`; this
data type contains the various aliases associated with gene names found in the
“SYMBOL” column. Using `keytype="ALIAS"`, we can cast a wider net:

```
select(SomaScan.db,
       columns = c("SYMBOL", "PROBEID", "ENTREZID"),
       keys = "CASC4", keytype = "ALIAS"
)
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
##   ALIAS SYMBOL  PROBEID ENTREZID
## 1 CASC4  GOLM2 10613-33   113201
## 2 CASC4  GOLM2  8838-10   113201
```

This reveals the source of our problem! CASC4 is also known as GOLM4, and
this symbol is used in the annotations database. Because of
this, searching for CASC4 as a symbol returns no results, but the same query
is able to identify an entry when the “ALIAS” column is specified.

Additionally, we can see that CASC4/GOLM2 is associated with two `SeqIds` -
`10613-33` and `8838-10`. How is this possible, and why does this happen?
For more information, please reference the Advanced Usage Examples (
`vignette("advanced_usage_examples", package = "SomaScan.db")`).

### 4.4.3 Specifying Menu Version

`SomaScan.db` contains annotations for all currently available versions of the
SomaScan menu by default. However, the `menu=` argument of `select` can be
used to retrieve analytes from a single, specified menu. For example, if you
have SomaScan data from an older menu version, like the `5k` menu (also known
as `V4.0`), this argument can be used to retrieve annotations associated with
that menu specifically:

```
all_keys <- keys(SomaScan.db)
menu_5k <- select(SomaScan.db,
                  keys = all_keys, columns = "PROBEID",
                  menu = "5k"
)

head(menu_5k)
```

```
##    PROBEID
## 1 10000-28
## 2  10001-7
## 3 10003-15
## 4 10006-25
## 5 10008-43
## 6 10011-65
```

The `SeqIds` in the `menu_5k` data frame represent the 4966
analytes that were available in v4.0 of the SomaScan menu. All of the listed
analytes have currently available annotations in `SomaScan.db`. Those that are
not represented do not currently have annotations available in `SomaScan.db`.

If the `menu=` argument is not specified in `select`, annotations for *all*
available analytes are returned.

---

## 4.5 `mapIDs` method

For situations in which you wish only to retrieve one data type from the
database, the `mapIds` method may be cleaner and more streamlined than using
`select`, and can help avoid problems with one-to-many mapping of keys.
For example, if you are only interested in the gene symbols associated with a
set of SomaScan analytes, they can be retrieved like so:

```
mapIds(SomaScan.db, keys = example_keys, column = "SYMBOL")
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
##  34799-31  20520-14   9123-18  21707-15  29325-43
## "C1orf21"   "FAM3C"   "CBARP"   "C1QL3"   "RPP14"
```

`mapIds` will return a **named vector** from a *single* column, while `select`
returns a data frame and can be used to retrieve data from multiple columns.

The primary difference between `mapIds` and `select` is how the method handles
one-to-many mapping, i.e. when the chosen key maps to > 1 entry in the
selected column. When this occurs, only the **first value** (by default) is
returned.

Compare the output in the examples below:

```
# Only 1 symbol per key
mapIds(SomaScan.db, keys = example_keys[3L], column = "GO")
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
##      9123-18
## "GO:0005886"
```

```
# All entries for chosen key
select(SomaScan.db, keys = example_keys[3L], column = "GO")
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
##    PROBEID         GO EVIDENCE ONTOLOGY
## 1  9123-18 GO:0005886      IBA       CC
## 2  9123-18 GO:0005886      ISS       CC
## 3  9123-18 GO:0030141      IBA       CC
## 4  9123-18 GO:0030141      ISS       CC
## 5  9123-18 GO:0030426      ISS       CC
## 6  9123-18 GO:0030672      IEA       CC
## 7  9123-18 GO:0044325      IBA       MF
## 8  9123-18 GO:0044325      ISS       MF
## 9  9123-18 GO:0045955      IBA       BP
## 10 9123-18 GO:0045955      ISS       BP
## 11 9123-18 GO:1901386      IBA       BP
## 12 9123-18 GO:1901386      ISS       BP
## 13 9123-18 GO:1903170      ISS       BP
```

Note that the `mapIds` method warning message states that it *returned* 1:many
mappings between keys and columns, however only one value was
returned for the desired `SeqId`. This is because there were more mapped
values that were discarded when the results were converted to a named vector.
This may not be a problem for some columns, like “SYMBOL” (typically there is
only one gene symbol per gene), but it may present a problem for others (like
GO terms or KEGG pathways). Think carefully when using `mapIds`, or consider
specifying the `multiVals=` argument to indicate what should be done
with multi-mapped output.

The default behavior of `mapIds` is to return the first available result:

```
# The default - returns the first available result
mapIds(SomaScan.db, keys = example_keys[3L], column = "GO",
       multiVals = "first")
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
##      9123-18
## "GO:0005886"
```

Again, the `select` message here indicates that, while only 1 value was
returned, there were many more GO term matches. All of the matches can be
viewed by specifying `multiVals="list"`:

```
# Returns a list object of results, instead of only returning the first result
mapIds(SomaScan.db, keys = example_keys[3L], column = "GO",
       multiVals = "list")
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
## $`9123-18`
##  [1] "GO:0005886" "GO:0005886" "GO:0030141" "GO:0030141" "GO:0030426"
##  [6] "GO:0030672" "GO:0044325" "GO:0044325" "GO:0045955" "GO:0045955"
## [11] "GO:1901386" "GO:1901386" "GO:1903170"
```

# 5 Adding Target Full Names

Because the annotations in this package are compiled from public repositories,
information typically found in an ADAT may be missing. For example, in an ADAT
file, each `SeqId` is associated with a protein target, and
the name of that target is provided as both an abbreviated symbol (“Target”)
and full description (“Target Full Name”). The `SomaScan.db`
package does not contain data *from* a particular ADAT file; however, it does
contain a function to add the full protein target name to any data
frame obtained via `select`.

As an example, we will generate a data frame of
[Ensembl](https://useast.ensembl.org/info/about/index.html) gene IDs and
[OMIM](https://www.omim.org/) IDs:

```
ensg <- select(SomaScan.db,
               keys = example_keys[1:3L],
               columns = c("ENSEMBL", "OMIM")
)
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
ensg
```

```
##    PROBEID         ENSEMBL   OMIM
## 1 34799-31 ENSG00000116667   <NA>
## 2 20520-14 ENSG00000196937 608618
## 3  9123-18 ENSG00000099625   <NA>
```

We will now append the Target Full Name to this data frame:

```
addTargetFullName(ensg)
```

```
##    PROBEID                  TARGETFULLNAME         ENSEMBL   OMIM
## 1 20520-14                   Protein FAM3C ENSG00000196937 608618
## 2 34799-31 Uncharacterized protein C1orf21 ENSG00000116667   <NA>
## 3  9123-18                     Protein Dos ENSG00000099625   <NA>
```

The full protein target name will be appended to the input data frame, with
the Target Full Name (in the “TARGETFULLNAME” column) always added to the
right of the “PROBEID” column.

# 6 Package Objects

In addition to the methods mentioned above, there is an R object that can be
used to retrieve SomaScan analytes from a specific menu version. The object is
a list, with each element in the list containing a character vector of
`SeqIds` that were available in the specified menu.

```
summary(somascan_menu)
```

```
##      Length Class  Mode
## v4.0  4966  -none- character
## v4.1  7267  -none- character
## v5.0 10731  -none- character
```

```
lapply(somascan_menu, head)
```

```
## $v4.0
## [1] "10000-28" "10001-7"  "10003-15" "10006-25" "10008-43" "10011-65"
##
## $v4.1
## [1] "10000-28" "10001-7"  "10003-15" "10006-25" "10008-43" "10010-10"
##
## $v5.0
## [1] "10000-28" "10001-7"  "10003-15" "10006-25" "10008-43" "10010-10"
```

This object also provides a quick and easy way of comparing the available
SomaScan menus:

```
setdiff(somascan_menu$v4.1, somascan_menu$v4.0) |> head(50L)
```

```
##  [1] "10010-10"  "10025-1"   "10039-32"  "10069-2"   "10351-51"  "10354-57"
##  [7] "10379-19"  "10382-1"   "10398-110" "10420-30"  "10439-57"  "10457-3"
## [13] "10460-1"   "10463-23"  "10470-34"  "10472-53"  "10473-2"   "10479-18"
## [19] "10480-33"  "10505-12"  "10528-2"   "10576-7"   "10626-116" "10631-9"
## [25] "10636-1"   "10670-26"  "10738-11"  "10741-22"  "10743-13"  "10746-24"
## [31] "10780-10"  "10801-11"  "10819-108" "10855-55"  "10870-32"  "10894-25"
## [37] "10966-1"   "10967-12"  "10970-3"   "10976-44"  "10980-11"  "11081-1"
## [43] "11083-23"  "11121-56"  "11150-3"   "11159-14"  "11184-51"  "11200-52"
## [49] "11203-97"  "11232-46"
```

# 7 Session Info

```
sessionInfo()
```

```
## R version 4.4.0 beta (2024-04-15 r86425)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 22.04.4 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.19-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] tibble_3.2.1         SomaScan.db_0.99.10  AnnotationDbi_1.65.2
## [4] IRanges_2.37.1       S4Vectors_0.41.7     Biobase_2.63.1
## [7] BiocGenerics_0.49.1  withr_3.0.0          BiocStyle_2.31.0
##
## loaded via a namespace (and not attached):
##  [1] bit_4.0.5               jsonlite_1.8.8          compiler_4.4.0
##  [4] BiocManager_1.30.22     crayon_1.5.2            blob_1.2.4
##  [7] Biostrings_2.71.6       jquerylib_0.1.4         png_0.1-8
## [10] yaml_2.3.8              fastmap_1.1.1           org.Hs.eg.db_3.19.1
## [13] R6_2.5.1                XVector_0.43.1          GenomeInfoDb_1.39.14
## [16] knitr_1.46              bookdown_0.39           GenomeInfoDbData_1.2.12
## [19] DBI_1.2.2               pillar_1.9.0            bslib_0.7.0
## [22] rlang_1.1.3             utf8_1.2.4              KEGGREST_1.43.0
## [25] cachem_1.0.8            xfun_0.43               sass_0.4.9
## [28] bit64_4.0.5             RSQLite_2.3.6           memoise_2.0.1
## [31] cli_3.6.2               magrittr_2.0.3          zlibbioc_1.49.3
## [34] digest_0.6.35           lifecycle_1.0.4         vctrs_0.6.5
## [37] glue_1.7.0              evaluate_0.23           fansi_1.0.6
## [40] rmarkdown_2.26          httr_1.4.7              pkgconfig_2.0.3
## [43] tools_4.4.0             htmltools_0.5.8.1       UCSC.utils_0.99.7
```