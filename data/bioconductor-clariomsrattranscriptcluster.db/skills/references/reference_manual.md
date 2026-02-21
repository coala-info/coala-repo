clariomsrattranscriptcluster.db

February 11, 2026

clariomsrattranscriptclusterACCNUM

Map Manufacturer identifiers to Accession Numbers

Description

clariomsrattranscriptclusterACCNUM is an R object that contains mappings between a manufac-
turer’s identifiers and manufacturers accessions.

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
x <- clariomsrattranscriptclusterACCNUM
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

clariomsrattranscriptcluster.db

clariomsrattranscriptclusterALIAS2PROBE

Map between Common Gene Symbol Identifiers and Manufacturer
Identifiers

Description

clariomsrattranscriptclusterALIAS is an R object that provides mappings between common gene
symbol identifiers and manufacturer identifiers.

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
xx <- as.list(clariomsrattranscriptclusterALIAS2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two aliases
xx[1:2]
# Get the first one
xx[[1]]

}

clariomsrattranscriptcluster.db

Bioconductor annotation data package

Description

Welcome to the clariomsrattranscriptcluster.db annotation Package. The purpose of this package
is to provide detailed information about the clariomsrattranscriptcluster platform. This package is
updated biannually.
Objects in this package are accessed using the select() interface. See ?select in the AnnotationDbi
package for details.

clariomsrattranscriptclusterCHR

3

See Also

• AnnotationDb-class for use of keys(), columns() and select().

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
columns(clariomsrattranscriptcluster.db)

## Bimap interface:
## The 'old style' of interacting with these objects is manipulation as
## bimaps. While this approach is still available we strongly encourage the
## use of select().
ls("package:clariomsrattranscriptcluster.db")

clariomsrattranscriptclusterCHR

Map Manufacturer IDs to Chromosomes

Description

clariomsrattranscriptclusterCHR is an R object that provides mappings between a manufacturer
identifier and the chromosome that contains the gene of interest.

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
x <- clariomsrattranscriptclusterCHR
# Get the probe identifiers that are mapped to a chromosome
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the CHR for the first five probes
xx[1:5]

4

clariomsrattranscriptclusterCHRLOC

# Get the first one
xx[[1]]

}

clariomsrattranscriptclusterCHRLENGTHS

A named vector for the length of each of the chromosomes

Description

clariomsrattranscriptclusterCHRLENGTHS provides the length measured in base pairs for each of
the chromosomes.

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
tt <- clariomsrattranscriptclusterCHRLENGTHS
# Length of chromosome 1
tt["1"]

clariomsrattranscriptclusterCHRLOC

Map Manufacturer IDs to Chromosomal Location

Description

clariomsrattranscriptclusterCHRLOC is an R object that maps manufacturer identifiers to the start-
ing position of the gene. The position of a gene is measured as the number of base pairs.

The CHRLOCEND mapping is the same as the CHRLOC mapping except that it specifies the
ending base of a gene instead of the start.

clariomsrattranscriptclusterENSEMBL

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

Mappings were based on data provided by: UCSC Genome Bioinformatics (Rattus norvegicus)

With a date stamp from the source of: 2021-Mar15

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- clariomsrattranscriptclusterCHRLOC
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

clariomsrattranscriptclusterENSEMBL

Map Ensembl gene accession numbers with Entrez Gene identifiers

Description

clariomsrattranscriptclusterENSEMBL is an R object that contains mappings between manufacturer
identifiers and Ensembl gene accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to Ensembl gene Accession Numbers.
Mappings were based on data provided by BOTH of these sources: http://www.ensembl.org/
biomart/martview/ ftp://ftp.ncbi.nlm.nih.gov/gene/DATA

6

clariomsrattranscriptclusterENTREZID

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
x <- clariomsrattranscriptclusterENSEMBL
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
x <- clariomsrattranscriptclusterENSEMBL2PROBE
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

clariomsrattranscriptclusterENTREZID

Map between Manufacturer Identifiers and Entrez Gene

Description

clariomsrattranscriptclusterENTREZID is an R object that provides mappings between manufac-
turer identifiers and Entrez Gene identifiers.

