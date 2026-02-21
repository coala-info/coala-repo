MmAgilentDesign026655.db

February 11, 2026

MmAgilentDesign026655ACCNUM

Map Manufacturer identifiers to Accession Numbers

Description

MmAgilentDesign026655ACCNUM is an R object that contains mappings between a manufac-
turer’s identifiers and manufacturers accessions.

Details

For chip packages such as this, the ACCNUM mapping comes directly from the manufacturer. This
is different from other mappings which are mapped onto the probes via an Entrez Gene identifier.

Each manufacturer identifier maps to a vector containing a GenBank accession number.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- MmAgilentDesign026655ACCNUM
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

MmAgilentDesign026655.db

MmAgilentDesign026655ALIAS2PROBE

Map between Common Gene Symbol Identifiers and Manufacturer
Identifiers

Description

MmAgilentDesign026655ALIAS is an R object that provides mappings between common gene
symbol identifiers and manufacturer identifiers.

Details

Each gene symbol is mapped to a named vector of manufacturer identifiers. The name represents
the gene symbol and the vector contains all manufacturer identifiers that are found for that symbol.
An NA is reported for any gene symbol that cannot be mapped to any manufacturer identifiers.
This mapping includes ALL gene symbols including those which are already listed in the SYMBOL
map. The SYMBOL map is meant to only list official gene symbols, while the ALIAS maps are
meant to store all used symbols.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
# Convert the object to a list
xx <- as.list(MmAgilentDesign026655ALIAS2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two aliases
xx[1:2]
# Get the first one
xx[[1]]

}

MmAgilentDesign026655.db

Bioconductor annotation data package

Description

Welcome to the MmAgilentDesign026655.db annotation Package. The purpose of this package
is to provide detailed information about the MmAgilentDesign026655 platform. This package is
updated biannually.
Objects in this package are accessed using the select() interface. See ?select in the AnnotationDbi
package for details.

MmAgilentDesign026655CHR

3

See Also

• AnnotationDb-class for use of keys(), columns() and select().

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
columns(MmAgilentDesign026655.db)

## Bimap interface:
## The 'old style' of interacting with these objects is manipulation as
## bimaps. While this approach is still available we strongly encourage the
## use of select().
ls("package:MmAgilentDesign026655.db")

MmAgilentDesign026655CHR

Map Manufacturer IDs to Chromosomes

Description

MmAgilentDesign026655CHR is an R object that provides mappings between a manufacturer iden-
tifier and the chromosome that contains the gene of interest.

Details

Each manufacturer identifier maps to a vector of chromosomes. Due to inconsistencies that may
exist at the time the object was built, the vector may contain more than one chromosome (e.g., the
identifier may map to more than one chromosome). If the chromosomal location is unknown, the
vector will contain an NA.
Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- MmAgilentDesign026655CHR
# Get the probe identifiers that are mapped to a chromosome
mapped_probes <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the CHR for the first five probes
xx[1:5]

4

MmAgilentDesign026655CHRLOC

# Get the first one
xx[[1]]

}

MmAgilentDesign026655CHRLENGTHS

A named vector for the length of each of the chromosomes

Description

MmAgilentDesign026655CHRLENGTHS provides the length measured in base pairs for each of
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
tt <- MmAgilentDesign026655CHRLENGTHS
# Length of chromosome 1
tt["1"]

MmAgilentDesign026655CHRLOC

Map Manufacturer IDs to Chromosomal Location

Description

MmAgilentDesign026655CHRLOC is an R object that maps manufacturer identifiers to the starting
position of the gene. The position of a gene is measured as the number of base pairs.

The CHRLOCEND mapping is the same as the CHRLOC mapping except that it specifies the
ending base of a gene instead of the start.

MmAgilentDesign026655ENSEMBL

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

Mappings were based on data provided by: UCSC Genome Bioinformatics (Mus musculus) ftp://hgdownload.cse.ucsc.edu/goldenPath/mm10
With a date stamp from the source of: 2012-Mar8

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- MmAgilentDesign026655CHRLOC
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

MmAgilentDesign026655ENSEMBL

Map Ensembl gene accession numbers with Entrez Gene identifiers

Description

