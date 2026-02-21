---
name: prinseq
description: PRINSEQ++ is a high-performance C++ implementation of the original PRINSEQ tool, optimized for speed and memory efficiency through multi-threading.
homepage: https://github.com/Adrian-Cantu/PRINSEQ-plus-plus
---

# prinseq

## Overview

PRINSEQ++ is a high-performance C++ implementation of the original PRINSEQ tool, optimized for speed and memory efficiency through multi-threading. It allows for rigorous data cleaning of sequencing reads by applying various filters (length, GC content, quality scores, complexity) and trimming operations (fixed length, poly-A/T tails, sliding window quality). It natively supports compressed gzip files and is a standard choice for preparing data for assembly or mapping.

## Common CLI Patterns

### Basic Quality Filtering
Filter reads based on length and average quality score:
```bash
prinseq++ -fastq input.fastq -min_len 50 -min_qual_mean 25 -out_name filtered_output
```

### Paired-End Processing
Process paired-end reads while maintaining synchronization. This generates "good" pairs, "single" reads (where one mate failed), and "bad" reads:
```bash
prinseq++ -fastq R1.fq -fastq2 R2.fq -threads 8 -out_name my_sample
```

### Trimming and Tail Removal
Trim 10 bases from the start and remove poly-A tails longer than 5 bases from the end:
```bash
prinseq++ -fastq input.fq -trim_left 10 -trim_tail_right 5
```

### Quality-Based Window Trimming
Trim the right end of reads using a sliding window (size 5, step 2) if the mean quality drops below 20:
```bash
prinseq++ -fastq input.fq -trim_qual_right 20 -trim_qual_window 5 -trim_qual_step 2
```

### Deduplication and Complexity Filtering
Remove exact duplicates and low-complexity sequences (using entropy):
```bash
prinseq++ -fastq input.fq -derep -lc_entropy 0.5
```

## Expert Tips

- **Performance**: Always specify `-threads` to take advantage of multi-core processors, as the default is 1. Note that multi-threading may change the order of sequences in the output.
- **Disk Space**: Use `-out_gz` to write compressed output directly, though be aware this can be slower than writing uncompressed data.
- **Handling Unwanted Files**: PRINSEQ++ generates several output files by default (good, single, bad). If you do not need specific outputs (e.g., the "bad" reads), use `-out_bad /dev/null` to avoid cluttering your filesystem.
- **Format Conversion**: You can convert FASTQ to FASTA during the filtering process by setting `-out_format 1`.
- **Legacy Data**: For older Illumina data, use the `-phred64` flag to ensure quality scores are parsed correctly.
- **Reporting**: Use `-VERBOSE 2` to get a structured report of how many sequences were removed by each specific filter, which is useful for multi-sample comparison and QC logging.

## Reference documentation
- [PRINSEQ++ Main Documentation](./references/github_com_Adrian-Cantu_PRINSEQ-plus-plus.md)