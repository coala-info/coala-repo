GenomeInfoDbData
February 11, 2026

GenomeInfoDb-package

Species and taxonomy ID look up tables

Description

This package contains one mapping object:

• specData: A data frame with columns ‘tax_id’, ‘genus’, and ‘species’. Used to retrieve taxon-

omy ID by species and returns list of available species.

Usage

data(specData)

Details

Scripts to generate these files are in GenomeInfoDbData/inst/scripts. All originate from the tax-
dummp download at ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz.

Author(s)

Bioconductor Core Team

Examples

data(specData)
sapply(specData, class)

#

tax_id

genus

species

#

"integer"

"factor" "character"

subset(specData, c(genus=="Homo" &

species=="sapiens"))$tax_id # [1] 9606

1

Index

∗ datasets

GenomeInfoDb-package, 1

GenomeInfoDb-package, 1

specData (GenomeInfoDb-package), 1

2

