---
name: nucdiff
description: NucDiff is a comparative genomics tool that maps and classifies local, structural, and global differences between two sets of DNA sequences. Use when user asks to compare two genomes, identify structural rearrangements, classify SNPs and indels, or validate de novo assemblies against a reference.
homepage: https://github.com/uio-cels/NucDiff
metadata:
  docker_image: "quay.io/biocontainers/nucdiff:2.0.3--pyh864c0ab_1"
---

# nucdiff

## Overview
NucDiff is a comparative genomics tool designed to map and classify differences between two sets of DNA sequences. By leveraging the MUMmer alignment package, it provides a granular breakdown of variations into three categories: local (SNPs, small indels), structural (translocations, inversions, relocations), and global differences. It is particularly effective for validating de novo assemblies against a reference genome or performing comparative analysis between closely related bacterial strains.

## Command Line Usage

The basic syntax for running NucDiff is:
`python nucdiff.py [options] Reference.fasta Query.fasta Output_dir Prefix`

### Common Patterns

**Basic Comparison**
Run a standard comparison with default parameters:
`python nucdiff.py reference.fasta query.fasta ./output_results my_comparison`

**High-Performance Execution**
Utilize multiple CPU cores to speed up the alignment process:
`python nucdiff.py --proc 8 reference.fasta query.fasta ./output_results my_comparison`

**Generating VCF for Variant Calling**
Enable VCF output for small and medium local differences to facilitate downstream analysis in standard bioinformatics pipelines:
`python nucdiff.py --vcf yes reference.fasta query.fasta ./output_results my_comparison`

**Tuning Alignment Sensitivity**
Pass custom parameters to the underlying NUCmer engine (e.g., minimum cluster length `-c` and minimum match length `-l`):
`python nucdiff.py --nucmer_opt '-c 200 -l 250' reference.fasta query.fasta ./output_results my_comparison`

### Key Arguments and Options
- `Reference.fasta`: The anchor sequence (e.g., a high-quality reference genome).
- `Query.fasta`: The sequence being tested (e.g., a new assembly).
- `--reloc_dist [int]`: Sets the minimum distance between two relocated blocks. Default is 10,000 bp.
- `--ref_name_full yes`: Includes the full header from the fasta file in the output; otherwise, everything after the first space is truncated.
- `--delta_file [path]`: If you have already run NUCmer, you can provide the existing `.delta` file to skip the alignment step.

## Expert Tips and Best Practices

- **Sequence Similarity**: NucDiff is optimized for "closely related" sequences. If the sequences are too divergent, the NUCmer alignment may become too fragmented for meaningful structural classification.
- **Hardcoded Parameters**: Note that `--maxmatch` in NUCmer and `-q` in delta-filter are hardcoded within NucDiff to ensure specific filtering logic; do not attempt to override these via `--nucmer_opt` or `--filter_opt`.
- **Output Inspection**:
    - `_ref_snps.gff/vcf`: Best for identifying point mutations relative to the reference.
    - `_ref_struct.gff`: Essential for identifying large-scale rearrangements like inversions or translocations.
    - `_stat.out`: Always check this file first for a high-level summary of the total number of differences found.
- **Visualization**: The generated `.gff` files are compatible with the Integrative Genomics Viewer (IGV). Loading both the reference-based and query-based GFFs provides a comprehensive view of how sequences have moved or changed.
- **Environment**: Ensure `mummer` and `biopython` are in your PATH. While originally written for Python 2.7, check your specific installation version as some bioconda distributions include compatibility patches.

## Reference documentation
- [NucDiff GitHub Manual](./references/github_com_uio-cels_NucDiff.md)
- [NucDiff Wiki and Output Descriptions](./references/github_com_uio-cels_NucDiff_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_nucdiff_overview.md)