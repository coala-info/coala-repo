MeSH.Zma.eg.db

April 16, 2019

MeSH.Zma.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Zma.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Zma.eg.db)
MeSH.Zma.eg.db

cls <- columns(MeSH.Zma.eg.db)
cls
kts <- keytypes(MeSH.Zma.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Zma.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Zma.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Zma.eg.db)
dbfile(MeSH.Zma.eg.db)
dbschema(MeSH.Zma.eg.db)
dbInfo(MeSH.Zma.eg.db)
species(MeSH.Zma.eg.db)

1

Index

MeSH.Zma.eg.db, 1

2

