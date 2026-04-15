---
name: bam-readcount
description: bam-readcount generates detailed, base-by-base metrics and allele counts from aligned sequencing data at specific genomic positions. Use when user asks to count alleles at specific sites, extract base-level quality metrics from a BAM file, or validate variant calls using site-specific read statistics.
homepage: https://github.com/genome/bam-readcount
metadata:
  docker_image: "quay.io/biocontainers/bam-readcount:1.0.1--h9aeec6d_3"
---

# bam-readcount

## Overview

`bam-readcount` is a specialized bioinformatics tool designed to provide granular, base-by-base metrics from aligned sequencing data. While many tools provide aggregate depth, `bam-readcount` breaks down counts by specific alleles and provides associated quality and positional metadata for every read covering a site. This makes it an essential tool for variant call refinement, resolving ambiguity between different variant callers, and performing deep-dive analysis of sequencing artifacts at specific loci.

## Command Line Usage

The basic syntax for `bam-readcount` is:
`bam-readcount [OPTIONS] <bam_file> [region]`

### Common CLI Patterns

**1. Basic site-specific counting**
To get metrics for a specific genomic window, provide the reference fasta and the region in `chr:start-stop` format:
```bash
bam-readcount -f reference.fa input.bam chr1:12345-12345
```

**2. Processing a list of specific sites**
For large-scale variant validation, use a site list file. The file must be tab-separated, contain no header, and follow the format `chromosome start end`:
```bash
bam-readcount -f reference.fa -l sites.bed input.bam
```

**3. Applying quality filters**
To reduce noise from poorly aligned or low-quality reads, use the mapping and base quality filters:
```bash
bam-readcount -q 20 -b 30 -f reference.fa input.bam
```
*   `-q`: Minimum mapping quality (default 0).
*   `-b`: Minimum base quality (default 0).

**4. Per-library reporting**
If the BAM file contains multiple libraries (e.g., merged samples), use `-p` to see results partitioned by library:
```bash
bam-readcount -p -f reference.fa input.bam
```

**5. Handling Insertions**
Use the `-i` flag to enable insertion-centric counting. When active, reads containing insertions at the site will be excluded from the standard per-base counts to avoid skewing statistics.

## Output Format Reference

The output is tab-separated and contains no header. Each line represents one genomic position:

1.  **chr**: Chromosome
2.  **position**: 1-based coordinate
3.  **reference_base**: The base in the reference genome
4.  **depth**: Total number of reads passing filters
5.  **base_statistics**: A series of colon-separated fields for each observed base (A, C, G, T, N, and indels).

### Base Statistic Fields
Each base entry follows this schema:
`base:count:avg_mapping_quality:avg_basequality:avg_se_mapping_quality:num_plus_strand:num_minus_strand:avg_pos_as_fraction:avg_num_mismatches_as_fraction:avg_sum_mismatch_qualities:num_q2_containing_reads:avg_distance_to_q2_start_in_q2_reads:avg_clipped_length:avg_distance_to_effective_3p_end`

## Expert Tips

*   **Reference Requirement**: Always provide the reference fasta (`-f`). While optional for some BAM files, it is strictly required for CRAM files and for calculating mismatch-related metrics.
*   **Memory Management**: For extremely high-depth data (e.g., amplicon sequencing), use `-d` to set a maximum depth limit (default is 10,000,000) to prevent excessive memory consumption.
*   **CRAM Support**: If using CRAM, `bam-readcount` will attempt to use the reference specified in the header or look up MD5s at ENA if `-f` is not provided, but providing the local fasta is significantly faster and more reliable.
*   **Parsing Results**: Because the output format is complex (nested colon-separated values), consider using external parsers like `brc-parser` to convert the output to a standard CSV/long format for downstream analysis in R or Python.

## Reference documentation
- [github_com_genome_bam-readcount.md](./references/github_com_genome_bam-readcount.md)
- [anaconda_org_channels_bioconda_packages_bam-readcount_overview.md](./references/anaconda_org_channels_bioconda_packages_bam-readcount_overview.md)