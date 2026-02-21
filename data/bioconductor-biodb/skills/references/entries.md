# Manipulating entry objects

Pierrick Roger

#### 29 October 2025

#### Abstract

This vignette shows you how to interact with BiodbEntry objects. How to retrieve them, get the values stored in them, search for entries by name, convert them to a data frame, and copy into a new local database.

#### Package

biodb 1.18.0

# 1 Introduction

The contents of the database entries, once parsed, are stored by *biodb* into
objects of the class `BiodbEntry`.

The `BiodbEntry` class is an RC (aka R5) class (not S3 or S4).
RC instances are never copied implicitly by R.
This means that each instance is shared by all parts of your code.
If one part of your code modifies or deletes a `BiodbEntry` object, any other
part of your code will be affected by this modification.
See [Reference classes](http://adv-r.had.co.nz/R5.html) and the vignette
[Details on biodb](details.html)
, for more explanations.

*biodb* uses identifiers (IDs) to retrieve and manipulate `BiodbEntry`
instances indirectly. Those identifiers are, in case of web server databases,
the official accession numbers provided by these databases.

We will see in this vignette how to
**retrieve** entries using a connector,
manipulate **fields** of an entry,
**free** entry instances from memory and delete their content from disk cache,
**search** for entries in a database,
**convert** entries into data frames or JSON,
**copying** all entries of a database into a new empty database,
and **merge** the entries of several databases into a single database.

To start we need to instantiate the package main class:

```
mybiodb <- biodb::BiodbMain$new()
```

For the demonstration of this vignette, we will use an extract of the
[ChEBI](https://www.ebi.ac.uk/chebi/) (Hastings et al. [2012](#ref-hastings2012_chebi)) database, that we
have put inside a TSV file.

Here is the TSV file:

```
chebi.tsv <- system.file("extdata", "chebi_extract.tsv", package='biodb')
```

And now we create the connector to this CSV File database:

```
chebi <- mybiodb$getFactory()$createConn('comp.csv.file', url=chebi.tsv)
```

# 2 Getting entries

To retrieve entries, we first need to get their identifiers.
We can either ask the connector to give us the full list of all entry
identifiers:

```
chebi$getEntryIds()
```

```
##  [1] "1018"  "1390"  "1456"  "1549"  "1894"  "1932"  "1997"  "10561" "15939"
## [10] "16750" "35485" "40304" "64679"
```

or get the first n entry IDs:

```
chebi$getEntryIds(max.results=3)
```

```
## [1] "1018" "1390" "1456"
```

Another way of getting entry IDs, is to search the database using a filter.
Here we search for entries by name:

```
chebi$searchForEntries(list(name='deoxyguanosine'))
```

```
## [1] 40304
```

Now we search by mass:

```
chebi$searchForEntries(list(monoisotopic.mass=list(value=283.0917, delta=0.1)))
```

```
## [1] 16750 35485 40304
```

And finally by both name and mass:

```
chebi$searchForEntries(list(name='guanosine', monoisotopic.mass=list(value=283.0917, delta=0.1)))
```

```
## [1] 16750 40304
```

Now that we have identifiers, we can get entry objects.
First we choose two identifiers:

```
ids <- chebi$searchForEntries(list(monoisotopic.mass=list(value=283.0917, delta=0.1)), max.results=2)
```

Then we get the corresponding list of entry instances:

```
chebi$getEntry(ids)
```

```
## [[1]]
## Biodb Compound CSV File entry instance 16750.
##
## [[2]]
## Biodb Compound CSV File entry instance 35485.
```

# 3 Entry fields

The content of an entry is stored inside its fields.
To access the values contained in the fields or information about the fields,
you need to call methods onto the entry object.

First, we get an entry object:

```
e <- chebi$getEntry(ids[[1]])
```

To get a list of all fields having a value inside an entry object, call:

```
e$getFieldNames()
```

```
## [1] "accession"         "comp.csv.file.id"  "description"
## [4] "formula"           "kegg.compound.id"  "molecular.mass"
## [7] "monoisotopic.mass" "name"              "smiles"
```

To get the value of a field, call:

```
e$getFieldValue('name')
```

```
## [1] "guanosine"
```

To get all the mass fields, run:

```
e$getFieldsByType('mass')
```

```
## [1] "monoisotopic.mass" "molecular.mass"
```

If you want more information about a field, you have to access the entry fields
instance:

```
mybiodb$getEntryFields()$get('monoisotopic.mass')
```

```
## Entry field "monoisotopic.mass".
##   Description: Monoisotopic mass, in u (unified atomic mass units) or Da (Dalton). It is computed using the mass of the primary isotope of the elements including the mass defect (mass difference between neutron and proton, and nuclear binding energy). Used with high resolution mass spectrometers. See https://en.wikipedia.org/wiki/Monoisotopic_mass.
##   Class: double.
##   Type: mass.
##   Cardinality: one.
##   Aliases: exact.mass.
```

# 4 Conversion

Entries may be converted into lists of values, data frames, and JSON.

To convert a single entry into a data frame, run:

```
x <- e$getFieldsAsDataframe()
```

Table 1: Converting an entry to a data frame

| accession | formula | monoisotopic.mass | molecular.mass | kegg.compound.id | name | smiles | description | comp.csv.file.id |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 16750 | C10H13N5O5 | 283.0917 | 283.2409 | C00387 | guanosine | Nc1nc2n(cnc2c(=O)[nH]1)[C@@H]1O[C@H](CO)[C@(**???**)](O)[C@H]1O | A purine nucleoside in which guanine is attached to ribofuranose via a beta-N(9)-glycosidic bond. | 16750 |

Several options are available to control which fields are output.
For instance, you can select the set of fields by their name:

```
x <- e$getFieldsAsDataframe(fields=c('name', 'monoisotopic.mass'))
```

Table 2: Selecting fields by names

| name | monoisotopic.mass |
| --- | --- |
| guanosine | 283.0917 |

or by their type:

```
x <- e$getFieldsAsDataframe(fields.type='mass')
```

Table 3: Selecting fields by type

| monoisotopic.mass | molecular.mass |
| --- | --- |
| 283.0917 | 283.2409 |

In case of entries with fields that contain multiple values, other options are
useful.
This is the case for mass spectrum entries.
If we get an entry from an extract of [Massbank](https://massbank.eu/MassBank/) (Horai et al. [2010](#ref-horai2010_massbank)):

```
massSqliteFile <- system.file("extdata", "generated", "massbank_extract_full.sqlite", package='biodb')
massbank <- mybiodb$getFactory()$createConn('mass.sqlite', url=massSqliteFile)
massbankEntry <- massbank$getEntry('KNA00776')
```

we can select the fields of cardinality one only:

```
x <- massbankEntry$getFieldsAsDataframe(only.card.one=TRUE)
```

Table 4: Selecting fields with only one value

| accession | chrom.col.id | chrom.col.name | chrom.rt | chrom.rt.unit | formula | inchi | inchikey | monoisotopic.mass | ms.level | ms.mode | smiles |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| KNA00776 | TOSOH TSKgel ODS-100V 5um Part no. 21456 | TOSOH TSKgel ODS-100V 5um Part no. 21456 | 329.8511 | s | C10H13N5O5 | InChI=1S/C10H13N5O5/c11-10-13-7-4(8(19)14-10)12-2-15(7)9-6(18)5(17)3(1-16)20-9/h2-3,5-6,9,16-18H,1H2,(H3,11,13,14,19)/t3-,5-,6-,9-/m1/s1 |  | 283.0917 | 1 | neg | C1=NC2=C(N1[C@H]3[C@(**???**)](%5BC%40%40H%5D%28%5BC%40H%5D%28O3%29CO%29O)O)N=C(NC2=O)N |

or get all the fields, in which case fields with more than one value will have
their values concatenated into a string using a default separator:

```
x <- massbankEntry$getFieldsAsDataframe(only.card.one=FALSE)
```

Table 5: Concatenate multiple values

| accession | cas.id | chebi.id | chrom.col.id | chrom.col.name | chrom.rt | chrom.rt.unit | formula | inchi | inchikey | kegg.compound.id | mass.csv.file.id | mass.sqlite.id | monoisotopic.mass | ms.level | ms.mode | name | smiles | peak.mz | peak.mztheo | peak.relative.intensity |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| KNA00776 | 118-00-3 | 16750 | TOSOH TSKgel ODS-100V 5um Part no. 21456 | TOSOH TSKgel ODS-100V 5um Part no. 21456 | 329.8511 | s | C10H13N5O5 | InChI=1S/C10H13N5O5/c11-10-13-7-4(8(19)14-10)12-2-15(7)9-6(18)5(17)3(1-16)20-9/h2-3,5-6,9,16-18H,1H2,(H3,11,13,14,19)/t3-,5-,6-,9-/m1/s1 |  | C00387 | KNA00776 | KNA00776 | 283.0917 | 1 | neg | Guanosine | C1=NC2=C(N1[C@H]3[C@(**???**)](%5BC%40%40H%5D%28%5BC%40H%5D%28O3%29CO%29O)O)N=C(NC2=O)N | 282.083871;150.041965;133.015586 | 282.083871;150.041965;133.015586 | 100;56;5 |

It is also possible to get one value per line for fields with cardinality
greater than one:

```
x <- massbankEntry$getFieldsAsDataframe(only.card.one=FALSE, flatten=FALSE)
```

Table 6: Output one value per row

| accession | cas.id | chebi.id | chrom.col.id | chrom.col.name | chrom.rt | chrom.rt.unit | formula | inchi | inchikey | kegg.compound.id | mass.csv.file.id | mass.sqlite.id | monoisotopic.mass | ms.level | ms.mode | name | smiles | peak.mz | peak.mztheo | peak.relative.intensity |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| KNA00776 | 118-00-3 | 16750 | TOSOH TSKgel ODS-100V 5um Part no. 21456 | TOSOH TSKgel ODS-100V 5um Part no. 21456 | 329.8511 | s | C10H13N5O5 | InChI=1S/C10H13N5O5/c11-10-13-7-4(8(19)14-10)12-2-15(7)9-6(18)5(17)3(1-16)20-9/h2-3,5-6,9,16-18H,1H2,(H3,11,13,14,19)/t3-,5-,6-,9-/m1/s1 |  | C00387 | KNA00776 | KNA00776 | 283.0917 | 1 | neg | Guanosine | C1=NC2=C(N1[C@H]3[C@(**???**)](%5BC%40%40H%5D%28%5BC%40H%5D%28O3%29CO%29O)O)N=C(NC2=O)N | 282.0839 | 282.0839 | 100 |
| KNA00776 | 118-00-3 | 16750 | TOSOH TSKgel ODS-100V 5um Part no. 21456 | TOSOH TSKgel ODS-100V 5um Part no. 21456 | 329.8511 | s | C10H13N5O5 | InChI=1S/C10H13N5O5/c11-10-13-7-4(8(19)14-10)12-2-15(7)9-6(18)5(17)3(1-16)20-9/h2-3,5-6,9,16-18H,1H2,(H3,11,13,14,19)/t3-,5-,6-,9-/m1/s1 |  | C00387 | KNA00776 | KNA00776 | 283.0917 | 1 | neg | Guanosine | C1=NC2=C(N1[C@H]3[C@(**???**)](%5BC%40%40H%5D%28%5BC%40H%5D%28O3%29CO%29O)O)N=C(NC2=O)N | 150.0420 | 150.0420 | 56 |
| KNA00776 | 118-00-3 | 16750 | TOSOH TSKgel ODS-100V 5um Part no. 21456 | TOSOH TSKgel ODS-100V 5um Part no. 21456 | 329.8511 | s | C10H13N5O5 | InChI=1S/C10H13N5O5/c11-10-13-7-4(8(19)14-10)12-2-15(7)9-6(18)5(17)3(1-16)20-9/h2-3,5-6,9,16-18H,1H2,(H3,11,13,14,19)/t3-,5-,6-,9-/m1/s1 |  | C00387 | KNA00776 | KNA00776 | 283.0917 | 1 | neg | Guanosine | C1=NC2=C(N1[C@H]3[C@(**???**)](%5BC%40%40H%5D%28%5BC%40H%5D%28O3%29CO%29O)O)N=C(NC2=O)N | 133.0156 | 133.0156 | 5 |

And we can limit the number of values for each field:

```
x <- massbankEntry$getFieldsAsDataframe(only.card.one=FALSE, limit=1)
```

Table 7: Output only one value for each field

| accession | cas.id | chebi.id | chrom.col.id | chrom.col.name | chrom.rt | chrom.rt.unit | formula | inchi | inchikey | kegg.compound.id | mass.csv.file.id | mass.sqlite.id | monoisotopic.mass | ms.level | ms.mode | name | smiles | peak.mz | peak.mztheo | peak.relative.intensity |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| KNA00776 | 118-00-3 | 16750 | TOSOH TSKgel ODS-100V 5um Part no. 21456 | TOSOH TSKgel ODS-100V 5um Part no. 21456 | 329.8511 | s | C10H13N5O5 | InChI=1S/C10H13N5O5/c11-10-13-7-4(8(19)14-10)12-2-15(7)9-6(18)5(17)3(1-16)20-9/h2-3,5-6,9,16-18H,1H2,(H3,11,13,14,19)/t3-,5-,6-,9-/m1/s1 |  | C00387 | KNA00776 | KNA00776 | 283.0917 | 1 | neg | Guanosine | C1=NC2=C(N1[C@H]3[C@(**???**)](%5BC%40%40H%5D%28%5BC%40H%5D%28O3%29CO%29O)O)N=C(NC2=O)N | 282.0839 | 282.0839 | 100 |

A list of several entries can also be convert into a data frame:

```
entries <- chebi$getEntry(chebi$getEntryIds(max.results=3))
x <- mybiodb$entriesToDataframe(entries)
```

Table 8: Converting a list of entries into a data frame

| accession | formula | monoisotopic.mass | molecular.mass | kegg.compound.id | name | smiles | description | comp.csv.file.id |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 16750 | C10H13N5O5 | 283.0917 | 283.2409 | C00387 | guanosine | Nc1nc2n(cnc2c(=O)[nH]1)[C@@H]1O[C@H](CO)[C@(**???**)](O)[C@H]1O | A purine nucleoside in which guanine is attached to ribofuranose via a beta-N(9)-glycosidic bond. | 16750 |
| 35485 | C10H13N5O5 | 283.0917 | 283.2409 | NA | adenosine 1-oxide | Nc1c2ncn([C@@H]3O[C@H](CO)[C@(**???**)](O)[C@H]3O)c2ncn1=O |  | 35485 |
| 1018 | C2H8AsNO3 | 168.9720 | 169.0120 | C07279 | 2-Aminoethylarsonate | NCC[As](O)(O)=O |  | 1018 |

or to JSON

```
mybiodb$entriesToJson(entries)
```

```
## [1] "{\n  \"accession\": \"16750\",\n  \"formula\": \"C10H13N5O5\",\n  \"monoisotopic.mass\": 283.0917,\n  \"molecular.mass\": 283.2409,\n  \"kegg.compound.id\": \"C00387\",\n  \"name\": \"guanosine\",\n  \"smiles\": \"Nc1nc2n(cnc2c(=O)[nH]1)[C@@H]1O[C@H](CO)[C@@H](O)[C@H]1O\",\n  \"description\": \"A purine nucleoside in which guanine is attached to ribofuranose via a beta-N(9)-glycosidic bond.\",\n  \"comp.csv.file.id\": \"16750\"\n}"
## [2] "{\n  \"accession\": \"35485\",\n  \"formula\": \"C10H13N5O5\",\n  \"monoisotopic.mass\": 283.0917,\n  \"molecular.mass\": 283.2409,\n  \"name\": \"adenosine 1-oxide\",\n  \"smiles\": \"Nc1c2ncn([C@@H]3O[C@H](CO)[C@@H](O)[C@H]3O)c2ncn1=O\",\n  \"description\": \"\",\n  \"comp.csv.file.id\": \"35485\"\n}"
## [3] "{\n  \"accession\": \"1018\",\n  \"formula\": \"C2H8AsNO3\",\n  \"monoisotopic.mass\": 168.97201,\n  \"molecular.mass\": 169.012,\n  \"kegg.compound.id\": \"C07279\",\n  \"name\": \"2-Aminoethylarsonate\",\n  \"smiles\": \"NCC[As](O)(O)=O\",\n  \"description\": \"\",\n  \"comp.csv.file.id\": \"1018\"\n}"
```

# 5 Memory usage

Each time you call the `getEntry()` method, *biodb* checks first if the entries
you requested are already in memory.
If this is the case, it returns them, otherwise it looks into the cache on disk
for downloaded contents.
If the entry contents have never been downloaded, the connector contacts the
database to get the missing contents and save them into the cache.
From the contents, *biodb* create the corresponding `BiodbEntry` objects.

You may want either to free memory usage by removing entry objects in memory,
or delete entry contents from cache in order to download more recent versions
of entries.
To remove entries from memory, run:

```
chebi$deleteAllEntriesFromVolatileCache()
```

To remove entry content files in cache folder, run:

```
chebi$deleteAllEntriesFromPersistentCache()
```

To remove all cache files attached to a connector, run:

```
chebi$deleteWholePersistentCache()
```

This will also delete the caching of all HTTP requests and all downloads,
including the possible download of the database, thus forcing to download again
data from the database.

# 6 Copy

Entry objects from any connector can be copied into a writable connector.

If we create a new connector to a SQLite file that does not exist:

```
sqliteOutputFile <- tempfile(pattern="biodb_copy_entries_new_db", fileext='.sqlite')
newDbConn <- mybiodb$getFactory()$createConn('comp.sqlite', url=sqliteOutputFile)
```

And allow modifications for this connector:

```
newDbConn$allowEditing()
newDbConn$allowWriting()
```

We can copy all entries from another connector into it:

```
mybiodb$copyDb(chebi, newDbConn)
```

And finally write the entries into the SQLite file:

```
newDbConn$write()
```

# 7 Merging databases

In this vignette we will merge entries from three different databases into a
single database.

For the demonstration we will use the ChEBI connector already created, and
create two other connectors.

A connector to the [Uniprot](https://www.uniprot.org/)
(Consortium [2016](#ref-uniprotConsortium2016UniProtKB)) database:

```
uniprot.tsv <- system.file("extdata", "uniprot_extract.tsv", package='biodb')
uniprot <- mybiodb$getFactory()$createConn('comp.csv.file', url=uniprot.tsv)
```

A connector to the [ExPASy enzyme](https://enzyme.expasy.org/)
(Bairoch [2000](#ref-bairoch2000_expasy)) database:

```
expasy.tsv <- system.file("extdata", "expasy_enzyme_extract.tsv", package='biodb')
expasy <- mybiodb$getFactory()$createConn('comp.csv.file', url=expasy.tsv)
```

## 7.1 Merging the entries

We will now merge the entries into a single database.
However we will use differently the entries of the three databases.
The ChEBI and Uniprot will just be put together since they have no link between them.
But we will use the ExPASy entries to add missing fields to the uniprot entries.
We will be able to do that because the uniprot entries have a field
`'expasy.enzyme.id'` that we can use to make the link with the ExPASy entries.

We will write a function that takes a Uniprot entry and search for the ExPASy
entry referenced and take missing fields from it:

```
completeUniprotEntry <- function(e) {
    expasy.id <- e$getFieldValue('expasy.enzyme.id');
    if ( ! is.na(expasy.id)) {
        ex <- expasy$getEntry(expasy.id)
        if ( ! is.null(ex)) {
            for (field in c('catalytic.activity', 'cofactor')) {
                v <- ex$getFieldValue(field)
                if ( ! is.na(v) && length(v) > 0)
                    e$setFieldValue(field, v)
            }
        }
    }
}
```

Remember that we use RC (Reference Classes, or R5) OOP model in biodb.
This means that we use references to objects.
Thus we can modify an instance at any place inside the code.

Now we will get all entries from Uniprot and run the function to complete all entries:

```
uniprot.entries <- uniprot$getEntry(uniprot$getEntryIds())
invisible(lapply(uniprot.entries, completeUniprotEntry))
```

Finally we get all entries from our ChEBI extract, merge all our entries into a
single data frame and save it in a file:

```
chebi.entries <- chebi$getEntry(chebi$getEntryIds())
all.entries.df <- mybiodb$entriesToDataframe(c(chebi.entries, uniprot.entries))
output.file <- tempfile(pattern="biodb_merged_entries", fileext='.tsv')
write.table(all.entries.df, file=output.file, sep="\t", row.names=FALSE)
```

Table 9: Merged data

| accession | formula | monoisotopic.mass | molecular.mass | kegg.compound.id | name | smiles | description | comp.csv.file.id | gene.symbol | expasy.enzyme.id | kegg.genes.id | aa.seq.length | aa.seq | catalytic.activity | cofactor |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1018 | C2H8AsNO3 | 168.97201 | 169.012 | C07279 | 2-Aminoethylarsonate | NCC[As](O)(O)=O |  | 1018 | NA | NA | NA | NA | NA | NA | NA |
| 1390 | C8H8O2 | 136.05243 | 136.148 | C06224 | 3,4-Dihydroxystyrene | Oc1ccc(C=C)cc1O |  | 1390 | NA | NA | NA | NA | NA | NA | NA |
| 1456 | C3H9NO2 | 91.06333 | 91.109 | C06057 | 3-aminopropane-1,2-diol | NC[C@H](O)CO |  | 1456 | NA | NA | NA | NA | NA | NA | NA |
| 1549 | C3H5O3R | 89.02387 | 89.070 | C03834 | 3-hydroxymonocarboxylic acid | OC([\*])CC(O)=O |  | 1549 | NA | NA | NA | NA | NA | NA | NA |
| 1894 | C5H11NO | 101.08406 | 101.147 | C10974 | 4-Methylaminobutanal | CNCCCC=O |  | 1894 | NA | NA | NA | NA | NA | NA | NA |
| 1932 | C6H6NR | 92.05002 | 92.119 | C03084 | 4-Substituted aniline | Nc1ccc([\*])cc1 |  | 1932 | NA | NA | NA | NA | NA | NA | NA |

## 7.2 Use a writable database

Instead of building the data frame, we could have used a writable database as
seen earlier.
Here is a new file database for which we enable edition (for inserting new
entries) and writing (for saving it onto disk):

```
newDbOutputFile <- tempfile(pattern="biodb_merged_entries_new_db", fileext='.tsv')
newDbConn <- mybiodb$getFactory()$createConn('comp.csv.file', url=newDbOutputFile)
newDbConn$allowEditing()
newDbConn$allowWriting()
```

Now we copy entries into this new database:

```
mybiodb$copyDb(chebi, newDbConn)
mybiodb$copyDb(uniprot, newDbConn)
```

And finally we write the database:

```
newDbConn$write()
```

# 8 Closing biodb instance

Do not forget to terminate your biodb instance once you are done with it:

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

Bairoch, A. 2000. “The Enzyme Database in 2000.” *Nucleic Acids Research* 28 (1): 304–5. <https://doi.org/10.1093/nar/28.1.304>.

Consortium, The UniProt. 2016. “UniProt: the universal protein knowledgebase.” *Nucleic Acids Research* 45 (D1): D158–D169. <https://doi.org/10.1093/nar/gkw1099>.

Hastings, Janna, Paula de Matos, Adriano Dekker, Marcus Ennis, Bhavana Harsha, Namrata Kale, Venkatesh Muthukrishnan, et al. 2012. “The ChEBI reference database and ontology for biologically relevant chemistry: enhancements for 2013.” *Nucleic Acids Research* 41 (D1): D456–D463. <https://doi.org/10.1093/nar/gks1146>.

Horai, Hisayuki, Masanori Arita, Shigehiko Kanaya, Yoshito Nihei, Tasuku Ikeda, Kazuhiro Suwa, Yuya Ojima, et al. 2010. “MassBank: A Public Repository for Sharing Mass Spectral Data for Life Sciences.” *Journal of Mass Spectrometry* 45 (7): 703–14. [https://doi.org/https://doi.org/10.1002/jms.1777](https://doi.org/https%3A//doi.org/10.1002/jms.1777).