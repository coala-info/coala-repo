---
name: fetchmgs
description: `fetchmgs` is a specialized bioinformatics tool that automates the identification and extraction of 40 universal phylogenetic marker genes.
homepage: https://github.com/motu-tool/FetchMGs
---

# fetchmgs

## Overview
`fetchmgs` is a specialized bioinformatics tool that automates the identification and extraction of 40 universal phylogenetic marker genes. These genes are typically present in single copies across most known organisms, making them excellent candidates for reconstructing evolutionary histories. The tool utilizes Hidden Markov Models (HMMs) and calibrated bitscore cutoffs to ensure high accuracy. It supports various input types, including raw assemblies (where it performs gene calling automatically) and pre-annotated protein files.

## Command Line Usage

The primary command for the tool is `fetchmgs extraction`.

### Basic Syntax
```bash
fetchmgs extraction <input_file> <mode> <output_folder> [options]
```

### Extraction Modes
The `mode` argument is mandatory and determines how the input is processed:
- **genome**: Use for single-organism genome assemblies (NT). The tool will call genes before extraction.
- **metagenome**: Use for community assemblies (NT). Optimized for fragmented sequences.
- **gene**: Use for pre-called protein sequences (AA).

### Input Handling
- **Single Files**: Provide a path to a plain or gzipped FASTA file.
- **Batch Processing**: Provide a text file containing one file path per line. `fetchmgs` will automatically detect if the input is a list of files based on content.

### Key Options
- `-d <FILE>`: In `gene` mode, provide the corresponding nucleotide sequences to receive `.fna` output. The order of sequences must match the protein input.
- `-t <INT>`: Set the number of CPU threads (default is 1).
- `-v`: Report only the single best hit per marker gene. This is highly recommended when processing individual genomes to ensure single-copy constraints.

## Output Files
For every sample processed, the tool generates three files in the specified output folder:
1. `SAMPLE.fetchMGs.faa`: Extracted marker genes in amino acid (protein) space.
2. `SAMPLE.fetchMGs.fna`: Extracted marker genes in nucleotide space (only if nucleotide input was provided or inferred).
3. `SAMPLE.fetchMGs.scores`: A mapping of identified marker genes to their respective HMM bitscores.

## Expert Tips and Best Practices
- **Sequence Completeness**: The calibrated cutoffs used by `fetchmgs` are most accurate when applied to complete protein sequences. If using `gene` mode, ensure your gene predictor has not truncated the sequences.
- **Genome Quality**: When working with high-quality isolate genomes, always use the `-v` flag. If multiple hits for the same marker gene appear without this flag, it may indicate contamination or a recent gene duplication event.
- **Automated Gene Calling**: In `genome` and `metagenome` modes, `fetchmgs` uses `pyrodigal` for internal gene prediction. You do not need to run a separate gene finder like Prodigal beforehand unless you require specific custom parameters.
- **Performance**: For large metagenomic datasets, increasing the thread count with `-t` significantly reduces the time spent on the HMM search phase (powered by `pyhmmer`).

## Reference documentation
- [FetchMGs GitHub Repository](./references/github_com_motu-tool_FetchMGs.md)
- [Bioconda fetchmgs Overview](./references/anaconda_org_channels_bioconda_packages_fetchmgs_overview.md)