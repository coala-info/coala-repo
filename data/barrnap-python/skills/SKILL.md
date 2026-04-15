---
name: barrnap-python
description: barrnap-python predicts the location of ribosomal RNA genes in DNA sequences using hidden Markov models. Use when user asks to identify rRNA signatures, annotate ribosomal subunits in a genome, or generate GFF3 files for bacterial, archaeal, eukaryotic, or mitochondrial sequences.
homepage: https://github.com/nickp60/barrnap-python
metadata:
  docker_image: "quay.io/biocontainers/barrnap-python:0.0.5--py36_1"
---

# barrnap-python

## Overview
barrnap-python is a distribution of the Basic Rapid Ribosomal RNA Predictor (barrnap), originally developed by Torsten Seemann. It leverages NHMMER (from the HMMER3 package) to rapidly scan DNA sequences for rRNA signatures. The tool is designed to be fast and lightweight, making it a standard choice for initial genome characterization and GFF3-compliant annotation of ribosomal subunits.

## Usage Patterns and Best Practices

### Basic Command Structure
The primary command is `barrnap`. By default, it outputs results in GFF3 format to `stdout`.

```bash
barrnap input.fasta > output.gff
```

### Kingdom Selection
The most critical parameter is `--kingdom`. The tool uses different Hidden Markov Models (HMMs) based on the target organism type.
- **bac** (Bacteria): Default. Detects 5S, 16S, 23S.
- **arc** (Archaea): Detects 5S, 16S, 23S.
- **euk** (Eukaryota): Detects 5.8S, 18S, 28S.
- **mito** (Metazoan Mitochondria): Detects 12S, 16S.

```bash
barrnap --kingdom euk input.fasta > eukaryotic_rrna.gff
```

### Performance Optimization
For large metagenomic files or multiple assemblies, use the `--threads` flag to enable parallel processing via NHMMER.

```bash
barrnap --threads 8 input.fasta > output.gff
```

### Adjusting Sensitivity and Length
- **E-value Threshold**: Use `--evalue` to adjust the stringency of the search. The default is 1e-06. Lower values (e.g., 1e-09) increase confidence but may miss divergent rRNAs.
- **Length Cutoff**: Use `--lencutoff` to ignore partial rRNA hits. The default is 0.8 (80% of the expected HMM length). Set to a lower value if you expect fragmented assemblies.

```bash
# Increase stringency and allow shorter fragments
barrnap --evalue 1e-10 --lencutoff 0.5 input.fasta > output.gff
```

### Expert Tips
- **Input Format**: Ensure the input FASTA file does not have extremely long headers, as some versions of the underlying HMMER tools may truncate them.
- **GFF3 Compatibility**: The output is strictly GFF3. If you need to visualize these in a genome browser (like IGV or JBrowse), ensure your reference FASTA sequence IDs match the IDs in the first column of the barrnap output.
- **Rejecting Pseudogenes**: If barrnap identifies multiple overlapping hits, it typically reports the one with the best E-value. However, in poor quality assemblies, check for "partial" flags in the GFF attributes column.

## Reference documentation
- [Anaconda Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_barrnap-python_overview.md)