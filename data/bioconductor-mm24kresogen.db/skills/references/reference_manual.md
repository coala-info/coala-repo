mm24kresogen.db

February 11, 2026

mm24kresogenACCNUM

Map Manufacturer identifiers to Accession Numbers

Description

mm24kresogenACCNUM is an R object that contains mappings between a manufacturer’s identi-
fiers and manufacturers accessions.

Details

For chip packages such as this, the ACCNUM mapping comes directly from the manufacturer. This
is different from other mappings which are mapped onto the probes via an Entrez Gene identifier.

Each manufacturer identifier maps to a vector containing a GenBank accession number.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

Examples

x <- mm24kresogenACCNUM
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

mm24kresogen.db

mm24kresogenALIAS2PROBE

Map between Common Gene Symbol Identifiers and Manufacturer
Identifiers

Description

mm24kresogenALIAS is an R object that provides mappings between common gene symbol iden-
tifiers and manufacturer identifiers.

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
xx <- as.list(mm24kresogenALIAS2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two aliases
xx[1:2]
# Get the first one
xx[[1]]

}

mm24kresogen.db

Bioconductor annotation data package

Description

Welcome to the mm24kresogen.db annotation Package. The purpose of this package is to provide
detailed information about the mm24kresogen platform. This package is updated biannually.

You can learn what objects this package supports with the following command:

ls("package:mm24kresogen.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:mm24kresogen.db")

mm24kresogenCHR

3

mm24kresogenCHR

Map Manufacturer IDs to Chromosomes

Description

mm24kresogenCHR is an R object that provides mappings between a manufacturer identifier and
the chromosome that contains the gene of interest.

Details

Each manufacturer identifier maps to a vector of chromosomes. Due to inconsistencies that may
exist at the time the object was built, the vector may contain more than one chromosome (e.g., the
identifier may map to more than one chromosome). If the chromosomal location is unknown, the
vector will contain an NA.
Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

Examples

x <- mm24kresogenCHR
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

mm24kresogenCHRLENGTHS

A named vector for the length of each of the chromosomes

Description

mm24kresogenCHRLENGTHS provides the length measured in base pairs for each of the chromo-
somes.

Details

This is a named vector with chromosome numbers as the names and the corresponding lengths for
chromosomes as the values.

Total lengths of chromosomes were derived by calculating the number of base pairs on the sequence
string for each chromosome.

Examples

tt <- mm24kresogenCHRLENGTHS
# Length of chromosome 1
tt["1"]

4

mm24kresogenENSEMBL

mm24kresogenCHRLOC

Map Manufacturer IDs to Chromosomal Location

Description

mm24kresogenCHRLOC is an R object that maps manufacturer identifiers to the starting position
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

Mappings were based on data provided by: UCSC Genome Bioinformatics (Mus musculus) ftp://hgdownload.cse.ucsc.edu/goldenPath/mm9
With a date stamp from the source of: 2009-Jul5

Examples

x <- mm24kresogenCHRLOC
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

mm24kresogenENSEMBL

Map Ensembl gene accession numbers with Entrez Gene identifiers

Description

mm24kresogenENSEMBL is an R object that contains mappings between Entrez Gene identifiers
and Ensembl gene accession numbers.

mm24kresogenENTREZID

Details

5

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

x <- mm24kresogenENSEMBL
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
xx <- as.list(mm24kresogenENSEMBL2PROBE)
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

mm24kresogenENTREZID Map between Manufacturer Identifiers and Entrez Gene

Description

mm24kresogenENTREZID is an R object that provides mappings between manufacturer identifiers
and Entrez Gene identifiers.

Details

Each manufacturer identifier is mapped to a vector of Entrez Gene identifiers. An NA is assigned to
those manufacturer identifiers that can not be mapped to an Entrez Gene identifier at this time.

If a given manufacturer identifier can be mapped to different Entrez Gene identifiers from various
sources, we attempt to select the common identifiers. If a concensus cannot be determined, we
select the smallest identifier.

6

mm24kresogenENZYME

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- mm24kresogenENTREZID
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

mm24kresogenENZYME

Map between Manufacturer IDs and Enzyme Commission (EC) Num-
bers

Description

mm24kresogenENZYME is an R object that provides mappings between manufacturer identifiers
and EC numbers.

Details

