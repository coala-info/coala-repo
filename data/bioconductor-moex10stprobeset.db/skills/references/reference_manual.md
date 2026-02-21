moex10stprobeset.db

February 11, 2026

moex10stprobesetACCNUM

Map Manufacturer identifiers to Accession Numbers

Description

moex10stprobesetACCNUM is an R object that contains mappings between a manufacturer’s iden-
tifiers and manufacturers accessions.

Details

For chip packages such as this, the ACCNUM mapping comes directly from the manufacturer. This
is different from other mappings which are mapped onto the probes via an Entrez Gene identifier.

Each manufacturer identifier maps to a vector containing a GenBank accession number.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2021-Apr14

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- moex10stprobesetACCNUM
# Get the probe identifiers that are mapped to an ACCNUM
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the ACCNUM for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

1

2

moex10stprobeset.db

moex10stprobesetALIAS2PROBE

Map between Common Gene Symbol Identifiers and Manufacturer
Identifiers

Description

moex10stprobesetALIAS is an R object that provides mappings between common gene symbol
identifiers and manufacturer identifiers.

Details

Each gene symbol is mapped to a named vector of manufacturer identifiers. The name represents
the gene symbol and the vector contains all manufacturer identifiers that are found for that symbol.
An NA is reported for any gene symbol that cannot be mapped to any manufacturer identifiers.
This mapping includes ALL gene symbols including those which are already listed in the SYMBOL
map. The SYMBOL map is meant to only list official gene symbols, while the ALIAS maps are
meant to store all used symbols.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2021-Apr14

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
# Convert the object to a list
xx <- as.list(moex10stprobesetALIAS2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two aliases
xx[1:2]
# Get the first one
xx[[1]]

}

moex10stprobeset.db

Bioconductor annotation data package

Description

Welcome to the moex10stprobeset.db annotation Package. The purpose of this package is to provide
detailed information about the moex10stprobeset platform. This package is updated biannually.
Objects in this package are accessed using the select() interface. See ?select in the AnnotationDbi
package for details.

moex10stprobesetCHR

See Also

3

• AnnotationDb-class for use of keys(), columns() and select().

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
columns(moex10stprobeset.db)

## Bimap interface:
## The 'old style' of interacting with these objects is manipulation as
## bimaps. While this approach is still available we strongly encourage the
## use of select().
ls("package:moex10stprobeset.db")

moex10stprobesetCHR

Map Manufacturer IDs to Chromosomes

Description

moex10stprobesetCHR is an R object that provides mappings between a manufacturer identifier and
the chromosome that contains the gene of interest.

Details

Each manufacturer identifier maps to a vector of chromosomes. Due to inconsistencies that may
exist at the time the object was built, the vector may contain more than one chromosome (e.g., the
identifier may map to more than one chromosome). If the chromosomal location is unknown, the
vector will contain an NA.
Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2021-Apr14

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- moex10stprobesetCHR
# Get the probe identifiers that are mapped to a chromosome
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the CHR for the first five probes
xx[1:5]
# Get the first one

4

xx[[1]]

}

moex10stprobesetCHRLOC

moex10stprobesetCHRLENGTHS

A named vector for the length of each of the chromosomes

Description

moex10stprobesetCHRLENGTHS provides the length measured in base pairs for each of the chro-
mosomes.

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
tt <- moex10stprobesetCHRLENGTHS
# Length of chromosome 1
tt["1"]

moex10stprobesetCHRLOC

Map Manufacturer IDs to Chromosomal Location

Description

moex10stprobesetCHRLOC is an R object that maps manufacturer identifiers to the starting position
of the gene. The position of a gene is measured as the number of base pairs.

The CHRLOCEND mapping is the same as the CHRLOC mapping except that it specifies the
ending base of a gene instead of the start.

moex10stprobesetENSEMBL

5

Details

Each manufacturer identifier maps to a named vector of chromosomal locations, where the name
indicates the chromosome. Due to inconsistencies that may exist at the time the object was built,
these vectors may contain more than one chromosome and/or location. If the chromosomal location
is unknown, the vector will contain an NA.

