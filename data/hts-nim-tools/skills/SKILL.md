---
name: hts-nim-tools
description: hts-nim-tools provides high-speed bioinformatics utilities for filtering alignments, counting reads, and validating variant calling data. Use when user asks to filter BAM or CRAM files using expressions, count reads overlapping genomic intervals, or identify missing data in VCF files.
homepage: https://github.com/brentp/hts-nim-tools
metadata:
  docker_image: "quay.io/biocontainers/hts-nim-tools:0.3.11--hbeb723e_0"
---

# hts-nim-tools

## Overview

`hts-nim-tools` is a collection of high-speed bioinformatics utilities built using the Nim programming language. These tools provide a performant alternative to traditional scripts for common sequence analysis tasks. Use this skill to efficiently filter alignments based on mapping quality or auxiliary tags, generate read counts for specific genomic intervals, and validate the integrity of variant calling projects by identifying "missing chunks" in VCF data.

## Core Utilities and Usage Patterns

### 1. bam-filter
Filters BAM, CRAM, or SAM files using a flexible expression language. This is significantly faster than writing custom Python or Perl scripts for complex filtering.

**Basic Syntax:**
`bam-filter [options] "<expression>" <input_file>`

**Available Attributes:**
- **Metrics**: `mapq`, `start`, `pos` (1-based), `end`, `flag`, `insert_size`
- **Boolean Flags**: `is_aligned`, `is_read1`, `is_read2`, `is_supplementary`, `is_secondary`, `is_dup`, `is_qcfail`, `is_reverse`, `is_mate_reverse`, `is_pair`, `is_proper_pair`, `is_mate_unmapped`, `is_unmapped`
- **Auxiliary Tags**: Access any tag using the `tag_` prefix (e.g., `tag_NM`, `tag_RG`).

**Expert Tip:** Combine multiple conditions with `&&` (AND) and `||` (OR).
*Example*: Filter for proper pairs with a mapping quality over 30 and fewer than 2 mismatches:
`bam-filter "is_proper_pair && mapq > 30 && tag_NM < 2" input.bam`

### 2. count-reads
Reports the number of reads overlapping each interval defined in a BED file.

**Basic Syntax:**
`count-reads [options] <regions.bed> <input.bam_or_cram>`

**Key Options:**
- `-F --flag <FLAG>`: Exclude reads with any of these bits set (default: 1796).
- `-Q --mapq <int>`: Set a minimum mapping quality threshold (default: 0).
- `-t --threads <int>`: Increase decompression threads for faster processing.

**Output:** A line for each BED interval containing the original BED fields followed by the read count.

### 3. vcf-check
A quality control tool for large-scale variant calling projects. It identifies regions where the query VCF lacks expected variation compared to a background VCF (like gnomAD).

**Basic Syntax:**
`vcf-check [options] <background.vcf.gz> <query.vcf.gz>`

**Key Options:**
- `-c --chunk <int>`: Genomic window size for checking (default: 100,000 bp).
- `-m --maf <float>`: Minimum allele frequency in the background VCF to consider a site (default: 0.1).

**Workflow Tip:** The output is a tab-delimited file (`chrom`, `pos`, `bg_count`, `query_count`). Use this to identify "silent" regions in your pipeline where variant calling may have failed due to technical errors or processing gaps.

## General Best Practices

- **CRAM Support**: When working with CRAM files, always provide the reference fasta using the `-f` or `--fasta` flag, or ensure the `$REF_PATH` environment variable is set.
- **Performance**: For large datasets, utilize the `-t` or `--threads` option to leverage multi-core decompression.
- **Tag Filtering**: When using `bam-filter` with string tags (like Read Groups), ensure the value is enclosed in single quotes within the double-quoted expression: `bam-filter "tag_RG == 'SRR12345'" input.bam`.

## Reference documentation
- [hts-nim-tools GitHub Repository](./references/github_com_brentp_hts-nim-tools.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hts-nim-tools_overview.md)