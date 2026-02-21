---
name: nanovar
description: NanoVar is a specialized pipeline designed for rapid and accurate structural variant (SV) detection using shallow long-read sequencing data.
homepage: https://github.com/cytham/nanovar
---

# nanovar

## Overview
NanoVar is a specialized pipeline designed for rapid and accurate structural variant (SV) detection using shallow long-read sequencing data. It is particularly effective for large-scale cohort studies or clinical investigations where sequencing depth is limited. The tool integrates long-read mapping via Minimap2 with a neural-network-based filtering system to provide high-precision SV calls. It supports multiple long-read technologies including Oxford Nanopore (ONT) and Pacific Biosciences (PacBio CLR/CCS).

## Core Command Pattern
The basic execution requires an input read file (or alignment), a reference genome, and a working directory.

```bash
nanovar [options] -t <threads> -f <gap_file> <input_file> <reference.fa> <working_dir>
```

### Input Formats
- **Reads**: `.fasta`, `.fastq` (and gzipped versions)
- **Alignments**: `.bam`, `.cram`

## Expert Usage and Best Practices

### 1. Data Type Specification
Always specify the sequencing technology using `-x` to ensure the correct alignment and discovery parameters are applied:
- `ont`: Oxford Nanopore (Default)
- `pacbio-clr`: PacBio Continuous Long Reads
- `pacbio-ccs`: PacBio Circular Consensus Sequencing (HiFi)

### 2. Handling Reference Gaps
To reduce false positives in repetitive or unmappable regions, use the `-f` flag. NanoVar includes built-in gap files for common assemblies:
- `-f hg19`
- `-f hg38`
- `-f mm10`
- Alternatively, provide a custom BED file path for other species.

### 3. Mobile Element Annotation (NanoINSight)
For human, mouse, or rat samples, enable repeat element annotation for insertions (e.g., LINE/SINE) using the `--annotate_ins` flag. This requires `mafft` and `RepeatMasker` to be in your PATH.
```bash
nanovar -t 24 -f hg38 --annotate_ins human sample.bam ref.fa ./output_dir
```

### 4. Sensitivity and Filtering
- **Coverage Thresholds**: Use `-c` (mincov) to adjust the minimum read support. The default is 4.
- **SV Length**: Use `-l` (minlen) to set the minimum SV size. The default is 25bp.
- **Quality Scores**: The `-s` (score) parameter filters the VCF based on the neural network's confidence. The default 1.0 is optimized for simulated data; consider lowering it slightly for higher recall on real-world low-depth data.

### 5. Genotyping Parameters
If your depth is significantly higher or lower than the recommended 4x-8x, you may need to adjust the genotype classification thresholds:
- `--homo`: Lower limit for homozygous ratio (Default: 0.75)
- `--hetero`: Lower limit for heterozygous ratio (Default: 0.35)

### 6. Output Analysis
- **Primary Output**: `${sample}.nanovar.pass.vcf` contains the filtered, high-confidence SV calls.
- **Visual Summary**: `${sample}.nanovar.pass.report.html` provides a run summary and statistics.
- **Supporting Reads**: Use `--sv_bam_out` to generate a BAM file containing only the reads that supported the SV calls, which is useful for manual inspection in IGV.

## Troubleshooting and Compatibility
- **Tensorflow Version**: Ensure `tensorflow-cpu==2.15.1`. Versions >= 2.16.0 are currently incompatible.
- **Numpy Version**: Ensure `numpy < 2.0.0` to avoid "dtype size changed" errors.
- **Dependencies**: Ensure `samtools`, `bedtools`, and `minimap2` are available in your system PATH.

## Reference documentation
- [NanoVar GitHub Repository](./references/github_com_cytham_nanovar.md)
- [NanoVar Wiki](./references/github_com_cytham_nanovar_wiki.md)