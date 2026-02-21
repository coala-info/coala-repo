MeSH.Xtr.eg.db

April 16, 2019

MeSH.Xtr.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Xtr.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Xtr.eg.db)
MeSH.Xtr.eg.db

cls <- columns(MeSH.Xtr.eg.db)
cls
kts <- keytypes(MeSH.Xtr.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Xtr.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Xtr.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Xtr.eg.db)
dbfile(MeSH.Xtr.eg.db)
dbschema(MeSH.Xtr.eg.db)
dbInfo(MeSH.Xtr.eg.db)
species(MeSH.Xtr.eg.db)

1

Index

MeSH.Xtr.eg.db, 1

2