Each manufacturer identifier maps to a named vector containing the EC number that corresponds
to the enzyme produced by that gene. The name corresponds to the manufacturer identifier. If this
information is unknown, the vector will contain an NA.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric num-
bers. In mm24kresogenENZYME2PROBE, EC is dropped from the Enzyme Commission numbers.

Enzyme Commission numbers have corresponding names that describe the functions of enzymes
in such a way that EC x is a more general description than EC x.y that in turn is a more general
description than EC x.y.z. The top level EC numbers and names are listed below:

EC 1 oxidoreductases

EC 2 transferases

EC 3 hydrolases

EC 4 lyases

EC 5 isomerases

EC 6 ligases

mm24kresogenENZYME2PROBE

7

The EC name for a given EC number can be viewed at http://www.chem.qmul.ac.uk/iupac/
jcbn/index.html#6

Mappings between probe identifiers and enzyme identifiers were obtained using files provided by:
KEGG GENOME ftp://ftp.genome.jp/pub/kegg/genomes With a date stamp from the source of:
2011-Mar15

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

Examples

x <- mm24kresogenENZYME
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

mm24kresogenENZYME2PROBE

Map between Enzyme Commission Numbers and Manufacturer Iden-
tifiers

Description

mm24kresogenENZYME2PROBE is an R object that maps Enzyme Commission (EC) numbers to
manufacturer identifiers.

Details

Each EC number maps to a named vector containing all of the manufacturer identifiers that cor-
respond to the gene that produces that enzyme. The name of the vector corresponds to the EC
number.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric num-
bers. In mm24kresogenENZYME2PROBE, EC is dropped from the Enzyme Commission numbers.

Enzyme Commission numbers have corresponding names that describe the functions of enzymes
in such a way that EC x is a more general description than EC x.y that in turn is a more general
description than EC x.y.z. The top level EC numbers and names are listed below:

EC 1 oxidoreductases

EC 2 transferases

EC 3 hydrolases

8

mm24kresogenGENENAME

EC 4 lyases

EC 5 isomerases

EC 6 ligases

The EC name for a given EC number can be viewed at http://www.chem.qmul.ac.uk/iupac/
jcbn/index.html#6

Mappings were based on data provided by: KEGG GENOME ftp://ftp.genome.jp/pub/kegg/genomes
With a date stamp from the source of: 2011-Mar15

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

Examples

# Convert to a list
xx <- as.list(mm24kresogenENZYME2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first five enzyme
#commission numbers
xx[1:5]
# Get the first one
xx[[1]]

}

mm24kresogenGENENAME Map between Manufacturer IDs and Genes

Description

mm24kresogenGENENAME is an R object that maps manufacturer identifiers to the corresponding
gene name.

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

x <- mm24kresogenGENENAME
# Get the probe identifiers that are mapped to a gene name
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

mm24kresogenGO

9

# Get the GENENAME for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

mm24kresogenGO

Map between Manufacturer IDs and Gene Ontology (GO)

Description

mm24kresogenGO is an R object that provides mappings between manufacturer identifiers and the
GO identifiers that they are directly associated with.

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

10

Examples

mm24kresogenGO2ALLPROBES

x <- mm24kresogenGO
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

mm24kresogenGO2ALLPROBES

Map between Gene Ontology (GO) Identifiers and all Manufacturer
Identifiers in the subtree

Description

mm24kresogenGO2ALLPROBES is an R object that provides mappings between a given GO iden-
tifier and all manufactuerer identifiers annotated at that GO term or one of its children in the GO
ontology.

Details

GO consists of three ontologies—molecular function (MF), biological process (BP), and cellular
component (CC). All ontologies are structured as directed acyclic graphs (DAGs). Each node in
each DAG (tree) is a GO term (id) associated with a named vector of manufacturer identifiers. The
name associated with each manufacturer id corresponds to the evidence code for that GO iden-
tifier. This object mm24kresogenGO2ALLPROBES maps between a given GO identifier and all
manufactuerer identifiers annotated at that GO term or one of its children in the GO ontology.

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

mm24kresogenGO2PROBE

11

A GO identifier may be mapped to the same manufacturer identifier more than once but the evidence
code can be different. Mappings between Gene Ontology identifiers and Gene Ontology terms and
other information are available in a separate data package named GO.

Mappings were based on data provided by:

