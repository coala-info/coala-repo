Mus.musculus
February 11, 2026

Mus.musculus

Annotation package that collates several annotation resources.

Description

This data object was automatically created by Bioconductor Core Team. It represents a collection
of annotation packages that can be used as a single object named Mus.musculus. This object can
be used with the standard four accessor method for all AnnotationDbi objects. Namely: cols,
keytype, keys and select. Users are encouraged to read the vignette from the OrganismDbi
package for more details.

Usage

library(Mus.musculus)

Examples

Mus.musculus
cls <- columns(Mus.musculus)
cls
cls <- cls[c(1,19,45)]
kts <- keytypes(Mus.musculus)
kt <- kts[2]
kts
ks <- head(keys(Mus.musculus, keytype=kts[2]))
ks
res <- select(Mus.musculus, keys=ks, columns=cls, keytype=kt)
head(res)

1

Index

∗ datasets

Mus.musculus, 1

Mus.musculus, 1

2