MmAgilentDesign026655ENSEMBL is an R object that contains mappings between manufacturer
identifiers and Ensembl gene accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to Ensembl gene Accession Numbers.
Mappings were based on data provided by BOTH of these sources: http://www.ensembl.org/
biomart/martview/ ftp://ftp.ncbi.nlm.nih.gov/gene/DATA

For most species, this mapping is a combination of manufacturer to ensembl IDs from BOTH
NCBI and ensembl. Users who wish to only use mappings from NCBI are encouraged to see

6

MmAgilentDesign026655ENTREZID

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
x <- MmAgilentDesign026655ENSEMBL
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
xx <- as.list(MmAgilentDesign026655ENSEMBL2PROBE)
if(length(xx) > 0){

# Gets the entrez gene IDs for the first five Ensembl IDs
xx[1:5]
# Get the first one
xx[[1]]

}

MmAgilentDesign026655ENTREZID

Map between Manufacturer Identifiers and Entrez Gene

Description

MmAgilentDesign026655ENTREZID is an R object that provides mappings between manufacturer
identifiers and Entrez Gene identifiers.

Details

Each manufacturer identifier is mapped to a vector of Entrez Gene identifiers. An NA is assigned to
those manufacturer identifiers that can not be mapped to an Entrez Gene identifier at this time.

MmAgilentDesign026655ENZYME

7

If a given manufacturer identifier can be mapped to different Entrez Gene identifiers from various
sources, we attempt to select the common identifiers. If a concensus cannot be determined, we
select the smallest identifier.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- MmAgilentDesign026655ENTREZID
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

MmAgilentDesign026655ENZYME

Maps between Manufacturer IDs and Enzyme Commission (EC) Num-
bers

Description

MmAgilentDesign026655ENZYME is an R object that provides mappings between manufacturer
identifiers and EC numbers. MmAgilentDesign026655ENZYME2PROBE is an R object that maps
Enzyme Commission (EC) numbers to manufacturer identifiers.

Details

When the MmAgilentDesign026655ENZYME maping viewed as a list, each manufacturer identi-
fier maps to a named vector containing the EC number that corresponds to the enzyme produced by
that gene. The names corresponds to the manufacturer identifiers. If this information is unknown,
the vector will contain an NA.
For the MmAgilentDesign026655ENZYME2PROBE, each EC number maps to a named vector
containing all of the manufacturer identifiers that correspond to the gene that produces that enzyme.
The name of the vector corresponds to the EC number.

8

MmAgilentDesign026655ENZYME

Enzyme Commission numbers are assigned by the Nomenclature Committee of the International
Union of Biochemistry and Molecular Biology http://www.chem.qmw.ac.uk/iubmb/enzyme/ to
allow enzymes to be identified.

An Enzyme Commission number is of the format EC x.y.z.w, where x, y, z, and w are numeric
numbers. In MmAgilentDesign026655ENZYME2PROBE, EC is dropped from the Enzyme Com-
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
x <- MmAgilentDesign026655ENZYME
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

# Now convert MmAgilentDesign026655ENZYME2PROBE to a list to see inside
xx <- as.list(MmAgilentDesign026655ENZYME2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first five enzyme

MmAgilentDesign026655GENENAME

9

#commission numbers
xx[1:5]
# Get the first one
xx[[1]]

}

MmAgilentDesign026655GENENAME

Map between Manufacturer IDs and Genes

Description

MmAgilentDesign026655GENENAME is an R object that maps manufacturer identifiers to the
corresponding gene name.

Details

Each manufacturer identifier maps to a named vector containing the gene name. The vector name
corresponds to the manufacturer identifier. If the gene name is unknown, the vector will contain an
NA.

Gene names currently include both the official (validated by a nomenclature committee) and pre-
ferred names (interim selected for display) for genes. Efforts are being made to differentiate the
two by adding a name to the vector.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- MmAgilentDesign026655GENENAME
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

10

MmAgilentDesign026655GO

MmAgilentDesign026655GO

Maps between manufacturer IDs and Gene Ontology (GO) IDs

Description

