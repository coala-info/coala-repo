MeSH.Hsa.eg.db

April 16, 2019

MeSH.Hsa.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Hsa.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Hsa.eg.db)
MeSH.Hsa.eg.db

cls <- columns(MeSH.Hsa.eg.db)
cls
kts <- keytypes(MeSH.Hsa.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Hsa.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Hsa.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Hsa.eg.db)
dbfile(MeSH.Hsa.eg.db)
dbschema(MeSH.Hsa.eg.db)
dbInfo(MeSH.Hsa.eg.db)
species(MeSH.Hsa.eg.db)

1

Index

MeSH.Hsa.eg.db, 1

2

