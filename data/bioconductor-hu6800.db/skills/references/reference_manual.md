hu6800.db
February 11, 2026

hu6800ACCNUM

Map Manufacturer identifiers to Accession Numbers

Description

hu6800ACCNUM is an R object that contains mappings between a manufacturer’s identifiers and
manufacturers accessions.

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
x <- hu6800ACCNUM
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

hu6800.db

hu6800ALIAS2PROBE

Map between Common Gene Symbol Identifiers and Manufacturer
Identifiers

Description

hu6800ALIAS is an R object that provides mappings between common gene symbol identifiers and
manufacturer identifiers.

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
xx <- as.list(hu6800ALIAS2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two aliases
xx[1:2]
# Get the first one
xx[[1]]

}

hu6800.db

Bioconductor annotation data package

Description

Welcome to the hu6800.db annotation Package. The purpose of this package is to provide detailed
information about the hu6800 platform. This package is updated biannually.
Objects in this package are accessed using the select() interface. See ?select in the AnnotationDbi
package for details.

hu6800CHR

See Also

3

• AnnotationDb-class for use of keys(), columns() and select().

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
columns(hu6800.db)

## Bimap interface:
## The 'old style' of interacting with these objects is manipulation as
## bimaps. While this approach is still available we strongly encourage the
## use of select().
ls("package:hu6800.db")

hu6800CHR

Map Manufacturer IDs to Chromosomes

Description

hu6800CHR is an R object that provides mappings between a manufacturer identifier and the chro-
mosome that contains the gene of interest.

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
x <- hu6800CHR
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

hu6800CHRLOC

hu6800CHRLENGTHS

A named vector for the length of each of the chromosomes

Description

hu6800CHRLENGTHS provides the length measured in base pairs for each of the chromosomes.

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
tt <- hu6800CHRLENGTHS
# Length of chromosome 1
tt["1"]

hu6800CHRLOC

Map Manufacturer IDs to Chromosomal Location

Description

hu6800CHRLOC is an R object that maps manufacturer identifiers to the starting position of the
gene. The position of a gene is measured as the number of base pairs.

The CHRLOCEND mapping is the same as the CHRLOC mapping except that it specifies the
ending base of a gene instead of the start.

hu6800ENSEMBL

Details

5

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
x <- hu6800CHRLOC
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

hu6800ENSEMBL

Map Ensembl gene accession numbers with Entrez Gene identifiers

Description

hu6800ENSEMBL is an R object that contains mappings between manufacturer identifiers and
Ensembl gene accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to Ensembl gene Accession Numbers.
Mappings were based on data provided by BOTH of these sources: http://www.ensembl.org/
biomart/martview/ ftp://ftp.ncbi.nlm.nih.gov/gene/DATA

For most species, this mapping is a combination of manufacturer to ensembl IDs from BOTH
NCBI and ensembl. Users who wish to only use mappings from NCBI are encouraged to see

6

hu6800ENTREZID

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
x <- hu6800ENSEMBL
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
x <- hu6800ENSEMBL2PROBE
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

hu6800ENTREZID

Map between Manufacturer Identifiers and Entrez Gene

Description

hu6800ENTREZID is an R object that provides mappings between manufacturer identifiers and
Entrez Gene identifiers.

hu6800ENZYME

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
x <- hu6800ENTREZID
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

hu6800ENZYME

Maps between Manufacturer IDs and Enzyme Commission (EC) Num-
bers

Description

hu6800ENZYME is an R object that provides mappings between manufacturer identifiers and EC
numbers. hu6800ENZYME2PROBE is an R object that maps Enzyme Commission (EC) numbers
to manufacturer identifiers.

Details

When the hu6800ENZYME maping viewed as a list, each manufacturer identifier maps to a named
vector containing the EC number that corresponds to the enzyme produced by that gene. The names
corresponds to the manufacturer identifiers. If this information is unknown, the vector will contain
an NA.

8

hu6800ENZYME