clariomsrattranscriptclusterENZYME

7

Details

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
x <- clariomsrattranscriptclusterENTREZID
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

clariomsrattranscriptclusterENZYME

Maps between Manufacturer IDs and Enzyme Commission (EC) Num-
bers

Description

clariomsrattranscriptclusterENZYME is an R object that provides mappings between manufacturer
identifiers and EC numbers. clariomsrattranscriptclusterENZYME2PROBE is an R object that
maps Enzyme Commission (EC) numbers to manufacturer identifiers.

8

Details

clariomsrattranscriptclusterENZYME

When the clariomsrattranscriptclusterENZYME maping viewed as a list, each manufacturer identi-
fier maps to a named vector containing the EC number that corresponds to the enzyme produced by
that gene. The names corresponds to the manufacturer identifiers. If this information is unknown,
the vector will contain an NA.
For the clariomsrattranscriptclusterENZYME2PROBE, each EC number maps to a named vector
containing all of the manufacturer identifiers that correspond to the gene that produces that enzyme.
The name of the vector corresponds to the EC number.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In clariomsrattranscriptclusterENZYME2PROBE, EC is dropped from the Enzyme Com-
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
x <- clariomsrattranscriptclusterENZYME
# Get the probe identifiers that are mapped to an EC number
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:3])
if(length(xx) > 0) {

clariomsrattranscriptclusterGENENAME

9

# Get the ENZYME for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

# Now convert clariomsrattranscriptclusterENZYME2PROBE to a list to see inside
x <- clariomsrattranscriptclusterENZYME2PROBE
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

clariomsrattranscriptclusterGENENAME

Map between Manufacturer IDs and Genes

Description

clariomsrattranscriptclusterGENENAME is an R object that maps manufacturer identifiers to the
corresponding gene name.

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
x <- clariomsrattranscriptclusterGENENAME
# Get the probe identifiers that are mapped to a gene name
mapped_probes <- mappedkeys(x)

10

clariomsrattranscriptclusterGO

# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the GENENAME for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

clariomsrattranscriptclusterGO

Maps between manufacturer IDs and Gene Ontology (GO) IDs

Description

clariomsrattranscriptclusterGO is an R object that provides mappings between manufacturer iden-
tifiers and the GO identifiers that they are directly associated with. This mapping and its reverse
mapping (clariomsrattranscriptclusterGO2PROBE) do NOT associate the child terms from the GO
ontology with the gene. Only the directly evidenced terms are represented here.

clariomsrattranscriptclusterGO2ALLPROBES is an R object that provides mappings between a
given GO identifier and all of the manufacturer identifiers annotated at that GO term OR TO ONE
OF IT’S CHILD NODES in the GO ontology. Thus, this mapping is much larger and more inclusive
than clariomsrattranscriptclusterGO2PROBE.

Details

If clariomsrattranscriptclusterGO is cast as a list, each manufacturer identifier is mapped to a list
of lists. The names on the outer list are GO identifiers. Each inner list consists of three named
elements: GOID, Ontology, and Evidence.

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

clariomsrattranscriptclusterGO

11

A more complete listing of evidence codes can be found at:
http://www.geneontology.org/GO.evidence.shtml

If clariomsrattranscriptclusterGO2ALLPROBES or clariomsrattranscriptclusterGO2PROBE is cast
as a list, each GO term maps to a named vector of manufacturer identifiers and evidence codes. A
GO identifier may be mapped to the same manufacturer identifier more than once but the evidence
code can be different. Mappings between Gene Ontology identifiers and Gene Ontology terms and
other information are available in a separate data package named GO.

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

• clariomsrattranscriptclusterGO2ALLPROBES
• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- clariomsrattranscriptclusterGO
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
x <- clariomsrattranscriptclusterGO2PROBE
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

clariomsrattranscriptclusterORGANISM

x <- clariomsrattranscriptclusterGO2ALLPROBES
mapped_genes <- mappedkeys(x)
# Convert clariomsrattranscriptclusterGO2ALLPROBES to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){
# Gets the manufacturer identifiers for the top 2nd and 3nd GO identifiers

goids <- xx[2:3]
# Gets all the manufacturer identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

clariomsrattranscriptclusterMAPCOUNTS

Number of mapped keys for the maps in package clariomsrattran-
scriptcluster.db

Description

DEPRECATED. Counts in the MAPCOUNT table are out of sync and should not be used.

clariomsrattranscriptclusterMAPCOUNTS provides the "map count" (i.e.
keys) for each map in package clariomsrattranscriptcluster.db.

the count of mapped

Details

DEPRECATED. Counts in the MAPCOUNT table are out of sync and should not be used.

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

clariomsrattranscriptclusterORGANISM

The Organism information for clariomsrattranscriptcluster

Description

clariomsrattranscriptclusterORGANISM is an R object that contains a single item: a character string
that names the organism for which clariomsrattranscriptcluster was built. clariomsrattranscriptclus-
terORGPKG is an R object that contains a chararcter vector with the name of the organism package
that a chip package depends on for its gene-centric annotation.

clariomsrattranscriptclusterPATH

13

Details

Although the package name is suggestive of the organism for which it was built, clariomsrattran-
scriptclusterORGANISM provides a simple way to programmatically extract the organism name.
clariomsrattranscriptclusterORGPKG provides a simple way to programmatically extract the name
of the parent organism package. The parent organism package is a strict dependency for chip pack-
ages as this is where the gene cetric information is ultimately extracted from. The full package name
will always be this string plus the extension ".db". But most programatic acces will not require this
extension, so its more convenient to leave it out.

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
clariomsrattranscriptclusterORGANISM
clariomsrattranscriptclusterORGPKG

clariomsrattranscriptclusterPATH

Mappings between probe identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms.

clariomsrattranscriptclusterPATH maps probe identifiers to the identifiers used by KEGG for path-
ways in which the genes represented by the probe identifiers are involved

clariomsrattranscriptclusterPATH2PROBE is an R object that provides mappings between KEGG
identifiers and manufacturer identifiers.

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

14

See Also

clariomsrattranscriptclusterPFAM

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- clariomsrattranscriptclusterPATH
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

x <- clariomsrattranscriptclusterPATH
mapped_probes <- mappedkeys(x)
# Now convert the clariomsrattranscriptclusterPATH2PROBE object to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0){

# Get the probe identifiers for the first two pathway identifiers
xx[1:2]
# Get the first one
xx[[1]]

}

