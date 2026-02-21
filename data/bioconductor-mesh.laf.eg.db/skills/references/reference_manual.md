MeSH.Laf.eg.db

April 16, 2019

MeSH.Laf.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Laf.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Laf.eg.db)
MeSH.Laf.eg.db

cls <- columns(MeSH.Laf.eg.db)
cls
kts <- keytypes(MeSH.Laf.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Laf.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Laf.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Laf.eg.db)
dbfile(MeSH.Laf.eg.db)
dbschema(MeSH.Laf.eg.db)
dbInfo(MeSH.Laf.eg.db)
species(MeSH.Laf.eg.db)

1

Index

MeSH.Laf.eg.db, 1

2