For the hu6800ENZYME2PROBE, each EC number maps to a named vector containing all of the
manufacturer identifiers that correspond to the gene that produces that enzyme. The name of the
vector corresponds to the EC number.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In hu6800ENZYME2PROBE, EC is dropped from the Enzyme Commission numbers.

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
x <- hu6800ENZYME
# Get the probe identifiers that are mapped to an EC number
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:3])
if(length(xx) > 0) {

# Get the ENZYME for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

# Now convert hu6800ENZYME2PROBE to a list to see inside

hu6800GENENAME

9

x <- hu6800ENZYME2PROBE
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

hu6800GENENAME

Map between Manufacturer IDs and Genes

Description

hu6800GENENAME is an R object that maps manufacturer identifiers to the corresponding gene
name.

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
x <- hu6800GENENAME
# Get the probe identifiers that are mapped to a gene name
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0) {

# Get the GENENAME for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

10

hu6800GO

hu6800GO

Maps between manufacturer IDs and Gene Ontology (GO) IDs

Description

hu6800GO is an R object that provides mappings between manufacturer identifiers and the GO iden-
tifiers that they are directly associated with. This mapping and its reverse mapping (hu6800GO2PROBE)
do NOT associate the child terms from the GO ontology with the gene. Only the directly evidenced
terms are represented here.

hu6800GO2ALLPROBES is an R object that provides mappings between a given GO identifier and
all of the manufacturer identifiers annotated at that GO term OR TO ONE OF IT’S CHILD NODES
in the GO ontology. Thus, this mapping is much larger and more inclusive than hu6800GO2PROBE.

Details

If hu6800GO is cast as a list, each manufacturer identifier is mapped to a list of lists. The names on
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

IDA: inferred from direct assay

IEP: inferred from expression pattern

IEA: inferred from electronic annotation

TAS: traceable author statement

NAS: non-traceable author statement

ND: no biological data available

IC: inferred by curator

A more complete listing of evidence codes can be found at:
http://www.geneontology.org/GO.evidence.shtml

If hu6800GO2ALLPROBES or hu6800GO2PROBE is cast as a list, each GO term maps to a named
vector of manufacturer identifiers and evidence codes. A GO identifier may be mapped to the
same manufacturer identifier more than once but the evidence code can be different. Mappings
between Gene Ontology identifiers and Gene Ontology terms and other information are available in
a separate data package named GO.

Whenever any of these mappings are cast as a data.frame, all the results will be output in an appro-
priate tabular form.

hu6800GO

11

Mappings between manufacturer identifiers and GO information were obtained through their map-
pings to manufacturer identifiers. NAs are assigned to manufacturer identifiers that can not be
mapped to any Gene Ontology information. Mappings between Gene Ontology identifiers an Gene
Ontology terms and other information are available in a separate data package named GO.

All mappings were based on data provided by: Gene Ontology http://current.geneontology.org/ontology/go-
basic.obo With a date stamp from the source of: 2021-02-01

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

See Also

• hu6800GO2ALLPROBES
• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- hu6800GO
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
x <- hu6800GO2PROBE
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){

# Gets the manufacturer ids for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets the manufacturer ids for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

x <- hu6800GO2ALLPROBES
mapped_genes <- mappedkeys(x)
# Convert hu6800GO2ALLPROBES to a list
xx <- as.list(x[mapped_genes][1:300])
if(length(xx) > 0){
# Gets the manufacturer identifiers for the top 2nd and 3nd GO identifiers

goids <- xx[2:3]

12

}

# Gets all the manufacturer identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

hu6800MAP

hu6800MAP

Map between Manufacturer Identifiers and cytogenetic maps/bands

Description

hu6800MAP is an R object that provides mappings between manufacturer identifiers and cytoband
locations.

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

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- hu6800MAP
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

hu6800MAPCOUNTS

13

hu6800MAPCOUNTS

Number of mapped keys for the maps in package hu6800.db

Description

DEPRECATED. Counts in the MAPCOUNT table are out of sync and should not be used.

hu6800MAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each map in
package hu6800.db.

Details

DEPRECATED. Counts in the MAPCOUNT table are out of sync and should not be used.

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

hu6800OMIM

Map between Manufacturer Identifiers and Mendelian Inheritance in
Man (MIM) identifiers

Description

hu6800OMIM is an R object that provides mappings between manufacturer identifiers and OMIM
identifiers.

Details

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

14

Examples

hu6800ORGANISM

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- hu6800OMIM
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

hu6800ORGANISM

The Organism information for hu6800

Description

hu6800ORGANISM is an R object that contains a single item: a character string that names the
organism for which hu6800 was built. hu6800ORGPKG is an R object that contains a chararcter
vector with the name of the organism package that a chip package depends on for its gene-centric
annotation.

Details

Although the package name is suggestive of the organism for which it was built, hu6800ORGANISM
provides a simple way to programmatically extract the organism name. hu6800ORGPKG provides
a simple way to programmatically extract the name of the parent organism package. The parent or-
ganism package is a strict dependency for chip packages as this is where the gene cetric information
is ultimately extracted from. The full package name will always be this string plus the extension
".db". But most programatic acces will not require this extension, so its more convenient to leave it
out.

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
hu6800ORGANISM
hu6800ORGPKG

hu6800PATH

15

hu6800PATH

Mappings between probe identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms.

hu6800PATH maps probe identifiers to the identifiers used by KEGG for pathways in which the
genes represented by the probe identifiers are involved

hu6800PATH2PROBE is an R object that provides mappings between KEGG identifiers and man-
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

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- hu6800PATH
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

x <- hu6800PATH
mapped_probes <- mappedkeys(x)
# Now convert the hu6800PATH2PROBE object to a list

16

hu6800PMID

xx <- as.list(x[mapped_probes][1:300])
if(length(xx) > 0){

# Get the probe identifiers for the first two pathway identifiers
xx[1:2]
# Get the first one
xx[[1]]

}

hu6800PFAM

Maps between Manufacturer Identifiers and PFAM Identifiers

Description

hu6800PFAM is an R object that provides mappings between manufacturer identifiers and PFAM
identifiers.

Details

The bimap interface for PFAM is defunct. Please use select() interface to PFAM identifiers. See
?AnnotationDbi::select for details.

hu6800PMID

Maps between Manufacturer Identifiers and PubMed Identifiers

Description

hu6800PMID is an R object that provides mappings between manufacturer identifiers and PubMed
identifiers. hu6800PMID2PROBE is an R object that provides mappings between PubMed identi-
fiers and manufacturer identifiers.

Details

When hu6800PMID is viewed as a list each manufacturer identifier is mapped to a named vector of
PubMed identifiers. The name associated with each vector corresponds to the manufacturer identi-
fier. The length of the vector may be one or greater, depending on how many PubMed identifiers a
given manufacturer identifier is mapped to. An NA is reported for any manufacturer identifier that
cannot be mapped to a PubMed identifier.

When hu6800PMID2PROBE is viewed as a list each PubMed identifier is mapped to a named vector
of manufacturer identifiers. The name represents the PubMed identifier and the vector contains all
manufacturer identifiers that are represented by that PubMed identifier. The length of the vector
may be one or longer, depending on how many manufacturer identifiers are mapped to a given
PubMed identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2021-Apr14

References

https://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=PubMed

hu6800PROSITE

See Also

• AnnotationDb-class for use of the select() interface.

Examples

17

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- hu6800PMID
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

x <- hu6800PMID2PROBE
mapped_probes <- mappedkeys(x)
# Now convert the reverse map object hu6800PMID2PROBE to a list
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

hu6800PROSITE

Maps between Manufacturer Identifiers and PROSITE Identifiers

Description

hu6800PROSITE is an R object that provides mappings between manufacturer identifiers and PROSITE
identifiers.

18

Details

hu6800REFSEQ

The bimap interface for PROSITE is defunct. Please use select() interface to PROSITE identifiers.
See ?AnnotationDbi::select for details.

hu6800REFSEQ

Map between Manufacturer Identifiers and RefSeq Identifiers

Description

hu6800REFSEQ is an R object that provides mappings between manufacturer identifiers and Ref-
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

Where XXXXX is a sequence of integers.
NCBI https://www.ncbi.nlm.nih.gov/RefSeq/ allows users to query the RefSeq database us-
ing RefSeq identifiers.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2021-Apr14

References

https://www.ncbi.nlm.nih.gov https://www.ncbi.nlm.nih.gov/RefSeq/

See Also

• AnnotationDb-class for use of the select() interface.

hu6800SYMBOL

Examples

19

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- hu6800REFSEQ
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

hu6800SYMBOL

Map between Manufacturer Identifiers and Gene Symbols

Description

hu6800SYMBOL is an R object that provides mappings between manufacturer identifiers and gene
abbreviations.

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
x <- hu6800SYMBOL

20

hu6800UNIPROT

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

hu6800UNIPROT

Map Uniprot accession numbers with Entrez Gene identifiers

Description

hu6800UNIPROT is an R object that contains mappings between the manufacturer identifiers and
Uniprot accession numbers.

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
x <- hu6800UNIPROT
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

hu6800_dbconn

21

hu6800_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

hu6800_dbconn()
hu6800_dbfile()
hu6800_dbschema(file="", show.indices=FALSE)
hu6800_dbInfo()

Arguments

file

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

hu6800_dbconn returns a connection object to the package annotation DB. IMPORTANT: Don’t
call dbDisconnect on the connection object returned by hu6800_dbconn or you will break all the
AnnDbObj objects defined in this package!

hu6800_dbfile returns the path (character string) to the package annotation DB (this is an SQLite
file).

hu6800_dbschema prints the schema definition of the package annotation DB.

hu6800_dbInfo prints other information about the package annotation DB.

Value

hu6800_dbconn: a DBIConnection object representing an open connection to the package annota-
tion DB.

hu6800_dbfile: a character string with the path to the package annotation DB.

hu6800_dbschema: none (invisible NULL).

hu6800_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

22

Examples

library(DBI)
## Count the number of rows in the "probes" table:
dbGetQuery(hu6800_dbconn(), "SELECT COUNT(*) FROM probes")

hu6800_dbschema()

hu6800_dbInfo()

hu6800_dbconn

hu6800_dbInfo (hu6800_dbconn), 21
hu6800_dbschema (hu6800_dbconn), 21
hu6800ACCNUM, 1
hu6800ALIAS2PROBE, 2
hu6800CHR, 3
hu6800CHRLENGTHS, 4
hu6800CHRLOC, 4
hu6800CHRLOCEND (hu6800CHRLOC), 4
hu6800ENSEMBL, 5
hu6800ENSEMBL2PROBE (hu6800ENSEMBL), 5
hu6800ENTREZID, 6
hu6800ENZYME, 7
hu6800ENZYME2PROBE (hu6800ENZYME), 7
hu6800GENENAME, 9
hu6800GO, 10
hu6800GO2ALLPROBES, 11
hu6800GO2ALLPROBES (hu6800GO), 10
hu6800GO2PROBE (hu6800GO), 10
hu6800LOCUSID (hu6800ENTREZID), 6
hu6800MAP, 12
hu6800MAPCOUNTS, 13
hu6800OMIM, 13
hu6800ORGANISM, 14
hu6800ORGPKG (hu6800ORGANISM), 14
hu6800PATH, 15
hu6800PATH2PROBE (hu6800PATH), 15
hu6800PFAM, 16
hu6800PMID, 16
hu6800PMID2PROBE (hu6800PMID), 16
hu6800PROSITE, 17
hu6800REFSEQ, 18
hu6800SYMBOL, 19
hu6800UNIPROT, 20
hu6800UNIPROT2PROBE (hu6800UNIPROT), 20

Index

∗ datasets

hu6800.db, 2
hu6800_dbconn, 21
hu6800ACCNUM, 1
hu6800ALIAS2PROBE, 2
hu6800CHR, 3
hu6800CHRLENGTHS, 4
hu6800CHRLOC, 4
hu6800ENSEMBL, 5
hu6800ENTREZID, 6
hu6800ENZYME, 7
hu6800GENENAME, 9
hu6800GO, 10
hu6800MAP, 12
hu6800MAPCOUNTS, 13
hu6800OMIM, 13
hu6800ORGANISM, 14
hu6800PATH, 15
hu6800PFAM, 16
hu6800PMID, 16
hu6800PROSITE, 17
hu6800REFSEQ, 18
hu6800SYMBOL, 19
hu6800UNIPROT, 20

∗ utilities

hu6800_dbconn, 21

AnnDbObj, 21

cat, 21
checkMAPCOUNTS, 13

dbconn, 21
dbConnect, 21
dbDisconnect, 21
dbfile, 21
dbGetQuery, 21
dbInfo, 21
dbschema, 21

hu6800 (hu6800.db), 2
hu6800.db, 2
hu6800_dbconn, 21
hu6800_dbfile (hu6800_dbconn), 21

23

