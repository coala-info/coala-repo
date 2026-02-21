illuminaHumanv2BeadID.db

February 11, 2026

illuminaHumanv2BeadIDACCNUM

Map Manufacturer identifiers to Accession Numbers

Description

illuminaHumanv2BeadIDACCNUM is an R object that contains mappings between a manufac-
turer’s identifiers and manufacturers accessions.

Details

For chip packages such as this, the ACCNUM mapping comes directly from the manufacturer. This
is different from other mappings which are mapped onto the probes via an Entrez Gene identifier.

Each manufacturer identifier maps to a vector containing a GenBank accession number.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2010-Sep7

Examples

x <- illuminaHumanv2BeadIDACCNUM
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

illuminaHumanv2BeadID.db

illuminaHumanv2BeadIDALIAS2PROBE

Map between Common Gene Symbol Identifiers and Manufacturer
Identifiers

Description

illuminaHumanv2BeadIDALIAS is an R object that provides mappings between common gene
symbol identifiers and manufacturer identifiers.

Details

Each gene symbol is mapped to a named vector of manufacturer identifiers. The name represents
the gene symbol and the vector contains all manufacturer identifiers that are found for that symbol.
An NA is reported for any gene symbol that cannot be mapped to any manufacturer identifiers.

This mapping includes ALL gene symbols including those which are already listed in the SYMBOL
map. The SYMBOL map is meant to only list official gene symbols, while the ALIAS maps are
meant to store all used symbols.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2010-Sep7

Examples

# Convert the object to a list
xx <- as.list(illuminaHumanv2BeadIDALIAS2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two aliases
xx[1:2]
# Get the first one
xx[[1]]

}

illuminaHumanv2BeadID.db

Bioconductor annotation data package

Description

Welcome to the illuminaHumanv2BeadID.db annotation Package. The purpose of this package is to
provide detailed information about the illuminaHumanv2BeadID platform. This package is updated
biannually.

You can learn what objects this package supports with the following command:
ls("package:illuminaHumanv2BeadID.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:illuminaHumanv2BeadID.db")

illuminaHumanv2BeadIDCHR

3

illuminaHumanv2BeadIDCHR

Map Manufacturer IDs to Chromosomes

Description

illuminaHumanv2BeadIDCHR is an R object that provides mappings between a manufacturer iden-
tifier and the chromosome that contains the gene of interest.

Details

Each manufacturer identifier maps to a vector of chromosomes. Due to inconsistencies that may
exist at the time the object was built, the vector may contain more than one chromosome (e.g., the
identifier may map to more than one chromosome). If the chromosomal location is unknown, the
vector will contain an NA.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2010-Sep7

Examples

x <- illuminaHumanv2BeadIDCHR
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

illuminaHumanv2BeadIDCHRLENGTHS

A named vector for the length of each of the chromosomes

Description

illuminaHumanv2BeadIDCHRLENGTHS provides the length measured in base pairs for each of
the chromosomes.

Details

This is a named vector with chromosome numbers as the names and the corresponding lengths for
chromosomes as the values.

Total lengths of chromosomes were derived by calculating the number of base pairs on the sequence
string for each chromosome.

4

Examples

tt <- illuminaHumanv2BeadIDCHRLENGTHS
# Length of chromosome 1
tt["1"]

illuminaHumanv2BeadIDCHRLOC

illuminaHumanv2BeadIDCHRLOC

Map Manufacturer IDs to Chromosomal Location

Description

illuminaHumanv2BeadIDCHRLOC is an R object that maps manufacturer identifiers to the starting
position of the gene. The position of a gene is measured as the number of base pairs.

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

x <- illuminaHumanv2BeadIDCHRLOC
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

illuminaHumanv2BeadIDENSEMBL

5

illuminaHumanv2BeadIDENSEMBL

Map Ensembl gene accession numbers with Entrez Gene identifiers

Description

