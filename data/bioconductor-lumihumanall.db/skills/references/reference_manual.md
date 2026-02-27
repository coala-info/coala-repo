lumiHumanAll.db

February 25, 2026

lumiHumanAllACCNUM

Map Manufacturer identifiers to Accession Numbers

Description

lumiHumanAllACCNUM is an R object that contains mappings between a manufacturer’s identi-
fiers and manufacturers accessions.

Details

For chip packages such as this, the ACCNUM mapping comes directly from the manufacturer. This
is different from other mappings which are mapped onto the probes via an Entrez Gene identifier.

Each manufacturer identifier maps to a vector containing a GenBank accession number.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2013-Sep12

Examples

x <- lumiHumanAllACCNUM
# Get the probe identifiers that are mapped to an ACCNUM
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the ACCNUM for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

1

2

lumiHumanAll.db

lumiHumanAllALIAS2PROBE

Map between Common Gene Symbol Identifiers and Manufacturer
Identifiers

Description

lumiHumanAllALIAS is an R object that provides mappings between common gene symbol iden-
tifiers and manufacturer identifiers.

Details

Each gene symbol is mapped to a named vector of manufacturer identifiers. The name represents
the gene symbol and the vector contains all manufacturer identifiers that are found for that symbol.
An NA is reported for any gene symbol that cannot be mapped to any manufacturer identifiers.

This mapping includes ALL gene symbols including those which are already listed in the SYMBOL
map. The SYMBOL map is meant to only list official gene symbols, while the ALIAS maps are
meant to store all used symbols.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2013-Sep12

Examples

# Convert the object to a list
xx <- as.list(lumiHumanAllALIAS2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two aliases
xx[1:2]
# Get the first one
xx[[1]]

}

lumiHumanAll.db

Bioconductor annotation data package

Description

Welcome to the lumiHumanAll.db annotation Package. The purpose of this package is to provide
detailed information about the lumiHumanAll platform. This package is updated biannually.

You can learn what objects this package supports with the following command:

ls("package:lumiHumanAll.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:lumiHumanAll.db")

lumiHumanAllCHR

3

lumiHumanAllCHR

Map Manufacturer IDs to Chromosomes

Description

lumiHumanAllCHR is an R object that provides mappings between a manufacturer identifier and
the chromosome that contains the gene of interest.

Details

Each manufacturer identifier maps to a vector of chromosomes. Due to inconsistencies that may
exist at the time the object was built, the vector may contain more than one chromosome (e.g., the
identifier may map to more than one chromosome). If the chromosomal location is unknown, the
vector will contain an NA.
Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2013-Sep12

Examples

x <- lumiHumanAllCHR
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

lumiHumanAllCHRLENGTHS

A named vector for the length of each of the chromosomes

Description

lumiHumanAllCHRLENGTHS provides the length measured in base pairs for each of the chromo-
somes.

Details

This is a named vector with chromosome numbers as the names and the corresponding lengths for
chromosomes as the values.

Total lengths of chromosomes were derived by calculating the number of base pairs on the sequence
string for each chromosome.

Examples

tt <- lumiHumanAllCHRLENGTHS
# Length of chromosome 1
tt["1"]

4

lumiHumanAllENSEMBL

lumiHumanAllCHRLOC

Map Manufacturer IDs to Chromosomal Location

Description

lumiHumanAllCHRLOC is an R object that maps manufacturer identifiers to the starting position
of the gene. The position of a gene is measured as the number of base pairs.

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

Since some genes have multiple start sites, this field can map to multiple locations.

Mappings were based on data provided by: UCSC Genome Bioinformatics (Homo sapiens) ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19
With a date stamp from the source of: 2010-Mar22

Examples

x <- lumiHumanAllCHRLOC
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

lumiHumanAllENSEMBL

Map Ensembl gene accession numbers with Entrez Gene identifiers

Description

lumiHumanAllENSEMBL is an R object that contains mappings between manufacturer identifiers
and Ensembl gene accession numbers.

lumiHumanAllENTREZID

Details

5

