MeSH.Ana.eg.db

April 16, 2019

MeSH.Ana.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Ana.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Ana.eg.db)
MeSH.Ana.eg.db

cls <- columns(MeSH.Ana.eg.db)
cls
kts <- keytypes(MeSH.Ana.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Ana.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Ana.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Ana.eg.db)
dbfile(MeSH.Ana.eg.db)
dbschema(MeSH.Ana.eg.db)
dbInfo(MeSH.Ana.eg.db)
species(MeSH.Ana.eg.db)

1

Index

MeSH.Ana.eg.db, 1

2