Gene Ontology ftp://ftp.geneontology.org/pub/go/godatabase/archive/latest-lite/ With a date stamp
from the source of: 20110312 and Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With a date
stamp from the source of: 2011-Mar16

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

Examples

# Convert to a list
xx <- as.list(mm24kresogenGO2ALLPROBES)
if(length(xx) > 0){

# Get the probe identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Get all the probe identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

mm24kresogenGO2PROBE Map between Gene Ontology (GO) and Manufacturer Identifiers

Description

mm24kresogenGO2PROBE is an R object that provides mappings between GO identifiers and man-
ufacturer identifiers.

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

12

mm24kresogenMAP

ND - no biological data available

IC - inferred by curator

A GO identifier may be mapped to the same probe identifier more than once but the evidence code
can be different. Mappings between Gene Ontology identifiers an Gene Ontology terms and other
information are available in a separate data package named GO.

Mappings were based on data provided by:

Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With a date stamp from the source of: 2011-
Mar16

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

Examples

# Convert to a list
xx <- as.list(mm24kresogenGO2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Get the probe identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

mm24kresogenMAP

Map between Manufacturer Identifiers and cytogenetic maps/bands

Description

mm24kresogenMAP is an R object that provides mappings between manufacturer identifiers and
cytoband locations.

Details

Each manufacturer identifier is mapped to a vector of cytoband locations. The vector length may
be one or longer, if there are multiple reported chromosomal locations for a given gene. An NA is
reported for any manufacturer identifiers that cannot be mapped to a cytoband at this time.

The physical location of each band on a chromosome can be obtained from another object named
"organism"CYTOLOC in a separate data package for human(humanCHRLOC), mouse(mouseCHRLOC),
and rat(ratCHRLOC).

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

References

http://www.ncbi.nlm.nih.gov

mm24kresogenMAPCOUNTS

13

Examples

x <- mm24kresogenMAP
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

mm24kresogenMAPCOUNTS Number of mapped keys for the maps in package mm24kresogen.db

Description

mm24kresogenMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each
map in package mm24kresogen.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

Examples

mm24kresogenMAPCOUNTS
mapnames <- names(mm24kresogenMAPCOUNTS)
mm24kresogenMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package mm24kresogen.db
checkMAPCOUNTS("mm24kresogen.db")

14

mm24kresogenORGANISM

mm24kresogenMGI

Map MGI gene accession numbers with manufacturer identifiers

Description

mm24kresogenMGI is an R object that contains mappings between manufacturer identifiers and
Jackson Laboratory MGI gene accession numbers.

Details

This object is a simple mapping of manufacturer identifiers http://www.ncbi.nlm.nih.gov/
entrez/query.fcgi?db=gene to MGI gene Accession Numbers.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

Examples

x <- mm24kresogenMGI
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
xx <- as.list(mm24kresogenMGI2PROBE)
if(length(xx) > 0){

# Gets the manufacturer IDs for the first five MGI IDs
xx[1:5]
# Get the first one
xx[[1]]

}

mm24kresogenORGANISM

The Organism information for mm24kresogen

Description

mm24kresogenORGANISM is an R object that contains a single item: a character string that names
the organism for which mm24kresogen was built. mm24kresogenORGPKG is an R object that
contains a chararcter vector with the name of the organism package that a chip package depends on
for its gene-centric annotation.

mm24kresogenPATH

Details

15

Although the package name is suggestive of the organism for which it was built, mm24kresogenORGANISM
provides a simple way to programmatically extract the organism name. mm24kresogenORGPKG
provides a simple way to programmatically extract the name of the parent organism package. The
parent organism package is a strict dependency for chip packages as this is where the gene cetric
information is ultimately extracted from. The full package name will always be this string plus the
extension ".db". But most programatic acces will not require this extension, so its more convenient
to leave it out.

Examples

mm24kresogenORGANISM
mm24kresogenORGPKG

mm24kresogenPATH

Mappings between probe identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms. mm24kresogenPATH maps probe identifiers to the identifiers used by KEGG for pathways in
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

Examples

x <- mm24kresogenPATH
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

mm24kresogenPFAM

mm24kresogenPATH2PROBE

Map between Kyoto Encyclopedia of Genes and Genomes (KEGG)
pathway identifiers and Manufacturer Identifiers

Description

mm24kresogenPATH2PROBE is an R object that provides mappings between KEGG identifiers
and manufacturer identifiers.

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
xx <- as.list(mm24kresogenPATH2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two pathway identifiers
xx[1:2]
# Get the first one
xx[[1]]

}

mm24kresogenPFAM

Map Manufacturer IDs to Pfam IDs

Description

mm24kresogenPFAM is an R object that provides mappings between a manufacturer identifier and
the associated Pfam identifiers.

mm24kresogenPMID

Details

17

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

x <- mm24kresogenPFAM
# Get the probe identifiers that are mapped to any Pfam ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
# randomly display 10 probes
sample(xx, 10)

mm24kresogenPMID

Map between Manufacturer Identifiers and PubMed Identifiers

Description

mm24kresogenPMID is an R object that provides mappings between manufacturer identifiers and
PubMed identifiers.

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

18

Examples

mm24kresogenPMID2PROBE

x <- mm24kresogenPMID
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

mm24kresogenPMID2PROBE

Map between PubMed Identifiers and Manufacturer Identifiers

Description

mm24kresogenPMID2PROBE is an R object that provides mappings between PubMed identifiers
and manufacturer identifiers.

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
xx <- as.list(mm24kresogenPMID2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two PubMed identifiers
xx[1:2]
# Get the first one
xx[[1]]
if(interactive() && require(annotate)){

# Get article information as XML files for a PubMed id
xmls <- pubmed(names(xx)[1], disp = "data")

mm24kresogenPROSITE

19

# View article information using a browser
pubmed(names(xx)[1], disp = "browser")

}

}

mm24kresogenPROSITE

Map Manufacturer IDs to PROSITE ID

Description

mm24kresogenPROSITE is an R object that provides mappings between a manufacturer identifier
and the associated PROSITE identifiers.

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

x <- mm24kresogenPROSITE
# Get the probe identifiers that are mapped to any PROSITE ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xxx <- as.list(x[mapped_probes])
# randomly display 10 probes
xxx[sample(1:length(xxx), 10)]

mm24kresogenREFSEQ

Map between Manufacturer Identifiers and RefSeq Identifiers

Description

mm24kresogenREFSEQ is an R object that provides mappings between manufacturer identifiers
and RefSeq identifiers.

20

Details

mm24kresogenSYMBOL

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

x <- mm24kresogenREFSEQ
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

mm24kresogenSYMBOL

Map between Manufacturer Identifiers and Gene Symbols

Description

mm24kresogenSYMBOL is an R object that provides mappings between manufacturer identifiers
and gene abbreviations.

mm24kresogenUNIGENE

Details

21

Each manufacturer identifier is mapped to an abbreviation for the corresponding gene. An NA is
reported if there is no known abbreviation for a given gene.

Symbols typically consist of 3 letters that define either a single gene (ABC) or multiple genes
(ABC1, ABC2, ABC3). Gene symbols can be used as key words to query public databases such as
Entrez Gene.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- mm24kresogenSYMBOL
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

mm24kresogenUNIGENE

Map between Manufacturer Identifiers and UniGene cluster identifiers

Description

mm24kresogenUNIGENE is an R object that provides mappings between manufacturer identifiers
and UniGene identifiers.

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

22

Examples

mm24kresogen_dbconn

x <- mm24kresogenUNIGENE
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

mm24kresogenUNIPROT

Map Uniprot accession numbers with Entrez Gene identifiers

Description

mm24kresogenUNIPROT is an R object that contains mappings between Entrez Gene identifiers
and Uniprot accession numbers.

Details

This object is a simple mapping of Entrez Gene identifiers http://www.ncbi.nlm.nih.gov/entrez/
query.fcgi?db=gene to Uniprot Accessions.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2011-Mar16

Examples

x <- mm24kresogenUNIPROT
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

mm24kresogen_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

mm24kresogen_dbconn

Usage

mm24kresogen_dbconn()
mm24kresogen_dbfile()
mm24kresogen_dbschema(file="", show.indices=FALSE)
mm24kresogen_dbInfo()

23

Arguments

file

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

mm24kresogen_dbconn returns a connection object to the package annotation DB. IMPORTANT:
Don’t call dbDisconnect on the connection object returned by mm24kresogen_dbconn or you will
break all the AnnDbObj objects defined in this package!

mm24kresogen_dbfile returns the path (character string) to the package annotation DB (this is an
SQLite file).

mm24kresogen_dbschema prints the schema definition of the package annotation DB.

mm24kresogen_dbInfo prints other information about the package annotation DB.

Value

mm24kresogen_dbconn: a DBIConnection object representing an open connection to the package
annotation DB.

mm24kresogen_dbfile: a character string with the path to the package annotation DB.

mm24kresogen_dbschema: none (invisible NULL).

mm24kresogen_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

## Count the number of rows in the "probes" table:
dbGetQuery(mm24kresogen_dbconn(), "SELECT COUNT(*) FROM probes")

## The connection object returned by mm24kresogen_dbconn() was
## created with:
dbConnect(SQLite(), dbname=mm24kresogen_dbfile(), cache_size=64000,
synchronous=0)

mm24kresogen_dbschema()

mm24kresogen_dbInfo()

Index

∗ datasets

mm24kresogen.db, 2
mm24kresogen_dbconn, 22
mm24kresogenACCNUM, 1
mm24kresogenALIAS2PROBE, 2
mm24kresogenCHR, 3
mm24kresogenCHRLENGTHS, 3
mm24kresogenCHRLOC, 4
mm24kresogenENSEMBL, 4
mm24kresogenENTREZID, 5
mm24kresogenENZYME, 6
mm24kresogenENZYME2PROBE, 7
mm24kresogenGENENAME, 8
mm24kresogenGO, 9
mm24kresogenGO2ALLPROBES, 10
mm24kresogenGO2PROBE, 11
mm24kresogenMAP, 12
mm24kresogenMAPCOUNTS, 13
mm24kresogenMGI, 14
mm24kresogenORGANISM, 14
mm24kresogenPATH, 15
mm24kresogenPATH2PROBE, 16
mm24kresogenPFAM, 16
mm24kresogenPMID, 17
mm24kresogenPMID2PROBE, 18
mm24kresogenPROSITE, 19
mm24kresogenREFSEQ, 19
mm24kresogenSYMBOL, 20
mm24kresogenUNIGENE, 21
mm24kresogenUNIPROT, 22

∗ utilities

mm24kresogen_dbconn, 22

AnnDbObj, 23

cat, 23
checkMAPCOUNTS, 13
count.mappedkeys, 13

dbconn, 23
dbConnect, 23
dbDisconnect, 23
dbfile, 23
dbGetQuery, 23

dbInfo, 23
dbschema, 23

mappedkeys, 13
mm24kresogen (mm24kresogen.db), 2
mm24kresogen.db, 2
mm24kresogen_dbconn, 22
mm24kresogen_dbfile

(mm24kresogen_dbconn), 22

mm24kresogen_dbInfo

(mm24kresogen_dbconn), 22

mm24kresogen_dbschema

(mm24kresogen_dbconn), 22

mm24kresogenACCNUM, 1
mm24kresogenALIAS2PROBE, 2
mm24kresogenCHR, 3
mm24kresogenCHRLENGTHS, 3
mm24kresogenCHRLOC, 4
mm24kresogenCHRLOCEND

(mm24kresogenCHRLOC), 4

mm24kresogenENSEMBL, 4
mm24kresogenENSEMBL2PROBE

(mm24kresogenENSEMBL), 4

mm24kresogenENTREZID, 5
mm24kresogenENZYME, 6
mm24kresogenENZYME2PROBE, 7
mm24kresogenGENENAME, 8
mm24kresogenGO, 9
mm24kresogenGO2ALLPROBES, 10
mm24kresogenGO2PROBE, 11
mm24kresogenLOCUSID

(mm24kresogenENTREZID), 5

mm24kresogenMAP, 12
mm24kresogenMAPCOUNTS, 13
mm24kresogenMGI, 14
mm24kresogenMGI2PROBE

(mm24kresogenMGI), 14

mm24kresogenORGANISM, 14
mm24kresogenORGPKG

(mm24kresogenORGANISM), 14

mm24kresogenPATH, 15
mm24kresogenPATH2PROBE, 16
mm24kresogenPFAM, 16
mm24kresogenPMID, 17

24

INDEX

mm24kresogenPMID2PROBE, 18
mm24kresogenPROSITE, 19
mm24kresogenREFSEQ, 19
mm24kresogenSYMBOL, 20
mm24kresogenUNIGENE, 21
mm24kresogenUNIPROT, 22
mm24kresogenUNIPROT2PROBE

(mm24kresogenUNIPROT), 22

25

