MeSH.Dre.eg.db

April 16, 2019

MeSH.Dre.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Dre.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Dre.eg.db)
MeSH.Dre.eg.db

cls <- columns(MeSH.Dre.eg.db)
cls
kts <- keytypes(MeSH.Dre.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Dre.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Dre.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Dre.eg.db)
dbfile(MeSH.Dre.eg.db)
dbschema(MeSH.Dre.eg.db)
dbInfo(MeSH.Dre.eg.db)
species(MeSH.Dre.eg.db)

1

Index

MeSH.Dre.eg.db, 1

2

