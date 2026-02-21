IlluminaHumanMethylation27k.db

February 11, 2026

IlluminaHumanMethylation27kACCNUM

Map Manufacturer identifiers to Accession Numbers

Description

IlluminaHumanMethylation27kACCNUM is an R object that contains mappings between a manu-
facturer’s identifiers and manufacturers accessions.

Details

For chip packages such as this, the ACCNUM mapping comes directly from the manufacturer. This
is different from other mappings which are mapped onto the probes via an Entrez Gene identifier.

Each manufacturer identifier maps to a vector containing a GenBank accession number.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

Examples

x <- IlluminaHumanMethylation27kACCNUM
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

IlluminaHumanMethylation27k.db

IlluminaHumanMethylation27kALIAS2PROBE

Map between Common Gene Symbol Identifiers and Manufacturer
Identifiers

Description

IlluminaHumanMethylation27kALIAS is an R object that provides mappings between common
gene symbol identifiers and manufacturer identifiers.

Details

Each gene symbol is mapped to a named vector of manufacturer identifiers. The name represents
the gene symbol and the vector contains all manufacturer identifiers that are found for that symbol.
An NA is reported for any gene symbol that cannot be mapped to any manufacturer identifiers.
This mapping includes ALL gene symbols including those which are already listed in the SYMBOL
map. The SYMBOL map is meant to only list official gene symbols, while the ALIAS maps are
meant to store all used symbols.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

Examples

# Convert the object to a list
xx <- as.list(IlluminaHumanMethylation27kALIAS2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two aliases
xx[1:2]
# Get the first one
xx[[1]]

}

IlluminaHumanMethylation27k.db

Bioconductor annotation data package

Description

Welcome to the IlluminaHumanMethylation27k.db annotation Package. The purpose of this pack-
age is to provide detailed information about the IlluminaHumanMethylation27k platform. This
package is updated biannually.

You can learn what objects this package supports with the following command:
ls("package:IlluminaHumanMethylation27k.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:IlluminaHumanMethylation27k.db")

IlluminaHumanMethylation27kBLAME

3

IlluminaHumanMethylation27kBLAME

Who checked the latest build of these annotations into version control?

Description

IlluminaHumanMethylation27kBLAME answers the important question of where to point the finger
when it turns out that an annotation is out of date. It comes with a free money-back guarantee; your
purchase price will be refunded.

Details

Typically this will be an overworked and underprepared grad student or RA.

Examples

IlluminaHumanMethylation27kBLAME

IlluminaHumanMethylation27kCHR

Map Manufacturer IDs to Chromosomes

Description

IlluminaHumanMethylation27kCHR is an R object that provides mappings between a manufacturer
identifier and the chromosome that contains the gene of interest.

Details

Each manufacturer identifier maps to a vector of chromosomes. Due to inconsistencies that may
exist at the time the object was built, the vector may contain more than one chromosome (e.g., the
identifier may map to more than one chromosome). If the chromosomal location is unknown, the
vector will contain an NA.
Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

Examples

x <- IlluminaHumanMethylation27kCHR
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

4

IlluminaHumanMethylation27kCHRLOC

IlluminaHumanMethylation27kCHRLENGTHS

A named vector for the length of each of the chromosomes

Description

IlluminaHumanMethylation27kCHRLENGTHS provides the length measured in base pairs for each
of the chromosomes.

Details

This is a named vector with chromosome numbers as the names and the corresponding lengths for
chromosomes as the values.

Total lengths of chromosomes were derived by calculating the number of base pairs on the sequence
string for each chromosome.

Examples

tt <- IlluminaHumanMethylation27kCHRLENGTHS
# Length of chromosome 1
tt["1"]

IlluminaHumanMethylation27kCHRLOC

Map Manufacturer IDs to Chromosomal Location

Description

IlluminaHumanMethylation27kCHRLOC is an R object that maps manufacturer identifiers to the
starting position of the gene. The position of a gene is measured as the number of base pairs.

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

IlluminaHumanMethylation27kCOLORCHANNEL

5

Examples

x <- IlluminaHumanMethylation27kCHRLOC
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

IlluminaHumanMethylation27kCOLORCHANNEL

Color Channel for locus assay

Description

IlluminaHumanMethylation27kCOLORCHANNEL is an R object that provides mappings between
a manufacturer identifier and the color channel for the assay for that locus

Details

Value is a simple Grn or Red for each probe, based simply on the Illumina manifest,

Mappings were based on data provided by: Illimina http://Illumina.com Downloaded 2010-Oct-10

Examples