Chromosomal locations on both the sense and antisense strands are measured as the number of base
pairs from the p (5’ end of the sense strand) to q (3’ end of the sense strand) arms. Chromosomal
locations on the antisense strand have a leading "-" sign (e. g. -1234567).

Since some genes have multiple start sites, this field can map to multiple locations.

Mappings were based on data provided by: UCSC Genome Bioinformatics (Mus musculus)

With a date stamp from the source of: 2021-Feb16

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- moex10stprobesetCHRLOC
# Get the probe identifiers that are mapped to chromosome locations
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the CHRLOC for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

moex10stprobesetENSEMBL

Map Ensembl gene accession numbers with Entrez Gene identifiers

Description

moex10stprobesetENSEMBL is an R object that contains mappings between manufacturer identi-
fiers and Ensembl gene accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to Ensembl gene Accession Numbers.
Mappings were based on data provided by BOTH of these sources: http://www.ensembl.org/
biomart/martview/ ftp://ftp.ncbi.nlm.nih.gov/gene/DATA

6

moex10stprobesetENTREZID

For most species, this mapping is a combination of manufacturer to ensembl IDs from BOTH
NCBI and ensembl. Users who wish to only use mappings from NCBI are encouraged to see
the ncbi2ensembl table in the appropriate organism package. Users who wish to only use mappings
from ensembl are encouraged to see the ensembl2ncbi table which is also found in the appropriate
organism packages. These mappings are based upon the ensembl table which is contains data from
BOTH of these sources in an effort to maximize the chances that you will find a match.

For worms and flies however, this mapping is based only on sources from ensembl, as these organ-
isms do not have ensembl to entrez gene mapping data at NCBI.

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- moex10stprobesetENSEMBL
# Get the entrez gene IDs that are mapped to an Ensembl ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0) {

# Get the Ensembl gene IDs for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}
#For the reverse map ENSEMBL2PROBE:
x <- moex10stprobesetENSEMBL2PROBE
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

moex10stprobesetENTREZID

Map between Manufacturer Identifiers and Entrez Gene

Description

moex10stprobesetENTREZID is an R object that provides mappings between manufacturer identi-
fiers and Entrez Gene identifiers.

moex10stprobesetENZYME

Details

7

Each manufacturer identifier is mapped to a vector of Entrez Gene identifiers. An NA is assigned to
those manufacturer identifiers that can not be mapped to an Entrez Gene identifier at this time.

If a given manufacturer identifier can be mapped to different Entrez Gene identifiers from various
sources, we attempt to select the common identifiers. If a concensus cannot be determined, we
select the smallest identifier.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2021-Apr14

References

https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- moex10stprobesetENTREZID
# Get the probe identifiers that are mapped to an ENTREZ Gene ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the ENTREZID for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

moex10stprobesetENZYME

Maps between Manufacturer IDs and Enzyme Commission (EC) Num-
bers

Description

moex10stprobesetENZYME is an R object that provides mappings between manufacturer iden-
tifiers and EC numbers. moex10stprobesetENZYME2PROBE is an R object that maps Enzyme
Commission (EC) numbers to manufacturer identifiers.

8

Details

moex10stprobesetENZYME

