targetscan.Mm.eg.db

April 16, 2019

targetscan.Mm.eg.db

Bioconductor annotation data package

Description

Welcome to the targetscan.Mm.eg.db annotation Package. The purpose of this package is to provide
detailed information about the latest version of the TargetScan miRNA target prediction database.
This package is updated biannually.

You can learn what objects this package supports with the following command:

ls("package:targetscan.Mm.eg.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

There are currently two annotation packages for TargetScan, one for human and another one for
mouse. These correspond to the TargetScanHuman and the TargetScanMouse databases, see the
TargetScan website for details.

Please note, that the package currently contains _only_ the prediction for conserved miRNA tar-
gets, separately for each miRNA family. These are the predicted targets that are returned are the
’conserved across mammals’ ones which are listed in the table ’Predicted Conserved Targets Info’
from the download page.

References

http://www.targetscan.org

Examples

ls("package:targetscan.Mm.eg.db")

1

2

targetscan.Mm.egMAPCOUNTS

targetscan.Mm.egFAMILY2MIRBASE

An annotation data object that maps miRNA families to miRBase iden-
tiﬁers

Description

targetscan.Mm.egFAMILY2MIRBASE maps miRNA family names to miRBase identiﬁers. The
mappings are taken from the TargetScan database.

Details

This is an R object containing key and value pairs. Keys are miRNA family names and values
are miRBase identiﬁers. Values are vectors of various lengths, as a single miRNA family usually
corresponds to many miRBase miRNAs.

References

http://www.targetscan.org for TargetScan and http://www.mirbase.org/ for miRBase.

See Also

The miRBase database is also provided as a custom annotation package in Bioconductor: mir-
base.db.

Examples

## Map some random miRNA families
fams <- sample(ls(targetscan.Mm.egFAMILY2MIRBASE), 3)
mget(fams, targetscan.Mm.egFAMILY2MIRBASE)

targetscan.Mm.egMAPCOUNTS

Number of mapped keys for the maps in package targetscan.Mm.eg.db

Description

targetscan.Mm.egMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each
map in package targetscan.Mm.eg.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function deﬁned in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

targetscan.Mm.egMIRBASE2FAMILY

3

Examples

targetscan.Mm.egMAPCOUNTS
mapnames <- names(targetscan.Mm.egMAPCOUNTS)
targetscan.Mm.egMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package targetscan.Mm.eg.db
checkMAPCOUNTS("targetscan.Mm.eg.db")

targetscan.Mm.egMIRBASE2FAMILY

An annotation data object that maps miRBase identiﬁers to miRNA
family names

Description

targetscan.Mm.egMIRBASE2FAMILY maps miRBase identiﬁers to miRNA family names. The
mappings are taken from the TargetScan database.

Details

This is an R object containing key and value pairs. Keys are miRBase identiﬁeers and values are
miRNA family names. Values are vectors of length 1, as a miRBase miRNA belongs to a single
miRNA family.

References

http://www.targetscan.org for TargetScan and http://www.mirbase.org for miRBase.

See Also

The miRBase database is also provided as a custom annotation package in Bioconductor: mir-
base.db.

Examples

## Map some random miRBase miRNAs
fams <- sample(ls(targetscan.Mm.egMIRBASE2FAMILY), 3)
mget(fams, targetscan.Mm.egMIRBASE2FAMILY)

4

targetscan.Mm.egTARGETS

targetscan.Mm.egMIRNA Annotation of miRBase identiﬁers to associated data

Description

This data set gives mappings between miRBase identiﬁers and their respective associated data.

Details

This is an R object containing key and value pairs. Keys are miRBase identiﬁers and values are
their associated data. Values are simple named lists of the following members:

MiRBase.ID The miRBase identiﬁer, it starts with a three letter species code.

MiRBase.Accession Accession number of the miRNA.

Seed.m8 miRNA seed, seven bases from the 5’ end og the miRNA.

Species Scientiﬁc name of the species.

Mature.sequence Mature sequence of the miRNA.

Family.conservation Level of conservation of the miRNA family.

The package contains the data for all miRBase identiﬁers, the ones for other species as well.

References

http://www.targetscan.org for TargetScan and http://microrna.sanger.ac.uk/sequences/
for miRBase.

Examples

## Query some random miRBase identifiers
fams <- sample(ls(targetscan.Mm.egMIRNA), 3)
mget(fams, targetscan.Mm.egMIRNA)

targetscan.Mm.egTARGETS

Annotation data for TargetScane miRNA target predictions

Description

targetscan.Mm.egTARGETS maps Entrez gene ideniﬁers to miRNA families. The mappings are
taken from the TargetScan database.

targetscan.Mm.egTARGETSFULL

5

Details

TargetScan predicts biological targets of miRNAs by searching for a presence of conserved 8mer
and 7mer sites that match the seed region of each miRNA.

There are currently two annotation packages for TargetScan, one for human and another one for
mouse. These correspond to the TargetScanHuman and the TargetScanMouse databases, see the
TargetScan website for details.

targetscan.Mm.egTARGETS is an R object containing key and value pairs. Keys are Entrez gene
identiﬁers and values are miRNA families. Values are vectors of various lengths, as some genes as
predicted to be potentially regulated by many miRNA families. Note that a given miRNA family can
come up many times in the value vector, if the miRNA seed matches the UTR of gene at multiple
positions.

References

http://www.targetscan.org for TargetScan and http://www.mirbase.org/ for miRBase.

See Also

targetscan.Mm.egTARGETSFULL for more information about the miRNA targets. The miRBase
database is also provided as a custom annotation package in Bioconductor: mirbase.db.

Examples

## Get the miRNA families that regulate these genes
genes <- sample(ls(targetscan.Mm.egTARGETS), 3)
mget( genes, targetscan.Mm.egTARGETS )

## Get all targets of a given miRNA family
mget("miR-10abc/10a-5p", revmap(targetscan.Mm.egTARGETS))

targetscan.Mm.egTARGETSFULL

Annotation data for TargetScane miRNA target predictions

Description

targetscan.Mm.egTARGETSFULL maps Entrez gene ideniﬁers to miRNA families. The mappings
are taken from the TargetScan database.

Details

TargetScan predicts biological targets of miRNAs by searching for a presence of conserved 8mer
and 7mer sites that match the seed region of each miRNA.

There are currently two annotation packages for TargetScan, one for human and another one for
mouse. These correspond to the TargetScanHuman and the TargetScanMouse databases, see the
TargetScan website for details.

targetscan.Mm.egTARGETSFULL is an R object containing key and value pairs. Keys are Entrez
gene identiﬁers and values are lists, each list member corresponds to a predicted targeting miRNA
family. Each list member is itself a list with the following members:

miR.Family Name of the miRNA family.

6

targetscan.Mm.eg_dbconn

UTR.start Start position on UTR.

UTR.end End position on UTR.

MSA.start Start of multiple sequence alignment, with gaps.

MSA.end End of multiple sequence alignment.

Seed.match Type of the matching. Possible values are ‘8mer’, which means that all eight bases
match, ‘m8’, which means an exact match to positions 2-8 of the mature miRNA, and ‘1A’,
which means that positions 2-7 of the mature miRnA match, followed by an ’A’.

PCT The probability of conserved targeting, see Friedman et al. in the references section below

for details.

References

Friedman RC, Farh KK, Burge CB, Bartel DP.: Most mammalian mRNAs are conserved targets of
microRNAs. Genome Res. 2009 Jan;19(1):92-105

http://www.targetscan.org for TargetScan and http://www.mirbase.org/ for miRBase.

See Also

The miRBase database is also provided as a custom annotation package in Bioconductor: mir-
base.db.

Examples

## Get the miRNA families that regulate these genes
genes <- sample(ls(targetscan.Mm.egTARGETSFULL), 3)
mget(genes, targetscan.Mm.egTARGETSFULL)

targetscan.Mm.eg_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

targetscan.Mm.eg_dbconn()
targetscan.Mm.eg_dbfile()
targetscan.Mm.eg_dbschema(file="", show.indices=FALSE)
targetscan.Mm.eg_dbInfo()

Arguments

file

A connection, or a character string naming the ﬁle to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

targetscan.Mm.eg_dbconn

Details

7

targetscan.Mm.eg_dbconn returns a connection object to the package annotation DB. IMPOR-
TANT: Don’t call dbDisconnect on the connection object returned by targetscan.Mm.eg_dbconn
or you will break all the AnnDbObj objects deﬁned in this package!

targetscan.Mm.eg_dbfile returns the path (character string) to the package annotation DB (this
is an SQLite ﬁle).

targetscan.Mm.eg_dbschema prints the schema deﬁnition of the package annotation DB.

targetscan.Mm.eg_dbInfo prints other information about the package annotation DB.

Value

targetscan.Mm.eg_dbconn: a DBIConnection object representing an open connection to the pack-
age annotation DB.

targetscan.Mm.eg_dbfile: a character string with the path to the package annotation DB.

targetscan.Mm.eg_dbschema: none (invisible NULL).

targetscan.Mm.eg_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

## Count the number of rows in the "mirna_family" table:
dbGetQuery(targetscan.Mm.eg_dbconn(), "SELECT COUNT(*) FROM mirna_family")

## The connection object returned by targetscan.Mm.eg_dbconn() was
## created with:
dbConnect(SQLite(), dbname=targetscan.Mm.eg_dbfile(), cache_size=64000,
synchronous=0)

targetscan.Mm.eg_dbschema()

targetscan.Mm.eg_dbInfo()

Index

∗Topic datasets

targetscan.Mm.eg.db, 1
targetscan.Mm.eg_dbconn, 6
targetscan.Mm.egFAMILY2MIRBASE, 2
targetscan.Mm.egMAPCOUNTS, 2
targetscan.Mm.egMIRBASE2FAMILY, 3
targetscan.Mm.egMIRNA, 4
targetscan.Mm.egTARGETS, 4
targetscan.Mm.egTARGETSFULL, 5

∗Topic utilities

targetscan.Mm.eg_dbconn, 6

AnnDbObj, 7

cat, 6
checkMAPCOUNTS, 2
count.mappedkeys, 2

dbconn, 7
dbConnect, 7
dbDisconnect, 7
dbfile, 7
dbGetQuery, 7
dbInfo, 7
dbschema, 7

mappedkeys, 2

targetscan.Mm.eg (targetscan.Mm.eg.db),

1

targetscan.Mm.eg.db, 1
targetscan.Mm.eg_dbconn, 6
targetscan.Mm.eg_dbfile

(targetscan.Mm.eg_dbconn), 6

targetscan.Mm.eg_dbInfo

(targetscan.Mm.eg_dbconn), 6

targetscan.Mm.eg_dbschema

(targetscan.Mm.eg_dbconn), 6

targetscan.Mm.egFAMILY2MIRBASE, 2
targetscan.Mm.egMAPCOUNTS, 2
targetscan.Mm.egMIRBASE2FAMILY, 3
targetscan.Mm.egMIRNA, 4
targetscan.Mm.egTARGETS, 4
targetscan.Mm.egTARGETSFULL, 5, 5

8

