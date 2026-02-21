MeSH.Aca.eg.db

April 16, 2019

MeSH.Aca.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Aca.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Aca.eg.db)
MeSH.Aca.eg.db

cls <- columns(MeSH.Aca.eg.db)
cls
kts <- keytypes(MeSH.Aca.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Aca.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Aca.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Aca.eg.db)
dbfile(MeSH.Aca.eg.db)
dbschema(MeSH.Aca.eg.db)
dbInfo(MeSH.Aca.eg.db)
species(MeSH.Aca.eg.db)

1

Index

MeSH.Aca.eg.db, 1

2