clariomsrattranscriptclusterPFAM

Maps between Manufacturer Identifiers and PFAM Identifiers

Description

clariomsrattranscriptclusterPFAM is an R object that provides mappings between manufacturer
identifiers and PFAM identifiers.

Details

The bimap interface for PFAM is defunct. Please use select() interface to PFAM identifiers. See
?AnnotationDbi::select for details.

clariomsrattranscriptclusterPMID

15

clariomsrattranscriptclusterPMID

Maps between Manufacturer Identifiers and PubMed Identifiers

Description

clariomsrattranscriptclusterPMID is an R object that provides mappings between manufacturer
identifiers and PubMed identifiers. clariomsrattranscriptclusterPMID2PROBE is an R object that
provides mappings between PubMed identifiers and manufacturer identifiers.

Details

When clariomsrattranscriptclusterPMID is viewed as a list each manufacturer identifier is mapped
to a named vector of PubMed identifiers. The name associated with each vector corresponds to
the manufacturer identifier. The length of the vector may be one or greater, depending on how
many PubMed identifiers a given manufacturer identifier is mapped to. An NA is reported for any
manufacturer identifier that cannot be mapped to a PubMed identifier.

When clariomsrattranscriptclusterPMID2PROBE is viewed as a list each PubMed identifier is mapped
to a named vector of manufacturer identifiers. The name represents the PubMed identifier and the
vector contains all manufacturer identifiers that are represented by that PubMed identifier. The
length of the vector may be one or longer, depending on how many manufacturer identifiers are
mapped to a given PubMed identifier.

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
x <- clariomsrattranscriptclusterPMID
# Get the probe identifiers that are mapped to any PubMed ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0){

# Get the PubMed identifiers for the first two probe identifiers
xx[1:2]
# Get the first one

16

clariomsrattranscriptclusterREFSEQ

