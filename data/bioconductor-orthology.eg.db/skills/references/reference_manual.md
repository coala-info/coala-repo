Orthology.eg.db

February 11, 2026

Orthology.eg.db

Bioconductor annotation data package

Description

Welcome to the Orthology.eg.db annotation Package. The purpose of this package is to provide
orthology mappings between species, based on NCBI Gene IDs and NCBI orthology mappings.
This package is updated biannually.

Objects in this package are accessed using the select() interface. See ?select in the AnnotationDbi
package for details.

Please note that this package is slightly different from other annotation packages; the keytypes and
columns are species names, separated by a period (e.g. Homo.sapiens), and the keys are the NCBI
Gene IDs that are to be mapped between species. See examples for more details.

See Also

• AnnotationDb-class for use of keys(), columns() and select().

Examples

## select() interface:
## Objects in this package can be accessed using the select() interface
## from the AnnotationDbi package. See ?select for details.
## Map NCBI Gene IDs from human to mouse
select(Orthology.eg.db, as.character(c(1,9,13:22)),"Mus.musculus","Homo.sapiens")

## get list of available species
head(keytypes(Orthology.eg.db))

## get list of Gene IDs for Electric eel
eeKeys <- keys(Orthology.eg.db, "Electrophorus.electricus")
head(eeKeys)

## map all availble Electric eel genes to human
ee2human <- select(Orthology.eg.db, eeKeys, "Homo.sapiens", "Electrophorus.electricus")

1

2

Orthology.eg_dbconn

Orthology.eg_dbconn

Collect information about the package annotation DB

Description

Some convenience functions for getting a connection object to (or collecting information about) the
package annotation DB.

Usage

Orthology.eg_dbconn()
Orthology.eg_dbfile()
Orthology.eg_dbschema(file="", show.indices=FALSE)
Orthology.eg_dbInfo()

Arguments

file

A connection, or a character string naming the file to print to (see the file
argument of the cat function for the details).

show.indices

The CREATE INDEX statements are not shown by default. Use show.indices=TRUE
to get them.

Details

Orthology.eg_dbconn returns a connection object to the package annotation DB. IMPORTANT:
Don’t call dbDisconnect on the connection object returned by Orthology.eg_dbconn or you will
break all the AnnDbObj objects defined in this package!

Orthology.eg_dbfile returns the path (character string) to the package annotation DB (this is an
SQLite file).

Orthology.eg_dbschema prints the schema definition of the package annotation DB.

Orthology.eg_dbInfo prints other information about the package annotation DB.

Value

Orthology.eg_dbconn: a DBIConnection object representing an open connection to the package
annotation DB.

Orthology.eg_dbfile: a character string with the path to the package annotation DB.

Orthology.eg_dbschema: none (invisible NULL).

Orthology.eg_dbInfo: none (invisible NULL).

See Also

dbGetQuery, dbConnect, dbconn, dbfile, dbschema, dbInfo

Orthology.eg_dbconn

Examples

3

library(DBI)
## Count the number of rows in the "genes" table:
dbGetQuery(Orthology.eg_dbconn(), "SELECT COUNT(*) FROM genes")

Orthology.eg_dbschema()

Orthology.eg_dbInfo()

Index

∗ datasets

Orthology.eg.db, 1
Orthology.eg_dbconn, 2

∗ utilities

Orthology.eg_dbconn, 2

AnnDbObj, 2

cat, 2

dbconn, 2
dbConnect, 2
dbDisconnect, 2
dbfile, 2
dbGetQuery, 2
dbInfo, 2
dbschema, 2

Orthology.eg (Orthology.eg.db), 1
Orthology.eg.db, 1
Orthology.eg_dbconn, 2
Orthology.eg_dbfile

(Orthology.eg_dbconn), 2

Orthology.eg_dbInfo

(Orthology.eg_dbconn), 2

Orthology.eg_dbschema

(Orthology.eg_dbconn), 2

4

