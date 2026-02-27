org.At.tair.db
February 25, 2026

org.At.tairARACYC

Mappings between TAIR identifiers and KEGG pathway identifiers

Description

AraCyc http://www.arabidopsis.org/tools/aracyc/ maintains pathway data for Arabidop-
sis thaliana. org.At.tairARACYC maps TAIR identifiers to the common names of the pathways
in which the genes represented by the tair identifiers are involved. Information is obtained from
AraCyc.

Details

Annotation based on data provided by: Tair ftp://ftp.plantcyc.org/pmn/Pathways/Data\_dumps/PMN15.5\_January2023/pathways/aracyc\_pathways.20230103
With a date stamp from the source of: 2025-09-24

References

http://www.genome.ad.jp/kegg/

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.At.tairARACYC
# Get the tair identifiers that are mapped to pathways
mapped_tairs <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_tairs])
if(length(xx) > 0) {

# Get the pathways for the first five tairs
xx[1:5]
# For the first tair
xx[[1]]

}

1

2

org.At.tair.db

org.At.tairARACYCENZYME

Map between TAIR IDs and Enzyme Names from ARACYC

Description

org.At.tairARACYCENZYME is an R object that provides mappings between TAIR identifiers and
Enzyme Names from ARACYC.

Details

Each TAIR identifier maps to a named vector containing the Enzyme name for that gene according
to the ARACYC database. If this information is unknown, the vector will contain an NA.

Mappings between tair identifiers and enzyme identifiers were obtained using files provided by: Tair
ftp://ftp.plantcyc.org/pmn/Pathways/Data\_dumps/PMN15.5\_January2023/pathways/aracyc\_pathways.20230103
With a date stamp from the source of: 2025-09-24

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.At.tairARACYCENZYME
# Get the tair identifiers that are mapped to an Enzyme Name
mapped_tairs <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_tairs])
if(length(xx) > 0) {

# Get the ENZYME name for the first five tairs
xx[1:5]
# Get the first one
xx[[1]]

}

org.At.tair.db

Bioconductor annotation data package

Description

Welcome to the org.At.tair.db annotation Package. The purpose of this package is to provide de-
tailed information about the org.At.tair platform. This package is updated biannually.
Objects in this package are accessed using the select() interface. See ?select in the AnnotationDbi
package for details.

org.At.tairCHR

See Also

3

• AnnotationDb-class for use of keys(), columns() and select().

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
columns(org.At.tair.db)

## Bimap interface:
## The 'old style' of interacting with these objects is manipulation as
## bimaps. While this approach is still available we strongly encourage the
## use of select().
ls("package:org.At.tair.db")

org.At.tairCHR

Map TAIR IDs to Chromosomes

Description

org.At.tairCHR is an R object that provides mappings between a TAIR identifier and the chromo-
some that contains the gene of interest.

Details

Each TAIR identifier maps to a vector of chromosomes. Due to inconsistencies that may exist at
the time the object was built, the vector may contain more than one chromosome (e.g., the identifier
may map to more than one chromosome). If the chromosomal location is unknown, the vector will
contain an NA.
Mappings were based on data provided by: Tair https://www.arabidopsis.org/api/download-files/download?filePath=Genes/TAIR10\_genome\_release/TAIR10\_functional\_descriptions
With a date stamp from the source of: 2025-09-24

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.At.tairCHR
# Get the tair identifiers that are mapped to a chromosome
mapped_tairs <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_tairs])
if(length(xx) > 0) {

# Get the CHR for the first five tairs
xx[1:5]
# Get the first one

4

xx[[1]]

}

org.At.tairCHRLOC

org.At.tairCHRLENGTHS A named vector for the length of each of the chromosomes

Description

org.At.tairCHRLENGTHS provides the length measured in base pairs for each of the chromosomes.

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
tt <- org.At.tairCHRLENGTHS
# Length of chromosome 1
tt["1"]

org.At.tairCHRLOC

Map Manufacturer IDs to Chromosomal Location

Description

org.At.tairCHRLOC is an R object that maps manufacturer identifiers to the starting position of the
gene. The position of a gene is measured as the number of base pairs.

The CHRLOCEND mapping is the same as the CHRLOC mapping except that it specifies the
ending base of a gene instead of the start.

org.At.tairENTREZID

Details

5

