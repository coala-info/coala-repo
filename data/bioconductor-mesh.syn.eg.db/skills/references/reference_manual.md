MeSH.Syn.eg.db

April 16, 2019

MeSH.Syn.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Syn.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Syn.eg.db)
MeSH.Syn.eg.db

cls <- columns(MeSH.Syn.eg.db)
cls
kts <- keytypes(MeSH.Syn.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Syn.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Syn.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Syn.eg.db)
dbfile(MeSH.Syn.eg.db)
dbschema(MeSH.Syn.eg.db)
dbInfo(MeSH.Syn.eg.db)
species(MeSH.Syn.eg.db)

1

Index

MeSH.Syn.eg.db, 1

2

