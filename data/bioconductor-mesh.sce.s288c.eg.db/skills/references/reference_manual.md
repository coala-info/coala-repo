MeSH.Sce.S288c.eg.db

April 16, 2019

MeSH.Sce.S288c.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Sce.S288c.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Sce.S288c.eg.db)
MeSH.Sce.S288c.eg.db

cls <- columns(MeSH.Sce.S288c.eg.db)
cls
kts <- keytypes(MeSH.Sce.S288c.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Sce.S288c.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Sce.S288c.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Sce.S288c.eg.db)
dbfile(MeSH.Sce.S288c.eg.db)
dbschema(MeSH.Sce.S288c.eg.db)
dbInfo(MeSH.Sce.S288c.eg.db)
species(MeSH.Sce.S288c.eg.db)

1

Index

MeSH.Sce.S288c.eg.db, 1

2

