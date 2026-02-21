mirbase.db
April 16, 2019

mirbase.db

Bioconductor Custom Annotation Data Package

Description

Welcome to the mirbase.db custom annotation package. This package contains multiple organisms.
The purpose is to provide detailed information about the mirRBase microRNA database (http:
//www.mirbase.org/). In particular, it covers the searchable database of published microRNA
sequences and annotation and not the miRBase Registry and Targets database. As requested by
the providers of this resource, the references below should be cited when making use of the data.
Ambros et al. 2003 provides guidelines on microRNA annotation.

The current version and release date are: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/
With a date stamp from the source of: 01 Aug 2012. This information is also available by using the
mirbase() function.

This package is updated biannually.
You can learn what objects this package supports with the following command: ls("package:mirbase.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with examples of how to use it. Many of these objects also have a reverse map available. When this
is true, expect to usually ﬁnd relevant information on the same manual page as the forward map.

References

Grifﬁths-Jones S, Saini HK, van Dongen S, Enright AJ. miRBase: tools for microRNA genomics.
NAR 2008 36(Database Issue):D154-D158 http://nar.oxfordjournals.org/cgi/content/full/
36/suppl_1/D154

Grifﬁths-Jones S, Grocock RJ, van Dongen S, Bateman A, Enright AJ. miRBase: microRNA se-
quences, targets and gene nomenclature. NAR 2006 34(Database Issue):D140-D144 http://nar.
oxfordjournals.org/cgi/content/full/34/suppl_1/D140

Grifﬁths-Jones S. The microRNA Registry. NAR 2004 32(Database Issue):D109-D111 http://
nar.oupjournals.org/cgi/content/full/32/suppl_1/D109

Ambros V, Bartel B, Bartel DP, Burge CB, Carrington JC, Chen X, Dreyfuss G, Eddy SR, Grifﬁths-
Jones S, Marshall M, Matzke M, Ruvkun G, Tuschl T. A uniform system for microRNA annotation.
RNA 2003 9(3):277-279 http://www.rnajournal.org/cgi/content/full/9/3/277

Examples

ls("package:mirbase.db")

1

2

mirbaseCHRLOC

mirbaseCHR

MicroRNA IDs to Chromosomes

Description

mirbaseCHR is an R object that provides mappings between microRNA identiﬁers and the chromo-
some that contains the microRNA of interest.

Details

Each microRNA identiﬁer maps to a vector of character strings representing possibly multiple chro-
mosomes.

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

Examples

x <- mirbaseCHR
# Get the microRNA identifiers that are mapped to a chromosome
mapped_keys <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_keys])
if(length(xx) > 0) {

# Get the CHR for the first five entries
xx[1:5]

}

mirbaseCHRLOC

MicroRNA IDs to Chromosomal Location

Description

mirbaseCHRLOC is an R object that maps microRNA identiﬁers to the starting position of the
microRNA. The position of a microRNA is measured as the number of base pairs.

The CHRLOCEND mapping is the same as the CHRLOC mapping except that it speciﬁes the
ending base of a microRNA instead of the start.

Details

Each microRNA identiﬁer maps to a named vector of chromosomal locations, where the name
indicates the chromosome.

Chromosomal locations on both the sense and antisense strands are measured as the number of base
pairs from the p (5’ end of the sense strand) to q (3’ end of the sense strand) arms. Chromosomal
locations on the antisense strand have a leading "-" sign (e. g. -1234567).

Since some microRNAs have multiple start sites, this ﬁeld can map to multiple locations.

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

mirbaseCLUSTER

Examples

3

x <- mirbaseCHRLOC
# Get the microRNA identifiers that are mapped to chromosome locations
mapped_keys <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_keys])
if(length(xx) > 0) {

# Get the CHRLOC for the first five entries
xx[1:5]

}

mirbaseCLUSTER

MicroRNA IDs to Clusters

Description

