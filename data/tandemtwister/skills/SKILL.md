---
name: tandemtwister
description: TandemTwister genotypes tandem repeats by leveraging long-read sequencing data to resolve complex repeat regions. Use when user asks to genotype germline tandem repeats, perform assembly-based genotyping, or profile somatic repeat expansions and contractions.
homepage: https://github.com/Lionward/tandemtwister
metadata:
  docker_image: "quay.io/biocontainers/tandemtwister:0.2.0--h9948957_0"
---

# tandemtwister

## Overview

TandemTwister is a high-performance bioinformatic tool designed to genotype tandem repeats (TRs) by leveraging the unique advantages of long-read sequencing. It excels at resolving complex repeat regions that are typically inaccessible to short-read technologies. The tool supports multiple analysis workflows—germline, somatic (experimental), and assembly-based—and includes specialized algorithms for phasing and error correction of short motifs (≤3bp). It is particularly useful for large-scale genomic studies, capable of processing over a million regions in under 20 minutes using multi-threading.

## Core Workflows

TandemTwister uses a command-first interface: `tandemtwister <command> [options]`.

### 1. Germline Genotyping
Used for standard diploid genotyping from long-read alignments.
```bash
tandemtwister germline \
  --bam input.bam \
  --ref reference.fa \
  --motif_file regions.bed \
  --output_file results.vcf \
  --sample MySample \
  --reads_type CCS \
  --threads 8
```

### 2. Assembly Genotyping
Used when comparing an assembled genome or contigs against a reference.
```bash
tandemtwister assembly \
  --bam assembly_to_ref.bam \
  --ref reference.fa \
  --motif_file regions.bed \
  --output_file assembly_genotypes.txt
```

### 3. Somatic Profiling (Experimental)
Used to identify expansions or contractions in somatic contexts. Note that this mode is currently in testing.

## Command Line Best Practices

### Input Requirements
- **Motif File**: Must be in BED, TSV, or CSV format containing reference coordinates and the repeat motif sequence.
- **Read Types**: Explicitly set `--reads_type` to `CCS`, `CLR`, or `ONT`. This triggers specific error-correction models.
- **Sex Specification**: Use `-s 0` for female and `-s 1` for male to ensure correct handling of sex chromosomes.

### Performance Optimization
- **Multi-threading**: Always utilize the `--threads` (or `-t`) flag for large datasets. The tool scales efficiently up to 32+ threads.
- **Memory Management**: Ensure `htslib` and `libdeflate` are correctly linked (standard in the Bioconda installation) for fast BAM processing.

### Accuracy Tuning
- **Phasing**: If your BAM file is already phased (e.g., via Whatshap), use the `--bamIsTagged` flag to improve haplotyping accuracy.
- **Quality Filtering**: Use `--quality_score` (default 10) to exclude low-quality reads. For high-precision CCS data, consider increasing this threshold.
- **Correction**: For CLR and ONT data, ensure `--correct` is set to `true` (default for these types) to enable interval-based consensus correction.

## Common CLI Patterns

**Quick Test Run:**
Verify installation and input formatting using a single thread and a small subset of regions:
```bash
tandemtwister germline -b test.bam -r ref.fa -m small_regions.bed -o test_out -sn test_sample -t 1
```

**High-Sensitivity ONT Profiling:**
```bash
tandemtwister germline -b ont_data.bam -r hg38.fa -m tr_catalog.bed -rt ONT --correct true -t 16
```



## Subcommands

| Command | Description |
|---------|-------------|
| tandemtwister assembly | Genotyping tandem repeats from aligned genome input. |
| tandemtwister germline | Genotyping tandem repeats from long-read alignments. |
| tandemtwister somatic | Somatic expansion profiling using long-read alignments. |

## Reference documentation
- [TandemTwister README](./references/github_com_Lionward_tandemtwister_blob_main_README.md)
- [Installation and Build Guide](./references/github_com_Lionward_tandemtwister_blob_main_Makefile.md)