Each manufacturer identifier maps to a named vector of chromosomal locations, where the name
indicates the chromosome. Due to inconsistencies that may exist at the time the object was built,
these vectors may contain more than one chromosome and/or location. If the chromosomal location
is unknown, the vector will contain an NA.

Chromosomal locations on both the sense and antisense strands are measured as the number of base
pairs from the p (5’ end of the sense strand) to q (3’ end of the sense strand) arms. Chromosomal
locations on the antisense strand have a leading "-" sign (e. g. -1234567).

Mappings were based on data provided by: Tair https://www.arabidopsis.org/api/download-files/download?filePath=Maps/seqviewer\_data/sv\_gene.data
With a date stamp from the source of: 2025-09-24

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.At.tairCHRLOC
# Get the tair identifiers that are mapped to chromosome locations
mapped_tairs <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_tairs])
if(length(xx) > 0) {

# Get the CHRLOC for the first five tairs
xx[1:5]
# Get the first one
xx[[1]]

}

org.At.tairENTREZID

Map TAIR identifiers with Entrez Gene identifiers

Description

org.At.tairENTREZID is an R object that contains mappings between TAIR accession numbers and
NCBI Entrez Gene identifiers.

Details

This object is a simple mapping of Entrez Gene identifiers https://www.ncbi.nlm.nih.gov/
entrez/query.fcgi?db=gene to TAIR Accession Numbers.
Mappings were based on data provided by: ftp://ftp.ncbi.nlm.nih.gov/gene/DATA

See Also

• AnnotationDb-class for use of the select() interface.

6

Examples

org.At.tairENZYME

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.At.tairENTREZID
# Get the ORF IDs that are mapped to an Entrez Gene ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the Entrez gene IDs for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

org.At.tairENZYME

Map between TAIR IDs and Enzyme Commission (EC) Numbers

Description

org.At.tairENZYME is an R object that provides mappings between TAIR identifiers and EC num-
bers.

Details

Each TAIR identifier maps to a named vector containing the EC number that corresponds to the
enzyme produced by that gene. The name corresponds to the manufacturer identifier. If this infor-
mation is unknown, the vector will contain an NA.
Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In org.At.tairENZYME2TAIR, EC is dropped from the Enzyme Commission numbers.

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

Mappings between TAIR identifiers and enzyme identifiers were obtained using files provided by:
Tair ftp://ftp.plantcyc.org/pmn/Pathways/Data\_dumps/PMN15.5\_January2023/pathways/aracyc\_pathways.20230103
With a date stamp from the source of: 2025-09-24

org.At.tairENZYME2TAIR

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

7

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.At.tairENZYME
# Get the TAIR identifiers that are mapped to an EC number
mapped_tairs <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_tairs])
if(length(xx) > 0) {

# Get the ENZYME for the first five tairs
xx[1:5]
# Get the first one
xx[[1]]

}

org.At.tairENZYME2TAIR

Map between Enzyme Commission Numbers and TAIR Identifiers

Description

org.At.tairENZYME2TAIR is an R object that maps Enzyme Commission (EC) numbers to TAIR
identifiers.

Details

Each EC number maps to a named vector containing all of the TAIR identifiers that correspond to
the gene that produces that enzyme. The name of the vector corresponds to the EC number.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In org.At.tairENZYME2TAIR, EC is dropped from the Enzyme Commission numbers.

Enzyme Commission numbers have corresponding names that describe the functions of enzymes
in such a way that EC x is a more general description than EC x.y that in turn is a more general
description than EC x.y.z. The top level EC numbers and names are listed below:

EC 1 oxidoreductases

EC 2 transferases

EC 3 hydrolases

8

EC 4 lyases

EC 5 isomerases

org.At.tairGENENAME

EC 6 ligases
The EC name for a given EC number can be viewed at http://www.chem.qmul.ac.uk/iupac/
jcbn/index.html#6

Mappings were based on data provided by: Tair ftp://ftp.plantcyc.org/pmn/Pathways/Data\_dumps/PMN15.5\_January2023/pathways/aracyc\_pathways.20230103
With a date stamp from the source of: 2025-09-24

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
# Convert to a list
xx <- as.list(org.At.tairENZYME2TAIR)
if(length(xx) > 0){

# Gets the tair identifiers for the first five enzyme
#commission numbers
xx[1:5]
# Get the first one
xx[[1]]

}