x <- IlluminaHumanMethylation27kCOLORCHANNEL
# Get the probe identifiers that are mapped
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the values for the first five probes
xx[1:5]

}

IlluminaHumanMethylation27kCPGCOORDINATE

Map Manufacturer IDs to genomic coordinate

Description

IlluminaHumanMethylation27kCPGCOORDINATE is an R object that provides mappings between
a manufacturer identifier and the CpG coordinate as defined by Illumina in the manifest.

6

Details

IlluminaHumanMethylation27kDISTTOTSS

Simple probe mapping to CpG coordinate within the human genome, Build 36, as defined by Illu-
mina.

Mappings were based on data provided by: Illimina http://Illumina.com Downloaded 19-Sep-2009

Examples

x <- IlluminaHumanMethylation27kCPGCOORDINATE
# Get the probe identifiers that are mapped to a CpG coordinate
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the CHR for the first five probes
xx[1:5]

}

IlluminaHumanMethylation27kCPGS

Number of CpG dinucleotides in target genomic sequence

Description

IlluminaHumanMethylation27kCPGS is an R object that provides mappings between Illumina probe
IDs and the number of CpGs in the source sequence targeted by Illumina, based on information in
their manifest.

Details

Probe mapping to CpG density within the human genome, Build 36, as defined by Illumina.

Mappings were based on data provided by: Illimina http://Illumina.com Downloaded 11-Jan-2011

Examples

as.list(IlluminaHumanMethylation27kCPGS)[150:200]

IlluminaHumanMethylation27kDISTTOTSS

Map Manufacturer IDs to the distance to the transcript start of the
nearest gene

Description

IlluminaHumanMethylation27kDISTTOTSS is an R object that provides mappings between a man-
ufacturer identifier and the distance to the transcript start site of the nearest transcript, as defined by
Illumina in the manifest.

IlluminaHumanMethylation27kENSEMBL

7

Details

Simple probe mapping to CpG coordinate within the human genome, Build 36, as defined by Illu-
mina.

Mappings were based on data provided by: Illimina http://Illumina.com Downloaded 19-Sep-2009

Examples

x <- IlluminaHumanMethylation27kDISTTOTSS
# Get the probe identifiers that are mapped to disttotss
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the value for the first five probes
xx[1:5]

}

IlluminaHumanMethylation27kENSEMBL

Map Ensembl gene accession numbers with Entrez Gene identifiers

Description

IlluminaHumanMethylation27kENSEMBL is an R object that contains mappings between Entrez
Gene identifiers and Ensembl gene accession numbers.

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
a date stamp from the source of: 2011-Mar16

Examples

x <- IlluminaHumanMethylation27kENSEMBL
# Get the entrez gene IDs that are mapped to an Ensembl ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the Ensembl gene IDs for the first five genes
xx[1:5]

8

IlluminaHumanMethylation27kENTREZID

# Get the first one
xx[[1]]

}
#For the reverse map ENSEMBL2PROBE:
# Convert to a list
xx <- as.list(IlluminaHumanMethylation27kENSEMBL2PROBE)
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

IlluminaHumanMethylation27kENTREZID

Map between Manufacturer Identifiers and Entrez Gene

Description

IlluminaHumanMethylation27kENTREZID is an R object that provides mappings between manu-
facturer identifiers and Entrez Gene identifiers.

Details

Each manufacturer identifier is mapped to a vector of Entrez Gene identifiers. An NA is assigned to
those manufacturer identifiers that can not be mapped to an Entrez Gene identifier at this time.

If a given manufacturer identifier can be mapped to different Entrez Gene identifiers from various
sources, we attempt to select the common identifiers. If a concensus cannot be determined, we
select the smallest identifier.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- IlluminaHumanMethylation27kENTREZID
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

IlluminaHumanMethylation27kENZYME

9

IlluminaHumanMethylation27kENZYME

Map between Manufacturer IDs and Enzyme Commission (EC) Num-
bers

Description

IlluminaHumanMethylation27kENZYME is an R object that provides mappings between manufac-
turer identifiers and EC numbers.

Details

Each manufacturer identifier maps to a named vector containing the EC number that corresponds
to the enzyme produced by that gene. The name corresponds to the manufacturer identifier. If this
information is unknown, the vector will contain an NA.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In IlluminaHumanMethylation27kENZYME2PROBE, EC is dropped from the Enzyme
Commission numbers.

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
2011-Mar15

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

Examples

x <- IlluminaHumanMethylation27kENZYME
# Get the probe identifiers that are mapped to an EC number
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

10

IlluminaHumanMethylation27kENZYME2PROBE

# Get the ENZYME for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

IlluminaHumanMethylation27kENZYME2PROBE

