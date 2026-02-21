MeSH.Ath.eg.db

April 16, 2019

MeSH.Ath.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Ath.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Ath.eg.db)
MeSH.Ath.eg.db

cls <- columns(MeSH.Ath.eg.db)
cls
kts <- keytypes(MeSH.Ath.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Ath.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Ath.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Ath.eg.db)
dbfile(MeSH.Ath.eg.db)
dbschema(MeSH.Ath.eg.db)
dbInfo(MeSH.Ath.eg.db)
species(MeSH.Ath.eg.db)

1

Index

MeSH.Ath.eg.db, 1

2