This object is a simple mapping of manufacturer identifiers to Ensembl gene Accession Numbers.

Mappings were based on data provided by BOTH of these sources: http://www.ensembl.org/
biomart/martview/ ftp://ftp.ncbi.nlm.nih.gov/gene/DATA

For most species, this mapping is a combination of manufacturer to ensembl IDs from BOTH
NCBI and ensembl. Users who wish to only use mappings from NCBI are encouraged to see
the ncbi2ensembl table in the appropriate organism package. Users who wish to only use mappings
from ensembl are encouraged to see the ensembl2ncbi table which is also found in the appropriate
organism packages. These mappings are based upon the ensembl table which is contains data from
BOTH of these sources in an effort to maximize the chances that you will find a match.

For worms and flies however, this mapping is based only on sources from ensembl, as these organ-
isms do not have ensembl to entrez gene mapping data at NCBI.

Examples

x <- lumiHumanAllENSEMBL
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
#For the reverse map ENSEMBL2PROBE:
# Convert to a list
xx <- as.list(lumiHumanAllENSEMBL2PROBE)
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

lumiHumanAllENTREZID Map between Manufacturer Identifiers and Entrez Gene

Description

lumiHumanAllENTREZID is an R object that provides mappings between manufacturer identifiers
and Entrez Gene identifiers.

Details

Each manufacturer identifier is mapped to a vector of Entrez Gene identifiers. An NA is assigned to
those manufacturer identifiers that can not be mapped to an Entrez Gene identifier at this time.

If a given manufacturer identifier can be mapped to different Entrez Gene identifiers from various
sources, we attempt to select the common identifiers. If a concensus cannot be determined, we
select the smallest identifier.

6

lumiHumanAllENZYME

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2013-Sep12

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- lumiHumanAllENTREZID
# Get the probe identifiers that are mapped to an ENTREZ Gene ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the ENTREZID for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

lumiHumanAllENZYME

Maps between Manufacturer IDs and Enzyme Commission (EC) Num-
bers

Description

lumiHumanAllENZYME is an R object that provides mappings between manufacturer identifiers
and EC numbers. lumiHumanAllENZYME2PROBE is an R object that maps Enzyme Commission
(EC) numbers to manufacturer identifiers.

Details

When the lumiHumanAllENZYME maping viewed as a list, each manufacturer identifier maps to
a named vector containing the EC number that corresponds to the enzyme produced by that gene.
The names corresponds to the manufacturer identifiers. If this information is unknown, the vector
will contain an NA.

For the lumiHumanAllENZYME2PROBE, each EC number maps to a named vector containing all
of the manufacturer identifiers that correspond to the gene that produces that enzyme. The name of
the vector corresponds to the EC number.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric num-
bers. In lumiHumanAllENZYME2PROBE, EC is dropped from the Enzyme Commission numbers.

Enzyme Commission numbers have corresponding names that describe the functions of enzymes
in such a way that EC x is a more general description than EC x.y that in turn is a more general
description than EC x.y.z. The top level EC numbers and names are listed below:

EC 1 oxidoreductases

EC 2 transferases

lumiHumanAllGENENAME

7

EC 3 hydrolases

EC 4 lyases

EC 5 isomerases

EC 6 ligases

The EC name for a given EC number can be viewed at http://www.chem.qmul.ac.uk/iupac/
jcbn/index.html#6

Mappings between probe identifiers and enzyme identifiers were obtained using files provided by:
KEGG GENOME ftp://ftp.genome.jp/pub/kegg/genomes With a date stamp from the source of:
2011-Mar15

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

Examples

x <- lumiHumanAllENZYME
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

# Now convert lumiHumanAllENZYME2PROBE to a list to see inside
xx <- as.list(lumiHumanAllENZYME2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first five enzyme
#commission numbers
xx[1:5]
# Get the first one
xx[[1]]

}

lumiHumanAllGENENAME Map between Manufacturer IDs and Genes

Description

lumiHumanAllGENENAME is an R object that maps manufacturer identifiers to the corresponding
gene name.

Details

