MeSH.Bta.eg.db

April 16, 2019

MeSH.Bta.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Bta.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Bta.eg.db)
MeSH.Bta.eg.db

cls <- columns(MeSH.Bta.eg.db)
cls
kts <- keytypes(MeSH.Bta.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Bta.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Bta.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Bta.eg.db)
dbfile(MeSH.Bta.eg.db)
dbschema(MeSH.Bta.eg.db)
dbInfo(MeSH.Bta.eg.db)
species(MeSH.Bta.eg.db)

1

Index

MeSH.Bta.eg.db, 1

2

