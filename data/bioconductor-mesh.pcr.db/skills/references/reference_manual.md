MeSH.PCR.db
April 16, 2019

MeSH.PCR.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.PCR.db

Author(s)

Itoshi NIKAIDO

Examples

library(MeSH.PCR.db)
MeSH.PCR.db

cls <- columns(MeSH.PCR.db)
cls
kts <- keytypes(MeSH.PCR.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.PCR.db, keytype=kts[2]))
ks
res <- select(MeSH.PCR.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.PCR.db)
dbfile(MeSH.PCR.db)
dbschema(MeSH.PCR.db)
dbInfo(MeSH.PCR.db)

1

Index

MeSH.PCR.db, 1

2

