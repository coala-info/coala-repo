illuminaHumanv4.db

February 11, 2026

illuminaHumanv4ACCNUM Map Manufacturer identifiers to Accession Numbers

Description

illuminaHumanv4ACCNUM is an R object that contains mappings between a manufacturer’s iden-
tifiers and manufacturers accessions.

Details

For chip packages such as this, the ACCNUM mapping comes directly from the manufacturer. This
is different from other mappings which are mapped onto the probes via an Entrez Gene identifier.

Each manufacturer identifier maps to a vector containing a GenBank accession number.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

Examples

x <- illuminaHumanv4ACCNUM
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

illuminaHumanv4.db

illuminaHumanv4ALIAS2PROBE

Map between Common Gene Symbol Identifiers and Manufacturer
Identifiers

Description

illuminaHumanv4ALIAS is an R object that provides mappings between common gene symbol
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
xx <- as.list(illuminaHumanv4ALIAS2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two aliases
xx[1:2]
# Get the first one
xx[[1]]

}

illuminaHumanv4.db

Bioconductor annotation data package

Description

Welcome to the illuminaHumanv4.db annotation Package. The purpose of this package is to provide
detailed information about the illuminaHumanv4 platform. This package is updated biannually.

You can learn what objects this package supports with the following command:

ls("package:illuminaHumanv4.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:illuminaHumanv4.db")

illuminaHumanv4CHR

3

illuminaHumanv4CHR

Map Manufacturer IDs to Chromosomes

Description

illuminaHumanv4CHR is an R object that provides mappings between a manufacturer identifier and
the chromosome that contains the gene of interest.

Details

Each manufacturer identifier maps to a vector of chromosomes. Due to inconsistencies that may
exist at the time the object was built, the vector may contain more than one chromosome (e.g., the
identifier may map to more than one chromosome). If the chromosomal location is unknown, the
vector will contain an NA.
Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

Examples

x <- illuminaHumanv4CHR
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

illuminaHumanv4CHRLENGTHS

A named vector for the length of each of the chromosomes

Description

illuminaHumanv4CHRLENGTHS provides the length measured in base pairs for each of the chro-
mosomes.

Details

This is a named vector with chromosome numbers as the names and the corresponding lengths for
chromosomes as the values.

Total lengths of chromosomes were derived by calculating the number of base pairs on the sequence
string for each chromosome.

Examples

tt <- illuminaHumanv4CHRLENGTHS
# Length of chromosome 1
tt["1"]

4

illuminaHumanv4ENSEMBL

illuminaHumanv4CHRLOC Map Manufacturer IDs to Chromosomal Location

Description

illuminaHumanv4CHRLOC is an R object that maps manufacturer identifiers to the starting position
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

Mappings were based on data provided by: UCSC Genome Bioinformatics (Homo sapiens) ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19
With a date stamp from the source of: 2010-Mar22

Examples

x <- illuminaHumanv4CHRLOC
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

illuminaHumanv4ENSEMBL

Map Ensembl gene accession numbers with Entrez Gene identifiers

Description

illuminaHumanv4ENSEMBL is an R object that contains mappings between manufacturer identi-
fiers and Ensembl gene accession numbers.

illuminaHumanv4ENTREZID

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

x <- illuminaHumanv4ENSEMBL
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
xx <- as.list(illuminaHumanv4ENSEMBL2PROBE)
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

illuminaHumanv4ENTREZID

Map between Manufacturer Identifiers and Entrez Gene

Description

illuminaHumanv4ENTREZID is an R object that provides mappings between manufacturer identi-
fiers and Entrez Gene identifiers.

Details

Each manufacturer identifier is mapped to a vector of Entrez Gene identifiers. An NA is assigned to
those manufacturer identifiers that can not be mapped to an Entrez Gene identifier at this time.

If a given manufacturer identifier can be mapped to different Entrez Gene identifiers from various
sources, we attempt to select the common identifiers. If a concensus cannot be determined, we
select the smallest identifier.

6

illuminaHumanv4ENZYME

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

Examples

x <- illuminaHumanv4ENTREZID
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

illuminaHumanv4ENZYME Maps between Manufacturer IDs and Enzyme Commission (EC) Num-

bers

Description

