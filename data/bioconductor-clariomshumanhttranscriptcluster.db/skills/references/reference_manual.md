clariomshumanhttranscriptcluster.db

February 11, 2026

clariomshumanhttranscriptclusterACCNUM

Map Manufacturer identifiers to Accession Numbers

Description

clariomshumanhttranscriptclusterACCNUM is an R object that contains mappings between a man-
ufacturer’s identifiers and manufacturers accessions.

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
x <- clariomshumanhttranscriptclusterACCNUM
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

clariomshumanhttranscriptcluster.db

clariomshumanhttranscriptclusterALIAS2PROBE

Map between Common Gene Symbol Identifiers and Manufacturer
Identifiers

Description

clariomshumanhttranscriptclusterALIAS is an R object that provides mappings between common
gene symbol identifiers and manufacturer identifiers.

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
xx <- as.list(clariomshumanhttranscriptclusterALIAS2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two aliases
xx[1:2]
# Get the first one
xx[[1]]

}

clariomshumanhttranscriptcluster.db

Bioconductor annotation data package

Description

Welcome to the clariomshumanhttranscriptcluster.db annotation Package. The purpose of this pack-
age is to provide detailed information about the clariomshumanhttranscriptcluster platform. This
package is updated biannually.
Objects in this package are accessed using the select() interface. See ?select in the AnnotationDbi
package for details.

clariomshumanhttranscriptclusterCHR

3

See Also

• AnnotationDb-class for use of keys(), columns() and select().

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
columns(clariomshumanhttranscriptcluster.db)

## Bimap interface:
## The 'old style' of interacting with these objects is manipulation as
## bimaps. While this approach is still available we strongly encourage the
## use of select().
ls("package:clariomshumanhttranscriptcluster.db")

clariomshumanhttranscriptclusterCHR

Map Manufacturer IDs to Chromosomes

Description

clariomshumanhttranscriptclusterCHR is an R object that provides mappings between a manufac-
turer identifier and the chromosome that contains the gene of interest.

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
x <- clariomshumanhttranscriptclusterCHR
# Get the probe identifiers that are mapped to a chromosome
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the CHR for the first five probes
xx[1:5]

4

clariomshumanhttranscriptclusterCHRLOC

# Get the first one
xx[[1]]

}

clariomshumanhttranscriptclusterCHRLENGTHS

A named vector for the length of each of the chromosomes

Description

clariomshumanhttranscriptclusterCHRLENGTHS provides the length measured in base pairs for
each of the chromosomes.

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
tt <- clariomshumanhttranscriptclusterCHRLENGTHS
# Length of chromosome 1
tt["1"]

clariomshumanhttranscriptclusterCHRLOC

Map Manufacturer IDs to Chromosomal Location

Description

clariomshumanhttranscriptclusterCHRLOC is an R object that maps manufacturer identifiers to the
starting position of the gene. The position of a gene is measured as the number of base pairs.

The CHRLOCEND mapping is the same as the CHRLOC mapping except that it specifies the
ending base of a gene instead of the start.

clariomshumanhttranscriptclusterENSEMBL

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

Mappings were based on data provided by: UCSC Genome Bioinformatics (Homo sapiens)

With a date stamp from the source of: 2021-Feb16

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- clariomshumanhttranscriptclusterCHRLOC
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

clariomshumanhttranscriptclusterENSEMBL

Map Ensembl gene accession numbers with Entrez Gene identifiers

Description

clariomshumanhttranscriptclusterENSEMBL is an R object that contains mappings between manu-
facturer identifiers and Ensembl gene accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to Ensembl gene Accession Numbers.
Mappings were based on data provided by BOTH of these sources: http://www.ensembl.org/
biomart/martview/ ftp://ftp.ncbi.nlm.nih.gov/gene/DATA

6

clariomshumanhttranscriptclusterENTREZID

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
x <- clariomshumanhttranscriptclusterENSEMBL
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
x <- clariomshumanhttranscriptclusterENSEMBL2PROBE
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

clariomshumanhttranscriptclusterENTREZID

Map between Manufacturer Identifiers and Entrez Gene

Description

clariomshumanhttranscriptclusterENTREZID is an R object that provides mappings between man-
ufacturer identifiers and Entrez Gene identifiers.

clariomshumanhttranscriptclusterENZYME

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
x <- clariomshumanhttranscriptclusterENTREZID
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

clariomshumanhttranscriptclusterENZYME

Maps between Manufacturer IDs and Enzyme Commission (EC) Num-
bers

Description

