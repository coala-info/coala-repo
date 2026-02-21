HuExExonProbesetLocation
February 11, 2026

HuExExonProbesetLocation

Probe sequence for microarrays of type HuEx.

Description

This data object was automatically created by the package AnnotationForge version 1.7.17.

Usage

data(HuExExonProbesetLocation)

Format

A data frame with 1432143 rows and 7 columns, as follows.

sequence
x
y
Probe.Set.Name
Probe.Interrogation.Position
Target.Strandedness

probe sequence
x-coordinate on the array
y-coordinate on the array

character
integer
integer
character Affymetrix Probe Set Name
Probe Interrogation Position
integer
Target Strandedness
factor

Source

The exon-level probeset genome location was retrieved from Netaffx using AffyCompatible.

Examples

HuExExonProbesetLocation
as.data.frame(HuExExonProbesetLocation[1:3,])

1

Index

∗ datasets

HuExExonProbesetLocation, 1

HuExExonProbesetLocation, 1

2

