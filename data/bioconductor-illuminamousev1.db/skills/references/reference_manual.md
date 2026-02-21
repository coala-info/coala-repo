illuminaMousev1.db

February 11, 2026

illuminaMousev1ACCNUM Map Manufacturer identifiers to Accession Numbers

Description

illuminaMousev1ACCNUM is an R object that contains mappings between a manufacturer’s iden-
tifiers and manufacturers accessions.

Details

For chip packages such as this, the ACCNUM mapping comes directly from the manufacturer. This
is different from other mappings which are mapped onto the probes via an Entrez Gene identifier.

Each manufacturer identifier maps to a vector containing a GenBank accession number.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

Examples

x <- illuminaMousev1ACCNUM
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

illuminaMousev1.db

illuminaMousev1ALIAS2PROBE

Map between Common Gene Symbol Identifiers and Manufacturer
Identifiers

Description

illuminaMousev1ALIAS is an R object that provides mappings between common gene symbol
identifiers and manufacturer identifiers.

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
xx <- as.list(illuminaMousev1ALIAS2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two aliases
xx[1:2]
# Get the first one
xx[[1]]

}

illuminaMousev1.db

Bioconductor annotation data package

Description

Welcome to the illuminaMousev1.db annotation Package. The purpose of this package is to provide
detailed information about the illuminaMousev1 platform. This package is updated biannually.

You can learn what objects this package supports with the following command:

ls("package:illuminaMousev1.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:illuminaMousev1.db")

illuminaMousev1CHR

3

illuminaMousev1CHR

Map Manufacturer IDs to Chromosomes

Description

illuminaMousev1CHR is an R object that provides mappings between a manufacturer identifier and
the chromosome that contains the gene of interest.

Details

Each manufacturer identifier maps to a vector of chromosomes. Due to inconsistencies that may
exist at the time the object was built, the vector may contain more than one chromosome (e.g., the
identifier may map to more than one chromosome). If the chromosomal location is unknown, the
vector will contain an NA.
Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

Examples

x <- illuminaMousev1CHR
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

illuminaMousev1CHRLENGTHS

A named vector for the length of each of the chromosomes

Description

illuminaMousev1CHRLENGTHS provides the length measured in base pairs for each of the chro-
mosomes.

Details

This is a named vector with chromosome numbers as the names and the corresponding lengths for
chromosomes as the values.

Total lengths of chromosomes were derived by calculating the number of base pairs on the sequence
string for each chromosome.

Examples

tt <- illuminaMousev1CHRLENGTHS
# Length of chromosome 1
tt["1"]

4

illuminaMousev1ENSEMBL

illuminaMousev1CHRLOC Map Manufacturer IDs to Chromosomal Location

Description

illuminaMousev1CHRLOC is an R object that maps manufacturer identifiers to the starting position
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

Mappings were based on data provided by: UCSC Genome Bioinformatics (Mus musculus) ftp://hgdownload.cse.ucsc.edu/goldenPath/mm10
With a date stamp from the source of: 2012-Mar8

Examples

x <- illuminaMousev1CHRLOC
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

illuminaMousev1ENSEMBL

Map Ensembl gene accession numbers with Entrez Gene identifiers

Description

illuminaMousev1ENSEMBL is an R object that contains mappings between manufacturer identi-
fiers and Ensembl gene accession numbers.

illuminaMousev1ENTREZID

5

Details

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

x <- illuminaMousev1ENSEMBL
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
xx <- as.list(illuminaMousev1ENSEMBL2PROBE)
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

illuminaMousev1ENTREZID

Map between Manufacturer Identifiers and Entrez Gene

Description

illuminaMousev1ENTREZID is an R object that provides mappings between manufacturer identi-
fiers and Entrez Gene identifiers.

Details

Each manufacturer identifier is mapped to a vector of Entrez Gene identifiers. An NA is assigned to
those manufacturer identifiers that can not be mapped to an Entrez Gene identifier at this time.

If a given manufacturer identifier can be mapped to different Entrez Gene identifiers from various
sources, we attempt to select the common identifiers. If a concensus cannot be determined, we
select the smallest identifier.

6

illuminaMousev1ENZYME

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- illuminaMousev1ENTREZID
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

