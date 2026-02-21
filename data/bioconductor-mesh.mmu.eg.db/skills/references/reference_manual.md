MeSH.Mmu.eg.db

April 16, 2019

MeSH.Mmu.eg.db

Annotation package that provides correspondence between MeSH ID
and Entrez Gene ID

Description

This data represents a collection of annotation packages that can be used as a single object named
as package name. This object can be used with the standard four accessor method for all Annota-
tionDbi objects. Namely: columns, keytypes, keys and select. Users are encouraged to read the
vignette from the MeSHDbi package for more details.

Usage

MeSH.Mmu.eg.db

Author(s)

Koki Tsuyuzaki

Examples

library(MeSH.Mmu.eg.db)
MeSH.Mmu.eg.db

cls <- columns(MeSH.Mmu.eg.db)
cls
kts <- keytypes(MeSH.Mmu.eg.db)
kt <- kts[2]
kts
ks <- head(keys(MeSH.Mmu.eg.db, keytype=kts[2]))
ks
res <- select(MeSH.Mmu.eg.db, keys=ks, columns=cls, keytype=kt)
head(res)

dbconn(MeSH.Mmu.eg.db)
dbfile(MeSH.Mmu.eg.db)
dbschema(MeSH.Mmu.eg.db)
dbInfo(MeSH.Mmu.eg.db)
species(MeSH.Mmu.eg.db)

1

Index

MeSH.Mmu.eg.db, 1

2

