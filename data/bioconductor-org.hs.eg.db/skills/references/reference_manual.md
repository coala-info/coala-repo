org.Hs.eg.db

February 11, 2026

org.Hs.egACCNUM

Map Entrez Gene identifiers to GenBank Accession Numbers

Description

org.Hs.egACCNUM is an R object that contains mappings between Entrez Gene identifiers and
GenBank accession numbers.

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
x <- org.Hs.egACCNUM
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
xx <- as.list(org.Hs.egACCNUM2EG)

1

2

if(length(xx) > 0){

org.Hs.egALIAS2EG

# Gets the entrez gene identifiers for the first five Entrez Gene IDs
xx[1:5]
# Get the first one
xx[[1]]

}

org.Hs.egALIAS2EG

Map between Common Gene Symbol Identifiers and Entrez Gene

Description

org.Hs.egALIAS is an R object that provides mappings between common gene symbol identifiers
and entrez gene identifiers.

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
xx <- as.list(org.Hs.egALIAS2EG)
# Remove pathway identifiers that do not map to any entrez gene id
xx <- xx[!is.na(xx)]
if(length(xx) > 0){

# The entrez gene identifiers for the first two elements of XX
xx[1:2]

org.Hs.eg.db

# Get the first one
xx[[1]]

}

3

org.Hs.eg.db

Bioconductor annotation data package

Description

Welcome to the org.Hs.eg.db annotation Package. This is an organism specific package. The pur-
pose is to provide detailed information about the species abbreviated in the second part of the
package name org.Hs.eg.db. This package is updated biannually.
Objects in this package are accessed using the select() interface. See ?select in the AnnotationDbi
package for details.

See Also

• AnnotationDb-class for use of keys(), columns() and select().

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
columns(org.Hs.eg.db)

## Bimap interface:
## The 'old style' of interacting with these objects is manipulation as
## bimaps. While this approach is still available we strongly encourage the
## use of select().
ls("package:org.Hs.eg.db")

org.Hs.egCHR

Map Entrez Gene IDs to Chromosomes

Description

org.Hs.egCHR is an R object that provides mappings between entrez gene identifiers and the chro-
mosome that contains the gene of interest.

Details

Each entrez gene identifier maps to a vector of a chromosome.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2025-Sep24

See Also

• AnnotationDb-class for use of the select() interface.

4

Examples

org.Hs.egCHRLENGTHS

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egCHR
# Get the entrez gene identifiers that are mapped to a chromosome
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the CHR for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

org.Hs.egCHRLENGTHS

A named vector for the length of each of the chromosomes

Description

org.Hs.egCHRLENGTHS provides the length measured in base pairs for each of the chromosomes.

Details

This is a named vector with chromosome numbers as the names and the corresponding lengths for
chromosomes as the values.

Total lengths of chromosomes were derived by calculating the number of base pairs on the sequence
string for each chromosome.

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
tt <- org.Hs.egCHRLENGTHS
# Length of chromosome 1
tt["1"]

org.Hs.egCHRLOC

5

org.Hs.egCHRLOC

Entrez Gene IDs to Chromosomal Location

Description

org.Hs.egCHRLOC is an R object that maps entrez gene identifiers to the starting position of the
gene. The position of a gene is measured as the number of base pairs.

The CHRLOCEND mapping is the same as the CHRLOC mapping except that it specifies the
ending base of a gene instead of the start.

Details

Each entrez gene identifier maps to a named vector of chromosomal locations, where the name
indicates the chromosome.

Chromosomal locations on both the sense and antisense strands are measured as the number of base
pairs from the p (5’ end of the sense strand) to q (3’ end of the sense strand) arms. Chromosomal
locations on the antisense strand have a leading "-" sign (e. g. -1234567).

Since some genes have multiple start sites, this field can map to multiple locations.

Mappings were based on data provided by: UCSC Genome Bioinformatics (Homo sapiens) ftp://hgdownload.cse.ucsc.edu/goldenPath/hg38/database
With a date stamp from the source of: UTC-Sep26

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egCHRLOC
# Get the entrez gene identifiers that are mapped to chromosome locations
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the CHRLOC for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

6

org.Hs.egENSEMBL

org.Hs.egENSEMBL

Map Ensembl gene accession numbers with Entrez Gene identifiers

Description

