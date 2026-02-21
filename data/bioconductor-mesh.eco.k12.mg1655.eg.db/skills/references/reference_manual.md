MeSH.Eco.K12.MG1655.eg.db
April 16, 2019

MeSH.Eco.K12.MG1655.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Eco.K12.MG1655.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Eco.K12.MG1655.eg.db)
MeSH.Eco.K12.MG1655.eg.db

cls <- columns(MeSH.Eco.K12.MG1655.eg.db)
cls
kts <- keytypes(MeSH.Eco.K12.MG1655.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Eco.K12.MG1655.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Eco.K12.MG1655.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Eco.K12.MG1655.eg.db)
dbfile(MeSH.Eco.K12.MG1655.eg.db)
dbschema(MeSH.Eco.K12.MG1655.eg.db)
dbInfo(MeSH.Eco.K12.MG1655.eg.db)
species(MeSH.Eco.K12.MG1655.eg.db)

1

Index

MeSH.Eco.K12.MG1655.eg.db, 1

2