xx[[1]]
if(interactive() && !is.null(xx[[1]]) && !is.na(xx[[1]])

&& require(annotate)){
# Get article information as XML files
xmls <- pubmed(xx[[1]], disp = "data")
# View article information using a browser
pubmed(xx[[1]], disp = "browser")

}

}

x <- clariomsrattranscriptclusterPMID2PROBE
mapped_probes <- mappedkeys(x)
# Now convert the reverse map object clariomsrattranscriptclusterPMID2PROBE to a list
xx <- as.list(x[mapped_probes][1:300])
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

clariomsrattranscriptclusterPROSITE

Maps between Manufacturer Identifiers and PROSITE Identifiers

Description

clariomsrattranscriptclusterPROSITE is an R object that provides mappings between manufacturer
identifiers and PROSITE identifiers.

Details

The bimap interface for PROSITE is defunct. Please use select() interface to PROSITE identifiers.
See ?AnnotationDbi::select for details.

clariomsrattranscriptclusterREFSEQ

Map between Manufacturer Identifiers and RefSeq Identifiers

Description

clariomsrattranscriptclusterREFSEQ is an R object that provides mappings between manufacturer
identifiers and RefSeq identifiers.

clariomsrattranscriptclusterREFSEQ

17

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
x <- clariomsrattranscriptclusterREFSEQ
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

18

clariomsrattranscriptclusterSYMBOL

clariomsrattranscriptclusterSYMBOL

Map between Manufacturer Identifiers and Gene Symbols

Description

clariomsrattranscriptclusterSYMBOL is an R object that provides mappings between manufacturer
identifiers and gene abbreviations.

Details

Each manufacturer identifier is mapped to an abbreviation for the corresponding gene. An NA is
reported if there is no known abbreviation for a given gene.

Symbols typically consist of 3 letters that define either a single gene (ABC) or multiple genes
(ABC1, ABC2, ABC3). Gene symbols can be used as key words to query public databases such as
Entrez Gene.

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
x <- clariomsrattranscriptclusterSYMBOL
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

clariomsrattranscriptclusterUNIPROT

19

clariomsrattranscriptclusterUNIPROT

Map Uniprot accession numbers with Entrez Gene identifiers

Description

clariomsrattranscriptclusterUNIPROT is an R object that contains mappings between the manufac-
turer identifiers and Uniprot accession numbers.

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
x <- clariomsrattranscriptclusterUNIPROT
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

clariomsrattranscriptcluster_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

20

Usage

clariomsrattranscriptcluster_dbconn

clariomsrattranscriptcluster_dbconn()
clariomsrattranscriptcluster_dbfile()
clariomsrattranscriptcluster_dbschema(file="", show.indices=FALSE)
clariomsrattranscriptcluster_dbInfo()

Arguments

file

show.indices

Details

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).
The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

clariomsrattranscriptcluster_dbconn returns a connection object to the package annotation
DB. IMPORTANT: Don’t call dbDisconnect on the connection object returned by clariomsrattranscriptcluster_dbconn
or you will break all the AnnDbObj objects defined in this package!
clariomsrattranscriptcluster_dbfile returns the path (character string) to the package anno-
tation DB (this is an SQLite file).
clariomsrattranscriptcluster_dbschema prints the schema definition of the package annota-
tion DB.
clariomsrattranscriptcluster_dbInfo prints other information about the package annotation
DB.

Value

clariomsrattranscriptcluster_dbconn: a DBIConnection object representing an open connec-
tion to the package annotation DB.
clariomsrattranscriptcluster_dbfile: a character string with the path to the package anno-
tation DB.
clariomsrattranscriptcluster_dbschema: none (invisible NULL).
clariomsrattranscriptcluster_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

library(DBI)
## Count the number of rows in the "probes" table:
dbGetQuery(clariomsrattranscriptcluster_dbconn(), "SELECT COUNT(*) FROM probes")

clariomsrattranscriptcluster_dbschema()

clariomsrattranscriptcluster_dbInfo()

Index

∗ datasets

AnnDbObj, 20

clariomsrattranscriptcluster.db, 2
clariomsrattranscriptcluster_dbconn,

