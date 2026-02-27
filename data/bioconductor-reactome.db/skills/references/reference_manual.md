reactome.db
February 25, 2026

reactome.db

Bioconductor annotation data package

Description

Welcome to the reactome.db annotation Package. The purpose of this package is to provide detailed
information about the latest version of the Reactome database. This package is updated biannually.

You can learn what objects this package supports with the following command:

ls("package:reactome.db")

Each of these objects has their own manual page detailing where relevant data was obtained along
with some examples of how to use it.

Examples

ls("package:reactome.db")

reactomeEXTID2PATHID

An annotation data object that maps Entrez Gene identifiers to Reac-
tome pathway identifiers

Description

reactomeEXTID2PATHID maps Entrez Gene identifiers to Reactome pathway identifiers.

Details

This is an R object containing key and value pairs. Keys are Entrez Gene identifiers and values
are the corresponding Reactome pathway identifiers. Values are vectors of length 1 or greater
depending on whether a given external identifier can be mapped to only one or more Reactome
pathway identifiers.

Reactome pathway identifiers are the identifiers used by Reactome for various pathways.

Mappings between Reactome pathway identifiers and pathway names can be obtained through an-
other annotation data object named reactomePATHID2NAME.

Mappings were based on data provided by: Reactome http://reactome.org/download/current/NCBI2Reactome_All_Levels.txt
& http://reactome.org/download/current/ReactomePathways.txt With a date stamp from the source
that is the same as the time stamp of the package.

1

reactomeGO2REACTOMEID

2

References

http://www.reactome.org/

Examples

xx <- as.list(reactomeEXTID2PATHID)
if(length(xx) > 0){
# Get the value of the first key
xx[[1]]
# Get the values for multiget for a few keys
if(length(xx) >= 3){
xx[1:3]
}
}

reactomeGO2REACTOMEID An annotation data object that maps Gene Ontology (GO) identifiers

to Reactome database identifiers

Description

reactomeGO2REACTOMEID maps GO identifiers to Reactome database identifiers

Details

This is an R object containing key and value pairs. Keys are GO identifiers and values are Reactome
database identifiers. Values are vectors of length 1.

Mappings were based on data provided by: Reactome wget http://reactome.org/download/current/gene_association.reactome
With a date stamp from the source that is the same as the time stamp of the package.

References

http://www.reactome.org/

Examples

xx <- as.list(reactomeGO2REACTOMEID)
if(length(xx) > 0){
# Get the value of the first key
xx[[1]]
# Get values for a few keys
if(length(xx) >= 3){
xx[1:3]
}
}

reactomeMAPCOUNTS

3

reactomeMAPCOUNTS

Number of mapped keys for the maps in package reactome.db

Description

reactomeMAPCOUNTS provides the "map count" (i.e. the count of mapped keys) for each map in
package reactome.db.

Details

This "map count" information is precalculated and stored in the package annotation DB. This allows
some quality control and is used by the checkMAPCOUNTS function defined in AnnotationDbi to com-
pare and validate different methods (like count.mappedkeys(x) or sum(!is.na(as.list(x))))
for getting the "map count" of a given map.

See Also

mappedkeys, count.mappedkeys, checkMAPCOUNTS

Examples

reactomeMAPCOUNTS
mapnames <- names(reactomeMAPCOUNTS)
reactomeMAPCOUNTS[mapnames[1]]
x <- get(mapnames[1])
sum(!is.na(as.list(x)))
count.mappedkeys(x)

# much faster!

## Check the "map count" of all the maps in package reactome.db
checkMAPCOUNTS("reactome.db")

reactomePATHID2EXTID

An annotation data object that maps Reactome pathway identifiers to
Entrez Gene identifiers.

Description

reactomePATHID2EXTID maps Reactome pathway identifiers to Entrez Gene identifiers

Details

This is an R object containing key and value pairs. Keys are Reactome pathway identifiers and
values are Entrez Gene identifiers. Values are vectors of length 1 or greater depending on whether
a pathway identifier can be mapped to one or more Entrez Gene identifiers.

Reactome pathway identifiers are the identifiers used by Reactome for various pathways.

Mappings between Reactome pathway identifiers and pathway names can be obtained through an-
other annotation data object named reactomePATHID2NAME.

Mappings were based on data provided by: Reactome http://reactome.org/download/current/NCBI2Reactome_All_Levels.txt
& http://reactome.org/download/current/ReactomePathways.txt With a date stamp from the source
that is the same as the time stamp of the package.

reactomePATHID2NAME

4

References

http://www.reactome.org/

Examples

xx <- as.list(reactomePATHID2EXTID)
if(length(xx) > 0){
# Get the value of the first key
xx[[1]]
# Get the values for multiget for a few keys
if(length(xx) >= 3){
xx[1:3]
}
}

reactomePATHID2NAME

An annotation data object that maps Reactome pathway identifiers to
Reactome pathway names

