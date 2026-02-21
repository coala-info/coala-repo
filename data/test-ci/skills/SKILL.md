---
name: test-ci
description: The `test-ci` skill utilizes the `seqtk` toolkit to perform high-performance, lightweight processing of biological sequences.
homepage: https://github.com/lh3/seqtk
---

# test-ci

## Overview

The `test-ci` skill utilizes the `seqtk` toolkit to perform high-performance, lightweight processing of biological sequences. It is the primary tool for rapid pre-processing tasks such as converting FASTQ to FASTA, quality-based trimming, and random subsampling of large datasets. It natively supports gzipped input files and is designed for memory efficiency in bioinformatics pipelines.

## Common CLI Patterns

### Format Conversion and Transformation
- **Convert FASTQ to FASTA**: `seqtk seq -a in.fq.gz > out.fa`
- **Reverse complement**: `seqtk seq -r in.fq > out.fq`
- **Fold long lines (e.g., 60bp)**: `seqtk seq -l 60 in.fa > out.fa`
- **Convert multi-line FASTQ to standard 4-line format**: `seqtk seq -l0 in.fq > out.fq`

### Quality Filtering and Masking
- **Mask low-quality bases (Phred < 20) to lowercase**: `seqtk seq -aQ64 -q20 in.fq > out.fa`
- **Mask low-quality bases to N**: `seqtk seq -aQ64 -q20 -n N in.fq > out.fa`
- **Trim low-quality ends (Phred algorithm)**: `seqtk trimfq in.fq > out.fq`
- **Trim specific length from ends**: `seqtk trimfq -b 5 -e 10 in.fa > out.fa` (Trims 5bp from left, 10bp from right)

### Sequence Extraction and Subsampling
- **Subsample reads**: `seqtk sample -s100 in.fq 10000 > sub.fq`
  - *Note*: Use the same seed (`-s`) when processing paired-end files to maintain read pairing.
- **Extract by name list**: `seqtk subseq in.fq name.lst > out.fq`
- **Extract by BED region**: `seqtk subseq in.fa reg.bed > out.fa`
- **Mask BED regions to lowercase**: `seqtk seq -M reg.bed in.fa > out.fa`

### Specialized Analysis
- **Identify telomere repeats (TTAGGG)n**: `seqtk telo seq.fa > telo.bed`

## Expert Tips
- **Gzip Support**: Always pass `.gz` files directly to `seqtk`; there is no need to decompress them first, saving disk space and I/O time.
- **Paired-End Consistency**: When subsampling paired-end data, always use the same integer seed with the `-s` flag for both R1 and R2 files to ensure the resulting subsets contain the same read pairs.
- **Illumina Quality Scales**: For older Illumina data (v1.3 to v1.7), use the `-Q64` flag to correctly interpret the quality scores.
- **Memory Efficiency**: `seqtk` is optimized for stream processing. For very large files, pipe the output directly to the next tool in your workflow to minimize intermediate file creation.

## Reference documentation
- [Bioconda test package overview](./references/anaconda_org_channels_bioconda_packages_test_overview.md)
- [Seqtk GitHub Documentation](./references/github_com_lh3_seqtk.md)