org.At.tairGENENAME

Map between TAIR IDs and Genes

Description

org.At.tairGENENAME is an R object that maps TAIR identifiers to the corresponding gene name.

Details

Each TAIR identifier maps to a named vector containing the gene name. The vector name corre-
sponds to the TAIR identifier. If the gene name is unknown, the vector will contain an NA.

Gene names currently include both the official (validated by a nomenclature committee) and pre-
ferred names (interim selected for display) for genes. Efforts are being made to differentiate the
two by adding a name to the vector.

Mappings were based on data provided by: Tair https://www.arabidopsis.org/api/download-files/download?filePath=Genes/TAIR10\_genome\_release/TAIR10\_functional\_descriptions
With a date stamp from the source of: 2025-09-24

See Also

• AnnotationDb-class for use of the select() interface.

org.At.tairGO

Examples

9

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.At.tairGENENAME
# Get the TAIR identifiers that are mapped to a gene name
mapped_tairs <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_tairs])
if(length(xx) > 0) {

# Get the GENENAME for the first five tairs
xx[1:5]
# Get the first one
xx[[1]]

}

org.At.tairGO

Map between TAIR IDs and Gene Ontology (GO)

Description

org.At.tairGO is an R object that provides mappings between TAIR identifiers and the GO identifiers
that they are directly associated with. This mapping and its reverse mapping do NOT associate the
child terms from the GO ontology with the gene. Only the directly evidenced terms are represented
here.

Details

Each TAIR Gene identifier is mapped to a list of lists. The names on the outer list are GO identifiers.
Each inner list consists of three named elements: GOID, Ontology, and Evidence.

The GOID element matches the GO identifier named in the outer list and is included for convenience
when processing the data using ’lapply’.

The Ontology element indicates which of the three Gene Ontology categories this identifier belongs
to. The categories are biological process (BP), cellular component (CC), and molecular function
(MF).

The Evidence element contains a code indicating what kind of evidence supports the association of
the GO identifier to the TAIR Gene id. Some of the evidence codes in use include:

IMP: inferred from mutant phenotype

IGI: inferred from genetic interaction

IPI: inferred from physical interaction

ISS: inferred from sequence similarity

IDA: inferred from direct assay

IEP: inferred from expression pattern

IEA: inferred from electronic annotation

TAS: traceable author statement

NAS: non-traceable author statement

10

org.At.tairGO

ND: no biological data available

IC: inferred by curator

A more complete listing of evidence codes can be found at:
http://www.geneontology.org/GO.evidence.shtml

Mappings between TAIR gene identifiers and GO information were obtained through their map-
pings to TAIR gene identifiers. NAs are assigned to TAIR identifiers that can not be mapped to
any Gene Ontology information. Mappings between Gene Ontology identifiers an Gene Ontology
terms and other information are available in a separate data package named GO.

Mappings were based on data provided by: Gene Ontology http://current.geneontology.org/ontology/go-
basic.obo With a date stamp from the source of: 2025-07-22

For the reverse map GO2TAIR, each GO term maps to a named vector of TAIR gene identifiers.
A GO identifier may be mapped to the same TAIR identifier more than once but the evidence code
can be different. Mappings between Gene Ontology identifiers and Gene Ontology terms and other
information are available in a separate data package named GO.

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

See Also