org.Hs.egENSEMBL is an R object that contains mappings between Entrez Gene identifiers and
Ensembl gene accession numbers.

Details

This object is a simple mapping of Entrez Gene identifiers https://www.ncbi.nlm.nih.gov/
entrez/query.fcgi?db=gene to Ensembl gene Accession Numbers.
Mappings were based on data provided by BOTH of these sources: http://www.ensembl.org/
biomart/martview/ ftp://ftp.ncbi.nlm.nih.gov/gene/DATA

For most species, this mapping is a combination of NCBI to ensembl IDs from BOTH NCBI and
ensembl. Users who wish to only use mappings from NCBI are encouraged to see the ncbi2ensembl
table in the appropriate organism package. Users who wish to only use mappings from ensembl are
encouraged to see the ensembl2ncbi table which is also found in the appropriate organism packages.
These mappings are based upon the ensembl table which is contains data from BOTH of these
sources in an effort to maximize the chances that you will find a match.

For worms and flies however, this mapping is based only on sources from ensembl, as these organ-
isms do not have ensembl to entrez gene mapping data at NCBI.

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egENSEMBL
# Get the entrez gene IDs that are mapped to an Ensembl ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the Ensembl gene IDs for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}
#For the reverse map ENSEMBL2EG:
# Convert to a list
xx <- as.list(org.Hs.egENSEMBL2EG)
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one

org.Hs.egENSEMBLPROT

7

xx[[1]]

}

org.Hs.egENSEMBLPROT Map Ensembl protein acession numbers with Entrez Gene identifiers

Description

org.Hs.egENSEMBL is an R object that contains mappings between Entrez Gene identifiers and
Ensembl protein accession numbers.

Details

This object is a simple mapping of Entrez Gene identifiers https://www.ncbi.nlm.nih.gov/
entrez/query.fcgi?db=gene to Ensembl protein accession numbers.
Mappings were based on data provided by: ftp://ftp.ensembl.org/pub/current_fasta ftp:
//ftp.ncbi.nlm.nih.gov/gene/DATA

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egENSEMBLPROT
# Get the entrez gene IDs that are mapped to an Ensembl ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the Ensembl gene IDs for the first five proteins
xx[1:5]
# Get the first one
xx[[1]]

}
#For the reverse map ENSEMBLPROT2EG:
# Convert to a list
xx <- as.list(org.Hs.egENSEMBLPROT2EG)
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

8

org.Hs.egENSEMBLTRANS

org.Hs.egENSEMBLTRANS Map Ensembl transcript acession numbers with Entrez Gene identi-

fiers

Description

org.Hs.egENSEMBL is an R object that contains mappings between Entrez Gene identifiers and
Ensembl transcript accession numbers.

Details

This object is a simple mapping of Entrez Gene identifiers https://www.ncbi.nlm.nih.gov/
entrez/query.fcgi?db=gene to Ensembl transcript accession numbers.

Mappings were based on data provided by: ftp://ftp.ensembl.org/pub/current_fasta ftp:
//ftp.ncbi.nlm.nih.gov/gene/DATA

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egENSEMBLTRANS
# Get the entrez gene IDs that are mapped to an Ensembl ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the Ensembl gene IDs for the first five proteins
xx[1:5]
# Get the first one
xx[[1]]

}
#For the reverse map ENSEMBLTRANS2EG:
# Convert to a list
xx <- as.list(org.Hs.egENSEMBLTRANS2EG)
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

org.Hs.egENZYME

9

org.Hs.egENZYME

Map between Entrez Gene IDs and Enzyme Commission (EC) Num-
bers

Description

org.Hs.egENZYME is an R object that provides mappings between entrez gene identifiers and EC
numbers.

Details

Each entrez gene identifier maps to a named vector containing the EC number that corresponds
to the enzyme produced by that gene. The name corresponds to the entrez gene identifier. If this
information is unknown, the vector will contain an NA.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In org.Hs.egENZYME2EG, EC is dropped from the Enzyme Commission numbers.

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

10

Examples

org.Hs.egGENENAME

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egENZYME
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
xx <- as.list(org.Hs.egENZYME2EG)
if(length(xx) > 0){

# Gets the entrez gene identifiers for the first five enzyme
#commission numbers
xx[1:5]
# Get the first one
xx[[1]]

}

org.Hs.egGENENAME

