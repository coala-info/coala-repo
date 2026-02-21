ath1121501.db
February 11, 2026

ath1121501ACCNUM

Map between manufacturer IDs and AGI locus IDs

Description

ath1121501ACCNUM is an R object that provide mappings between manufacturer IDs and AGI locus
IDs.

Details

Each manufacturer ID is mapped to a vector of AGI locus IDs.

If a manufacturer ID is mapped to multiple AGI locus IDs, then all of these AGI locus IDs will be
listed.
For ath1121501ACCNUM an NA is assigned to those manufacturer IDs that can not be mapped to an
AGI locus ID at this time.

Mappings were based on data provided by: Tair https://www.arabidopsis.org/download\_files/Microarrays/Affymetrix/affy\_ATH1\_array\_elements-
2010-12-20.txt With a date stamp from the source of: 2021-Apr15

See Also

• AnnotationDb-class for use of the select() interface.
• nhit.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- ath1121501ACCNUM
# Get the probe identifiers that are mapped to a chromosome
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the AGI locus IDs for the first five probes
xx[1:5]
# Get the first one

1

2

xx[[1]]

}

##
y <- ath1121501MULTIHIT
## identical(keys(x), keys(y))

# TRUE

ath1121501ARACYC

# a single AGI locus ID
# NA

# nhx <- nhit(x)
# nhy <- nhit(y)
# identical(names(nhx), keys(x)) # TRUE
# identical(names(nhy), keys(y)) # TRUE
# table(nhx)
# table(nhy)
# onehit_probes <- names(nhx)[nhx != 0 & nhy == 0]
# x[[onehit_probes[1]]]
# y[[onehit_probes[1]]]
# multihit_probes <- names(nhx)[nhy != 0]
# x[[multihit_probes[1]]]
# y[[multihit_probes[1]]]
# nohit_probes <- names(nhx)[nhx == 0]
# NA
# x[[nohit_probes[1]]]
# y[[nohit_probes[1]]]
# NA
# FALSE
# any(nhx == 0 & nhy != 0)
# ## Back to a more "normal" map (that combines the data from 'x' and 'y')
# xy <- as(x, "AnnDbBimap")
# xy[[onehit_probes[1]]]
# xy[[multihit_probes[1]]]
# xy[[nohit_probes[1]]]

# 'as(y, "AnnDbBimap")' works too
# a single AGI locus ID
# several AGI locus IDs
# NA

# "multiple"
# several AGI locus IDs

ath1121501ARACYC

Mappings between probe identifiers and KEGG pathway identifiers

Description

AraCyc http://www.arabidopsis.org/tools/aracyc/ maintains pathway data for Arabidopsis
thaliana. ath1121501ARACYC maps probe identifiers to the common names of the pathways in
which the genes represented by the probe identifiers are involved. Information is obtained from
AraCyc.

Details

Annotation based on data provided by: Tair ftp://ftp.plantcyc.org/Pathways/Data\_dumps/PMN15\_January2021/pathways/ara\_pathways.20210325.txt
With a date stamp from the source of: 2021-Apr15

References

http://www.genome.ad.jp/kegg/

See Also

• AnnotationDb-class for use of the select() interface.

ath1121501ARACYCENZYME

3

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- ath1121501ARACYC
# Get the probe identifiers that are mapped to pathways
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the pathways for the first five probes
xx[1:5]
# For the first probe
xx[[1]]

}

ath1121501ARACYCENZYME

Map between Manufacturer IDs and Enzyme Names from ARACYC

Description

ath1121501ARACYCENZYME is an R object that provides mappings between manufacturer iden-
tifiers and Enzyme Names from ARACYC.

Details

Each manufacturer identifier maps to a named vector containing the Enzyme name for that gene
according to the ARACYC database. If this information is unknown, the vector will contain an NA.
Mappings between probe identifiers and enzyme identifiers were obtained using files provided by:
Tair ftp://ftp.plantcyc.org/Pathways/Data\_dumps/PMN15\_January2021/pathways/ara\_pathways.20210325.txt
With a date stamp from the source of: 2021-Apr15

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- ath1121501ARACYCENZYME
# Get the probe identifiers that are mapped to an Enzyme Name
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the ENZYME name for the first five probes

4

ath1121501CHR

xx[1:5]
# Get the first one
xx[[1]]

}

ath1121501.db

Bioconductor annotation data package

Description

Welcome to the ath1121501.db annotation Package. The purpose of this package is to provide
detailed information about the ath1121501 platform. This package is updated biannually.
Objects in this package are accessed using the select() interface. See ?select in the AnnotationDbi
package for details.

See Also

