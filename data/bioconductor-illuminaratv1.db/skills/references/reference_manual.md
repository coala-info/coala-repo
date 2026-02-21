illuminaRatv1.db

February 11, 2026

illuminaRatv1ACCNUM

Map Manufacturer identifiers to Accession Numbers

Description

illuminaRatv1ACCNUM is an R object that contains mappings between a manufacturer’s identifiers
and manufacturers accessions.

Details

For chip packages such as this, the ACCNUM mapping comes directly from the manufacturer. This
is different from other mappings which are mapped onto the probes via an Entrez Gene identifier.

Each manufacturer identifier maps to a vector containing a GenBank accession number.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

Examples

x <- illuminaRatv1ACCNUM
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

illuminaRatv1.db

illuminaRatv1ALIAS2PROBE

Map between Common Gene Symbol Identifiers and Manufacturer
Identifiers

Description

illuminaRatv1ALIAS is an R object that provides mappings between common gene symbol identi-
fiers and manufacturer identifiers.

Details

Each gene symbol is mapped to a named vector of manufacturer identifiers. The name represents
the gene symbol and the vector contains all manufacturer identifiers that are found for that symbol.
An NA is reported for any gene symbol that cannot be mapped to any manufacturer identifiers.

This mapping includes ALL gene symbols including those which are already listed in the SYMBOL
map. The SYMBOL map is meant to only list official gene symbols, while the ALIAS maps are
meant to store all used symbols.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

Examples

# Convert the object to a list
xx <- as.list(illuminaRatv1ALIAS2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two aliases
xx[1:2]
# Get the first one
xx[[1]]

}

illuminaRatv1.db

Bioconductor annotation data package

Description

Welcome to the illuminaRatv1.db annotation Package. The purpose of this package is to provide
detailed information about the illuminaRatv1 platform. This package is updated biannually.

You can learn what objects this package supports with the following command:

ls("package:illuminaRatv1.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:illuminaRatv1.db")

illuminaRatv1CHR

3

illuminaRatv1CHR

Map Manufacturer IDs to Chromosomes

Description

illuminaRatv1CHR is an R object that provides mappings between a manufacturer identifier and the
chromosome that contains the gene of interest.

Details

Each manufacturer identifier maps to a vector of chromosomes. Due to inconsistencies that may
exist at the time the object was built, the vector may contain more than one chromosome (e.g., the
identifier may map to more than one chromosome). If the chromosomal location is unknown, the
vector will contain an NA.
Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

Examples

x <- illuminaRatv1CHR
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

illuminaRatv1CHRLENGTHS

A named vector for the length of each of the chromosomes

Description

illuminaRatv1CHRLENGTHS provides the length measured in base pairs for each of the chromo-
somes.

Details

This is a named vector with chromosome numbers as the names and the corresponding lengths for
chromosomes as the values.

Total lengths of chromosomes were derived by calculating the number of base pairs on the sequence
string for each chromosome.

Examples

tt <- illuminaRatv1CHRLENGTHS
# Length of chromosome 1
tt["1"]

4

illuminaRatv1ENSEMBL

illuminaRatv1CHRLOC

Map Manufacturer IDs to Chromosomal Location

Description

illuminaRatv1CHRLOC is an R object that maps manufacturer identifiers to the starting position of
the gene. The position of a gene is measured as the number of base pairs.

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

Mappings were based on data provided by: UCSC Genome Bioinformatics (Rattus norvegicus)
ftp://hgdownload.cse.ucsc.edu/goldenPath/rn6 With a date stamp from the source of: 2014-Aug1

Examples

x <- illuminaRatv1CHRLOC
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

illuminaRatv1ENSEMBL Map Ensembl gene accession numbers with Entrez Gene identifiers

Description

illuminaRatv1ENSEMBL is an R object that contains mappings between manufacturer identifiers
and Ensembl gene accession numbers.

illuminaRatv1ENTREZID

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

x <- illuminaRatv1ENSEMBL
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
xx <- as.list(illuminaRatv1ENSEMBL2PROBE)
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

illuminaRatv1ENTREZID Map between Manufacturer Identifiers and Entrez Gene

Description

illuminaRatv1ENTREZID is an R object that provides mappings between manufacturer identifiers
and Entrez Gene identifiers.

