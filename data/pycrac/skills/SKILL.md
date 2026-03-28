---
name: pycrac
description: The pycrac package provides a suite of tools for analyzing UV cross-linking and analysis of cDNA data to map RNA-protein interaction sites. Use when user asks to demultiplex sequencing reads, trim adapters, count genomic feature overlaps, or identify significant binding sites through mutation analysis.
homepage: http://sandergranneman.bio.ed.ac.uk/Granneman_Lab/pyCRAC_software.html
---


# pycrac

## Overview
The `pycrac` package is a comprehensive Python-based suite designed for the analysis of UV cross-linking and analysis of cDNA (CRAC) data. It provides specialized tools to handle the unique challenges of CRAC datasets, such as identifying deletions and substitutions that indicate cross-linking sites. It streamlines the workflow from raw FASTQ files to genomic hit maps and peak calling, allowing for precise mapping of RNA-protein interaction sites.

## Core CLI Patterns and Best Practices

### Sequence Preprocessing
Before mapping, use `pycrac` utilities to handle barcodes and adapters.
- **pyBarcodeFilter.py**: Use this to demultiplex raw sequencing reads based on experimental barcodes.
- **pyAdapterTrimmer.py**: Essential for removing 3' adapter sequences which can interfere with alignment.

### Read Mapping and Processing
CRAC data often contains "mutational signatures" (deletions or substitutions) at the site of cross-linking.
- **pyReadCounters.py**: Use this to count the number of reads overlapping with genomic features. It is highly effective for generating distribution plots across genes or transcripts.
- **pyCalculateFDRs.py**: Use this to identify statistically significant binding sites by calculating False Discovery Rates for clusters of mutations.

### Genomic Analysis
- **pyGTF2snoRNA.py / pyGTF2genelist.py**: Use these utilities to convert GTF annotation files into formats compatible with the pycrac analysis pipeline.
- **pyBinCollector.py**: Useful for calculating the distribution of hits across specific genomic regions or around specific landmarks (e.g., start codons, introns).

### Expert Tips
- **Mutation Tracking**: Always ensure your alignment settings (e.g., in Bowtie or BWA) allow for the specific mutations (usually deletions) generated during the CRAC protocol, as these are the primary indicators of the exact cross-linking nucleotide.
- **Memory Management**: When processing large BAM/SAM files with `pyReadCounters.py`, ensure you have sufficient RAM or use the chromosome-by-chromosome processing options if available to prevent memory overflows.
- **Normalization**: When comparing different libraries, use the total number of mapped reads or specific internal controls to normalize your hit counts.



## Subcommands

| Command | Description |
|---------|-------------|
| pyBarcodeFilter.py | Filters FASTQ/FASTA files based on barcodes. |
| pyMotif.py | pyMotif.py |
| pyReadAligner.py | Aligns reads to genomic or coding sequences, with options for various input file types and analysis parameters. |
| pyReadCounters.py | Analyze novo, SAM/BAM or gtf data |

## Reference documentation
- [pycrac Overview](./references/anaconda_org_channels_bioconda_packages_pycrac_overview.md)