org.EcSakai.eg.db

February 25, 2026

org.EcSakai.egACCNUM Map Entrez Gene identifiers to GenBank Accession Numbers

Description

org.EcSakai.egACCNUM is an R object that contains mappings between Entrez Gene identifiers
and GenBank accession numbers.

Details

This object is a simple mapping of Entrez Gene identifiers https://www.ncbi.nlm.nih.gov/
entrez/query.fcgi?db=gene to all possible GenBank accession numbers.
Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2025-Sep24

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.EcSakai.egACCNUM
# Get the entrez gene identifiers that are mapped to an ACCNUM
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the ACCNUM for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}
#For the reverse map ACCNUM2EG:
# Convert to a list
xx <- as.list(org.EcSakai.egACCNUM2EG)

1

2

if(length(xx) > 0){

org.EcSakai.egALIAS2EG

# Gets the entrez gene identifiers for the first five Entrez Gene IDs
xx[1:5]
# Get the first one
xx[[1]]

}

org.EcSakai.egALIAS2EG

Map between Common Gene Symbol Identifiers and Entrez Gene

Description

org.EcSakai.egALIAS is an R object that provides mappings between common gene symbol iden-
tifiers and entrez gene identifiers.

Details

Each gene symbol maps to a named vector containing the corresponding entrez gene identifier. The
name of the vector corresponds to the gene symbol. Since gene symbols are sometimes redundantly
assigned in the literature, users are cautioned that this map may produce multiple matching results
for a single gene symbol. Users should map back from the entrez gene IDs produced to determine
which result is the one they want when this happens.

Because of this problem with redundant assigment of gene symbols, is it never advisable to use
gene symbols as primary identifiers.

This mapping includes ALL gene symbols including those which are already listed in the SYMBOL
map. The SYMBOL map is meant to only list official gene symbols, while the ALIAS maps are
meant to store all used symbols.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2025-Sep24

References

https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
# Convert the object to a list
xx <- as.list(org.EcSakai.egALIAS2EG)
# Remove pathway identifiers that do not map to any entrez gene id
xx <- xx[!is.na(xx)]
if(length(xx) > 0){

# The entrez gene identifiers for the first two elements of XX

org.EcSakai.eg.db

xx[1:2]
# Get the first one
xx[[1]]

}

3

org.EcSakai.eg.db

Bioconductor annotation data package

Description

Welcome to the org.EcSakai.eg.db annotation Package. This is an organism specific package. The
purpose is to provide detailed information about the species abbreviated in the second part of the
package name org.EcSakai.eg.db. This package is updated biannually.
Objects in this package are accessed using the select() interface. See ?select in the AnnotationDbi
package for details.

See Also

• AnnotationDb-class for use of keys(), columns() and select().

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
columns(org.EcSakai.eg.db)

## Bimap interface:
## The 'old style' of interacting with these objects is manipulation as
## bimaps. While this approach is still available we strongly encourage the
## use of select().
ls("package:org.EcSakai.eg.db")

org.EcSakai.egENZYME Map between Entrez Gene IDs and Enzyme Commission (EC) Num-

bers

Description

org.EcSakai.egENZYME is an R object that provides mappings between entrez gene identifiers and
EC numbers.

Details

Each entrez gene identifier maps to a named vector containing the EC number that corresponds
to the enzyme produced by that gene. The name corresponds to the entrez gene identifier. If this
information is unknown, the vector will contain an NA.
Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

4

org.EcSakai.egENZYME

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In org.EcSakai.egENZYME2EG, EC is dropped from the Enzyme Commission numbers.

Enzyme Commission numbers have corresponding names that describe the functions of enzymes
in such a way that EC x is a more general description than EC x.y that in turn is a more general
description than EC x.y.z. The top level EC numbers and names are listed below:

EC 1 oxidoreductases

EC 2 transferases

EC 3 hydrolases

EC 4 lyases

EC 5 isomerases

EC 6 ligases
The EC name for a given EC number can be viewed at http://www.chem.qmul.ac.uk/iupac/
jcbn/index.html#6

