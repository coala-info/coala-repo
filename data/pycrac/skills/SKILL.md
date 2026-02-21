---
name: pycrac
description: The pycrac skill provides procedural knowledge for handling the pyCRAC software suite.
homepage: http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html
---

# pycrac

## Overview

The pycrac skill provides procedural knowledge for handling the pyCRAC software suite. This toolkit is essential for researchers working with RNA-protein interaction data. It excels at processing raw sequencing reads, filtering for specific experimental barcodes, mapping reads to reference genomes, and identifying protein binding sites through mutation and distribution analysis.

## Core Workflows and CLI Patterns

### 1. Pre-processing and Demultiplexing
Use `pyBarcodeFilter.py` to sort raw FastQ files based on experimental barcodes.
- **Standard Pattern**: `pyBarcodeFilter.py -f input.fastq -b barcodes.txt`
- **Tip**: Ensure the barcode file is tab-delimited with the barcode sequence in the first column and the sample name in the second.

### 2. Read Trimming and Quality Control
Before mapping, use `pyAdapterTrimmer.py` to remove sequencing adapters.
- **Standard Pattern**: `pyAdapterTrimmer.py -f input.fastq -a ADAPTER_SEQUENCE`
- **Expert Tip**: Use the `-m` flag to set a minimum read length (e.g., `-m 15`) to discard short, uninformative reads that increase mapping noise.

### 3. Genomic Mapping and Alignment
While pyCRAC can interface with various aligners, `pyReadAligner.py` is the primary wrapper for mapping reads to a reference genome.
- **Standard Pattern**: `pyReadAligner.py -f processed.fastq -r reference.fasta`
- **Key Parameter**: Use `--out-format` to specify SAM or BAM output for downstream compatibility with tools like IGV or Samtools.

### 4. Analysis of Protein-RNA Interactions
The power of pyCRAC lies in its ability to analyze cross-linking sites, often identified by specific mutations (e.g., T-to-C transitions).
- **pyReadCounters.py**: Use this to count reads mapping to specific genomic features (GTF/GFF).
  - `pyReadCounters.py -f mapped.bam -gtf annotations.gtf`
- **pyHill.py**: Use this for peak calling and identifying significantly enriched binding regions.
- **pyMotif.py**: Use this to discover enriched sequence motifs within the identified binding sites.

## Best Practices
- **Memory Management**: When processing large BAM files, utilize the `--chunk-size` option where available to prevent memory overflows.
- **Mutation Tracking**: Always enable mutation tracking in `pyReadAligner.py` if the experimental protocol (like CRAC) relies on cross-linking induced mutations to pinpoint binding sites.
- **File Naming**: Maintain a consistent naming convention (e.g., `sample_trimmed_mapped.bam`) as pyCRAC tools often generate multiple intermediate files.

## Reference documentation
- [pycrac Overview](./references/anaconda_org_channels_bioconda_packages_pycrac_overview.md)