Map between Enzyme Commission Numbers and Manufacturer Iden-
tifiers

Description

IlluminaHumanMethylation27kENZYME2PROBE is an R object that maps Enzyme Commission
(EC) numbers to manufacturer identifiers.

Details

Each EC number maps to a named vector containing all of the manufacturer identifiers that cor-
respond to the gene that produces that enzyme. The name of the vector corresponds to the EC
number.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In IlluminaHumanMethylation27kENZYME2PROBE, EC is dropped from the Enzyme
Commission numbers.

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
With a date stamp from the source of: 2011-Mar15

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

IlluminaHumanMethylation27kGENENAME

11

Examples

# Convert to a list
xx <- as.list(IlluminaHumanMethylation27kENZYME2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first five enzyme
#commission numbers
xx[1:5]
# Get the first one
xx[[1]]

}

IlluminaHumanMethylation27kGENENAME

Map between Manufacturer IDs and Genes

Description

IlluminaHumanMethylation27kGENENAME is an R object that maps manufacturer identifiers to
the corresponding gene name.

Details

Each manufacturer identifier maps to a named vector containing the gene name. The vector name
corresponds to the manufacturer identifier. If the gene name is unknown, the vector will contain an
NA.

Gene names currently include both the official (validated by a nomenclature committee) and pre-
ferred names (interim selected for display) for genes. Efforts are being made to differentiate the
two by adding a name to the vector.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

Examples

x <- IlluminaHumanMethylation27kGENENAME
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

12

IlluminaHumanMethylation27kGO

IlluminaHumanMethylation27kGO

Map between Manufacturer IDs and Gene Ontology (GO)

Description

IlluminaHumanMethylation27kGO is an R object that provides mappings between manufacturer
identifiers and the GO identifiers that they are directly associated with.

Details

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
lite/ With a date stamp from the source of: 20110312

Examples

x <- IlluminaHumanMethylation27kGO
# Get the probe identifiers that are mapped to a GO ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

IlluminaHumanMethylation27kGO2ALLPROBES

13

# Try the firest one
got <- xx[[1]]
got[[1]][["GOID"]]
got[[1]][["Ontology"]]
got[[1]][["Evidence"]]

}

IlluminaHumanMethylation27kGO2ALLPROBES

Map between Gene Ontology (GO) Identifiers and all Manufacturer
Identifiers in the subtree

Description

IlluminaHumanMethylation27kGO2ALLPROBES is an R object that provides mappings between a
given GO identifier and all manufactuerer identifiers annotated at that GO term or one of its children
in the GO ontology.

Details

GO consists of three ontologies—molecular function (MF), biological process (BP), and cellular
component (CC). All ontologies are structured as directed acyclic graphs (DAGs). Each node in
each DAG (tree) is a GO term (id) associated with a named vector of manufacturer identifiers. The
name associated with each manufacturer id corresponds to the evidence code for that GO identifier.
This object IlluminaHumanMethylation27kGO2ALLPROBES maps between a given GO identifier
and all manufactuerer identifiers annotated at that GO term or one of its children in the GO ontology.

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
from the source of: 20110312 and Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With a date
stamp from the source of: 2011-Mar16

14

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

Examples

IlluminaHumanMethylation27kGO2PROBE