mirbaseCLUSTER is an R object that provides mappings between microRNA identiﬁers and other
microRNA identiﬁers within a 10kb window (’genomic cluster’).

Details

Each microRNA identiﬁer maps to a vector of a microRNA identiﬁers belonging to a cluster (if any
beyound itself). This information was computed ad-hoc as it is not included in the original data
tables provided by mirbase.org.

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

Examples

x <- mirbaseCLUSTER
# Get the first cluster containg more than one element
clL <- eapply(x, length)
id <- names(clL[clL > 1])[1]
get(id, x)

mirbaseCOMMENT

MicroRNA IDs to Comments

Description

mirbaseCOMMENTS is an R object that provides mappings between microRNA identiﬁers and
comments related to their description.

Details

Each microRNA identiﬁer maps to a character string. The references cited in the comment can be
found by using mirbasePMID.

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

mirbaseDESCRIPTION

4

See Also

mirbasePMID

Examples

# first microRNA with a comment that includes a citation.
mir1 <- intersect(mappedkeys(mirbaseCOMMENT),
mappedkeys(mirbasePMID))[1]

get(mir1, mirbaseCOMMENT)
get(mir1, mirbasePMID)

mirbaseCONTEXT

MicroRNA IDs to Genomic Context

Description

mirbaseCONTEXT is an R object that maps microRNA identiﬁers to information related to over-
lapping transcripts.

Details

Each microRNA identiﬁer maps to a mirnaContext object that has 6 slots: contextTranscriptID:
Transcript identifer contextOverlapSense: Strand of transcript contextOverlapType: Type of over-
lap (exon, intron, 3’ or 5’ UTR) contextNumber: Type of overlap number (eg exon 3) contextTran-
scriptSource: Transcript database contextTranscriptName: Transcript Name

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

See Also

mirnaContext

Examples

x <- mirbaseCONTEXT
# Get the CONTEXT for the first element mapped
get(mappedkeys(x)[1], x)

mirbaseDESCRIPTION

MicroRNA IDs to Descriptions

Description

mirbaseDESCRIPTION is an R object that provides mappings between microRNA identiﬁers and
their full names.

Details

Each microRNA identiﬁer maps to a character string.

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

mirbaseFAMILY

Examples

x <- mirbaseDESCRIPTION
# first 3 entries with a description.
mget(mappedkeys(x)[1:3], x)

mirbaseFAMILY

MicroRNA IDs to Family

5

Description

mirbaseFAMILY is an R object that provides mappings between microRNA identiﬁers and their
family.

Details

Each microRNA identiﬁer maps to a character string which is the miRNA gene family ID. The
name of the returned value is the family name.

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

Examples

x <- mirbaseFAMILY
# first 3 microRNA with a family.
mget(mappedkeys(x)[1:3], x)

mirbaseHAIRPIN

MicroRNA IDs to Hairpin

Description

mirbaseHAIRPIN is an R object that provides mappings between microRNA identiﬁers and an
ASCII representation of the the folded precursor (stem-loop sequence).

Details

Each microRNA identiﬁer maps to a character string. The mature microRNA(s) sequence are high-
lighted in capital letters.

The representation was created the RNAfold program from the ViennaRNA suite http://www.tbi.
univie.ac.at/~ivo/RNA/. Extra information include the minimum free energy (’MFE’) which
can be found by using mirbaseMFE and the position on the sequence of mature mirna(s) which can
be found by using mirbaseMATURE.

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

References

Hofacker IL, Stadler PF. Memory efﬁcient folding algorithms for circular RNA secondary struc-
tures. Bioinformatics. 2006 May 15; 22(10):1172-6. http://www.ncbi.nlm.nih.gov/pubmed/
16452114

mirbaseID2SPECIES

6

Examples

x <- mirbaseHAIRPIN
# hairpin representation sequences of all microRNAs
mirnaHairpin <- mget(mappedkeys(x), x)
# print first one
cat(mirnaHairpin[[1]], "\n")

mirbaseID2ACC

MicroRNA IDs to Accessions

