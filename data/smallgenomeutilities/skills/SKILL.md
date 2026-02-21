---
name: smallgenomeutilities
description: The `smallgenomeutilities` package is a collection of Python-based command-line tools specifically designed for the unique challenges of viral genomics.
homepage: https://github.com/cbg-ethz/smallgenomeutilities
---

# smallgenomeutilities

## Overview
The `smallgenomeutilities` package is a collection of Python-based command-line tools specifically designed for the unique challenges of viral genomics. Unlike general-purpose bioinformatics tools, these utilities are optimized for high-variability viral RNA data. They facilitate complex workflows such as converting alignments between different reference strains (liftover), merging overlapping paired-end reads into full amplicons, and generating quality control metrics for depth and coverage across small genomes.

## Core CLI Patterns

### Alignment and Reference Manipulation
*   **Genomic Liftover**: Use `convert_reference` to transform a BAM/SAM file from one reference coordinate system to another.
    ```bash
    convert_reference -i input.bam -r new_reference.fasta -o output.bam
    ```
*   **Coordinate Mapping**: Use `mapper` to determine specific genomic offsets on a target contig based on an initial contig.
*   **Base Counting**: Use `aln2basecnt` to extract per-base counts and coverage from a single alignment file, which is often the first step for variant calling or QC.

### Consensus and Variant Analysis
*   **Consensus Generation**: Use `extract_consensus` to build sequences from BAM files. You can choose to include the majority base or use ambiguous (IUPAC) bases.
*   **Frameshift Detection**: Run `frameshift_deletions_checks` on consensus sequences to identify indels that disrupt the reading frame.
    *   *Tip*: This tool requires `mafft` to be installed in the environment.
*   **Minority Variants**: Use `minority_freq` to extract frequencies of non-majority variants across multiple samples simultaneously.

### Read Processing and Coverage
*   **Paired-End Merging**: Use `paired_end_read_merger` to fuse reads into a single merged read based on their alignment to a reference, which is highly effective for amplicon-based viral sequencing.
    ```bash
    paired_end_read_merger input.sam -f reference.fasta -o merged.sam
    ```
*   **Coverage QC**: Use `coverage_depth_qc` to calculate the fraction of the genome covered at specific depth thresholds (e.g., 10x, 100x). It supports TSV files from `aln2basecnt` or `samtools depth`.
*   **Interval Extraction**: Use `extract_coverage_intervals` to find regions with sufficient depth for downstream haplotype reconstruction tools like ShoRAH.

## Expert Tips
*   **Memory Efficiency**: Most utilities are designed to handle NGS data streamingly or with small memory footprints, making them suitable for high-throughput viral pipelines.
*   **Half-Open Intervals**: Note that tools like `extract_coverage_intervals` use 0-based indexing and return half-open intervals `[start:end)`, consistent with Python and BED format conventions.
*   **V-pipe Integration**: These tools are the engine behind the V-pipe workflow. If you are troubleshooting a V-pipe run, these utilities are usually the specific points of failure or adjustment.
*   **Help Flag**: Every utility supports the `--help` flag. Use it to check for specific filtering parameters like frequency thresholds or gap tolerances (especially in `extract_sam`).

## Reference documentation
- [smallgenomeutilities GitHub Repository](./references/github_com_cbg-ethz_smallgenomeutilities.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_smallgenomeutilities_overview.md)