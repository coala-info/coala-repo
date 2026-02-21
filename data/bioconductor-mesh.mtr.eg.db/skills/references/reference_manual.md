MeSH.Mtr.eg.db

April 16, 2019

MeSH.Mtr.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Mtr.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Mtr.eg.db)
MeSH.Mtr.eg.db

cls <- columns(MeSH.Mtr.eg.db)
cls
kts <- keytypes(MeSH.Mtr.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Mtr.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Mtr.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Mtr.eg.db)
dbfile(MeSH.Mtr.eg.db)
dbschema(MeSH.Mtr.eg.db)
dbInfo(MeSH.Mtr.eg.db)
species(MeSH.Mtr.eg.db)

1

Index

MeSH.Mtr.eg.db, 1

2