Description

mirbaseID2ACC is an R object that provides mappings between microRNA identiﬁers and their
Accession numbers.

Details

Each microRNA identiﬁer maps to a unique Accession number.

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

Examples

x <- mirbaseID2ACC
# Get the microRNA identifiers that are mapped to an Accession
mapped_keys <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_keys])
if(length(xx) > 0) {

# Get the ID2ACC for the first five entries
xx[1:5]

}

mirbaseID2SPECIES

MicroRNA IDs to Species

Description

mirbaseID2SPECIES is an R object that provides mappings between microRNA identiﬁers and the
species they belong to.

Details

Each microRNA identiﬁer maps to a unique character string which is an abbreviated name of
the species. Further information concerning the species can be found by using the name with
mirbaseSPECIES.

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

mirbaseLINKS

Examples

7

x <- mirbaseID2SPECIES
# Get the microRNA identifiers that are mapped to a species
mapped_keys <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_keys])
if(length(xx) > 0) {

# Get the ID2SPECIES for the first five entries
xx[1:5]

}

mirbaseLINKS

MicroRNA IDs to External Database Links

Description

mirbaseLINKS is an R object that maps microRNA identiﬁers to a set external database identiﬁers.

Details

Each microRNA identiﬁer maps to a mirnaLinks object that has 3 slots: linksDbLink: Accession
number linksDbId: Database linksDbSecondary: Second accession number (or name)

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

See Also

mirnaLinks

Examples

x <- mirbaseLINKS
mapped_keys <- mappedkeys(x)
# Get the LINKS for the first element of xx
get(mapped_keys[1], x)

mirbaseMAPCOUNTS

Number of mapped keys for the maps in package mirbase.db

Description

mirbaseMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each map in
package mirbase.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function deﬁned in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

mirbaseMATURE

8

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

Examples

mirbaseMAPCOUNTS
mapnames <- names(mirbaseMAPCOUNTS)
mirbaseMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package mirbase.db
checkMAPCOUNTS("mirbase.db")

mirbaseMATURE

MicroRNA IDs to Mature MicroRNAs

Description

mirbaseMATURE is an R object that maps microRNA identiﬁers to information related to their
corresponding mature microRNA(s).

Details

Each microRNA identiﬁer maps to a mirnaMATURE object that has 7 slots: matureAccession: Ac-
cession number matureName: ID (or name) matureFrom: Start position in precursor sequence
matureTo: End position in precursor sequence matureEvidence: Experimental evidence mature-
Experiment: Experiment description and citation matureSimilarity: Accession number of similar
precursor microRNA

The citations in the Experiment description can be retrieved by using mirbasePMID.

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

Examples

x <- mirbaseMATURE
mapped_keys <- mappedkeys(x)
# Get the MATURE for the first element of xx
get(mapped_keys[1], x)

mirbaseMFE

9

mirbaseMFE

MicroRNA IDs to Minimum Fold Energy

Description

mirbaseMFE is an R object that provides mappings between microRNA identiﬁers and the Mini-
mum Fold Energy of the folded precursor (stem-loop sequence).

Details

Each microRNA identiﬁer maps to a unique numeric value representing the Minimum Fold En-
ergy of the folded precursor (stem-loop sequence) computed by the RNAfold program from the
ViennaRNA suite http://www.tbi.univie.ac.at/~ivo/RNA/.

A graphical representation of the folded sequence can be found by using mirbaseHAIRPIN.

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

References

Hofacker IL, Stadler PF. Memory efﬁcient folding algorithms for circular RNA secondary struc-
tures. Bioinformatics. 2006 May 15; 22(10):1172-6. http://www.ncbi.nlm.nih.gov/pubmed/
16452114

See Also

mirbaseHAIRPIN

Examples

x <- mirbaseMFE
# Get the microRNA identifiers that are mapped to a MFE
mapped_keys <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_keys])
if(length(xx) > 0) {

# Get the MFE for the first five entries
xx[1:5]

}

