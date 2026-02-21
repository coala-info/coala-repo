MeSH.Cpo.eg.db

April 16, 2019

MeSH.Cpo.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Cpo.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Cpo.eg.db)
MeSH.Cpo.eg.db

cls <- columns(MeSH.Cpo.eg.db)
cls
kts <- keytypes(MeSH.Cpo.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Cpo.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Cpo.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Cpo.eg.db)
dbfile(MeSH.Cpo.eg.db)
dbschema(MeSH.Cpo.eg.db)
dbInfo(MeSH.Cpo.eg.db)
species(MeSH.Cpo.eg.db)

1

Index

MeSH.Cpo.eg.db, 1

2

