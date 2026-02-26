---
name: seq-seq-pan
description: seq-seq-pan is a bioinformatics workflow designed for the sequential alignment of genomic sequences to build a pangenome iteratively. Use when user asks to perform whole-genome alignment, split a pangenome by chromosomes, extract specific genomic subregions, or map coordinates between a consensus sequence and individual genomes.
homepage: https://gitlab.com/chrjan/seq-seq-pan
---


# seq-seq-pan

## Overview
seq-seq-pan is a specialized bioinformatics workflow designed for the sequential alignment of genomic sequences. Unlike traditional multiple sequence aligners that process all inputs simultaneously, seq-seq-pan builds a pangenome iteratively. This approach is particularly effective for closely related species or strains where a unified coordinate system (the pangenome) is required to analyze variations, extract specific loci across all samples, or map annotations from a reference to a collective consensus.

## Core Workflows and CLI Patterns

### Whole-Genome Alignment (WGA)
The primary entry point for building the pangenome.
- **Basic Usage**: `seq-seq-pan wga [options]`
- **Key Output**: Generates an `.xmfa` alignment file and a `xxx_genomedescription.txt` file. The genome description file is critical for all downstream "extract" and "split" operations.

### Splitting the Pangenome
Use the `split` command to organize the pangenome by chromosomes or specific contigs.
- **Requirement**: Requires a genome description file (`-g`).
- **Genome ID Logic**: The first column in the description file must be an integer representing the order in which genomes were added during the WGA process.
- **Example Description Format (Tab-separated)**:
  ```text
  1    chr1    23000
  1    chr2    31000
  2    contig1 9000
  ```

### Extracting Subregions
To extract a specific genomic interval from the alignment (including the consensus):
- **Pattern**: `seq-seq-pan extract -x <alignment.xmfa> -g <description.txt> -p <out_path> -n <name> -e <sequence_id>:<start>-<end>`
- **Expert Tip**: Ensure the `<sequence_id>` matches the name used in the original FASTA headers.

### Coordinate Mapping
Map coordinates from the consensus sequence back to individual genomes or vice versa.
- **Map All**: Use `seq-seq-pan mapall` to map all coordinates of the consensus sequence to selected genomes.
- **Single Map**: `seq-seq-pan map -c <consensus.fasta> -p <out_path> -n <output_name> -i <index_file>`

## Expert Tips and Best Practices
- **Sequence Naming**: Internally, the tool (via progressiveMauve) may rename sequences to integers (1, 2, 3). Always keep the `xxx_genomedescription.txt` file generated during the WGA step, as it serves as the Rosetta Stone for mapping these integers back to your original chromosome/contig names.
- **Input Validation**: Ensure FASTA files are not empty before starting the WGA. The underlying alignment engine may hang indefinitely on empty files without throwing an error.
- **Consensus Handling**: If the consensus sequence is not split into expected Locally Collinear Blocks (LCBs), verify the chromosome annotations in the genome description file used during the `split` or `consensus` phase.
- **Handling 'X' Bases**: The tool is designed to handle 'X' bases specifically when building consensus sequences, making it suitable for draft genomes with masked regions.

## Reference documentation
- [seq-seq-pan GitLab Activity](./references/gitlab_com_chrjan_seq-seq-pan.atom.md)
- [seq-seq-pan Overview](./references/anaconda_org_channels_bioconda_packages_seq-seq-pan_overview.md)
- [seq-seq-pan Releases and Features](./references/gitlab_com_chrjan_seq-seq-pan_-_releases.md)