When the moex10stprobesetENZYME maping viewed as a list, each manufacturer identifier maps
to a named vector containing the EC number that corresponds to the enzyme produced by that gene.
The names corresponds to the manufacturer identifiers. If this information is unknown, the vector
will contain an NA.
For the moex10stprobesetENZYME2PROBE, each EC number maps to a named vector containing
all of the manufacturer identifiers that correspond to the gene that produces that enzyme. The name
of the vector corresponds to the EC number.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In moex10stprobesetENZYME2PROBE, EC is dropped from the Enzyme Commission
numbers.

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

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- moex10stprobesetENZYME
# Get the probe identifiers that are mapped to an EC number
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:3])
if(length(xx) > 0) {

moex10stprobesetGENENAME

9

# Get the ENZYME for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

# Now convert moex10stprobesetENZYME2PROBE to a list to see inside
x <- moex10stprobesetENZYME2PROBE
mapped_probes <- mappedkeys(x)
## convert to a list
xx <- as.list(x[mapped_probes][1:3])
if(length(xx) > 0){

# Get the probe identifiers for the first five enzyme
#commission numbers
xx[1:5]
# Get the first one
xx[[1]]

}

moex10stprobesetGENENAME

Map between Manufacturer IDs and Genes

Description

moex10stprobesetGENENAME is an R object that maps manufacturer identifiers to the correspond-
ing gene name.

Details

Each manufacturer identifier maps to a named vector containing the gene name. The vector name
corresponds to the manufacturer identifier. If the gene name is unknown, the vector will contain an
NA.
Gene names currently include both the official (validated by a nomenclature committee) and pre-
ferred names (interim selected for display) for genes. Efforts are being made to differentiate the
two by adding a name to the vector.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2021-Apr14

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- moex10stprobesetGENENAME
# Get the probe identifiers that are mapped to a gene name
mapped_probes <- mappedkeys(x)

10

moex10stprobesetGO

# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the GENENAME for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

moex10stprobesetGO

Maps between manufacturer IDs and Gene Ontology (GO) IDs

Description

moex10stprobesetGO is an R object that provides mappings between manufacturer identifiers and
the GO identifiers that they are directly associated with. This mapping and its reverse mapping
(moex10stprobesetGO2PROBE) do NOT associate the child terms from the GO ontology with the
gene. Only the directly evidenced terms are represented here.

moex10stprobesetGO2ALLPROBES is an R object that provides mappings between a given GO
identifier and all of the manufacturer identifiers annotated at that GO term OR TO ONE OF IT’S
CHILD NODES in the GO ontology. Thus, this mapping is much larger and more inclusive than
moex10stprobesetGO2PROBE.

Details

If moex10stprobesetGO is cast as a list, each manufacturer identifier is mapped to a list of lists. The
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

ISS: inferred from sequence similarity

IDA: inferred from direct assay

IEP: inferred from expression pattern

IEA: inferred from electronic annotation

TAS: traceable author statement

NAS: non-traceable author statement

ND: no biological data available

IC: inferred by curator

moex10stprobesetGO

11

A more complete listing of evidence codes can be found at:
http://www.geneontology.org/GO.evidence.shtml

If moex10stprobesetGO2ALLPROBES or moex10stprobesetGO2PROBE is cast as a list, each GO
term maps to a named vector of manufacturer identifiers and evidence codes. A GO identifier
may be mapped to the same manufacturer identifier more than once but the evidence code can
be different. Mappings between Gene Ontology identifiers and Gene Ontology terms and other
information are available in a separate data package named GO.

Whenever any of these mappings are cast as a data.frame, all the results will be output in an appro-
priate tabular form.

Mappings between manufacturer identifiers and GO information were obtained through their map-
pings to manufacturer identifiers. NAs are assigned to manufacturer identifiers that can not be
mapped to any Gene Ontology information. Mappings between Gene Ontology identifiers an Gene
Ontology terms and other information are available in a separate data package named GO.

All mappings were based on data provided by: Gene Ontology http://current.geneontology.org/ontology/go-
basic.obo With a date stamp from the source of: 2021-02-01

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

See Also

• moex10stprobesetGO2ALLPROBES
• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- moex10stprobesetGO
# Get the manufacturer identifiers that are mapped to a GO ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0) {

# Try the first one
got <- xx[[1]]
got[[1]][["GOID"]]
got[[1]][["Ontology"]]
got[[1]][["Evidence"]]

}
# For the reverse map:
x <- moex10stprobesetGO2PROBE
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){

# Gets the manufacturer ids for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets the manufacturer ids for the first element of goids

12

}

goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

moex10stprobesetMGI

x <- moex10stprobesetGO2ALLPROBES
mapped_genes <- mappedkeys(x)
# Convert moex10stprobesetGO2ALLPROBES to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){
# Gets the manufacturer identifiers for the top 2nd and 3nd GO identifiers

goids <- xx[2:3]
# Gets all the manufacturer identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