Mappings between entrez gene identifiers and enzyme identifiers were obtained using files provided
by: KEGG GENOME ftp://ftp.genome.jp/pub/kegg/genomes With a date stamp from the source of:
2011-Mar15

For the reverse map, each EC number maps to a named vector containing the entrez gene identifier
that corresponds to the gene that produces that enzyme. The name of the vector corresponds to the
EC number.

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.EcSakai.egENZYME
# Get the entrez gene identifiers that are mapped to an EC number
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the ENZYME for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}
# For the reverse map:
# Convert to a list
xx <- as.list(org.EcSakai.egENZYME2EG)
if(length(xx) > 0){

# Gets the entrez gene identifiers for the first five enzyme
#commission numbers

org.EcSakai.egGENENAME

xx[1:5]
# Get the first one
xx[[1]]

}

5

org.EcSakai.egGENENAME

Map between Entrez Gene IDs and Genes

Description

org.EcSakai.egGENENAME is an R object that maps entrez gene identifiers to the corresponding
gene name.

Details

Each entrez gene identifier maps to a named vector containing the gene name. The vector name
corresponds to the entrez gene identifier. If the gene name is unknown, the vector will contain an
NA.

Gene names currently include both the official (validated by a nomenclature committee) and pre-
ferred names (interim selected for display) for genes. Efforts are being made to differentiate the
two by adding a name to the vector.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2025-Sep24

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.EcSakai.egGENENAME
# Get the gene names that are mapped to an entrez gene identifier
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the GENE NAME for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

6

org.EcSakai.egGO

org.EcSakai.egGO

Maps between Entrez Gene IDs and Gene Ontology (GO) IDs

Description

org.EcSakai.egGO is an R object that provides mappings between entrez gene identifiers and the
GO identifiers that they are directly associated with. This mapping and its reverse mapping do NOT
associate the child terms from the GO ontology with the gene. Only the directly evidenced terms
are represented here.

org.EcSakai.egGO2ALLEGS is an R object that provides mappings between a given GO iden-
tifier and all of the Entrez Gene identifiers annotated at that GO term OR TO ONE OF IT’S
CHILD NODES in the GO ontology. Thus, this mapping is much larger and more inclusive than
org.EcSakai.egGO2EG.

Details

If org.EcSakai.egGO is cast as a list, each Entrez Gene identifier is mapped to a list of lists. The
names on the outer list are GO identifiers. Each inner list consists of three named elements: GOID,
Ontology, and Evidence.

The GOID element matches the GO identifier named in the outer list and is included for convenience
when processing the data using ’lapply’.

The Ontology element indicates which of the three Gene Ontology categories this identifier belongs
to. The categories are biological process (BP), cellular component (CC), and molecular function
(MF).

The Evidence element contains a code indicating what kind of evidence supports the association of
the GO identifier to the Entrez Gene id. Some of the evidence codes in use include:

IMP: inferred from mutant phenotype

IGI: inferred from genetic interaction

IPI: inferred from physical interaction

ISS: inferred from sequence similarity

IDA: inferred from direct assay

IEP: inferred from expression pattern

IEA: inferred from electronic annotation

TAS: traceable author statement

NAS: non-traceable author statement

ND: no biological data available

IC: inferred by curator

A more complete listing of evidence codes can be found at:
http://www.geneontology.org/GO.evidence.shtml

If org.EcSakai.egGO2ALLEGS or org.EcSakai.egGO2EG is cast as a list, each GO term maps to
a named vector of entrez gene identifiers and evidence codes. A GO identifier may be mapped to
the same entrez gene identifier more than once but the evidence code can be different. Mappings
between Gene Ontology identifiers and Gene Ontology terms and other information are available in
a separate data package named GO.

org.EcSakai.egGO

7

Whenever any of these mappings are cast as a data.frame, all the results will be output in an appro-
priate tabular form.

Mappings between entrez gene identifiers and GO information were obtained through their map-
pings to Entrez Gene identifiers. NAs are assigned to entrez gene identifiers that can not be mapped
to any Gene Ontology information. Mappings between Gene Ontology identifiers an Gene Ontol-
ogy terms and other information are available in a separate data package named GO.

