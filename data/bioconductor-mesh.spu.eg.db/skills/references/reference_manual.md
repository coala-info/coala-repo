MeSH.Spu.eg.db

April 16, 2019

MeSH.Spu.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Spu.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Spu.eg.db)
MeSH.Spu.eg.db

cls <- columns(MeSH.Spu.eg.db)
cls
kts <- keytypes(MeSH.Spu.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Spu.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Spu.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Spu.eg.db)
dbfile(MeSH.Spu.eg.db)
dbschema(MeSH.Spu.eg.db)
dbInfo(MeSH.Spu.eg.db)
species(MeSH.Spu.eg.db)

1

Index

MeSH.Spu.eg.db, 1

2

