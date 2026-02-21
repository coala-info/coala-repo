MeSH.Oni.eg.db

April 16, 2019

MeSH.Oni.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Oni.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Oni.eg.db)
MeSH.Oni.eg.db

cls <- columns(MeSH.Oni.eg.db)
cls
kts <- keytypes(MeSH.Oni.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Oni.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Oni.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Oni.eg.db)
dbfile(MeSH.Oni.eg.db)
dbschema(MeSH.Oni.eg.db)
dbInfo(MeSH.Oni.eg.db)
species(MeSH.Oni.eg.db)

1

Index

MeSH.Oni.eg.db, 1

2

