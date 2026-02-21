MeSH.Pto.eg.db

April 16, 2019

MeSH.Pto.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Pto.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Pto.eg.db)
MeSH.Pto.eg.db

cls <- columns(MeSH.Pto.eg.db)
cls
kts <- keytypes(MeSH.Pto.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Pto.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Pto.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Pto.eg.db)
dbfile(MeSH.Pto.eg.db)
dbschema(MeSH.Pto.eg.db)
dbInfo(MeSH.Pto.eg.db)
species(MeSH.Pto.eg.db)

1

Index

MeSH.Pto.eg.db, 1

2

