MeSH.Cin.eg.db

April 16, 2019

MeSH.Cin.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Cin.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Cin.eg.db)
MeSH.Cin.eg.db

cls <- columns(MeSH.Cin.eg.db)
cls
kts <- keytypes(MeSH.Cin.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Cin.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Cin.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Cin.eg.db)
dbfile(MeSH.Cin.eg.db)
dbschema(MeSH.Cin.eg.db)
dbInfo(MeSH.Cin.eg.db)
species(MeSH.Cin.eg.db)

1

Index

MeSH.Cin.eg.db, 1

2