MmAgilentDesign026655GO is an R object that provides mappings between manufacturer iden-
tifiers and the GO identifiers that they are directly associated with. This mapping and its reverse
mapping (MmAgilentDesign026655GO2PROBE) do NOT associate the child terms from the GO
ontology with the gene. Only the directly evidenced terms are represented here.

MmAgilentDesign026655GO2ALLPROBES is an R object that provides mappings between a given
GO identifier and all of the manufacturer identifiers annotated at that GO term OR TO ONE OF IT’S
CHILD NODES in the GO ontology. Thus, this mapping is much larger and more inclusive than
MmAgilentDesign026655GO2PROBE.

Details

If MmAgilentDesign026655GO is cast as a list, each manufacturer identifier is mapped to a list
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

A more complete listing of evidence codes can be found at:
http://www.geneontology.org/GO.evidence.shtml

If MmAgilentDesign026655GO2ALLPROBES or MmAgilentDesign026655GO2PROBE is cast as
a list, each GO term maps to a named vector of manufacturer identifiers and evidence codes. A GO
identifier may be mapped to the same manufacturer identifier more than once but the evidence code
can be different. Mappings between Gene Ontology identifiers and Gene Ontology terms and other
information are available in a separate data package named GO.

MmAgilentDesign026655GO

11

Whenever any of these mappings are cast as a data.frame, all the results will be output in an appro-
priate tabular form.

Mappings between manufacturer identifiers and GO information were obtained through their map-
pings to manufacturer identifiers. NAs are assigned to manufacturer identifiers that can not be
mapped to any Gene Ontology information. Mappings between Gene Ontology identifiers an Gene
Ontology terms and other information are available in a separate data package named GO.

All mappings were based on data provided by: Gene Ontology ftp://ftp.geneontology.org/pub/go/godatabase/archive/latest-
lite/ With a date stamp from the source of: 20150919

References

ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/

See Also

• MmAgilentDesign026655GO2ALLPROBES
• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- MmAgilentDesign026655GO
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
xx <- as.list(MmAgilentDesign026655GO2PROBE)
if(length(xx) > 0){

# Gets the manufacturer ids for the top 2nd and 3nd GO identifiers
goids <- xx[2:3]
# Gets the manufacturer ids for the first element of goids
goids[[1]]
# Evidence code for the mappings
names(goids[[1]])

}
# Convert MmAgilentDesign026655GO2ALLPROBES to a list
xx <- as.list(MmAgilentDesign026655GO2ALLPROBES)
if(length(xx) > 0){
# Gets the manufacturer identifiers for the top 2nd and 3nd GO identifiers

goids <- xx[2:3]
# Gets all the manufacturer identifiers for the first element of goids
goids[[1]]

12

}

# Evidence code for the mappings
names(goids[[1]])

MmAgilentDesign026655MGI

MmAgilentDesign026655MAPCOUNTS

Number of mapped keys for the maps in package MmAgilentDe-
sign026655.db

Description

DEPRECATED. Counts in the MAPCOUNT table are out of sync and should not be used.

MmAgilentDesign026655MAPCOUNTS provides the "map count" (i.e. the count of mapped keys)
for each map in package MmAgilentDesign026655.db.

Details

DEPRECATED. Counts in the MAPCOUNT table are out of sync and should not be used.

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

MmAgilentDesign026655MGI

Map MGI gene accession numbers with manufacturer identifiers

Description

MmAgilentDesign026655MGI is an R object that contains mappings between manufacturer identi-
fiers and Jackson Laboratory MGI gene accession numbers.

Details

This object is a simple mapping of manufacturer identifiers to MGI gene Accession Numbers.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

See Also

• AnnotationDb-class for use of the select() interface.

MmAgilentDesign026655ORGANISM

13

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- MmAgilentDesign026655MGI
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
xx <- as.list(MmAgilentDesign026655MGI2PROBE)
if(length(xx) > 0){

# Gets the manufacturer IDs for the first five MGI IDs
xx[1:5]
# Get the first one
xx[[1]]

}

MmAgilentDesign026655ORGANISM

The Organism information for MmAgilentDesign026655

Description

MmAgilentDesign026655ORGANISM is an R object that contains a single item: a character string
that names the organism for which MmAgilentDesign026655 was built. MmAgilentDesign026655ORGPKG
is an R object that contains a chararcter vector with the name of the organism package that a chip
package depends on for its gene-centric annotation.