mirbasePMID

MicroRNA IDs to References

Description

mirbasePMID is an R object that maps microRNA identiﬁers to a set of references (PubMed IDen-
tiﬁers).

10

Details

mirbaseSEQUENCE

Each microRNA identiﬁer maps to a mirnaPmid object that has 5 slots: pmidAuthor: List of authors
pmidTitle: Title pmidJournal: Citation pmidMedline: Pubmed identiﬁer pmidOrderAdded: Order

The Order is the same as the one used in mirbaseCOMMENT and in mirbaseMATURE.

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

See Also

mirnaPmid

Examples

x <- mirbasePMID
mapped_keys <- mappedkeys(x)
# Get the PMIDs for the first element of xx
get(mapped_keys[1], x)

mirbaseSEQUENCE

MicroRNA IDs to Sequence

Description

mirbaseSEQUENCE is an R object that provides mappings between microRNA identiﬁers and their
precursor sequence (stem-loop).

Details

Each microRNA identiﬁer maps to a unique character string representing the precursor (stem-loop)
sequence of the microRNA. A graphical representation of the folded sequence can be found by
using mirbaseHAIRPIN.

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

See Also

mirbaseHAIRPIN

Examples

x <- mirbaseSEQUENCE
# Get the microRNA identifiers that are mapped to a SEQUENCE
mapped_keys <- mappedkeys(x)
# Convert to a list
xx <- as.list(x[mapped_keys])
if(length(xx) > 0) {

# Get the SEQUENCE for the first five entries
xx[1:5]

}

mirbaseSPECIES

11

mirbaseSPECIES

Organism Acronym to Species

Description

mirbaseSPECIES is an R object that provides mappings between organism acronyms and the species
speciﬁcations.

Details

Each organism acronym to a unique character string which is the full name of the species. Further
information concerning the species can be found by using the toTable function which reports the
’division’, ’taxonomy’, ’genome_assembly’ and the ’ensembl_db’ used.

The organism acronym of a microRNA is returned by using mirbaseID2SPECIES.

Source: miRBase (Version: 19) ftp://mirbase.org/pub/mirbase/CURRENT/ With a date stamp from
the source of: 01 Aug 2012

See Also

mirbaseID2SPECIES

Examples

x <- mirbaseID2SPECIES
y <- mirbaseSPECIES
# get full species information for the first microRNA
mir1 <- mappedkeys(x)[1]
mir1Species <- get(mir1, x)
get(mir1Species, y)
toTable(y[mir1Species])

mirbase_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

mirbase_dbconn()
mirbase_dbfile()
mirbase_dbschema(file="", show.indices=FALSE)
mirbase_dbInfo()

12

Arguments

file

mirnaContext-class

A connection, or a character string naming the ﬁle to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

mirbase_dbconn returns a connection object to the package annotation DB. IMPORTANT: Don’t
call dbDisconnect on the connection object returned by mirbase_dbconn or you will break all the
AnnDbObj objects deﬁned in this package!

mirbase_dbfile returns the path (character string) to the package annotation DB (this is an SQLite
ﬁle).

mirbase_dbschema prints the schema deﬁnition of the package annotation DB.

mirbase_dbInfo prints other information about the package annotation DB.

Value

mirbase_dbconn: a DBIConnection object representing an open connection to the package anno-
tation DB.

mirbase_dbfile: a character string with the path to the package annotation DB.

mirbase_dbschema: none (invisible NULL).

mirbase_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

## Count the number of rows in the "ID2ACC" table:
dbGetQuery(mirbase_dbconn(), "SELECT COUNT(*) FROM mirna")

## The connection object returned by mirbase_dbconn() was
## created with:
dbConnect(SQLite(), dbname=mirbase_dbfile(), cache_size=64000,
synchronous=0)

mirbase_dbschema()

mirbase_dbInfo()

mirnaContext-class

Class "mirnaContext"

Description

A class to represent the genomic context of a microRNA

