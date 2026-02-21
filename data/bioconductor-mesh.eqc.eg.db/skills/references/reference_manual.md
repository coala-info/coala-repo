MeSH.Eqc.eg.db

April 16, 2019

MeSH.Eqc.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Eqc.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Eqc.eg.db)
MeSH.Eqc.eg.db

cls <- columns(MeSH.Eqc.eg.db)
cls
kts <- keytypes(MeSH.Eqc.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Eqc.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Eqc.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Eqc.eg.db)
dbfile(MeSH.Eqc.eg.db)
dbschema(MeSH.Eqc.eg.db)
dbInfo(MeSH.Eqc.eg.db)
species(MeSH.Eqc.eg.db)

1

Index

MeSH.Eqc.eg.db, 1

2

