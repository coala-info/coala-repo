MeSH.Dsi.eg.db

April 16, 2019

MeSH.Dsi.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Dsi.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Dsi.eg.db)
MeSH.Dsi.eg.db

cls <- columns(MeSH.Dsi.eg.db)
cls
kts <- keytypes(MeSH.Dsi.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Dsi.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Dsi.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Dsi.eg.db)
dbfile(MeSH.Dsi.eg.db)
dbschema(MeSH.Dsi.eg.db)
dbInfo(MeSH.Dsi.eg.db)
species(MeSH.Dsi.eg.db)

1

Index

MeSH.Dsi.eg.db, 1

2

