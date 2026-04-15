---
name: cmseq
description: cmseq extracts high-resolution coverage statistics, identifies polymorphic sites, and generates consensus sequences from BAM files. Use when user asks to calculate breadth and depth of coverage, detect synonymous and non-synonymous mutations, or reconstruct sequences from alignment data.
homepage: https://github.com/SegataLab/cmseq
metadata:
  docker_image: "quay.io/biocontainers/cmseq:1.0.4--pyhb7b1952_0"
---

# cmseq

## Overview

cmseq is a specialized suite of tools designed to interface with BAM files to extract high-resolution coverage statistics and sequence information. It excels at calculating how much of a reference is covered (breadth) and the intensity of that coverage (depth), while also providing robust methods for identifying polymorphic sites within a population. Additionally, it can generate a consensus sequence from alignment data without relying on the original reference sequence's nucleotides, making it a powerful tool for studying microbial diversity and strain-level variations in sequencing datasets.

## Command Line Usage

### Coverage Analysis
Use `breadth_depth.py` to get tabular statistics on your alignments.
*   **Basic usage**: `breadth_depth.py my_sample.bam`
*   **Unsorted files**: Use `--sortindex` to have the tool handle sorting and indexing automatically.
*   **Quality Filtering**: Use `--minqual` (default 30) and `--mincov` (default 1) to ensure statistics are based on reliable data.
*   **Targeting**: Use `-c` followed by a comma-separated list of IDs or a FASTA file to limit analysis to specific contigs.

### Polymorphism Detection
Use `poly.py` for whole-genome polymorphic rates or `polymut.py` for protein-coding sequences (CDS).
*   **CDS Analysis**: `polymut.py --gff_file annotations.gff my_sample.bam`
*   **Note**: `polymut.py` requires Biopython <= 1.76. It calculates synonymous and non-synonymous mutations by comparing dominant and second-dominant alleles.
*   **Thresholding**: Adjust `--dominant_frq_thrsh` to define the ratio at which a site is considered a variant.

### Consensus Generation
Use `consensus.py` to reconstruct sequences from BAM data.
*   **Reference-Free**: The tool generates a consensus based on the reads themselves rather than the reference sequence.
*   **Majority Rule**: By default, it uses a majority rule for each position.
*   **Masking**: Positions failing to meet `--mincov` or `--minqual` thresholds are reported as `-`.

## Expert Tips

*   **Summary Statistics**: The output of `breadth_depth.py` includes an `all_contigs` row which treats the entire BAM file as a single entity for global metrics.
*   **Read Trimming**: When generating consensus or calculating coverage, use `--truncate` to ignore a specific number of nucleotides at the ends of contigs, which are often prone to alignment artifacts.
*   **Filtering Flags**: Use the `-f` flag to exclude unmapped, secondary, QC-fail, and duplicate reads. If unset, the tool behaves similarly to `bedtools genomecov` and considers all reads.
*   **Python Integration**: For complex workflows, cmseq can be imported as a Python module. Use `cmseq.BamFile` to manage collections of contigs and `cmseq.BamContig` for operations on specific references.



## Subcommands

| Command | Description |
|---------|-------------|
| breadth_depth.py | calculate the Breadth and Depth of coverage of BAMFILE. |
| polymut.py | Reports the polymorphic rate of each reference (polymorphic bases / total bases). Focuses only on covered regions (i.e. depth >= 1) |

## Reference documentation

- [CMSeq GitHub README](./references/github_com_SegataLab_cmseq_blob_master_README.md)
- [CMSeq Python Class Documentation](./references/github_com_SegataLab_cmseq_blob_master_README_class.md)