Each manufacturer identifier maps to a named vector containing the gene name. The vector name
corresponds to the manufacturer identifier. If the gene name is unknown, the vector will contain an
NA.

8

lumiHumanAllGO

Gene names currently include both the official (validated by a nomenclature committee) and pre-
ferred names (interim selected for display) for genes. Efforts are being made to differentiate the
two by adding a name to the vector.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2013-Sep12

Examples

x <- lumiHumanAllGENENAME
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

lumiHumanAllGO

Maps between manufacturer IDs and Gene Ontology (GO) IDs

Description

lumiHumanAllGO is an R object that provides mappings between manufacturer identifiers and
the GO identifiers that they are directly associated with. This mapping and its reverse mapping
(lumiHumanAllGO2PROBE) do NOT associate the child terms from the GO ontology with the
gene. Only the directly evidenced terms are represented here.

lumiHumanAllGO2ALLPROBES is an R object that provides mappings between a given GO iden-
tifier and all of the manufacturer identifiers annotated at that GO term OR TO ONE OF IT’S CHILD
NODES in the GO ontology. Thus, this mapping is much larger and more inclusive than lumiHu-
manAllGO2PROBE.

Details

If lumiHumanAllGO is cast as a list, each manufacturer identifier is mapped to a list of lists. The
names on the outer list are GO identifiers. Each inner list consists of three named elements: GOID,
Ontology, and Evidence.

The GOID element matches the GO identifier named in the outer list and is included for convenience
when processing the data using ’lapply’.

The Ontology element indicates which of the three Gene Ontology categories this identifier belongs
to. The categories are biological process (BP), cellular component (CC), and molecular function
(MF).

The Evidence element contains a code indicating what kind of evidence supports the association of
the GO identifier to the manufacturer id. Some of the evidence codes in use include:

IMP: inferred from mutant phenotype

IGI: inferred from genetic interaction

IPI: inferred from physical interaction

lumiHumanAllGO

9

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

If lumiHumanAllGO2ALLPROBES or lumiHumanAllGO2PROBE is cast as a list, each GO term
maps to a named vector of manufacturer identifiers and evidence codes. A GO identifier may be
mapped to the same manufacturer identifier more than once but the evidence code can be different.
Mappings between Gene Ontology identifiers and Gene Ontology terms and other information are
available in a separate data package named GO.

Whenever any of these mappings are cast as a data.frame, all the results will be output in an appro-
priate tabular form.

Mappings between manufacturer identifiers and GO information were obtained through their map-
pings to manufacturer identifiers. NAs are assigned to manufacturer identifiers that can not be
mapped to any Gene Ontology information. Mappings between Gene Ontology identifiers an Gene
Ontology terms and other information are available in a separate data package named GO.

All mappings were based on data provided by: Gene Ontology ftp://ftp.geneontology.org/pub/go/godatabase/archive/latest-
lite/ With a date stamp from the source of: 20130907

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

See Also

lumiHumanAllGO2ALLPROBES.

Examples

