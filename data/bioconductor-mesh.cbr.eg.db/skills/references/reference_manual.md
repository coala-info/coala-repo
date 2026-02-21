MeSH.Cbr.eg.db

April 16, 2019

MeSH.Cbr.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Cbr.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Cbr.eg.db)
MeSH.Cbr.eg.db

cls <- columns(MeSH.Cbr.eg.db)
cls
kts <- keytypes(MeSH.Cbr.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Cbr.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Cbr.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Cbr.eg.db)
dbfile(MeSH.Cbr.eg.db)
dbschema(MeSH.Cbr.eg.db)
dbInfo(MeSH.Cbr.eg.db)
species(MeSH.Cbr.eg.db)

1

Index

MeSH.Cbr.eg.db, 1

2