clariomshumanhttranscriptclusterENZYME is an R object that provides mappings between manu-
facturer identifiers and EC numbers. clariomshumanhttranscriptclusterENZYME2PROBE is an R
object that maps Enzyme Commission (EC) numbers to manufacturer identifiers.

8

Details

clariomshumanhttranscriptclusterENZYME

When the clariomshumanhttranscriptclusterENZYME maping viewed as a list, each manufacturer
identifier maps to a named vector containing the EC number that corresponds to the enzyme pro-
duced by that gene. The names corresponds to the manufacturer identifiers. If this information is
unknown, the vector will contain an NA.
For the clariomshumanhttranscriptclusterENZYME2PROBE, each EC number maps to a named
vector containing all of the manufacturer identifiers that correspond to the gene that produces that
enzyme. The name of the vector corresponds to the EC number.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In clariomshumanhttranscriptclusterENZYME2PROBE, EC is dropped from the Enzyme
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

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- clariomshumanhttranscriptclusterENZYME
# Get the probe identifiers that are mapped to an EC number
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:3])
if(length(xx) > 0) {

clariomshumanhttranscriptclusterGENENAME

9

# Get the ENZYME for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

# Now convert clariomshumanhttranscriptclusterENZYME2PROBE to a list to see inside
x <- clariomshumanhttranscriptclusterENZYME2PROBE
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

clariomshumanhttranscriptclusterGENENAME

Map between Manufacturer IDs and Genes

Description

clariomshumanhttranscriptclusterGENENAME is an R object that maps manufacturer identifiers to
the corresponding gene name.

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
x <- clariomshumanhttranscriptclusterGENENAME
# Get the probe identifiers that are mapped to a gene name
mapped_probes <- mappedkeys(x)

10

clariomshumanhttranscriptclusterGO

# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the GENENAME for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

clariomshumanhttranscriptclusterGO

Maps between manufacturer IDs and Gene Ontology (GO) IDs

Description

clariomshumanhttranscriptclusterGO is an R object that provides mappings between manufacturer
identifiers and the GO identifiers that they are directly associated with. This mapping and its reverse
mapping (clariomshumanhttranscriptclusterGO2PROBE) do NOT associate the child terms from
the GO ontology with the gene. Only the directly evidenced terms are represented here.

clariomshumanhttranscriptclusterGO2ALLPROBES is an R object that provides mappings between
a given GO identifier and all of the manufacturer identifiers annotated at that GO term OR TO ONE
OF IT’S CHILD NODES in the GO ontology. Thus, this mapping is much larger and more inclusive
than clariomshumanhttranscriptclusterGO2PROBE.

Details

If clariomshumanhttranscriptclusterGO is cast as a list, each manufacturer identifier is mapped to a
list of lists. The names on the outer list are GO identifiers. Each inner list consists of three named
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

clariomshumanhttranscriptclusterGO

11

A more complete listing of evidence codes can be found at:
http://www.geneontology.org/GO.evidence.shtml

If clariomshumanhttranscriptclusterGO2ALLPROBES or clariomshumanhttranscriptclusterGO2PROBE
is cast as a list, each GO term maps to a named vector of manufacturer identifiers and evidence
codes. A GO identifier may be mapped to the same manufacturer identifier more than once but the
evidence code can be different. Mappings between Gene Ontology identifiers and Gene Ontology
terms and other information are available in a separate data package named GO.

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

• clariomshumanhttranscriptclusterGO2ALLPROBES
• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- clariomshumanhttranscriptclusterGO
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
x <- clariomshumanhttranscriptclusterGO2PROBE
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

clariomshumanhttranscriptclusterMAP

x <- clariomshumanhttranscriptclusterGO2ALLPROBES
mapped_genes <- mappedkeys(x)
# Convert clariomshumanhttranscriptclusterGO2ALLPROBES to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){
# Gets the manufacturer identifiers for the top 2nd and 3nd GO identifiers

goids <- xx[2:3]
# Gets all the manufacturer identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

clariomshumanhttranscriptclusterMAP

Map between Manufacturer Identifiers and cytogenetic maps/bands

Description

clariomshumanhttranscriptclusterMAP is an R object that provides mappings between manufacturer
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

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2021-Apr14

References

https://www.ncbi.nlm.nih.gov

See Also

• AnnotationDb-class for use of the select() interface.

clariomshumanhttranscriptclusterMAPCOUNTS

13

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- clariomshumanhttranscriptclusterMAP
# Get the probe identifiers that are mapped to any cytoband
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the MAP for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

clariomshumanhttranscriptclusterMAPCOUNTS

Number of mapped keys for the maps in package clariomshumanht-
transcriptcluster.db

Description

DEPRECATED. Counts in the MAPCOUNT table are out of sync and should not be used.

clariomshumanhttranscriptclusterMAPCOUNTS provides the "map count" (i.e. the count of mapped
keys) for each map in package clariomshumanhttranscriptcluster.db.

Details

DEPRECATED. Counts in the MAPCOUNT table are out of sync and should not be used.

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

clariomshumanhttranscriptclusterOMIM

Map between Manufacturer Identifiers and Mendelian Inheritance in
Man (MIM) identifiers

Description

clariomshumanhttranscriptclusterOMIM is an R object that provides mappings between manufac-
turer identifiers and OMIM identifiers.

14

Details

clariomshumanhttranscriptclusterORGANISM

Each manufacturer identifier is mapped to a vector of OMIM identifiers. The vector length may be
one or longer, depending on how many OMIM identifiers the manufacturer identifier maps to. An
NA is reported for any manufacturer identifier that cannot be mapped to an OMIM identifier at this
time.

OMIM is based upon the book Mendelian Inheritance in Man (V. A. McKusick) and focuses primar-
ily on inherited or heritable genetic diseases. It contains textual information, pictures, and reference
information that can be searched using various terms, among which the MIM number is one.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2021-Apr14

References

https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene https://www.ncbi.nlm.nih.
gov/entrez/query.fcgi?db=OMIM

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- clariomshumanhttranscriptclusterOMIM
# Get the probe identifiers that are mapped to a OMIM ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the OMIM for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

clariomshumanhttranscriptclusterORGANISM

The Organism information for clariomshumanhttranscriptcluster

Description

clariomshumanhttranscriptclusterORGANISM is an R object that contains a single item: a character
string that names the organism for which clariomshumanhttranscriptcluster was built. clariomshu-
manhttranscriptclusterORGPKG is an R object that contains a chararcter vector with the name of
the organism package that a chip package depends on for its gene-centric annotation.

clariomshumanhttranscriptclusterPATH

15

Details

Although the package name is suggestive of the organism for which it was built, clariomshuman-
httranscriptclusterORGANISM provides a simple way to programmatically extract the organism
name. clariomshumanhttranscriptclusterORGPKG provides a simple way to programmatically ex-
tract the name of the parent organism package. The parent organism package is a strict dependency
for chip packages as this is where the gene cetric information is ultimately extracted from. The full
package name will always be this string plus the extension ".db". But most programatic acces will
not require this extension, so its more convenient to leave it out.

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
clariomshumanhttranscriptclusterORGANISM
clariomshumanhttranscriptclusterORGPKG

clariomshumanhttranscriptclusterPATH

Mappings between probe identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms.

clariomshumanhttranscriptclusterPATH maps probe identifiers to the identifiers used by KEGG for
pathways in which the genes represented by the probe identifiers are involved

clariomshumanhttranscriptclusterPATH2PROBE is an R object that provides mappings between
KEGG identifiers and manufacturer identifiers.

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

16

See Also

clariomshumanhttranscriptclusterPFAM

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- clariomshumanhttranscriptclusterPATH
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

x <- clariomshumanhttranscriptclusterPATH
mapped_probes <- mappedkeys(x)
# Now convert the clariomshumanhttranscriptclusterPATH2PROBE object to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0){

# Get the probe identifiers for the first two pathway identifiers
xx[1:2]
# Get the first one
xx[[1]]

}

