ragene10sttranscriptcluster.db

February 25, 2026

ragene10sttranscriptclusterACCNUM

Map Manufacturer identifiers to Accession Numbers

Description

ragene10sttranscriptclusterACCNUM is an R object that contains mappings between a manufac-
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
x <- ragene10sttranscriptclusterACCNUM
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

ragene10sttranscriptcluster.db

ragene10sttranscriptclusterALIAS2PROBE

Map between Common Gene Symbol Identifiers and Manufacturer
Identifiers

Description

ragene10sttranscriptclusterALIAS is an R object that provides mappings between common gene
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
xx <- as.list(ragene10sttranscriptclusterALIAS2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two aliases
xx[1:2]
# Get the first one
xx[[1]]

}

ragene10sttranscriptcluster.db

Bioconductor annotation data package

Description

Welcome to the ragene10sttranscriptcluster.db annotation Package. The purpose of this package
is to provide detailed information about the ragene10sttranscriptcluster platform. This package is
updated biannually.
Objects in this package are accessed using the select() interface. See ?select in the AnnotationDbi
package for details.

ragene10sttranscriptclusterCHR

3

See Also

• AnnotationDb-class for use of keys(), columns() and select().

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
columns(ragene10sttranscriptcluster.db)

## Bimap interface:
## The 'old style' of interacting with these objects is manipulation as
## bimaps. While this approach is still available we strongly encourage the
## use of select().
ls("package:ragene10sttranscriptcluster.db")

ragene10sttranscriptclusterCHR

Map Manufacturer IDs to Chromosomes

Description

ragene10sttranscriptclusterCHR is an R object that provides mappings between a manufacturer
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
x <- ragene10sttranscriptclusterCHR
# Get the probe identifiers that are mapped to a chromosome
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the CHR for the first five probes
xx[1:5]

4

ragene10sttranscriptclusterCHRLOC

# Get the first one
xx[[1]]

}

ragene10sttranscriptclusterCHRLENGTHS

A named vector for the length of each of the chromosomes

Description

ragene10sttranscriptclusterCHRLENGTHS provides the length measured in base pairs for each of
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
tt <- ragene10sttranscriptclusterCHRLENGTHS
# Length of chromosome 1
tt["1"]

ragene10sttranscriptclusterCHRLOC

Map Manufacturer IDs to Chromosomal Location

Description

ragene10sttranscriptclusterCHRLOC is an R object that maps manufacturer identifiers to the start-
ing position of the gene. The position of a gene is measured as the number of base pairs.

The CHRLOCEND mapping is the same as the CHRLOC mapping except that it specifies the
ending base of a gene instead of the start.

ragene10sttranscriptclusterENSEMBL

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
x <- ragene10sttranscriptclusterCHRLOC
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

ragene10sttranscriptclusterENSEMBL

Map Ensembl gene accession numbers with Entrez Gene identifiers

Description

ragene10sttranscriptclusterENSEMBL is an R object that contains mappings between manufacturer
identifiers and Ensembl gene accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to Ensembl gene Accession Numbers.
Mappings were based on data provided by BOTH of these sources: http://www.ensembl.org/
biomart/martview/ ftp://ftp.ncbi.nlm.nih.gov/gene/DATA

6

ragene10sttranscriptclusterENTREZID

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
x <- ragene10sttranscriptclusterENSEMBL
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
x <- ragene10sttranscriptclusterENSEMBL2PROBE
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

ragene10sttranscriptclusterENTREZID

Map between Manufacturer Identifiers and Entrez Gene

Description

ragene10sttranscriptclusterENTREZID is an R object that provides mappings between manufac-
turer identifiers and Entrez Gene identifiers.

ragene10sttranscriptclusterENZYME

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
x <- ragene10sttranscriptclusterENTREZID
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

ragene10sttranscriptclusterENZYME

Maps between Manufacturer IDs and Enzyme Commission (EC) Num-
bers

Description

ragene10sttranscriptclusterENZYME is an R object that provides mappings between manufacturer
identifiers and EC numbers. ragene10sttranscriptclusterENZYME2PROBE is an R object that maps
Enzyme Commission (EC) numbers to manufacturer identifiers.

8

Details

ragene10sttranscriptclusterENZYME

