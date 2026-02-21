MeSH.Cfa.eg.db

April 16, 2019

MeSH.Cfa.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Cfa.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Cfa.eg.db)
MeSH.Cfa.eg.db

cls <- columns(MeSH.Cfa.eg.db)
cls
kts <- keytypes(MeSH.Cfa.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Cfa.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Cfa.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Cfa.eg.db)
dbfile(MeSH.Cfa.eg.db)
dbschema(MeSH.Cfa.eg.db)
dbInfo(MeSH.Cfa.eg.db)
species(MeSH.Cfa.eg.db)

1

Index

MeSH.Cfa.eg.db, 1

2