Details

Each manufacturer identifier is mapped to a vector of Entrez Gene identifiers. An NA is assigned to
those manufacturer identifiers that can not be mapped to an Entrez Gene identifier at this time.

If a given manufacturer identifier can be mapped to different Entrez Gene identifiers from various
sources, we attempt to select the common identifiers. If a concensus cannot be determined, we
select the smallest identifier.

6

illuminaRatv1ENZYME

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- illuminaRatv1ENTREZID
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

illuminaRatv1ENZYME

Maps between Manufacturer IDs and Enzyme Commission (EC) Num-
bers

Description

illuminaRatv1ENZYME is an R object that provides mappings between manufacturer identifiers
and EC numbers. illuminaRatv1ENZYME2PROBE is an R object that maps Enzyme Commission
(EC) numbers to manufacturer identifiers.

Details

When the illuminaRatv1ENZYME maping viewed as a list, each manufacturer identifier maps to
a named vector containing the EC number that corresponds to the enzyme produced by that gene.
The names corresponds to the manufacturer identifiers. If this information is unknown, the vector
will contain an NA.

For the illuminaRatv1ENZYME2PROBE, each EC number maps to a named vector containing all
of the manufacturer identifiers that correspond to the gene that produces that enzyme. The name of
the vector corresponds to the EC number.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric num-
bers. In illuminaRatv1ENZYME2PROBE, EC is dropped from the Enzyme Commission numbers.

Enzyme Commission numbers have corresponding names that describe the functions of enzymes
in such a way that EC x is a more general description than EC x.y that in turn is a more general
description than EC x.y.z. The top level EC numbers and names are listed below:

EC 1 oxidoreductases

EC 2 transferases

illuminaRatv1GENENAME

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

x <- illuminaRatv1ENZYME
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

# Now convert illuminaRatv1ENZYME2PROBE to a list to see inside
xx <- as.list(illuminaRatv1ENZYME2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first five enzyme
#commission numbers
xx[1:5]
# Get the first one
xx[[1]]

}

illuminaRatv1GENENAME Map between Manufacturer IDs and Genes

Description

illuminaRatv1GENENAME is an R object that maps manufacturer identifiers to the corresponding
gene name.

Details

Each manufacturer identifier maps to a named vector containing the gene name. The vector name
corresponds to the manufacturer identifier. If the gene name is unknown, the vector will contain an
NA.

8

illuminaRatv1GO

Gene names currently include both the official (validated by a nomenclature committee) and pre-
ferred names (interim selected for display) for genes. Efforts are being made to differentiate the
two by adding a name to the vector.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

Examples

x <- illuminaRatv1GENENAME
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

illuminaRatv1GO

Maps between manufacturer IDs and Gene Ontology (GO) IDs

Description

illuminaRatv1GO is an R object that provides mappings between manufacturer identifiers and the
GO identifiers that they are directly associated with. This mapping and its reverse mapping (illumi-
naRatv1GO2PROBE) do NOT associate the child terms from the GO ontology with the gene. Only
the directly evidenced terms are represented here.

illuminaRatv1GO2ALLPROBES is an R object that provides mappings between a given GO identi-
fier and all of the manufacturer identifiers annotated at that GO term OR TO ONE OF IT’S CHILD
NODES in the GO ontology. Thus, this mapping is much larger and more inclusive than illumi-
naRatv1GO2PROBE.

Details

If illuminaRatv1GO is cast as a list, each manufacturer identifier is mapped to a list of lists. The
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

illuminaRatv1GO

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

If illuminaRatv1GO2ALLPROBES or illuminaRatv1GO2PROBE is cast as a list, each GO term
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
lite/ With a date stamp from the source of: 20150314

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

See Also

illuminaRatv1GO2ALLPROBES.

Examples