When the ragene10sttranscriptclusterENZYME maping viewed as a list, each manufacturer identi-
fier maps to a named vector containing the EC number that corresponds to the enzyme produced by
that gene. The names corresponds to the manufacturer identifiers. If this information is unknown,
the vector will contain an NA.
For the ragene10sttranscriptclusterENZYME2PROBE, each EC number maps to a named vector
containing all of the manufacturer identifiers that correspond to the gene that produces that enzyme.
The name of the vector corresponds to the EC number.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In ragene10sttranscriptclusterENZYME2PROBE, EC is dropped from the Enzyme Com-
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
x <- ragene10sttranscriptclusterENZYME
# Get the probe identifiers that are mapped to an EC number
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:3])
if(length(xx) > 0) {

ragene10sttranscriptclusterGENENAME

9

# Get the ENZYME for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

# Now convert ragene10sttranscriptclusterENZYME2PROBE to a list to see inside
x <- ragene10sttranscriptclusterENZYME2PROBE
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

ragene10sttranscriptclusterGENENAME

Map between Manufacturer IDs and Genes

Description

ragene10sttranscriptclusterGENENAME is an R object that maps manufacturer identifiers to the
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
x <- ragene10sttranscriptclusterGENENAME
# Get the probe identifiers that are mapped to a gene name
mapped_probes <- mappedkeys(x)

10

ragene10sttranscriptclusterGO

# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the GENENAME for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

ragene10sttranscriptclusterGO

Maps between manufacturer IDs and Gene Ontology (GO) IDs

Description

ragene10sttranscriptclusterGO is an R object that provides mappings between manufacturer iden-
tifiers and the GO identifiers that they are directly associated with. This mapping and its reverse
mapping (ragene10sttranscriptclusterGO2PROBE) do NOT associate the child terms from the GO
ontology with the gene. Only the directly evidenced terms are represented here.

ragene10sttranscriptclusterGO2ALLPROBES is an R object that provides mappings between a
given GO identifier and all of the manufacturer identifiers annotated at that GO term OR TO ONE
OF IT’S CHILD NODES in the GO ontology. Thus, this mapping is much larger and more inclusive
than ragene10sttranscriptclusterGO2PROBE.

Details

If ragene10sttranscriptclusterGO is cast as a list, each manufacturer identifier is mapped to a list
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

ragene10sttranscriptclusterGO

11

A more complete listing of evidence codes can be found at:
http://www.geneontology.org/GO.evidence.shtml

If ragene10sttranscriptclusterGO2ALLPROBES or ragene10sttranscriptclusterGO2PROBE is cast
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

• ragene10sttranscriptclusterGO2ALLPROBES
• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- ragene10sttranscriptclusterGO
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
x <- ragene10sttranscriptclusterGO2PROBE
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

ragene10sttranscriptclusterORGANISM

x <- ragene10sttranscriptclusterGO2ALLPROBES
mapped_genes <- mappedkeys(x)
# Convert ragene10sttranscriptclusterGO2ALLPROBES to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){
# Gets the manufacturer identifiers for the top 2nd and 3nd GO identifiers

goids <- xx[2:3]
# Gets all the manufacturer identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

ragene10sttranscriptclusterMAPCOUNTS

Number
gene10sttranscriptcluster.db

of mapped

keys

for

the maps

in

package

ra-

Description

DEPRECATED. Counts in the MAPCOUNT table are out of sync and should not be used.

ragene10sttranscriptclusterMAPCOUNTS provides the "map count" (i.e. the count of mapped keys)
for each map in package ragene10sttranscriptcluster.db.

Details

DEPRECATED. Counts in the MAPCOUNT table are out of sync and should not be used.

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

ragene10sttranscriptclusterORGANISM

The Organism information for ragene10sttranscriptcluster

Description

ragene10sttranscriptclusterORGANISM is an R object that contains a single item: a character string
that names the organism for which ragene10sttranscriptcluster was built. ragene10sttranscriptclusterORGPKG
is an R object that contains a chararcter vector with the name of the organism package that a chip
package depends on for its gene-centric annotation.

ragene10sttranscriptclusterPATH

13

Details

Although the package name is suggestive of the organism for which it was built, ragene10sttranscriptclusterORGANISM
provides a simple way to programmatically extract the organism name. ragene10sttranscriptclusterORGPKG
provides a simple way to programmatically extract the name of the parent organism package. The
parent organism package is a strict dependency for chip packages as this is where the gene cetric
information is ultimately extracted from. The full package name will always be this string plus the
extension ".db". But most programatic acces will not require this extension, so its more convenient
to leave it out.

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
ragene10sttranscriptclusterORGANISM
ragene10sttranscriptclusterORGPKG

ragene10sttranscriptclusterPATH

Mappings between probe identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms.

ragene10sttranscriptclusterPATH maps probe identifiers to the identifiers used by KEGG for path-
ways in which the genes represented by the probe identifiers are involved

ragene10sttranscriptclusterPATH2PROBE is an R object that provides mappings between KEGG
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

ragene10sttranscriptclusterPFAM

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- ragene10sttranscriptclusterPATH
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

x <- ragene10sttranscriptclusterPATH
mapped_probes <- mappedkeys(x)
# Now convert the ragene10sttranscriptclusterPATH2PROBE object to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0){

# Get the probe identifiers for the first two pathway identifiers
xx[1:2]
# Get the first one
xx[[1]]

}

