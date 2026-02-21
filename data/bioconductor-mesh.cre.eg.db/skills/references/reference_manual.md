MeSH.Cre.eg.db

April 16, 2019

MeSH.Cre.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Cre.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Cre.eg.db)
MeSH.Cre.eg.db

cls <- columns(MeSH.Cre.eg.db)
cls
kts <- keytypes(MeSH.Cre.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Cre.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Cre.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Cre.eg.db)
dbfile(MeSH.Cre.eg.db)
dbschema(MeSH.Cre.eg.db)
dbInfo(MeSH.Cre.eg.db)
species(MeSH.Cre.eg.db)

1

Index

MeSH.Cre.eg.db, 1

2