x <- illuminaRatv1GO
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
xx <- as.list(illuminaRatv1GO2PROBE)
if(length(xx) > 0){

10

illuminaRatv1MAPCOUNTS

# Gets the manufacturer ids for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets the manufacturer ids for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}
# Convert illuminaRatv1GO2ALLPROBES to a list
xx <- as.list(illuminaRatv1GO2ALLPROBES)
if(length(xx) > 0){

# Gets the manufacturer identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets all the manufacturer identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

illuminaRatv1MAPCOUNTS

Number of mapped keys for the maps in package illuminaRatv1.db

Description

illuminaRatv1MAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each
map in package illuminaRatv1.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

Examples

illuminaRatv1MAPCOUNTS
mapnames <- names(illuminaRatv1MAPCOUNTS)
illuminaRatv1MAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package illuminaRatv1.db
checkMAPCOUNTS("illuminaRatv1.db")

illuminaRatv1listNewMappings

11

illuminaRatv1listNewMappings

Custom mappings added to the package

Description

We have used an extensive re-annotation of the illuminaRatv1 probe sequences to provide additional
information that is not captured in the standard Bioconductor packages. Whereas Bioconductor
annotations are based on the RefSeq ID that each probe maps to, our additional mappings provide
data specific to each probe on the platform. See below for details. We recommend using the probe
quality as a form of filtering, and retaining only perfect or good probes for an analysis.

Details of custom mappings

illuminaRatv1listNewMappings List all the custom re-annotation mappings provided by the pack-

age

illuminaRatv1fullReannotation Return all the re-annotation information as a matrix

illuminaRatv1ARRAYADDRESS Array Address code used to identify the probe at the bead-level

illuminaRatv1NUID Lumi’s nuID (universal naming scheme for oligonucleotides) Reference: Du

et al. (2007), Biol Direct 2:16

illuminaRatv1PROBESEQUENCE The 50 base sequence for the probe

illuminaRatv1PROBEQUALITY Quality grade assigned to the probe: “Perfect” if it perfectly
and uniquely matches the target transcript; “Good” if the probe, although imperfectly match-
ing the target transcript, is still likely to provide considerably sensitive signal (up to two mis-
matches are allowed, based on empirical evidence that the signal intensity for 50-mer probes
with less than 95% identity to the respective targets is less than 50% of the signal associated
with perfect matches *); “Bad” if the probe matches repeat sequences, intergenic or intronic
regions, or is unlikely to provide specific signal for any transcript; “No match” if it does not
match any genomic region or transcript.

illuminaRatv1CODINGZONE Coding status of target sequence: intergenic / intronic / Transcrip-
tomic (“Transcriptomic” when the target transcript is non-coding or there is no information on
the coding sequence)

illuminaRatv1GENOMICLOCATION Probe’s genomic coordinates (hg19 for human, mm9 for

mouse or rn4 for rat)

illuminaRatv1GENOMICMATCHSIMILARITY Percentage of similarity between the probe

and its best genomic match in the alignable region, taking the probe as reference

illuminaRatv1SECONDMATCHES Genomic coordinates of second best matches between the

probe and the genome

illuminaRatv1SECONDMATCHSIMILARITY Percentage of similarity between the probe and

its second best genomic match in the alignable region, taking the probe as reference

illuminaRatv1TRANSCRIPTOMICMATCHSIMILARITY Percentage of similarity between
the probe and its target transcript in the alignable region, taking the probe as reference

illuminaRatv1OTHERGENOMICMATCHES Genomic coordinates of sequences as alignable

with the probe (in terms of number of matching nucleotides) as its main target

illuminaRatv1REPEATMASK Overlapping RepeatMasked sequences, with number of bases over-

lapped by the repeat

12

illuminaRatv1listNewMappings

illuminaRatv1OVERLAPPINGSNP Overlapping annotated SNPs

illuminaRatv1ENTREZREANNOTATED Entrez IDs

illuminaRatv1ENSEMBLREANNOTATED Ensembl IDs

illuminaRatv1SYMBOLREANNOTATED Gene symbol derived by re-annotation

illuminaRatv1REPORTERGROUPID For probes marked as controls in Illuminas annotation

file, these gives the type of control

illuminaRatv1REPORTERGROUPNAME Usually a more informative name for the control type

References

http://remoat.sysbiol.cam.ac.uk

Barbosa-Morais et al. (2010) A re-annotation pipeline for Illumina BeadArrays: improving the
interpretation of gene expression data. Nucleic Acids Research

Examples

##See what new mappings are available

illuminaRatv1listNewMappings()

x <- illuminaRatv1PROBEQUALITY

mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the PROBEQUALITY for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

##Overall table of qualities
table(unlist(xx))

x <- illuminaRatv1ARRAYADDRESS

mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the ARRAYADDRESS for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

##Can do the mapping from array address to illumina ID using a revmap

y<- revmap(illuminaRatv1ARRAYADDRESS)

illuminaRatv1ORGANISM

13

mapped_probes <- mappedkeys(y)
# Convert to a list
yy <- as.list(y[mapped_probes])
if(length(yy) > 0) {

# Get the ARRAYADDRESS for the first five probes
yy[1:5]
# Get the first one
yy[[1]]

}

x <- illuminaRatv1CODINGZONE

mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the CODINGZONE for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

x <- illuminaRatv1PROBESEQUENCE

mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the PROBESEQUENCE for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

illuminaRatv1ORGANISM The Organism information for illuminaRatv1

Description

illuminaRatv1ORGANISM is an R object that contains a single item: a character string that names
the organism for which illuminaRatv1 was built. illuminaRatv1ORGPKG is an R object that con-
tains a chararcter vector with the name of the organism package that a chip package depends on for
its gene-centric annotation.

Details

Although the package name is suggestive of the organism for which it was built, illuminaRatv1ORGANISM
provides a simple way to programmatically extract the organism name.
illuminaRatv1ORGPKG
provides a simple way to programmatically extract the name of the parent organism package. The

14

illuminaRatv1PATH

parent organism package is a strict dependency for chip packages as this is where the gene cetric
information is ultimately extracted from. The full package name will always be this string plus the
extension ".db". But most programatic acces will not require this extension, so its more convenient
to leave it out.

Examples

illuminaRatv1ORGANISM
illuminaRatv1ORGPKG

illuminaRatv1PATH

Mappings between probe identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms.

illuminaRatv1PATH maps probe identifiers to the identifiers used by KEGG for pathways in which
the genes represented by the probe identifiers are involved

illuminaRatv1PATH2PROBE is an R object that provides mappings between KEGG identifiers and
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

x <- illuminaRatv1PATH
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

# Now convert the illuminaRatv1PATH2PROBE object to a list
xx <- as.list(illuminaRatv1PATH2PROBE)

illuminaRatv1PMID

if(length(xx) > 0){

15

# Get the probe identifiers for the first two pathway identifiers
xx[1:2]
# Get the first one
xx[[1]]

}

illuminaRatv1PMID

Maps between Manufacturer Identifiers and PubMed Identifiers

Description

illuminaRatv1PMID is an R object that provides mappings between manufacturer identifiers and
PubMed identifiers. illuminaRatv1PMID2PROBE is an R object that provides mappings between
PubMed identifiers and manufacturer identifiers.

Details

When illuminaRatv1PMID is viewed as a list each manufacturer identifier is mapped to a named
vector of PubMed identifiers. The name associated with each vector corresponds to the manufac-
turer identifier. The length of the vector may be one or greater, depending on how many PubMed
identifiers a given manufacturer identifier is mapped to. An NA is reported for any manufacturer
identifier that cannot be mapped to a PubMed identifier.

When illuminaRatv1PMID2PROBE is viewed as a list each PubMed identifier is mapped to a
named vector of manufacturer identifiers. The name represents the PubMed identifier and the vector
contains all manufacturer identifiers that are represented by that PubMed identifier. The length of
the vector may be one or longer, depending on how many manufacturer identifiers are mapped to a
given PubMed identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=PubMed

Examples

x <- illuminaRatv1PMID
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

16

illuminaRatv1REFSEQ

xmls <- pubmed(xx[[1]], disp = "data")
# View article information using a browser
pubmed(xx[[1]], disp = "browser")

}

}

