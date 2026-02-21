MeSH.Dvi.eg.db

April 16, 2019

MeSH.Dvi.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Dvi.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Dvi.eg.db)
MeSH.Dvi.eg.db

cls <- columns(MeSH.Dvi.eg.db)
cls
kts <- keytypes(MeSH.Dvi.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Dvi.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Dvi.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Dvi.eg.db)
dbfile(MeSH.Dvi.eg.db)
dbschema(MeSH.Dvi.eg.db)
dbInfo(MeSH.Dvi.eg.db)
species(MeSH.Dvi.eg.db)

1

Index

MeSH.Dvi.eg.db, 1

2

