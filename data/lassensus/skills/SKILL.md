---
name: lassensus
description: Lassensus automates the generation of Lassa virus consensus sequences from long-read sequencing data by identifying the closest reference and performing mapping, consensus calling, and polishing. Use when user asks to generate Lassa virus consensus sequences, identify the best GenBank reference for LASV samples, or process long-read sequencing data for Lassa virus assembly.
homepage: https://github.com/DaanJansen94/lassensus
---


# lassensus

## Overview

Lassensus is a specialized bioinformatics tool designed to automate the workflow for Lassa virus consensus sequence generation, specifically optimized for long-read sequencing data. Because Lassa viruses exhibit extreme sequence divergence, using a single reference for all samples often leads to poor mapping. This skill enables the automated identification of the closest GenBank reference for each sample, followed by a robust pipeline involving mapping (minimap2), consensus calling (ivar), and polishing (medaka).

## Installation and Environment

The tool is available via Bioconda. It is recommended to run it within a dedicated environment to manage its dependencies (minimap2, samtools, ivar, lassaseq, seqtk, and medaka).

```bash
conda create -n lassensus -c bioconda lassensus -y
conda activate lassensus
```

## Command Line Usage

### Basic Execution
The tool requires an input directory containing FASTQ files and an output directory for results.

```bash
lassensus --input_dir /path/to/fastq_input --output_dir /path/to/results
```

### Optimizing Reference Selection
Lassensus identifies the best reference by mapping a subset of reads to all available LASV genomes. You can refine this search using the following parameters:

- **Speed up selection**: Use `--ref_reads` (default 10,000) to limit the number of reads used for the initial reference identification. Increase this value if your sample has very low viral titer.
- **Filter by Host**: Use `--host` to restrict references (1: Human, 2: Rodent, 3: Both).
- **Filter by Completeness**: Use `--genome 1` to only match against complete genomes or `--completeness` to set a specific percentage threshold.
- **Identity Threshold**: Adjust `--min_identity` (default 90.0) to set the minimum percentage identity required for a read to be considered during reference selection.

### Tuning Consensus Quality
The quality of the final polished FASTA depends on the stringency of the consensus calling:

- **High Stringency**: For high-confidence calls, increase `--min_depth` (e.g., 100) and `--min_quality` (e.g., 40), and set `--majority_threshold` to 0.9.
- **Low Coverage Samples**: For samples with lower depth, decrease `--min_depth` (e.g., 20) and `--majority_threshold` (e.g., 0.5) to recover more of the genome, though this may increase the risk of errors.
- **Read Subsampling**: Use `--max_reads` (default 1,000,000) to cap the data used for the final assembly, which prevents excessive computation time on very deep samples.

## Output Structure

For every processed sample, the tool produces:
- `{sample_name}_L_consensus_polished.fasta`: The final polished L segment.
- `{sample_name}_S_consensus_polished.fasta`: The final polished S segment.
- `AllConsensus/`: A directory containing multi-fasta files (`all_L_consensus.fasta` and `all_S_consensus.fasta`) aggregating results from all samples in the batch.

## Expert Tips

- **Reference Selection Failures**: If the tool fails to find a reference, check if your reads are actually Lassa virus or if the `--min_identity` threshold is too high for a highly divergent strain.
- **Segment Gaps**: If one segment (L or S) is missing from the output, it usually indicates that the depth at that segment fell below the `--min_depth` threshold across the entire sequence.
- **Polishing**: The tool uses `medaka` for polishing. Ensure your input data is compatible with the underlying medaka models (typically Oxford Nanopore reads).

## Reference documentation
- [Lassensus GitHub Repository](./references/github_com_DaanJansen94_lassensus.md)
- [Lassensus Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_lassensus_overview.md)