illuminaHumanv2BeadIDENSEMBL is an R object that contains mappings between Entrez Gene
identifiers and Ensembl gene accession numbers.

Details

This object is a simple mapping of Entrez Gene identifiers http://www.ncbi.nlm.nih.gov/entrez/
query.fcgi?db=gene to Ensembl gene Accession Numbers.

Mappings were based on data provided by BOTH of these sources: http://www.ensembl.org/
biomart/martview/ ftp://ftp.ncbi.nlm.nih.gov/gene/DATA

This mapping is a combination of NCBI to ensembl IDs from BOTH NCBI and ensembl. Users
who wish to only use mappings from NCBI are encouraged to see the ncbi2ensembl table in the
appropriate organism package. Users who wish to only use mappings from ensembl are encouraged
to see the ensembl2ncbi table which is also found in the appropriate organism packages. These
mappings are based upon the ensembl table which is contains data from BOTH of these sources in
an effort to maximize the chances that you will find a match.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2010-Sep7

Examples

x <- illuminaHumanv2BeadIDENSEMBL
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
xx <- as.list(illuminaHumanv2BeadIDENSEMBL2PROBE)
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

6

illuminaHumanv2BeadIDENZYME

illuminaHumanv2BeadIDENTREZID

Map between Manufacturer Identifiers and Entrez Gene

Description

illuminaHumanv2BeadIDENTREZID is an R object that provides mappings between manufacturer
identifiers and Entrez Gene identifiers.

Details

Each manufacturer identifier is mapped to a vector of Entrez Gene identifiers. An NA is assigned to
those manufacturer identifiers that can not be mapped to an Entrez Gene identifier at this time.

If a given manufacturer identifier can be mapped to different Entrez Gene identifiers from various
sources, we attempt to select the common identifiers. If a concensus cannot be determined, we
select the smallest identifier.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2010-Sep7

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- illuminaHumanv2BeadIDENTREZID
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

illuminaHumanv2BeadIDENZYME

Map between Manufacturer IDs and Enzyme Commission (EC) Num-
bers

Description

illuminaHumanv2BeadIDENZYME is an R object that provides mappings between manufacturer
identifiers and EC numbers.

illuminaHumanv2BeadIDENZYME

7

Details

Each manufacturer identifier maps to a named vector containing the EC number that corresponds
to the enzyme produced by that gene. The name corresponds to the manufacturer identifier. If this
information is unknown, the vector will contain an NA.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In illuminaHumanv2BeadIDENZYME2PROBE, EC is dropped from the Enzyme Com-
mission numbers.

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
KEGG GENOME ftp://ftp.genome.jp/pub/kegg/genomes With a date stamp from the source of:
2010-Sep7

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

Examples

x <- illuminaHumanv2BeadIDENZYME
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

8

illuminaHumanv2BeadIDENZYME2PROBE

illuminaHumanv2BeadIDENZYME2PROBE

Map between Enzyme Commission Numbers and Manufacturer Iden-
tifiers

Description

illuminaHumanv2BeadIDENZYME2PROBE is an R object that maps Enzyme Commission (EC)
numbers to manufacturer identifiers.

Details

Each EC number maps to a named vector containing all of the manufacturer identifiers that cor-
respond to the gene that produces that enzyme. The name of the vector corresponds to the EC
number.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In illuminaHumanv2BeadIDENZYME2PROBE, EC is dropped from the Enzyme Com-
mission numbers.

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

Mappings were based on data provided by: KEGG GENOME ftp://ftp.genome.jp/pub/kegg/genomes
With a date stamp from the source of: 2010-Sep7

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

Examples

# Convert to a list
xx <- as.list(illuminaHumanv2BeadIDENZYME2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first five enzyme
#commission numbers
xx[1:5]
# Get the first one

illuminaHumanv2BeadIDGENENAME

9

xx[[1]]

}

illuminaHumanv2BeadIDGENENAME

Map between Manufacturer IDs and Genes

Description

