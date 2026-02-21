yeast2probe

February 18, 2026

yeast2probe

Probe sequence for microarrays of type yeast2.

Description

This data object was automatically created by the package AnnotationForge version 1.11.21.

Usage

data(yeast2probe)

Format

A data frame with 120855 rows and 6 columns, as follows.

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

The probe sequence data was obtained from http://www.affymetrix.com. The file name was Yeast\_2\_probe\_tab.

Examples

yeast2probe
as.data.frame(yeast2probe[1:3,])

1

Index

∗ datasets

yeast2probe, 1

yeast2probe, 1

2

