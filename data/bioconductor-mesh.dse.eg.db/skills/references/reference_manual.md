MeSH.Dse.eg.db

April 16, 2019

MeSH.Dse.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Dse.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Dse.eg.db)
MeSH.Dse.eg.db

cls <- columns(MeSH.Dse.eg.db)
cls
kts <- keytypes(MeSH.Dse.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Dse.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Dse.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Dse.eg.db)
dbfile(MeSH.Dse.eg.db)
dbschema(MeSH.Dse.eg.db)
dbInfo(MeSH.Dse.eg.db)
species(MeSH.Dse.eg.db)

1

Index

MeSH.Dse.eg.db, 1

2