# Convert to a list
xx <- as.list(IlluminaHumanMethylation27kGO2ALLPROBES)
if(length(xx) > 0){

# Get the probe identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Get all the probe identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

IlluminaHumanMethylation27kGO2PROBE

Map between Gene Ontology (GO) and Manufacturer Identifiers

Description

IlluminaHumanMethylation27kGO2PROBE is an R object that provides mappings between GO
identifiers and manufacturer identifiers.

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

Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With a date stamp from the source of: 2011-
Mar16

IlluminaHumanMethylation27kISCPGISLAND

15

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

Examples

# Convert to a list
xx <- as.list(IlluminaHumanMethylation27kGO2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Get the probe identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

IlluminaHumanMethylation27kISCPGISLAND

Determine whether a probe is within a CpG island

Description

IlluminaHumanMethylation27kISCPGISLAND is an R object that provides mappings between a
manufacturer identifier and whether or not the CpG site being assayed meets Illumina’s criteria for
being in a CpG island as defined by Illumina in the manifest.

Details

Value is a simple TRUE or FALSE for each probe, based simply on the Illumina manifest, TRUE
meaning that the CpG site is within a CpG island.

Mappings were based on data provided by: Illimina http://Illumina.com Downloaded 19-Sep-2009

Examples

x <- IlluminaHumanMethylation27kISCPGISLAND
# Get the probe identifiers that are mapped
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the values for the first five probes
xx[1:5]

}

16

IlluminaHumanMethylation27kMAP

IlluminaHumanMethylation27kMAP

Map between Manufacturer Identifiers and cytogenetic maps/bands

Description

IlluminaHumanMethylation27kMAP is an R object that provides mappings between manufacturer
identifiers and cytoband locations.

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
a date stamp from the source of: 2011-Mar16

References

http://www.ncbi.nlm.nih.gov

Examples

x <- IlluminaHumanMethylation27kMAP
# Get the probe identifiers that are mapped to any cytoband
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the MAP for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

IlluminaHumanMethylation27kMAPCOUNTS

17

IlluminaHumanMethylation27kMAPCOUNTS

Number of mapped keys for the maps in package IlluminaHuman-
Methylation27k.db

Description

IlluminaHumanMethylation27kMAPCOUNTS provides the "map count" (i.e. the count of mapped
keys) for each map in package IlluminaHumanMethylation27k.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

Examples

IlluminaHumanMethylation27kMAPCOUNTS
mapnames <- names(IlluminaHumanMethylation27kMAPCOUNTS)
IlluminaHumanMethylation27kMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package IlluminaHumanMethylation27k.db
checkMAPCOUNTS("IlluminaHumanMethylation27k.db")

IlluminaHumanMethylation27kNUID

Map Illumina probe IDs to the NuID representation of the target se-
quence

Description

IlluminaHumanMethylation27kNUID is an R object that provides mappings between Illumina probe
IDs and the NuID string generated by lumi::seq2id(sourceSeq) based on the target sequences pro-
vided by Illumina in the 27k manifest.

Details

Probe ID to NuID conversion, without the agonizing wait.

Mappings were based on data provided by: Illimina http://Illumina.com Downloaded 11-Jan-2011

Examples

as.list(IlluminaHumanMethylation27kNUID)[150:200]

18

IlluminaHumanMethylation27kORGANISM

IlluminaHumanMethylation27kOMIM

Map between Manufacturer Identifiers and Mendelian Inheritance in
Man (MIM) identifiers

Description

IlluminaHumanMethylation27kOMIM is an R object that provides mappings between manufacturer
identifiers and OMIM identifiers.

Details

Each manufacturer identifier is mapped to a vector of OMIM identifiers. The vector length may be
one or longer, depending on how many OMIM identifiers the manufacturer identifier maps to. An
NA is reported for any manufacturer identifier that cannot be mapped to an OMIM identifier at this
time.

OMIM is based upon the book Mendelian Inheritance in Man (V. A. McKusick) and focuses primar-
ily on inherited or heritable genetic diseases. It contains textual information, pictures, and reference
information that can be searched using various terms, among which the MIM number is one.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene http://www3.ncbi.nlm.nih.gov/
entrez/query.fcgi?db=OMIM

Examples

x <- IlluminaHumanMethylation27kOMIM
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

IlluminaHumanMethylation27kORGANISM

The Organism information for IlluminaHumanMethylation27k

Description

IlluminaHumanMethylation27kORGANISM is an R object that contains a single item: a character
string that names the organism for which IlluminaHumanMethylation27k was built. IlluminaHu-
manMethylation27kORGPKG is an R object that contains a chararcter vector with the name of the
organism package that a chip package depends on for its gene-centric annotation.

IlluminaHumanMethylation27kPATH

19

Details

Although the package name is suggestive of the organism for which it was built, IlluminaHu-
manMethylation27kORGANISM provides a simple way to programmatically extract the organism
name. IlluminaHumanMethylation27kORGPKG provides a simple way to programmatically ex-
tract the name of the parent organism package. The parent organism package is a strict dependency
for chip packages as this is where the gene cetric information is ultimately extracted from. The full
package name will always be this string plus the extension ".db". But most programatic acces will
not require this extension, so its more convenient to leave it out.

Examples

IlluminaHumanMethylation27kORGANISM
IlluminaHumanMethylation27kORGPKG

IlluminaHumanMethylation27kPATH

Mappings between probe identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms. IlluminaHumanMethylation27kPATH maps probe identifiers to the identifiers used by KEGG
for pathways in which the genes represented by the probe identifiers are involved

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

x <- IlluminaHumanMethylation27kPATH
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

20

IlluminaHumanMethylation27kPFAM

IlluminaHumanMethylation27kPATH2PROBE

Map between Kyoto Encyclopedia of Genes and Genomes (KEGG)
pathway identifiers and Manufacturer Identifiers

Description

IlluminaHumanMethylation27kPATH2PROBE is an R object that provides mappings between KEGG
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
With a date stamp from the source of: 2011-Mar15

References

http://www.genome.ad.jp/kegg/

Examples

# Convert the object to a list
xx <- as.list(IlluminaHumanMethylation27kPATH2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two pathway identifiers
xx[1:2]
# Get the first one
xx[[1]]

}

IlluminaHumanMethylation27kPFAM

Map Manufacturer IDs to Pfam IDs

Description

IlluminaHumanMethylation27kPFAM is an R object that provides mappings between a manufac-
turer identifier and the associated Pfam identifiers.

IlluminaHumanMethylation27kPMID

21

Details

Each manufacturer identifier maps to a named vector of Pfam identifiers. The name for each Pfam
identifier is the IPI accession numbe where this Pfam identifier is found.

If the Pfam is a named NA, it means that the associated Entrez Gene id of this manufacturer identifier
is found in an IPI entry of the IPI database, but there is no Pfam identifier in the entry.

If the Pfam is a non-named NA, it means that the associated Entrez Gene id of this manufacturer
identifier is not found in any IPI entry of the IPI database.

Mappings were based on data provided by: The International Protein Index ftp://ftp.ebi.ac.uk/pub/databases/IPI/current
With a date stamp from the source of: 2011-Feb18

References

Kersey P. J., Duarte J., Williams A., Karavidopoulou Y., Birney E., Apweiler R. The International
Protein Index: An integrated database for proteomics experiments. Proteomics 4(7): 1985-1988
(2004) http://www.ebi.ac.uk/IPI/IPIhelp.html

Examples

x <- IlluminaHumanMethylation27kPFAM
# Get the probe identifiers that are mapped to any Pfam ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
# randomly display 10 probes
sample(xx, 10)

IlluminaHumanMethylation27kPMID

Map between Manufacturer Identifiers and PubMed Identifiers

Description

IlluminaHumanMethylation27kPMID is an R object that provides mappings between manufacturer
identifiers and PubMed identifiers.

Details

Each manufacturer identifier is mapped to a named vector of PubMed identifiers. The name asso-
ciated with each vector corresponds to the manufacturer identifier. The length of the vector may
be one or greater, depending on how many PubMed identifiers a given manufacturer identifier is
mapped to. An NA is reported for any manufacturer identifier that cannot be mapped to a PubMed
identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=PubMed

22

Examples

IlluminaHumanMethylation27kPMID2PROBE

x <- IlluminaHumanMethylation27kPMID
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

IlluminaHumanMethylation27kPMID2PROBE

Map between PubMed Identifiers and Manufacturer Identifiers

Description

IlluminaHumanMethylation27kPMID2PROBE is an R object that provides mappings between PubMed
identifiers and manufacturer identifiers.

Details

Each PubMed identifier is mapped to a named vector of manufacturer identifiers. The name repre-
sents the PubMed identifier and the vector contains all manufacturer identifiers that are represented
by that PubMed identifier. The length of the vector may be one or longer, depending on how many
manufacturer identifiers are mapped to a given PubMed identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

Examples

# Convert the object to a list
xx <- as.list(IlluminaHumanMethylation27kPMID2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two PubMed identifiers
xx[1:2]
# Get the first one
xx[[1]]
if(interactive() && require(annotate)){

# Get article information as XML files for a PubMed id
xmls <- pubmed(names(xx)[1], disp = "data")

IlluminaHumanMethylation27kPROSITE

23

# View article information using a browser
pubmed(names(xx)[1], disp = "browser")

}

}

IlluminaHumanMethylation27kPROSITE

Map Manufacturer IDs to PROSITE ID

Description

IlluminaHumanMethylation27kPROSITE is an R object that provides mappings between a manu-
facturer identifier and the associated PROSITE identifiers.

Details

Each manufacturer identifier maps to a named vector of PROSITE identifiers. The name for each
PROSITE identifier is the IPI accession numbe where this PROSITE identifier is found.

If the PROSITE is a named NA, it means that the associated Entrez Gene id of this manufacturer
identifier is found in an IPI entry of the IPI database, but there is no PROSITE identifier in the entry.

If the PROSITE is a non-named NA, it means that the associated Entrez Gene id of this manufacturer
identifier is not found in any IPI entry of the IPI database.

Mappings were based on data provided by: The International Protein Index ftp://ftp.ebi.ac.uk/pub/databases/IPI/current
With a date stamp from the source of: 2011-Feb18

References

Kersey P. J., Duarte J., Williams A., Karavidopoulou Y., Birney E., Apweiler R. The International
Protein Index: An integrated database for proteomics experiments. Proteomics 4(7): 1985-1988
(2004) http://www.ebi.ac.uk/IPI/IPIhelp.html

Examples

x <- IlluminaHumanMethylation27kPROSITE
# Get the probe identifiers that are mapped to any PROSITE ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xxx <- as.list(x[mapped_probes])
# randomly display 10 probes
xxx[sample(1:length(xxx), 10)]

24

IlluminaHumanMethylation27kREFSEQ

IlluminaHumanMethylation27kREFSEQ

Map between Manufacturer Identifiers and RefSeq Identifiers

Description

IlluminaHumanMethylation27kREFSEQ is an R object that provides mappings between manufac-
turer identifiers and RefSeq identifiers.

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
a date stamp from the source of: 2011-Mar16

References

http://www.ncbi.nlm.nih.gov http://www.ncbi.nlm.nih.gov/RefSeq/

Examples

x <- IlluminaHumanMethylation27kREFSEQ
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

IlluminaHumanMethylation27kSVNID

25

IlluminaHumanMethylation27kSVNID

What is the in-house Subversion ID of this annotation package?

Description

IlluminaHumanMethylation27kSVNID answers the important question of where to point the finger
when it turns out an annotation is out of date. Naturally, this particular feature will also indicate if
the user has ended up with an out-of-date copy of the package, so that both maintainers and users
can track any such discontinuities.

Details

The revision ID should include a numeric change identifier and its author.

Examples

x <- IlluminaHumanMethylation27kSVNID
show(x)

IlluminaHumanMethylation27kSYMBOL

Map between Manufacturer Identifiers and Gene Symbols

Description

IlluminaHumanMethylation27kSYMBOL is an R object that provides mappings between manufac-
turer identifiers and gene abbreviations.

Details

Each manufacturer identifier is mapped to an abbreviation for the corresponding gene. An NA is
reported if there is no known abbreviation for a given gene.

Symbols typically consist of 3 letters that define either a single gene (ABC) or multiple genes
(ABC1, ABC2, ABC3). Gene symbols can be used as key words to query public databases such as
Entrez Gene.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

26

Examples

IlluminaHumanMethylation27kUNIGENE

x <- IlluminaHumanMethylation27kSYMBOL
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

IlluminaHumanMethylation27kUNIGENE

Map between Manufacturer Identifiers and UniGene cluster identifiers

Description

IlluminaHumanMethylation27kUNIGENE is an R object that provides mappings between manu-
facturer identifiers and UniGene identifiers.

Details

Each manufacturer identifier is mapped to a UniGene identifier. An NA is reported if the manufac-
turer identifier cannot be mapped to UniGene at this time.

A UniGene identifier represents a cluster of sequences of a gene. Using UniGene identifiers one
can query the UniGene database for information about the sequences or the Entrez Gene database
for information about the genes.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- IlluminaHumanMethylation27kUNIGENE
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

IlluminaHumanMethylation27kUNIPROT

27

IlluminaHumanMethylation27kUNIPROT

Map Uniprot accession numbers with Entrez Gene identifiers

Description

IlluminaHumanMethylation27kUNIPROT is an R object that contains mappings between Entrez
Gene identifiers and Uniprot accession numbers.

Details

This object is a simple mapping of Entrez Gene identifiers http://www.ncbi.nlm.nih.gov/entrez/
query.fcgi?db=gene to Uniprot Accessions.
Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

Examples

x <- IlluminaHumanMethylation27kUNIPROT
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

IlluminaHumanMethylation27k_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

IlluminaHumanMethylation27k_dbconn()
IlluminaHumanMethylation27k_dbfile()
IlluminaHumanMethylation27k_dbschema(file="", show.indices=FALSE)
IlluminaHumanMethylation27k_dbInfo()

Arguments

file

show.indices

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).
The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