ragene10sttranscriptclusterPFAM

Maps between Manufacturer Identifiers and PFAM Identifiers

Description

ragene10sttranscriptclusterPFAM is an R object that provides mappings between manufacturer
identifiers and PFAM identifiers.

Details

The bimap interface for PFAM is defunct. Please use select() interface to PFAM identifiers. See
?AnnotationDbi::select for details.

ragene10sttranscriptclusterPMID

15

ragene10sttranscriptclusterPMID

Maps between Manufacturer Identifiers and PubMed Identifiers

Description

ragene10sttranscriptclusterPMID is an R object that provides mappings between manufacturer iden-
tifiers and PubMed identifiers. ragene10sttranscriptclusterPMID2PROBE is an R object that pro-
vides mappings between PubMed identifiers and manufacturer identifiers.

Details

When ragene10sttranscriptclusterPMID is viewed as a list each manufacturer identifier is mapped
to a named vector of PubMed identifiers. The name associated with each vector corresponds to
the manufacturer identifier. The length of the vector may be one or greater, depending on how
many PubMed identifiers a given manufacturer identifier is mapped to. An NA is reported for any
manufacturer identifier that cannot be mapped to a PubMed identifier.

When ragene10sttranscriptclusterPMID2PROBE is viewed as a list each PubMed identifier is mapped
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
x <- ragene10sttranscriptclusterPMID
# Get the probe identifiers that are mapped to any PubMed ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0){

# Get the PubMed identifiers for the first two probe identifiers
xx[1:2]
# Get the first one

16

ragene10sttranscriptclusterREFSEQ

xx[[1]]
if(interactive() && !is.null(xx[[1]]) && !is.na(xx[[1]])

&& require(annotate)){
# Get article information as XML files
xmls <- pubmed(xx[[1]], disp = "data")
# View article information using a browser
pubmed(xx[[1]], disp = "browser")

}

}

x <- ragene10sttranscriptclusterPMID2PROBE
mapped_probes <- mappedkeys(x)
# Now convert the reverse map object ragene10sttranscriptclusterPMID2PROBE to a list
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

ragene10sttranscriptclusterPROSITE

Maps between Manufacturer Identifiers and PROSITE Identifiers

Description

ragene10sttranscriptclusterPROSITE is an R object that provides mappings between manufacturer
identifiers and PROSITE identifiers.

Details

The bimap interface for PROSITE is defunct. Please use select() interface to PROSITE identifiers.
See ?AnnotationDbi::select for details.

ragene10sttranscriptclusterREFSEQ

Map between Manufacturer Identifiers and RefSeq Identifiers

Description

ragene10sttranscriptclusterREFSEQ is an R object that provides mappings between manufacturer
identifiers and RefSeq identifiers.

ragene10sttranscriptclusterREFSEQ

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
x <- ragene10sttranscriptclusterREFSEQ
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

ragene10sttranscriptclusterSYMBOL

ragene10sttranscriptclusterSYMBOL

Map between Manufacturer Identifiers and Gene Symbols

Description

ragene10sttranscriptclusterSYMBOL is an R object that provides mappings between manufacturer
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
x <- ragene10sttranscriptclusterSYMBOL
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

ragene10sttranscriptclusterUNIPROT

19

ragene10sttranscriptclusterUNIPROT

Map Uniprot accession numbers with Entrez Gene identifiers

Description

ragene10sttranscriptclusterUNIPROT is an R object that contains mappings between the manufac-
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
x <- ragene10sttranscriptclusterUNIPROT
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

ragene10sttranscriptcluster_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

20

Usage

ragene10sttranscriptcluster_dbconn

ragene10sttranscriptcluster_dbconn()
ragene10sttranscriptcluster_dbfile()
ragene10sttranscriptcluster_dbschema(file="", show.indices=FALSE)
ragene10sttranscriptcluster_dbInfo()

Arguments

file

show.indices

Details

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).
The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

ragene10sttranscriptcluster_dbconn returns a connection object to the package annotation
DB. IMPORTANT: Don’t call dbDisconnect on the connection object returned by ragene10sttranscriptcluster_dbconn
or you will break all the AnnDbObj objects defined in this package!
ragene10sttranscriptcluster_dbfile returns the path (character string) to the package anno-
tation DB (this is an SQLite file).
ragene10sttranscriptcluster_dbschema prints the schema definition of the package annotation
DB.
ragene10sttranscriptcluster_dbInfo prints other information about the package annotation
DB.

Value

