mi16cod.db

February 25, 2026

mi16codACCNUM

Map Manufacturer identifiers to Accession Numbers

Description

mi16codACCNUM is an R object that contains mappings between a manufacturer’s identifiers and
manufacturers accessions.

Details

For chip packages such as this, the ACCNUM mapping comes directly from the manufacturer. This
is different from other mappings which are mapped onto the probes via an Entrez Gene identifier.

Each manufacturer identifier maps to a vector containing a GenBank accession number.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

Examples

x <- mi16codACCNUM
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

mi16cod.db

mi16codALIAS2PROBE

Map between Common Gene Symbol Identifiers and Manufacturer
Identifiers

Description

mi16codALIAS is an R object that provides mappings between common gene symbol identifiers
and manufacturer identifiers.

Details

Each gene symbol is mapped to a named vector of manufacturer identifiers. The name represents
the gene symbol and the vector contains all manufacturer identifiers that are found for that symbol.
An NA is reported for any gene symbol that cannot be mapped to any manufacturer identifiers.

This mapping includes ALL gene symbols including those which are already listed in the SYMBOL
map. The SYMBOL map is meant to only list official gene symbols, while the ALIAS maps are
meant to store all used symbols.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

Examples

# Convert the object to a list
xx <- as.list(mi16codALIAS2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two aliases
xx[1:2]
# Get the first one
xx[[1]]

}

mi16cod.db

Bioconductor annotation data package

Description

Welcome to the mi16cod.db annotation Package. The purpose of this package is to provide detailed
information about the mi16cod platform. This package is updated biannually.

You can learn what objects this package supports with the following command:

ls("package:mi16cod.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:mi16cod.db")

mi16codCHR

3

mi16codCHR

Map Manufacturer IDs to Chromosomes

Description

mi16codCHR is an R object that provides mappings between a manufacturer identifier and the
chromosome that contains the gene of interest.

Details

Each manufacturer identifier maps to a vector of chromosomes. Due to inconsistencies that may
exist at the time the object was built, the vector may contain more than one chromosome (e.g., the
identifier may map to more than one chromosome). If the chromosomal location is unknown, the
vector will contain an NA.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

Examples

x <- mi16codCHR
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

mi16codCHRLENGTHS

A named vector for the length of each of the chromosomes

Description

mi16codCHRLENGTHS provides the length measured in base pairs for each of the chromosomes.

Details

This is a named vector with chromosome numbers as the names and the corresponding lengths for
chromosomes as the values.

Total lengths of chromosomes were derived by calculating the number of base pairs on the sequence
string for each chromosome.

Examples

tt <- mi16codCHRLENGTHS
# Length of chromosome 1
tt["1"]

4

mi16codENSEMBL

mi16codCHRLOC

Map Manufacturer IDs to Chromosomal Location

Description

mi16codCHRLOC is an R object that maps manufacturer identifiers to the starting position of the
gene. The position of a gene is measured as the number of base pairs.

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

Mappings were based on data provided by: UCSC Genome Bioinformatics (Mus musculus) ftp://hgdownload.cse.ucsc.edu/goldenPath/mm10
With a date stamp from the source of: 2012-Mar8

Examples

x <- mi16codCHRLOC
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

mi16codENSEMBL

Map Ensembl gene accession numbers with Entrez Gene identifiers

Description

mi16codENSEMBL is an R object that contains mappings between manufacturer identifiers and
Ensembl gene accession numbers.

mi16codENTREZID

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

x <- mi16codENSEMBL
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
xx <- as.list(mi16codENSEMBL2PROBE)
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

mi16codENTREZID

Map between Manufacturer Identifiers and Entrez Gene

Description

mi16codENTREZID is an R object that provides mappings between manufacturer identifiers and
Entrez Gene identifiers.

Details

Each manufacturer identifier is mapped to a vector of Entrez Gene identifiers. An NA is assigned to
those manufacturer identifiers that can not be mapped to an Entrez Gene identifier at this time.