28

Details

IlluminaHumanMethylation27k_getControls

IlluminaHumanMethylation27k_dbconn returns a connection object to the package annotation
DB. IMPORTANT: Don’t call dbDisconnect on the connection object returned by IlluminaHumanMethylation27k_dbconn
or you will break all the AnnDbObj objects defined in this package!
IlluminaHumanMethylation27k_dbfile returns the path (character string) to the package anno-
tation DB (this is an SQLite file).
IlluminaHumanMethylation27k_dbschema prints the schema definition of the package annotation
DB.
IlluminaHumanMethylation27k_dbInfo prints other information about the package annotation
DB.

Value

IlluminaHumanMethylation27k_dbconn: a DBIConnection object representing an open connec-
tion to the package annotation DB.
IlluminaHumanMethylation27k_dbfile: a character string with the path to the package annota-
tion DB.
IlluminaHumanMethylation27k_dbschema: none (invisible NULL).
IlluminaHumanMethylation27k_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

## Count the number of rows in the "probes" table:
dbGetQuery(IlluminaHumanMethylation27k_dbconn(), "SELECT COUNT(*) FROM probes")

## The connection object returned by IlluminaHumanMethylation27k_dbconn() was
## created with:
dbConnect(SQLite(), dbname=IlluminaHumanMethylation27k_dbfile(), cache_size=64000,
synchronous=0)

