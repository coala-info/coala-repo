MeSH.Ame.eg.db

April 16, 2019

MeSH.Ame.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Ame.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Ame.eg.db)
MeSH.Ame.eg.db

cls <- columns(MeSH.Ame.eg.db)
cls
kts <- keytypes(MeSH.Ame.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Ame.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Ame.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Ame.eg.db)
dbfile(MeSH.Ame.eg.db)
dbschema(MeSH.Ame.eg.db)
dbInfo(MeSH.Ame.eg.db)
species(MeSH.Ame.eg.db)

1

Index

MeSH.Ame.eg.db, 1

2

