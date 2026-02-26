---
name: tetrimmer
description: TETrimmer automates the refinement and curation of transposable element consensus sequences by performing sequence extension, alignment, and classification. Use when user asks to refine de novo TE libraries, define precise transposable element boundaries, or automate manual TE curation workflows.
homepage: https://github.com/qjiangzhao/TETrimmer.git
---


# tetrimmer

## Overview

TETrimmer is a specialized tool designed to replace or assist the labor-intensive process of manual TE curation. While de novo discovery tools identify potential transposable elements, they often produce fragmented or redundant consensus sequences. TETrimmer automates the refinement process by performing BLASTN searches against a reference genome, extracting and extending hits, generating multiple sequence alignments (MSA), and applying clustering and cleaning algorithms to define precise TE boundaries and classifications.

## Core Workflow and CLI Patterns

### Basic Execution
The primary command requires an input TE library (FASTA) and the corresponding genome assembly (FASTA).

```bash
TEtrimmer -i <input_library.fasta> -g <genome_assembly.fasta> -o <output_directory>
```

### Recommended Production Parameters
For comprehensive curation, including protein domain-based classification and multi-threading:

```bash
TEtrimmer -i library.fa -g genome.fa -o output_dir -t 20 --pfam_dir /path/to/pfam_db --classify_all
```

### Key Arguments
- `-i / --input`: Input TE consensus sequences (e.g., from RepeatModeler2 or EDTA).
- `-g / --genome`: The reference genome FASTA file used for sequence extraction and extension.
- `-o / --outdir`: Directory where results, MSAs, and refined consensus files will be stored.
- `-t / --threads`: Number of CPU cores. Curation is computationally expensive; use high thread counts (20-48) for large genomes.
- `--pfam_dir`: Path to the PFAM database directory. Required for automated TE classification.
- `--classify_all`: Forces the tool to attempt classification for all processed elements.

## Best Practices and Expert Tips

### Environment Setup
- **Installation**: Use `mamba` instead of standard `conda` to resolve the complex dependency tree (BLAST, RepeatMasker, MAFFT, etc.) more reliably.
- **Version Control**: If the bioconda version is outdated, activate the environment and run the latest `TEtrimmer.py` directly from the cloned GitHub repository to access recent bug fixes.

### Input Preparation
- **De novo Inputs**: TETrimmer is optimized to handle outputs from EDTA and RepeatModeler2. Ensure headers in the input FASTA do not contain complex special characters that might break downstream MSA tools.
- **Genome Indexing**: While TETrimmer handles many steps, ensuring your genome FASTA is indexed (using `samtools faidx`) can prevent initialization delays.

### Performance Optimization
- **Memory Requirements**: For large, repeat-rich genomes (like barley or maize), ensure the system has at least 128GB+ RAM, as MSA clustering and sequence extension for high-copy elements are memory-intensive.
- **WSL Warning**: Avoid running TETrimmer on Windows Subsystem for Linux (WSL) for large-scale projects, as it exhibits significantly slower performance compared to native Linux environments.

### Troubleshooting
- **Clobber Errors**: During conda installation, "ClobberError" or "ClobberWarning" regarding shared paths (like `bin/blastx`) can usually be ignored; allow the transaction to finish.
- **TE-Aid Errors**: If you encounter "join: command not found" or "rm: cannot remove header" errors during execution, these are typically non-fatal and do not impact the final consensus quality.

## Reference documentation
- [TEtrimmer GitHub Repository](./references/github_com_qjiangzhao_TETrimmer.md)
- [TEtrimmer Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tetrimmer_overview.md)