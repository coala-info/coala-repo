Homo.sapiens

February 11, 2026

Homo.sapiens

Annotation package that collates several annotation resources.

Description

This data object was automatically created by Bioconductor Core Team. It represents a collection
of annotation packages that can be used as a single object named Homo.sapiens. This object can
be used with the standard four accessor method for all AnnotationDbi objects. Namely: cols,
keytype, keys and select. Users are encouraged to read the vignette from the OrganismDbi
package for more details.

Usage

library(Homo.sapiens)

Examples

Homo.sapiens
cls <- columns(Homo.sapiens)
cls
cls <- cls[c(1,19,45)]
kts <- keytypes(Homo.sapiens)
kt <- kts[2]
kts
ks <- head(keys(Homo.sapiens, keytype=kts[2]))
ks
res <- select(Homo.sapiens, keys=ks, columns=cls, keytype=kt)
head(res)

1

Index

∗ datasets

Homo.sapiens, 1

Homo.sapiens, 1

2

