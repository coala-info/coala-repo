agprobe

February 11, 2026

agprobe

Probe sequence for microarrays of type ag.

Description

This data object was automatically created by the package AnnotationForge version 1.11.21.

Usage

data(agprobe)

Format

A data frame with 131822 rows and 6 columns, as follows.

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

The probe sequence data was obtained from http://www.affymetrix.com. The file name was AG\_probe\_tab.

Examples

agprobe
as.data.frame(agprobe[1:3,])

1

Index

∗ datasets

agprobe, 1

agprobe, 1

2

