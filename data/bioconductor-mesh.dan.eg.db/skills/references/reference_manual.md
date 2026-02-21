MeSH.Dan.eg.db

April 16, 2019

MeSH.Dan.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Dan.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Dan.eg.db)
MeSH.Dan.eg.db

cls <- columns(MeSH.Dan.eg.db)
cls
kts <- keytypes(MeSH.Dan.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Dan.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Dan.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Dan.eg.db)
dbfile(MeSH.Dan.eg.db)
dbschema(MeSH.Dan.eg.db)
dbInfo(MeSH.Dan.eg.db)
species(MeSH.Dan.eg.db)

1

Index

MeSH.Dan.eg.db, 1

2

