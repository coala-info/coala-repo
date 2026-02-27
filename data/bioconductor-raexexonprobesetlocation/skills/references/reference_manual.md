RaExExonProbesetLocation
February 25, 2026

RaExExonProbesetLocation

Probe sequence for microarrays of type RaEx.

Description

This data object was automatically created by the package AnnotationForge version 1.7.17.

Usage

data(RaExExonProbesetLocation)

Format

A data frame with 1064709 rows and 7 columns, as follows.

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

RaExExonProbesetLocation
as.data.frame(RaExExonProbesetLocation[1:3,])

1

Index

∗ datasets

RaExExonProbesetLocation, 1

RaExExonProbesetLocation, 1

2

