MeSH.Dmo.eg.db

April 16, 2019

MeSH.Dmo.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Dmo.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Dmo.eg.db)
MeSH.Dmo.eg.db

cls <- columns(MeSH.Dmo.eg.db)
cls
kts <- keytypes(MeSH.Dmo.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Dmo.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Dmo.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Dmo.eg.db)
dbfile(MeSH.Dmo.eg.db)
dbschema(MeSH.Dmo.eg.db)
dbInfo(MeSH.Dmo.eg.db)
species(MeSH.Dmo.eg.db)

1

Index

MeSH.Dmo.eg.db, 1

2

