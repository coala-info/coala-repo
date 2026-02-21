MeSH.Aml.eg.db

April 16, 2019

MeSH.Aml.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Aml.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Aml.eg.db)
MeSH.Aml.eg.db

cls <- columns(MeSH.Aml.eg.db)
cls
kts <- keytypes(MeSH.Aml.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Aml.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Aml.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Aml.eg.db)
dbfile(MeSH.Aml.eg.db)
dbschema(MeSH.Aml.eg.db)
dbInfo(MeSH.Aml.eg.db)
species(MeSH.Aml.eg.db)

1

Index

MeSH.Aml.eg.db, 1

2

