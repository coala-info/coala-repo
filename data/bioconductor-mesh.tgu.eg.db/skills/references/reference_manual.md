MeSH.Tgu.eg.db

April 16, 2019

MeSH.Tgu.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Tgu.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Tgu.eg.db)
MeSH.Tgu.eg.db

cls <- columns(MeSH.Tgu.eg.db)
cls
kts <- keytypes(MeSH.Tgu.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Tgu.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Tgu.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Tgu.eg.db)
dbfile(MeSH.Tgu.eg.db)
dbschema(MeSH.Tgu.eg.db)
dbInfo(MeSH.Tgu.eg.db)
species(MeSH.Tgu.eg.db)

1

Index

MeSH.Tgu.eg.db, 1

2

