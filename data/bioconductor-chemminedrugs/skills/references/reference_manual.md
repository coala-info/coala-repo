ChemmineDrugs

February 11, 2026

ChemmineDrugs

Chemmine Drugs

Description

This package contains a pre-built SQLite database of the DrugBank data set. The DUD database
can also be downloaded using the DUD() function in ChemmineR. It is no longer included in this
package because of it’s large size (1.8GB zipped)

These databases can be used with functions in the ChemmineR package to perform compound
searches and also to retrieve pre-computed features for each compound.

Author(s)

Kevin Horan

See Also

ChemmmineR

Examples

library(ChemmineDrugs)
## list included databases
dir(system.file("extdata",package="ChemmineDrugs"))

## Not run:
library(ChemmineR)
conn = DrugBank()

## End(Not run)

1

Index

ChemmineDrugs, 1
ChemmmineR, 1

2