Details

Although the package name is suggestive of the organism for which it was built, MmAgilentDe-
sign026655ORGANISM provides a simple way to programmatically extract the organism name.
MmAgilentDesign026655ORGPKG provides a simple way to programmatically extract the name
of the parent organism package. The parent organism package is a strict dependency for chip pack-
ages as this is where the gene cetric information is ultimately extracted from. The full package name
will always be this string plus the extension ".db". But most programatic acces will not require this
extension, so its more convenient to leave it out.

See Also

• AnnotationDb-class for use of the select() interface.

14

Examples

MmAgilentDesign026655PATH

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
MmAgilentDesign026655ORGANISM
MmAgilentDesign026655ORGPKG

MmAgilentDesign026655PATH

Mappings between probe identifiers and KEGG pathway identifiers

Description

KEGG (Kyoto Encyclopedia of Genes and Genomes) maintains pathway data for various organ-
isms.

MmAgilentDesign026655PATH maps probe identifiers to the identifiers used by KEGG for path-
ways in which the genes represented by the probe identifiers are involved

MmAgilentDesign026655PATH2PROBE is an R object that provides mappings between KEGG
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

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- MmAgilentDesign026655PATH
# Get the probe identifiers that are mapped to a KEGG pathway ID
mapped_probes <- mappedkeys(x)
# Convert to a list

MmAgilentDesign026655PFAM

15

xx <- as.list(x[mapped_probes])
if(length(xx) > 0) {

# Get the PATH for the first five probes
xx[1:5]
# Get the first one
xx[[1]]

}

# Now convert the MmAgilentDesign026655PATH2PROBE object to a list
xx <- as.list(MmAgilentDesign026655PATH2PROBE)
if(length(xx) > 0){

# Get the probe identifiers for the first two pathway identifiers
xx[1:2]
# Get the first one
xx[[1]]

}

MmAgilentDesign026655PFAM

Maps between Manufacturer Identifiers and PFAM Identifiers

Description

MmAgilentDesign026655PFAM is an R object that provides mappings between manufacturer iden-
tifiers and PFAM identifiers.

Details

The bimap interface for PFAM is defunct. Please use select() interface to PFAM identifiers. See
?AnnotationDbi::select for details.

MmAgilentDesign026655PMID

Maps between Manufacturer Identifiers and PubMed Identifiers

Description

MmAgilentDesign026655PMID is an R object that provides mappings between manufacturer iden-
tifiers and PubMed identifiers. MmAgilentDesign026655PMID2PROBE is an R object that pro-
vides mappings between PubMed identifiers and manufacturer identifiers.

Details

When MmAgilentDesign026655PMID is viewed as a list each manufacturer identifier is mapped
to a named vector of PubMed identifiers. The name associated with each vector corresponds to
the manufacturer identifier. The length of the vector may be one or greater, depending on how
many PubMed identifiers a given manufacturer identifier is mapped to. An NA is reported for any
manufacturer identifier that cannot be mapped to a PubMed identifier.

When MmAgilentDesign026655PMID2PROBE is viewed as a list each PubMed identifier is mapped
to a named vector of manufacturer identifiers. The name represents the PubMed identifier and the

16

MmAgilentDesign026655PMID

vector contains all manufacturer identifiers that are represented by that PubMed identifier. The
length of the vector may be one or longer, depending on how many manufacturer identifiers are
mapped to a given PubMed identifier.

Titles, abstracts, and possibly full texts of articles can be obtained from PubMed by providing a
valid PubMed identifier. The pubmed function of annotate can also be used for the same purpose.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=PubMed

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- MmAgilentDesign026655PMID
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

# Now convert the reverse map object MmAgilentDesign026655PMID2PROBE to a list
xx <- as.list(MmAgilentDesign026655PMID2PROBE)
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

MmAgilentDesign026655PROSITE

17

MmAgilentDesign026655PROSITE

Maps between Manufacturer Identifiers and PROSITE Identifiers

Description

MmAgilentDesign026655PROSITE is an R object that provides mappings between manufacturer
identifiers and PROSITE identifiers.