x <- lumiHumanAllGO
# Get the manufacturer identifiers that are mapped to a GO ID
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
xx <- as.list(lumiHumanAllGO2PROBE)
if(length(xx) > 0){

10

lumiHumanAllMAP

# Gets the manufacturer ids for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets the manufacturer ids for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}
# Convert lumiHumanAllGO2ALLPROBES to a list
xx <- as.list(lumiHumanAllGO2ALLPROBES)
if(length(xx) > 0){

# Gets the manufacturer identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets all the manufacturer identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

lumiHumanAllMAP

Map between Manufacturer Identifiers and cytogenetic maps/bands

Description

lumiHumanAllMAP is an R object that provides mappings between manufacturer identifiers and
cytoband locations.

Details

Each manufacturer identifier is mapped to a vector of cytoband locations. The vector length may
be one or longer, if there are multiple reported chromosomal locations for a given gene. An NA is
reported for any manufacturer identifiers that cannot be mapped to a cytoband at this time.

Cytogenetic bands for most higher organisms are labeled p1, p2, p3, q1, q2, q3 (p and q are the p
and q arms), etc., counting from the centromere out toward the telomeres. At higher resolutions,
sub-bands can be seen within the bands. The sub-bands are also numbered from the centromere out
toward the telomere. Thus, a label of 7q31.2 indicates that the band is on chromosome 7, q arm,
band 3, sub-band 1, and sub-sub-band 2.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2013-Sep12

References

http://www.ncbi.nlm.nih.gov

Examples

x <- lumiHumanAllMAP
# Get the probe identifiers that are mapped to any cytoband
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the MAP for the first five probes
xx[1:5]

lumiHumanAllMAPCOUNTS

11

# Get the first one
xx[[1]]

}

lumiHumanAllMAPCOUNTS Number of mapped keys for the maps in package lumiHumanAll.db

Description

lumiHumanAllMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each
map in package lumiHumanAll.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

Examples

lumiHumanAllMAPCOUNTS
mapnames <- names(lumiHumanAllMAPCOUNTS)
lumiHumanAllMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package lumiHumanAll.db
checkMAPCOUNTS("lumiHumanAll.db")

lumiHumanAllOMIM

Map between Manufacturer Identifiers and Mendelian Inheritance in
Man (MIM) identifiers

Description

lumiHumanAllOMIM is an R object that provides mappings between manufacturer identifiers and
OMIM identifiers.

12

Details

lumiHumanAllORGANISM

Each manufacturer identifier is mapped to a vector of OMIM identifiers. The vector length may be
one or longer, depending on how many OMIM identifiers the manufacturer identifier maps to. An
NA is reported for any manufacturer identifier that cannot be mapped to an OMIM identifier at this
time.

OMIM is based upon the book Mendelian Inheritance in Man (V. A. McKusick) and focuses primar-
ily on inherited or heritable genetic diseases. It contains textual information, pictures, and reference
information that can be searched using various terms, among which the MIM number is one.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2013-Sep12

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene http://www3.ncbi.nlm.nih.gov/
entrez/query.fcgi?db=OMIM

Examples

x <- lumiHumanAllOMIM
# Get the probe identifiers that are mapped to a OMIM ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the OMIM for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

lumiHumanAllORGANISM

The Organism information for lumiHumanAll

Description

lumiHumanAllORGANISM is an R object that contains a single item: a character string that names
lumiHumanAllORGPKG is an R object that
the organism for which lumiHumanAll was built.
contains a chararcter vector with the name of the organism package that a chip package depends on
for its gene-centric annotation.

Details

Although the package name is suggestive of the organism for which it was built, lumiHumanAllOR-
GANISM provides a simple way to programmatically extract the organism name. lumiHumanAl-
lORGPKG provides a simple way to programmatically extract the name of the parent organism
package. The parent organism package is a strict dependency for chip packages as this is where
the gene cetric information is ultimately extracted from. The full package name will always be this
string plus the extension ".db". But most programatic acces will not require this extension, so its
more convenient to leave it out.

lumiHumanAllPATH

Examples

lumiHumanAllORGANISM
lumiHumanAllORGPKG

13

lumiHumanAllPATH

Mappings between probe identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms.

lumiHumanAllPATH maps probe identifiers to the identifiers used by KEGG for pathways in which
the genes represented by the probe identifiers are involved

lumiHumanAllPATH2PROBE is an R object that provides mappings between KEGG identifiers and
manufacturer identifiers.

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

Examples

x <- lumiHumanAllPATH
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

# Now convert the lumiHumanAllPATH2PROBE object to a list
xx <- as.list(lumiHumanAllPATH2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two pathway identifiers
xx[1:2]
# Get the first one
xx[[1]]

}

14

lumiHumanAllPMID

lumiHumanAllPFAM

Map Manufacturer IDs to Pfam IDs

Description

lumiHumanAllPFAM is an R object that provides mappings between a manufacturer identifier and
the associated Pfam identifiers.

Details

Each manufacturer identifier maps to a named vector of Pfam identifiers. The name for each Pfam
identifier is the IPI accession numbe where this Pfam identifier is found.

If the Pfam is a named NA, it means that the associated Entrez Gene id of this manufacturer identifier
is found in an IPI entry of the IPI database, but there is no Pfam identifier in the entry.

If the Pfam is a non-named NA, it means that the associated Entrez Gene id of this manufacturer
identifier is not found in any IPI entry of the IPI database.

Mappings were based on data provided by: Uniprot http://www.UniProt.org/ With a date stamp
from the source of: Mon Sep 16 12:05:19 2013

Examples

x <- lumiHumanAllPFAM
# Get the probe identifiers that are mapped to any Pfam ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
# randomly display 10 probes
sample(xx, 10)

lumiHumanAllPMID

Maps between Manufacturer Identifiers and PubMed Identifiers

Description

lumiHumanAllPMID is an R object that provides mappings between manufacturer identifiers and
PubMed identifiers. lumiHumanAllPMID2PROBE is an R object that provides mappings between
PubMed identifiers and manufacturer identifiers.

Details

When lumiHumanAllPMID is viewed as a list each manufacturer identifier is mapped to a named
vector of PubMed identifiers. The name associated with each vector corresponds to the manufac-
turer identifier. The length of the vector may be one or greater, depending on how many PubMed
identifiers a given manufacturer identifier is mapped to. An NA is reported for any manufacturer
identifier that cannot be mapped to a PubMed identifier.

When lumiHumanAllPMID2PROBE is viewed as a list each PubMed identifier is mapped to a
named vector of manufacturer identifiers. The name represents the PubMed identifier and the vector
contains all manufacturer identifiers that are represented by that PubMed identifier. The length of

lumiHumanAllPROSITE

15

the vector may be one or longer, depending on how many manufacturer identifiers are mapped to a
given PubMed identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2013-Sep12

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=PubMed

Examples

x <- lumiHumanAllPMID
# Get the probe identifiers that are mapped to any PubMed ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])

if(length(xx) > 0){

# Get the PubMed identifiers for the first two probe identifiers
xx[1:2]
# Get the first one
xx[[1]]
if(interactive() && !is.null(xx[[1]]) && !is.na(xx[[1]])

&& require(annotate)){

# Get article information as XML files
xmls <- pubmed(xx[[1]], disp = "data")
# View article information using a browser
pubmed(xx[[1]], disp = "browser")

}

}

# Now convert the reverse map object lumiHumanAllPMID2PROBE to a list
xx <- as.list(lumiHumanAllPMID2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two PubMed identifiers
xx[1:2]
# Get the first one
xx[[1]]
if(interactive() && require(annotate)){

# Get article information as XML files for a PubMed id
xmls <- pubmed(names(xx)[1], disp = "data")
# View article information using a browser
pubmed(names(xx)[1], disp = "browser")

}

}

lumiHumanAllPROSITE

Map Manufacturer IDs to PROSITE ID

Description

lumiHumanAllPROSITE is an R object that provides mappings between a manufacturer identifier
and the associated PROSITE identifiers.

16

Details

lumiHumanAllREFSEQ

Each manufacturer identifier maps to a named vector of PROSITE identifiers. The name for each
PROSITE identifier is the IPI accession numbe where this PROSITE identifier is found.

If the PROSITE is a named NA, it means that the associated Entrez Gene id of this manufacturer
identifier is found in an IPI entry of the IPI database, but there is no PROSITE identifier in the entry.

If the PROSITE is a non-named NA, it means that the associated Entrez Gene id of this manufacturer
identifier is not found in any IPI entry of the IPI database.

Mappings were based on data provided by: Uniprot http://www.UniProt.org/ With a date stamp
from the source of: Mon Sep 16 12:05:19 2013

Examples

x <- lumiHumanAllPROSITE
# Get the probe identifiers that are mapped to any PROSITE ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xxx <- as.list(x[mapped_probes])
# randomly display 10 probes
xxx[sample(1:length(xxx), 10)]

lumiHumanAllREFSEQ

Map between Manufacturer Identifiers and RefSeq Identifiers

Description

lumiHumanAllREFSEQ is an R object that provides mappings between manufacturer identifiers
and RefSeq identifiers.

Details

Each manufacturer identifier is mapped to a named vector of RefSeq identifiers. The name repre-
sents the manufacturer identifier and the vector contains all RefSeq identifiers that can be mapped
to that manufacturer identifier. The length of the vector may be one or greater, depending on how
many RefSeq identifiers a given manufacturer identifier can be mapped to. An NA is reported for
any manufacturer identifier that cannot be mapped to a RefSeq identifier at this time.

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
NCBI http://www.ncbi.nlm.nih.gov/RefSeq/ allows users to query the RefSeq database using
RefSeq identifiers.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2013-Sep12

17

lumiHumanAllSYMBOL

References

http://www.ncbi.nlm.nih.gov http://www.ncbi.nlm.nih.gov/RefSeq/

Examples

x <- lumiHumanAllREFSEQ
# Get the probe identifiers that are mapped to any RefSeq ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the REFSEQ for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

lumiHumanAllSYMBOL

Map between Manufacturer Identifiers and Gene Symbols

Description

lumiHumanAllSYMBOL is an R object that provides mappings between manufacturer identifiers
and gene abbreviations.

Details

Each manufacturer identifier is mapped to an abbreviation for the corresponding gene. An NA is
reported if there is no known abbreviation for a given gene.

Symbols typically consist of 3 letters that define either a single gene (ABC) or multiple genes
(ABC1, ABC2, ABC3). Gene symbols can be used as key words to query public databases such as
Entrez Gene.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2013-Sep12

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- lumiHumanAllSYMBOL
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

18

lumiHumanAllUNIPROT

lumiHumanAllUNIGENE

Map between Manufacturer Identifiers and UniGene cluster identifiers

Description

lumiHumanAllUNIGENE is an R object that provides mappings between manufacturer identifiers
and UniGene identifiers.

Details

Each manufacturer identifier is mapped to a UniGene identifier. An NA is reported if the manufac-
turer identifier cannot be mapped to UniGene at this time.

A UniGene identifier represents a cluster of sequences of a gene. Using UniGene identifiers one
can query the UniGene database for information about the sequences or the Entrez Gene database
for information about the genes.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2013-Sep12

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- lumiHumanAllUNIGENE
# Get the probe identifiers that are mapped to an UNIGENE ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the UNIGENE for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

lumiHumanAllUNIPROT

Map Uniprot accession numbers with Entrez Gene identifiers

Description

lumiHumanAllUNIPROT is an R object that contains mappings between the manufacturer identi-
fiers and Uniprot accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to Uniprot Accessions.

Mappings were based on data provided by NCBI (link above) with an exception for fly, which
required retrieving the data from ensembl http://www.ensembl.org/biomart/martview/

lumiHumanAll_dbconn

Examples

19

x <- lumiHumanAllUNIPROT
# Get the entrez gene IDs that are mapped to an Uniprot ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the Uniprot IDs for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

lumiHumanAll_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

lumiHumanAll_dbconn()
lumiHumanAll_dbfile()
lumiHumanAll_dbschema(file="", show.indices=FALSE)
lumiHumanAll_dbInfo()

Arguments

file

show.indices

Details

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).
The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