mirnaLinks-class

Objects from the Class

13

Objects can be created by calls of the form new("mirnaContext", contextTranscriptID, contextOverlapSense,

contextOverlapType, contextNumber, contextTranscriptSource,

contextTranscriptName).

Slots

contextTranscriptID: Object of class "character" A character string for Transcript identifer

overlapping a microRNA.

contextOverlapSense: Object of class "character" A character string for the Strand of tran-

script.

contextOverlapType: Object of class "character" A character string for the of Type of overlap

(exon, intron, 3’ or 5’ UTR).

contextNumber: Object of class "numeric" A numeric vector for the Type of overlap number (eg

exon 3).

contextTranscriptSource: Object of class "character" A character string for the Transcript

database.

contextTranscriptName: Object of class "character" A character string for the Transcript Name.

Methods

contextTranscriptID signature(object = "mirnaContext"): The get method for slot context-

TranscriptID.

contextOverlapSense signature(object = "mirnaContext"): The get method for slot contex-

tOverlapSense.

contextOverlapType signature(object = "mirnaContext"): The get method for slot contex-

tOverlapType.

contextNumber signature(object = "mirnaContext"): The get method for slot contextNum-

ber.

contextTranscriptSource signature(object = "mirnaContext"): The get method for slot

contextTranscriptSource.

contextTranscriptName signature(object = "mirnaContext"): The get method for slot con-

textTranscriptName.

show signature(x = "mirnaContext"): The method for pretty print.

See Also

mirbaseCONTEXT

mirnaLinks-class

Class "mirnaLinks"

Description

A class to represent microRNA external database links

Objects from the Class

Objects can be created by calls of the form new("mirnaLinks", linksDbLink, linksDbId, linksDbSecondary).

14

Slots

mirnaMature-class

linksDbLink: Object of class "character" A character string for the Accession number of a

microRNA.

linksDbId: Object of class "character" A character string for the Database of a microRNA.

linksDbSecondary: Object of class "character" A character string for the Second accession

number (or name) of a mature microRNA.

Methods

linksDbLink signature(object = "mirnaLinks"): The get method for slot linksDbLink.

linksDbId signature(object = "mirnaLinks"): The get method for slot linksDbId.

linksDbSecondary signature(object = "mirnaLinks"): The get method for slot linksDbSec-

ondary.

show signature(x = "mirnaLinks"): The method for pretty print.

See Also

mirbaseLINKS

mirnaMature-class

Class "mirnaMature"

Description

A class to represent mature microRNAs

Objects from the Class

Objects can be created by calls of the form new("mirnaMature", matureAccession, matureName, matureFrom,

matureTo, matureEvidence, matureExperiment, matureSimilarity).

Slots

matureAccession: Object of class "character" A character string for the Accession number of

a mature microRNA.

matureName: Object of class "character" A character string for the ID (or name) of a mature

microRNA.

matureFrom: Object of class "character" A character string for Start position in precursor se-

quence of a mature microRNA.

matureTo: Object of class "character" A character string for the End position in precursor se-

quence of a mature microRNA.

matureEvidence: Object of class "character" A character string for the Experimental evidence

of a mature microRNA.

matureExperiment: Object of class "character" A character string for the Experiment descrip-

tion and citation of a mature microRNA.

matureSimilarity: Object of class "character" A character string for the Accession number of

similar precursor microRNA of a mature microRNA.

mirnaPmid-class

Methods

15

matureAccession signature(object = "mirnaMature"): The get method for slot matureAc-

cession.

matureName signature(object = "mirnaMature"): The get method for slot matureName.
matureFrom signature(object = "mirnaMature"): The get method for slot matureFrom.
matureTo signature(object = "mirnaMature"): The get method for slot matureTo.
matureEvidence signature(object = "mirnaMature"): The get method for slot matureEvi-

dence.

matureExperiment signature(object = "mirnaMature"): The get method for slot matureEx-

periment.