moex10stprobesetMAPCOUNTS

Number of mapped keys for the maps in package moex10stprobeset.db

Description

DEPRECATED. Counts in the MAPCOUNT table are out of sync and should not be used.

moex10stprobesetMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each
map in package moex10stprobeset.db.

Details

DEPRECATED. Counts in the MAPCOUNT table are out of sync and should not be used.

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

moex10stprobesetMGI

Map MGI gene accession numbers with manufacturer identifiers

Description

moex10stprobesetMGI is an R object that contains mappings between manufacturer identifiers and
Jackson Laboratory MGI gene accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to MGI gene Accession Numbers.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2021-Apr14

moex10stprobesetORGANISM

13

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- moex10stprobesetMGI
# Get the manufacturer IDs that are mapped to an MGI ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0) {

# Get the MGI IDs for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}
#For the reverse map MGI2EG:
x <- moex10stprobesetMGI2PROBE
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){

# Gets the manufacturer IDs for the first five MGI IDs
xx[1:5]
# Get the first one
xx[[1]]

}

moex10stprobesetORGANISM

The Organism information for moex10stprobeset

Description

moex10stprobesetORGANISM is an R object that contains a single item: a character string that
names the organism for which moex10stprobeset was built. moex10stprobesetORGPKG is an R
object that contains a chararcter vector with the name of the organism package that a chip package
depends on for its gene-centric annotation.

Details

Although the package name is suggestive of the organism for which it was built, moex10stprobesetORGANISM
provides a simple way to programmatically extract the organism name. moex10stprobesetORGPKG
provides a simple way to programmatically extract the name of the parent organism package. The
parent organism package is a strict dependency for chip packages as this is where the gene cetric
information is ultimately extracted from. The full package name will always be this string plus the
extension ".db". But most programatic acces will not require this extension, so its more convenient
to leave it out.

14

See Also

moex10stprobesetPATH

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
moex10stprobesetORGANISM
moex10stprobesetORGPKG

moex10stprobesetPATH Mappings between probe identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms.

moex10stprobesetPATH maps probe identifiers to the identifiers used by KEGG for pathways in
which the genes represented by the probe identifiers are involved

moex10stprobesetPATH2PROBE is an R object that provides mappings between KEGG identifiers
and manufacturer identifiers.

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
x <- moex10stprobesetPATH

moex10stprobesetPFAM

15

# Get the probe identifiers that are mapped to a KEGG pathway ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the PATH for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

x <- moex10stprobesetPATH
mapped_probes <- mappedkeys(x)
# Now convert the moex10stprobesetPATH2PROBE object to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0){

# Get the probe identifiers for the first two pathway identifiers
xx[1:2]
# Get the first one
xx[[1]]

}

moex10stprobesetPFAM Maps between Manufacturer Identifiers and PFAM Identifiers

Description

moex10stprobesetPFAM is an R object that provides mappings between manufacturer identifiers
and PFAM identifiers.

Details

The bimap interface for PFAM is defunct. Please use select() interface to PFAM identifiers. See
?AnnotationDbi::select for details.

moex10stprobesetPMID Maps between Manufacturer Identifiers and PubMed Identifiers

Description

moex10stprobesetPMID is an R object that provides mappings between manufacturer identifiers
and PubMed identifiers. moex10stprobesetPMID2PROBE is an R object that provides mappings
between PubMed identifiers and manufacturer identifiers.

Details

When moex10stprobesetPMID is viewed as a list each manufacturer identifier is mapped to a named
vector of PubMed identifiers. The name associated with each vector corresponds to the manufac-
turer identifier. The length of the vector may be one or greater, depending on how many PubMed
identifiers a given manufacturer identifier is mapped to. An NA is reported for any manufacturer
identifier that cannot be mapped to a PubMed identifier.

16

moex10stprobesetPMID

When moex10stprobesetPMID2PROBE is viewed as a list each PubMed identifier is mapped to a
named vector of manufacturer identifiers. The name represents the PubMed identifier and the vector
contains all manufacturer identifiers that are represented by that PubMed identifier. The length of
the vector may be one or longer, depending on how many manufacturer identifiers are mapped to a
given PubMed identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2021-Apr14

