☰
[ ]

[![SingleM logo](/singlem/sandpiper.png)](/singlem/)

## [SingleM](/singlem/)

S

* [Lyrebird (phage profiling)](/singlem/Lyrebird)
* [Installation](/singlem/Installation)
* [Glossary](/singlem/Glossary)
* [FAQ](/singlem/FAQ)
* [Usage](/singlem/tools)

+ [SingleM data](/singlem/tools/data)
+ [SingleM pipe](/singlem/tools/pipe)
+ [SingleM summarise](/singlem/tools/summarise)
+ [SingleM renew](/singlem/tools/renew)
+ [SingleM supplement](/singlem/tools/supplement)
+ [SingleM prokaryotic\_fraction](/singlem/tools/prokaryotic_fraction)
+ [SingleM appraise](/singlem/tools/appraise)
+ [Lyrebird data](/singlem/tools/lyrebird_data)
+ [Lyrebird pipe](/singlem/tools/lyrebird_pipe)

* [Advanced modes](/singlem/advanced)

+ [SingleM query](/singlem/advanced/query)
+ [SingleM makedb](/singlem/advanced/makedb)
+ [SingleM condense](/singlem/advanced/condense)
+ [SingleM seqs](/singlem/advanced/seqs)
+ [SingleM create](/singlem/advanced/create)
+ [SingleM metapackage](/singlem/advanced/metapackage)
+ [SingleM regenerate](/singlem/advanced/regenerate)
+ [Lyrebird condense](/singlem/advanced/lyrebird_condense)
+ [Lyrebird renew](/singlem/advanced/lyrebird_renew)

# singlem makedb

It can be useful in some situations to search for sequences in OTU tables. For instance, you may ask "is the most abundant OTU or anything similar in samples B, C or D?" To answer this question make a SingleM database from sample B, C & D's OTU tables:

```
singlem pipe -1 B.fq.gz --otu-table B.otu_table.csv
singlem pipe -1 C.fq.gz --otu-table C.otu_table.csv
singlem pipe -1 D.fq.gz --otu-table D.otu_table.csv
singlem makedb --otu-tables B.otu_table.csv C.otu_table.csv D.otu_table.csv --db BCD.sdb
```

`.sdb` is the conventional file extension for SingleM databases. Then to query this database with windows from sample A:

```
singlem pipe -1 A.fq.gz --otu-table A.otu_table.csv
singlem query --query-otu-table A.otu_table.csv --db BCD.sdb
```

# REQUIRED ARGUMENTS

**--otu-tables**, **--otu-table** *OTU\_TABLES* [*OTU\_TABLES* ...]

Make a db from these OTU tables

**--otu-tables-list** *OTU\_TABLES\_LIST*

Make a db from the OTU table files newline separated in this file

**--archive-otu-tables**, **--archive-otu-table** *ARCHIVE\_OTU\_TABLES* [*ARCHIVE\_OTU\_TABLES* ...]

Make a db from these archive tables

**--archive-otu-table-list** *ARCHIVE\_OTU\_TABLE\_LIST*

Make a db from the archive tables newline separated in this file

**--gzip-archive-otu-table-list** *GZIP\_ARCHIVE\_OTU\_TABLE\_LIST*

Make a db from the gzip'd archive tables newline separated in this
file

**--db** *DB*

Name of database to create e.g. tundra.sdb

# OTHER ARGUMENTS

**--threads** *THREADS*

Use this many threads where possible [default 1]

**--sequence-database-methods** {smafa-naive,annoy,scann,nmslib,scann-naive,none} [{smafa-naive,annoy,scann,nmslib,scann-naive,none} ...]

Index sequences using these methods. Note that specifying
"scann-naive" means "scann" databases will also be built
[default ['smafa-naive']]

**--sequence-database-types** {nucleotide,protein} [{nucleotide,protein} ...]

Index sequences using these types. [default: ['nucleotide']]

**--pregenerated-otu-sqlite-db** *PREGENERATED\_OTU\_SQLITE\_DB*

[for internal usage] remake the indices using this input SQLite
database

**--num-annoy-nucleotide-trees** *NUM\_ANNOY\_NUCLEOTIDE\_TREES*

make annoy nucleotide sequence indices with this ntrees [default
10]

**--num-annoy-protein-trees** *NUM\_ANNOY\_PROTEIN\_TREES*

make annoy protein sequence indices with this ntrees [default 10]

**--tmpdir** *TMPDIR*

[for internal usage] use this directory internally for working

# OTHER GENERAL OPTIONS

**--debug**

output debug information

**--version**

output version information and quit

**--quiet**

only output errors

**--full-help**

print longer help message

**--full-help-roff**

print longer help message in ROFF (manpage) format

# AUTHORS

> ```
> Ben J. Woodcroft, Centre for Microbiome Research, School of Biomedical Sciences, Faculty of Health, Queensland University of Technology
> Samuel Aroney, Centre for Microbiome Research, School of Biomedical Sciences, Faculty of Health, Queensland University of Technology
> Raphael Eisenhofer, Centre for Evolutionary Hologenomics, University of Copenhagen, Denmark
> Rossen Zhao, Centre for Microbiome Research, School of Biomedical Sciences, Faculty of Health, Queensland University of Technology
> ```

On this page

* [singlem makedb](#singlem-makedb)
* [REQUIRED ARGUMENTS](#required-arguments)
* [OTHER ARGUMENTS](#other-arguments)
* [OTHER GENERAL OPTIONS](#other-general-options)
* [AUTHORS](#authors)

Powered by [Doctave](https://cli.doctave.com)