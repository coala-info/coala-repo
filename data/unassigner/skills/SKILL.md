---
name: unassigner
description: Unassigner identifies bacterial species by determining which designations are statistically inconsistent with 16S rRNA sequences. Use when user asks to perform species inconsistency analysis, rule out bacterial species designations, or trim 16S rRNA sequences.
homepage: https://github.com/PennChopMicrobiomeProgram/unassigner
---


# unassigner

## Overview

The `unassigner` tool provides a specialized approach to bacterial identification using 16S rRNA marker gene sequences. While standard taxonomic classifiers attempt to find the "best" match, `unassigner` is designed to rule out species designations that are statistically inconsistent with a partial 16S sequence. It calculates the probability of inconsistency with nearby bacterial species, providing a more conservative and rigorous species-level assessment for microbiome research.

## Core Workflows

### Species Inconsistency Analysis
The primary command `unassign` processes a FASTA file of 16S sequences. On its first run, it automatically downloads necessary bacterial species data and formats reference files.

```bash
# Basic usage
unassign my_sequences.fasta
```

**Key Behaviors:**
- **Output Directory**: Creates a folder named `[input_filename]_unassigned` in the same directory as the input file.
- **Results**: Generates a results table (`unassigner_output.tsv`) containing probabilities of inconsistency.
- **Dependencies**: Requires `vsearch` to be available in the system path.

### Sequence Trimming and Region Extraction
The `trimragged` utility is used to extract specific regions from full-length 16S genes or to handle sequences where primers are only partially present due to sequencing limitations.

```bash
# Trim sequences based on a specific primer
trimragged AGAGTTTGATCCTGGCTCAG --input_file my_sequences.fasta
```

**Best Practices for `trimragged`:**
- **Dual Runs**: The tool accepts only one primer at a time. For paired-end data or full region extraction, run the command twice (once for the forward primer and once for the reverse).
- **Partial Matches**: Use the `--min_partial` argument to control the sensitivity of matching for low-quality sequence ends.
- **Algorithm**: It uses a three-step process: full primer matching, partial matching, and alignment-based estimation for remaining reads.

## Expert Tips and Best Practices

- **Species Ruling vs. Assignment**: Use this tool specifically when you need to know which species a sequence *cannot* be, rather than just accepting the top hit from a standard classifier.
- **Database Management**: If you need to specify a custom location for the reference data (LTP data), check the `--help` output for path configuration options to avoid repeated downloads in containerized or HPC environments.
- **Vsearch Integration**: Ensure `vsearch` is installed and accessible. If using the `pip` installation method, `vsearch` must be managed manually; using the `bioconda` or `Docker` versions is recommended to ensure all binary dependencies are met.
- **Output Consolidation**: Be aware that the tool may generate both `algorithm_output.tsv` and `unassigner_output.tsv`. The latter is typically the primary table for downstream analysis.

## Reference documentation
- [Unassigner Overview](./references/anaconda_org_channels_bioconda_packages_unassigner_overview.md)
- [Unassigner GitHub Repository and Usage](./references/github_com_PennChopMicrobiomeProgram_unassigner.md)