illuminaHumanv4ENZYME is an R object that provides mappings between manufacturer iden-
tifiers and EC numbers.
illuminaHumanv4ENZYME2PROBE is an R object that maps Enzyme
Commission (EC) numbers to manufacturer identifiers.

Details

When the illuminaHumanv4ENZYME maping viewed as a list, each manufacturer identifier maps
to a named vector containing the EC number that corresponds to the enzyme produced by that gene.
The names corresponds to the manufacturer identifiers. If this information is unknown, the vector
will contain an NA.

For the illuminaHumanv4ENZYME2PROBE, each EC number maps to a named vector containing
all of the manufacturer identifiers that correspond to the gene that produces that enzyme. The name
of the vector corresponds to the EC number.

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In illuminaHumanv4ENZYME2PROBE, EC is dropped from the Enzyme Commission
numbers.

Enzyme Commission numbers have corresponding names that describe the functions of enzymes
in such a way that EC x is a more general description than EC x.y that in turn is a more general
description than EC x.y.z. The top level EC numbers and names are listed below:

EC 1 oxidoreductases

EC 2 transferases

illuminaHumanv4GENENAME

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

x <- illuminaHumanv4ENZYME
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

# Now convert illuminaHumanv4ENZYME2PROBE to a list to see inside
xx <- as.list(illuminaHumanv4ENZYME2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first five enzyme
#commission numbers
xx[1:5]
# Get the first one
xx[[1]]

}

illuminaHumanv4GENENAME

Map between Manufacturer IDs and Genes

Description

illuminaHumanv4GENENAME is an R object that maps manufacturer identifiers to the correspond-
ing gene name.

8

Details

illuminaHumanv4GO

Each manufacturer identifier maps to a named vector containing the gene name. The vector name
corresponds to the manufacturer identifier. If the gene name is unknown, the vector will contain an
NA.

Gene names currently include both the official (validated by a nomenclature committee) and pre-
ferred names (interim selected for display) for genes. Efforts are being made to differentiate the
two by adding a name to the vector.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

Examples

x <- illuminaHumanv4GENENAME
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

illuminaHumanv4GO

Maps between manufacturer IDs and Gene Ontology (GO) IDs

Description

illuminaHumanv4GO is an R object that provides mappings between manufacturer identifiers and
the GO identifiers that they are directly associated with. This mapping and its reverse mapping
(illuminaHumanv4GO2PROBE) do NOT associate the child terms from the GO ontology with the
gene. Only the directly evidenced terms are represented here.

illuminaHumanv4GO2ALLPROBES is an R object that provides mappings between a given GO
identifier and all of the manufacturer identifiers annotated at that GO term OR TO ONE OF IT’S
CHILD NODES in the GO ontology. Thus, this mapping is much larger and more inclusive than
illuminaHumanv4GO2PROBE.

Details

If illuminaHumanv4GO is cast as a list, each manufacturer identifier is mapped to a list of lists. The
names on the outer list are GO identifiers. Each inner list consists of three named elements: GOID,
Ontology, and Evidence.

The GOID element matches the GO identifier named in the outer list and is included for convenience
when processing the data using ’lapply’.

The Ontology element indicates which of the three Gene Ontology categories this identifier belongs
to. The categories are biological process (BP), cellular component (CC), and molecular function
(MF).

The Evidence element contains a code indicating what kind of evidence supports the association of
the GO identifier to the manufacturer id. Some of the evidence codes in use include:

illuminaHumanv4GO

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

If illuminaHumanv4GO2ALLPROBES or illuminaHumanv4GO2PROBE is cast as a list, each GO
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

illuminaHumanv4GO2ALLPROBES.

Examples

x <- illuminaHumanv4GO
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

illuminaHumanv4MAP

