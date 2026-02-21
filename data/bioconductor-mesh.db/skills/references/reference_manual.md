MeSH.db
April 11, 2018

MeSH.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.db

Author(s)

Itoshi NIKAIDO

Examples

library(MeSH.db)
MeSH.db

cls <- columns(MeSH.db)
cls
kts <- keytypes(MeSH.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.db, keytype=kts[2]))
ks
res <- select(MeSH.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.db)
dbfile(MeSH.db)
dbschema(MeSH.db)
dbInfo(MeSH.db)

1

Index

MeSH.db, 1

2