• org.At.tairGO2ALLTAIRS.
• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.At.tairGO
# Get the TAIR gene identifiers that are mapped to a GO ID
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
xx <- as.list(org.At.tairGO2TAIR)
if(length(xx) > 0){

# Gets the TAIR gene ids for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets the TAIR ids for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

org.At.tairGO2ALLTAIRS

11

org.At.tairGO2ALLTAIRS

Map between Gene Ontology (GO) Identifiers and all TAIR Identifiers
in the subtree

Description

org.At.tairGO2ALLTAIRS is an R object that provides mappings between a given GO identifier and
all TAIR identifiers annotated at that GO term or one of its children in the GO ontology.

Details

GO consists of three ontologies—molecular function (MF), biological process (BP), and cellular
component (CC). All ontologies are structured as directed acyclic graphs (DAGs). Each node in
each DAG (tree) is a GO term (id) associated with a named vector of manufacturer identifiers. The
name associated with each manufacturer id corresponds to the evidence code for that GO identifier.
This object org.At.tairGO2ALLTAIRS maps between a given GO identifier and all TAIR identifiers
annotated at that GO term or one of its children in the GO ontology.

The evidence code indicates what kind of evidence supports the association between the GO and
Entrez Gene identifiers. Evidence codes currently in use include:

IMP - inferred from mutant phenotype

IGI - inferred from genetic interaction

IPI - inferred from physical interaction

ISS - inferred from sequence similarity

IDA - inferred from direct assay

IEP - inferred from expression pattern

IEA - inferred from electronic annotation

TAS - traceable author statement

NAS - non-traceable author statement

ND - no biological data available

IC - inferred by curator

A GO identifier may be mapped to the same TAIR identifier more than once but the evidence code
can be different. Mappings between Gene Ontology identifiers and Gene Ontology terms and other
information are available in a separate data package named GO.

Mappings were based on data provided by:

Gene Ontology http://current.geneontology.org/ontology/go-basic.obo With a date stamp from the
source of: 2025-07-22

For GO2ALL style mappings, the intention is to return all the genes that are the same kind of
term as the parent term (based on the idea that they are more specific descriptions of the general
term). However because of this intent, not all relationship types will be counted as offspring for this
mapping. Only "is a" and "has a" style relationships indicate that the genes from the child terms
would be the same kind of thing.

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

12

See Also

org.At.tairMAPCOUNTS

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
# Convert to a list
xx <- as.list(org.At.tairGO2ALLTAIRS)
if(length(xx) > 0){

# Gets the tair identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets all the tair identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

org.At.tairMAPCOUNTS

Number of mapped keys for the maps in package org.At.tair.db

Description

org.At.tairMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each map
in package org.At.tair.db.

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
org.At.tairMAPCOUNTS
mapnames <- names(org.At.tairMAPCOUNTS)

org.At.tairORGANISM

13

org.At.tairMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package org.At.tair.db
checkMAPCOUNTS("org.At.tair.db")

org.At.tairORGANISM

The Organism for org.At.tair

Description

org.At.tairORGANISM is an R object that contains a single item: a character string that names the
organism for which org.At.tair was built.

Details

Although the package name is suggestive of the organism for which it was built, org.At.tairORGANISM
provides a simple way to programmatically extract the organism name.

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
org.At.tairORGANISM

org.At.tairPATH

Mappings between TAIR identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms. org.At.tairPATH maps TAIR identifiers to the identifiers used by KEGG for pathways in
which the genes represented by the TAIR identifiers are involved

Details

Each KEGG pathway has a name and identifier. Pathway name for a given pathway identifier can
be obtained using the KEGG data package that can either be built using AnnBuilder or downloaded
from Bioconductor http://www.bioconductor.org.
Graphic presentations of pathways are searchable at url http://www.genome.ad.jp/kegg/pathway.html
by using pathway identifiers as keys.

Mappings were based on data provided by: KEGG GENOME ftp://ftp.genome.jp/pub/kegg/genomes
With a date stamp from the source of: 2011-Mar15

14

References

http://www.genome.ad.jp/kegg/

See Also

org.At.tairPATH2TAIR

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.At.tairPATH
# Get the TAIR identifiers that are mapped to a KEGG pathway ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the PATH for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

org.At.tairPATH2TAIR Map between Kyoto Encyclopedia of Genes and Genomes (KEGG)
pathway identifiers and TAIR Identifiers

Description

org.At.tairPATH2TAIR is an R object that provides mappings between KEGG identifiers and TAIR
identifiers.

Details

Each KEGG identifier is mapped to a named vector of manufacturer identifiers. The name repre-
sents the KEGG identifier and the vector contains all TAIR identifiers that are found in that par-
ticular pathway. An NA is reported for any KEGG identifier that cannot be mapped to any TAIR
identifiers.

Pathway name for a given pathway identifier can be obtained using the KEGG data package that can
either be built using AnnBuilder or downloaded from Bioconductor http://www.bioconductor.
org.
Graphic presentations of pathways are searchable at http://www.genome.ad.jp/kegg/pathway.
html using pathway identifiers as keys.
Mappings were based on data provided by: KEGG GENOME ftp://ftp.genome.jp/pub/kegg/genomes
With a date stamp from the source of: 2011-Mar15

References

http://www.genome.ad.jp/kegg/

org.At.tairPMID

See Also

15

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
# Convert the object to a list
xx <- as.list(org.At.tairPATH2TAIR)
# Remove pathway identifiers that do not map to any tair id
xx <- xx[!is.na(xx)]
if(length(xx) > 0){

# The tair identifiers for the first two elements of XX
xx[1:2]
# Get the first one
xx[[1]]

}

org.At.tairPMID

Map between TAIR Identifiers and PubMed Identifiers

Description

org.At.tairPMID is an R object that provides mappings between TAIR identifiers and PubMed iden-
tifiers.

Details

Each TAIR identifier is mapped to a named vector of PubMed identifiers. The name associated
with each vector corresponds to the TAIR identifier. The length of the vector may be one or greater,
depending on how many PubMed identifiers a given TAIR identifier is mapped to. An NA is reported
for any TAIR identifier that cannot be mapped to a PubMed identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose.

Mappings were based on data provided by: Tair https://www.arabidopsis.org/api/download-files/download?filePath=Public\_Data\_Releases/TAIR\_Data\_20230630/Locus\_Published\_20230630.txt.gz
With a date stamp from the source of: 2025-09-24

References

https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=PubMed

See Also

• AnnotationDb-class for use of the select() interface.

16

Examples

org.At.tairPMID2TAIR

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.At.tairPMID
# Get the tair identifiers that are mapped to any PubMed ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0){

# The tair identifiers for the first two elements of XX
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

org.At.tairPMID2TAIR Map between PubMed Identifiers and TAIR Identifiers

Description

org.At.tairPMID2TAIR is an R object that provides mappings between PubMed identifiers and
TAIR identifiers.

Details

Each PubMed identifier is mapped to a named vector of TAIR identifiers. The name represents the
PubMed identifier and the vector contains all TAIR identifiers that are represented by that PubMed
identifier. The length of the vector may be one or longer, depending on how many TAIR identifiers
are mapped to a given PubMed identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose

Mappings were based on data provided by: Tair https://www.arabidopsis.org/api/download-files/download?filePath=Public\_Data\_Releases/TAIR\_Data\_20230630/Locus\_Published\_20230630.txt.gz
With a date stamp from the source of: 2025-09-24

See Also

• AnnotationDb-class for use of the select() interface.

org.At.tairREFSEQ

Examples

17

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
# Convert the object to a list
xx <- as.list(org.At.tairPMID2TAIR)
if(length(xx) > 0){

# The tair identifiers for the first two elements of XX
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

org.At.tairREFSEQ

Map between TAIR Identifiers and RefSeq Identifiers

Description

org.At.tairREFSEQ is an R object that provides mappings between TAIR identifiers and RefSeq
identifiers.

Details

Each TAIR identifier is mapped to a named vector of RefSeq identifiers. The name represents
the TAIR identifier and the vector contains all RefSeq identifiers that can be mapped to that TAIR
identifier. The length of the vector may be one or greater, depending on how many RefSeq identifiers
a given TAIR identifier can be mapped to. An NA is reported for any TAIR identifier that cannot be
mapped to a RefSeq identifier at this time.

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
Mappings were based on data provided by: ftp://ftp.ncbi.nlm.nih.gov/gene/DATA

18

References

org.At.tairSYMBOL

https://www.ncbi.nlm.nih.gov https://www.ncbi.nlm.nih.gov/RefSeq/

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.At.tairREFSEQ
# Get the TAIR identifiers that are mapped to any RefSeq ID
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
x <- org.At.tairREFSEQ2TAIR
# Get the RefSeq identifier that are mapped to an TAIR ID
mapped_seqs <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_seqs])
if(length(xx) > 0) {

# Get the TAIR ID for the first five Refseqs
xx[1:5]
# Get the first one
xx[[1]]

}

org.At.tairSYMBOL

Map between TAIR Identifiers and Gene Symbols

Description

org.At.tairSYMBOL is an R object that provides mappings between TAIR identifiers and gene
abbreviations.

Details

Each TAIR identifier is mapped to an abbreviation for the corresponding gene. An NA is reported if
there is no known abbreviation for a given gene.

Symbols typically consist of 3 letters that define either a single gene (ABC) or multiple genes
(ABC1, ABC2, ABC3). Gene symbols can be used as key words to query public databases such as
Entrez Gene.

org.At.tair_dbconn

19

Mappings were based on data provided by: Tair https://www.arabidopsis.org/api/download-files/download?filePath=Public\_Data\_Releases/TAIR\_Data\_20230630/gene\_aliases\_20230630.txt.gz
With a date stamp from the source of: 2025-09-24

References

https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- org.At.tairSYMBOL
# Get the tair identifiers that are mapped to a gene symbol
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the SYMBOL for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

org.At.tair_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

org.At.tair_dbconn()
org.At.tair_dbfile()
org.At.tair_dbschema(file="", show.indices=FALSE)
org.At.tair_dbInfo()

Arguments

file

show.indices

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).
The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