# For the reverse map:
# Convert to a list
xx <- as.list(illuminaHumanv4GO2PROBE)
if(length(xx) > 0){

# Gets the manufacturer ids for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets the manufacturer ids for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}
# Convert illuminaHumanv4GO2ALLPROBES to a list
xx <- as.list(illuminaHumanv4GO2ALLPROBES)
if(length(xx) > 0){

# Gets the manufacturer identifiers for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets all the manufacturer identifiers for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}

illuminaHumanv4MAP

Map between Manufacturer Identifiers and cytogenetic maps/bands

Description

illuminaHumanv4MAP is an R object that provides mappings between manufacturer identifiers and
cytoband locations.

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
a date stamp from the source of: 2015-Mar17

References

http://www.ncbi.nlm.nih.gov

Examples

x <- illuminaHumanv4MAP
# Get the probe identifiers that are mapped to any cytoband
mapped_probes <- mappedkeys(x)
# Convert to a list

illuminaHumanv4MAPCOUNTS

11

xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the MAP for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

illuminaHumanv4MAPCOUNTS

Number of mapped keys for the maps in package illuminaHumanv4.db

Description

illuminaHumanv4MAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each
map in package illuminaHumanv4.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

Examples

illuminaHumanv4MAPCOUNTS
mapnames <- names(illuminaHumanv4MAPCOUNTS)
illuminaHumanv4MAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package illuminaHumanv4.db
checkMAPCOUNTS("illuminaHumanv4.db")

illuminaHumanv4listNewMappings

Custom mappings added to the package

Description

We have used an extensive re-annotation of the illuminaHumanv4 probe sequences to provide ad-
ditional information that is not captured in the standard Bioconductor packages. Whereas Biocon-
ductor annotations are based on the RefSeq ID that each probe maps to, our additional mappings
provide data specific to each probe on the platform. See below for details. We recommend using
the probe quality as a form of filtering, and retaining only perfect or good probes for an analysis.

12

illuminaHumanv4listNewMappings

Details of custom mappings

illuminaHumanv4listNewMappings List all the custom re-annotation mappings provided by the

package

illuminaHumanv4fullReannotation Return all the re-annotation information as a matrix
illuminaHumanv4ARRAYADDRESS Array Address code used to identify the probe at the bead-

level

illuminaHumanv4NUID Lumi’s nuID (universal naming scheme for oligonucleotides) Reference:

Du et al. (2007), Biol Direct 2:16

illuminaHumanv4PROBESEQUENCE The 50 base sequence for the probe
illuminaHumanv4PROBEQUALITY Quality grade assigned to the probe: “Perfect” if it per-
fectly and uniquely matches the target transcript; “Good” if the probe, although imperfectly
matching the target transcript, is still likely to provide considerably sensitive signal (up to
two mismatches are allowed, based on empirical evidence that the signal intensity for 50-mer
probes with less than 95% identity to the respective targets is less than 50% of the signal as-
sociated with perfect matches *); “Bad” if the probe matches repeat sequences, intergenic or
intronic regions, or is unlikely to provide specific signal for any transcript; “No match” if it
does not match any genomic region or transcript.

illuminaHumanv4CODINGZONE Coding status of target sequence: intergenic / intronic / Tran-
scriptomic (“Transcriptomic” when the target transcript is non-coding or there is no informa-
tion on the coding sequence)

illuminaHumanv4GENOMICLOCATION Probe’s genomic coordinates (hg19 for human, mm9

for mouse or rn4 for rat)

illuminaHumanv4GENOMICMATCHSIMILARITY Percentage of similarity between the probe

and its best genomic match in the alignable region, taking the probe as reference

illuminaHumanv4SECONDMATCHES Genomic coordinates of second best matches between

the probe and the genome

illuminaHumanv4SECONDMATCHSIMILARITY Percentage of similarity between the probe
and its second best genomic match in the alignable region, taking the probe as reference
illuminaHumanv4TRANSCRIPTOMICMATCHSIMILARITY Percentage of similarity between

the probe and its target transcript in the alignable region, taking the probe as reference

illuminaHumanv4OTHERGENOMICMATCHES Genomic coordinates of sequences as alignable

with the probe (in terms of number of matching nucleotides) as its main target

illuminaHumanv4REPEATMASK Overlapping RepeatMasked sequences, with number of bases

overlapped by the repeat

illuminaHumanv4OVERLAPPINGSNP Overlapping annotated SNPs
illuminaHumanv4ENTREZREANNOTATED Entrez IDs
illuminaHumanv4ENSEMBLREANNOTATED Ensembl IDs
illuminaHumanv4SYMBOLREANNOTATED Gene symbol derived by re-annotation
illuminaHumanv4REPORTERGROUPID For probes marked as controls in Illuminas annota-

tion file, these gives the type of control

illuminaHumanv4REPORTERGROUPNAME Usually a more informative name for the control

type

References

http://remoat.sysbiol.cam.ac.uk

Barbosa-Morais et al. (2010) A re-annotation pipeline for Illumina BeadArrays: improving the
interpretation of gene expression data. Nucleic Acids Research

illuminaHumanv4listNewMappings

13

Examples

##See what new mappings are available

illuminaHumanv4listNewMappings()

x <- illuminaHumanv4PROBEQUALITY

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

x <- illuminaHumanv4ARRAYADDRESS

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

y<- revmap(illuminaHumanv4ARRAYADDRESS)

mapped_probes <- mappedkeys(y)
# Convert to a list
yy <- as.list(y[mapped_probes])
if(length(yy) > 0) {

# Get the ARRAYADDRESS for the first five probes
yy[1:5]
# Get the first one
yy[[1]]

}

x <- illuminaHumanv4CODINGZONE

mapped_probes <- mappedkeys(x)
# Convert to a list

14

illuminaHumanv4OMIM

xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the CODINGZONE for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

x <- illuminaHumanv4PROBESEQUENCE

mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the PROBESEQUENCE for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

illuminaHumanv4OMIM

Map between Manufacturer Identifiers and Mendelian Inheritance in
Man (MIM) identifiers

Description

illuminaHumanv4OMIM is an R object that provides mappings between manufacturer identifiers
and OMIM identifiers.

Details

Each manufacturer identifier is mapped to a vector of OMIM identifiers. The vector length may be
one or longer, depending on how many OMIM identifiers the manufacturer identifier maps to. An
NA is reported for any manufacturer identifier that cannot be mapped to an OMIM identifier at this
time.

OMIM is based upon the book Mendelian Inheritance in Man (V. A. McKusick) and focuses primar-
ily on inherited or heritable genetic diseases. It contains textual information, pictures, and reference
information that can be searched using various terms, among which the MIM number is one.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Mar17

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene http://www3.ncbi.nlm.nih.gov/
entrez/query.fcgi?db=OMIM

illuminaHumanv4ORGANISM

15

Examples

x <- illuminaHumanv4OMIM
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

illuminaHumanv4ORGANISM

The Organism information for illuminaHumanv4

Description

illuminaHumanv4ORGANISM is an R object that contains a single item: a character string that
names the organism for which illuminaHumanv4 was built.
illuminaHumanv4ORGPKG is an R
object that contains a chararcter vector with the name of the organism package that a chip package
depends on for its gene-centric annotation.

Details

Although the package name is suggestive of the organism for which it was built, illuminaHu-
manv4ORGANISM provides a simple way to programmatically extract the organism name. illumi-
naHumanv4ORGPKG provides a simple way to programmatically extract the name of the parent
organism package. The parent organism package is a strict dependency for chip packages as this is
where the gene cetric information is ultimately extracted from. The full package name will always
be this string plus the extension ".db". But most programatic acces will not require this extension,
so its more convenient to leave it out.

Examples

illuminaHumanv4ORGANISM
illuminaHumanv4ORGPKG

illuminaHumanv4PATH

Mappings between probe identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms.

illuminaHumanv4PATH maps probe identifiers to the identifiers used by KEGG for pathways in
which the genes represented by the probe identifiers are involved

illuminaHumanv4PATH2PROBE is an R object that provides mappings between KEGG identifiers
and manufacturer identifiers.

16

Details

illuminaHumanv4PMID

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

x <- illuminaHumanv4PATH
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

# Now convert the illuminaHumanv4PATH2PROBE object to a list
xx <- as.list(illuminaHumanv4PATH2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two pathway identifiers
xx[1:2]
# Get the first one
xx[[1]]

}

illuminaHumanv4PMID

Maps between Manufacturer Identifiers and PubMed Identifiers

Description

illuminaHumanv4PMID is an R object that provides mappings between manufacturer identifiers
and PubMed identifiers. illuminaHumanv4PMID2PROBE is an R object that provides mappings
between PubMed identifiers and manufacturer identifiers.

Details

When illuminaHumanv4PMID is viewed as a list each manufacturer identifier is mapped to a named
vector of PubMed identifiers. The name associated with each vector corresponds to the manufac-
turer identifier. The length of the vector may be one or greater, depending on how many PubMed
identifiers a given manufacturer identifier is mapped to. An NA is reported for any manufacturer
identifier that cannot be mapped to a PubMed identifier.

illuminaHumanv4PMID

17

When illuminaHumanv4PMID2PROBE is viewed as a list each PubMed identifier is mapped to a
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

x <- illuminaHumanv4PMID
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

# Now convert the reverse map object illuminaHumanv4PMID2PROBE to a list
xx <- as.list(illuminaHumanv4PMID2PROBE)
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

18

illuminaHumanv4REFSEQ

illuminaHumanv4REFSEQ Map between Manufacturer Identifiers and RefSeq Identifiers

Description

illuminaHumanv4REFSEQ is an R object that provides mappings between manufacturer identifiers
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

Examples

x <- illuminaHumanv4REFSEQ
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

illuminaHumanv4SYMBOL

19

illuminaHumanv4SYMBOL Map between Manufacturer Identifiers and Gene Symbols

Description

illuminaHumanv4SYMBOL is an R object that provides mappings between manufacturer identifiers
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

x <- illuminaHumanv4SYMBOL
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

illuminaHumanv4UNIGENE

Map between Manufacturer Identifiers and UniGene cluster identifiers

Description

illuminaHumanv4UNIGENE is an R object that provides mappings between manufacturer identi-
fiers and UniGene identifiers.

20

Details

illuminaHumanv4UNIPROT

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

x <- illuminaHumanv4UNIGENE
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

illuminaHumanv4UNIPROT

Map Uniprot accession numbers with Entrez Gene identifiers

Description

illuminaHumanv4UNIPROT is an R object that contains mappings between the manufacturer iden-
tifiers and Uniprot accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to Uniprot Accessions.

Mappings were based on data provided by NCBI (link above) with an exception for fly, which
required retrieving the data from ensembl http://www.ensembl.org/biomart/martview/

Examples

x <- illuminaHumanv4UNIPROT
# Get the entrez gene IDs that are mapped to an Uniprot ID
mapped_genes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_genes])
if(length(xx) > 0) {

# Get the Uniprot IDs for the first five genes
xx[1:5]

illuminaHumanv4_dbconn

21

# Get the first one
xx[[1]]

}