clariomshumanhttranscriptclusterPFAM

Maps between Manufacturer Identifiers and PFAM Identifiers

Description

clariomshumanhttranscriptclusterPFAM is an R object that provides mappings between manufac-
turer identifiers and PFAM identifiers.

Details

The bimap interface for PFAM is defunct. Please use select() interface to PFAM identifiers. See
?AnnotationDbi::select for details.

clariomshumanhttranscriptclusterPMID

17

clariomshumanhttranscriptclusterPMID

Maps between Manufacturer Identifiers and PubMed Identifiers

Description

clariomshumanhttranscriptclusterPMID is an R object that provides mappings between manufac-
turer identifiers and PubMed identifiers. clariomshumanhttranscriptclusterPMID2PROBE is an R
object that provides mappings between PubMed identifiers and manufacturer identifiers.

Details

When clariomshumanhttranscriptclusterPMID is viewed as a list each manufacturer identifier is
mapped to a named vector of PubMed identifiers. The name associated with each vector corre-
sponds to the manufacturer identifier. The length of the vector may be one or greater, depending on
how many PubMed identifiers a given manufacturer identifier is mapped to. An NA is reported for
any manufacturer identifier that cannot be mapped to a PubMed identifier.

When clariomshumanhttranscriptclusterPMID2PROBE is viewed as a list each PubMed identifier is
mapped to a named vector of manufacturer identifiers. The name represents the PubMed identifier
and the vector contains all manufacturer identifiers that are represented by that PubMed identifier.
The length of the vector may be one or longer, depending on how many manufacturer identifiers are
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
x <- clariomshumanhttranscriptclusterPMID
# Get the probe identifiers that are mapped to any PubMed ID
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0){

# Get the PubMed identifiers for the first two probe identifiers
xx[1:2]
# Get the first one

18

clariomshumanhttranscriptclusterREFSEQ

xx[[1]]
if(interactive() && !is.null(xx[[1]]) && !is.na(xx[[1]])

&& require(annotate)){
# Get article information as XML files
xmls <- pubmed(xx[[1]], disp = "data")
# View article information using a browser
pubmed(xx[[1]], disp = "browser")

}

}

