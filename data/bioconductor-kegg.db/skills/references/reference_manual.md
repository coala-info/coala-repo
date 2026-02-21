KEGG.db

August 27, 2020

KEGG.db

Bioconductor annotation data package

Description

Welcome to the KEGG.db annotation Package. The purpose of this package was to provide detailed
information about the latest version of the KEGG pathway databases. But a number of years ago,
KEGG changed their policy about sharing their data and so this package is no longer allowed to
be current. Users who are interested in a more current pathway data are encouraged to look at the
KEGGREST or reactome.db packages.

Objects in this package are accessed using the select() interface. See ?select in the AnnotationDbi
package for details.

See Also

• AnnotationDb-class for use of keys(), columns() and select().

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
columns(KEGG.db)

## Bimap interface:
## The 'old style' of interacting with these objects is manipulation as
## bimaps. While this approach is still available we strongly encourage the
## use of select().
ls("package:KEGG.db")

1

2

KEGGEXTID2PATHID

KEGGENZYMEID2GO

An annotation data object that maps Enzyme Commission numbers to
Gene Ontology identiﬁers

Description

KEGGENZYMEID2GO maps Enzyme Commission numbers to Gene Ontoloty (GO) identiﬁers

Details

This is an R object containing key and value pairs. Keys are Enzyme Commission numbers and
values are GO identiﬁers. Values are vectors of length 1. Enzyme Commission numbers that can
not be mapped to a GO term are assigned a value NA.

Mappings were based on data provided by: Gene Ontology External Link http://www.geneontology.org/external2go
With a date stamp from the source of: 2015-Sepec2go27

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
xx <- as.list(KEGGENZYMEID2GO)
if(length(xx) > 0){

# Get the value of the first key
xx[[1]]
# Get values for a few keys
if(length(xx) >= 3)

xx[1:3]

}

KEGGEXTID2PATHID

An annotation data object that maps Entrez Gene or Open Reading
Frame identiﬁers KEGG pathway identiﬁers

Description

KEGGEXTID2PATHID maps Entrez Gene (for human, mouse, and rat) and Open Reading Frame
(for yeast) identiﬁers to KEGG pathway identiﬁers.

KEGGGO2ENZYMEID

Details

3

This is an R object containing key and value pairs. Keys are Entrez Gene identiﬁers for human,
mouse, and rat and Open Reading Frame (ORF) identiﬁers for yeast and values are the correspond-
ing KEGG pathway identiﬁers. Values are vectors of length 1 or greater depending on whether a
given external identiﬁer can be mapped to only one or more KEGG pathway identiﬁers. NAs are
assigned to Entrez Gene or ORF identiﬁers that can not be mapped to any pathway identiﬁer.

KEGG pathway identiﬁers are the identiﬁers used by KEGG for various pathways.

Mappings between KEGG pathway identiﬁers and pathway names can be obtained through another
annotation data object named KEGGPATHID2NAME.

Mappings were based on data provided by: KEGG GENOME ftp://ftp.genome.jp/pub/kegg/genomes
With a date stamp from the source of: 2011-Mar15

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
xx <- as.list(KEGGEXTID2PATHID)
if(length(xx) > 0){

# Get the value of the first key
xx[[1]]
# Get the values for multiget for a few keys
if(length(xx) >= 3){
xx[1:3]
}

}

KEGGGO2ENZYMEID

An annotation data object that maps Gene Ontology (GO) identiﬁers
to Enzyme Commission numbers

Description

KEGGGO2ENZYMEID maps GO identiﬁers to Enzyme Commission numbers

Details

This is an R object containing key and value pairs. Keys are GO identiﬁers and values are Enzyme
Commission numbers. Values are vectors of length 1. GO identiﬁers can not be mapped to any
Enzyme Commission number are assigned NAs.

Mappings are based on data provided by: Gene Ontology External Link http://www.geneontology.org/external2go
With a date stamp from the source of: 2015-Sepec2go27

4

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

See Also

• AnnotationDb-class for use of the select() interface.

KEGGMAPCOUNTS

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
xx <- as.list(KEGGGO2ENZYMEID)
if(length(xx) > 0){

# Get the value of the first key
xx[[1]]
# Get values for a few keys
if(length(xx) >= 3){
xx[1:3]
}

}

KEGGMAPCOUNTS

Number of mapped keys for the maps in package KEGG.db

Description

KEGGMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each map in
package KEGG.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function deﬁned in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

• mappedkeys,

• count.mappedkeys,

• checkMAPCOUNTS

• AnnotationDb-class for use of the select() interface.

KEGGPATHID2EXTID

Examples

5

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
KEGGMAPCOUNTS
mapnames <- names(KEGGMAPCOUNTS)
KEGGMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package KEGG.db
checkMAPCOUNTS("KEGG.db")

KEGGPATHID2EXTID

An annotation data object that maps KEGG pathway identiﬁers to En-
trez Gene or Open Reading Frame identiﬁers.

Description

KEGGPATHID2EXTID maps KEGG pathway identiﬁers to Entrez Gene (for human, mouse, and
rat) or Open Reading Frame (for yeast) identiﬁers

Details