illuminaHumanv4_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

illuminaHumanv4_dbconn()
illuminaHumanv4_dbfile()
illuminaHumanv4_dbschema(file="", show.indices=FALSE)
illuminaHumanv4_dbInfo()

Arguments

file

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

illuminaHumanv4_dbconn returns a connection object to the package annotation DB. IMPOR-
TANT: Don’t call dbDisconnect on the connection object returned by illuminaHumanv4_dbconn
or you will break all the AnnDbObj objects defined in this package!

illuminaHumanv4_dbfile returns the path (character string) to the package annotation DB (this is
an SQLite file).

illuminaHumanv4_dbschema prints the schema definition of the package annotation DB.

illuminaHumanv4_dbInfo prints other information about the package annotation DB.

Value

illuminaHumanv4_dbconn: a DBIConnection object representing an open connection to the pack-
age annotation DB.

illuminaHumanv4_dbfile: a character string with the path to the package annotation DB.

illuminaHumanv4_dbschema: none (invisible NULL).

illuminaHumanv4_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

22

Examples

illuminaHumanv4_dbconn

## Count the number of rows in the "probes" table:
dbGetQuery(illuminaHumanv4_dbconn(), "SELECT COUNT(*) FROM probes")

illuminaHumanv4_dbschema()

illuminaHumanv4_dbInfo()