x <- clariomshumanhttranscriptclusterPMID2PROBE
mapped_probes <- mappedkeys(x)
# Now convert the reverse map object clariomshumanhttranscriptclusterPMID2PROBE to a list
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

clariomshumanhttranscriptclusterPROSITE

Maps between Manufacturer Identifiers and PROSITE Identifiers

Description

clariomshumanhttranscriptclusterPROSITE is an R object that provides mappings between manu-
facturer identifiers and PROSITE identifiers.

Details

The bimap interface for PROSITE is defunct. Please use select() interface to PROSITE identifiers.
See ?AnnotationDbi::select for details.

clariomshumanhttranscriptclusterREFSEQ

Map between Manufacturer Identifiers and RefSeq Identifiers

Description

clariomshumanhttranscriptclusterREFSEQ is an R object that provides mappings between manu-
facturer identifiers and RefSeq identifiers.

clariomshumanhttranscriptclusterREFSEQ

19

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
x <- clariomshumanhttranscriptclusterREFSEQ
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

20

clariomshumanhttranscriptclusterSYMBOL

clariomshumanhttranscriptclusterSYMBOL

Map between Manufacturer Identifiers and Gene Symbols

Description

clariomshumanhttranscriptclusterSYMBOL is an R object that provides mappings between manu-
facturer identifiers and gene abbreviations.

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
x <- clariomshumanhttranscriptclusterSYMBOL
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

clariomshumanhttranscriptclusterUNIPROT

21

clariomshumanhttranscriptclusterUNIPROT

Map Uniprot accession numbers with Entrez Gene identifiers

Description

clariomshumanhttranscriptclusterUNIPROT is an R object that contains mappings between the
manufacturer identifiers and Uniprot accession numbers.

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
x <- clariomshumanhttranscriptclusterUNIPROT
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

clariomshumanhttranscriptcluster_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

22

Usage

clariomshumanhttranscriptcluster_dbconn

clariomshumanhttranscriptcluster_dbconn()
clariomshumanhttranscriptcluster_dbfile()
clariomshumanhttranscriptcluster_dbschema(file="", show.indices=FALSE)
clariomshumanhttranscriptcluster_dbInfo()

Arguments

file

show.indices

Details

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).
The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

clariomshumanhttranscriptcluster_dbconn returns a connection object to the package annota-
tion DB. IMPORTANT: Don’t call dbDisconnect on the connection object returned by clariomshumanhttranscriptcluster_dbconn
or you will break all the AnnDbObj objects defined in this package!
clariomshumanhttranscriptcluster_dbfile returns the path (character string) to the package
annotation DB (this is an SQLite file).
clariomshumanhttranscriptcluster_dbschema prints the schema definition of the package an-
notation DB.
clariomshumanhttranscriptcluster_dbInfo prints other information about the package anno-
tation DB.

Value

clariomshumanhttranscriptcluster_dbconn: a DBIConnection object representing an open
connection to the package annotation DB.
clariomshumanhttranscriptcluster_dbfile: a character string with the path to the package
annotation DB.
clariomshumanhttranscriptcluster_dbschema: none (invisible NULL).
clariomshumanhttranscriptcluster_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

library(DBI)
## Count the number of rows in the "probes" table:
dbGetQuery(clariomshumanhttranscriptcluster_dbconn(), "SELECT COUNT(*) FROM probes")

clariomshumanhttranscriptcluster_dbschema()

clariomshumanhttranscriptcluster_dbInfo()

Index

∗ datasets

clariomshumanhttranscriptcluster.db,

2

clariomshumanhttranscriptclusterSYMBOL,

20

clariomshumanhttranscriptclusterUNIPROT,

clariomshumanhttranscriptcluster_dbconn,

21

21

