MeSH.Mes.eg.db

April 16, 2019

MeSH.Mes.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Mes.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Mes.eg.db)
MeSH.Mes.eg.db

cls <- columns(MeSH.Mes.eg.db)
cls
kts <- keytypes(MeSH.Mes.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Mes.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Mes.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Mes.eg.db)
dbfile(MeSH.Mes.eg.db)
dbschema(MeSH.Mes.eg.db)
dbInfo(MeSH.Mes.eg.db)
species(MeSH.Mes.eg.db)

1

Index

MeSH.Mes.eg.db, 1

2