Details

The bimap interface for PROSITE is defunct. Please use select() interface to PROSITE identifiers.
See ?AnnotationDbi::select for details.

MmAgilentDesign026655REFSEQ

Map between Manufacturer Identifiers and RefSeq Identifiers

Description

MmAgilentDesign026655REFSEQ is an R object that provides mappings between manufacturer
identifiers and RefSeq identifiers.

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
a date stamp from the source of: 2015-Sep27

18

References

MmAgilentDesign026655SYMBOL

http://www.ncbi.nlm.nih.gov http://www.ncbi.nlm.nih.gov/RefSeq/

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- MmAgilentDesign026655REFSEQ
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

MmAgilentDesign026655SYMBOL

Map between Manufacturer Identifiers and Gene Symbols

Description

MmAgilentDesign026655SYMBOL is an R object that provides mappings between manufacturer
identifiers and gene abbreviations.

Details

Each manufacturer identifier is mapped to an abbreviation for the corresponding gene. An NA is
reported if there is no known abbreviation for a given gene.

Symbols typically consist of 3 letters that define either a single gene (ABC) or multiple genes
(ABC1, ABC2, ABC3). Gene symbols can be used as key words to query public databases such as
Entrez Gene.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

See Also

• AnnotationDb-class for use of the select() interface.

MmAgilentDesign026655UNIGENE

19

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
x <- MmAgilentDesign026655SYMBOL
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

MmAgilentDesign026655UNIGENE

Map between Manufacturer Identifiers and UniGene cluster identifiers

Description

MmAgilentDesign026655UNIGENE is an R object that provides mappings between manufacturer
identifiers and UniGene identifiers.

Details

Each manufacturer identifier is mapped to a UniGene identifier. An NA is reported if the manufac-
turer identifier cannot be mapped to UniGene at this time.

A UniGene identifier represents a cluster of sequences of a gene. Using UniGene identifiers one
can query the UniGene database for information about the sequences or the Entrez Gene database
for information about the genes.

Mappings were based on data provided by: Entrez Gene ftp://ftp.ncbi.nlm.nih.gov/gene/DATA With
a date stamp from the source of: 2015-Sep27

References

http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:

20

MmAgilentDesign026655UNIPROT

x <- MmAgilentDesign026655UNIGENE
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

MmAgilentDesign026655UNIPROT

Map Uniprot accession numbers with Entrez Gene identifiers

Description

MmAgilentDesign026655UNIPROT is an R object that contains mappings between the manufac-
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
x <- MmAgilentDesign026655UNIPROT
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

MmAgilentDesign026655_dbconn

21

MmAgilentDesign026655_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

MmAgilentDesign026655_dbconn()
MmAgilentDesign026655_dbfile()
MmAgilentDesign026655_dbschema(file="", show.indices=FALSE)
MmAgilentDesign026655_dbInfo()

Arguments

file

show.indices

Details

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).
The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

MmAgilentDesign026655_dbconn returns a connection object to the package annotation DB. IM-
PORTANT: Don’t call dbDisconnect on the connection object returned by MmAgilentDesign026655_dbconn
or you will break all the AnnDbObj objects defined in this package!
MmAgilentDesign026655_dbfile returns the path (character string) to the package annotation DB
(this is an SQLite file).
MmAgilentDesign026655_dbschema prints the schema definition of the package annotation DB.
MmAgilentDesign026655_dbInfo prints other information about the package annotation DB.

Value

MmAgilentDesign026655_dbconn: a DBIConnection object representing an open connection to
the package annotation DB.
MmAgilentDesign026655_dbfile: a character string with the path to the package annotation DB.
MmAgilentDesign026655_dbschema: none (invisible NULL).
MmAgilentDesign026655_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

22

Examples

MmAgilentDesign026655_dbconn

library(DBI)
## Count the number of rows in the "probes" table:
dbGetQuery(MmAgilentDesign026655_dbconn(), "SELECT COUNT(*) FROM probes")

MmAgilentDesign026655_dbschema()

MmAgilentDesign026655_dbInfo()

Index

∗ datasets