All mappings were based on data provided by: Gene Ontology http://current.geneontology.org/ontology/go-
basic.obo With a date stamp from the source of: 2025-07-22

For GO2ALL style mappings, the intention is to return all the genes that are the same kind of
term as the parent term (based on the idea that they are more specific descriptions of the general
term). However because of this intent, not all relationship types will be counted as offspring for this
mapping. Only "is a" and "has a" style relationships indicate that the genes from the child terms
would be the same kind of thing.

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

See Also

• org.EcSakai.egGO2ALLEGS
• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.EcSakai.egGO
# Get the entrez gene identifiers that are mapped to a GO ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Try the first one
got <- xx[[1]]
got[[1]][["GOID"]]
got[[1]][["Ontology"]]
got[[1]][["Evidence"]]

}
# For the reverse map:
# Convert to a list
xx <- as.list(org.EcSakai.egGO2EG)
if(length(xx) > 0){

# Gets the entrez gene ids for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets the entrez gene ids for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}
# For org.EcSakai.egGO2ALLEGS

8

org.EcSakai.egMAPCOUNTS

xx <- as.list(org.EcSakai.egGO2ALLEGS)
if(length(xx) > 0){

# Gets the Entrez Gene identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets all the Entrez Gene identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

org.EcSakai.egMAPCOUNTS

Number of mapped keys for the maps in package org.EcSakai.eg.db

Description

org.EcSakai.egMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each
map in package org.EcSakai.eg.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

• mappedkeys
• count.mappedkeys
• checkMAPCOUNTS
• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
org.EcSakai.egMAPCOUNTS
mapnames <- names(org.EcSakai.egMAPCOUNTS)
org.EcSakai.egMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package org.EcSakai.eg.db
checkMAPCOUNTS("org.EcSakai.eg.db")

org.EcSakai.egORGANISM

9

org.EcSakai.egORGANISM

The Organism for org.EcSakai.eg

Description

org.EcSakai.egORGANISM is an R object that contains a single item: a character string that names
the organism for which org.EcSakai.eg was built.

Details

Although the package name is suggestive of the organism for which it was built, org.EcSakai.egORGANISM
provides a simple way to programmatically extract the organism name.

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
org.EcSakai.egORGANISM

org.EcSakai.egPATH

Mappings between Entrez Gene identifiers and KEGG pathway iden-
tifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms. org.EcSakai.egPATH maps entrez gene identifiers to the identifiers used by KEGG for path-
ways

Details

Each KEGG pathway has a name and identifier. Pathway name for a given pathway identifier can
be obtained using the KEGG data package that can either be built using AnnBuilder or downloaded
from Bioconductor http://www.bioconductor.org.
Graphic presentations of pathways are searchable at url http://www.genome.ad.jp/kegg/pathway.html
by using pathway identifiers as keys.

Mappings were based on data provided by: KEGG GENOME ftp://ftp.genome.jp/pub/kegg/genomes
With a date stamp from the source of: 2011-Mar15

References

http://www.genome.ad.jp/kegg/

10

See Also

org.EcSakai.egPMID

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.EcSakai.egPATH
# Get the entrez gene identifiers that are mapped to a KEGG pathway ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the PATH for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

# For the reverse map:
# Convert the object to a list
xx <- as.list(org.EcSakai.egPATH2EG)
# Remove pathway identifiers that do not map to any entrez gene id
xx <- xx[!is.na(xx)]
if(length(xx) > 0){

# The entrez gene identifiers for the first two elements of XX
xx[1:2]
# Get the first one
xx[[1]]

}

org.EcSakai.egPMID

Map between Entrez Gene Identifiers and PubMed Identifiers

Description

org.EcSakai.egPMID is an R object that provides mappings between entrez gene identifiers and
PubMed identifiers.

Details

Each entrez gene identifier is mapped to a named vector of PubMed identifiers. The name associated
with each vector corresponds to the entrez gene identifier. The length of the vector may be one or
greater, depending on how many PubMed identifiers a given entrez gene identifier is mapped to. An
NA is reported for any entrez gene identifier that cannot be mapped to a PubMed identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2025-Sep24

11

org.EcSakai.egREFSEQ

References

https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=PubMed

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.EcSakai.egPMID
# Get the entrez gene identifiers that are mapped to any PubMed ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0){

# The entrez gene identifiers for the first two elements of XX
xx[1:2]
# Get the first one
xx[[1]]
if(interactive() && !is.null(xx[[1]]) && !is.na(xx[[1]])

&& require(annotate)){
# Gets article information as XML files
xmls <- pubmed(xx[[1]], disp = "data")
# Views article information using a browser
pubmed(xx[[1]], disp = "browser")

}

}
# For the reverse map:
# Convert the object to a list
xx <- as.list(org.EcSakai.egPMID2EG)
if(length(xx) > 0){

# The entrez gene identifiers for the first two elements of XX
xx[1:2]
# Get the first one
xx[[1]]
if(interactive() && require(annotate)){

# Gets article information as XML files for a PubMed id
xmls <- pubmed(names(xx)[1], disp = "data")
# Views article information using a browser
pubmed(names(xx)[1], disp = "browser")

}

}

org.EcSakai.egREFSEQ Map between Entrez Gene Identifiers and RefSeq Identifiers

Description

org.EcSakai.egREFSEQ is an R object that provides mappings between entrez gene identifiers and
RefSeq identifiers.

12

Details

org.EcSakai.egREFSEQ

Each entrez gene identifier is mapped to a named vector of RefSeq identifiers. The name represents
the entrez gene identifier and the vector contains all RefSeq identifiers that can be mapped to that
entrez gene identifier. The length of the vector may be one or greater, depending on how many
RefSeq identifiers a given entrez gene identifier can be mapped to. An NA is reported for any entrex
gene identifier that cannot be mapped to a RefSeq identifier at this time.

RefSeq identifiers differ in format according to the type of record the identifiers are for as shown
below:

NG\_XXXXX: RefSeq accessions for genomic region (nucleotide) records

NM\_XXXXX: RefSeq accessions for mRNA records

NC\_XXXXX: RefSeq accessions for chromosome records

NP\_XXXXX: RefSeq accessions for protein records

XR\_XXXXX: RefSeq accessions for model RNAs that are not associated with protein products

XM\_XXXXX: RefSeq accessions for model mRNA records

XP\_XXXXX: RefSeq accessions for model protein records

Where XXXXX is a sequence of integers.
NCBI https://www.ncbi.nlm.nih.gov/RefSeq/ allows users to query the RefSeq database us-
ing RefSeq identifiers.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2025-Sep24

References

https://www.ncbi.nlm.nih.gov https://www.ncbi.nlm.nih.gov/RefSeq/

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.EcSakai.egREFSEQ
# Get the entrez gene identifiers that are mapped to any RefSeq ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the REFSEQ for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

# For the reverse map:
x <- org.EcSakai.egREFSEQ2EG
# Get the RefSeq identifier that are mapped to an entrez gene ID

org.EcSakai.egSYMBOL

13

mapped_seqs <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_seqs])
if(length(xx) > 0) {

# Get the entrez gene for the first five Refseqs
xx[1:5]
# Get the first one
xx[[1]]

}

