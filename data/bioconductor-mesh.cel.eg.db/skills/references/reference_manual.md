MeSH.Cel.eg.db

April 16, 2019

MeSH.Cel.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Cel.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Cel.eg.db)
MeSH.Cel.eg.db

cls <- columns(MeSH.Cel.eg.db)
cls
kts <- keytypes(MeSH.Cel.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Cel.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Cel.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Cel.eg.db)
dbfile(MeSH.Cel.eg.db)
dbschema(MeSH.Cel.eg.db)
dbInfo(MeSH.Cel.eg.db)
species(MeSH.Cel.eg.db)

1

Index

MeSH.Cel.eg.db, 1

2