Description

reactomePATHID2NAME maps Reactome pathway identifiers to pathway names used by Reactome
for various pathways

Details

This is an R object containing key and value pairs. Keys are Reactome pathway identifiers and
values are pathway names. Values are vectors of length 1.

Mappings were based on data provided by: Reactome http://reactome.org/download/current/ReactomePathways.txt
With a date stamp from the source that is the same as the time stamp of the package.

References

http://www.reactome.org/

Examples

xx <- as.list(reactomePATHID2NAME)
if(length(xx) > 0){
# get the value for the first key
xx[[1]]
# Get the values for a few keys
if(length(xx) >= 3){
xx[1:3]
}
}

reactomePATHNAME2ID

5

reactomePATHNAME2ID

An annotation data object that maps Reactome pathway names to
identifiers for the corresponding pathway names used by Reactome

Description

reactomePATHNAME2ID maps Reactome pathway names to pathway identifiers used by Reactome
for various pathways

Details

This is an R object containing key and value pairs. Keys are Reactome pathway names and values
are pathway identifiers. Values are vectors of length 1.

Mappings were based on data provided by: Reactome http://reactome.org/download/current/ReactomePathways.txt
With a date stamp from the source that is the same as the time stamp of the package.

References

http://www.reactome.org/

Examples

xx <- as.list(reactomePATHNAME2ID)
if(length(xx) > 0){
# get the value for the first key
xx[[1]]
# Get the values for a few keys
if(length(xx) >= 3){
xx[1:3]
}
}

reactomeREACTOMEID2GO An annotation data object that maps Reactome database identifiers to

Gene Ontology identifiers

Description

reactomeREACTOMEID2GO maps Reactome database identifiers to Gene Ontoloty (GO) identi-
fiers

Details

This is an R object containing key and value pairs. Keys are Reactome database identifiers and
values are GO identifiers. Values are vectors of length 1.

Mappings were based on data provided by: Reactome http://reactome.org/download/current/gene_association.reactome
With a date stamp from the source that is the same as the time stamp of the package.

References

http://www.reactome.org/

reactome_dbconn

6

Examples

xx <- as.list(reactomeREACTOMEID2GO)
if(length(xx) > 0){
# Get the value of the first key
xx[[1]]

# Get values for a few keys

if(length(xx) >= 3){
xx[1:3]
}
}

reactome_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

reactome_dbconn()
reactome_dbfile()
reactome_dbschema(file="", show.indices=FALSE)
reactome_dbInfo()

Arguments

file

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

reactome_dbconn returns a connection object to the package annotation DB. IMPORTANT: Don’t
call dbDisconnect on the connection object returned by reactome_dbconn or you will break all
the AnnDbObj objects defined in this package!

reactome_dbfile returns the path (character string) to the package annotation DB (this is an
SQLite file).

reactome_dbschema prints the schema definition of the package annotation DB.

reactome_dbInfo prints other information about the package annotation DB.

Value

reactome_dbconn: a DBIConnection object representing an open connection to the package anno-
tation DB.

reactome_dbfile: a character string with the path to the package annotation DB.

reactome_dbschema: none (invisible NULL).

reactome_dbInfo: none (invisible NULL).

7

reactome_dbconn

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Examples

library(RSQLite)
## Count the number of rows in the "pathway2name" table:
dbGetQuery(reactome_dbconn(), "SELECT COUNT(*) FROM pathway2name")

## The connection object returned by reactome_dbconn() was
## created with:
dbConnect(SQLite(), dbname=reactome_dbfile(), cache_size=64000,
synchronous="off")

reactome_dbschema()

reactome_dbInfo()

Index

∗ datasets

reactome.db, 1
reactome_dbconn, 6
reactomeEXTID2PATHID, 1
reactomeGO2REACTOMEID, 2
reactomeMAPCOUNTS, 3
reactomePATHID2EXTID, 3
reactomePATHID2NAME, 4
reactomePATHNAME2ID, 5
reactomeREACTOMEID2GO, 5

∗ utilities

reactome_dbconn, 6

AnnDbObj, 6

cat, 6
checkMAPCOUNTS, 3
count.mappedkeys, 3

dbconn, 7
dbConnect, 7
dbDisconnect, 6
dbfile, 7
dbGetQuery, 7
dbInfo, 7
dbschema, 7

mappedkeys, 3

reactome (reactome.db), 1
reactome.db, 1
reactome_dbconn, 6
reactome_dbfile (reactome_dbconn), 6
reactome_dbInfo (reactome_dbconn), 6
reactome_dbschema (reactome_dbconn), 6
reactomeEXTID2PATHID, 1
reactomeGO2REACTOMEID, 2
reactomeMAPCOUNTS, 3
reactomePATHID2EXTID, 3
reactomePATHID2NAME, 4
reactomePATHNAME2ID, 5
reactomeREACTOMEID2GO, 5

8

