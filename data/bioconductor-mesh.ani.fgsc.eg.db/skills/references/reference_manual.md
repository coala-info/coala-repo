MeSH.Ani.FGSC.eg.db

April 16, 2019

MeSH.Ani.FGSC.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Ani.FGSC.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Ani.FGSC.eg.db)
MeSH.Ani.FGSC.eg.db

cls <- columns(MeSH.Ani.FGSC.eg.db)
cls
kts <- keytypes(MeSH.Ani.FGSC.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Ani.FGSC.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Ani.FGSC.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Ani.FGSC.eg.db)
dbfile(MeSH.Ani.FGSC.eg.db)
dbschema(MeSH.Ani.FGSC.eg.db)
dbInfo(MeSH.Ani.FGSC.eg.db)
species(MeSH.Ani.FGSC.eg.db)

1

Index

MeSH.Ani.FGSC.eg.db, 1

2

