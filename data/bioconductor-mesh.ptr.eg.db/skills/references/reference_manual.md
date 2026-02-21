MeSH.Ptr.eg.db

April 16, 2019

MeSH.Ptr.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Ptr.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Ptr.eg.db)
MeSH.Ptr.eg.db

cls <- columns(MeSH.Ptr.eg.db)
cls
kts <- keytypes(MeSH.Ptr.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Ptr.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Ptr.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Ptr.eg.db)
dbfile(MeSH.Ptr.eg.db)
dbschema(MeSH.Ptr.eg.db)
dbInfo(MeSH.Ptr.eg.db)
species(MeSH.Ptr.eg.db)

1

Index

MeSH.Ptr.eg.db, 1

2