clariomshumanhttranscriptclusterACCNUM,

∗ utilities

clariomshumanhttranscriptcluster_dbconn,

1

21

clariomshumanhttranscriptclusterALIAS2PROBE,

2

clariomshumanhttranscriptclusterCHR,

3

clariomshumanhttranscriptclusterCHRLENGTHS,

AnnDbObj, 22

cat, 22
checkMAPCOUNTS, 13
clariomshumanhttranscriptcluster

4

clariomshumanhttranscriptclusterCHRLOC,

4

clariomshumanhttranscriptclusterENSEMBL,

5

clariomshumanhttranscriptclusterENTREZID,

6

clariomshumanhttranscriptclusterENZYME,

7

clariomshumanhttranscriptclusterGENENAME,

9

clariomshumanhttranscriptclusterGO,

10

clariomshumanhttranscriptclusterMAP,

12

clariomshumanhttranscriptclusterMAPCOUNTS,

13

clariomshumanhttranscriptclusterOMIM,

13

clariomshumanhttranscriptclusterORGANISM,

14

clariomshumanhttranscriptclusterPATH,

15

clariomshumanhttranscriptclusterPFAM,

16

clariomshumanhttranscriptclusterPMID,

17

clariomshumanhttranscriptclusterPROSITE,

18

clariomshumanhttranscriptclusterREFSEQ,

18

23

(clariomshumanhttranscriptcluster.db),
2

clariomshumanhttranscriptcluster.db, 2
clariomshumanhttranscriptcluster_dbconn,

21

clariomshumanhttranscriptcluster_dbfile

(clariomshumanhttranscriptcluster_dbconn),
21

clariomshumanhttranscriptcluster_dbInfo

(clariomshumanhttranscriptcluster_dbconn),
21

clariomshumanhttranscriptcluster_dbschema

(clariomshumanhttranscriptcluster_dbconn),
21

clariomshumanhttranscriptclusterACCNUM,

1

clariomshumanhttranscriptclusterALIAS2PROBE,

2

clariomshumanhttranscriptclusterCHR, 3
clariomshumanhttranscriptclusterCHRLENGTHS,

4

clariomshumanhttranscriptclusterCHRLOC,

4

clariomshumanhttranscriptclusterCHRLOCEND

(clariomshumanhttranscriptclusterCHRLOC),
4

clariomshumanhttranscriptclusterENSEMBL,

5

clariomshumanhttranscriptclusterENSEMBL2PROBE

(clariomshumanhttranscriptclusterENSEMBL),
5

24

INDEX

clariomshumanhttranscriptclusterENTREZID,

6

clariomshumanhttranscriptclusterENZYME,

clariomshumanhttranscriptclusterUNIPROT2PROBE

(clariomshumanhttranscriptclusterUNIPROT),
21

dbconn, 22
dbConnect, 22
dbDisconnect, 22
dbfile, 22
dbGetQuery, 22
dbInfo, 22
dbschema, 22

7

clariomshumanhttranscriptclusterENZYME2PROBE

(clariomshumanhttranscriptclusterENZYME),
7

clariomshumanhttranscriptclusterGENENAME,

9

clariomshumanhttranscriptclusterGO, 10
clariomshumanhttranscriptclusterGO2ALLPROBES,

11

clariomshumanhttranscriptclusterGO2ALLPROBES
(clariomshumanhttranscriptclusterGO),
10

clariomshumanhttranscriptclusterGO2PROBE

(clariomshumanhttranscriptclusterGO),
10

clariomshumanhttranscriptclusterLOCUSID

(clariomshumanhttranscriptclusterENTREZID),
6

clariomshumanhttranscriptclusterMAP,

12

clariomshumanhttranscriptclusterMAPCOUNTS,

13

clariomshumanhttranscriptclusterOMIM,

13

clariomshumanhttranscriptclusterORGANISM,

14

clariomshumanhttranscriptclusterORGPKG

(clariomshumanhttranscriptclusterORGANISM),
14

clariomshumanhttranscriptclusterPATH,

15

clariomshumanhttranscriptclusterPATH2PROBE

(clariomshumanhttranscriptclusterPATH),
15

clariomshumanhttranscriptclusterPFAM,

16

clariomshumanhttranscriptclusterPMID,

17

clariomshumanhttranscriptclusterPMID2PROBE

(clariomshumanhttranscriptclusterPMID),
17

clariomshumanhttranscriptclusterPROSITE,

18

clariomshumanhttranscriptclusterREFSEQ,

18

clariomshumanhttranscriptclusterSYMBOL,

20

clariomshumanhttranscriptclusterUNIPROT,

21

