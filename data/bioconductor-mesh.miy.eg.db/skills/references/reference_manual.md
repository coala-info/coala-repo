MeSH.Miy.eg.db

April 16, 2019

MeSH.Miy.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Miy.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Miy.eg.db)
MeSH.Miy.eg.db

cls <- columns(MeSH.Miy.eg.db)
cls
kts <- keytypes(MeSH.Miy.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Miy.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Miy.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Miy.eg.db)
dbfile(MeSH.Miy.eg.db)
dbschema(MeSH.Miy.eg.db)
dbInfo(MeSH.Miy.eg.db)
species(MeSH.Miy.eg.db)

1

Index

MeSH.Miy.eg.db, 1

2

