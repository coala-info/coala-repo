MeSH.Dme.eg.db

April 16, 2019

MeSH.Dme.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Dme.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Dme.eg.db)
MeSH.Dme.eg.db

cls <- columns(MeSH.Dme.eg.db)
cls
kts <- keytypes(MeSH.Dme.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Dme.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Dme.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Dme.eg.db)
dbfile(MeSH.Dme.eg.db)
dbschema(MeSH.Dme.eg.db)
dbInfo(MeSH.Dme.eg.db)
species(MeSH.Dme.eg.db)

1

Index

MeSH.Dme.eg.db, 1

2