lumiHumanAll_dbconn returns a connection object to the package annotation DB. IMPORTANT:
Don’t call dbDisconnect on the connection object returned by lumiHumanAll_dbconn or you will
break all the AnnDbObj objects defined in this package!
lumiHumanAll_dbfile returns the path (character string) to the package annotation DB (this is an
SQLite file).
lumiHumanAll_dbschema prints the schema definition of the package annotation DB.
lumiHumanAll_dbInfo prints other information about the package annotation DB.

Value

lumiHumanAll_dbconn: a DBIConnection object representing an open connection to the package
annotation DB.
lumiHumanAll_dbfile: a character string with the path to the package annotation DB.
lumiHumanAll_dbschema: none (invisible NULL).
lumiHumanAll_dbInfo: none (invisible NULL).

20

See Also

lumiHumanAll_dbconn

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

## Count the number of rows in the "probes" table:
dbGetQuery(lumiHumanAll_dbconn(), "SELECT COUNT(*) FROM probes")

## The connection object returned by lumiHumanAll_dbconn() was
## created with:
dbConnect(SQLite(), dbname=lumiHumanAll_dbfile(), cache_size=64000,
synchronous=0)

lumiHumanAll_dbschema()

lumiHumanAll_dbInfo()

Index

∗ datasets