illuminaMousev1ENZYME Maps between Manufacturer IDs and Enzyme Commission (EC) Num-

bers

Description

illuminaMousev1ENZYME is an R object that provides mappings between manufacturer identifiers
and EC numbers. illuminaMousev1ENZYME2PROBE is an R object that maps Enzyme Commis-
sion (EC) numbers to manufacturer identifiers.

Details

When the illuminaMousev1ENZYME maping viewed as a list, each manufacturer identifier maps
to a named vector containing the EC number that corresponds to the enzyme produced by that gene.
The names corresponds to the manufacturer identifiers. If this information is unknown, the vector
will contain an NA.

For the illuminaMousev1ENZYME2PROBE, each EC number maps to a named vector containing
all of the manufacturer identifiers that correspond to the gene that produces that enzyme. The name
of the vector corresponds to the EC number.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In illuminaMousev1ENZYME2PROBE, EC is dropped from the Enzyme Commission
numbers.

Enzyme Commission numbers have corresponding names that describe the functions of enzymes
in such a way that EC x is a more general description than EC x.y that in turn is a more general
description than EC x.y.z. The top level EC numbers and names are listed below:

EC 1 oxidoreductases

EC 2 transferases

illuminaMousev1GENENAME

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

x <- illuminaMousev1ENZYME
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

# Now convert illuminaMousev1ENZYME2PROBE to a list to see inside
xx <- as.list(illuminaMousev1ENZYME2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first five enzyme
#commission numbers
xx[1:5]
# Get the first one
xx[[1]]

}

illuminaMousev1GENENAME

Map between Manufacturer IDs and Genes

Description

illuminaMousev1GENENAME is an R object that maps manufacturer identifiers to the correspond-
ing gene name.

8

Details

illuminaMousev1GO

Each manufacturer identifier maps to a named vector containing the gene name. The vector name
corresponds to the manufacturer identifier. If the gene name is unknown, the vector will contain an
NA.

Gene names currently include both the official (validated by a nomenclature committee) and pre-
ferred names (interim selected for display) for genes. Efforts are being made to differentiate the
two by adding a name to the vector.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

Examples

x <- illuminaMousev1GENENAME
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

illuminaMousev1GO

Maps between manufacturer IDs and Gene Ontology (GO) IDs

Description

illuminaMousev1GO is an R object that provides mappings between manufacturer identifiers and
the GO identifiers that they are directly associated with. This mapping and its reverse mapping
(illuminaMousev1GO2PROBE) do NOT associate the child terms from the GO ontology with the
gene. Only the directly evidenced terms are represented here.

illuminaMousev1GO2ALLPROBES is an R object that provides mappings between a given GO
identifier and all of the manufacturer identifiers annotated at that GO term OR TO ONE OF IT’S
CHILD NODES in the GO ontology. Thus, this mapping is much larger and more inclusive than
illuminaMousev1GO2PROBE.

Details

If illuminaMousev1GO is cast as a list, each manufacturer identifier is mapped to a list of lists. The
names on the outer list are GO identifiers. Each inner list consists of three named elements: GOID,
Ontology, and Evidence.

The GOID element matches the GO identifier named in the outer list and is included for convenience
when processing the data using ’lapply’.

The Ontology element indicates which of the three Gene Ontology categories this identifier belongs
to. The categories are biological process (BP), cellular component (CC), and molecular function
(MF).

The Evidence element contains a code indicating what kind of evidence supports the association of
the GO identifier to the manufacturer id. Some of the evidence codes in use include:

illuminaMousev1GO

9

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

If illuminaMousev1GO2ALLPROBES or illuminaMousev1GO2PROBE is cast as a list, each GO
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

All mappings were based on data provided by: Gene Ontology ftp://ftp.geneontology.org/pub/go/godatabase/archive/latest-
lite/ With a date stamp from the source of: 20150314

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

See Also

illuminaMousev1GO2ALLPROBES.

Examples

x <- illuminaMousev1GO
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

10

illuminaMousev1MAPCOUNTS