If a given manufacturer identifier can be mapped to different Entrez Gene identifiers from various
sources, we attempt to select the common identifiers. If a concensus cannot be determined, we
select the smallest identifier.

6

mi16codENZYME

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- mi16codENTREZID
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

mi16codENZYME

Maps between Manufacturer IDs and Enzyme Commission (EC) Num-
bers

Description

mi16codENZYME is an R object that provides mappings between manufacturer identifiers and EC
numbers. mi16codENZYME2PROBE is an R object that maps Enzyme Commission (EC) numbers
to manufacturer identifiers.

Details

When the mi16codENZYME maping viewed as a list, each manufacturer identifier maps to a named
vector containing the EC number that corresponds to the enzyme produced by that gene. The names
corresponds to the manufacturer identifiers. If this information is unknown, the vector will contain
an NA.

For the mi16codENZYME2PROBE, each EC number maps to a named vector containing all of the
manufacturer identifiers that correspond to the gene that produces that enzyme. The name of the
vector corresponds to the EC number.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In mi16codENZYME2PROBE, EC is dropped from the Enzyme Commission numbers.

Enzyme Commission numbers have corresponding names that describe the functions of enzymes
in such a way that EC x is a more general description than EC x.y that in turn is a more general
description than EC x.y.z. The top level EC numbers and names are listed below:

EC 1 oxidoreductases

EC 2 transferases

mi16codGENENAME

EC 3 hydrolases

EC 4 lyases

EC 5 isomerases

EC 6 ligases

7

The EC name for a given EC number can be viewed at http://www.chem.qmul.ac.uk/iupac/
jcbn/index.html#6

Mappings between probe identifiers and enzyme identifiers were obtained using files provided by:
KEGG GENOME ftp://ftp.genome.jp/pub/kegg/genomes With a date stamp from the source of:
2011-Mar15

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

Examples

x <- mi16codENZYME
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

# Now convert mi16codENZYME2PROBE to a list to see inside
xx <- as.list(mi16codENZYME2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first five enzyme
#commission numbers
xx[1:5]
# Get the first one
xx[[1]]

}

mi16codGENENAME

Map between Manufacturer IDs and Genes

Description

mi16codGENENAME is an R object that maps manufacturer identifiers to the corresponding gene
name.

Details

Each manufacturer identifier maps to a named vector containing the gene name. The vector name
corresponds to the manufacturer identifier. If the gene name is unknown, the vector will contain an
NA.

8

mi16codGO

Gene names currently include both the official (validated by a nomenclature committee) and pre-
ferred names (interim selected for display) for genes. Efforts are being made to differentiate the
two by adding a name to the vector.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

Examples

x <- mi16codGENENAME
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

mi16codGO

Maps between manufacturer IDs and Gene Ontology (GO) IDs

Description

mi16codGO is an R object that provides mappings between manufacturer identifiers and the GO
identifiers that they are directly associated with. This mapping and its reverse mapping (mi16codGO2PROBE)
do NOT associate the child terms from the GO ontology with the gene. Only the directly evidenced
terms are represented here.

mi16codGO2ALLPROBES is an R object that provides mappings between a given GO identifier
and all of the manufacturer identifiers annotated at that GO term OR TO ONE OF IT’S CHILD
NODES in the GO ontology. Thus, this mapping is much larger and more inclusive than mi16codGO2PROBE.

Details

If mi16codGO is cast as a list, each manufacturer identifier is mapped to a list of lists. The names on
the outer list are GO identifiers. Each inner list consists of three named elements: GOID, Ontology,
and Evidence.

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

ISS: inferred from sequence similarity

mi16codGO

9

IDA: inferred from direct assay

IEP: inferred from expression pattern

IEA: inferred from electronic annotation

TAS: traceable author statement

NAS: non-traceable author statement

ND: no biological data available