# Now convert the reverse map object illuminaRatv1PMID2PROBE to a list
xx <- as.list(illuminaRatv1PMID2PROBE)
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

illuminaRatv1REFSEQ

Map between Manufacturer Identifiers and RefSeq Identifiers

Description

illuminaRatv1REFSEQ is an R object that provides mappings between manufacturer identifiers and
RefSeq identifiers.

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
a date stamp from the source of: 2015-Mar17

17

illuminaRatv1SYMBOL

References

http://www.ncbi.nlm.nih.gov http://www.ncbi.nlm.nih.gov/RefSeq/

Examples

x <- illuminaRatv1REFSEQ
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

illuminaRatv1SYMBOL

Map between Manufacturer Identifiers and Gene Symbols

Description

illuminaRatv1SYMBOL is an R object that provides mappings between manufacturer identifiers
and gene abbreviations.

Details

Each manufacturer identifier is mapped to an abbreviation for the corresponding gene. An NA is
reported if there is no known abbreviation for a given gene.

Symbols typically consist of 3 letters that define either a single gene (ABC) or multiple genes
(ABC1, ABC2, ABC3). Gene symbols can be used as key words to query public databases such as
Entrez Gene.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- illuminaRatv1SYMBOL
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

illuminaRatv1UNIPROT