Index

∗ datasets

illuminaHumanv4.db, 2
illuminaHumanv4_dbconn, 21
illuminaHumanv4ACCNUM, 1
illuminaHumanv4ALIAS2PROBE, 2
illuminaHumanv4CHR, 3
illuminaHumanv4CHRLENGTHS, 3
illuminaHumanv4CHRLOC, 4
illuminaHumanv4ENSEMBL, 4
illuminaHumanv4ENTREZID, 5
illuminaHumanv4ENZYME, 6
illuminaHumanv4GENENAME, 7
illuminaHumanv4GO, 8
illuminaHumanv4listNewMappings, 11
illuminaHumanv4MAP, 10
illuminaHumanv4MAPCOUNTS, 11
illuminaHumanv4OMIM, 14
illuminaHumanv4ORGANISM, 15
illuminaHumanv4PATH, 15
illuminaHumanv4PMID, 16
illuminaHumanv4REFSEQ, 18
illuminaHumanv4SYMBOL, 19
illuminaHumanv4UNIGENE, 19
illuminaHumanv4UNIPROT, 20

∗ utilities

illuminaHumanv4_dbconn, 21

AnnDbObj, 21

cat, 21
checkMAPCOUNTS, 11
count.mappedkeys, 11

dbconn, 21
dbConnect, 21
dbDisconnect, 21
dbfile, 21
dbGetQuery, 21
dbInfo, 21
dbschema, 21

