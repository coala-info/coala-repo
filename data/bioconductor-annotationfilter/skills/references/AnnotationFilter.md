# Facilities for Filtering Bioconductor Annotation Resources

#### 29 October 2025

**Package**: *[AnnotationFilter](https://bioconductor.org/packages/3.22/AnnotationFilter)*
**Authors**: Martin Morgan [aut],
Johannes Rainer [aut],
Joachim Bargsten [ctb],
Daniel Van Twisk [ctb],
Bioconductor Package Maintainer [cre]
**Last modified:** 2025-10-29 20:01:59.794772
**Compiled**: Wed Oct 29 22:30:10 2025

# 1 Introduction

A large variety of annotation resources are available in Bioconductor. Accessing
the full content of these databases or even of single tables is computationally
expensive and in many instances not required, as users may want to extract only
sub-sets of the data e.g. genomic coordinates of a single gene. In that respect,
filtering annotation resources before data extraction has a major impact on
performance and increases the usability of such genome-scale databases.

The *[AnnotationFilter](https://bioconductor.org/packages/3.22/AnnotationFilter)* package was thus developed to provide basic
filter classes to enable a common filtering framework for Bioconductor
annotation resources. *[AnnotationFilter](https://bioconductor.org/packages/3.22/AnnotationFilter)* defines filter classes for
some of the most commonly used features in annotation databases, such as
*symbol* or *genename*. Each filter class is supposed to work on a single
database table column and to facilitate filtering on the provided values. Such
filter classes enable the user to build complex queries to retrieve specific
annotations without needing to know column or table names or the layout of the
underlying databases. While initially being developed to be used in the
*[Organism.dplyr](https://bioconductor.org/packages/3.22/Organism.dplyr)* and *[ensembldb](https://bioconductor.org/packages/3.22/ensembldb)* packages, the filter
classes and the related filtering concept can be easily added to other
annotation packages too.

# 2 Filter classes

All filter classes extend the basic `AnnotationFilter` class and take one or
more *values* and a *condition* to allow filtering on a single database table
column. Based on the type of the input value, filter classes are divided into:

* `CharacterFilter`: takes a `character` value of length >= 1 and supports
  conditions `==`, `!=`, `startsWith` and `endsWith`. An example would be a
  `GeneIdFilter` that allows to filter on gene IDs.
* `IntegerFilter`: takes a single `integer` as input and supports the conditions
  `==`, `!=`, `>`, `<`, `>=` and `<=`. An example would be a `GeneStartFilter`
  that filters results on the (chromosomal) start coordinates of genes.
* `DoubleFilter`: takes a single `numeric` as input and supports the conditions
  `==`, `!=`, `>`, `<`, `>=` and `<=`.
* `GRangesFilter`: is a special filter, as it takes a `GRanges` as `value` and
  performs the filtering on a combination of columns (i.e. start and end
  coordinate as well as sequence name and strand). To be consistent with the
  `findOverlaps` method from the *[IRanges](https://bioconductor.org/packages/3.22/IRanges)* package, the constructor
  of the `GRangesFilter` filter takes a `type` argument to define its
  condition. Supported values are `"any"` (the default) that retrieves all
  entries overlapping the `GRanges`, `"start"` and `"end"` matching all features
  with the same start and end coordinate respectively, `"within"` that matches
  all features that are *within* the range defined by the `GRanges` and
  `"equal"` that returns features that are equal to the `GRanges`.

The names of the filter classes are intuitive, the first part corresponding to
the database column name with each character following a `_` being capitalized,
followed by the key word `Filter`. The name of a filter for a database table
column `gene_id` is thus called `GeneIdFilter`. The default database column for
a filter is stored in its `field` slot (accessible *via* the `field` method).

The `supportedFilters` method can be used to get an overview of all available
filter objects defined in `AnnotationFilter`.

```
library(AnnotationFilter)
supportedFilters()
```

```
##               filter        field
## 16      CdsEndFilter      cds_end
## 15    CdsStartFilter    cds_start
## 6       EntrezFilter       entrez
## 19     ExonEndFilter     exon_end
## 1       ExonIdFilter      exon_id
## 2     ExonNameFilter    exon_name
## 18    ExonRankFilter    exon_rank
## 17   ExonStartFilter   exon_start
## 24     GRangesFilter      granges
## 5  GeneBiotypeFilter gene_biotype
## 21     GeneEndFilter     gene_end
## 3       GeneIdFilter      gene_id
## 4     GeneNameFilter    gene_name
## 20   GeneStartFilter   gene_start
## 11   ProteinIdFilter   protein_id
## 13     SeqNameFilter     seq_name
## 14   SeqStrandFilter   seq_strand
## 7       SymbolFilter       symbol
## 10   TxBiotypeFilter   tx_biotype
## 23       TxEndFilter       tx_end
## 8         TxIdFilter        tx_id
## 9       TxNameFilter      tx_name
## 22     TxStartFilter     tx_start
## 12     UniprotFilter      uniprot
```

Note that the `AnnotationFilter` package does provides only the filter classes
but not the functionality to apply the filtering. Such functionality is
annotation resource and database layout dependent and needs thus to be
implemented in the packages providing access to annotation resources.

# 3 Usage

Filters are created *via* their dedicated constructor functions, such as the
`GeneIdFilter` function for the `GeneIdFilter` class. Because of this simple and
cheap creation, filter classes are thought to be *read-only* and thus don’t
provide *setter* methods to change their slot values. In addition to the
constructor functions, `AnnotationFilter` provides the functionality to
*translate* query expressions into filter classes (see further below for an
example).

Below we create a `SymbolFilter` that could be used to filter an annotation
resource to retrieve all entries associated with the specified symbol value(s).

```
library(AnnotationFilter)

smbl <- SymbolFilter("BCL2")
smbl
```

```
## class: SymbolFilter
## condition: ==
## value: BCL2
```

Such a filter is supposed to be used to retrieve all entries associated to
features with a value in a database table column called *symbol* matching the
filter’s value `"BCL2"`.

Using the `"startsWith"` condition we could define a filter to retrieve all
entries for genes with a gene name/symbol starting with the specified value
(e.g. `"BCL2"` and `"BCL2L11"` for the example below.

```
smbl <- SymbolFilter("BCL2", condition = "startsWith")
smbl
```

```
## class: SymbolFilter
## condition: startsWith
## value: BCL2
```

In addition to the constructor functions, `AnnotationFilter` provides a
functionality to create filter instances in a more natural and intuitive way by
*translating* filter expressions (written as a *formula*, i.e. starting with a
`~`).

```
smbl <- AnnotationFilter(~ symbol == "BCL2")
smbl
```

```
## class: SymbolFilter
## condition: ==
## value: BCL2
```

Individual `AnnotationFilter` objects can be combined in an
`AnnotationFilterList`. This class extends `list` and provides an additional
`logicOp()` that defines how its individual filters are supposed to be
combined. The length of `logicOp()` has to be 1 less than the number of filter
objects. Each element in `logicOp()` defines how two consecutive filters should
be combined. Below we create a `AnnotationFilterList` containing two filter
objects to be combined with a logical *AND*.

```
flt <- AnnotationFilter(~ symbol == "BCL2" &
                            tx_biotype == "protein_coding")
flt
```

```
## AnnotationFilterList of length 2
## symbol == 'BCL2' & tx_biotype == 'protein_coding'
```

Note that the `AnnotationFilter` function does not (yet) support translation of
nested expressions, such as `(symbol == "BCL2L11" & tx_biotype == "nonsense_mediated_decay") | (symbol == "BCL2" & tx_biotype == "protein_coding")`. Such queries can however be build by nesting
`AnnotationFilterList` classes.

```
## Define the filter query for the first pair of filters.
afl1 <- AnnotationFilterList(SymbolFilter("BCL2L11"),
                             TxBiotypeFilter("nonsense_mediated_decay"))
## Define the second filter pair in ( brackets should be combined.
afl2 <- AnnotationFilterList(SymbolFilter("BCL2"),
                             TxBiotypeFilter("protein_coding"))
## Now combine both with a logical OR
afl <- AnnotationFilterList(afl1, afl2, logicOp = "|")

afl
```

```
## AnnotationFilterList of length 2
## (symbol == 'BCL2L11' & tx_biotype == 'nonsense_mediated_decay') | (symbol == 'BCL2' & tx_biotype == 'protein_coding')
```

This `AnnotationFilterList` would now select all entries for all transcripts of
the gene *BCL2L11* with the biotype *nonsense\_mediated\_decay* or for all protein
coding transcripts of the gene *BCL2*.

# 4 Using `AnnotationFilter` in other packages

The `AnnotationFilter` package does only provide filter classes, but no
filtering functionality. This has to be implemented in the package using the
filters. In this section we first show in a very simple example how
`AnnotationFilter` classes could be used to filter a `data.frame` and
subsequently explore how a simple filter framework could be implemented for a
SQL based annotation resources.

Let’s first define a simple `data.frame` containing the data we want to
filter. Note that subsetting this `data.frame` using `AnnotationFilter` is
obviously not the best solution, but it should help to understand the basic
concept.

```
## Define a simple gene table
gene <- data.frame(gene_id = 1:10,
                   symbol = c(letters[1:9], "b"),
                   seq_name = paste0("chr", c(1, 4, 4, 8, 1, 2, 5, 3, "X", 4)),
                   stringsAsFactors = FALSE)
gene
```

```
##    gene_id symbol seq_name
## 1        1      a     chr1
## 2        2      b     chr4
## 3        3      c     chr4
## 4        4      d     chr8
## 5        5      e     chr1
## 6        6      f     chr2
## 7        7      g     chr5
## 8        8      h     chr3
## 9        9      i     chrX
## 10      10      b     chr4
```

Next we generate a `SymbolFilter` and inspect what information we can extract
from it.

```
smbl <- SymbolFilter("b")
```

We can access the filter *condition* using the `condition` method

```
condition(smbl)
```

```
## [1] "=="
```

The value of the filter using the `value` method

```
value(smbl)
```

```
## [1] "b"
```

And finally the *field* (i.e. column in the data table) using the `field`
method.

```
field(smbl)
```

```
## [1] "symbol"
```

With this information we can define a simple function that takes the data table
and the filter as input and returns a `logical` with length equal to the number
of rows of the table, `TRUE` for rows matching the filter.

```
doMatch <- function(x, filter) {
    do.call(condition(filter), list(x[, field(filter)], value(filter)))
}

## Apply this function
doMatch(gene, smbl)
```

```
##  [1] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
```

Note that this simple function does not support multiple filters and also not
conditions `"startsWith"` or `"endsWith"`. Next we define a second function that
extracts the relevant data from the data resource.

```
doExtract <- function(x, filter) {
    x[doMatch(x, filter), ]
}

## Apply it on the data
doExtract(gene, smbl)
```

```
##    gene_id symbol seq_name
## 2        2      b     chr4
## 10      10      b     chr4
```

We could even modify the `doMatch` function to enable filter expressions.

```
doMatch <- function(x, filter) {
    if (is(filter, "formula"))
        filter <- AnnotationFilter(filter)
    do.call(condition(filter), list(x[, field(filter)], value(filter)))
}

doExtract(gene, ~ gene_id == '2')
```

```
##   gene_id symbol seq_name
## 2       2      b     chr4
```

For such simple examples `AnnotationFilter` might be an overkill as the same
could be achieved (much simpler) using standard R operations. A real case
scenario in which `AnnotationFilter` becomes useful are SQL-based annotation
resources. We will thus explore next how SQL resources could be filtered using
`AnnotationFilter`.

We use the SQLite database from the *[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)* package that
provides a variety of annotations for all human genes. Using the packages’
connection to the database we inspect first what database tables are available
and then select one for our simple filtering example.

We use an `EnsDb` SQLite database used by the *[ensembldb](https://bioconductor.org/packages/3.22/ensembldb)* package
and implement simple filter functions to extract specific data from one of its
database tables. We thus load below the `EnsDb.Hsapiens.v75` package that
provides access to human gene, transcript, exon and protein annotations. Using
its connection to the database we inspect first what database tables are
available and then what *fields* (i.e. columns) the *gene* table has.

```
## Load the required packages
library(org.Hs.eg.db)
library(RSQLite)
## Get the database connection
dbcon <- org.Hs.eg_dbconn()

## What tables do we have?
dbListTables(dbcon)
```

```
##  [1] "accessions"            "alias"                 "chrlengths"
##  [4] "chromosome_locations"  "chromosomes"           "cytogenetic_locations"
##  [7] "ec"                    "ensembl"               "ensembl2ncbi"
## [10] "ensembl_prot"          "ensembl_trans"         "gene_info"
## [13] "genes"                 "genetype"              "go"
## [16] "go_all"                "go_bp"                 "go_bp_all"
## [19] "go_cc"                 "go_cc_all"             "go_mf"
## [22] "go_mf_all"             "kegg"                  "map_counts"
## [25] "map_metadata"          "metadata"              "ncbi2ensembl"
## [28] "omim"                  "pfam"                  "prosite"
## [31] "pubmed"                "refseq"                "sqlite_stat1"
## [34] "sqlite_stat4"          "ucsc"                  "uniprot"
```

`org.Hs.eg.db` provides many different tables, one for each identifier or
annotation resource. We will use the *gene\_info* table and determine which
*fields* (i.e. columns) the table provides.

```
## What fields are there in the gene_info table?
dbListFields(dbcon, "gene_info")
```

```
## [1] "_id"       "gene_name" "symbol"
```

The *gene\_info* table provides the official gene symbol and the gene name. The
column *symbol* matches the default `field` value of the `SymbolFilter` as does
the column *gene\_name* for the *GeneNameFilter*. If the column in the database
would not match the field of an `AnnotationFilter`, we would have to implement a
function that maps the default field of the filter object to the database
column. See the end of the section for an example.

We next implement a simple `doExtractGene` function that retrieves data from the
*gene\_info* table and re-uses the `doFilter` function to extract specific
data. The parameter `x` is now the database connection object.

```
doExtractGene <- function(x, filter) {
    gene <- dbGetQuery(x, "select * from gene_info")
    doExtract(gene, filter)
}

## Extract all entries for BCL2
bcl2 <- doExtractGene(dbcon, SymbolFilter("BCL2"))

bcl2
```

```
##     _id                gene_name symbol
## 479 479 BCL2 apoptosis regulator   BCL2
```

This works, but is not really efficient, since the function first fetches the
full database table and subsets it only afterwards. A much more efficient
solution is to *translate* the `AnnotationFilter` class(es) to an SQL *where*
condition and hence perform the filtering on the database level. Here we have to
do some small modifications, since not all condition values can be used 1:1 in
SQL calls. The condition `"=="` has for example to be converted into `"="` and
the `"startsWith"` into a SQL `"like"` by adding also a `"%"` wildcard to the
value of the filter. We would also have to deal with filters that have a `value`
of length > 1. A `SymbolFilter` with a `value` being `c("BCL2", "BCL2L11")`
would for example have to be converted to a SQL call `"symbol in ('BCL2','BCL2L11')"`. Here we skip these special cases and define a simple
function that translates an `AnnotationFilter` to a *where* condition to be
included into the SQL call. Depending on whether the filter extends
`CharacterFilter` or `IntegerFilter` the value has also to be quoted.

```
## Define a simple function that covers some condition conversion
conditionForSQL <- function(x) {
    switch(x,
           "==" = "=",
           x)
}

## Define a function to translate a filter into an SQL where condition.
## Character values have to be quoted.
where <- function(x) {
    if (is(x, "CharacterFilter"))
        value <- paste0("'", value(x), "'")
    else value <- value(x)
    paste0(field(x), conditionForSQL(condition(x)), value)
}

## Now "translate" a filter using this function
where(SeqNameFilter("Y"))
```

```
## [1] "seq_name='Y'"
```

Next we implement a new function which integrates the filter into the SQL call
to let the database server take care of the filtering.

```
## Define a function that
doExtractGene2 <- function(x, filter) {
    if (is(filter, "formula"))
        filter <- AnnotationFilter(filter)
    query <- paste0("select * from gene_info where ", where(filter))
    dbGetQuery(x, query)
}

bcl2 <- doExtractGene2(dbcon, ~ symbol == "BCL2")
bcl2
```

```
##   _id                gene_name symbol
## 1 479 BCL2 apoptosis regulator   BCL2
```

Below we compare the performance of both approaches.

```
system.time(doExtractGene(dbcon, ~ symbol == "BCL2"))
```

```
##    user  system elapsed
##   0.315   0.000   0.315
```

```
system.time(doExtractGene2(dbcon, ~ symbol == "BCL2"))
```

```
##    user  system elapsed
##   0.027   0.000   0.027
```

Not surprisingly, the second approach is much faster.

Be aware that the examples shown here are only for illustration purposes. In a
real world situation additional factors, like combinations of filters, which
database tables to join, which columns to be returned etc would have to be
considered too.

What if the database column on which we want to filter does not match the
`field` of an `AnnotatioFilter`? If for example the database column is named
*hgnc\_symbol* instead of *symbol* we could for example package-internally
overwrite the default `field` method for `SymbolFilter` to return the correct
field for the database column.

```
## Default method from AnnotationFilter:
field(SymbolFilter("a"))
```

```
## [1] "symbol"
```

```
## Overwrite the default method.
setMethod("field", "SymbolFilter", function(object, ...) "hgnc_symbol")

## Call to field returns now the "correct" database column
field(SymbolFilter("a"))
```

```
## [1] "hgnc_symbol"
```

# 5 Session information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
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
##  [1] RSQLite_2.4.3           org.Hs.eg.db_3.22.0     AnnotationDbi_1.72.0
##  [4] IRanges_2.44.0          S4Vectors_0.48.0        Biobase_2.70.0
##  [7] BiocGenerics_0.56.0     generics_0.1.4          AnnotationFilter_1.34.0
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] bit_4.6.0            jsonlite_2.0.0       crayon_1.5.3
##  [4] compiler_4.5.1       BiocManager_1.30.26  blob_1.2.4
##  [7] Biostrings_2.78.0    GenomicRanges_1.62.0 jquerylib_0.1.4
## [10] Seqinfo_1.0.0        png_0.1-8            yaml_2.3.10
## [13] fastmap_1.2.0        XVector_0.50.0       R6_2.6.1
## [16] knitr_1.50           bookdown_0.45        DBI_1.2.3
## [19] bslib_0.9.0          rlang_1.1.6          KEGGREST_1.50.0
## [22] cachem_1.1.0         xfun_0.53            sass_0.4.10
## [25] lazyeval_0.2.2       bit64_4.6.0-1        memoise_2.0.1
## [28] cli_3.6.5            digest_0.6.37        lifecycle_1.0.4
## [31] vctrs_0.6.5          evaluate_1.0.5       rmarkdown_2.30
## [34] httr_1.4.7           pkgconfig_2.0.3      tools_4.5.1
## [37] htmltools_0.5.8.1
```