Map between Entrez Gene IDs and Genes

Description

org.Hs.egGENENAME is an R object that maps entrez gene identifiers to the corresponding gene
name.

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

org.Hs.egGENETYPE

Examples

11

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egGENENAME
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

org.Hs.egGENETYPE

Map between Entrez Gene Identifiers and Gene Type

Description

org.Hs.egGENETYPE is an R object that provides mappings between entrez gene identifiers and
gene types.

Details

Each entrez gene identifier is mapped to the reported type of the corresponding gene. An NA is
reported if there is no known type for a given gene.

References

https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egGENETYPE
# Get the gene symbol that are mapped to an entrez gene identifiers
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the SYMBOL for the first five genes

12

org.Hs.egGO

xx[1:5]
# Get the first one
xx[[1]]

}
# Get the entrez gene identifiers that are mapped to a gene type
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the entrez gene ID for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

org.Hs.egGO

Maps between Entrez Gene IDs and Gene Ontology (GO) IDs

Description

org.Hs.egGO is an R object that provides mappings between entrez gene identifiers and the GO
identifiers that they are directly associated with. This mapping and its reverse mapping do NOT
associate the child terms from the GO ontology with the gene. Only the directly evidenced terms
are represented here.

org.Hs.egGO2ALLEGS is an R object that provides mappings between a given GO identifier and
all of the Entrez Gene identifiers annotated at that GO term OR TO ONE OF IT’S CHILD NODES
in the GO ontology. Thus, this mapping is much larger and more inclusive than org.Hs.egGO2EG.

Details

If org.Hs.egGO is cast as a list, each Entrez Gene identifier is mapped to a list of lists. The names on
the outer list are GO identifiers. Each inner list consists of three named elements: GOID, Ontology,
and Evidence.

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

org.Hs.egGO

13

NAS: non-traceable author statement

ND: no biological data available

IC: inferred by curator

A more complete listing of evidence codes can be found at:
http://www.geneontology.org/GO.evidence.shtml

If org.Hs.egGO2ALLEGS or org.Hs.egGO2EG is cast as a list, each GO term maps to a named vec-
tor of entrez gene identifiers and evidence codes. A GO identifier may be mapped to the same entrez
gene identifier more than once but the evidence code can be different. Mappings between Gene On-
tology identifiers and Gene Ontology terms and other information are available in a separate data
package named GO.

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

• org.Hs.egGO2ALLEGS
• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egGO
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

14