matureSimilarity signature(object = "mirnaMature"): The get method for slot matureSimi-

larity.

show signature(x = "mirnaMature"): The method for pretty print.

See Also

mirbaseMATURE

mirnaPmid-class

Class "mirnaPmid"

Description

A class to represent microRNA references

Objects from the Class

Objects can be created by calls of the form new("mirnaPmid", pmidAuthor, pmidTitle, pmidJournal, pmidMedline, pmidOrderAdded).

Slots

pmidAuthor: Object of class "character" A character string for the authors of a reference.
pmidTitle: Object of class "character" A character string for the title of a reference.
pmidJournal: Object of class "character" A character string for the citation of a reference.
pmidMedline: Object of class "numeric" A numeric vector for the Pubmed identiﬁer of a refer-

ence.

pmidOrderAdded: Object of class "numeric" A numeric vector for the order of the reference.

Methods

pmidAuthor signature(object = "mirnaPmid"): The get method for slot pmidAuthor.
pmidTitle signature(object = "mirnaPmid"): The get method for slot pmidTitle.
pmidJournal signature(object = "mirnaPmid"): The get method for slot pmidJournal.
pmidMedline signature(object = "mirnaPmid"): The get method for slot pmidMedline.
pmidOrderAdded signature(object = "mirnaPmid"): The get method for slot pmidOrder-

Added.

show signature(x = "mirnaPmid"): The method for pretty print.

16

See Also

mirbasePMID

mirnaPmid-class

Index

∗Topic classes

mirnaContext-class, 12
mirnaLinks-class, 13
mirnaMature-class, 14
mirnaPmid-class, 15

∗Topic datasets

mirbase_dbconn, 11
mirbaseMAPCOUNTS, 7

∗Topic data

mirbase.db, 1
mirbaseCHR, 2
mirbaseCHRLOC, 2
mirbaseCLUSTER, 3
mirbaseCOMMENT, 3
mirbaseCONTEXT, 4
mirbaseDESCRIPTION, 4
mirbaseFAMILY, 5
mirbaseHAIRPIN, 5
mirbaseID2ACC, 6
mirbaseID2SPECIES, 6
mirbaseLINKS, 7
mirbaseMATURE, 8
mirbaseMFE, 9
mirbasePMID, 9
mirbaseSEQUENCE, 10
mirbaseSPECIES, 11

∗Topic methods

mirnaContext-class, 12
mirnaLinks-class, 13
mirnaMature-class, 14
mirnaPmid-class, 15

∗Topic utilities

mirbase_dbconn, 11

AnnDbObj, 12

cat, 12
checkMAPCOUNTS, 7, 8
contextNumber (mirnaContext-class), 12
contextNumber,mirnaContext-method

(mirnaContext-class), 12

contextOverlapSense

(mirnaContext-class), 12

17

contextOverlapSense,mirnaContext-method
(mirnaContext-class), 12

contextOverlapType

(mirnaContext-class), 12
contextOverlapType,mirnaContext-method
(mirnaContext-class), 12

contextTranscriptID

(mirnaContext-class), 12
contextTranscriptID,mirnaContext-method
(mirnaContext-class), 12

contextTranscriptName

(mirnaContext-class), 12

contextTranscriptName,mirnaContext-method

(mirnaContext-class), 12

contextTranscriptSource

(mirnaContext-class), 12

contextTranscriptSource,mirnaContext-method

(mirnaContext-class), 12

count.mappedkeys, 8

dbconn, 12
dbConnect, 12
dbDisconnect, 12
dbfile, 12
dbGetQuery, 12
dbInfo, 12
dbschema, 12

linksDbId (mirnaLinks-class), 13
linksDbId,mirnaLinks-method

(mirnaLinks-class), 13

linksDbLink (mirnaLinks-class), 13
linksDbLink,mirnaLinks-method
(mirnaLinks-class), 13
linksDbSecondary (mirnaLinks-class), 13
linksDbSecondary,mirnaLinks-method

(mirnaLinks-class), 13

