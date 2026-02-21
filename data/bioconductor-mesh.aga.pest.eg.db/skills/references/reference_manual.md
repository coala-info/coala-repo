MeSH.Aga.PEST.eg.db

April 16, 2019

MeSH.Aga.PEST.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Aga.PEST.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Aga.PEST.eg.db)
MeSH.Aga.PEST.eg.db

cls <- columns(MeSH.Aga.PEST.eg.db)
cls
kts <- keytypes(MeSH.Aga.PEST.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Aga.PEST.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Aga.PEST.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Aga.PEST.eg.db)
dbfile(MeSH.Aga.PEST.eg.db)
dbschema(MeSH.Aga.PEST.eg.db)
dbInfo(MeSH.Aga.PEST.eg.db)
species(MeSH.Aga.PEST.eg.db)

1

Index

MeSH.Aga.PEST.eg.db, 1

2

