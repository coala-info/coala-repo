---
name: mitos
description: MITOS is a specialized bioinformatics pipeline designed specifically for the unique challenges of metazoan mitochondrial genome annotation.
homepage: http://mitos.bioinf.uni-leipzig.de
---

# mitos

## Overview
MITOS is a specialized bioinformatics pipeline designed specifically for the unique challenges of metazoan mitochondrial genome annotation. Unlike general-purpose annotators, it accounts for mitochondrial-specific genetic codes, compact gene structures, and overlapping features. It is the standard tool for processing mitochondrial assemblies to produce publication-ready annotations.

## Installation and Setup
The recommended way to install MITOS is via Bioconda to ensure all dependencies (like BLAST, tRNAscan-SE, and various covariance models) are correctly linked.

```bash
conda install -c bioconda mitos
```

## Common CLI Patterns

### Basic Annotation
To run a standard annotation on a mitochondrial FASTA file:
```bash
runmitos.py -i input.fasta -o output_dir -code 5 -ref refseq63m
```
*   `-i`: Input FASTA file containing the mitochondrial sequence.
*   `-o`: Output directory for results.
*   `-code`: The genetic code (e.g., `5` for Invertebrate Mitochondrial, `2` for Vertebrate).
*   `-ref`: The reference dataset to use (e.g., `refseq63m` or `refseq63f`).

### Advanced Options
*   **Sensitivity**: Use `-e` to set the e-value threshold for BLAST searches.
*   **Feature Types**: Use `--prot`, `--trna`, or `--rrna` to toggle specific feature detection if only a subset of the genome needs re-annotation.
*   **Linear vs Circular**: If the input sequence is not circularized, ensure the tool is aware of the topology to avoid missing features at the sequence ends.

## Expert Tips
*   **Genetic Code Selection**: Always verify the specific mitochondrial genetic code for your taxon. Using the wrong code (e.g., using Code 1 instead of Code 5) will result in incorrect protein-coding gene boundaries and premature stop codons.
*   **Reference Data**: Ensure you have downloaded the necessary MITOS reference data (RefSeq) before running the CLI, as the tool requires these databases to perform homology searches.
*   **Output Interpretation**: MITOS generates a `result.gff` file. This is the primary file for downstream analysis or submission to databases like NCBI/ENA.
*   **Galaxy Alternative**: For users uncomfortable with the CLI, MITOS is actively maintained on the European Galaxy server (usegalaxy.eu), which provides a graphical interface for the same underlying logic.

## Reference documentation
- [MITOS Homepage and Documentation](./references/mitos_bioinf_uni-leipzig_de_index.md)
- [Bioconda MITOS Package Overview](./references/anaconda_org_channels_bioconda_packages_mitos_overview.md)