org.EcSakai.egSYMBOL Map between Entrez Gene Identifiers and Gene Symbols

Description

org.EcSakai.egSYMBOL is an R object that provides mappings between entrez gene identifiers and
gene abbreviations.

Details

Each entrez gene identifier is mapped to the a common abbreviation for the corresponding gene. An
NA is reported if there is no known abbreviation for a given gene.
Symbols typically consist of 3 letters that define either a single gene (ABC) or multiple genes
(ABC1, ABC2, ABC3). Gene symbols can be used as key words to query public databases such as
Entrez Gene.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2025-Sep24

References

https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.EcSakai.egSYMBOL
# Get the gene symbol that are mapped to an entrez gene identifiers
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the SYMBOL for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

14

org.EcSakai.eg_dbconn

}
# For the reverse map:
x <- org.EcSakai.egSYMBOL2EG
# Get the entrez gene identifiers that are mapped to a gene symbol
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the entrez gene ID for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

org.EcSakai.eg_dbconn Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

org.EcSakai.eg_dbconn()
org.EcSakai.eg_dbfile()
org.EcSakai.eg_dbschema(file="", show.indices=FALSE)
org.EcSakai.eg_dbInfo()

Arguments

file

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

org.EcSakai.eg_dbconn returns a connection object to the package annotation DB. IMPORTANT:
Don’t call dbDisconnect on the connection object returned by org.EcSakai.eg_dbconn or you
will break all the AnnDbObj objects defined in this package!