illuminaHumanv2BeadIDGENENAME is an R object that maps manufacturer identifiers to the
corresponding gene name.

Details

Each manufacturer identifier maps to a named vector containing the gene name. The vector name
corresponds to the manufacturer identifier. If the gene name is unknown, the vector will contain an
NA.

Gene names currently include both the official (validated by a nomenclature committee) and pre-
ferred names (interim selected for display) for genes. Efforts are being made to differentiate the
two by adding a name to the vector.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2010-Sep7

Examples

x <- illuminaHumanv2BeadIDGENENAME
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

illuminaHumanv2BeadIDGO

Map between Manufacturer IDs and Gene Ontology (GO)

Description

illuminaHumanv2BeadIDGO is an R object that provides mappings between manufacturer identi-
fiers and the GO identifiers that they are directly associated with.

10

Details

illuminaHumanv2BeadIDGO

Each Entrez Gene identifier is mapped to a list of lists. The names on the outer list are GO identi-
fiers. Each inner list consists of three named elements: GOID, Ontology, and Evidence.

The GOID element matches the GO identifier named in the outer list and is included for convenience
when processing the data using ’lapply’.

The Ontology element indicates which of the three Gene Ontology categories this identifier belongs
to. The categories are biological process (BP), cellular component (CC), and molecular function
(MF).

The Evidence element contains a code indicating what kind of evidence supports the association of
the GO identifier to the Entrez Gene id. The evidence codes in use include:

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

Mappings between probe identifiers and GO information were obtained through their mappings to
Entrez Gene identifiers. NAs are assigned to probe identifiers that can not be mapped to any Gene
Ontology information. Mappings between Gene Ontology identifiers an Gene Ontology terms and
other information are available in a separate data package named GO.

Mappings were based on data provided by: Gene Ontology ftp://ftp.geneontology.org/pub/go/godatabase/archive/latest-
lite/ With a date stamp from the source of: 20100904

Examples

x <- illuminaHumanv2BeadIDGO
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

illuminaHumanv2BeadIDGO2ALLPROBES

11

illuminaHumanv2BeadIDGO2ALLPROBES

Map between Gene Ontology (GO) Identifiers and all Manufacturer
Identifiers in the subtree

Description

illuminaHumanv2BeadIDGO2ALLPROBES is an R object that provides mappings between a given
GO identifier and all manufactuerer identifiers annotated at that GO term or one of its children in
the GO ontology.

Details

GO consists of three ontologies—molecular function (MF), biological process (BP), and cellular
component (CC). All ontologies are structured as directed acyclic graphs (DAGs). Each node in
each DAG (tree) is a GO term (id) associated with a named vector of manufacturer identifiers. The
name associated with each manufacturer id corresponds to the evidence code for that GO identifier.
This object illuminaHumanv2BeadIDGO2ALLPROBES maps between a given GO identifier and
all manufactuerer identifiers annotated at that GO term or one of its children in the GO ontology.

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

Gene Ontology ftp://ftp.geneontology.org/pub/go/godatabase/archive/latest-lite/ With a date stamp
from the source of: 20100904 and Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With a date
stamp from the source of: 2010-Sep7

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

12

Examples

illuminaHumanv2BeadIDGO2PROBE