lumiHumanAll.db, 2
lumiHumanAll_dbconn, 19
lumiHumanAllACCNUM, 1
lumiHumanAllALIAS2PROBE, 2
lumiHumanAllCHR, 3
lumiHumanAllCHRLENGTHS, 3
lumiHumanAllCHRLOC, 4
lumiHumanAllENSEMBL, 4
lumiHumanAllENTREZID, 5
lumiHumanAllENZYME, 6
lumiHumanAllGENENAME, 7
lumiHumanAllGO, 8
lumiHumanAllMAP, 10
lumiHumanAllMAPCOUNTS, 11
lumiHumanAllOMIM, 11
lumiHumanAllORGANISM, 12
lumiHumanAllPATH, 13
lumiHumanAllPFAM, 14
lumiHumanAllPMID, 14
lumiHumanAllPROSITE, 15
lumiHumanAllREFSEQ, 16
lumiHumanAllSYMBOL, 17
lumiHumanAllUNIGENE, 18
lumiHumanAllUNIPROT, 18

∗ utilities

lumiHumanAll_dbconn, 19

AnnDbObj, 19

cat, 19
checkMAPCOUNTS, 11
count.mappedkeys, 11

dbconn, 20
dbConnect, 20
dbDisconnect, 19
dbfile, 20
dbGetQuery, 20
dbInfo, 20
dbschema, 20