# For the reverse map:
# Convert to a list
xx <- as.list(illuminaMousev1GO2PROBE)
if(length(xx) > 0){

# Gets the manufacturer ids for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets the manufacturer ids for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}
# Convert illuminaMousev1GO2ALLPROBES to a list
xx <- as.list(illuminaMousev1GO2ALLPROBES)
if(length(xx) > 0){

# Gets the manufacturer identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets all the manufacturer identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

illuminaMousev1MAPCOUNTS

Number of mapped keys for the maps in package illuminaMousev1.db

Description

illuminaMousev1MAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each
map in package illuminaMousev1.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

Examples

illuminaMousev1MAPCOUNTS
mapnames <- names(illuminaMousev1MAPCOUNTS)
illuminaMousev1MAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package illuminaMousev1.db
checkMAPCOUNTS("illuminaMousev1.db")

illuminaMousev1MGI

11

illuminaMousev1MGI

Map MGI gene accession numbers with manufacturer identifiers

Description

illuminaMousev1MGI is an R object that contains mappings between manufacturer identifiers and
Jackson Laboratory MGI gene accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to MGI gene Accession Numbers.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

Examples

x <- illuminaMousev1MGI
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
xx <- as.list(illuminaMousev1MGI2PROBE)
if(length(xx) > 0){

# Gets the manufacturer IDs for the first five MGI IDs
xx[1:5]
# Get the first one
xx[[1]]

}

illuminaMousev1listNewMappings

Custom mappings added to the package

Description

We have used an extensive re-annotation of the illuminaMousev1 probe sequences to provide ad-
ditional information that is not captured in the standard Bioconductor packages. Whereas Biocon-
ductor annotations are based on the RefSeq ID that each probe maps to, our additional mappings
provide data specific to each probe on the platform. See below for details. We recommend using
the probe quality as a form of filtering, and retaining only perfect or good probes for an analysis.

12

illuminaMousev1listNewMappings

Details of custom mappings

illuminaMousev1listNewMappings List all the custom re-annotation mappings provided by the

package

illuminaMousev1fullReannotation Return all the re-annotation information as a matrix
illuminaMousev1ARRAYADDRESS Array Address code used to identify the probe at the bead-

level

illuminaMousev1NUID Lumi’s nuID (universal naming scheme for oligonucleotides) Reference:

Du et al. (2007), Biol Direct 2:16

illuminaMousev1PROBESEQUENCE The 50 base sequence for the probe
illuminaMousev1PROBEQUALITY Quality grade assigned to the probe: “Perfect” if it perfectly
and uniquely matches the target transcript; “Good” if the probe, although imperfectly match-
ing the target transcript, is still likely to provide considerably sensitive signal (up to two mis-
matches are allowed, based on empirical evidence that the signal intensity for 50-mer probes
with less than 95% identity to the respective targets is less than 50% of the signal associated
with perfect matches *); “Bad” if the probe matches repeat sequences, intergenic or intronic
regions, or is unlikely to provide specific signal for any transcript; “No match” if it does not
match any genomic region or transcript.

illuminaMousev1CODINGZONE Coding status of target sequence: intergenic / intronic / Tran-
scriptomic (“Transcriptomic” when the target transcript is non-coding or there is no informa-
tion on the coding sequence)

illuminaMousev1GENOMICLOCATION Probe’s genomic coordinates (hg19 for human, mm9

for mouse or rn4 for rat)

illuminaMousev1GENOMICMATCHSIMILARITY Percentage of similarity between the probe

and its best genomic match in the alignable region, taking the probe as reference

illuminaMousev1SECONDMATCHES Genomic coordinates of second best matches between

the probe and the genome

illuminaMousev1SECONDMATCHSIMILARITY Percentage of similarity between the probe
and its second best genomic match in the alignable region, taking the probe as reference
illuminaMousev1TRANSCRIPTOMICMATCHSIMILARITY Percentage of similarity between

the probe and its target transcript in the alignable region, taking the probe as reference

illuminaMousev1OTHERGENOMICMATCHES Genomic coordinates of sequences as alignable

with the probe (in terms of number of matching nucleotides) as its main target

illuminaMousev1REPEATMASK Overlapping RepeatMasked sequences, with number of bases

overlapped by the repeat

illuminaMousev1OVERLAPPINGSNP Overlapping annotated SNPs
illuminaMousev1ENTREZREANNOTATED Entrez IDs
illuminaMousev1ENSEMBLREANNOTATED Ensembl IDs
illuminaMousev1SYMBOLREANNOTATED Gene symbol derived by re-annotation
illuminaMousev1REPORTERGROUPID For probes marked as controls in Illuminas annotation

file, these gives the type of control

illuminaMousev1REPORTERGROUPNAME Usually a more informative name for the control

type

References

http://remoat.sysbiol.cam.ac.uk

Barbosa-Morais et al. (2010) A re-annotation pipeline for Illumina BeadArrays: improving the
interpretation of gene expression data. Nucleic Acids Research

illuminaMousev1listNewMappings

13

Examples

##See what new mappings are available

illuminaMousev1listNewMappings()

x <- illuminaMousev1PROBEQUALITY

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

x <- illuminaMousev1ARRAYADDRESS

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

y<- revmap(illuminaMousev1ARRAYADDRESS)

mapped_probes <- mappedkeys(y)
# Convert to a list
yy <- as.list(y[mapped_probes])
if(length(yy) > 0) {

# Get the ARRAYADDRESS for the first five probes
yy[1:5]
# Get the first one
yy[[1]]

}

x <- illuminaMousev1CODINGZONE

mapped_probes <- mappedkeys(x)
# Convert to a list

14

illuminaMousev1ORGANISM

xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the CODINGZONE for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

x <- illuminaMousev1PROBESEQUENCE

mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the PROBESEQUENCE for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

illuminaMousev1ORGANISM

The Organism information for illuminaMousev1

Description

illuminaMousev1ORGANISM is an R object that contains a single item: a character string that
illuminaMousev1ORGPKG is an R
names the organism for which illuminaMousev1 was built.
object that contains a chararcter vector with the name of the organism package that a chip package
depends on for its gene-centric annotation.

Details

Although the package name is suggestive of the organism for which it was built, illuminaMou-
sev1ORGANISM provides a simple way to programmatically extract the organism name. illumi-
naMousev1ORGPKG provides a simple way to programmatically extract the name of the parent
organism package. The parent organism package is a strict dependency for chip packages as this is
where the gene cetric information is ultimately extracted from. The full package name will always
be this string plus the extension ".db". But most programatic acces will not require this extension,
so its more convenient to leave it out.

Examples

illuminaMousev1ORGANISM
illuminaMousev1ORGPKG

illuminaMousev1PATH

15

illuminaMousev1PATH

Mappings between probe identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms.

illuminaMousev1PATH maps probe identifiers to the identifiers used by KEGG for pathways in
which the genes represented by the probe identifiers are involved

illuminaMousev1PATH2PROBE is an R object that provides mappings between KEGG identifiers
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

Examples

x <- illuminaMousev1PATH
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

# Now convert the illuminaMousev1PATH2PROBE object to a list
xx <- as.list(illuminaMousev1PATH2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two pathway identifiers
xx[1:2]
# Get the first one
xx[[1]]

}

16

illuminaMousev1PMID

illuminaMousev1PMID

Maps between Manufacturer Identifiers and PubMed Identifiers

Description

illuminaMousev1PMID is an R object that provides mappings between manufacturer identifiers
and PubMed identifiers.
illuminaMousev1PMID2PROBE is an R object that provides mappings
between PubMed identifiers and manufacturer identifiers.

Details

When illuminaMousev1PMID is viewed as a list each manufacturer identifier is mapped to a named
vector of PubMed identifiers. The name associated with each vector corresponds to the manufac-
turer identifier. The length of the vector may be one or greater, depending on how many PubMed
identifiers a given manufacturer identifier is mapped to. An NA is reported for any manufacturer
identifier that cannot be mapped to a PubMed identifier.

When illuminaMousev1PMID2PROBE is viewed as a list each PubMed identifier is mapped to a
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

x <- illuminaMousev1PMID
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

# Now convert the reverse map object illuminaMousev1PMID2PROBE to a list

illuminaMousev1REFSEQ

17

xx <- as.list(illuminaMousev1PMID2PROBE)
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

illuminaMousev1REFSEQ Map between Manufacturer Identifiers and RefSeq Identifiers

Description

illuminaMousev1REFSEQ is an R object that provides mappings between manufacturer identifiers
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

NCBI http://www.ncbi.nlm.nih.gov/RefSeq/ allows users to query the RefSeq database using
RefSeq identifiers.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

References

http://www.ncbi.nlm.nih.gov http://www.ncbi.nlm.nih.gov/RefSeq/

18

Examples

illuminaMousev1SYMBOL

x <- illuminaMousev1REFSEQ
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

illuminaMousev1SYMBOL Map between Manufacturer Identifiers and Gene Symbols

Description

illuminaMousev1SYMBOL is an R object that provides mappings between manufacturer identifiers
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

x <- illuminaMousev1SYMBOL
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

illuminaMousev1UNIGENE

19

illuminaMousev1UNIGENE

Map between Manufacturer Identifiers and UniGene cluster identifiers

Description

illuminaMousev1UNIGENE is an R object that provides mappings between manufacturer identi-
fiers and UniGene identifiers.

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

x <- illuminaMousev1UNIGENE
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

illuminaMousev1UNIPROT

Map Uniprot accession numbers with Entrez Gene identifiers

Description

illuminaMousev1UNIPROT is an R object that contains mappings between the manufacturer iden-
tifiers and Uniprot accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to Uniprot Accessions.

Mappings were based on data provided by NCBI (link above) with an exception for fly, which
required retrieving the data from ensembl http://www.ensembl.org/biomart/martview/

20

Examples

illuminaMousev1_dbconn

x <- illuminaMousev1UNIPROT
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

illuminaMousev1_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

illuminaMousev1_dbconn()
illuminaMousev1_dbfile()
illuminaMousev1_dbschema(file="", show.indices=FALSE)
illuminaMousev1_dbInfo()

Arguments

file

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

illuminaMousev1_dbconn returns a connection object to the package annotation DB. IMPOR-
TANT: Don’t call dbDisconnect on the connection object returned by illuminaMousev1_dbconn
or you will break all the AnnDbObj objects defined in this package!

illuminaMousev1_dbfile returns the path (character string) to the package annotation DB (this is
an SQLite file).

illuminaMousev1_dbschema prints the schema definition of the package annotation DB.

illuminaMousev1_dbInfo prints other information about the package annotation DB.

illuminaMousev1_dbconn

Value

21

illuminaMousev1_dbconn: a DBIConnection object representing an open connection to the pack-
age annotation DB.

illuminaMousev1_dbfile: a character string with the path to the package annotation DB.

illuminaMousev1_dbschema: none (invisible NULL).

illuminaMousev1_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

## Count the number of rows in the "probes" table:
dbGetQuery(illuminaMousev1_dbconn(), "SELECT COUNT(*) FROM probes")

illuminaMousev1_dbschema()

illuminaMousev1_dbInfo()

Index

∗ datasets

illuminaMousev1.db, 2
illuminaMousev1_dbconn, 20
illuminaMousev1ACCNUM, 1
illuminaMousev1ALIAS2PROBE, 2
illuminaMousev1CHR, 3
illuminaMousev1CHRLENGTHS, 3
illuminaMousev1CHRLOC, 4
illuminaMousev1ENSEMBL, 4
illuminaMousev1ENTREZID, 5
illuminaMousev1ENZYME, 6
illuminaMousev1GENENAME, 7
illuminaMousev1GO, 8
illuminaMousev1listNewMappings, 11
illuminaMousev1MAPCOUNTS, 10
illuminaMousev1MGI, 11
illuminaMousev1ORGANISM, 14
illuminaMousev1PATH, 15
illuminaMousev1PMID, 16
illuminaMousev1REFSEQ, 17
illuminaMousev1SYMBOL, 18
illuminaMousev1UNIGENE, 19
illuminaMousev1UNIPROT, 19

∗ utilities

illuminaMousev1_dbconn, 20

AnnDbObj, 20

cat, 20
checkMAPCOUNTS, 10
count.mappedkeys, 10

dbconn, 21
dbConnect, 21
dbDisconnect, 20
dbfile, 21
dbGetQuery, 21
dbInfo, 21
dbschema, 21

illuminaMousev1 (illuminaMousev1.db), 2
illuminaMousev1.db, 2
illuminaMousev1_dbconn, 20
illuminaMousev1_dbfile

(illuminaMousev1_dbconn), 20

22

illuminaMousev1_dbInfo

(illuminaMousev1_dbconn), 20

illuminaMousev1_dbschema

(illuminaMousev1_dbconn), 20

illuminaMousev1ACCNUM, 1
illuminaMousev1ALIAS2PROBE, 2
illuminaMousev1ARRAYADDRESS

(illuminaMousev1listNewMappings),
11
illuminaMousev1CHR, 3
illuminaMousev1CHRLENGTHS, 3
illuminaMousev1CHRLOC, 4
illuminaMousev1CHRLOCEND

(illuminaMousev1CHRLOC), 4

illuminaMousev1CODINGZONE

(illuminaMousev1listNewMappings),
11

illuminaMousev1ENSEMBL, 4
illuminaMousev1ENSEMBL2PROBE

(illuminaMousev1ENSEMBL), 4
illuminaMousev1ENSEMBLREANNOTATED

(illuminaMousev1listNewMappings),
11

illuminaMousev1ENTREZID, 5
illuminaMousev1ENTREZREANNOTATED

(illuminaMousev1listNewMappings),
11

illuminaMousev1ENZYME, 6
illuminaMousev1ENZYME2PROBE

(illuminaMousev1ENZYME), 6

illuminaMousev1fullReannotation

(illuminaMousev1listNewMappings),
11

illuminaMousev1GENENAME, 7
illuminaMousev1GENOMICLOCATION

(illuminaMousev1listNewMappings),
11

illuminaMousev1GENOMICMATCHSIMILARITY

(illuminaMousev1listNewMappings),
11
illuminaMousev1GO, 8
illuminaMousev1GO2ALLPROBES, 9
illuminaMousev1GO2ALLPROBES

INDEX

23

(illuminaMousev1listNewMappings),
11

illuminaMousev1TRANSCRIPTOMICMATCHSIMILARITY

(illuminaMousev1listNewMappings),
11

illuminaMousev1UNIGENE, 19
illuminaMousev1UNIPROT, 19
illuminaMousev1UNIPROT2PROBE

(illuminaMousev1UNIPROT), 19

mappedkeys, 10

(illuminaMousev1GO), 8

illuminaMousev1GO2PROBE

(illuminaMousev1GO), 8

illuminaMousev1listNewMappings, 11
illuminaMousev1LOCUSID

(illuminaMousev1ENTREZID), 5

illuminaMousev1MAPCOUNTS, 10
illuminaMousev1MGI, 11
illuminaMousev1MGI2PROBE

(illuminaMousev1MGI), 11

illuminaMousev1NUID

(illuminaMousev1listNewMappings),
11

illuminaMousev1ORGANISM, 14
illuminaMousev1ORGPKG

(illuminaMousev1ORGANISM), 14

illuminaMousev1OTHERGENOMICMATCHES

(illuminaMousev1listNewMappings),
11

illuminaMousev1OVERLAPPINGSNP

(illuminaMousev1listNewMappings),
11

illuminaMousev1PATH, 15
illuminaMousev1PATH2PROBE

(illuminaMousev1PATH), 15

illuminaMousev1PMID, 16
illuminaMousev1PMID2PROBE

(illuminaMousev1PMID), 16

illuminaMousev1PROBEQUALITY

(illuminaMousev1listNewMappings),
11

illuminaMousev1PROBESEQUENCE

(illuminaMousev1listNewMappings),
11

illuminaMousev1REFSEQ, 17
illuminaMousev1REPEATMASK

(illuminaMousev1listNewMappings),
11

illuminaMousev1REPORTERGROUPID

(illuminaMousev1listNewMappings),
11

illuminaMousev1REPORTERGROUPNAME

(illuminaMousev1listNewMappings),
11

illuminaMousev1SECONDMATCHES

(illuminaMousev1listNewMappings),
11

illuminaMousev1SECONDMATCHSIMILARITY

(illuminaMousev1listNewMappings),
11

illuminaMousev1SYMBOL, 18
illuminaMousev1SYMBOLREANNOTATED