IlluminaHumanMethylation27k_dbschema()

IlluminaHumanMethylation27k_dbInfo()

IlluminaHumanMethylation27k_getControls

Retrieve control probe addresses, optionally by control probe type

Description

A convenience function to retrieve addresses of Illumina control probes.

Usage

IlluminaHumanMethylation27k_getControls(type=NULL)

IlluminaHumanMethylation27k_getProbeOrdering

29

Arguments

type

Details

Optional control probe type. If NULL, all control probes will be returned.

IlluminaHumanMethylation27k_getControls simply queries a VIEW in the SQLite database
accompanying this package to obtain control probe addresses.

Value

A data.frame with fields Address and Type for each probe returned.

See Also

dbconn, dbfile, dbschema, dbInfo

Examples

## Get all the control probe addresses
IlluminaHumanMethylation27k_getControls()

## Get only the bisulfite conversion controls
IlluminaHumanMethylation27k_getControls('Bisulfite')

IlluminaHumanMethylation27k_getProbeOrdering

Retrieve probe IDs in the order loaded from the manifest

Description

A convenience function to provide consistent probe ordering from IDATs.

IlluminaHumanMethylation27k_getProbeOrdering()

Usage

Value

A vector of Probe_ID strings in the order found in the original manifest.

Examples

ordering <- IlluminaHumanMethylation27k_getProbeOrdering()

