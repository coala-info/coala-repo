HuExExonProbesetLocationHg18

February 11, 2026

HuExExonProbesetLocation

Probe sequence for microarrays of type HuEx.

Description

This data object was automatically created by the package AnnotationDbi version 1.8.1.

Usage

data(HuExExonProbesetLocation)

Format

A data frame with 1425756 rows and 7 columns, as follows.

EPROBESETID
CHR
STRAND
START
END
GPROBESETID Gene-level probeset id
ANNLEVEL

exon-level probeset id
chroosome
chromosome strand
start position of the Probe Selection Region on chromosome
end position of the Probe Selection Region on chromosome

annotation level

Source

The exon-level probeset genome location was retrieved from Netaffx using AffyCompatible.

Examples

library(HuExExonProbesetLocationHg18)
data(HuExExonProbesetLocation)
as.data.frame(HuExExonProbesetLocation[1:3,])

1

Index

∗ datasets

HuExExonProbesetLocation, 1

HuExExonProbesetLocation, 1

2

