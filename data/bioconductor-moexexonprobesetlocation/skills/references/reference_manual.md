MoExExonProbesetLocation
February 25, 2026

MoExExonProbesetLocation

Probe sequence for microarrays of type MoEx.

Description

This data object was automatically created by the package AnnotationForge version 1.7.17.

Usage

data(MoExExonProbesetLocation)

Format

A data frame with 1256831 rows and 7 columns, as follows.

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

MoExExonProbesetLocation
as.data.frame(MoExExonProbesetLocation[1:3,])

1

Index

∗ datasets

MoExExonProbesetLocation, 1

MoExExonProbesetLocation, 1

2