mappedkeys, 8
matureAccession (mirnaMature-class), 14
matureAccession,mirnaMature-method

(mirnaMature-class), 14
matureEvidence (mirnaMature-class), 14

18

INDEX

matureEvidence,mirnaMature-method

mirbasePmidBimap-class

(mirnaPmid-class), 15

mirbaseSEQUENCE, 10
mirbaseSPECIES, 6, 11
mirbaseSPECIES2ID (mirbaseID2SPECIES), 6
mirnaContext, 4
mirnaContext (mirnaContext-class), 12
mirnaContext-class, 12
mirnaLinks, 7
mirnaLinks (mirnaLinks-class), 13
mirnaLinks-class, 13
mirnaMature (mirnaMature-class), 14
mirnaMature-class, 14
mirnaPmid, 10
mirnaPmid (mirnaPmid-class), 15
mirnaPmid-class, 15

pmidAuthor (mirnaPmid-class), 15
pmidAuthor,mirnaPmid-method
(mirnaPmid-class), 15

pmidJournal (mirnaPmid-class), 15
pmidJournal,mirnaPmid-method
(mirnaPmid-class), 15

pmidMedline (mirnaPmid-class), 15
pmidMedline,mirnaPmid-method
(mirnaPmid-class), 15
pmidOrderAdded (mirnaPmid-class), 15
pmidOrderAdded,mirnaPmid-method

(mirnaPmid-class), 15

pmidTitle (mirnaPmid-class), 15
pmidTitle,mirnaPmid-method

(mirnaPmid-class), 15

show,mirnaContext-method

(mirnaContext-class), 12

show,mirnaLinks-method

(mirnaLinks-class), 13

show,mirnaMature-method

(mirnaMature-class), 14

show,mirnaPmid-method

(mirnaPmid-class), 15

toTable, 11

(mirnaMature-class), 14
matureExperiment (mirnaMature-class), 14
matureExperiment,mirnaMature-method

(mirnaMature-class), 14

matureFrom (mirnaMature-class), 14
matureFrom,mirnaMature-method
(mirnaMature-class), 14

matureName (mirnaMature-class), 14
matureName,mirnaMature-method
(mirnaMature-class), 14
matureSimilarity (mirnaMature-class), 14
matureSimilarity,mirnaMature-method

(mirnaMature-class), 14
matureTo (mirnaMature-class), 14
matureTo,mirnaMature-method

(mirnaMature-class), 14

mirbase (mirbase.db), 1
mirbase.db, 1
mirbase_dbconn, 11
mirbase_dbfile (mirbase_dbconn), 11
mirbase_dbInfo (mirbase_dbconn), 11
mirbase_dbschema (mirbase_dbconn), 11
mirbaseACC2ID (mirbaseID2ACC), 6
mirbaseCHR, 2
mirbaseCHRLOC, 2
mirbaseCHRLOCEND (mirbaseCHRLOC), 2
mirbaseCLUSTER, 3
mirbaseCOMMENT, 3, 10
mirbaseCONTEXT, 4, 13
mirbaseContextBimap

(mirnaContext-class), 12

mirbaseContextBimap-class

(mirnaContext-class), 12

mirbaseDESCRIPTION, 4
mirbaseFAMILY, 5
mirbaseHAIRPIN, 5, 9, 10
mirbaseID2ACC, 6
mirbaseID2SPECIES, 6, 11
mirbaseLINKS, 7, 14
mirbaseLinksBimap (mirnaLinks-class), 13
mirbaseLinksBimap-class

(mirnaLinks-class), 13

mirbaseMAPCOUNTS, 7
mirbaseMATURE, 5, 8, 10, 15
mirbaseMatureBimap (mirnaMature-class),

14

mirbaseMatureBimap-class

(mirnaMature-class), 14

mirbaseMFE, 5, 9
mirbasePMID, 3, 4, 8, 9, 16
mirbasePmidBimap (mirnaPmid-class), 15

