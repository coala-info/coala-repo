MeSH.Dya.eg.db

April 16, 2019

MeSH.Dya.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Dya.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Dya.eg.db)
MeSH.Dya.eg.db

cls <- columns(MeSH.Dya.eg.db)
cls
kts <- keytypes(MeSH.Dya.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Dya.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Dya.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Dya.eg.db)
dbfile(MeSH.Dya.eg.db)
dbschema(MeSH.Dya.eg.db)
dbInfo(MeSH.Dya.eg.db)
species(MeSH.Dya.eg.db)

1

Index

MeSH.Dya.eg.db, 1

2

