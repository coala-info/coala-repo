MeSH.Cal.SC5314.eg.db

April 16, 2019

MeSH.Cal.SC5314.eg.db Annotation package that provides correspondence between MeSH ID

and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Cal.SC5314.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Cal.SC5314.eg.db)
MeSH.Cal.SC5314.eg.db

cls <- columns(MeSH.Cal.SC5314.eg.db)
cls
kts <- keytypes(MeSH.Cal.SC5314.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Cal.SC5314.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Cal.SC5314.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Cal.SC5314.eg.db)
dbfile(MeSH.Cal.SC5314.eg.db)
dbschema(MeSH.Cal.SC5314.eg.db)
dbInfo(MeSH.Cal.SC5314.eg.db)
species(MeSH.Cal.SC5314.eg.db)

1

Index

MeSH.Cal.SC5314.eg.db, 1

2