30

IlluminaHumanMethylation27k_getProbes

IlluminaHumanMethylation27k_getProbes

Retrieve probe addresses by design and/or color channel for process-
ing

Description

A convenience function to retrieve probe addresses by design or color channel.

Usage

IlluminaHumanMethylation27k_getProbes(color=NULL, design='I')

Arguments

color

design

Details

Optional color for design I. If NULL, both will be returned as a list.

Optional probe design type. If NULL, both will be returned in a list.

IlluminaHumanMethylation27k_getProbes simply queries a VIEW in the SQLite database ac-
companying this package to obtain probe addresses en masse.

Value

If no arguments are provided, a list of two data frames for probes, one for each color channel. If
arguments are provided, the value depends on them.

See Also

dbconn, dbfile, dbschema, dbInfo

Examples

## Get both channels' worth of probes for processing IDAT files
IlluminaHumanMethylation27k_getProbes(color='Red')

Index

∗ datasets

IlluminaHumanMethylation27k.db, 2
IlluminaHumanMethylation27k_dbconn,

27

IlluminaHumanMethylation27k_getControls,

28

IlluminaHumanMethylation27k_getProbeOrdering,

29

IlluminaHumanMethylation27k_getProbes,

30

IlluminaHumanMethylation27kACCNUM,

1

IlluminaHumanMethylation27kALIAS2PROBE,

2

IlluminaHumanMethylation27kBLAME,

3

IlluminaHumanMethylation27kCHR, 3
IlluminaHumanMethylation27kCHRLENGTHS,

4

IlluminaHumanMethylation27kCHRLOC,

4

IlluminaHumanMethylation27kCOLORCHANNEL,

5

IlluminaHumanMethylation27kCPGCOORDINATE,

5

IlluminaHumanMethylation27kCPGS, 6
IlluminaHumanMethylation27kDISTTOTSS,

6

IlluminaHumanMethylation27kENSEMBL,

7

IlluminaHumanMethylation27kENTREZID,

8

IlluminaHumanMethylation27kENZYME,

9

IlluminaHumanMethylation27kENZYME2PROBE,

10

IlluminaHumanMethylation27kGENENAME,

11

IlluminaHumanMethylation27kGO, 12
IlluminaHumanMethylation27kGO2ALLPROBES,

13

IlluminaHumanMethylation27kGO2PROBE,

14

31

IlluminaHumanMethylation27kISCPGISLAND,

15

IlluminaHumanMethylation27kMAP, 16
IlluminaHumanMethylation27kMAPCOUNTS,

17

IlluminaHumanMethylation27kNUID,

17

IlluminaHumanMethylation27kOMIM,

18

IlluminaHumanMethylation27kORGANISM,

18

IlluminaHumanMethylation27kPATH,

