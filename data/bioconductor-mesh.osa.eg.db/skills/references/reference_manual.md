MeSH.Osa.eg.db

April 16, 2019

MeSH.Osa.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Osa.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Osa.eg.db)
MeSH.Osa.eg.db

cls <- columns(MeSH.Osa.eg.db)
cls
kts <- keytypes(MeSH.Osa.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Osa.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Osa.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Osa.eg.db)
dbfile(MeSH.Osa.eg.db)
dbschema(MeSH.Osa.eg.db)
dbInfo(MeSH.Osa.eg.db)
species(MeSH.Osa.eg.db)

1

Index

MeSH.Osa.eg.db, 1

2