lumiHumanAll (lumiHumanAll.db), 2
lumiHumanAll.db, 2

21

lumiHumanAll_dbconn, 19
lumiHumanAll_dbfile

(lumiHumanAll_dbconn), 19

lumiHumanAll_dbInfo

(lumiHumanAll_dbconn), 19

lumiHumanAll_dbschema

(lumiHumanAll_dbconn), 19

lumiHumanAllACCNUM, 1
lumiHumanAllALIAS2PROBE, 2
lumiHumanAllCHR, 3
lumiHumanAllCHRLENGTHS, 3
lumiHumanAllCHRLOC, 4
lumiHumanAllCHRLOCEND

(lumiHumanAllCHRLOC), 4

lumiHumanAllENSEMBL, 4
lumiHumanAllENSEMBL2PROBE

(lumiHumanAllENSEMBL), 4

lumiHumanAllENTREZID, 5
lumiHumanAllENZYME, 6
lumiHumanAllENZYME2PROBE

(lumiHumanAllENZYME), 6

lumiHumanAllGENENAME, 7
lumiHumanAllGO, 8
lumiHumanAllGO2ALLPROBES, 9
lumiHumanAllGO2ALLPROBES

(lumiHumanAllGO), 8

lumiHumanAllGO2PROBE (lumiHumanAllGO), 8
lumiHumanAllLOCUSID

(lumiHumanAllENTREZID), 5

lumiHumanAllMAP, 10
lumiHumanAllMAPCOUNTS, 11
lumiHumanAllOMIM, 11
lumiHumanAllORGANISM, 12
lumiHumanAllORGPKG

(lumiHumanAllORGANISM), 12

lumiHumanAllPATH, 13
lumiHumanAllPATH2PROBE

(lumiHumanAllPATH), 13

lumiHumanAllPFAM, 14
lumiHumanAllPMID, 14
lumiHumanAllPMID2PROBE

(lumiHumanAllPMID), 14

lumiHumanAllPROSITE, 15

22

INDEX

lumiHumanAllREFSEQ, 16
lumiHumanAllSYMBOL, 17
lumiHumanAllUNIGENE, 18
lumiHumanAllUNIPROT, 18
lumiHumanAllUNIPROT2PROBE

(lumiHumanAllUNIPROT), 18

mappedkeys, 11

