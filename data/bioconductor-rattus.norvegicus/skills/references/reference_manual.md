Rattus.norvegicus

February 25, 2026

Rattus.norvegicus

Annotation package that collates several annotation resources.

Description

This data object was automatically created by Bioconductor Core Team. It represents a collection
of annotation packages that can be used as a single object named Rattus.norvegicus. This object
can be used with the standard four accessor method for all AnnotationDbi objects. Namely: cols,
keytype, keys and select. Users are encouraged to read the vignette from the OrganismDbi
package for more details.

Usage

library(Rattus.norvegicus)

Examples

Rattus.norvegicus
cls <- columns(Rattus.norvegicus)
cls
cls <- cls[c(1,19,45)]
kts <- keytypes(Rattus.norvegicus)
kt <- kts[2]
kts
ks <- head(keys(Rattus.norvegicus, keytype=kts[2]))
ks
res <- select(Rattus.norvegicus, keys=ks, columns=cls, keytype=kt)
head(res)

1

Index

∗ datasets

Rattus.norvegicus, 1

Rattus.norvegicus, 1

2

