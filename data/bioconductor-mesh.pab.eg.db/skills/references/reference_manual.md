MeSH.Pab.eg.db

April 16, 2019

MeSH.Pab.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Pab.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Pab.eg.db)
MeSH.Pab.eg.db

cls <- columns(MeSH.Pab.eg.db)
cls
kts <- keytypes(MeSH.Pab.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Pab.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Pab.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Pab.eg.db)
dbfile(MeSH.Pab.eg.db)
dbschema(MeSH.Pab.eg.db)
dbInfo(MeSH.Pab.eg.db)
species(MeSH.Pab.eg.db)

1

Index

MeSH.Pab.eg.db, 1

2

