MeSH.Gma.eg.db

April 16, 2019

MeSH.Gma.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Gma.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Gma.eg.db)
MeSH.Gma.eg.db

cls <- columns(MeSH.Gma.eg.db)
cls
kts <- keytypes(MeSH.Gma.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Gma.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Gma.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Gma.eg.db)
dbfile(MeSH.Gma.eg.db)
dbschema(MeSH.Gma.eg.db)
dbInfo(MeSH.Gma.eg.db)
species(MeSH.Gma.eg.db)

1

Index

MeSH.Gma.eg.db, 1

2

