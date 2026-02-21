MeSH.Ssc.eg.db

April 16, 2019

MeSH.Ssc.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Ssc.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Ssc.eg.db)
MeSH.Ssc.eg.db

cls <- columns(MeSH.Ssc.eg.db)
cls
kts <- keytypes(MeSH.Ssc.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Ssc.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Ssc.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Ssc.eg.db)
dbfile(MeSH.Ssc.eg.db)
dbschema(MeSH.Ssc.eg.db)
dbInfo(MeSH.Ssc.eg.db)
species(MeSH.Ssc.eg.db)

1

Index

MeSH.Ssc.eg.db, 1

2

