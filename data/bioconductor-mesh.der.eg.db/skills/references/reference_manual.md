MeSH.Der.eg.db

April 16, 2019

MeSH.Der.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Der.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Der.eg.db)
MeSH.Der.eg.db

cls <- columns(MeSH.Der.eg.db)
cls
kts <- keytypes(MeSH.Der.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Der.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Der.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Der.eg.db)
dbfile(MeSH.Der.eg.db)
dbschema(MeSH.Der.eg.db)
dbInfo(MeSH.Der.eg.db)
species(MeSH.Der.eg.db)

1

Index

MeSH.Der.eg.db, 1

2