MmAgilentDesign026655.db, 2
MmAgilentDesign026655_dbconn, 21
MmAgilentDesign026655ACCNUM, 1
MmAgilentDesign026655ALIAS2PROBE,

2

MmAgilentDesign026655CHR, 3
MmAgilentDesign026655CHRLENGTHS, 4
MmAgilentDesign026655CHRLOC, 4
MmAgilentDesign026655ENSEMBL, 5
MmAgilentDesign026655ENTREZID, 6
MmAgilentDesign026655ENZYME, 7
MmAgilentDesign026655GENENAME, 9
MmAgilentDesign026655GO, 10
MmAgilentDesign026655MAPCOUNTS, 12
MmAgilentDesign026655MGI, 12
MmAgilentDesign026655ORGANISM, 13
MmAgilentDesign026655PATH, 14
MmAgilentDesign026655PFAM, 15
MmAgilentDesign026655PMID, 15
MmAgilentDesign026655PROSITE, 17
MmAgilentDesign026655REFSEQ, 17
MmAgilentDesign026655SYMBOL, 18
MmAgilentDesign026655UNIGENE, 19
MmAgilentDesign026655UNIPROT, 20

∗ utilities

MmAgilentDesign026655_dbconn, 21

AnnDbObj, 21

cat, 21
checkMAPCOUNTS, 12

dbconn, 21
dbConnect, 21
dbDisconnect, 21
dbfile, 21
dbGetQuery, 21
dbInfo, 21
dbschema, 21

MmAgilentDesign026655

(MmAgilentDesign026655.db), 2

MmAgilentDesign026655.db, 2

23

MmAgilentDesign026655_dbconn, 21
MmAgilentDesign026655_dbfile

(MmAgilentDesign026655_dbconn),
21

MmAgilentDesign026655_dbInfo

(MmAgilentDesign026655_dbconn),
21

MmAgilentDesign026655_dbschema

(MmAgilentDesign026655_dbconn),
21

MmAgilentDesign026655ACCNUM, 1
MmAgilentDesign026655ALIAS2PROBE, 2
MmAgilentDesign026655CHR, 3
MmAgilentDesign026655CHRLENGTHS, 4
MmAgilentDesign026655CHRLOC, 4
MmAgilentDesign026655CHRLOCEND

(MmAgilentDesign026655CHRLOC),
4

MmAgilentDesign026655ENSEMBL, 5
MmAgilentDesign026655ENSEMBL2PROBE

(MmAgilentDesign026655ENSEMBL),
5

MmAgilentDesign026655ENTREZID, 6
MmAgilentDesign026655ENZYME, 7
MmAgilentDesign026655ENZYME2PROBE

(MmAgilentDesign026655ENZYME),
7

MmAgilentDesign026655GENENAME, 9
MmAgilentDesign026655GO, 10
MmAgilentDesign026655GO2ALLPROBES, 11
MmAgilentDesign026655GO2ALLPROBES

(MmAgilentDesign026655GO), 10

MmAgilentDesign026655GO2PROBE

(MmAgilentDesign026655GO), 10

MmAgilentDesign026655LOCUSID

(MmAgilentDesign026655ENTREZID),
6

MmAgilentDesign026655MAPCOUNTS, 12
MmAgilentDesign026655MGI, 12
MmAgilentDesign026655MGI2PROBE

(MmAgilentDesign026655MGI), 12

MmAgilentDesign026655ORGANISM, 13
MmAgilentDesign026655ORGPKG

24

INDEX

(MmAgilentDesign026655ORGANISM),
13

MmAgilentDesign026655PATH, 14
MmAgilentDesign026655PATH2PROBE

(MmAgilentDesign026655PATH), 14

MmAgilentDesign026655PFAM, 15
MmAgilentDesign026655PMID, 15
MmAgilentDesign026655PMID2PROBE

(MmAgilentDesign026655PMID), 15

MmAgilentDesign026655PROSITE, 17
MmAgilentDesign026655REFSEQ, 17
MmAgilentDesign026655SYMBOL, 18
MmAgilentDesign026655UNIGENE, 19
MmAgilentDesign026655UNIPROT, 20
MmAgilentDesign026655UNIPROT2PROBE

(MmAgilentDesign026655UNIPROT),
20