References

https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=PubMed

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- moex10stprobesetPMID
# Get the probe identifiers that are mapped to any PubMed ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
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

x <- moex10stprobesetPMID2PROBE
mapped_probes <- mappedkeys(x)
# Now convert the reverse map object moex10stprobesetPMID2PROBE to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0){

# Get the probe identifiers for the first two PubMed identifiers
xx[1:2]
# Get the first one
xx[[1]]
if(interactive() && require(annotate)){

# Get article information as XML files for a PubMed id

moex10stprobesetPROSITE

17

xmls <- pubmed(names(xx)[1], disp = "data")
# View article information using a browser
pubmed(names(xx)[1], disp = "browser")

}

}

moex10stprobesetPROSITE

Maps between Manufacturer Identifiers and PROSITE Identifiers

Description

moex10stprobesetPROSITE is an R object that provides mappings between manufacturer identifiers
and PROSITE identifiers.

Details

The bimap interface for PROSITE is defunct. Please use select() interface to PROSITE identifiers.
See ?AnnotationDbi::select for details.

moex10stprobesetREFSEQ

Map between Manufacturer Identifiers and RefSeq Identifiers

Description

moex10stprobesetREFSEQ is an R object that provides mappings between manufacturer identifiers
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

18

moex10stprobesetSYMBOL

NCBI https://www.ncbi.nlm.nih.gov/RefSeq/ allows users to query the RefSeq database us-
ing RefSeq identifiers.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2021-Apr14

References

https://www.ncbi.nlm.nih.gov https://www.ncbi.nlm.nih.gov/RefSeq/

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- moex10stprobesetREFSEQ
# Get the probe identifiers that are mapped to any RefSeq ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the REFSEQ for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

moex10stprobesetSYMBOL

Map between Manufacturer Identifiers and Gene Symbols

Description

moex10stprobesetSYMBOL is an R object that provides mappings between manufacturer identifiers
and gene abbreviations.

Details

Each manufacturer identifier is mapped to an abbreviation for the corresponding gene. An NA is
reported if there is no known abbreviation for a given gene.

Symbols typically consist of 3 letters that define either a single gene (ABC) or multiple genes
(ABC1, ABC2, ABC3). Gene symbols can be used as key words to query public databases such as
Entrez Gene.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2021-Apr14

19

moex10stprobesetUNIPROT

References

https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- moex10stprobesetSYMBOL
# Get the probe identifiers that are mapped to a gene symbol
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the SYMBOL for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

moex10stprobesetUNIPROT

Map Uniprot accession numbers with Entrez Gene identifiers

Description

moex10stprobesetUNIPROT is an R object that contains mappings between the manufacturer iden-
tifiers and Uniprot accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to Uniprot Accessions.

Mappings were based on data provided by NCBI (link above) with an exception for fly, which
required retrieving the data from ensembl http://www.ensembl.org/biomart/martview/

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- moex10stprobesetUNIPROT

20

moex10stprobeset_dbconn

# Get the entrez gene IDs that are mapped to an Uniprot ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0) {

# Get the Uniprot IDs for the first five genes
xx[1:5]
# Get the first one
xx[[1]]

}

moex10stprobeset_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

moex10stprobeset_dbconn()
moex10stprobeset_dbfile()
moex10stprobeset_dbschema(file="", show.indices=FALSE)
moex10stprobeset_dbInfo()

Arguments

file

show.indices

Details

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).
The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

moex10stprobeset_dbconn returns a connection object to the package annotation DB. IMPOR-
TANT: Don’t call dbDisconnect on the connection object returned by moex10stprobeset_dbconn
or you will break all the AnnDbObj objects defined in this package!
moex10stprobeset_dbfile returns the path (character string) to the package annotation DB (this
is an SQLite file).
moex10stprobeset_dbschema prints the schema definition of the package annotation DB.
moex10stprobeset_dbInfo prints other information about the package annotation DB.

Value

