MeSH.Mdo.eg.db

April 16, 2019

MeSH.Mdo.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Mdo.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Mdo.eg.db)
MeSH.Mdo.eg.db

cls <- columns(MeSH.Mdo.eg.db)
cls
kts <- keytypes(MeSH.Mdo.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Mdo.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Mdo.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Mdo.eg.db)
dbfile(MeSH.Mdo.eg.db)
dbschema(MeSH.Mdo.eg.db)
dbInfo(MeSH.Mdo.eg.db)
species(MeSH.Mdo.eg.db)

1

Index

MeSH.Mdo.eg.db, 1

2