org.Hs.egMAP

}
# For the reverse map:
# Convert to a list
xx <- as.list(org.Hs.egGO2EG)
if(length(xx) > 0){

# Gets the entrez gene ids for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets the entrez gene ids for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}
# For org.Hs.egGO2ALLEGS
xx <- as.list(org.Hs.egGO2ALLEGS)
if(length(xx) > 0){

# Gets the Entrez Gene identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets all the Entrez Gene identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

org.Hs.egMAP

Map between Entrez Gene Identifiers and cytogenetic maps/bands

Description

org.Hs.egMAP is an R object that provides mappings between entrez gene identifiers and cytoband
locations.

Details

Each entrez gene identifier is mapped to a vector of cytoband locations. The vector length may
be one or longer, if there are multiple reported chromosomal locations for a given gene. An NA is
reported for any entrez gene identifiers that cannot be mapped to a cytoband at this time.

Cytogenetic bands for most higher organisms are labeled p1, p2, p3, q1, q2, q3 (p and q are the p
and q arms), etc., counting from the centromere out toward the telomeres. At higher resolutions,
sub-bands can be seen within the bands. The sub-bands are also numbered from the centromere out
toward the telomere. Thus, a label of 7q31.2 indicates that the band is on chromosome 7, q arm,
band 3, sub-band 1, and sub-sub-band 2.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2025-Sep24

References

https://www.ncbi.nlm.nih.gov

See Also

• AnnotationDb-class for use of the select() interface.

org.Hs.egMAPCOUNTS

Examples

15

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egMAP
# Get the entrez gene identifiers that are mapped to any cytoband
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the ids for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}
#For the reverse map org.Hs.egMAP2EG
x <- org.Hs.egMAP2EG
# Get the cytobands that are mapped to any entrez gene id
mapped_bands <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_bands])
if(length(xx) > 0) {

# Get the bands for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

org.Hs.egMAPCOUNTS

Number of mapped keys for the maps in package org.Hs.eg.db

Description

org.Hs.egMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each map in
package org.Hs.eg.db.

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

16

Examples

org.Hs.egOMIM

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
org.Hs.egMAPCOUNTS
mapnames <- names(org.Hs.egMAPCOUNTS)
org.Hs.egMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package org.Hs.eg.db
checkMAPCOUNTS("org.Hs.eg.db")

org.Hs.egOMIM

Map between Entrez Gene Identifiers and Mendelian Inheritance in
Man (MIM) identifiers

Description

org.Hs.egOMIM is an R object that provides mappings between entrez gene identifiers and OMIM
identifiers.

Details

Each entrez gene identifier is mapped to an OMIM identifier. An NA is reported for any entrez gene
identifier that cannot be mapped to an OMIM identifier at this time.

OMIM is based upon the book Mendelian Inheritance in Man (V. A. McKusick) and focuses primar-
ily on inherited or heritable genetic diseases. It contains textual information, pictures, and reference
information that can be searched using various terms, among which the MIM number is one.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2025-Sep24

References

https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene https://www.ncbi.nlm.nih.
gov/entrez/query.fcgi?db=OMIM

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egOMIM

org.Hs.egORGANISM

17

# Get the entrez gene identifiers that are mapped to a OMIM ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the OMIM for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

# For the reverse map:
x <- org.Hs.egOMIM2EG
# Get the OMIM IDs that are mapped to the entrez gene IDs
mapped_OMIMs <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_OMIMs])
if(length(xx) > 0) {

# Get the entrez gene ID for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

org.Hs.egORGANISM

The Organism for org.Hs.eg

Description

org.Hs.egORGANISM is an R object that contains a single item: a character string that names the
organism for which org.Hs.eg was built.

Details

Although the package name is suggestive of the organism for which it was built, org.Hs.egORGANISM
provides a simple way to programmatically extract the organism name.

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
org.Hs.egORGANISM

18

org.Hs.egPATH

org.Hs.egPATH

Mappings between Entrez Gene identifiers and KEGG pathway iden-
tifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms. org.Hs.egPATH maps entrez gene identifiers to the identifiers used by KEGG for pathways

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

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egPATH
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
xx <- as.list(org.Hs.egPATH2EG)
# Remove pathway identifiers that do not map to any entrez gene id
xx <- xx[!is.na(xx)]
if(length(xx) > 0){

# The entrez gene identifiers for the first two elements of XX

org.Hs.egPFAM

xx[1:2]
# Get the first one
xx[[1]]

}

19

org.Hs.egPFAM

Maps between Manufacturer Identifiers and PFAM Identifiers

Description

org.Hs.egPFAM is an R object that provides mappings between manufacturer identifiers and PFAM
identifiers.

Details

The bimap interface for PFAM is defunct. Please use select() interface to PFAM identifiers. See
?AnnotationDbi::select for details.

org.Hs.egPMID

Map between Entrez Gene Identifiers and PubMed Identifiers

Description

org.Hs.egPMID is an R object that provides mappings between entrez gene identifiers and PubMed
identifiers.

Details

Each entrez gene identifier is mapped to a named vector of PubMed identifiers. The name associated
with each vector corresponds to the entrez gene identifier. The length of the vector may be one or
greater, depending on how many PubMed identifiers a given entrez gene identifier is mapped to. An
NA is reported for any entrez gene identifier that cannot be mapped to a PubMed identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2025-Sep24

References

https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=PubMed

See Also

• AnnotationDb-class for use of the select() interface.

20

Examples

org.Hs.egPROSITE

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egPMID
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
xx <- as.list(org.Hs.egPMID2EG)
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

org.Hs.egPROSITE

Maps between Manufacturer Identifiers and PROSITE Identifiers

Description

org.Hs.egPROSITE is an R object that provides mappings between manufacturer identifiers and
PROSITE identifiers.

Details

The bimap interface for PROSITE is defunct. Please use select() interface to PROSITE identifiers.
See ?AnnotationDbi::select for details.

org.Hs.egREFSEQ

21

org.Hs.egREFSEQ

Map between Entrez Gene Identifiers and RefSeq Identifiers

Description

org.Hs.egREFSEQ is an R object that provides mappings between entrez gene identifiers and Ref-
Seq identifiers.

Details

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
x <- org.Hs.egREFSEQ
# Get the entrez gene identifiers that are mapped to any RefSeq ID
mapped_genes <- mappedkeys(x)

22

org.Hs.egSYMBOL

# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the REFSEQ for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

# For the reverse map:
x <- org.Hs.egREFSEQ2EG
# Get the RefSeq identifier that are mapped to an entrez gene ID
mapped_seqs <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_seqs])
if(length(xx) > 0) {

# Get the entrez gene for the first five Refseqs
xx[1:5]
# Get the first one
xx[[1]]

}