IC: inferred by curator

A more complete listing of evidence codes can be found at:

http://www.geneontology.org/GO.evidence.shtml

If mi16codGO2ALLPROBES or mi16codGO2PROBE is cast as a list, each GO term maps to a
named vector of manufacturer identifiers and evidence codes. A GO identifier may be mapped to
the same manufacturer identifier more than once but the evidence code can be different. Mappings
between Gene Ontology identifiers and Gene Ontology terms and other information are available in
a separate data package named GO.

Whenever any of these mappings are cast as a data.frame, all the results will be output in an appro-
priate tabular form.

Mappings between manufacturer identifiers and GO information were obtained through their map-
pings to manufacturer identifiers. NAs are assigned to manufacturer identifiers that can not be
mapped to any Gene Ontology information. Mappings between Gene Ontology identifiers an Gene
Ontology terms and other information are available in a separate data package named GO.

All mappings were based on data provided by: Gene Ontology ftp://ftp.geneontology.org/pub/go/godatabase/archive/latest-
lite/ With a date stamp from the source of: 20150919

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

See Also

mi16codGO2ALLPROBES.

Examples

x <- mi16codGO
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
xx <- as.list(mi16codGO2PROBE)
if(length(xx) > 0){

# Gets the manufacturer ids for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]

10

mi16codMAPCOUNTS

# Gets the manufacturer ids for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}
# Convert mi16codGO2ALLPROBES to a list
xx <- as.list(mi16codGO2ALLPROBES)
if(length(xx) > 0){

# Gets the manufacturer identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets all the manufacturer identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

mi16codMAPCOUNTS

Number of mapped keys for the maps in package mi16cod.db

Description

mi16codMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each map in
package mi16cod.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

Examples

mi16codMAPCOUNTS
mapnames <- names(mi16codMAPCOUNTS)
mi16codMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package mi16cod.db
checkMAPCOUNTS("mi16cod.db")

mi16codMGI

11

mi16codMGI

Map MGI gene accession numbers with manufacturer identifiers

Description

mi16codMGI is an R object that contains mappings between manufacturer identifiers and Jackson
Laboratory MGI gene accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to MGI gene Accession Numbers.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

Examples

x <- mi16codMGI
# Get the manufacturer IDs that are mapped to an MGI ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the MGI IDs for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}
#For the reverse map MGI2EG:
# Convert to a list
xx <- as.list(mi16codMGI2PROBE)
if(length(xx) > 0){

# Gets the manufacturer IDs for the first five MGI IDs
xx[1:5]
# Get the first one
xx[[1]]

}

mi16codORGANISM

The Organism information for mi16cod

Description

mi16codORGANISM is an R object that contains a single item: a character string that names the
organism for which mi16cod was built. mi16codORGPKG is an R object that contains a chararcter
vector with the name of the organism package that a chip package depends on for its gene-centric
annotation.

12

Details

mi16codPATH

Although the package name is suggestive of the organism for which it was built, mi16codORGANISM
provides a simple way to programmatically extract the organism name. mi16codORGPKG provides
a simple way to programmatically extract the name of the parent organism package. The parent or-
ganism package is a strict dependency for chip packages as this is where the gene cetric information
is ultimately extracted from. The full package name will always be this string plus the extension
".db". But most programatic acces will not require this extension, so its more convenient to leave it
out.

Examples

mi16codORGANISM
mi16codORGPKG

mi16codPATH

Mappings between probe identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms.

mi16codPATH maps probe identifiers to the identifiers used by KEGG for pathways in which the
genes represented by the probe identifiers are involved

mi16codPATH2PROBE is an R object that provides mappings between KEGG identifiers and man-
ufacturer identifiers.

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

x <- mi16codPATH
# Get the probe identifiers that are mapped to a KEGG pathway ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the PATH for the first five probes
xx[1:5]
# Get the first one

mi16codPMID

xx[[1]]

}

13

# Now convert the mi16codPATH2PROBE object to a list
xx <- as.list(mi16codPATH2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two pathway identifiers
xx[1:2]
# Get the first one
xx[[1]]

}

mi16codPMID

Maps between Manufacturer Identifiers and PubMed Identifiers

Description

mi16codPMID is an R object that provides mappings between manufacturer identifiers and PubMed
identifiers. mi16codPMID2PROBE is an R object that provides mappings between PubMed identi-
fiers and manufacturer identifiers.

Details

When mi16codPMID is viewed as a list each manufacturer identifier is mapped to a named vector
of PubMed identifiers. The name associated with each vector corresponds to the manufacturer iden-
tifier. The length of the vector may be one or greater, depending on how many PubMed identifiers
a given manufacturer identifier is mapped to. An NA is reported for any manufacturer identifier that
cannot be mapped to a PubMed identifier.

When mi16codPMID2PROBE is viewed as a list each PubMed identifier is mapped to a named
vector of manufacturer identifiers. The name represents the PubMed identifier and the vector con-
tains all manufacturer identifiers that are represented by that PubMed identifier. The length of the
vector may be one or longer, depending on how many manufacturer identifiers are mapped to a
given PubMed identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=PubMed

Examples

x <- mi16codPMID
# Get the probe identifiers that are mapped to any PubMed ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])

if(length(xx) > 0){

# Get the PubMed identifiers for the first two probe identifiers
xx[1:2]

14

mi16codREFSEQ

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

# Now convert the reverse map object mi16codPMID2PROBE to a list
xx <- as.list(mi16codPMID2PROBE)
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

mi16codREFSEQ

Map between Manufacturer Identifiers and RefSeq Identifiers

Description

mi16codREFSEQ is an R object that provides mappings between manufacturer identifiers and Ref-
Seq identifiers.

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

mi16codSYMBOL

15

Where XXXXX is a sequence of integers.

NCBI http://www.ncbi.nlm.nih.gov/RefSeq/ allows users to query the RefSeq database using
RefSeq identifiers.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

References

http://www.ncbi.nlm.nih.gov http://www.ncbi.nlm.nih.gov/RefSeq/

Examples

x <- mi16codREFSEQ
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

mi16codSYMBOL

Map between Manufacturer Identifiers and Gene Symbols

Description

mi16codSYMBOL is an R object that provides mappings between manufacturer identifiers and
gene abbreviations.

Details

Each manufacturer identifier is mapped to an abbreviation for the corresponding gene. An NA is
reported if there is no known abbreviation for a given gene.

Symbols typically consist of 3 letters that define either a single gene (ABC) or multiple genes
(ABC1, ABC2, ABC3). Gene symbols can be used as key words to query public databases such as
Entrez Gene.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

16

Examples

mi16codUNIGENE

x <- mi16codSYMBOL
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

mi16codUNIGENE

Map between Manufacturer Identifiers and UniGene cluster identifiers

Description

mi16codUNIGENE is an R object that provides mappings between manufacturer identifiers and
UniGene identifiers.

Details

Each manufacturer identifier is mapped to a UniGene identifier. An NA is reported if the manufac-
turer identifier cannot be mapped to UniGene at this time.

A UniGene identifier represents a cluster of sequences of a gene. Using UniGene identifiers one
can query the UniGene database for information about the sequences or the Entrez Gene database
for information about the genes.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- mi16codUNIGENE
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

mi16codUNIPROT

17

mi16codUNIPROT

Map Uniprot accession numbers with Entrez Gene identifiers

Description

mi16codUNIPROT is an R object that contains mappings between the manufacturer identifiers and
Uniprot accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to Uniprot Accessions.

Mappings were based on data provided by NCBI (link above) with an exception for fly, which
required retrieving the data from ensembl http://www.ensembl.org/biomart/martview/

Examples

x <- mi16codUNIPROT
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

mi16cod_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

mi16cod_dbconn()
mi16cod_dbfile()
mi16cod_dbschema(file="", show.indices=FALSE)
mi16cod_dbInfo()

Arguments

file

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

18

Details

mi16cod_dbconn

mi16cod_dbconn returns a connection object to the package annotation DB. IMPORTANT: Don’t
call dbDisconnect on the connection object returned by mi16cod_dbconn or you will break all the
AnnDbObj objects defined in this package!

mi16cod_dbfile returns the path (character string) to the package annotation DB (this is an SQLite
file).

mi16cod_dbschema prints the schema definition of the package annotation DB.

mi16cod_dbInfo prints other information about the package annotation DB.

Value

mi16cod_dbconn: a DBIConnection object representing an open connection to the package anno-
tation DB.

mi16cod_dbfile: a character string with the path to the package annotation DB.

mi16cod_dbschema: none (invisible NULL).

mi16cod_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

## Count the number of rows in the "probes" table:
dbGetQuery(mi16cod_dbconn(), "SELECT COUNT(*) FROM probes")

mi16cod_dbschema()

mi16cod_dbInfo()

mi16cod_dbInfo (mi16cod_dbconn), 17
mi16cod_dbschema (mi16cod_dbconn), 17
mi16codACCNUM, 1
mi16codALIAS2PROBE, 2
mi16codCHR, 3
mi16codCHRLENGTHS, 3
mi16codCHRLOC, 4
mi16codCHRLOCEND (mi16codCHRLOC), 4
mi16codENSEMBL, 4
mi16codENSEMBL2PROBE (mi16codENSEMBL), 4
mi16codENTREZID, 5
mi16codENZYME, 6
mi16codENZYME2PROBE (mi16codENZYME), 6
mi16codGENENAME, 7
mi16codGO, 8
mi16codGO2ALLPROBES, 9
mi16codGO2ALLPROBES (mi16codGO), 8
mi16codGO2PROBE (mi16codGO), 8
mi16codLOCUSID (mi16codENTREZID), 5
mi16codMAPCOUNTS, 10
mi16codMGI, 11
mi16codMGI2PROBE (mi16codMGI), 11
mi16codORGANISM, 11
mi16codORGPKG (mi16codORGANISM), 11
mi16codPATH, 12
mi16codPATH2PROBE (mi16codPATH), 12
mi16codPMID, 13
mi16codPMID2PROBE (mi16codPMID), 13
mi16codREFSEQ, 14
mi16codSYMBOL, 15
mi16codUNIGENE, 16
mi16codUNIPROT, 17
mi16codUNIPROT2PROBE (mi16codUNIPROT),

17

Index

∗ datasets

mi16cod.db, 2
mi16cod_dbconn, 17
mi16codACCNUM, 1
mi16codALIAS2PROBE, 2
mi16codCHR, 3
mi16codCHRLENGTHS, 3
mi16codCHRLOC, 4
mi16codENSEMBL, 4
mi16codENTREZID, 5
mi16codENZYME, 6
mi16codGENENAME, 7
mi16codGO, 8
mi16codMAPCOUNTS, 10
mi16codMGI, 11
mi16codORGANISM, 11
mi16codPATH, 12
mi16codPMID, 13
mi16codREFSEQ, 14
mi16codSYMBOL, 15
mi16codUNIGENE, 16
mi16codUNIPROT, 17

∗ utilities

mi16cod_dbconn, 17

AnnDbObj, 18

cat, 17
checkMAPCOUNTS, 10
count.mappedkeys, 10

dbconn, 18
dbConnect, 18
dbDisconnect, 18
dbfile, 18
dbGetQuery, 18
dbInfo, 18
dbschema, 18

mappedkeys, 10
mi16cod (mi16cod.db), 2
mi16cod.db, 2
mi16cod_dbconn, 17
mi16cod_dbfile (mi16cod_dbconn), 17

19