illuminaRatv1UNIGENE Map between Manufacturer Identifiers and UniGene cluster identifiers

Description

illuminaRatv1UNIGENE is an R object that provides mappings between manufacturer identifiers
and UniGene identifiers.

Details

Each manufacturer identifier is mapped to a UniGene identifier. An NA is reported if the manufac-
turer identifier cannot be mapped to UniGene at this time.

A UniGene identifier represents a cluster of sequences of a gene. Using UniGene identifiers one
can query the UniGene database for information about the sequences or the Entrez Gene database
for information about the genes.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- illuminaRatv1UNIGENE
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

illuminaRatv1UNIPROT Map Uniprot accession numbers with Entrez Gene identifiers

Description

illuminaRatv1UNIPROT is an R object that contains mappings between the manufacturer identifiers
and Uniprot accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to Uniprot Accessions.

Mappings were based on data provided by NCBI (link above) with an exception for fly, which
required retrieving the data from ensembl http://www.ensembl.org/biomart/martview/

illuminaRatv1_dbconn

Examples

19

x <- illuminaRatv1UNIPROT
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

illuminaRatv1_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

illuminaRatv1_dbconn()
illuminaRatv1_dbfile()
illuminaRatv1_dbschema(file="", show.indices=FALSE)
illuminaRatv1_dbInfo()

Arguments

file

show.indices

Details

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).
The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

illuminaRatv1_dbconn returns a connection object to the package annotation DB. IMPORTANT:
Don’t call dbDisconnect on the connection object returned by illuminaRatv1_dbconn or you will
break all the AnnDbObj objects defined in this package!
illuminaRatv1_dbfile returns the path (character string) to the package annotation DB (this is an
SQLite file).
illuminaRatv1_dbschema prints the schema definition of the package annotation DB.
illuminaRatv1_dbInfo prints other information about the package annotation DB.

Value

illuminaRatv1_dbconn: a DBIConnection object representing an open connection to the package
annotation DB.
illuminaRatv1_dbfile: a character string with the path to the package annotation DB.
illuminaRatv1_dbschema: none (invisible NULL).
illuminaRatv1_dbInfo: none (invisible NULL).

20

See Also

illuminaRatv1_dbconn

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

## Count the number of rows in the "probes" table:
dbGetQuery(illuminaRatv1_dbconn(), "SELECT COUNT(*) FROM probes")

illuminaRatv1_dbschema()

illuminaRatv1_dbInfo()

Index

∗ datasets

illuminaRatv1.db, 2
illuminaRatv1_dbconn, 19
illuminaRatv1ACCNUM, 1
illuminaRatv1ALIAS2PROBE, 2
illuminaRatv1CHR, 3
illuminaRatv1CHRLENGTHS, 3
illuminaRatv1CHRLOC, 4
illuminaRatv1ENSEMBL, 4
illuminaRatv1ENTREZID, 5
illuminaRatv1ENZYME, 6
illuminaRatv1GENENAME, 7
illuminaRatv1GO, 8
illuminaRatv1listNewMappings, 11
illuminaRatv1MAPCOUNTS, 10
illuminaRatv1ORGANISM, 13
illuminaRatv1PATH, 14
illuminaRatv1PMID, 15
illuminaRatv1REFSEQ, 16
illuminaRatv1SYMBOL, 17
illuminaRatv1UNIGENE, 18
illuminaRatv1UNIPROT, 18

∗ utilities

illuminaRatv1_dbconn, 19

AnnDbObj, 19

cat, 19
checkMAPCOUNTS, 10
count.mappedkeys, 10

