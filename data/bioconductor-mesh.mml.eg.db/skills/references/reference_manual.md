MeSH.Mml.eg.db

April 16, 2019

MeSH.Mml.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Mml.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Mml.eg.db)
MeSH.Mml.eg.db

cls <- columns(MeSH.Mml.eg.db)
cls
kts <- keytypes(MeSH.Mml.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Mml.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Mml.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Mml.eg.db)
dbfile(MeSH.Mml.eg.db)
dbschema(MeSH.Mml.eg.db)
dbInfo(MeSH.Mml.eg.db)
species(MeSH.Mml.eg.db)

1

Index

MeSH.Mml.eg.db, 1

2

