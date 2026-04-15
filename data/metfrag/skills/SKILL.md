---
name: metfrag
description: MetFrag identifies metabolites by matching experimental mass spectrometry fragmentation patterns against candidate molecular structures from databases. Use when user asks to identify metabolites, simulate molecular fragmentation, or score candidate structures against MS/MS spectra.
homepage: http://c-ruttkies.github.io/MetFrag/
metadata:
  docker_image: "quay.io/biocontainers/metfrag:2.4.5--3"
---

# metfrag

## Overview
MetFrag is a computational tool designed to bridge the gap between experimental mass spectrometry data and molecular structures. It automates the process of metabolite identification by retrieving candidate structures from databases, performing bond dissociation to simulate fragmentation, and scoring how well those theoretical fragments align with observed peaks in a spectrum. This skill provides the necessary guidance to configure and execute MetFrag for high-throughput metabolite annotation.

## Command Line Usage
MetFrag is typically executed as a Java-based command-line tool. The primary method of interaction involves passing a parameters file that defines the search space and fragmentation settings.

### Basic Execution
To run a MetFrag analysis, use the following command structure:
```bash
metfrag <parameters_file.txt>
```
*Note: Depending on the installation method (e.g., Bioconda), the command may be `MetFrag` or require calling the JAR directly via `java -jar MetFrag.jar`.*

### Core Parameters
A standard parameters file should include the following key-value pairs:
- **IonizedPrecursorMass**: The m/z value of the precursor ion.
- **DatabaseSearchRelativeMassDeviation**: The mass tolerance (in ppm) for candidate retrieval.
- **FragmentPeakMatchAbsoluteMassDeviation**: The absolute error allowed for fragment matching (e.g., 0.001).
- **FragmentPeakMatchRelativeMassDeviation**: The relative error allowed for fragment matching (e.g., 5.0).
- **MetFragDatabaseType**: The source of candidates (e.g., `PubChem`, `ChemSpider`, or `LocalCSV`).
- **PeakList**: The list of m/z and intensity pairs from the MS/MS spectrum.

## Best Practices
- **Mass Accuracy**: Always match the `DatabaseSearchRelativeMassDeviation` to the resolution of the instrument used (e.g., 5 ppm for Q-Exactive, 20 ppm for TOF).
- **Candidate Filtering**: Use specific database IDs or molecular formulas when available to narrow the search space and reduce computation time.
- **Scoring Interpretation**: Higher MetFrag scores indicate better alignment between theoretical and experimental fragments. Use these scores as a ranking mechanism rather than an absolute identification.
- **Local Databases**: For proprietary or niche compounds, use the `LocalCSV` database type to provide a custom list of structures in SMILES or InChI format.

## Reference documentation
- [MetFrag Overview](./references/anaconda_org_channels_bioconda_packages_metfrag_overview.md)