org.Hs.egSYMBOL

Map between Entrez Gene Identifiers and Gene Symbols

Description

org.Hs.egSYMBOL is an R object that provides mappings between entrez gene identifiers and gene
abbreviations.

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

org.Hs.egUCSCKG

Examples

23

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egSYMBOL
# Get the gene symbol that are mapped to an entrez gene identifiers
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the SYMBOL for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}
# For the reverse map:
x <- org.Hs.egSYMBOL2EG
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

org.Hs.egUCSCKG

This mapping has been deprecated and will no longer be available
after bioconductor 2.6. See the details section for how you can live
without it. For now, it is a map of UCSC "Known Gene" accession
numbers with Entrez Gene identifiers

Description

org.Hs.egUCSCKG is an R object that contains mappings between Entrez Gene identifiers and
UCSC "Known Gene" accession numbers.

Details

This object is a simple mapping of Entrez Gene identifiers https://www.ncbi.nlm.nih.gov/
entrez/query.fcgi?db=gene to UCSC "Known Gene" Accession Numbers. Please be advised
that UCSC "Known Genes" are not more like putative transcripts transcript identifiers than they are
gene identifiers.

Mappings were based on data provided by: UCSC Genome Bioinformatics (Homo sapiens) ftp://hgdownload.cse.ucsc.edu/goldenPath/hg38/database
With a date stamp from the source of: UTC-Sep26

This mapping is based on the very latest build available at UCSC for this organism as of March
2010. 2.6 is the last release where you can expect it to be here. The GenomicFeatures package
contains functionality that replaces the need for this mapping. Please see the GenomicFeatures
vignette for details on how to use it.

24

See Also

org.Hs.egUNIPROT

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egUCSCKG
# Get the entrez gene IDs that are mapped to a UCSC KG ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the UCSC gene IDs for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

org.Hs.egUNIPROT

Map Uniprot accession numbers with Entrez Gene identifiers

Description

org.Hs.egUNIPROT is an R object that contains mappings between Entrez Gene identifiers and
Uniprot accession numbers.

Details

This object is a simple mapping of Entrez Gene identifiers https://www.ncbi.nlm.nih.gov/
entrez/query.fcgi?db=gene to Uniprot Accession Numbers.
Mappings were based on data provided by NCBI (link above) with an exception for fly, which
required retrieving the data from ensembl http://www.ensembl.org/biomart/martview/

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.Hs.egUNIPROT
# Get the entrez gene IDs that are mapped to a Uniprot ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])

org.Hs.eg_dbconn

25

if(length(xx) > 0) {

# Get the Uniprot gene IDs for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

org.Hs.eg_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

org.Hs.eg_dbconn()
org.Hs.eg_dbfile()
org.Hs.eg_dbschema(file="", show.indices=FALSE)
org.Hs.eg_dbInfo()

Arguments

file

show.indices

Details

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).
The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

org.Hs.eg_dbconn returns a connection object to the package annotation DB. IMPORTANT: Don’t
call dbDisconnect on the connection object returned by org.Hs.eg_dbconn or you will break all
the AnnDbObj objects defined in this package!
org.Hs.eg_dbfile returns the path (character string) to the package annotation DB (this is an
SQLite file).
org.Hs.eg_dbschema prints the schema definition of the package annotation DB.
org.Hs.eg_dbInfo prints other information about the package annotation DB.

Value

org.Hs.eg_dbconn: a DBIConnection object representing an open connection to the package an-
notation DB.
org.Hs.eg_dbfile: a character string with the path to the package annotation DB.
org.Hs.eg_dbschema: none (invisible NULL).
org.Hs.eg_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

26

Examples

