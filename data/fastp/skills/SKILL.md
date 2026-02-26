---
name: fastp
description: "fastp is an all-in-one FASTQ preprocessor that performs quality profiling, adapter trimming, read filtering, and data merging. Use when user asks to preprocess sequencing data, trim adapters, filter reads by quality, merge paired-end reads, or extract unique molecular identifiers."
homepage: https://github.com/OpenGene/fastp
---


# fastp

## Overview
fastp is a high-performance, all-in-one preprocessor for FASTQ files. It replaces the need for multiple separate tools by combining quality profiling, adapter trimming, read filtering, and data merging into a single execution. It is designed for speed and efficiency, providing both a visual HTML report and a machine-readable JSON report. While optimized for short-read data (Illumina, MGI), it also offers basic support for long-read data.

## Common CLI Patterns

### Basic Processing
For paired-end (PE) data, fastp automatically detects adapters by default.
```bash
fastp -i in.R1.fq.gz -I in.R2.fq.gz -o out.R1.fq.gz -O out.R2.fq.gz
```

For single-end (SE) data:
```bash
fastp -i in.fq.gz -o out.fq.gz
```

### Quality and Length Filtering
*   **-q, --qualified_quality_phred**: The quality value that a base is considered as qualified (default: 15, i.e., Q15).
*   **-u, --unqualified_percent_limit**: How many percent of bases are allowed to be unqualified (default: 40).
*   **-l, --length_required**: Reads shorter than this length will be discarded (default: 15).

### Sliding Window Trimming
Similar to Trimmomatic but faster. Use `-W` to set window size and `-M` to set required mean quality.
```bash
fastp -i in.R1.fq.gz -I in.R2.fq.gz -o out.R1.fq.gz -O out.R2.fq.gz -5 -3 -W 4 -M 20
```
*   `-5`: Enable cutting by quality score from 5' end.
*   `-3`: Enable cutting by quality score from 3' end.

### PolyG and PolyX Trimming
Essential for NovaSeq/NextSeq data where "no signal" is interpreted as G.
*   **--trim_poly_g**: Enabled by default for NovaSeq/NextSeq data.
*   **--trim_poly_x**: Useful for removing polyA tails in mRNA-Seq.

### UMI (Unique Molecular Identifier) Processing
fastp can extract UMIs and append them to the read name.
```bash
fastp -i in.R1.fq.gz -I in.R2.fq.gz -o out.R1.fq.gz -O out.R2.fq.gz --umi --umi_loc=per_read --umi_len=8 --umi_prefix=UMI
```

### Merging Paired-End Reads
If your library has overlapping reads, fastp can merge them into a single read.
```bash
fastp -i in.R1.fq.gz -I in.R2.fq.gz --merge --merged_out merged.fq.gz --out1 unmerged.R1.fq.gz --out2 unmerged.R2.fq.gz
```

## Expert Tips

1.  **Streaming to Aligners**: Use `--stdout` to stream processed reads directly to an aligner like BWA or Bowtie2 to save disk I/O. For PE data, the output will be interleaved.
    ```bash
    fastp -i R1.fq.gz -I R2.fq.gz --stdout | bwa mem -p ref.fa -
    ```
2.  **Deduplication**: Use `-D` or `--dedup` to enable FASTQ-level deduplication. This is extremely fast compared to BAM-level deduplication.
3.  **Parallelization**: If you have a massive FASTQ file, use `--split_by_lines` or `--split` to break the output into multiple smaller files for parallel downstream processing.
4.  **Overrepresented Sequences**: Enable `--overrepresentation_analysis` to identify potential contaminants or adapter dimers that were not trimmed.
5.  **Base Correction**: For PE data, fastp can correct mismatched base pairs in overlapped regions if one base has high quality and the other has very low quality (enabled by default).

## Reference documentation
- [fastp GitHub README](./references/github_com_OpenGene_fastp.md)
- [fastp Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastp_overview.md)