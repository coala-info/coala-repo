MeSH.Vvi.eg.db

April 16, 2019

MeSH.Vvi.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Vvi.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Vvi.eg.db)
MeSH.Vvi.eg.db

cls <- columns(MeSH.Vvi.eg.db)
cls
kts <- keytypes(MeSH.Vvi.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Vvi.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Vvi.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Vvi.eg.db)
dbfile(MeSH.Vvi.eg.db)
dbschema(MeSH.Vvi.eg.db)
dbInfo(MeSH.Vvi.eg.db)
species(MeSH.Vvi.eg.db)

1

Index

MeSH.Vvi.eg.db, 1

2

