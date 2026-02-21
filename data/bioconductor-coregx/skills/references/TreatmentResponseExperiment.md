# The TreatmentResponseExperiment Class

Petr Smirnov1\* and Christopher Eeles1\*\*

1Princess Margaret Cancer Centre, University Health Network, Toronto Canada

\*petr.smirnov@uhnresearch.ca
\*\*christopher.eeles@uhnresearch.ca

#### 29 October 2025

#### Package

CoreGx 2.14.0

# Contents

* [1 Why Do We Need A New Class?](#why-do-we-need-a-new-class)
* [2 Design Philosophy](#design-philosophy)
* [3 Anatomy of a TreatmentResponseExperiment](#anatomy-of-a-treatmentresponseexperiment)
  + [3.1 Class Diagram](#class-diagram)
  + [3.2 Object Structure and Cardinality](#object-structure-and-cardinality)
* [4 Constructing a TreatmentResponseExperiment](#constructing-a-treatmentresponseexperiment)
  + [4.1 The DataMapper Class](#the-datamapper-class)
  + [4.2 The TREDataMapper Class](#the-tredatamapper-class)
  + [4.3 metaConstruct Method](#metaconstruct-method)
* [5 TreatmentResponseExperiment Object](#treatmentresponseexperiment-object)
  + [5.1 Row and Column Names](#row-and-column-names)
  + [5.2 `data.frame` Subsetting](#data.frame-subsetting)
    - [5.2.1 Regex Queries](#regex-queries)
  + [5.3 `data.table` Subsetting](#data.table-subsetting)
* [6 Accessor Methods](#accessor-methods)
  + [6.1 rowData](#rowdata)
  + [6.2 colData](#coldata)
  + [6.3 assays](#assays)
  + [6.4 assay](#assay)
* [7 References](#references)
* **Appendix**
* [A sessionInfo](#sessioninfo)

# 1 Why Do We Need A New Class?

The current implementation for the `@treatmentResponse` slot in a
`PharmacoSet` has some limitations.

Firstly, it does not natively support dose-response experiments with
multiple drugs and/or cancer cell lines. As a result we have not been
able to include this data into a `PharmacoSet` thus far.

Secondly, drug combination data has the potential to scale to high dimensionality.
As a result we need an object that is highly performant to ensure
computations on such data can be completed in a timely manner.

To resolve these issues, we designed and implement the
`TreamtentResponseExperiment` (or `TRE` for short)!

# 2 Design Philosophy

The current use case is supporting drug combinations experiments in
*[PharmacoGx](https://bioconductor.org/packages/3.22/PharmacoGx)*, but we wanted to create something flexible
enough to fit other use cases. As such, we have used the generic term
‘treatment’ to refer to any experimental intervention one can conduct on a
set of samples. In context of *[PharmacoGx](https://bioconductor.org/packages/3.22/PharmacoGx)*, a
treatment represents application of one or more anti-cancer compounds to a
cancer cell-line. The resulting viability for this cell-line
after treatment is the response metric. We hope that the implementation of
our class is general enough to support other use cases. For example, the
`TreatmentResponseExperiment` class is also being adopted for radiation
dose-response experiments in cancer cell-lines in
*[RadioGx](https://bioconductor.org/packages/3.22/RadioGx)* as well as for investigating compound
toxicity in healthy human and rat cell-lines in
*[ToxicoGx](https://bioconductor.org/packages/3.22/ToxicoGx)*.

Our design takes the aspects of the `SummarizedExperiment` and
`MultiAssayExperiment` classes and implements them using the `data.table`
package, which provides an R API to a rich set of tools for scalable,
high performance data processing implemented in C.

# 3 Anatomy of a TreatmentResponseExperiment

## 3.1 Class Diagram

![](data:image/png;base64...)

We have borrowed directly from the `SummarizedExperiment` class
for the `rowData`, `colData`, `metadata` and `assays` slot names.
We also implemented the `SummarizedExperiment` accessor methods for the
`TreatmentResponseExperiment`. Therefore the interface should be familiar to
users of common Bioconductor packages.

## 3.2 Object Structure and Cardinality

There are, however, some important differences which make this object more
flexible when dealing with high dimensional data.

![](data:image/png;base64...)

Unlike a `SummarizedExperiment`, there are three distinct
subgroups of columns in `rowData` and `colData`.

The first are the `rowKey` and `colKey` which are implemented internally to
map between each assay observation and its associated treatments or samples
(rows or columns); these will not be returned by the accessors by default.
The second are the `rowIDs` and `colIDs`, these hold all of the information
necessary to uniquely identify a row or column and are used to generate the
`rowKey` and `colKey`. Finally, there are the `rowMeta` and `colMeta` columns,
which store any additional data about treatments or samples not required to
uniquely identify a row in either table.

Within the `TreatmentResponseExperiment`, an `assayIndex` is stored in the
`@.intern` slot which maps between unique combinations of `rowKey` and `colKey`
and the experimental observations in each assay. This relationship is maintained
using a separate primary key for each assay, which can map to one or more `rowKey`
and `colKey` combination. For assays containing raw experimental observations,
generally each assay row will map to one and only one combination of `rowKey`
and `colKey`. However, for metrics computed over experimental observations, It
may be desirable to summarized over some of the `rowID` and/or `colID` columns.
In this case, the relationship between the summarized rows and the metadata
stored in the `rowData` and `colData` slots are retained in the `assayIndex`,
allowing

Also worth noting is the cardinality between `rowData` and `colData` for a given
assay within the assays list. As indicated by the lower connection between these
tables and an assay, for each row or column key there may be zero or more rows in
the assay table. Conversely for each row in the assay there may be zero or one key
in `colData` or `rowData`. When combined, the `rowKey` and `colKey` for a given
row in an assay become a composite key which uniquely identify an observation.

# 4 Constructing a TreatmentResponseExperiment

To deal with the complex kinds of experimental designs which can be stored
in a `LongTable`, we have engineered a new object to help document and validate
the way data is mapped from raw data files, as a single large `data.frame` or
`data.table`, to the various slots of a `TreatmentResponseExperiment` object.

## 4.1 The DataMapper Class

The `DataMapper` is an abstract class, which means in cannot be instatiated.
Its purpose is to provide a description of the concept of a DataMapper and
define a basic interface for any classes inheriting from it. A DataMapper is
simply a way to map columns from some raw data file to the slots of an S4 class.
It is similar to a schema in SQL in that it defines the valid parts of an
object (analogously a SQL table), but differs in that no types are specified or
enforced at this time.

This object is not important for general users, but may be useful for other
developers who want to map from some raw data to some `S4` class. In this case,
any derived data mapper should inherit from the `DataMapper` abstract class.
Only one slot is defined by default, a `list` or `List` in the `@rawdata` slot.
An accessor method, `rawdata(DataMapper)`, is defined to assign and retrieve
the raw data from your mapper object.

## 4.2 The TREDataMapper Class

The `TREDataMapper` class is the first concrete sub-class of a
`DataMapper`. It is the object which defines how to go from a single
`data.frame` or `data.table` of raw experimental data to a properly formatted
and valid `TreatmentResponseExperiment` object. This is accomplished by defining
various mappings, which let the the user decide which columns from `rawdata`
should go into which slots of the object. Each slot mapping is implemented as a
list of character vectors specifying the column names from `rawdata` to assign
to each slot.

Additionally, a helper method has been included, `guessMapping`, that will
try to determine which columns of a `TreatmentResponseExperiment`s `rawdata`
should be assigned to which slots, and therefore which maps.

To get started making a `TreatmentResponseExperiment` lets have a look at some
rawdata which is a subset of the data from Oneil *et al.*, 2016. The full set
of rawdata is available for exploration and download from
[SynergxDB.ca](https://www.synergxdb.ca/), a free and open source web-app and
database of publicly available drug combination sensitivity experiments which we
created and released (Seo *et al.*, 2019).

The data was generated as part of the commercial activities of the
pharmaceutical company Merck, and is thus named according.

```
filePath <- system.file('extdata', 'merckLongTable.csv', package='CoreGx',
  mustWork=TRUE)
merckDT <- fread(filePath, na.strings=c('NULL'))
colnames(merckDT)
```

```
##  [1] "drug1id"            "drug2id"            "drug1dose"
##  [4] "drug2dose"          "combination_name"   "cellid"
##  [7] "batchid"            "viability1"         "viability2"
## [10] "viability3"         "viability4"         "mu/muMax_published"
## [13] "X/X0_published"
```

| drug1id | drug2id | drug1dose | drug2dose | combination\_name |
| --- | --- | --- | --- | --- |
| 5-FU | Bortezomib | 0.35 | 0.00045 | 5-FU & Bortezomib |
| 5-FU | Bortezomib | 0.35 | 0.00200 | 5-FU & Bortezomib |
| 5-FU | Bortezomib | 0.35 | 0.00900 | 5-FU & Bortezomib |
| 5-FU | Bortezomib | 0.35 | 0.04000 | 5-FU & Bortezomib |
| 5-FU | L778123 | 0.35 | 0.32500 | 5-FU & L778123 |
| 5-FU | L778123 | 0.35 | 0.80000 | 5-FU & L778123 |

| combination\_name | cellid | batchid | viability1 | viability2 | viability3 | viability4 | mu/muMax\_published | X/X0\_published |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 5-FU & Bortezomib | A2058 | 1 | 0.814 | 0.754 | 0.765 | 0.849 | 0.880 | 0.847 |
| 5-FU & Bortezomib | A2058 | 1 | 0.792 | 0.788 | 0.840 | 0.852 | 0.897 | 0.867 |
| 5-FU & Bortezomib | A2058 | 1 | 0.696 | 0.831 | 0.690 | 0.806 | 0.854 | 0.817 |
| 5-FU & Bortezomib | A2058 | 1 | 0.637 | 0.678 | 0.625 | 0.627 | 0.767 | 0.724 |
| 5-FU & L778123 | A2058 | 1 | 0.679 | 0.795 | 0.731 | 0.700 | 0.830 | 0.790 |
| 5-FU & L778123 | A2058 | 1 | 0.667 | 0.734 | 0.596 | 0.613 | 0.773 | 0.730 |

We can see that all the data related to the treatment response experiment is
contained within this table.

To get an idea of where in a `TreatmentResponseExperiment` this data should go, lets come up
with some guesses for mappings.

```
# Our guesses of how we may identify rows, columns and assays
groups <- list(
  justDrugs=c('drug1id', 'drug2id'),
  drugsAndDoses=c('drug1id', 'drug2id', 'drug1dose', 'drug2dose'),
  justCells=c('cellid'),
  cellsAndBatches=c('cellid', 'batchid'),
  assays1=c('drug1id', 'drug2id', 'cellid'),
  assays2=c('drug1id', 'drug2id', 'drug1dose', 'drug2dose', 'cellid', 'batchid')
)

# Decide if we want to subset out mapped columns after each group
subsets <- c(FALSE, TRUE, FALSE, TRUE, FALSE, TRUE)

# First we put our data in the `TRE`
TREdataMapper <- TREDataMapper(rawdata=merckDT)

# Then we can test our hypotheses, subset=FALSE means we don't remove mapped
#   columns after each group is mapped
guess <- guessMapping(TREdataMapper, groups=groups, subset=subsets)
```

```
## [CoreGx::guessMapping,LongTableDataMapper-method]
##  Mapping for group justDrugs: drug1id, drug2id
```

```
## [CoreGx::guessMapping,LongTableDataMapper-method]
##  Mapping for group drugsAndDoses: drug1id, drug2id, drug1dose, drug2dose
```

```
## [CoreGx::guessMapping,LongTableDataMapper-method]
##  Mapping for group justCells: cellid
```

```
## [CoreGx::guessMapping,LongTableDataMapper-method]
##  Mapping for group cellsAndBatches: cellid, batchid
```

```
## [CoreGx::guessMapping,LongTableDataMapper-method]
##  Mapping for group assays1: drug1id, drug2id, cellid
```

```
## [CoreGx::guessMapping,LongTableDataMapper-method]
##  Mapping for group assays2: drug1id, drug2id, drug1dose, drug2dose, cellid, batchid
```

```
guess
```

```
## $metadata
## $metadata$id_columns
## [1] NA
##
## $metadata$mapped_columns
## character(0)
##
##
## $justDrugs
## $justDrugs$id_columns
## [1] "drug1id" "drug2id"
##
## $justDrugs$mapped_columns
## [1] "combination_name"
##
##
## $drugsAndDoses
## $drugsAndDoses$id_columns
## [1] "drug1id"   "drug2id"   "drug1dose" "drug2dose"
##
## $drugsAndDoses$mapped_columns
## [1] "combination_name"
##
##
## $justCells
## $justCells$id_columns
## [1] "cellid"
##
## $justCells$mapped_columns
## character(0)
##
##
## $cellsAndBatches
## $cellsAndBatches$id_columns
## [1] "cellid"  "batchid"
##
## $cellsAndBatches$mapped_columns
## character(0)
##
##
## $assays1
## $assays1$id_columns
## [1] "drug1id" "drug2id" "cellid"
##
## $assays1$mapped_columns
## character(0)
##
##
## $assays2
## $assays2$id_columns
## [1] "drug1id"   "drug2id"   "drug1dose" "drug2dose" "cellid"    "batchid"
##
## $assays2$mapped_columns
## [1] "viability1"         "viability2"         "viability3"
## [4] "viability4"         "mu/muMax_published" "X/X0_published"
##
##
## $unmapped
## character(0)
```

Since we want our `TreatmentResponseExperiment` to have drugs as rows and
samples as columns, we see that both `justDrug` and `drugsAndDoses` yield the
same result. So we do not yet prefer one over the other. Looking at `justCells`
and `cellsAndBatches`, we see one column maps to each of them and therefore still
have no preference. For `assay1` however, we see that no columns mapped, while
`assay2` maps many of raw data columns.

Since assays will be subset based on the `rowKey` and `colKey`, we know that
the rowIDs must be `drugsAndDose` and the the colIDs must be `cellsAndBatches`.
Therefore, to uniquely identify an observation in any given assay we need
all of these columns. We can use this information to assign maps to our
`TREDataMapper`.

```
rowDataMap(TREdataMapper) <- guess$drugsAndDose
colDataMap(TREdataMapper) <- guess$cellsAndBatches
```

Looking at our mapped columns for `assay2`, we must decide if we want these
to go into more than one assay. If we do, we should name each item of our
`assayMap` for the `TREDataMapper` and specify it in a list of
`character` vectors, one for each assay. Since viability is the raw experimental
measurement and the final two columns are summaries of it, we will assign them
to two assays:sensitivity and profiles.

```
assays <- list(
  sensitivity=list(
    guess$assays2[[1]],
    guess$assays2[[2]][seq_len(4)]
  ),
  profiles=list(
    guess$assays2[[1]],
    guess$assays2[[2]][c(5, 6)]
  )
)
assays
```

```
## $sensitivity
## $sensitivity[[1]]
## [1] "drug1id"   "drug2id"   "drug1dose" "drug2dose" "cellid"    "batchid"
##
## $sensitivity[[2]]
## [1] "viability1" "viability2" "viability3" "viability4"
##
##
## $profiles
## $profiles[[1]]
## [1] "drug1id"   "drug2id"   "drug1dose" "drug2dose" "cellid"    "batchid"
##
## $profiles[[2]]
## [1] "mu/muMax_published" "X/X0_published"
```

```
assayMap(TREdataMapper) <- assays
```

## 4.3 metaConstruct Method

The metaConstruct method accepts a `DataMapper` object as its only argument,
and uses the information in that `DataMapper` to preprocess all `rawdata` and
map them to the appropriate slots of an `S4` object. In our case, we are mapping
from the merckDT `data.table` to a `TreatmentResponseExperiment`.

At minimum, a `TREDataMapper` must specify the `rowDataMap`, `colDataMap`,
and `assayMap`. Additional maps are available, see `?TREDataMapper-class`
and `?TREDataMapper-accessors` for more details.

After configuration, creating the object is very straight forward.

```
tre <- metaConstruct(TREdataMapper)
```

```
## 2025-10-29 23:18:32 Building assay index...
## 2025-10-29 23:18:32 Joining rowData to assayIndex...
## 2025-10-29 23:18:33 Joining colData to assayIndex...
## 2025-10-29 23:18:33 Joining assays to assayIndex...
## 2025-10-29 23:18:34 Setting assayIndex key...
## 2025-10-29 23:18:35 Building LongTable...
```

# 5 TreatmentResponseExperiment Object

As mentioned previously, a `TreatmentResponseExperiment` has both list and
table like behaviours. For table like operations, a given
`TreatmentResponseExperiment` can be thought of as a `rowKey` by
`colKey` rectangular object.

To support `data.frame` like sub-setting for this object, the constructor makes
pseudo row and column names, which are the ID columns for each row of
`rowData` or `colData` pasted together with a ‘:’. The ordering of these
columns is preserved in the pseudo-dim names, so be sure to arrange them
as desirged before creating the `TreatmentResponseExperiment`.

## 5.1 Row and Column Names

```
head(rownames(tre))
```

```
## [1] "5-FU:Bortezomib:0.35:0.00045" "5-FU:Bortezomib:0.35:0.002"
## [3] "5-FU:Bortezomib:0.35:0.009"   "5-FU:Bortezomib:0.35:0.04"
## [5] "5-FU:L778123:0.35:0.325"      "5-FU:L778123:0.35:0.8"
```

We see that the rownames for the Merck `TreatmentResponseExperiment` are the cell-line name
pasted to the batch id.

```
head(colnames(tre))
```

```
## [1] "A2058:1" "A2058:3" "A2780:1" "A2780:2" "A375:1"  "A375:2"
```

For the column names, a similar pattern is followed by combining the colID
columns in the form ‘drug1:drug2:drug1dose:drug2dose’.

## 5.2 `data.frame` Subsetting

We can subset a `TreatmentResponseExperiment` using the same row and column name syntax as
with a `data.frame` or `matrix`.

```
row <- rownames(tre)[1]
columns <- colnames(tre)[1:2]
tre[row, columns]
```

```
## <TreatmentResponseExperiment>
##    dim:  1 1
##    assays(2): sensitivity profiles
##    rownames(1): 5-FU:Bortezomib:0.35:0.00045
##    rowData(5): drug1id drug2id drug1dose drug2dose combination_name
##    colnames(1): A2058:1
##    colData(2): cellid batchid
##    metadata(0): none
```

### 5.2.1 Regex Queries

However, unlike a `data.frame` or `matrix` this subsetting also accepts partial
row and column names as well as regex queries.

```
head(rowData(tre), 3)
```

```
##    drug1id    drug2id drug1dose drug2dose  combination_name
##     <char>     <char>     <num>     <num>            <char>
## 1:    5-FU Bortezomib      0.35   0.00045 5-FU & Bortezomib
## 2:    5-FU Bortezomib      0.35   0.00200 5-FU & Bortezomib
## 3:    5-FU Bortezomib      0.35   0.00900 5-FU & Bortezomib
```

```
head(colData(tre), 3)
```

```
##    cellid batchid
##    <char>   <int>
## 1:  A2058       1
## 2:  A2058       3
## 3:  A2780       1
```

For example, if we want to get all instance where ‘5-FU’ is the drug:

```
tre['5-FU', ]
```

```
## <TreatmentResponseExperiment>
##    dim:  21 5
##    assays(2): sensitivity profiles
##    rownames(21): 5-FU:Bortezomib:0.35:0.00045 5-FU:Bortezomib:0.35:0.002 ... 5-FU:geldanamycin:0.35:2 MK-4541:5-FU:0.045:10
##    rowData(5): drug1id drug2id drug1dose drug2dose combination_name
##    colnames(5): A2058:1 A2780:1 A375:1 A427:1 CAOV3:1
##    colData(2): cellid batchid
##    metadata(0): none
```

This has matched all colnames where 5-FU was in either drug1 or drug2. If we
only want to match drug1, we have several options:

```
all.equal(tre['5-FU:*:*:*', ], tre['^5-FU',  ])
```

```
## [1] TRUE
```

As a technicaly note, ‘\*’ is replaced with ‘.\*’ internally for regex queries.
This was implemented to mimic the linux shell style patten matching that most
command-line users are familiar with.

## 5.3 `data.table` Subsetting

In addition to regex queries, a `TreatmentResponseExperiment` object supports
arbitrarily complex subset queries using the `data.table` API. To access this
API, you will need to use the `.` function, which allows you to pass raw R
expressions to be evaluated inside the `i` and `j` arguments for
`dataTable[i, j]`.

For example if we want to subset to rows where the cell line is VCAP and columns
where drug1 is Temozolomide and drug2 is either Lapatinib or Bortezomib:

```
tre[
    # row query
    .(drug1id == 'Temozolomide' & drug2id %in% c('Lapatinib', 'Bortezomib')),
    .(cellid == 'CAOV3') # column query
]
```

```
## <TreatmentResponseExperiment>
##    dim:  8 1
##    assays(2): sensitivity profiles
##    rownames(8): Temozolomide:Bortezomib:2.75:0.00045 Temozolomide:Bortezomib:2.75:0.002 ... Temozolomide:Lapatinib:2.75:1.1 Temozolomide:Lapatinib:2.75:5
##    rowData(5): drug1id drug2id drug1dose drug2dose combination_name
##    colnames(1): CAOV3:1
##    colData(2): cellid batchid
##    metadata(0): none
```

We can also invert matches or subset on other columns in `rowData` or `colData`:

```
subTRE <- tre[
  .(drug1id == 'Temozolomide' & drug2id != 'Lapatinib'),
  .(batchid != 2)
]
```

To show that this works as expected:

```
print(paste0('drug2id: ', paste0(unique(rowData(subTRE)$drug2id),
    collapse=', ')))
```

```
## [1] "drug2id: ABT-888, BEZ-235, Bortezomib, Dasatinib, Erlotinib, MK-2206, MK-5108, MK-8669, MK-8776, PD325901, SN-38, Sorafenib, geldanamycin"
```

```
print(paste0('batchid: ', paste0(unique(colData(subTRE)$batchid),
    collapse=', ')))
```

```
## [1] "batchid: 1"
```

# 6 Accessor Methods

## 6.1 rowData

```
head(rowData(tre), 3)
```

```
##    drug1id    drug2id drug1dose drug2dose  combination_name
##     <char>     <char>     <num>     <num>            <char>
## 1:    5-FU Bortezomib      0.35   0.00045 5-FU & Bortezomib
## 2:    5-FU Bortezomib      0.35   0.00200 5-FU & Bortezomib
## 3:    5-FU Bortezomib      0.35   0.00900 5-FU & Bortezomib
```

```
head(rowData(tre, key=TRUE), 3)
```

```
## Key: <rowKey>
##    drug1id    drug2id drug1dose drug2dose  combination_name rowKey
##     <char>     <char>     <num>     <num>            <char>  <int>
## 1:    5-FU Bortezomib      0.35   0.00045 5-FU & Bortezomib      1
## 2:    5-FU Bortezomib      0.35   0.00200 5-FU & Bortezomib      2
## 3:    5-FU Bortezomib      0.35   0.00900 5-FU & Bortezomib      3
```

## 6.2 colData

```
head(colData(tre), 3)
```

```
##    cellid batchid
##    <char>   <int>
## 1:  A2058       1
## 2:  A2058       3
## 3:  A2780       1
```

```
head(colData(tre, key=TRUE), 3)
```

```
## Key: <colKey>
##    cellid batchid colKey
##    <char>   <int>  <int>
## 1:  A2058       1      1
## 2:  A2058       3      2
## 3:  A2780       1      3
```

## 6.3 assays

```
assays <- assays(tre)
assays[[1]]
```

```
## Key: <drug1id, drug2id, drug1dose, drug2dose, cellid, batchid>
##            drug1id    drug2id drug1dose drug2dose cellid batchid
##             <char>     <char>     <num>     <num> <char>   <int>
##    1:         5-FU Bortezomib    0.3500   0.00045  A2058       1
##    2:         5-FU Bortezomib    0.3500   0.00045  A2780       1
##    3:         5-FU Bortezomib    0.3500   0.00045   A375       1
##    4:         5-FU Bortezomib    0.3500   0.00045   A427       1
##    5:         5-FU Bortezomib    0.3500   0.00045  CAOV3       1
##   ---
## 3796: geldanamycin  Topotecan    0.0223   0.07750  A2058       1
## 3797: geldanamycin  Topotecan    0.0223   0.07750  A2780       1
## 3798: geldanamycin  Topotecan    0.0223   0.07750   A375       1
## 3799: geldanamycin  Topotecan    0.0223   0.07750   A427       1
## 3800: geldanamycin  Topotecan    0.0223   0.07750  CAOV3       1
##               combination_name viability1 viability2 viability3 viability4
##                         <char>      <num>      <num>      <num>      <num>
##    1:        5-FU & Bortezomib      0.814      0.754      0.765      0.849
##    2:        5-FU & Bortezomib      0.214      0.195      0.186      0.223
##    3:        5-FU & Bortezomib      1.064      1.080      1.082      1.009
##    4:        5-FU & Bortezomib      0.675      0.582      0.482      0.516
##    5:        5-FU & Bortezomib      0.845      0.799      0.799      0.759
##   ---
## 3796: geldanamycin & Topotecan      0.090      0.043      0.112      0.103
## 3797: geldanamycin & Topotecan      0.025      0.022      0.029      0.023
## 3798: geldanamycin & Topotecan      0.151      0.146      0.144      0.171
## 3799: geldanamycin & Topotecan      0.142      0.166      0.124      0.175
## 3800: geldanamycin & Topotecan      0.091      0.084      0.134      0.119
```

```
assays[[2]]
```

```
## Key: <drug1id, drug2id, drug1dose, drug2dose, cellid, batchid>
##            drug1id    drug2id drug1dose drug2dose cellid batchid
##             <char>     <char>     <num>     <num> <char>   <int>
##    1:         5-FU Bortezomib    0.3500   0.00045  A2058       1
##    2:         5-FU Bortezomib    0.3500   0.00045  A2780       1
##    3:         5-FU Bortezomib    0.3500   0.00045   A375       1
##    4:         5-FU Bortezomib    0.3500   0.00045   A427       1
##    5:         5-FU Bortezomib    0.3500   0.00045  CAOV3       1
##   ---
## 3796: geldanamycin  Topotecan    0.0223   0.07750  A2058       1
## 3797: geldanamycin  Topotecan    0.0223   0.07750  A2780       1
## 3798: geldanamycin  Topotecan    0.0223   0.07750   A375       1
## 3799: geldanamycin  Topotecan    0.0223   0.07750   A427       1
## 3800: geldanamycin  Topotecan    0.0223   0.07750  CAOV3       1
##               combination_name mu/muMax_published X/X0_published
##                         <char>              <num>          <num>
##    1:        5-FU & Bortezomib              0.880          0.847
##    2:        5-FU & Bortezomib              0.384          0.426
##    3:        5-FU & Bortezomib              1.033          1.047
##    4:        5-FU & Bortezomib              0.676          0.638
##    5:        5-FU & Bortezomib              0.708          0.667
##   ---
## 3796: geldanamycin & Topotecan             -0.187          0.193
## 3797: geldanamycin & Topotecan             -0.445          0.135
## 3798: geldanamycin & Topotecan              0.090          0.283
## 3799: geldanamycin & Topotecan             -0.012          0.246
## 3800: geldanamycin & Topotecan             -1.935          0.017
```

```
assays <- assays(tre, withDimnames=TRUE)
colnames(assays[[1]])
```

```
##  [1] "drug1id"          "drug2id"          "drug1dose"        "drug2dose"
##  [5] "cellid"           "batchid"          "combination_name" "viability1"
##  [9] "viability2"       "viability3"       "viability4"
```

```
assays <- assays(tre, withDimnames=TRUE, metadata=TRUE)
colnames(assays[[2]])
```

```
## [1] "drug1id"            "drug2id"            "drug1dose"
## [4] "drug2dose"          "cellid"             "batchid"
## [7] "combination_name"   "mu/muMax_published" "X/X0_published"
```

```
assayNames(tre)
```

```
## [1] "sensitivity" "profiles"
```

Using these names we can access specific assays within a
`TreatmentResponseExperiment`.

## 6.4 assay

```
colnames(assay(tre, 'sensitivity'))
```

```
##  [1] "drug1id"          "drug2id"          "drug1dose"        "drug2dose"
##  [5] "cellid"           "batchid"          "combination_name" "viability1"
##  [9] "viability2"       "viability3"       "viability4"
```

```
assay(tre, 'sensitivity')
```

```
## Key: <drug1id, drug2id, drug1dose, drug2dose, cellid, batchid>
##            drug1id    drug2id drug1dose drug2dose cellid batchid
##             <char>     <char>     <num>     <num> <char>   <int>
##    1:         5-FU Bortezomib    0.3500   0.00045  A2058       1
##    2:         5-FU Bortezomib    0.3500   0.00045  A2780       1
##    3:         5-FU Bortezomib    0.3500   0.00045   A375       1
##    4:         5-FU Bortezomib    0.3500   0.00045   A427       1
##    5:         5-FU Bortezomib    0.3500   0.00045  CAOV3       1
##   ---
## 3796: geldanamycin  Topotecan    0.0223   0.07750  A2058       1
## 3797: geldanamycin  Topotecan    0.0223   0.07750  A2780       1
## 3798: geldanamycin  Topotecan    0.0223   0.07750   A375       1
## 3799: geldanamycin  Topotecan    0.0223   0.07750   A427       1
## 3800: geldanamycin  Topotecan    0.0223   0.07750  CAOV3       1
##               combination_name viability1 viability2 viability3 viability4
##                         <char>      <num>      <num>      <num>      <num>
##    1:        5-FU & Bortezomib      0.814      0.754      0.765      0.849
##    2:        5-FU & Bortezomib      0.214      0.195      0.186      0.223
##    3:        5-FU & Bortezomib      1.064      1.080      1.082      1.009
##    4:        5-FU & Bortezomib      0.675      0.582      0.482      0.516
##    5:        5-FU & Bortezomib      0.845      0.799      0.799      0.759
##   ---
## 3796: geldanamycin & Topotecan      0.090      0.043      0.112      0.103
## 3797: geldanamycin & Topotecan      0.025      0.022      0.029      0.023
## 3798: geldanamycin & Topotecan      0.151      0.146      0.144      0.171
## 3799: geldanamycin & Topotecan      0.142      0.166      0.124      0.175
## 3800: geldanamycin & Topotecan      0.091      0.084      0.134      0.119
```

```
colnames(assay(tre, 'sensitivity', withDimnames=TRUE))
```

```
##  [1] "drug1id"          "drug2id"          "drug1dose"        "drug2dose"
##  [5] "cellid"           "batchid"          "combination_name" "viability1"
##  [9] "viability2"       "viability3"       "viability4"
```

```
assay(tre, 'sensitivity', withDimnames=TRUE)
```

```
## Key: <drug1id, drug2id, drug1dose, drug2dose, cellid, batchid>
##            drug1id    drug2id drug1dose drug2dose cellid batchid
##             <char>     <char>     <num>     <num> <char>   <int>
##    1:         5-FU Bortezomib    0.3500   0.00045  A2058       1
##    2:         5-FU Bortezomib    0.3500   0.00045  A2780       1
##    3:         5-FU Bortezomib    0.3500   0.00045   A375       1
##    4:         5-FU Bortezomib    0.3500   0.00045   A427       1
##    5:         5-FU Bortezomib    0.3500   0.00045  CAOV3       1
##   ---
## 3796: geldanamycin  Topotecan    0.0223   0.07750  A2058       1
## 3797: geldanamycin  Topotecan    0.0223   0.07750  A2780       1
## 3798: geldanamycin  Topotecan    0.0223   0.07750   A375       1
## 3799: geldanamycin  Topotecan    0.0223   0.07750   A427       1
## 3800: geldanamycin  Topotecan    0.0223   0.07750  CAOV3       1
##               combination_name viability1 viability2 viability3 viability4
##                         <char>      <num>      <num>      <num>      <num>
##    1:        5-FU & Bortezomib      0.814      0.754      0.765      0.849
##    2:        5-FU & Bortezomib      0.214      0.195      0.186      0.223
##    3:        5-FU & Bortezomib      1.064      1.080      1.082      1.009
##    4:        5-FU & Bortezomib      0.675      0.582      0.482      0.516
##    5:        5-FU & Bortezomib      0.845      0.799      0.799      0.759
##   ---
## 3796: geldanamycin & Topotecan      0.090      0.043      0.112      0.103
## 3797: geldanamycin & Topotecan      0.025      0.022      0.029      0.023
## 3798: geldanamycin & Topotecan      0.151      0.146      0.144      0.171
## 3799: geldanamycin & Topotecan      0.142      0.166      0.124      0.175
## 3800: geldanamycin & Topotecan      0.091      0.084      0.134      0.119
```

# 7 References

# Appendix

1. O’Neil J, Benita Y, Feldman I, Chenard M, Roberts B, Liu Y, Li J, Kral A,
   Lejnine S, Loboda A, Arthur W, Cristescu R, Haines BB, Winter C, Zhang T,
   Bloecher A, Shumway SD. An Unbiased Oncology Compound Screen to Identify Novel
   Combination Strategies. Mol Cancer Ther. 2016 Jun;15(6):1155-62.
   doi: 10.1158/1535-7163.MCT-15-0843. Epub 2016 Mar 16. PMID: 26983881.
2. Heewon Seo, Denis Tkachuk, Chantal Ho, Anthony Mammoliti, Aria Rezaie,
   Seyed Ali Madani Tonekaboni, Benjamin Haibe-Kains, SYNERGxDB: an integrative
   pharmacogenomic portal to identify synergistic drug combinations for precision
   oncology, Nucleic Acids Research, Volume 48, Issue W1, 02 July 2020, Pages
   W494–W501, <https://doi.org/10.1093/nar/gkaa421>

# A sessionInfo

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
##  [1] data.table_1.17.8           CoreGx_2.14.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [7] IRanges_2.44.0              S4Vectors_0.48.0
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] BiocGenerics_0.56.0         generics_0.1.4
## [13] formatR_1.14                BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] farver_2.1.2                S7_0.2.0
##  [5] bitops_1.0-9                fastmap_1.2.0
##  [7] BumpyMatrix_1.18.0          shinyjs_2.1.0
##  [9] promises_1.4.0              digest_0.6.37
## [11] mime_0.13                   lifecycle_1.0.4
## [13] cluster_2.1.8.1             statmod_1.5.1
## [15] magrittr_2.0.4              compiler_4.5.1
## [17] rlang_1.1.6                 sass_0.4.10
## [19] tools_4.5.1                 igraph_2.2.1
## [21] yaml_2.3.10                 knitr_1.50
## [23] htmlwidgets_1.6.4           S4Arrays_1.10.0
## [25] bench_1.1.4                 DelayedArray_0.36.0
## [27] marray_1.88.0               RColorBrewer_1.1-3
## [29] abind_1.4-8                 BiocParallel_1.44.0
## [31] KernSmooth_2.23-26          grid_4.5.1
## [33] relations_0.6-15            caTools_1.18.3
## [35] xtable_1.8-4                ggplot2_4.0.0
## [37] scales_1.4.0                gtools_3.9.5
## [39] dichromat_2.0-0.1           MultiAssayExperiment_1.36.0
## [41] cli_3.6.5                   rmarkdown_2.30
## [43] crayon_1.5.3                otel_0.2.0
## [45] visNetwork_2.1.4            BiocBaseUtils_1.12.0
## [47] sets_1.0-25                 cachem_1.1.0
## [49] parallel_4.5.1              BiocManager_1.30.26
## [51] XVector_0.50.0              vctrs_0.6.5
## [53] Matrix_1.7-4                jsonlite_2.0.0
## [55] slam_0.1-55                 lsa_0.73.3
## [57] bookdown_0.45               limma_3.66.0
## [59] jquerylib_0.1.4             glue_1.8.0
## [61] codetools_0.2-20            DT_0.34.0
## [63] cowplot_1.2.0               gtable_0.3.6
## [65] later_1.4.4                 shinydashboard_0.7.3
## [67] tibble_3.3.0                pillar_1.11.1
## [69] htmltools_0.5.8.1           gplots_3.2.0
## [71] fgsea_1.36.0                R6_2.6.1
## [73] evaluate_1.0.5              shiny_1.11.1
## [75] lattice_0.22-7              backports_1.5.0
## [77] SnowballC_0.7.1             httpuv_1.6.16
## [79] bslib_0.9.0                 fastmatch_1.1-6
## [81] Rcpp_1.1.0                  SparseArray_1.10.0
## [83] checkmate_2.3.3             xfun_0.53
## [85] piano_2.26.0                pkgconfig_2.0.3
```