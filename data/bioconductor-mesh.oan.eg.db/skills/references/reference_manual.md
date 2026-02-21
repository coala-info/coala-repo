MeSH.Oan.eg.db

April 16, 2019

MeSH.Oan.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Oan.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Oan.eg.db)
MeSH.Oan.eg.db

cls <- columns(MeSH.Oan.eg.db)
cls
kts <- keytypes(MeSH.Oan.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Oan.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Oan.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Oan.eg.db)
dbfile(MeSH.Oan.eg.db)
dbschema(MeSH.Oan.eg.db)
dbInfo(MeSH.Oan.eg.db)
species(MeSH.Oan.eg.db)

1

Index

MeSH.Oan.eg.db, 1

2