illuminaHumanv4 (illuminaHumanv4.db), 2
illuminaHumanv4.db, 2
illuminaHumanv4_dbconn, 21

23

illuminaHumanv4_dbfile

(illuminaHumanv4_dbconn), 21

illuminaHumanv4_dbInfo

(illuminaHumanv4_dbconn), 21

illuminaHumanv4_dbschema

(illuminaHumanv4_dbconn), 21

illuminaHumanv4ACCNUM, 1
illuminaHumanv4ALIAS2PROBE, 2
illuminaHumanv4ARRAYADDRESS

(illuminaHumanv4listNewMappings),
11
illuminaHumanv4CHR, 3
illuminaHumanv4CHRLENGTHS, 3
illuminaHumanv4CHRLOC, 4
illuminaHumanv4CHRLOCEND

(illuminaHumanv4CHRLOC), 4

illuminaHumanv4CODINGZONE

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4ENSEMBL, 4
illuminaHumanv4ENSEMBL2PROBE

(illuminaHumanv4ENSEMBL), 4
illuminaHumanv4ENSEMBLREANNOTATED

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4ENTREZID, 5
illuminaHumanv4ENTREZREANNOTATED

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4ENZYME, 6
illuminaHumanv4ENZYME2PROBE

(illuminaHumanv4ENZYME), 6

illuminaHumanv4fullReannotation

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4GENENAME, 7
illuminaHumanv4GENOMICLOCATION

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4GENOMICMATCHSIMILARITY

(illuminaHumanv4listNewMappings),
11
illuminaHumanv4GO, 8

24

INDEX

illuminaHumanv4SYMBOLREANNOTATED

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4TRANSCRIPTOMICMATCHSIMILARITY

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4UNIGENE, 19
illuminaHumanv4UNIPROT, 20
illuminaHumanv4UNIPROT2PROBE

(illuminaHumanv4UNIPROT), 20

mappedkeys, 11

illuminaHumanv4GO2ALLPROBES, 9
illuminaHumanv4GO2ALLPROBES

(illuminaHumanv4GO), 8

illuminaHumanv4GO2PROBE

(illuminaHumanv4GO), 8

illuminaHumanv4listNewMappings, 11
illuminaHumanv4LOCUSID

(illuminaHumanv4ENTREZID), 5

illuminaHumanv4MAP, 10
illuminaHumanv4MAPCOUNTS, 11
illuminaHumanv4NUID

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4OMIM, 14
illuminaHumanv4ORGANISM, 15
illuminaHumanv4ORGPKG

(illuminaHumanv4ORGANISM), 15

illuminaHumanv4OTHERGENOMICMATCHES

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4OVERLAPPINGSNP

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4PATH, 15
illuminaHumanv4PATH2PROBE

(illuminaHumanv4PATH), 15

illuminaHumanv4PMID, 16
illuminaHumanv4PMID2PROBE

(illuminaHumanv4PMID), 16

illuminaHumanv4PROBEQUALITY

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4PROBESEQUENCE

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4REFSEQ, 18
illuminaHumanv4REPEATMASK

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4REPORTERGROUPID

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4REPORTERGROUPNAME

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4SECONDMATCHES

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4SECONDMATCHSIMILARITY

(illuminaHumanv4listNewMappings),
11

illuminaHumanv4SYMBOL, 19

