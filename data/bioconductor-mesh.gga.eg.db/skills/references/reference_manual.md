MeSH.Gga.eg.db

April 16, 2019

MeSH.Gga.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Gga.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Gga.eg.db)
MeSH.Gga.eg.db

cls <- columns(MeSH.Gga.eg.db)
cls
kts <- keytypes(MeSH.Gga.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Gga.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Gga.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Gga.eg.db)
dbfile(MeSH.Gga.eg.db)
dbschema(MeSH.Gga.eg.db)
dbInfo(MeSH.Gga.eg.db)
species(MeSH.Gga.eg.db)

1

Index

MeSH.Gga.eg.db, 1

2

