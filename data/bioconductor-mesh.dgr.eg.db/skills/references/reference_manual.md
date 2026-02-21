MeSH.Dgr.eg.db

April 16, 2019

MeSH.Dgr.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Dgr.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Dgr.eg.db)
MeSH.Dgr.eg.db

cls <- columns(MeSH.Dgr.eg.db)
cls
kts <- keytypes(MeSH.Dgr.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Dgr.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Dgr.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Dgr.eg.db)
dbfile(MeSH.Dgr.eg.db)
dbschema(MeSH.Dgr.eg.db)
dbInfo(MeSH.Dgr.eg.db)
species(MeSH.Dgr.eg.db)

1

Index

MeSH.Dgr.eg.db, 1

2

