---
name: prinseq-plus-plus
description: prinseq-plus-plus is a high-performance C++ tool used for rapid quality control, filtering, and trimming of high-throughput sequencing data. Use when user asks to filter reads by quality or length, trim adapters and low-quality bases, remove sequence duplicates, or perform complexity filtering.
homepage: https://github.com/Adrian-Cantu/PRINSEQ-plus-plus
metadata:
  docker_image: "quay.io/biocontainers/prinseq-plus-plus:1.2.4--h7ff8a90_1"
---

# prinseq-plus-plus

## Overview
PRINSEQ++ is a C++ implementation of the original PRINSEQ-lite tool, designed for rapid sequence cleaning and quality control. It allows for the filtering of reads based on length, GC content, and quality scores, as well as the trimming of adapters, poly-A/T tails, and low-quality bases. Because it is multi-threaded and utilizes C++ optimizations, it is significantly faster and more memory-efficient than its Perl predecessor, making it ideal for modern high-throughput sequencing workflows.

## Common CLI Patterns

### Basic Quality Filtering
To filter single-end reads by length and average quality:
```bash
prinseq++ -fastq input.fastq -min_len 50 -min_qual_mean 20 -out_name filtered_output
```

### Paired-End Processing
When processing paired-end data, PRINSEQ++ handles mate pairs and outputs "good" pairs, "singletons" (where only one mate passed), and "bad" reads:
```bash
prinseq++ -fastq R1.fastq -fastq2 R2.fastq -threads 8 -min_len 60 -min_qual_score 15 -out_name pe_data
```

### Trimming Low-Quality Ends
Use a sliding window approach to trim low-quality bases from the 3' end (right):
```bash
prinseq++ -fastq input.fastq -trim_qual_right 20 -trim_qual_window 5 -trim_qual_step 2 -out_name trimmed
```

### Sequence Deduplication and Complexity Filtering
To remove exact duplicates and filter low-complexity sequences (e.g., using DUST or Entropy):
```bash
prinseq++ -fastq input.fastq -derep -lc_dust 0.5 -lc_entropy 0.5 -out_name clean_data
```

## Tool-Specific Best Practices

### Performance and Multi-threading
- **Threads**: Use the `-threads` flag to leverage multiple cores. Note that using more than one thread may result in the output sequences being in a different order than the input.
- **Gzip Handling**: PRINSEQ++ can read `.gz` files directly. While it can also write compressed output using `-out_gz`, this is currently noted as being slow; consider piping to `gzip` or using a separate compression step if performance is critical.

### Output Management
- **Naming Convention**: By default, `-out_name` creates several files:
  - `[name]_good_out_R1/R2`: Pairs where both reads passed.
  - `[name]_single_out_R1/R2`: Reads that passed but their mate failed.
  - `[name]_bad_out_R1/R2`: Reads that failed quality control.
- **Discarding Data**: If you do not need specific output files (like the "bad" reads), you can redirect them to `/dev/null` using the individual output flags: `-out_bad /dev/null -out_bad2 /dev/null`.

### Input Formats
- **FASTA Input**: If working with FASTA files, use the `-FASTA` flag. Note that quality scores will be internally assigned a default value (31/A) unless otherwise specified.
- **Phred64**: For older Illumina data (v1.3–1.7), ensure you include the `-phred64` flag to correctly interpret quality scores.

### Reporting
- **Verbosity**: Use `-VERBOSE 2` to get a detailed report comparing statistics across all filters (min_len, max_len, GC, quality, etc.). This is useful for identifying which specific filter is removing the most reads.

## Reference documentation
- [PRINSEQ++ GitHub Repository](./references/github_com_Adrian-Cantu_PRINSEQ-plus-plus.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_prinseq-plus-plus_overview.md)