20

Details

org.At.tair_dbconn

org.At.tair_dbconn returns a connection object to the package annotation DB. IMPORTANT:
Don’t call dbDisconnect on the connection object returned by org.At.tair_dbconn or you will
break all the AnnDbObj objects defined in this package!
org.At.tair_dbfile returns the path (character string) to the package annotation DB (this is an
SQLite file).
org.At.tair_dbschema prints the schema definition of the package annotation DB.
org.At.tair_dbInfo prints other information about the package annotation DB.

Value

org.At.tair_dbconn: a DBIConnection object representing an open connection to the package
annotation DB.
org.At.tair_dbfile: a character string with the path to the package annotation DB.
org.At.tair_dbschema: none (invisible NULL).
org.At.tair_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

library(DBI)
## Count the number of rows in the "genes" table:
dbGetQuery(org.At.tair_dbconn(), "SELECT COUNT(*) FROM genes")

org.At.tair_dbschema()

org.At.tair_dbInfo()

org.At.tair_dbfile

(org.At.tair_dbconn), 19

org.At.tair_dbInfo

(org.At.tair_dbconn), 19

org.At.tair_dbschema

(org.At.tair_dbconn), 19

org.At.tairARACYC, 1
org.At.tairARACYCENZYME, 2
org.At.tairCHR, 3
org.At.tairCHRLENGTHS, 4
org.At.tairCHRLOC, 4
org.At.tairCHRLOCEND