19

IlluminaHumanMethylation27kPATH2PROBE,

20

IlluminaHumanMethylation27kPFAM,

20

IlluminaHumanMethylation27kPMID,

21

IlluminaHumanMethylation27kPMID2PROBE,

22

IlluminaHumanMethylation27kPROSITE,

23

IlluminaHumanMethylation27kREFSEQ,

24

IlluminaHumanMethylation27kSVNID,

25

IlluminaHumanMethylation27kSYMBOL,

25

IlluminaHumanMethylation27kUNIGENE,

26

IlluminaHumanMethylation27kUNIPROT,

27

∗ utilities

IlluminaHumanMethylation27k_dbconn,

27

IlluminaHumanMethylation27k_getControls,

28

IlluminaHumanMethylation27k_getProbeOrdering,

29

IlluminaHumanMethylation27k_getProbes,

30

AnnDbObj, 28

INDEX

7

IlluminaHumanMethylation27kENTREZID, 8
IlluminaHumanMethylation27kENZYME, 9
IlluminaHumanMethylation27kENZYME2PROBE,

10

IlluminaHumanMethylation27kGENENAME,

11

IlluminaHumanMethylation27kGO, 12
IlluminaHumanMethylation27kGO2ALLPROBES,

13

IlluminaHumanMethylation27kGO2PROBE,

14

IlluminaHumanMethylation27kISCPGISLAND,

15

IlluminaHumanMethylation27kLOCUSID

(IlluminaHumanMethylation27kENTREZID),
8

IlluminaHumanMethylation27kMAP, 16
IlluminaHumanMethylation27kMAPCOUNTS,

17

IlluminaHumanMethylation27kNUID, 17
IlluminaHumanMethylation27kOMIM, 18
IlluminaHumanMethylation27kORGANISM,

18

IlluminaHumanMethylation27kORGPKG

(IlluminaHumanMethylation27kORGANISM),
18

IlluminaHumanMethylation27kPATH, 19
IlluminaHumanMethylation27kPATH2PROBE,

20

IlluminaHumanMethylation27kPFAM, 20
IlluminaHumanMethylation27kPMID, 21
IlluminaHumanMethylation27kPMID2PROBE,

22

IlluminaHumanMethylation27kPROSITE, 23
IlluminaHumanMethylation27kREFSEQ, 24
IlluminaHumanMethylation27kSVNID, 25
IlluminaHumanMethylation27kSYMBOL, 25
IlluminaHumanMethylation27kUNIGENE, 26
IlluminaHumanMethylation27kUNIPROT, 27
IlluminaHumanMethylation27kUNIPROT2PROBE

(IlluminaHumanMethylation27kUNIPROT),
27

mappedkeys, 17

32

cat, 27
checkMAPCOUNTS, 17
count.mappedkeys, 17

dbconn, 28–30
dbConnect, 28
dbDisconnect, 28
dbfile, 28–30
dbGetQuery, 28
dbInfo, 28–30
dbschema, 28–30

IlluminaHumanMethylation27k

(IlluminaHumanMethylation27k.db),
2

IlluminaHumanMethylation27k.db, 2
IlluminaHumanMethylation27k_dbconn, 27
IlluminaHumanMethylation27k_dbfile

(IlluminaHumanMethylation27k_dbconn),
27

IlluminaHumanMethylation27k_dbInfo

(IlluminaHumanMethylation27k_dbconn),
27

IlluminaHumanMethylation27k_dbschema

(IlluminaHumanMethylation27k_dbconn),
27

IlluminaHumanMethylation27k_getControls,

28

IlluminaHumanMethylation27k_getProbeOrdering,

29

IlluminaHumanMethylation27k_getProbes,

30

IlluminaHumanMethylation27kACCNUM, 1
IlluminaHumanMethylation27kALIAS2PROBE,

2

IlluminaHumanMethylation27kBLAME, 3
IlluminaHumanMethylation27kCHR, 3
IlluminaHumanMethylation27kCHRLENGTHS,

4

IlluminaHumanMethylation27kCHRLOC, 4
IlluminaHumanMethylation27kCHRLOCEND

(IlluminaHumanMethylation27kCHRLOC),
4

IlluminaHumanMethylation27kCOLORCHANNEL,

5

IlluminaHumanMethylation27kCPGCOORDINATE,

5

IlluminaHumanMethylation27kCPGS, 6
IlluminaHumanMethylation27kDISTTOTSS,

6

IlluminaHumanMethylation27kENSEMBL, 7
IlluminaHumanMethylation27kENSEMBL2PROBE

(IlluminaHumanMethylation27kENSEMBL),

