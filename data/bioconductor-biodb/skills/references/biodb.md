# An introduction to biodb

Pierrick Roger

#### 29 October 2025

#### Abstract

A quick tour of the various features of *biodb*: creating connectors,
accessing entries, converting entries into a data frame, searching for
entries, dealing with mass spectra, existing connectors.

#### Package

biodb 1.18.0

# 1 Introduction

*biodb* provides access to **chemical**, **biological** and **mass spectra**
databases, and offers a **development framework** that facilitates the writing
of new connectors.

Numerous public databases are available for scientific research, but few are
easily accessible from a programming environment, making it hard for most of
researchers to use their content.
Developing a code to access databases and keep it up to date with the
evolutions of these databases are two time consuming tasks. It is thus greatly
preferable to use an already developed package.

In R, packages with public database connectors, most often propose to connect
to one single database with a specific API, and do not offer a **development
framework** (Szöcs et al. [2020](#ref-szocs2020_webchem); Guha [2016](#ref-guha2016_rpubchem); Tenenbaum and Volkening [2020](#ref-tenenbaum2020_keggrest); Carey [2020](#ref-carey2020_hmbdQuery); Soudy et al. [2020](#ref-soudy2020_uniprotr); Carlson and Ortutay [2020](#ref-carlson2020_uniprotws); Wolf [2019](#ref-wolf2019_chemspiderapi); Stravs et al. [2013](#ref-stravs2013_rmassbank); Drost and Paszkowski [2017](#ref-drost2017_biomartr); Winter, Chamberlain, and Guangchun [2020](#ref-winter2020_rentrez)).
When a package does not offer the services the scientific programmer
requests, or when no package exists for the targeted database, a homemade
solution is implemented.
In such a case, the effort spent is often lost and never capitalized for
sharing with the community.

*biodb* has been designed and implemented as a unified API to databases and a
**development framework**.
The unified API allows to access the databases in a standardized way, while
allowing original database services to be accessed directly.
The **development framework** has for goal to help scientific programmers to
capitalize on their effort to improve connection to databases and share it with
the community.
The framework lowers the effort needed by the developer to improve an existing
connector or implement a new one.
Most *biodb* connectors are distributed inside separated packages, that are
automatically recognized by the main package.
This system of extensions gives more independence for developing new connectors
and distributing them, since developers do not need to request any modification
inside the main package code.

The database services provided by the unified API of *biodb*: retrieval of
entries, chemical and biological compound search by mass and name, mass spectra
annotation, MSMS matching, read and write of in-house local databases.
Alongside the unified API, connectors to public databases furnishes also access
to specific web services through dedicated methods.
See table [1](#tab:features) for a list of available features.

Table 1: *biodb* main features
These are generic features (i.e.: present at top-level of architecture or present in at least a group of connectors), unless specified otherwise.

| Features | Description |
| --- | --- |
| Getting entries | Retrieval of entries by accession number, and search for entries. |
| Merging entries | Merging entries from different databases. |
| Exporting entries | Extracting values of entries into data frames. |
| In-house db reading | Connection to a local in-house database (CSV file or SQLite database file). |
| In-house db writing | Writing entries into an in-house database. |
| LCMS annotation | Annotating an LCMS spectra using a spectra database. |
| MSMS matching | Search for matching MSMS spectra into a database. |
| Framework | Development framework for easy implementation of *biodb* extension packages. |
| Pathways | Search for biological pathways with KEGG (see *biodbKegg* extension). |

In this vignette we will introduce you to the basic features of *biodb*,
allowing you to be quickly productive.
Pointers toward other documents are included along the way, for going into
details or learning advanced features.

For a complete list of features, see vignette
[Details on biodb](details.html)
for a more more information of *biodb* with other packages.

# 2 Installation

Install using Bioconductor:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install('biodb')
```

# 3 Initialization

The first step in using *biodb*, is to create an instance of the
main class `BiodbMain`. This is done by calling the constructor of
the class:

```
mybiodb <- biodb::newInst()
```

During this step the configuration is set up, the cache system is initialized
and extension packages are loaded.

We will see at the end of this vignette that the *biodb* instance needs to be
terminated with a call to the `terminate()` method.

# 4 Connecting to a database

In *biodb* the connection to a database is handled by a connector instance that
you can get from the factory.
Here we create a connector to a CSV file database (see [2](#tab:compTable) for
content) of chemical compounds:

```
compUrl <- system.file("extdata", "chebi_extract.tsv", package='biodb')
compdb <- mybiodb$getFactory()$createConn('comp.csv.file', url=compUrl)
```

```
## Loading required package: biodb
```

The two parameters passed to the `createConn()` are the identifier of the
Compound CSV File connector class and the URL (i.e.: the path) of the TSV file.
With this connector instance you are now able to get entries and search for
them by either name or mass.
By default *biodb* will use the TAB character as separator for the CSV file,
and the standard *biodb* entry field names for the column names of the file.
To load a CSV file with a different separator and custom column names, you have
to define them inside the connector instance.
Please see vignette
[Details on biodb](details.html)
for learning how to define the character separator and the column names of your
file inside the CSV database connector.

To get a list of all connector classes available with their names, call an
instance of `BiodbDbsInfo`:

```
mybiodb$getDbsInfo()
```

```
## Biodb databases information instance.
## The following databases are defined:
##   comp.csv.file: Compound CSV File connector class.
##   comp.sqlite: Compound SQLite connector class.
##   mass.csv.file: Mass spectra CSV File connector class.
##   mass.sqlite: Mass spectra SQLite connector class.
```

To get available informations on these database connectors, use the `get()`
method:

```
mybiodb$getDbsInfo()$get(c('comp.csv.file', 'mass.csv.file'))
```

```
## $comp.csv.file
## Compound CSV File class.
##   Class: comp.csv.file.
##   Package: biodb.
##   Description: A connector to handle a compound database stored inside a CSV file. It is possible to choose the separator for the CSV file, as well as match the column names with the biodb entry fields..
##   Entry content type: tsv.
##
## $mass.csv.file
## Mass spectra CSV File class.
##   Class: mass.csv.file.
##   Package: biodb.
##   Description: A connector to handle a mass spectra database stored inside a CSV file. It is possible to choose the separator for the CSV file, as well as match the column names with the biodb entry fields...
##   Entry content type: tsv.
```

Here we must stop a moment to explain the use of the `$` operator.
This operator is the call operator for the object oriented programming (OOP)
model *R5*.
This OOP model is different from *S4*.
While in *S4* the generic methods and their specialization are defined apart
from the classes, in *R5* the two are defined together and a method definition
is necessarily part of a class. Each method being part of a class, it is also
part of each object of the class, hence the use of a call operator (`$`) on a
object.
In the code line above, the call `mybiodb$getFactory()` means to call
`getFactory()` method onto `biodb` instance.
This call will return another object (of class `BiodbFactory`) on which we call
the method `createConn()`.
Note that while in *R Studio*, you will benefit from the autosuggestion system
to find all methods available for an instance.
See vignette
[Details on biodb](details.html)
for explanations about the OOP model chosen for *biodb*.

Table 2: Excerpt from compound database TSV file.

| accession | formula | monoisotopic.mass | molecular.mass | kegg.compound.id | name | smiles | description |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1018 | C2H8AsNO3 | 168.97201 | 169.012 | C07279 | 2-Aminoethylarsonate | `NCC[As](O)(O)=O` |  |
| 1390 | C8H8O2 | 136.05243 | 136.148 | C06224 | 3,4-Dihydroxystyrene | `Oc1ccc(C=C)cc1O` |  |
| 1456 | C3H9NO2 | 91.06333 | 91.109 | C06057 | 3-aminopropane-1,2-diol | `NC[C@H](O)CO` |  |
| 1549 | C3H5O3R | 89.02387 | 89.070 | C03834 | 3-hydroxymonocarboxylic acid | `OC([*])CC(O)=O` |  |
| 1894 | C5H11NO | 101.08406 | 101.147 | C10974 | 4-Methylaminobutanal | `CNCCCC=O` |  |
| 1932 | C6H6NR | 92.05002 | 92.119 | C03084 | 4-Substituted aniline | `Nc1ccc([*])cc1` |  |

# 5 Accessing entries

The main goal of the connector is to retrieve entries. The two main generic
ways to retrieve entries with a connector are: getting entries using their
identifiers (accession numbers), and searching for entries by name.
For compound databases, there is also the possibility to search for entries by
mass.

In this section we will show how to get entries, convert them into a data frame
and search for entries by name.
For advanced features about entries, please see the vignette `entries`.

## 5.1 Getting entries

Getting entries is done with the `getEntry()` methods to which you pass a
character vector of one or more identifiers:

```
entries <- compdb$getEntry(c('1018', '1549', '64679'))
entries
```

```
## [[1]]
## Biodb Compound CSV File entry instance 1018.
##
## [[2]]
## Biodb Compound CSV File entry instance 1549.
##
## [[3]]
## Biodb Compound CSV File entry instance 64679.
```

The returned objects are instances of `BiodbEntry`, which means you can call on
them all functions available in this class. Here is an example of calling the
method `getFieldsJson()` on the first entry in order to get a JSON
representation of the entry values:

```
entries[[1]]$getFieldsAsJson()
```

```
## {
##   "accession": "1018",
##   "formula": "C2H8AsNO3",
##   "monoisotopic.mass": 168.97201,
##   "molecular.mass": 169.012,
##   "kegg.compound.id": "C07279",
##   "name": "2-Aminoethylarsonate",
##   "smiles": "NCC[As](O)(O)=O",
##   "description": "",
##   "comp.csv.file.id": "1018"
## }
```

## 5.2 Getting all fields defined inside an entry

To get the list of fields defined (i.e.: with an associated value) in an entry,
call the method `getFieldNames()` on the entry instance:

```
fields <- entries[[1]]$getFieldNames()
fields
```

```
## [1] "accession"         "comp.csv.file.id"  "description"
## [4] "formula"           "kegg.compound.id"  "molecular.mass"
## [7] "monoisotopic.mass" "name"              "smiles"
```

The names returned correspond to all the fields for which a value has been
parsed from the content returned by the database.
To know the significance of each field you have to call the method `get()` on
the `BiodbEntryFields` class:

```
mybiodb$getEntryFields()$get(fields)
```

```
## $accession
## Entry field "accession".
##   Description: The accession number of the entry.
##   Class: character.
##   Case: sensitive.
##   Cardinality: one.
##   Aliases: NA.
##
## $comp.csv.file.id
## Entry field "comp.csv.file.id".
##   Description: Compound CSV File ID
##   Class: character.
##   Case: insensitive.
##   Type: id.
##   Cardinality: many.
##   Duplicates: forbidden.
##   Aliases: NA.
##
## $description
## Entry field "description".
##   Description: The decription of the entry.
##   Class: character.
##   Case: sensitive.
##   Cardinality: one.
##   Aliases: protdesc.
##
## $formula
## Entry field "formula".
##   Description: Empirical chemical formula of a compound.
##   Class: character.
##   Case: sensitive.
##   Cardinality: one.
##   Aliases: NA.
##
## $kegg.compound.id
## Entry field "kegg.compound.id".
##   Description: KEGG Compound ID
##   Class: character.
##   Case: insensitive.
##   Type: id.
##   Cardinality: many.
##   Duplicates: forbidden.
##   Aliases: NA.
##
## $molecular.mass
## Entry field "molecular.mass".
##   Description: Molecular mass (also called molecular weight), in u (unified atomic mass units) or Da (Dalton). It is computed from the atomic masses of each nuclide present in the molecule, taking into account the various possible isotops of each atom. See https://en.wikipedia.org/wiki/Molecular_mass.
##   Class: double.
##   Type: mass.
##   Cardinality: one.
##   Aliases: mass, molecular.weight, compoundmass.
##
## $monoisotopic.mass
## Entry field "monoisotopic.mass".
##   Description: Monoisotopic mass, in u (unified atomic mass units) or Da (Dalton). It is computed using the mass of the primary isotope of the elements including the mass defect (mass difference between neutron and proton, and nuclear binding energy). Used with high resolution mass spectrometers. See https://en.wikipedia.org/wiki/Monoisotopic_mass.
##   Class: double.
##   Type: mass.
##   Cardinality: one.
##   Aliases: exact.mass.
##
## $name
## Entry field "name".
##   Description: The name of the entry.
##   Class: character.
##   Case: insensitive.
##   Type: name.
##   Cardinality: many.
##   Duplicates: forbidden.
##   Aliases: fullnames, synonyms.
##
## $smiles
## Entry field "smiles".
##   Description: SMILES.
##   Class: character.
##   Case: sensitive.
##   Cardinality: one.
##   Aliases: NA.
```

The `BiodbEntryFields` gathers all information about entry fields, the same way
the `BiodbDbsInfo` class gather information about all database connectors.

## 5.3 Getting field values from an entry

In *biodb* the definition of fields are global. Thus they are shared between
databases, and the same field will have the same name in two entries of two
different databases.

`getFieldValue()` is used to get the value of a field:

```
entries[[1]]$getFieldValue('formula')
```

```
## [1] "C2H8AsNO3"
```

## 5.4 Exporting entries into a data frame

Another way to access field values of entries, is to export them as a data
frame.

You can export the values of one single entry:

```
entryDf <- entries[[1]]$getFieldsAsDataframe()
```

See table [3](#tab:entryTable) for the exported data frame.

Table 3: Values of one entry of the compound database.

| accession | formula | monoisotopic.mass | molecular.mass | kegg.compound.id | name | smiles | description | comp.csv.file.id |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1018 | C2H8AsNO3 | 168.972 | 169.012 | C07279 | 2-Aminoethylarsonate | `NCC[As](O)(O)=O` |  | 1018 |

Or export the values of a set of entries:

```
entriesDf <- mybiodb$entriesToDataframe(entries)
```

See table [4](#tab:entriesTable) for the exported data frame.

Table 4: Values of a set of entries from the compound database.

| accession | formula | monoisotopic.mass | molecular.mass | kegg.compound.id | name | smiles | description | comp.csv.file.id |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1018 | C2H8AsNO3 | 168.97201 | 169.0120 | C07279 | 2-Aminoethylarsonate | `NCC[As](O)(O)=O` |  | 1018 |
| 1549 | C3H5O3R | 89.02387 | 89.0700 | C03834 | 3-hydroxymonocarboxylic acid | `OC([*])CC(O)=O` |  | 1549 |
| 64679 | C9H18NO11P | 347.06180 | 347.2131 | NA | O-(alpha-D-mannose-1-phosphoryl)-L-serine | `N[C@@H](COP(O)(=O)O[C@H]1O[C@H](CO)[C@@H](O)[C@H](O)[C@@H]1O)C(O)=O` | A mannose phosphate in which in which the phosphate group of alpha-D-mannose 1-phosphate is esterified by the alcoholic hydroxy group of L-serine. | 64679 |

## 5.5 Searching for entries

In *biodb* each database connector offers the possibility to search entries by
their name, although some database servers do not propose this feature in which
case an explicit error message will be returned.

The generic method to search for entries is `searchForEntries()`, it
returns a character vector containing identifiers of matchings entries.
Here is a search on the *name* field:

```
compdb$searchForEntries(list(name='deoxyguanosine'))
```

```
## [1] 40304
```

If you want to search into a compound database, the connector has certainly
implemented the search on mass.
With our example database, we can search on the *monoisotopic.mass* field:

```
compdb$searchForEntries(list(name='guanosine', monoisotopic.mass=list(value=283.0917, delta=0.1)))
```

```
## [1] 16750 40304
```

When searching by mass, the *biodb* mass field to use must be selected. To get
a list of all *biodb* mass fields, run:

```
mybiodb$getEntryFields()$getFieldNames(type='mass')
```

```
## [1] "average.mass"      "molecular.mass"    "monoisotopic.mass"
## [4] "nominal.mass"
```

To get information of any of these fields run:

```
mybiodb$getEntryFields()$get('nominal.mass')
```

```
## Entry field "nominal.mass".
##   Description: Nominal mass, in u (unified atomic mass units) or Da (Dalton). It is computed using the mass number of the most abundant isotope of each atom. Typically used with low resolution mass spectrometers. See https://en.wikipedia.org/wiki/Monoisotopic_mass.
##   Class: integer.
##   Type: mass.
##   Cardinality: one.
##   Aliases: NA.
```

Then to know if you can run a search on a connector on a particular mass field
run:

```
compdb$isSearchableByField('average.mass')
```

```
## [1] FALSE
```

To get a list of all searchable field for a connector, run:

```
compdb$getSearchableFields()
```

```
## [1] "name"              "monoisotopic.mass" "molecular.mass"
```

# 6 Mass spectra

Another feature of *biodb* is the ability to annotate an LCMS spectra or to
search for an MSMS spectra matching.
In this section we will see the annotation of LCMS spectra and matching of MSMS
spectra.

## 6.1 Mass spectra annotation with a compound database

Using a compound database it is possible to annotate a mass spectra.
You will get a data frame containing your data frame input (with your M/Z
values) completed by annotations from the compound database.

Here is an input data frame containing M/Z values in negative mode:

```
ms.tsv <- system.file("extdata", "ms.tsv", package='biodb')
mzdf <- read.table(ms.tsv, header=TRUE, sep="\t")
```

See table [5](#tab:mzdfTable) for the content of the input.

Table 5: Input M/Z values.

| mz | rt |
| --- | --- |
| 282.0839 | 334 |
| 283.0623 | 872 |
| 346.0546 | 536 |
| 821.3964 | 740 |

We know call the `annotateMzValues()` method to run the annotation:

```
annotMz <- compdb$annotateMzValues(mzdf, mz.tol=1e-3, ms.mode='neg')
```

The `mz.tol` option sets the M/Z tolerance (by default in plain value, thus
`±0.1` in our case).
The `ms.mode` option defines the MS mode of your input spectrum, either
positive (`'pos'`) or negative (`'neg'`).
See table [6](#tab:annotMzTable) for the content of the input.
Note that in the output, columns coming from the database have their name
prefixed with the database name.

Table 6: Annotation output.

| mz | rt | comp.csv.file.id |
| --- | --- | --- |
| 282.0839 | 334 | 16750 |
| 282.0839 | 334 | 35485 |
| 282.0839 | 334 | 40304 |
| 283.0623 | 872 | NA |
| 346.0546 | 536 | 64679 |
| 821.3964 | 740 | 15939 |

## 6.2 Mass spectra annotation with a mass spectra database

Using a mass spectra database it is as well possible to annotate a simple mass
spectrum, but also LCMS data (i.e. including retention times).

First we have to open a connection to the LCMS database (see table
[7](#tab:lcms3Table) for content):

```
massUrl <- system.file("extdata", "massbank_extract_lcms_3.tsv", package='biodb')
massDb <- mybiodb$getFactory()$createConn('mass.csv.file', url=massUrl)
```

Table 7: Excerpt from LCMS database TSV file.

| accession | smiles | mass | ms.mode | peak.mztheo | peak.intensity | chrom.col.id | chrom.rt | chrom.rt.unit | formula | name | ms.level |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PR010001 | NCCCN | 74.0844 | pos | 73 | 999 | mycol | 78 | s | C3H10N2 | 1,3-Diaminopropane | 1 |
| PR010001 | NCCCN | 74.0844 | pos | 86 | 407 | mycol | 78 | s | C3H10N2 | 1,3-Diaminopropane | 1 |
| PR010001 | NCCCN | 74.0844 | pos | 174 | 481 | mycol | 78 | s | C3H10N2 | 1,3-Diaminopropane | 1 |
| PR010002 | OCC(O)(C1)OCC(O)(CO)O1 | 180.0634 | pos | 73 | 999 | mycol | 189 | s | C6H12O6 | 1,3-Dihydroxyacetone dimer | 1 |
| PR010003 | OC(=O)CC(O)(CC(O)=O)C(O)=O | 192.0270 | pos | 73 | 999 | mycol | 45 | s | C6H8O7 | Citric acid | 1 |
| PR010004 | COc(c1)c(O)ccc(C=CC(O)=O)1 | 194.0579 | pos | 73 | 999 | mycol | 90 | s | C10H10O4 | trans-4-Hydroxy-3-methoxycinnamate | 1 |

Then we create an input data frame containing M/Z and RT (retention time) values:

```
input <- data.frame(mz=c(73.01, 116.04, 174.2), rt=c(79, 173, 79))
```

Unit of the retention times will be set when running the annotation.

And finally we call the annotation function `searchMsPeaks()`:

```
annotMzRt <- massDb$searchMsPeaks(input, mz.tol=0.1, rt.unit='s', rt.tol=10, match.rt=TRUE, prefix='match.')
```

The `mz.tol` option sets the M/Z tolerance (by default in plain value, thus
`±0.1` in our case).
The `match.rt` option enables matching on retention time values, `rt.unit` sets
the unit (`"s"` for second and `"min"` for minute) and `rt.tol` the tolerance.
The `prefix` option specifies a custom prefix to use for naming the database
columns inside the output.
See table [8](#tab:annotMzRtTable) for the results.

Table 8: Results of annotation of an M/Z and RT input file with an LCMS database.

| mz | rt | match.accession | match.chrom.col.id | match.chrom.col.name | match.chrom.rt | match.chrom.rt.unit | match.formula | match.mass.csv.file.id | match.molecular.mass | match.ms.level | match.ms.mode | match.name | match.peak.intensity | match.peak.mz | match.peak.mztheo | match.smiles |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 73.01 | 79 | PR010001 | mycol | mycol | 78 | s | C3H10N2 | PR010001 | 74.0844 | 1 | pos | 1,3-Diaminopropane | 999 | 73 | 73 | NCCCN |
| 116.04 | 173 | PR010006 | mycol | mycol | 176 | s | C9H13NO2 | PR010006 | 167.0946 | 1 | pos | (R)-(-)-Phenylephrine | 999 | 116 | 116 | CNC[C@H](O)c(c1)cc(O)cc1 |
| 174.20 | 79 | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA | NA |

## 6.3 MS/MS matching

*biodb* also offers an MS/MS matching service, allowing you to compare your
experimental spectrum with an MS/MS database.

First we open a connection to a MS/MS TSV file database:

```
msmsUrl <- system.file("extdata", "massbank_extract_msms.tsv", package='biodb')
msmsdb <- mybiodb$getFactory()$createConn('mass.csv.file', url=msmsUrl)
```

See table [9](#tab:msmsTable) for content.

Table 9: Excerpt from MS/MS database TSV file.

| accession | formula | ms.mode | ms.level | peak.mztheo | peak.intensity | peak.relative.intensity | peak.formula | msprecannot | msprecmz | peak.attr |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| AU200951 | C7H5F3O | neg | 2 | 161.0238 | 38176 | 100.000000 | C7H4F3O- | [M-H]- | 161.022 | [M-H]- |
| AU200951 | C7H5F3O | neg | 2 | 162.0274 | 1780 | 4.604605 | C6[13]CH4F3O- | [M-H]- | 161.022 | NA |
| AU200951 | C7H5F3O | neg | 2 | 141.0167 | 616 | 1.601602 | C7H3F2O- | [M-H]- | 161.022 | NA |
| AU200952 | C7H5F3O | neg | 2 | 161.0246 | 6180 | 100.000000 | C7H4F3O- | [M-H]- | 161.022 | [M-H]- |
| AU200952 | C7H5F3O | neg | 2 | 141.0184 | 1384 | 22.322320 | C7H3F2O- | [M-H]- | 161.022 | NA |
| AU200952 | C7H5F3O | neg | 2 | 121.0113 | 1180 | 19.019020 | C7H2FO- | [M-H]- | 161.022 | NA |

Then we define an input spectrum:

```
input <- data.frame(mz=c(286.1456, 287.1488, 288.1514), rel.int=c(100, 45, 18))
```

The `rel.int` column contains relative intensity in percentage.

Finally we run the matching service by calling the `msmsSearch()` method:

```
matchDf <- msmsdb$msmsSearch(input, precursor.mz=286.1438, mz.tol=0.1, mz.tol.unit='plain', ms.mode='pos')
```

The `precursor.mz` option sets the M/Z value for the precursor of your input
spectrum.
The `mz.tol` option defines the M/Z tolerance (by default in plain value, thus
`±0.1` in our case).
The `mz.tol.unit` option defines the mode use for the tolerance: either
`'plain'` or `'ppm'`.
The `ms.mode` option defines the MS mode of your input spectrum, either
positive (`'pos'`) or negative (`'neg'`).

The results are displayed in table [10](#tab:msmsMatchingTable).
Each matching spectrum found in database is listed in the output data frame,
along with a score and the number of the matched peak inside the database
spectrum (the column names are the peak numbers of the input spectrum).

Table 10: Results of running spectrum matching service on an MS/MS database.

| id | score | peak.1 | peak.2 | peak.3 |
| --- | --- | --- | --- | --- |
| AU158001 | 0.7804225 | 1 | 2 | 3 |
| AU158002 | 0.7429446 | 1 | 2 | 4 |

# 7 Sources of documentation

Several vignettes are available. Among them you will find help for creating
a new connector, adding an entry field to an existing connector, searching
for compounds by mass or name, merging entries from different databases into
a local database, annotation of a mass spectrum, etc.
See table [11](#tab:vignettes) for a full list of available vignettes.

Table 11: List of *biodb* available vignettes with their short description.

| Vignette | Description |
| --- | --- |
| [An introduction to biodb](biodb.html) | Introduction to the biodb package. |
| [Details on biodb](details.html) | Details on general *biodb* usage and principles |
| [Manipulating entry objects](entries.html) | Manipulating entry objects |

You will also find documentation inside the R manual of the package. All
*biodb* public classes have a help page. On each help page you will find a
description of the class as well as a list of all its public methods with a
description of their parameters. For instance you can get help on `BiodbEntry`
class with `?BiodbEntry`.

# 8 Closing biodb instance

When done with your *biodb* instance you have to terminate it, in order to
ensure release of resources (file handles, database connection, etc):

```
mybiodb$terminate()
```

# 9 Session information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] biodb_1.18.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3      sass_0.4.10         bitops_1.0-9
##  [4] RSQLite_2.4.3       stringi_1.8.7       hms_1.1.4
##  [7] digest_0.6.37       magrittr_2.0.4      evaluate_1.0.5
## [10] bookdown_0.45       fastmap_1.2.0       blob_1.2.4
## [13] R.oo_1.27.1         plyr_1.8.9          jsonlite_2.0.0
## [16] R.utils_2.13.0      progress_1.2.3      sqlq_1.0.1
## [19] DBI_1.2.3           BiocManager_1.30.26 XML_3.99-0.19
## [22] jquerylib_0.1.4     cli_3.6.5           rlang_1.1.6
## [25] chk_0.10.0          crayon_1.5.3        R.methodsS3_1.8.2
## [28] bit64_4.6.0-1       withr_3.0.2         cachem_1.1.0
## [31] yaml_2.3.10         tools_4.5.1         memoise_2.0.1
## [34] sched_1.0.3         vctrs_0.6.5         R6_2.6.1
## [37] lifecycle_1.0.4     stringr_1.5.2       bit_4.6.0
## [40] pkgconfig_2.0.3     bslib_0.9.0         glue_1.8.0
## [43] Rcpp_1.1.0          lgr_0.5.0           xfun_0.53
## [46] knitr_1.50          fscache_1.0.5       htmltools_0.5.8.1
## [49] rmarkdown_2.30      compiler_4.5.1      prettyunits_1.2.0
## [52] askpass_1.2.1       RCurl_1.98-1.17     openssl_2.3.4
```

# References

Carey, Vince. 2020. “HmdbQuery: Utilities for Exploration of Human Metabolome Database. R Package Version 1.10.0.” <https://doi.org/10.18129/B9.bioc.hmdbQuery>.

Carlson, Marc, and Csaba Ortutay. 2020. “UniProt.ws: R Interface to Uniprot Web Services. R Package Version 2.30.0.” <https://doi.org/10.18129/B9.bioc.UniProt.ws>.

Drost, Hajk-Georg, and Jerzy Paszkowski. 2017. “Biomartr: Genomic Data Retrieval with R.” *Bioinformatics* 33 (8): 1216–7. <https://doi.org/10.1093/bioinformatics/btw821>.

Guha, Rajarshi. 2016. “Rpubchem: Interface to the Pubchem Collection. R Package Version 1.5.10.” [https://CRAN.R-project.org/package=rpubchem](https://CRAN.R-project.org/package%3Drpubchem).

Soudy, Mohamed, Ali Mostafa Anwar, Eman Ali Ahmed, Aya Osama, Shahd Ezzeldin, Sebaey Mahgoub, and Sameh Magdeldin. 2020. “UniprotR: Retrieving and Visualizing Protein Sequence and Functional Information from Universal Protein Resource (Uniprot Knowledgebase).” *Journal of Proteomics* 213: 103613. [https://doi.org/https://doi.org/10.1016/j.jprot.2019.103613](https://doi.org/https%3A//doi.org/10.1016/j.jprot.2019.103613).

Stravs, Michael A., Emma L. Schymanski, Heinz P. Singer, and Juliane Hollender. 2013. “Automatic Recalibration and Processing of Tandem Mass Spectra Using Formula Annotation.” *Journal of Mass Spectrometry* 48 (1): 89–99. [https://doi.org/https://doi.org/10.1002/jms.3131](https://doi.org/https%3A//doi.org/10.1002/jms.3131).

Szöcs, Eduard, Tamás Stirling, Eric Scott, Andreas Scharmüller, and Ralf Schäfer. 2020. “Webchem : An R Package to Retrieve Chemical Information from the Web.” *Journal of Statistical Software* 93 (May). <https://doi.org/10.18637/jss.v093.i13>.

Tenenbaum, Dan, and Jeremy Volkening. 2020. “KEGGREST: Client-Side Rest Access to the Kyoto Encyclopedia of Genes and Genomes (Kegg). R Package Version 1.30.1.” <https://doi.org/10.18129/B9.bioc.KEGGREST>.

Winter, David, Scott Chamberlain, and Han Guangchun. 2020. “Rentrez: ’Entrez’ in R.” [https://CRAN.R-project.org/package=rentrez](https://CRAN.R-project.org/package%3Drentrez).

Wolf, Raoul. 2019. “ChemSpider Api R Package.” <https://github.com/NIVANorge/chemspiderapi>.