# Convert to a list
xx <- as.list(illuminaHumanv2BeadIDGO2ALLPROBES)
if(length(xx) > 0){

# Get the probe identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Get all the probe identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

illuminaHumanv2BeadIDGO2PROBE

Map between Gene Ontology (GO) and Manufacturer Identifiers

Description

illuminaHumanv2BeadIDGO2PROBE is an R object that provides mappings between GO identi-
fiers and manufacturer identifiers.

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

Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With a date stamp from the source of: 2010-
Sep7

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

illuminaHumanv2BeadIDMAP

13

Examples

# Convert to a list
xx <- as.list(illuminaHumanv2BeadIDGO2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Get the probe identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

illuminaHumanv2BeadIDMAP

Map between Manufacturer Identifiers and cytogenetic maps/bands

Description

illuminaHumanv2BeadIDMAP is an R object that provides mappings between manufacturer iden-
tifiers and cytoband locations.

Details

Each manufacturer identifier is mapped to a vector of cytoband locations. The vector length may
be one or longer, if there are multiple reported chromosomal locations for a given gene. An NA is
reported for any manufacturer identifiers that cannot be mapped to a cytoband at this time.

Cytogenetic bands for most higher organisms are labeled p1, p2, p3, q1, q2, q3 (p and q are the p
and q arms), etc., counting from the centromere out toward the telomeres. At higher resolutions,
sub-bands can be seen within the bands. The sub-bands are also numbered from the centromere out
toward the telomere. Thus, a label of 7q31.2 indicates that the band is on chromosome 7, q arm,
band 3, sub-band 1, and sub-sub-band 2.

The physical location of each band on a chromosome can be obtained from another object named
"organism"CYTOLOC in a separate data package for human(humanCHRLOC), mouse(mouseCHRLOC),
and rat(ratCHRLOC).

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2010-Sep7

References

http://www.ncbi.nlm.nih.gov

Examples

x <- illuminaHumanv2BeadIDMAP
# Get the probe identifiers that are mapped to any cytoband
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the MAP for the first five probes
xx[1:5]

14

illuminaHumanv2BeadIDOMIM

# Get the first one
xx[[1]]

}

illuminaHumanv2BeadIDMAPCOUNTS

Number of mapped keys for the maps in package illuminaHu-
manv2BeadID.db

Description

illuminaHumanv2BeadIDMAPCOUNTS provides the "map count" (i.e. the count of mapped keys)
for each map in package illuminaHumanv2BeadID.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

Examples

illuminaHumanv2BeadIDMAPCOUNTS
mapnames <- names(illuminaHumanv2BeadIDMAPCOUNTS)
illuminaHumanv2BeadIDMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package illuminaHumanv2BeadID.db
checkMAPCOUNTS("illuminaHumanv2BeadID.db")

illuminaHumanv2BeadIDOMIM

Map between Manufacturer Identifiers and Mendelian Inheritance in
Man (MIM) identifiers

Description

illuminaHumanv2BeadIDOMIM is an R object that provides mappings between manufacturer iden-
tifiers and OMIM identifiers.

illuminaHumanv2BeadIDORGANISM

15

Details

Each manufacturer identifier is mapped to a vector of OMIM identifiers. The vector length may be
one or longer, depending on how many OMIM identifiers the manufacturer identifier maps to. An
NA is reported for any manufacturer identifier that cannot be mapped to an OMIM identifier at this
time.

OMIM is based upon the book Mendelian Inheritance in Man (V. A. McKusick) and focuses primar-
ily on inherited or heritable genetic diseases. It contains textual information, pictures, and reference
information that can be searched using various terms, among which the MIM number is one.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2010-Sep7

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene http://www3.ncbi.nlm.nih.gov/
entrez/query.fcgi?db=OMIM

Examples

x <- illuminaHumanv2BeadIDOMIM
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

illuminaHumanv2BeadIDORGANISM

The Organism information for illuminaHumanv2BeadID

Description

illuminaHumanv2BeadIDORGANISM is an R object that contains a single item: a character string
that names the organism for which illuminaHumanv2BeadID was built. illuminaHumanv2BeadIDORGPKG
is an R object that contains a chararcter vector with the name of the organism package that a chip
package depends on for its gene-centric annotation.

Details

Although the package name is suggestive of the organism for which it was built, illuminaHu-
manv2BeadIDORGANISM provides a simple way to programmatically extract the organism name.
illuminaHumanv2BeadIDORGPKG provides a simple way to programmatically extract the name
of the parent organism package. The parent organism package is a strict dependency for chip pack-
ages as this is where the gene cetric information is ultimately extracted from. The full package name
will always be this string plus the extension ".db". But most programatic acces will not require this
extension, so its more convenient to leave it out.

16

Examples

illuminaHumanv2BeadIDORGANISM
illuminaHumanv2BeadIDORGPKG

illuminaHumanv2BeadIDPATH

illuminaHumanv2BeadIDPATH

Mappings between probe identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms. illuminaHumanv2BeadIDPATH maps probe identifiers to the identifiers used by KEGG for
pathways in which the genes represented by the probe identifiers are involved

Details

Each KEGG pathway has a name and identifier. Pathway name for a given pathway identifier can
be obtained using the KEGG data package that can either be built using AnnBuilder or downloaded
from Bioconductor http://www.bioconductor.org.

Graphic presentations of pathways are searchable at url http://www.genome.ad.jp/kegg/pathway.html
by using pathway identifiers as keys.

Mappings were based on data provided by: KEGG GENOME ftp://ftp.genome.jp/pub/kegg/genomes
With a date stamp from the source of: 2010-Sep7

References

http://www.genome.ad.jp/kegg/

Examples

x <- illuminaHumanv2BeadIDPATH
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

illuminaHumanv2BeadIDPATH2PROBE

17

illuminaHumanv2BeadIDPATH2PROBE

Map between Kyoto Encyclopedia of Genes and Genomes (KEGG)
pathway identifiers and Manufacturer Identifiers

Description

illuminaHumanv2BeadIDPATH2PROBE is an R object that provides mappings between KEGG
identifiers and manufacturer identifiers.

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
With a date stamp from the source of: 2010-Sep7

References

http://www.genome.ad.jp/kegg/

Examples

# Convert the object to a list
xx <- as.list(illuminaHumanv2BeadIDPATH2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two pathway identifiers
xx[1:2]
# Get the first one
xx[[1]]

}

illuminaHumanv2BeadIDPFAM

Map Manufacturer IDs to Pfam IDs

Description

illuminaHumanv2BeadIDPFAM is an R object that provides mappings between a manufacturer
identifier and the associated Pfam identifiers.

18

Details

illuminaHumanv2BeadIDPMID

Each manufacturer identifier maps to a named vector of Pfam identifiers. The name for each Pfam
identifier is the IPI accession numbe where this Pfam identifier is found.

If the Pfam is a named NA, it means that the associated Entrez Gene id of this manufacturer identifier
is found in an IPI entry of the IPI database, but there is no Pfam identifier in the entry.

If the Pfam is a non-named NA, it means that the associated Entrez Gene id of this manufacturer
identifier is not found in any IPI entry of the IPI database.

Mappings were based on data provided by: The International Protein Index ftp://ftp.ebi.ac.uk/pub/databases/IPI/current
With a date stamp from the source of: 2010-Aug19

References

Kersey P. J., Duarte J., Williams A., Karavidopoulou Y., Birney E., Apweiler R. The International
Protein Index: An integrated database for proteomics experiments. Proteomics 4(7): 1985-1988
(2004) http://www.ebi.ac.uk/IPI/IPIhelp.html

Examples

x <- illuminaHumanv2BeadIDPFAM
# Get the probe identifiers that are mapped to any Pfam ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
# randomly display 10 probes
sample(xx, 10)

illuminaHumanv2BeadIDPMID

Map between Manufacturer Identifiers and PubMed Identifiers

Description

illuminaHumanv2BeadIDPMID is an R object that provides mappings between manufacturer iden-
tifiers and PubMed identifiers.

Details

Each manufacturer identifier is mapped to a named vector of PubMed identifiers. The name asso-
ciated with each vector corresponds to the manufacturer identifier. The length of the vector may
be one or greater, depending on how many PubMed identifiers a given manufacturer identifier is
mapped to. An NA is reported for any manufacturer identifier that cannot be mapped to a PubMed
identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2010-Sep7

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=PubMed

illuminaHumanv2BeadIDPMID2PROBE

19

Examples

x <- illuminaHumanv2BeadIDPMID
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

illuminaHumanv2BeadIDPMID2PROBE

Map between PubMed Identifiers and Manufacturer Identifiers

Description

illuminaHumanv2BeadIDPMID2PROBE is an R object that provides mappings between PubMed
identifiers and manufacturer identifiers.

Details

Each PubMed identifier is mapped to a named vector of manufacturer identifiers. The name repre-
sents the PubMed identifier and the vector contains all manufacturer identifiers that are represented
by that PubMed identifier. The length of the vector may be one or longer, depending on how many
manufacturer identifiers are mapped to a given PubMed identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2010-Sep7

Examples

# Convert the object to a list
xx <- as.list(illuminaHumanv2BeadIDPMID2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two PubMed identifiers
xx[1:2]
# Get the first one
xx[[1]]
if(interactive() && require(annotate)){

# Get article information as XML files for a PubMed id
xmls <- pubmed(names(xx)[1], disp = "data")

20

illuminaHumanv2BeadIDPROSITE

# View article information using a browser
pubmed(names(xx)[1], disp = "browser")

}

}

illuminaHumanv2BeadIDPROSITE

Map Manufacturer IDs to PROSITE ID

Description

illuminaHumanv2BeadIDPROSITE is an R object that provides mappings between a manufacturer
identifier and the associated PROSITE identifiers.

Details

Each manufacturer identifier maps to a named vector of PROSITE identifiers. The name for each
PROSITE identifier is the IPI accession numbe where this PROSITE identifier is found.

If the PROSITE is a named NA, it means that the associated Entrez Gene id of this manufacturer
identifier is found in an IPI entry of the IPI database, but there is no PROSITE identifier in the entry.

If the PROSITE is a non-named NA, it means that the associated Entrez Gene id of this manufacturer
identifier is not found in any IPI entry of the IPI database.

Mappings were based on data provided by: The International Protein Index ftp://ftp.ebi.ac.uk/pub/databases/IPI/current
With a date stamp from the source of: 2010-Aug19

References

Kersey P. J., Duarte J., Williams A., Karavidopoulou Y., Birney E., Apweiler R. The International
Protein Index: An integrated database for proteomics experiments. Proteomics 4(7): 1985-1988
(2004) http://www.ebi.ac.uk/IPI/IPIhelp.html

Examples

x <- illuminaHumanv2BeadIDPROSITE
# Get the probe identifiers that are mapped to any PROSITE ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xxx <- as.list(x[mapped_probes])
# randomly display 10 probes
xxx[sample(1:length(xxx), 10)]

illuminaHumanv2BeadIDREFSEQ

21

illuminaHumanv2BeadIDREFSEQ

Map between Manufacturer Identifiers and RefSeq Identifiers

Description

illuminaHumanv2BeadIDREFSEQ is an R object that provides mappings between manufacturer
identifiers and RefSeq identifiers.

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
a date stamp from the source of: 2010-Sep7

References

http://www.ncbi.nlm.nih.gov http://www.ncbi.nlm.nih.gov/RefSeq/

Examples

x <- illuminaHumanv2BeadIDREFSEQ
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

22

illuminaHumanv2BeadIDUNIGENE

illuminaHumanv2BeadIDSYMBOL

Map between Manufacturer Identifiers and Gene Symbols

Description

illuminaHumanv2BeadIDSYMBOL is an R object that provides mappings between manufacturer
identifiers and gene abbreviations.

Details

Each manufacturer identifier is mapped to an abbreviation for the corresponding gene. An NA is
reported if there is no known abbreviation for a given gene.

Symbols typically consist of 3 letters that define either a single gene (ABC) or multiple genes
(ABC1, ABC2, ABC3). Gene symbols can be used as key words to query public databases such as
Entrez Gene.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2010-Sep7

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- illuminaHumanv2BeadIDSYMBOL
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

illuminaHumanv2BeadIDUNIGENE

Map between Manufacturer Identifiers and UniGene cluster identifiers

Description

illuminaHumanv2BeadIDUNIGENE is an R object that provides mappings between manufacturer
identifiers and UniGene identifiers.

illuminaHumanv2BeadIDUNIPROT

23

Details

Each manufacturer identifier is mapped to a UniGene identifier. An NA is reported if the manufac-
turer identifier cannot be mapped to UniGene at this time.

A UniGene identifier represents a cluster of sequences of a gene. Using UniGene identifiers one
can query the UniGene database for information about the sequences or the Entrez Gene database
for information about the genes.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2010-Sep7

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- illuminaHumanv2BeadIDUNIGENE
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

illuminaHumanv2BeadIDUNIPROT

Map Uniprot accession numbers with Entrez Gene identifiers

Description

illuminaHumanv2BeadIDUNIPROT is an R object that contains mappings between Entrez Gene
identifiers and Uniprot accession numbers.

Details

This object is a simple mapping of Entrez Gene identifiers http://www.ncbi.nlm.nih.gov/entrez/
query.fcgi?db=gene to Uniprot Accessions.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2010-Sep7

Examples

x <- illuminaHumanv2BeadIDUNIPROT
# Get the entrez gene IDs that are mapped to an Uniprot ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

24

illuminaHumanv2BeadID_dbconn

# Get the Uniprot IDs for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

illuminaHumanv2BeadID_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

illuminaHumanv2BeadID_dbconn()
illuminaHumanv2BeadID_dbfile()
illuminaHumanv2BeadID_dbschema(file="", show.indices=FALSE)
illuminaHumanv2BeadID_dbInfo()

Arguments

file

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

illuminaHumanv2BeadID_dbconn returns a connection object to the package annotation DB. IM-
PORTANT: Don’t call dbDisconnect on the connection object returned by illuminaHumanv2BeadID_dbconn
or you will break all the AnnDbObj objects defined in this package!

illuminaHumanv2BeadID_dbfile returns the path (character string) to the package annotation DB
(this is an SQLite file).

illuminaHumanv2BeadID_dbschema prints the schema definition of the package annotation DB.

illuminaHumanv2BeadID_dbInfo prints other information about the package annotation DB.

Value

illuminaHumanv2BeadID_dbconn: a DBIConnection object representing an open connection to
the package annotation DB.

illuminaHumanv2BeadID_dbfile: a character string with the path to the package annotation DB.

illuminaHumanv2BeadID_dbschema: none (invisible NULL).

illuminaHumanv2BeadID_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

illuminaHumanv2BeadID_dbconn

25

Examples

## Count the number of rows in the "probes" table:
dbGetQuery(illuminaHumanv2BeadID_dbconn(), "SELECT COUNT(*) FROM probes")

## The connection object returned by illuminaHumanv2BeadID_dbconn() was
## created with:
dbConnect(SQLite(), dbname=illuminaHumanv2BeadID_dbfile(), cache_size=64000,
synchronous=0)

illuminaHumanv2BeadID_dbschema()

illuminaHumanv2BeadID_dbInfo()

Index

∗ datasets

illuminaHumanv2BeadID.db, 2
illuminaHumanv2BeadID_dbconn, 24
illuminaHumanv2BeadIDACCNUM, 1
illuminaHumanv2BeadIDALIAS2PROBE,

2

illuminaHumanv2BeadIDCHR, 3
illuminaHumanv2BeadIDCHRLENGTHS, 3
illuminaHumanv2BeadIDCHRLOC, 4
illuminaHumanv2BeadIDENSEMBL, 5
illuminaHumanv2BeadIDENTREZID, 6
illuminaHumanv2BeadIDENZYME, 6
illuminaHumanv2BeadIDENZYME2PROBE,

8

illuminaHumanv2BeadIDGENENAME, 9
illuminaHumanv2BeadIDGO, 9
illuminaHumanv2BeadIDGO2ALLPROBES,

11

illuminaHumanv2BeadIDGO2PROBE, 12
illuminaHumanv2BeadIDMAP, 13
illuminaHumanv2BeadIDMAPCOUNTS, 14
illuminaHumanv2BeadIDOMIM, 14
illuminaHumanv2BeadIDORGANISM, 15
illuminaHumanv2BeadIDPATH, 16
illuminaHumanv2BeadIDPATH2PROBE,

17

illuminaHumanv2BeadIDPFAM, 17
illuminaHumanv2BeadIDPMID, 18
illuminaHumanv2BeadIDPMID2PROBE,

19

illuminaHumanv2BeadIDPROSITE, 20
illuminaHumanv2BeadIDREFSEQ, 21
illuminaHumanv2BeadIDSYMBOL, 22
illuminaHumanv2BeadIDUNIGENE, 22
illuminaHumanv2BeadIDUNIPROT, 23

∗ utilities

illuminaHumanv2BeadID_dbconn, 24

AnnDbObj, 24

cat, 24
checkMAPCOUNTS, 14
count.mappedkeys, 14

26

dbconn, 24
dbConnect, 24
dbDisconnect, 24
dbfile, 24
dbGetQuery, 24
dbInfo, 24
dbschema, 24

illuminaHumanv2BeadID

(illuminaHumanv2BeadID.db), 2

illuminaHumanv2BeadID.db, 2
illuminaHumanv2BeadID_dbconn, 24
illuminaHumanv2BeadID_dbfile

(illuminaHumanv2BeadID_dbconn),
24

illuminaHumanv2BeadID_dbInfo

(illuminaHumanv2BeadID_dbconn),
24

illuminaHumanv2BeadID_dbschema

(illuminaHumanv2BeadID_dbconn),
24

illuminaHumanv2BeadIDACCNUM, 1
illuminaHumanv2BeadIDALIAS2PROBE, 2
illuminaHumanv2BeadIDCHR, 3
illuminaHumanv2BeadIDCHRLENGTHS, 3
illuminaHumanv2BeadIDCHRLOC, 4
illuminaHumanv2BeadIDCHRLOCEND

(illuminaHumanv2BeadIDCHRLOC),
4

illuminaHumanv2BeadIDENSEMBL, 5
illuminaHumanv2BeadIDENSEMBL2PROBE

(illuminaHumanv2BeadIDENSEMBL),
5

illuminaHumanv2BeadIDENTREZID, 6
illuminaHumanv2BeadIDENZYME, 6
illuminaHumanv2BeadIDENZYME2PROBE, 8
illuminaHumanv2BeadIDGENENAME, 9
illuminaHumanv2BeadIDGO, 9
illuminaHumanv2BeadIDGO2ALLPROBES, 11
illuminaHumanv2BeadIDGO2PROBE, 12
illuminaHumanv2BeadIDLOCUSID

(illuminaHumanv2BeadIDENTREZID),
6

illuminaHumanv2BeadIDMAP, 13

INDEX

27

illuminaHumanv2BeadIDMAPCOUNTS, 14
illuminaHumanv2BeadIDOMIM, 14
illuminaHumanv2BeadIDORGANISM, 15
illuminaHumanv2BeadIDORGPKG

(illuminaHumanv2BeadIDORGANISM),
15

illuminaHumanv2BeadIDPATH, 16
illuminaHumanv2BeadIDPATH2PROBE, 17
illuminaHumanv2BeadIDPFAM, 17
illuminaHumanv2BeadIDPMID, 18
illuminaHumanv2BeadIDPMID2PROBE, 19
illuminaHumanv2BeadIDPROSITE, 20
illuminaHumanv2BeadIDREFSEQ, 21
illuminaHumanv2BeadIDSYMBOL, 22
illuminaHumanv2BeadIDUNIGENE, 22
illuminaHumanv2BeadIDUNIPROT, 23
illuminaHumanv2BeadIDUNIPROT2PROBE

(illuminaHumanv2BeadIDUNIPROT),
23

mappedkeys, 14

