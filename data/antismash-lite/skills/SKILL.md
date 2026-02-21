---
name: antismash-lite
description: The `antismash-lite` skill enables the automated discovery and characterization of secondary metabolite biosynthesis gene clusters.
homepage: https://docs.antismash.secondarymetabolites.org/intro/
---

# antismash-lite

## Overview
The `antismash-lite` skill enables the automated discovery and characterization of secondary metabolite biosynthesis gene clusters. It transforms raw genomic sequences into annotated maps of specialized metabolism, identifying the genetic architecture behind bioactive compounds. This skill provides procedural knowledge for running the "antibiotics and Secondary Metabolite Analysis SHell" (antiSMASH) via the command line, focusing on efficient resource usage and comprehensive metabolic profiling.

## Installation and Setup
Install the lightweight version of antiSMASH via Bioconda:
```bash
conda install bioconda::antismash-lite
```
Note: The `lite` version may require separate downloads of essential databases (e.g., Pfam, ClusterBlast, MIBiG) using the `download-antismash-databases` script before the first run.

## Common CLI Patterns

### Basic Genome Scan
To run a standard analysis on a GenBank file with default settings:
```bash
antismash input_genome.gbk
```

### High-Sensitivity Discovery
For a thorough search including comparative genomics and specialized domain analysis:
```bash
antismash --cb-general --cb-knownclusters --cb-subclusters --asf --pfam2go --genefinding-tool prodigal input.fasta
```

### Targeted Analysis for Specific Taxa
Optimize gene finding by specifying the taxonomic origin:
```bash
antismash --taxon bacteria --genefinding-tool prodigal input.gbk
# Use 'fungi' for fungal genomes to trigger appropriate HMMs
antismash --taxon fungi input.fasta
```

## Expert Tips and Best Practices

### Input Requirements
- **Preferred Format**: Use GenBank (.gbk) files that already contain gene annotations for the most accurate results.
- **FASTA Inputs**: If providing FASTA, antiSMASH will run `prodigal` (bacteria) or `glimmerhmm` (fungi) to predict genes. Ensure the `--genefinding-tool` flag matches your organism type.

### Managing Output
- **Output Directory**: Use `--output-dir <directory>` to keep results organized, especially when running batch jobs.
- **HTML Results**: The primary output is `index.html`. View this in a browser to navigate the "Region" concept, which groups related protoclusters into functional units.

### Performance Optimization
- **CPU Allocation**: Use `-c <threads>` to speed up HMM searches and ClusterBlast.
- **Minimal Run**: If only basic detection is needed without comparative analysis, omit the `--cb-*` flags to significantly reduce runtime and memory usage.

### Interpreting Results
- **Protoclusters**: These are the basic units of detection based on core biosynthetic enzymes.
- **Regions**: These represent the full genomic context. One region may contain multiple overlapping or adjacent protoclusters.
- **NRPS/PKS Analysis**: Pay close attention to the "Monomer prediction" in the results for Non-Ribosomal Peptide Synthetases and Polyketide Synthases to predict the chemical structure of the metabolite.

## Reference documentation
- [antiSMASH - the antibiotics and Secondary Metabolite Analysis SHell](./references/anaconda_org_channels_bioconda_packages_antismash-lite_overview.md)
- [Introduction - antiSMASH Documentation](./references/docs_antismash_secondarymetabolites_org_intro.md)