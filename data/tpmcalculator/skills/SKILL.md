---
name: tpmcalculator
description: tpmcalculator precisely quantifies transcriptomic features and alternative splicing events from alignment data. Use when user asks to 'quantify gene expression', 'quantify transcript expression', 'quantify exon expression', 'quantify intron expression', or 'identify intron retention events'.
homepage: https://github.com/ncbi/TPMCalculator
metadata:
  docker_image: "quay.io/biocontainers/tpmcalculator:0.0.6--h2bd4fab_0"
---

# tpmcalculator

## Overview
The `tpmcalculator` skill enables precise quantification of transcriptomic features directly from alignment data. Unlike general counters, it performs a one-step transformation of GTF coordinates to create unique, non-overlapping models for exons and "pure" introns. This makes it particularly useful for researchers needing to identify alternative splicing events like intron retention alongside standard gene-level TPM values.

## Usage Patterns

### Basic Quantification
To process a single BAM file with a standard GTF:
```bash
TPMCalculator -g genes.gtf -b sample.bam
```

### Batch Processing
To process all BAM files within a specific directory:
```bash
TPMCalculator -g genes.gtf -d /path/to/bam_directory/
```

### Recommended Settings for Paired-End Data
When working with paired-end sequencing, it is critical to ensure only valid pairs are counted to maintain quantification accuracy:
```bash
TPMCalculator -g genes.gtf -b sample.bam -p -c 100
```
*Note: Set `-c` (minimum intron size) to your read length for optimal results.*

### Extended Transcript-Level Output
By default, the tool focuses on gene-level features. Use the `-e` flag to include transcript-level TPM values:
```bash
TPMCalculator -g genes.gtf -b sample.bam -e
```

## Command Options Reference

| Option | Description | Default |
| :--- | :--- | :--- |
| `-g` | Path to the GTF annotation file (Required) | N/A |
| `-b` | Path to a single BAM file | N/A |
| `-d` | Path to a directory containing multiple BAM files | N/A |
| `-k` | Gene ID key to parse from GTF | `gene_id` |
| `-t` | Transcript ID key to parse from GTF | `transcript_id` |
| `-p` | Use only properly paired reads (Recommended for PE) | No |
| `-q` | Minimum MAPQ value to filter reads | 0 |
| `-o` | Minimum overlap (bp) between a read and a feature | 8 |
| `-c` | Minimum size for created introns | 16 |
| `-a` | Include features with zero counts in output | No |

## Output Files
The tool generates four primary output files per sample:
1. `*_genes.out`: Gene-level TPM and raw counts.
2. `*_transcripts.out`: Transcript-level data (if `-e` is used).
3. `*_exons.out`: Exon-level quantification.
4. `*_introns.out`: "Pure" intron quantification (non-overlapping with exons).

## Expert Tips
- **MAPQ Filtering**: If your aligner (like STAR or HISAT2) assigns specific meanings to MAPQ values (e.g., 255 for unique mappers), use the `-q` flag to filter out multi-mapping reads to reduce noise.
- **Intron Retention**: Use the `*_introns.out` file to specifically look for reads falling into "pure" intronic regions, which is a strong indicator of intron retention events.
- **Memory Efficiency**: The tool is highly optimized; it typically processes a 7GB BAM file in ~20 minutes using only 4GB of RAM.

## Reference documentation
- [TPMCalculator Wiki](./references/github_com_NLM-DIR_TPMCalculator_wiki.md)
- [TPMCalculator GitHub Repository](./references/github_com_NLM-DIR_TPMCalculator.md)