org.Hs.eg_dbconn

library(DBI)
## Count the number of rows in the "genes" table:
dbGetQuery(org.Hs.eg_dbconn(), "SELECT COUNT(*) FROM genes")

org.Hs.eg_dbschema()

org.Hs.eg_dbInfo()

Index

∗ datasets

org.Hs.eg.db, 3
org.Hs.eg_dbconn, 25
org.Hs.egACCNUM, 1
org.Hs.egALIAS2EG, 2
org.Hs.egCHR, 3
org.Hs.egCHRLENGTHS, 4
org.Hs.egCHRLOC, 5
org.Hs.egENSEMBL, 6
org.Hs.egENSEMBLPROT, 7
org.Hs.egENSEMBLTRANS, 8
org.Hs.egENZYME, 9
org.Hs.egGENENAME, 10
org.Hs.egGENETYPE, 11
org.Hs.egGO, 12
org.Hs.egMAP, 14
org.Hs.egMAPCOUNTS, 15
org.Hs.egOMIM, 16
org.Hs.egORGANISM, 17
org.Hs.egPATH, 18
org.Hs.egPFAM, 19
org.Hs.egPMID, 19
org.Hs.egPROSITE, 20
org.Hs.egREFSEQ, 21
org.Hs.egSYMBOL, 22
org.Hs.egUCSCKG, 23
org.Hs.egUNIPROT, 24

∗ utilities

org.Hs.eg_dbconn, 25

AnnDbObj, 25

cat, 25
checkMAPCOUNTS, 15
count.mappedkeys, 15

dbconn, 25
dbConnect, 25
dbDisconnect, 25
dbfile, 25
dbGetQuery, 25
dbInfo, 25
dbschema, 25

mappedkeys, 15

org.Hs.eg (org.Hs.eg.db), 3
org.Hs.eg.db, 3
org.Hs.eg_dbconn, 25
org.Hs.eg_dbfile (org.Hs.eg_dbconn), 25
org.Hs.eg_dbInfo (org.Hs.eg_dbconn), 25
org.Hs.eg_dbschema (org.Hs.eg_dbconn),

25
org.Hs.egACCNUM, 1
org.Hs.egACCNUM2EG (org.Hs.egACCNUM), 1
org.Hs.egALIAS2EG, 2
org.Hs.egCHR, 3
org.Hs.egCHRLENGTHS, 4
org.Hs.egCHRLOC, 5
org.Hs.egCHRLOCEND (org.Hs.egCHRLOC), 5
org.Hs.egENSEMBL, 6
org.Hs.egENSEMBL2EG (org.Hs.egENSEMBL),

6

org.Hs.egENSEMBLPROT, 7
org.Hs.egENSEMBLPROT2EG

(org.Hs.egENSEMBLPROT), 7

org.Hs.egENSEMBLTRANS, 8
org.Hs.egENSEMBLTRANS2EG

(org.Hs.egENSEMBLTRANS), 8

org.Hs.egENZYME, 9
org.Hs.egENZYME2EG (org.Hs.egENZYME), 9
org.Hs.egGENENAME, 10
org.Hs.egGENETYPE, 11
org.Hs.egGO, 12
org.Hs.egGO2ALLEGS, 13
org.Hs.egGO2ALLEGS (org.Hs.egGO), 12
org.Hs.egGO2EG (org.Hs.egGO), 12
org.Hs.egMAP, 14
org.Hs.egMAP2EG (org.Hs.egMAP), 14
org.Hs.egMAPCOUNTS, 15
org.Hs.egOMIM, 16
org.Hs.egOMIM2EG (org.Hs.egOMIM), 16
org.Hs.egORGANISM, 17
org.Hs.egPATH, 18
org.Hs.egPATH2EG (org.Hs.egPATH), 18
org.Hs.egPFAM, 19
org.Hs.egPMID, 19
org.Hs.egPMID2EG (org.Hs.egPMID), 19
org.Hs.egPROSITE, 20

27

28

INDEX

org.Hs.egREFSEQ, 21
org.Hs.egREFSEQ2EG (org.Hs.egREFSEQ), 21
org.Hs.egSYMBOL, 22
org.Hs.egSYMBOL2EG (org.Hs.egSYMBOL), 22
org.Hs.egUCSCKG, 23
org.Hs.egUNIPROT, 24

