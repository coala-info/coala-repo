MeSH.Nle.eg.db

April 16, 2019

MeSH.Nle.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Nle.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Nle.eg.db)
MeSH.Nle.eg.db

cls <- columns(MeSH.Nle.eg.db)
cls
kts <- keytypes(MeSH.Nle.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Nle.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Nle.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Nle.eg.db)
dbfile(MeSH.Nle.eg.db)
dbschema(MeSH.Nle.eg.db)
dbInfo(MeSH.Nle.eg.db)
species(MeSH.Nle.eg.db)

1

Index

MeSH.Nle.eg.db, 1

2