ragene10sttranscriptcluster_dbconn: a DBIConnection object representing an open connec-
tion to the package annotation DB.
ragene10sttranscriptcluster_dbfile: a character string with the path to the package annota-
tion DB.
ragene10sttranscriptcluster_dbschema: none (invisible NULL).
ragene10sttranscriptcluster_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

library(DBI)
## Count the number of rows in the "probes" table:
dbGetQuery(ragene10sttranscriptcluster_dbconn(), "SELECT COUNT(*) FROM probes")

ragene10sttranscriptcluster_dbschema()

ragene10sttranscriptcluster_dbInfo()

Index

∗ datasets

ragene10sttranscriptcluster.db, 2
ragene10sttranscriptcluster_dbconn,

19

ragene10sttranscriptclusterACCNUM,

1

ragene10sttranscriptclusterALIAS2PROBE,

2

ragene10sttranscriptclusterCHR, 3
ragene10sttranscriptclusterCHRLENGTHS,

4

ragene10sttranscriptclusterCHRLOC,

4

AnnDbObj, 20

cat, 20
checkMAPCOUNTS, 12

dbconn, 20
dbConnect, 20
dbDisconnect, 20
dbfile, 20
dbGetQuery, 20
dbInfo, 20
dbschema, 20

ragene10sttranscriptclusterENSEMBL,

ragene10sttranscriptcluster

5

ragene10sttranscriptclusterENTREZID,

6

ragene10sttranscriptclusterENZYME,

7

ragene10sttranscriptclusterGENENAME,

9

ragene10sttranscriptclusterGO, 10
ragene10sttranscriptclusterMAPCOUNTS,

12

ragene10sttranscriptclusterORGANISM,

12

ragene10sttranscriptclusterPATH,

13

ragene10sttranscriptclusterPFAM,

14

ragene10sttranscriptclusterPMID,

15

ragene10sttranscriptclusterPROSITE,

16

ragene10sttranscriptclusterREFSEQ,

16

ragene10sttranscriptclusterSYMBOL,

18

ragene10sttranscriptclusterUNIPROT,

19

∗ utilities

ragene10sttranscriptcluster_dbconn,

19

21

(ragene10sttranscriptcluster.db),
2

ragene10sttranscriptcluster.db, 2
ragene10sttranscriptcluster_dbconn, 19
ragene10sttranscriptcluster_dbfile

(ragene10sttranscriptcluster_dbconn),
19

ragene10sttranscriptcluster_dbInfo

(ragene10sttranscriptcluster_dbconn),
19

ragene10sttranscriptcluster_dbschema

(ragene10sttranscriptcluster_dbconn),
19

ragene10sttranscriptclusterACCNUM, 1
ragene10sttranscriptclusterALIAS2PROBE,

2

ragene10sttranscriptclusterCHR, 3
ragene10sttranscriptclusterCHRLENGTHS,

4

ragene10sttranscriptclusterCHRLOC, 4
ragene10sttranscriptclusterCHRLOCEND

(ragene10sttranscriptclusterCHRLOC),
4

ragene10sttranscriptclusterENSEMBL, 5
ragene10sttranscriptclusterENSEMBL2PROBE

(ragene10sttranscriptclusterENSEMBL),
5

ragene10sttranscriptclusterENTREZID, 6
ragene10sttranscriptclusterENZYME, 7

22

INDEX

ragene10sttranscriptclusterENZYME2PROBE

(ragene10sttranscriptclusterENZYME),
7

ragene10sttranscriptclusterGENENAME, 9
ragene10sttranscriptclusterGO, 10
ragene10sttranscriptclusterGO2ALLPROBES,

11

ragene10sttranscriptclusterGO2ALLPROBES
(ragene10sttranscriptclusterGO),
10

ragene10sttranscriptclusterGO2PROBE

(ragene10sttranscriptclusterGO),
10

ragene10sttranscriptclusterLOCUSID

(ragene10sttranscriptclusterENTREZID),
6

ragene10sttranscriptclusterMAPCOUNTS,

12

ragene10sttranscriptclusterORGANISM,

12

ragene10sttranscriptclusterORGPKG

(ragene10sttranscriptclusterORGANISM),
12

ragene10sttranscriptclusterPATH, 13
ragene10sttranscriptclusterPATH2PROBE

(ragene10sttranscriptclusterPATH),
13

ragene10sttranscriptclusterPFAM, 14
ragene10sttranscriptclusterPMID, 15
ragene10sttranscriptclusterPMID2PROBE

(ragene10sttranscriptclusterPMID),
15

ragene10sttranscriptclusterPROSITE, 16
ragene10sttranscriptclusterREFSEQ, 16
ragene10sttranscriptclusterSYMBOL, 18
ragene10sttranscriptclusterUNIPROT, 19
ragene10sttranscriptclusterUNIPROT2PROBE

(ragene10sttranscriptclusterUNIPROT),
19