dbconn, 20
dbConnect, 20
dbDisconnect, 19
dbfile, 20
dbGetQuery, 20
dbInfo, 20
dbschema, 20

illuminaRatv1 (illuminaRatv1.db), 2
illuminaRatv1.db, 2
illuminaRatv1_dbconn, 19
illuminaRatv1_dbfile

(illuminaRatv1_dbconn), 19

21

illuminaRatv1_dbInfo

(illuminaRatv1_dbconn), 19

illuminaRatv1_dbschema

(illuminaRatv1_dbconn), 19

illuminaRatv1ACCNUM, 1
illuminaRatv1ALIAS2PROBE, 2
illuminaRatv1ARRAYADDRESS

(illuminaRatv1listNewMappings),
11
illuminaRatv1CHR, 3
illuminaRatv1CHRLENGTHS, 3
illuminaRatv1CHRLOC, 4
illuminaRatv1CHRLOCEND

(illuminaRatv1CHRLOC), 4

illuminaRatv1CODINGZONE

(illuminaRatv1listNewMappings),
11

illuminaRatv1ENSEMBL, 4
illuminaRatv1ENSEMBL2PROBE

(illuminaRatv1ENSEMBL), 4
illuminaRatv1ENSEMBLREANNOTATED

(illuminaRatv1listNewMappings),
11

illuminaRatv1ENTREZID, 5
illuminaRatv1ENTREZREANNOTATED

(illuminaRatv1listNewMappings),
11

illuminaRatv1ENZYME, 6
illuminaRatv1ENZYME2PROBE

(illuminaRatv1ENZYME), 6

illuminaRatv1fullReannotation

(illuminaRatv1listNewMappings),
11

illuminaRatv1GENENAME, 7
illuminaRatv1GENOMICLOCATION

(illuminaRatv1listNewMappings),
11

illuminaRatv1GENOMICMATCHSIMILARITY

(illuminaRatv1listNewMappings),
11
illuminaRatv1GO, 8
illuminaRatv1GO2ALLPROBES, 9
illuminaRatv1GO2ALLPROBES

22

INDEX

(illuminaRatv1listNewMappings),
11

illuminaRatv1UNIGENE, 18
illuminaRatv1UNIPROT, 18
illuminaRatv1UNIPROT2PROBE

(illuminaRatv1UNIPROT), 18

mappedkeys, 10

(illuminaRatv1GO), 8

illuminaRatv1GO2PROBE

(illuminaRatv1GO), 8

illuminaRatv1listNewMappings, 11
illuminaRatv1LOCUSID

(illuminaRatv1ENTREZID), 5

illuminaRatv1MAPCOUNTS, 10
illuminaRatv1NUID

(illuminaRatv1listNewMappings),
11

illuminaRatv1ORGANISM, 13
illuminaRatv1ORGPKG

(illuminaRatv1ORGANISM), 13

illuminaRatv1OTHERGENOMICMATCHES

(illuminaRatv1listNewMappings),
11

illuminaRatv1OVERLAPPINGSNP

(illuminaRatv1listNewMappings),
11
illuminaRatv1PATH, 14
illuminaRatv1PATH2PROBE

(illuminaRatv1PATH), 14

illuminaRatv1PMID, 15
illuminaRatv1PMID2PROBE

(illuminaRatv1PMID), 15

illuminaRatv1PROBEQUALITY

(illuminaRatv1listNewMappings),
11

illuminaRatv1PROBESEQUENCE

(illuminaRatv1listNewMappings),
11

illuminaRatv1REFSEQ, 16
illuminaRatv1REPEATMASK

(illuminaRatv1listNewMappings),
11

illuminaRatv1REPORTERGROUPID

(illuminaRatv1listNewMappings),
11

illuminaRatv1REPORTERGROUPNAME

(illuminaRatv1listNewMappings),
11

illuminaRatv1SECONDMATCHES

(illuminaRatv1listNewMappings),
11

illuminaRatv1SECONDMATCHSIMILARITY

(illuminaRatv1listNewMappings),
11

illuminaRatv1SYMBOL, 17
illuminaRatv1SYMBOLREANNOTATED

(illuminaRatv1listNewMappings),
11

illuminaRatv1TRANSCRIPTOMICMATCHSIMILARITY

