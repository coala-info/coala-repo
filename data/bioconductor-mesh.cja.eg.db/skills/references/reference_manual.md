MeSH.Cja.eg.db

April 16, 2019

MeSH.Cja.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Cja.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Cja.eg.db)
MeSH.Cja.eg.db

cls <- columns(MeSH.Cja.eg.db)
cls
kts <- keytypes(MeSH.Cja.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Cja.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Cja.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Cja.eg.db)
dbfile(MeSH.Cja.eg.db)
dbschema(MeSH.Cja.eg.db)
dbInfo(MeSH.Cja.eg.db)
species(MeSH.Cja.eg.db)

1

Index

MeSH.Cja.eg.db, 1

2

