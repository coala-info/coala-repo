---
name: taxator-tk
description: Taxator-tk is a suite of algorithms that performs taxonomic analysis of genetic sequences using sensitive local alignments and phylogenetic inference. Use when user asks to assign sequences to taxa, perform taxonomic binning of assembled contigs, or generate high-precision consensus assignments for novel sequences.
homepage: https://github.com/fungs/taxator-tk
---


# taxator-tk

## Overview
The taxator toolkit (taxator-tk) is a specialized suite of algorithms designed for the taxonomic analysis of genetic sequences. Unlike rapid k-mer classifiers, taxator-tk utilizes sensitive local alignments and approximate phylogenetic inference to assign sequences to taxa. This makes it the preferred choice when working with novel sequences or complex environments where high-precision, conservative consensus assignments are prioritized over raw speed.

## Installation and Setup
The toolkit is most easily managed via Bioconda.
```bash
conda install -c bioconda taxator-tk
```
To perform assignments, you must download or build a "refpack" (reference package). Pre-packaged refpacks are typically required for the alignment and inference steps.

## Common CLI Patterns and Workflows

### 1. Pre-processing Input Sequences
Taxator-tk requires clean FASTA identifiers. Spaces followed by metadata can cause issues with underlying aligners.
```bash
# Strip extra metadata from FASTA headers
fasta-strip-identifier < input.fasta > clean_input.fasta
```

### 2. The Core Workflow
The general pipeline involves three main stages:
1.  **Alignment**: Aligning query sequences against a reference database (refpack) using a supported aligner (e.g., BLAST, DIAMOND).
2.  **Taxonomic Assignment**: Running the `taxator` program to generate taxonomic mappings.
3.  **Consensus Binning**: Aggregating segment-level assignments into a final consensus for the entire sequence.

### 3. Memory Management for Large Datasets
If running on a machine with limited RAM:
*   **Split Input**: Divide large FASTA files into smaller chunks and run the `taxator` program on each piece.
*   **Concatenate Results**: The resulting GFF3 output files can be safely concatenated before the final consensus binning step.
*   **On-disk Indexing**: Use an on-disk FASTA index for the refpack to reduce the permanent memory footprint.

## Expert Tips and Best Practices
*   **Sequence Length**: This tool is most effective for longer sequences (assembled contigs or long-read technologies like PacBio/Oxford Nanopore). For very short reads, assignments may often stay at higher taxonomic ranks (e.g., Phylum) due to the conservative consensus approach.
*   **Handling Unspecific Taxa**: If the majority of assignments are at the "root" or "kingdom" level, your sequences likely lack close relatives in the refpack. Ensure you are using the most recent and comprehensive refpack available.
*   **Visualizing Results**: The primary output is in GFF3 format. This can be loaded directly into sequence viewers like IGV (Integrative Genomics Viewer) to see exactly which segments of a contig contributed to a specific taxonomic assignment.
*   **Parallelization**: The core algorithm is "embarrassingly parallel." You can manually distribute chunks of the alignment or the `taxator` execution across multiple CPU cores or cluster nodes to decrease runtime.
*   **Avoid Redundancy**: Do not run taxator-tk on unassembled, overlapping short reads. The redundant calculations for overlapping regions will lead to prohibitive runtimes without improving accuracy.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_fungs_taxator-tk.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_taxator-tk_overview.md)