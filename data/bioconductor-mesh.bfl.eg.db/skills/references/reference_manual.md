MeSH.Bﬂ.eg.db

April 16, 2019

MeSH.Bfl.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Bfl.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Bfl.eg.db)
MeSH.Bfl.eg.db

cls <- columns(MeSH.Bfl.eg.db)
cls
kts <- keytypes(MeSH.Bfl.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Bfl.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Bfl.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Bfl.eg.db)
dbfile(MeSH.Bfl.eg.db)
dbschema(MeSH.Bfl.eg.db)
dbInfo(MeSH.Bfl.eg.db)
species(MeSH.Bfl.eg.db)

1

Index

MeSH.Bfl.eg.db, 1

2

