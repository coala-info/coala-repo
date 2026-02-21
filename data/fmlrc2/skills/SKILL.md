---
name: fmlrc2
description: fmlrc2 is a high-performance Rust implementation of the Functional Multi-Loci Read Corrector (FMLRC).
homepage: https://github.com/HudsonAlpha/rust-fmlrc
---

# fmlrc2

## Overview
fmlrc2 is a high-performance Rust implementation of the Functional Multi-Loci Read Corrector (FMLRC). It utilizes an FM-index built from accurate short-read data to identify and correct errors in long-read sequences. Compared to the original C++ version, fmlrc2 offers significantly faster execution times and reduced CPU usage while maintaining nearly identical correction accuracy. It is particularly effective for bacterial and eukaryotic genome polishing.

## BWT Construction
Before correction, you must build a BWT of the accurate short reads. There are two primary methods:

### 1. Simplified Construction (msbwt2)
Recommended for most users. It is flexible and handles FASTA/FASTQ inputs.
```bash
# Requires msbwt2-build
msbwt2-build -o comp_msbwt.npy reads.fastq.gz
```

### 2. High-Performance Construction (ropebwt2)
Faster for large datasets but requires a complex shell pipe.
```bash
gunzip -c reads.fq.gz | awk 'NR % 4 == 2' | tr NT TN | ropebwt2 -LR | tr NT TN | fmlrc2-convert comp_msbwt.npy
```
*Note: If read recovery is not required, you can omit the `sort` step in the pipe to significantly reduce construction time.*

## Correction Workflow
The basic syntax for correction is:
```bash
fmlrc2 [OPTIONS] <comp_msbwt.npy> <uncorrected.fq.gz> <corrected_reads.fa>
```

### Key Parameters
- `-k`, `--K`: Sets k-mer sizes. Default is `[21, 59]`. You can specify multiple values for multi-pass correction.
- `-t`, `--threads`: Number of threads (default: 1).
- `-C`, `--cache_size`: Length of sequences to pre-compute. Default is 8 (~25MB). Increasing to 10 (~1GB) significantly reduces CPU time if memory allows.

### Multi-pass Correction Example
To perform a 3-pass correction with k-mer sizes 21, 59, and 79:
```bash
fmlrc2 -k 21 59 79 -- comp_msbwt.npy uncorrected.fq.gz corrected_reads.fa
```
*Note: Use the `--` delimiter if the CLI needs to distinguish the end of the k-mer list from positional arguments.*

## Best Practices
- **Memory Management**: The `-C` (cache size) parameter is the primary lever for performance. Use `-C 10` for a good balance between speed and memory (requires ~1GB RAM for the cache).
- **Input Formats**: fmlrc2 supports both FASTA and FASTQ (optionally gzipped) for uncorrected reads.
- **Output Formats**: Currently, fmlrc2 only supports uncompressed FASTA for the corrected output.
- **K-mer Selection**: While the defaults (21, 59) work well for most bacterial genomes, adding a larger k-mer (e.g., 79 or 85) can improve results for more complex or repetitive eukaryotic genomes.

## Reference documentation
- [GitHub Repository Documentation](./references/github_com_HudsonAlpha_fmlrc2.md)