(org.At.tairCHRLOC), 4

org.At.tairENTREZID, 5
org.At.tairENZYME, 6
org.At.tairENZYME2TAIR, 7
org.At.tairGENENAME, 8
org.At.tairGO, 9
org.At.tairGO2ALLTAIRS, 10, 11
org.At.tairGO2TAIR (org.At.tairGO), 9
org.At.tairMAPCOUNTS, 12
org.At.tairORGANISM, 13
org.At.tairPATH, 13
org.At.tairPATH2TAIR, 14
org.At.tairPMID, 15
org.At.tairPMID2TAIR, 16
org.At.tairREFSEQ, 17
org.At.tairREFSEQ2TAIR

(org.At.tairREFSEQ), 17

org.At.tairSYMBOL, 18

Index

∗ datasets

org.At.tair.db, 2
org.At.tair_dbconn, 19
org.At.tairARACYC, 1
org.At.tairARACYCENZYME, 2
org.At.tairCHR, 3
org.At.tairCHRLENGTHS, 4
org.At.tairCHRLOC, 4
org.At.tairENTREZID, 5
org.At.tairENZYME, 6
org.At.tairENZYME2TAIR, 7
org.At.tairGENENAME, 8
org.At.tairGO, 9
org.At.tairGO2ALLTAIRS, 11
org.At.tairMAPCOUNTS, 12
org.At.tairORGANISM, 13
org.At.tairPATH, 13
org.At.tairPATH2TAIR, 14
org.At.tairPMID, 15
org.At.tairPMID2TAIR, 16
org.At.tairREFSEQ, 17
org.At.tairSYMBOL, 18

∗ utilities

org.At.tair_dbconn, 19

AnnDbObj, 20

cat, 19
checkMAPCOUNTS, 12
count.mappedkeys, 12

dbconn, 20
dbConnect, 20
dbDisconnect, 20
dbfile, 20
dbGetQuery, 20
dbInfo, 20
dbschema, 20

mappedkeys, 12

org.At.tair (org.At.tair.db), 2
org.At.tair.db, 2
org.At.tair_dbconn, 19

21

