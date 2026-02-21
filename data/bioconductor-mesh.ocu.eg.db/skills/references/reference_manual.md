MeSH.Ocu.eg.db

April 16, 2019

MeSH.Ocu.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Ocu.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Ocu.eg.db)
MeSH.Ocu.eg.db

cls <- columns(MeSH.Ocu.eg.db)
cls
kts <- keytypes(MeSH.Ocu.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Ocu.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Ocu.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Ocu.eg.db)
dbfile(MeSH.Ocu.eg.db)
dbschema(MeSH.Ocu.eg.db)
dbInfo(MeSH.Ocu.eg.db)
species(MeSH.Ocu.eg.db)

1

Index

MeSH.Ocu.eg.db, 1

2