moex10stprobeset_dbconn: a DBIConnection object representing an open connection to the pack-
age annotation DB.
moex10stprobeset_dbfile: a character string with the path to the package annotation DB.
moex10stprobeset_dbschema: none (invisible NULL).
moex10stprobeset_dbInfo: none (invisible NULL).

moex10stprobeset_dbconn

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

library(DBI)
## Count the number of rows in the "probes" table:
dbGetQuery(moex10stprobeset_dbconn(), "SELECT COUNT(*) FROM probes")

21

moex10stprobeset_dbschema()

moex10stprobeset_dbInfo()

Index

∗ datasets

moex10stprobeset.db, 2
moex10stprobeset_dbconn, 20
moex10stprobesetACCNUM, 1
moex10stprobesetALIAS2PROBE, 2
moex10stprobesetCHR, 3
moex10stprobesetCHRLENGTHS, 4
moex10stprobesetCHRLOC, 4
moex10stprobesetENSEMBL, 5
moex10stprobesetENTREZID, 6
moex10stprobesetENZYME, 7
moex10stprobesetGENENAME, 9
moex10stprobesetGO, 10
moex10stprobesetMAPCOUNTS, 12
moex10stprobesetMGI, 12
moex10stprobesetORGANISM, 13
moex10stprobesetPATH, 14
moex10stprobesetPFAM, 15
moex10stprobesetPMID, 15
moex10stprobesetPROSITE, 17
moex10stprobesetREFSEQ, 17
moex10stprobesetSYMBOL, 18
moex10stprobesetUNIPROT, 19

∗ utilities

moex10stprobeset_dbconn, 20

AnnDbObj, 20

cat, 20
checkMAPCOUNTS, 12

dbconn, 21
dbConnect, 21
dbDisconnect, 20
dbfile, 21
dbGetQuery, 21
dbInfo, 21
dbschema, 21

moex10stprobeset (moex10stprobeset.db),

2

moex10stprobeset.db, 2
moex10stprobeset_dbconn, 20
moex10stprobeset_dbfile

(moex10stprobeset_dbconn), 20

22

moex10stprobeset_dbInfo

(moex10stprobeset_dbconn), 20

moex10stprobeset_dbschema

(moex10stprobeset_dbconn), 20

moex10stprobesetACCNUM, 1
moex10stprobesetALIAS2PROBE, 2
moex10stprobesetCHR, 3
moex10stprobesetCHRLENGTHS, 4
moex10stprobesetCHRLOC, 4
moex10stprobesetCHRLOCEND

(moex10stprobesetCHRLOC), 4

moex10stprobesetENSEMBL, 5
moex10stprobesetENSEMBL2PROBE

(moex10stprobesetENSEMBL), 5

moex10stprobesetENTREZID, 6
moex10stprobesetENZYME, 7
moex10stprobesetENZYME2PROBE

(moex10stprobesetENZYME), 7

moex10stprobesetGENENAME, 9
moex10stprobesetGO, 10
moex10stprobesetGO2ALLPROBES, 11
moex10stprobesetGO2ALLPROBES

(moex10stprobesetGO), 10

moex10stprobesetGO2PROBE

(moex10stprobesetGO), 10

moex10stprobesetLOCUSID

(moex10stprobesetENTREZID), 6

moex10stprobesetMAPCOUNTS, 12
moex10stprobesetMGI, 12
moex10stprobesetMGI2PROBE

(moex10stprobesetMGI), 12

moex10stprobesetORGANISM, 13
moex10stprobesetORGPKG

(moex10stprobesetORGANISM), 13

moex10stprobesetPATH, 14
moex10stprobesetPATH2PROBE

(moex10stprobesetPATH), 14

moex10stprobesetPFAM, 15
moex10stprobesetPMID, 15
moex10stprobesetPMID2PROBE

(moex10stprobesetPMID), 15

moex10stprobesetPROSITE, 17
moex10stprobesetREFSEQ, 17

INDEX

23

moex10stprobesetSYMBOL, 18
moex10stprobesetUNIPROT, 19
moex10stprobesetUNIPROT2PROBE

(moex10stprobesetUNIPROT), 19

