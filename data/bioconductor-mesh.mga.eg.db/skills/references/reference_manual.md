MeSH.Mga.eg.db

April 16, 2019

MeSH.Mga.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Mga.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Mga.eg.db)
MeSH.Mga.eg.db

cls <- columns(MeSH.Mga.eg.db)
cls
kts <- keytypes(MeSH.Mga.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Mga.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Mga.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Mga.eg.db)
dbfile(MeSH.Mga.eg.db)
dbschema(MeSH.Mga.eg.db)
dbInfo(MeSH.Mga.eg.db)
species(MeSH.Mga.eg.db)

1

Index

MeSH.Mga.eg.db, 1

2

