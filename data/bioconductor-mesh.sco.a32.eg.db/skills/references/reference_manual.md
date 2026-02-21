MeSH.Sco.A32.eg.db

April 16, 2019

MeSH.Sco.A32.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Sco.A32.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Sco.A32.eg.db)
MeSH.Sco.A32.eg.db

cls <- columns(MeSH.Sco.A32.eg.db)
cls
kts <- keytypes(MeSH.Sco.A32.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Sco.A32.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Sco.A32.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Sco.A32.eg.db)
dbfile(MeSH.Sco.A32.eg.db)
dbschema(MeSH.Sco.A32.eg.db)
dbInfo(MeSH.Sco.A32.eg.db)
species(MeSH.Sco.A32.eg.db)

1

Index

MeSH.Sco.A32.eg.db, 1

2