org.EcSakai.eg_dbfile returns the path (character string) to the package annotation DB (this is
an SQLite file).

org.EcSakai.eg_dbschema prints the schema definition of the package annotation DB.

org.EcSakai.eg_dbInfo prints other information about the package annotation DB.

org.EcSakai.eg_dbconn

Value

15

org.EcSakai.eg_dbconn: a DBIConnection object representing an open connection to the package
annotation DB.
org.EcSakai.eg_dbfile: a character string with the path to the package annotation DB.
org.EcSakai.eg_dbschema: none (invisible NULL).
org.EcSakai.eg_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

library(DBI)
## Count the number of rows in the "genes" table:
dbGetQuery(org.EcSakai.eg_dbconn(), "SELECT COUNT(*) FROM genes")

org.EcSakai.eg_dbschema()

org.EcSakai.eg_dbInfo()

org.EcSakai.egALIAS2EG, 2
org.EcSakai.egENZYME, 3
org.EcSakai.egENZYME2EG

(org.EcSakai.egENZYME), 3

org.EcSakai.egGENENAME, 5
org.EcSakai.egGO, 6
org.EcSakai.egGO2ALLEGS, 7
org.EcSakai.egGO2ALLEGS

(org.EcSakai.egGO), 6
org.EcSakai.egGO2EG (org.EcSakai.egGO),

6

org.EcSakai.egMAPCOUNTS, 8
org.EcSakai.egORGANISM, 9
org.EcSakai.egPATH, 9
org.EcSakai.egPATH2EG

(org.EcSakai.egPATH), 9

org.EcSakai.egPMID, 10
org.EcSakai.egPMID2EG

(org.EcSakai.egPMID), 10

org.EcSakai.egREFSEQ, 11
org.EcSakai.egREFSEQ2EG

(org.EcSakai.egREFSEQ), 11

org.EcSakai.egSYMBOL, 13
org.EcSakai.egSYMBOL2EG

(org.EcSakai.egSYMBOL), 13

Index

∗ datasets

org.EcSakai.eg.db, 3
org.EcSakai.eg_dbconn, 14
org.EcSakai.egACCNUM, 1
org.EcSakai.egALIAS2EG, 2
org.EcSakai.egENZYME, 3
org.EcSakai.egGENENAME, 5
org.EcSakai.egGO, 6
org.EcSakai.egMAPCOUNTS, 8
org.EcSakai.egORGANISM, 9
org.EcSakai.egPATH, 9
org.EcSakai.egPMID, 10
org.EcSakai.egREFSEQ, 11
org.EcSakai.egSYMBOL, 13

∗ utilities

org.EcSakai.eg_dbconn, 14

AnnDbObj, 14

cat, 14
checkMAPCOUNTS, 8
count.mappedkeys, 8

dbconn, 15
dbConnect, 15
dbDisconnect, 14
dbfile, 15
dbGetQuery, 15
dbInfo, 15
dbschema, 15

mappedkeys, 8

org.EcSakai.eg (org.EcSakai.eg.db), 3
org.EcSakai.eg.db, 3
org.EcSakai.eg_dbconn, 14
org.EcSakai.eg_dbfile

(org.EcSakai.eg_dbconn), 14

org.EcSakai.eg_dbInfo

(org.EcSakai.eg_dbconn), 14

org.EcSakai.eg_dbschema

(org.EcSakai.eg_dbconn), 14

org.EcSakai.egACCNUM, 1
org.EcSakai.egACCNUM2EG

(org.EcSakai.egACCNUM), 1

16