This is an R object containing key and value pairs. Keys are KEGG pathway identiﬁers and values
are Entrez Gene identiﬁers for human, mouse, and rat or Open Reading Frame (ORF) identiﬁers
for yeast. Values are vectors of length 1 or greater depending on whether a pathway identiﬁer can
be maapped to one or more Entrez Gene or ORF identiﬁers. NAs are assigned to KEGG pathway
identiﬁers that can not be mapped to any Entrez Gene or ORF identiﬁers.

KEGG pathway identiﬁers are the identiﬁers used by KEGG for various pathways.

Mappings between KEGG pathway identiﬁers and pathway names can be obtained through another
annotation data object named KEGGPATHID2NAME.

Mappings were based on data provided by: KEGG GENOME ftp://ftp.genome.jp/pub/kegg/genomes
With a date stamp from the source of: 2011-Mar15

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

See Also

• AnnotationDb-class for use of the select() interface.

6

Examples

KEGGPATHID2NAME

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
xx <- as.list(KEGGPATHID2EXTID)
if(length(xx) > 0){

# Get the value of the first key
xx[[1]]
# Get the values for multiget for a few keys
if(length(xx) >= 3){
xx[1:3]
}

}

KEGGPATHID2NAME

An annotation data object that maps KEGG pathway identiﬁers to
KEGG pathway names

Description

KEGGPATHID2NAME maps KEGG pathway identiﬁers to pathway names used by KEGG for
various pathways

Details

This is an R object containing key and value pairs. Keys are KEGG pathway identiﬁers and values
are pathway names. Values are vectors of length 1.

Mappings were based on data provided by: KEGG PATHWAY ftp://ftp.genome.jp/pub/kegg/pathway
With a date stamp from the source of: 2011-Mar15

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
xx <- as.list(KEGGPATHID2NAME)
if(length(xx) > 0){

# get the value for the first key
xx[[1]]
# Get the values for a few keys
if(length(xx) >= 3){

KEGGPATHNAME2ID

xx[1:3]
}

}

7

KEGGPATHNAME2ID

An annotation data object that maps KEGG pathway names to identi-
ﬁers for the corresponding pathway names used by KEGG

Description

KEGGPATHNAME2ID maps KEGG pathway names to pathway identiﬁers used by KEGG for
various pathways

Details

This is an R object containing key and value pairs. Keys are KEGG pathway names and values are
pathway identiﬁers. Values are vectors of length 1.

Mappings were based on data provided by: KEGG PATHWAY ftp://ftp.genome.jp/pub/kegg/pathway
With a date stamp from the source of: 2011-Mar15

References

ftp://ftp.genome.ad.jp/pub/kegg/pathways

See Also

• AnnotationDb-class for use of the select() interface.

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.

## Bimap interface:
xx <- as.list(KEGGPATHNAME2ID)
if(length(xx) > 0){

# get the value for the first key
xx[[1]]
# Get the values for a few keys
if(length(xx) >= 3){
xx[1:3]
}

}

8

KEGG_dbconn

KEGG_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

KEGG_dbconn()
KEGG_dbfile()
KEGG_dbschema(file="", show.indices=FALSE)
KEGG_dbInfo()

Arguments

file

A connection, or a character string naming the ﬁle to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

KEGG_dbconn returns a connection object to the package annotation DB. IMPORTANT: Don’t
call dbDisconnect on the connection object returned by KEGG_dbconn or you will break all the
AnnDbObj objects deﬁned in this package!

KEGG_dbfile returns the path (character string) to the package annotation DB (this is an SQLite
ﬁle).

KEGG_dbschema prints the schema deﬁnition of the package annotation DB.

KEGG_dbInfo prints other information about the package annotation DB.

Value

KEGG_dbconn: a DBIConnection object representing an open connection to the package annotation
DB.

KEGG_dbfile: a character string with the path to the package annotation DB.

KEGG_dbschema: none (invisible NULL).

KEGG_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

KEGG_dbconn

Examples

9

library(DBI)
## Count the number of rows in the "pathway2name" table:
dbGetQuery(KEGG_dbconn(), "SELECT COUNT(*) FROM pathway2name")

KEGG_dbschema()

KEGG_dbInfo()

Index

∗ datasets

KEGG.db, 1
KEGG_dbconn, 8
KEGGENZYMEID2GO, 2
KEGGEXTID2PATHID, 2
KEGGGO2ENZYMEID, 3
KEGGMAPCOUNTS, 4
KEGGPATHID2EXTID, 5
KEGGPATHID2NAME, 6
KEGGPATHNAME2ID, 7

∗ utilities

KEGG_dbconn, 8

AnnDbObj, 8

cat, 8
checkMAPCOUNTS, 4
count.mappedkeys, 4

dbconn, 8
dbConnect, 8
dbDisconnect, 8
dbfile, 8
dbGetQuery, 8
dbInfo, 8
dbschema, 8

KEGG (KEGG.db), 1
KEGG.db, 1
KEGG_dbconn, 8
KEGG_dbfile (KEGG_dbconn), 8
KEGG_dbInfo (KEGG_dbconn), 8
KEGG_dbschema (KEGG_dbconn), 8
KEGGENZYMEID2GO, 2
KEGGEXTID2PATHID, 2
KEGGGO2ENZYMEID, 3
KEGGMAPCOUNTS, 4
KEGGPATHID2EXTID, 5
KEGGPATHID2NAME, 6
KEGGPATHNAME2ID, 7

mappedkeys, 4

10

