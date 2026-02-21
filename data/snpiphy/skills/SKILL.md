---
name: snpiphy
description: `snpiphy` is a streamlined pipeline designed to generate phylogenetic trees derived from Single Nucleotide Polymorphisms (SNPs).
homepage: https://github.com/bogemad/snpiphy
---

# snpiphy

## Overview
`snpiphy` is a streamlined pipeline designed to generate phylogenetic trees derived from Single Nucleotide Polymorphisms (SNPs). It integrates established bioinformatics tools—including Snippy for variant calling, Gubbins for recombination detection, and RAxML or FastTree for phylogeny—into a single command-line interface. It is particularly effective for analyzing bacterial genomes where a common reference sequence is available.

## Usage Patterns

### Basic Execution
For interleaved paired-end FASTQ files or FASTA assemblies in a single directory:
`snpiphy -o <output_dir> -r <reference.fasta> -q <input_dir>`

### Handling Single-End Reads
If your input directory contains single-end reads (e.g., Ion Torrent or specific Illumina runs), you must explicitly flag them:
`snpiphy -o <output_dir> -r <reference.fasta> -q <input_dir> -s`

### Complex Input Sets
When dealing with a mix of single-end and paired-end data, or data spread across multiple directories, use an input list:
1. Generate a template: `snpiphy_generate_input_list`
2. Run the pipeline: `snpiphy -o <output_dir> -r <reference.fasta> -l <input_list.tsv>`

## Optimization and Best Practices

### Performance Tuning
- **Multithreading**: Use `-t <threads>` to specify CPU cores.
- **Parallelization**: Use the `-j` flag to trigger GNU Parallel for the `snippy` steps, which significantly reduces runtime when processing many samples on multi-core systems.

### Tree Building Algorithms
- **RAxML (Default)**: Best for high-accuracy maximum likelihood trees.
- **FastTree**: Use `-b fasttree` for much faster execution on very large datasets where RAxML might be computationally prohibitive.
- **Gamma Model**: Use `-m` to switch to the GTRGAMMA model instead of GTRCAT during tree building.

### Biological Considerations
- **Recombination**: By default, the pipeline filters recombination events using Gubbins. If your organism is known to have low recombination rates, disable this with `-n` to speed up the process.
- **Coverage Cutoff**: The default coverage threshold is 85%. If your samples are expected to have lower coverage, adjust this using `-c <0-100>` to prevent samples from being rejected.

## Reference documentation
- [snpiphy GitHub Repository](./references/github_com_bogemad_snpiphy.md)
- [snpiphy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_snpiphy_overview.md)