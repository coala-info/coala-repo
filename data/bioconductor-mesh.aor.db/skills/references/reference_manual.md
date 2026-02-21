MeSH.AOR.db
April 16, 2019

MeSH.AOR.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.AOR.db

Author(s)

Itoshi NIKAIDO

Examples

library(MeSH.AOR.db)
MeSH.AOR.db

cls <- columns(MeSH.AOR.db)
cls
kts <- keytypes(MeSH.AOR.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.AOR.db, keytype=kts[2]))
ks
res <- select(MeSH.AOR.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.AOR.db)
dbfile(MeSH.AOR.db)
dbschema(MeSH.AOR.db)
dbInfo(MeSH.AOR.db)

1

Index

MeSH.AOR.db, 1

2