• AnnotationDb-class for use of keys(), columns() and select().

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
columns(ath1121501.db)

## Bimap interface:
## The 'old style' of interacting with these objects is manipulation as
## bimaps. While this approach is still available we strongly encourage the
## use of select().
ls("package:ath1121501.db")

ath1121501CHR

Map Manufacturer IDs to Chromosomes

Description

ath1121501CHR is an R object that provides mappings between a manufacturer identifier and the
chromosome that contains the gene of interest.

Details

Each manufacturer identifier maps to a vector of chromosomes. Due to inconsistencies that may
exist at the time the object was built, the vector may contain more than one chromosome (e.g., the
identifier may map to more than one chromosome). If the chromosomal location is unknown, the
vector will contain an NA.

Mappings were based on data provided by: Tair https://www.arabidopsis.org/download\_files/Genes/TAIR10\_genome\_release/TAIR10\_functional\_descriptions
With a date stamp from the source of: 2021-Apr15

ath1121501CHRLENGTHS

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

5

## Bimap interface:
x <- ath1121501CHR
# Get the probe identifiers that are mapped to a chromosome
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the CHR for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

ath1121501CHRLENGTHS

A named vector for the length of each of the chromosomes

Description

ath1121501CHRLENGTHS provides the length measured in base pairs for each of the chromo-
somes.

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
tt <- ath1121501CHRLENGTHS
# Length of chromosome 1
tt["1"]

6

ath1121501CHRLOC

ath1121501CHRLOC

Map Manufacturer IDs to Chromosomal Location

Description

ath1121501CHRLOC is an R object that maps manufacturer identifiers to the starting position of
the gene. The position of a gene is measured as the number of base pairs.

The CHRLOCEND mapping is the same as the CHRLOC mapping except that it specifies the
ending base of a gene instead of the start.

Details

Each manufacturer identifier maps to a named vector of chromosomal locations, where the name
indicates the chromosome. Due to inconsistencies that may exist at the time the object was built,
these vectors may contain more than one chromosome and/or location. If the chromosomal location
is unknown, the vector will contain an NA.

Chromosomal locations on both the sense and antisense strands are measured as the number of base
pairs from the p (5’ end of the sense strand) to q (3’ end of the sense strand) arms. Chromosomal
locations on the antisense strand have a leading "-" sign (e. g. -1234567).

Mappings were based on data provided by: Tair https://www.arabidopsis.org/download\_files/Maps/seqviewer\_data/sv\_gene.data
With a date stamp from the source of: 2021-Apr15

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- ath1121501CHRLOC
# Get the probe identifiers that are mapped to chromosome locations
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the CHRLOC for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

ath1121501ENZYME

7

ath1121501ENZYME

Map between Manufacturer IDs and Enzyme Commission (EC) Num-
bers

Description

ath1121501ENZYME is an R object that provides mappings between manufacturer identifiers and
EC numbers.

Details

Each manufacturer identifier maps to a named vector containing the EC number that corresponds
to the enzyme produced by that gene. The name corresponds to the manufacturer identifier. If this
information is unknown, the vector will contain an NA.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric num-
bers. In ath1121501ENZYME2PROBE, EC is dropped from the Enzyme Commission numbers.

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

Mappings between probe identifiers and enzyme identifiers were obtained using files provided by:
Tair ftp://ftp.plantcyc.org/Pathways/Data\_dumps/PMN15\_January2021/pathways/ara\_pathways.20210325.txt
With a date stamp from the source of: 2021-Apr15

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

See Also

• AnnotationDb-class for use of the select() interface.

8

Examples

ath1121501ENZYME2PROBE

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- ath1121501ENZYME
# Get the probe identifiers that are mapped to an EC number
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the ENZYME for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

ath1121501ENZYME2PROBE

Map between Enzyme Commission Numbers and Manufacturer Iden-
tifiers

Description

ath1121501ENZYME2PROBE is an R object that maps Enzyme Commission (EC) numbers to
manufacturer identifiers.

Details

Each EC number maps to a named vector containing all of the manufacturer identifiers that cor-
respond to the gene that produces that enzyme. The name of the vector corresponds to the EC
number.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric num-
bers. In ath1121501ENZYME2PROBE, EC is dropped from the Enzyme Commission numbers.

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

ath1121501GENENAME

9

Mappings were based on data provided by: Tair ftp://ftp.plantcyc.org/Pathways/Data\_dumps/PMN15\_January2021/pathways/ara\_pathways.20210325.txt
With a date stamp from the source of: 2021-Apr15

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
# Convert to a list
xx <- as.list(ath1121501ENZYME2PROBE)
if(length(xx) > 0){

# Gets the probe identifiers for the first five enzyme
#commission numbers
xx[1:5]
# Get the first one
xx[[1]]

}