19

clariomsrattranscriptclusterACCNUM,

1

clariomsrattranscriptclusterALIAS2PROBE,

2

clariomsrattranscriptclusterCHR, 3
clariomsrattranscriptclusterCHRLENGTHS,

4

clariomsrattranscriptclusterCHRLOC,

4

clariomsrattranscriptclusterENSEMBL,

5

clariomsrattranscriptclusterENTREZID,

6

clariomsrattranscriptclusterENZYME,

7

clariomsrattranscriptclusterGENENAME,

9

clariomsrattranscriptclusterGO, 10
clariomsrattranscriptclusterMAPCOUNTS,

12

clariomsrattranscriptclusterORGANISM,

12

clariomsrattranscriptclusterPATH,

13

clariomsrattranscriptclusterPFAM,

14

clariomsrattranscriptclusterPMID,

15

clariomsrattranscriptclusterPROSITE,

16

clariomsrattranscriptclusterREFSEQ,

16

clariomsrattranscriptclusterSYMBOL,

18

clariomsrattranscriptclusterUNIPROT,

cat, 20
checkMAPCOUNTS, 12
clariomsrattranscriptcluster

(clariomsrattranscriptcluster.db),
2

clariomsrattranscriptcluster.db, 2
clariomsrattranscriptcluster_dbconn,

19

clariomsrattranscriptcluster_dbfile

(clariomsrattranscriptcluster_dbconn),
19

clariomsrattranscriptcluster_dbInfo

(clariomsrattranscriptcluster_dbconn),
19

clariomsrattranscriptcluster_dbschema

(clariomsrattranscriptcluster_dbconn),
19

clariomsrattranscriptclusterACCNUM, 1
clariomsrattranscriptclusterALIAS2PROBE,

2

clariomsrattranscriptclusterCHR, 3
clariomsrattranscriptclusterCHRLENGTHS,

4

clariomsrattranscriptclusterCHRLOC, 4
clariomsrattranscriptclusterCHRLOCEND

(clariomsrattranscriptclusterCHRLOC),
4

clariomsrattranscriptclusterENSEMBL, 5
clariomsrattranscriptclusterENSEMBL2PROBE

(clariomsrattranscriptclusterENSEMBL),
5

clariomsrattranscriptclusterENTREZID,

6

clariomsrattranscriptclusterENZYME, 7
clariomsrattranscriptclusterENZYME2PROBE

(clariomsrattranscriptclusterENZYME),
7

clariomsrattranscriptclusterGENENAME,

9

clariomsrattranscriptclusterGO, 10
clariomsrattranscriptclusterGO2ALLPROBES,

19

∗ utilities

clariomsrattranscriptcluster_dbconn,

19

11

21

22

INDEX

clariomsrattranscriptclusterGO2ALLPROBES
(clariomsrattranscriptclusterGO),
10

clariomsrattranscriptclusterGO2PROBE

(clariomsrattranscriptclusterGO),
10

clariomsrattranscriptclusterLOCUSID

(clariomsrattranscriptclusterENTREZID),
6

clariomsrattranscriptclusterMAPCOUNTS,

12

clariomsrattranscriptclusterORGANISM,

12

clariomsrattranscriptclusterORGPKG

(clariomsrattranscriptclusterORGANISM),
12

clariomsrattranscriptclusterPATH, 13
clariomsrattranscriptclusterPATH2PROBE

(clariomsrattranscriptclusterPATH),
13

clariomsrattranscriptclusterPFAM, 14
clariomsrattranscriptclusterPMID, 15
clariomsrattranscriptclusterPMID2PROBE

(clariomsrattranscriptclusterPMID),
15

clariomsrattranscriptclusterPROSITE,

16

clariomsrattranscriptclusterREFSEQ, 16
clariomsrattranscriptclusterSYMBOL, 18
clariomsrattranscriptclusterUNIPROT,

19

clariomsrattranscriptclusterUNIPROT2PROBE

(clariomsrattranscriptclusterUNIPROT),
19

dbconn, 20
dbConnect, 20
dbDisconnect, 20
dbfile, 20
dbGetQuery, 20
dbInfo, 20
dbschema, 20

