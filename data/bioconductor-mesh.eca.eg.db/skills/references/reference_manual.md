MeSH.Eca.eg.db

August 24, 2021

MeSH.Eca.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Eca.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Eca.eg.db)
MeSH.Eca.eg.db

cls <- columns(MeSH.Eca.eg.db)
cls
kts <- keytypes(MeSH.Eca.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Eca.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Eca.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Eca.eg.db)
dbfile(MeSH.Eca.eg.db)
dbschema(MeSH.Eca.eg.db)
dbInfo(MeSH.Eca.eg.db)
species(MeSH.Eca.eg.db)

1

Index

MeSH.Eca.eg.db, 1

2