ath1121501GENENAME

Map between Manufacturer IDs and Genes

Description

ath1121501GENENAME is an R object that maps manufacturer identifiers to the corresponding
gene name.

Details

Each manufacturer identifier maps to a named vector containing the gene name. The vector name
corresponds to the manufacturer identifier. If the gene name is unknown, the vector will contain an
NA.

Gene names currently include both the official (validated by a nomenclature committee) and pre-
ferred names (interim selected for display) for genes. Efforts are being made to differentiate the
two by adding a name to the vector.

Mappings were based on data provided by: Tair https://www.arabidopsis.org/download\_files/Genes/TAIR10\_genome\_release/TAIR10\_functional\_descriptions
With a date stamp from the source of: 2021-Apr15

See Also

• AnnotationDb-class for use of the select() interface.

10

Examples

ath1121501GO

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- ath1121501GENENAME
# Get the probe identifiers that are mapped to a gene name
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the GENENAME for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

ath1121501GO

Map between Manufacturer IDs and Gene Ontology (GO)

Description

ath1121501GO is an R object that provides mappings between manufacturer identifiers and the GO
identifiers that they are directly associated with.

Details

Each Entrez Gene identifier is mapped to a list of lists. The names on the outer list are GO identi-
fiers. Each inner list consists of three named elements: GOID, Ontology, and Evidence.

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

ath1121501GO2ALLPROBES

IC: inferred by curator

A more complete listing of evidence codes can be found at:
http://www.geneontology.org/GO.evidence.shtml

11

Mappings between probe identifiers and GO information were obtained through their mappings to
Entrez Gene identifiers. NAs are assigned to probe identifiers that can not be mapped to any Gene
Ontology information. Mappings between Gene Ontology identifiers an Gene Ontology terms and
other information are available in a separate data package named GO.

Mappings were based on data provided by: Gene Ontology http://current.geneontology.org/ontology/go-
basic.obo With a date stamp from the source of: 2021-02-01

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- ath1121501GO
# Get the probe identifiers that are mapped to a GO ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Try the firest one
got <- xx[[1]]
got[[1]][["GOID"]]
got[[1]][["Ontology"]]
got[[1]][["Evidence"]]

}

ath1121501GO2ALLPROBES

Map between Gene Ontology (GO) Identifiers and all Manufacturer
Identifiers in the subtree

Description

ath1121501GO2ALLPROBES is an R object that provides mappings between a given GO identifier
and all manufactuerer identifiers annotated at that GO term or one of its children in the GO ontology.

Details

GO consists of three ontologies—molecular function (MF), biological process (BP), and cellular
component (CC). All ontologies are structured as directed acyclic graphs (DAGs). Each node in
each DAG (tree) is a GO term (id) associated with a named vector of manufacturer identifiers. The

12

ath1121501GO2ALLPROBES

name associated with each manufacturer id corresponds to the evidence code for that GO identi-
fier. This object ath1121501GO2ALLPROBES maps between a given GO identifier and all manu-
factuerer identifiers annotated at that GO term or one of its children in the GO ontology.

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

A GO identifier may be mapped to the same manufacturer identifier more than once but the evidence
code can be different. Mappings between Gene Ontology identifiers and Gene Ontology terms and
other information are available in a separate data package named GO.

Mappings were based on data provided by:

Gene Ontology http://current.geneontology.org/ontology/go-basic.obo With a date stamp from the
source of: 2021-02-01

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
# Convert to a list
xx <- as.list(ath1121501GO2ALLPROBES)
if(length(xx) > 0){

# Gets the probe identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets all the probe identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

ath1121501GO2PROBE

13

ath1121501GO2PROBE

Map between Gene Ontology (GO) and Manufacturer Identifiers

Description

ath1121501GO2PROBE is an R object that provides mappings between GO identifiers and manu-
facturer identifiers.

Details

Each GO term maps to a named vector of manufacturer identifiers. The name associated with
each manufacturer identifier corresponds to the evidence code for that GO identifier. The evidence
code indicates what kind of evidence supports the association between the GO and Entrez Gene
identifiers. Evidence codes currently in use include:

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

A GO identifier may be mapped to the same probe identifier more than once but the evidence code
can be different. Mappings between Gene Ontology identifiers an Gene Ontology terms and other
information are available in a separate data package named GO.

Mappings were based on data provided by:

Gene Ontology http://current.geneontology.org/ontology/go-basic.obo With a date stamp from the
source of: 2021-02-01

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:

14

ath1121501ORGANISM

# Convert to a list
xx <- as.list(ath1121501GO2PROBE)
if(length(xx) > 0){

# Gets the probe identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets the probe identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

ath1121501MAPCOUNTS

Number of mapped keys for the maps in package ath1121501.db

Description

DEPRECATED. Counts in the MAPCOUNT table are out of sync and should not be used.

ath1121501MAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each map
in package ath1121501.db.

Details

DEPRECATED. Counts in the MAPCOUNT table are out of sync and should not be used.

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

ath1121501ORGANISM

The Organism information for ath1121501

Description

ath1121501ORGANISM is an R object that contains a single item: a character string that names
the organism for which ath1121501 was built. ath1121501ORGPKG is an R object that contains
a chararcter vector with the name of the organism package that a chip package depends on for its
gene-centric annotation.

Details

Although the package name is suggestive of the organism for which it was built, ath1121501ORGANISM
provides a simple way to programmatically extract the organism name. ath1121501ORGPKG pro-
vides a simple way to programmatically extract the name of the parent organism package. The
parent organism package is a strict dependency for chip packages as this is where the gene cetric
information is ultimately extracted from. The full package name will always be this string plus the
extension ".db". But most programatic access will not require this extension, so its more convenient
to leave it out.

Examples

ath1121501ORGANISM
ath1121501ORGPKG

ath1121501PATH

15

ath1121501PATH

Mappings between probe identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms. ath1121501PATH maps probe identifiers to the identifiers used by KEGG for pathways in
which the genes represented by the probe identifiers are involved

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
x <- ath1121501PATH
# Get the probe identifiers that are mapped to a KEGG pathway ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the PATH for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

16

ath1121501PATH2PROBE

ath1121501PATH2PROBE Map between Kyoto Encyclopedia of Genes and Genomes (KEGG)

pathway identifiers and Manufacturer Identifiers

Description

ath1121501PATH2PROBE is an R object that provides mappings between KEGG identifiers and
manufacturer identifiers.

Details

Each KEGG identifier is mapped to a named vector of manufacturer identifiers. The name rep-
resents the KEGG identifier and the vector contains all manufacturer identifiers that are found in
that particular pathway. An NA is reported for any KEGG identifier that cannot be mapped to any
manufacturer identifiers.

Pathway name for a given pathway identifier can be obtained using the KEGG data package that can
either be built using AnnBuilder or downloaded from Bioconductor http://www.bioconductor.
org.
Graphic presentations of pathways are searchable at http://www.genome.ad.jp/kegg/pathway.
html using pathway identifiers as keys.

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
# Convert the object to a list
xx <- as.list(ath1121501PATH2PROBE)
# Remove pathway identifiers that do not map to any probe id
xx <- xx[!is.na(xx)]
if(length(xx) > 0){

# The probe identifiers for the first two elements of XX
xx[1:2]
# Get the first one
xx[[1]]

}

ath1121501PMID

17

ath1121501PMID

Map between Manufacturer Identifiers and PubMed Identifiers

Description

ath1121501PMID is an R object that provides mappings between manufacturer identifiers and
PubMed identifiers.

Details

Each manufacturer identifier is mapped to a named vector of PubMed identifiers. The name asso-
ciated with each vector corresponds to the manufacturer identifier. The length of the vector may
be one or greater, depending on how many PubMed identifiers a given manufacturer identifier is
mapped to. An NA is reported for any manufacturer identifier that cannot be mapped to a PubMed
identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose.

Mappings were based on data provided by: Tair https://www.arabidopsis.org/download\_files/Public\_Data\_Releases/TAIR\_Data\_20200331/Locus\_Published\_20200331.txt.gz
With a date stamp from the source of: 2021-Apr15

References

https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=PubMed

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- ath1121501PMID
# Get the probe identifiers that are mapped to any PubMed ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0){

# The probe identifiers for the first two elements of XX
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

18

ath1121501PMID2PROBE

ath1121501PMID2PROBE Map between PubMed Identifiers and Manufacturer Identifiers

Description

ath1121501PMID2PROBE is an R object that provides mappings between PubMed identifiers and
manufacturer identifiers.

Details

Each PubMed identifier is mapped to a named vector of manufacturer identifiers. The name repre-
sents the PubMed identifier and the vector contains all manufacturer identifiers that are represented
by that PubMed identifier. The length of the vector may be one or longer, depending on how many
manufacturer identifiers are mapped to a given PubMed identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose

Mappings were based on data provided by: Tair https://www.arabidopsis.org/download\_files/Public\_Data\_Releases/TAIR\_Data\_20200331/Locus\_Published\_20200331.txt.gz
With a date stamp from the source of: 2021-Apr15

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
# Convert the object to a list
xx <- as.list(ath1121501PMID2PROBE)
if(length(xx) > 0){

# The probe identifiers for the first two elements of XX
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

ath1121501SYMBOL

19

ath1121501SYMBOL

Map between Manufacturer Identifiers and Gene Symbols

Description

ath1121501SYMBOL is an R object that provides mappings between manufacturer identifiers and
gene abbreviations.

Details

Each manufacturer identifier is mapped to an abbreviation for the corresponding gene. An NA is
reported if there is no known abbreviation for a given gene.

Symbols typically consist of 3 letters that define either a single gene (ABC) or multiple genes
(ABC1, ABC2, ABC3). Gene symbols can be used as key words to query public databases such as
Entrez Gene.

Mappings were based on data provided by: Tair https://www.arabidopsis.org/download\_files/Public\_Data\_Releases/TAIR\_Data\_20200331/gene\_aliases\_20200331.txt.gz
With a date stamp from the source of: 2021-Apr15

References

https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- ath1121501SYMBOL
# Get the probe identifiers that are mapped to a gene symbol
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the SYMBOL for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

20

ath1121501_dbconn

ath1121501_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

ath1121501_dbconn()
ath1121501_dbfile()
ath1121501_dbschema(file="", show.indices=FALSE)
ath1121501_dbInfo()

Arguments

file

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

ath1121501_dbconn returns a connection object to the package annotation DB. IMPORTANT:
Don’t call dbDisconnect on the connection object returned by ath1121501_dbconn or you will
break all the AnnDbObj objects defined in this package!

ath1121501_dbfile returns the path (character string) to the package annotation DB (this is an
SQLite file).

ath1121501_dbschema prints the schema definition of the package annotation DB.

ath1121501_dbInfo prints other information about the package annotation DB.

Value

ath1121501_dbconn: a DBIConnection object representing an open connection to the package
annotation DB.

ath1121501_dbfile: a character string with the path to the package annotation DB.

ath1121501_dbschema: none (invisible NULL).

ath1121501_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

ath1121501_dbconn

Examples

21

library(DBI)
## Count the number of rows in the "probes" table:
dbGetQuery(ath1121501_dbconn(), "SELECT COUNT(*) FROM probes")

ath1121501_dbschema()

ath1121501_dbInfo()

ath1121501ENZYME2PROBE, 8
ath1121501GENENAME, 9
ath1121501GO, 10
ath1121501GO2ALLPROBES, 11
ath1121501GO2PROBE, 13
ath1121501MAPCOUNTS, 14
ath1121501ORGANISM, 14
ath1121501ORGPKG (ath1121501ORGANISM),

14
ath1121501PATH, 15
ath1121501PATH2PROBE, 16
ath1121501PMID, 17
ath1121501PMID2PROBE, 18
ath1121501SYMBOL, 19

cat, 20
checkMAPCOUNTS, 14

dbconn, 20
dbConnect, 20
dbDisconnect, 20
dbfile, 20
dbGetQuery, 20
dbInfo, 20
dbschema, 20

nhit, 1

Index

∗ datasets

ath1121501.db, 4
ath1121501_dbconn, 20
ath1121501ACCNUM, 1
ath1121501ARACYC, 2
ath1121501ARACYCENZYME, 3
ath1121501CHR, 4
ath1121501CHRLENGTHS, 5
ath1121501CHRLOC, 6
ath1121501ENZYME, 7
ath1121501ENZYME2PROBE, 8
ath1121501GENENAME, 9
ath1121501GO, 10
ath1121501GO2ALLPROBES, 11
ath1121501GO2PROBE, 13
ath1121501MAPCOUNTS, 14
ath1121501ORGANISM, 14
ath1121501PATH, 15
ath1121501PATH2PROBE, 16
ath1121501PMID, 17
ath1121501PMID2PROBE, 18
ath1121501SYMBOL, 19

∗ utilities

ath1121501_dbconn, 20

AnnDbObj, 20
ath1121501 (ath1121501.db), 4
ath1121501.db, 4
ath1121501_dbconn, 20
ath1121501_dbfile (ath1121501_dbconn),

20

ath1121501_dbInfo (ath1121501_dbconn),

20
ath1121501_dbschema

(ath1121501_dbconn), 20

ath1121501ACCNUM, 1
ath1121501ARACYC, 2
ath1121501ARACYCENZYME, 3
ath1121501CHR, 4
ath1121501CHRLENGTHS, 5
ath1121501CHRLOC, 6
ath1121501CHRLOCEND (ath1121501CHRLOC),

6
ath1121501ENZYME, 7

22

