MeSH.Lma.eg.db

April 16, 2019

MeSH.Lma.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Lma.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Lma.eg.db)
MeSH.Lma.eg.db

cls <- columns(MeSH.Lma.eg.db)
cls
kts <- keytypes(MeSH.Lma.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Lma.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Lma.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Lma.eg.db)
dbfile(MeSH.Lma.eg.db)
dbschema(MeSH.Lma.eg.db)
dbInfo(MeSH.Lma.eg.db)
species(MeSH.Lma.eg.db)

1

Index

MeSH.Lma.eg.db, 1

2

