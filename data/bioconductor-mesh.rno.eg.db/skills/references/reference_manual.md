MeSH.Rno.eg.db

April 16, 2019

MeSH.Rno.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Rno.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Rno.eg.db)
MeSH.Rno.eg.db

cls <- columns(MeSH.Rno.eg.db)
cls
kts <- keytypes(MeSH.Rno.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Rno.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Rno.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Rno.eg.db)
dbfile(MeSH.Rno.eg.db)
dbschema(MeSH.Rno.eg.db)
dbInfo(MeSH.Rno.eg.db)
species(MeSH.Rno.eg.db)

1

Index

MeSH.Rno.eg.db, 1

2

