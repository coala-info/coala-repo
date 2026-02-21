MeSH.Xla.eg.db

April 16, 2019

MeSH.Xla.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Xla.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Xla.eg.db)
MeSH.Xla.eg.db

cls <- columns(MeSH.Xla.eg.db)
cls
kts <- keytypes(MeSH.Xla.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Xla.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Xla.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Xla.eg.db)
dbfile(MeSH.Xla.eg.db)
dbschema(MeSH.Xla.eg.db)
dbInfo(MeSH.Xla.eg.db)
species(MeSH.Xla.eg.db)

1

Index

MeSH.Xla.eg.db, 1

2

