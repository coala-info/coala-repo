---
name: sequenza-utils
description: sequenza-utils provides a Python-based command-line interface to preprocess genomic data into the compressed seqz format required for copy number analysis. Use when user asks to generate GC-content wiggle files, convert BAM or VCF files to seqz format, or perform binning and merging of seqz files.
homepage: http://sequenza-utils.readthedocs.org
metadata:
  docker_image: "quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8"
---

# sequenza-utils

## Overview
The `sequenza-utils` suite acts as the primary data preprocessing bridge between raw sequencing outputs and the Sequenza R analysis framework. It provides a Python-based CLI to transform large genomic files into a compressed, binned format (seqz) that represents the depth of coverage and allele frequencies. This skill helps you navigate the multi-step workflow of preparing tumor-normal pairs for copy number analysis, ensuring correct parameter selection for genotype filtering and GC-content normalization.

## Core Workflows

### 1. Reference Preparation (GC Content)
Before processing samples, you must generate a GC-content wiggle file for the reference genome. This is used to normalize depth-ratio calculations.
- **Command**: `sequenza-utils gc_wiggle -f reference.fasta -w 50 -o reference_gc50.wig.gz`
- **Tip**: Match the window size (`-w`) to your intended binning size (commonly 50).

### 2. Generating Seqz Files
The primary goal is to create a `.seqz` file from tumor and normal samples.

**From BAM Files (Recommended):**
Requires `samtools` and the reference FASTA.
```bash
sequenza-utils bam2seqz -n normal.bam -t tumor.bam -gc reference_gc50.wig.gz -F reference.fasta -o sample.seqz.gz
```

**From VCF Files:**
Useful if you already have variant calls. Use `--preset` for specific callers.
```bash
sequenza-utils snp2seqz -v variants.vcf.gz -gc reference_gc50.wig.gz --preset mutect -o sample.seqz.gz
```

### 3. Post-Processing and Optimization
Raw seqz files are often too large for R to process efficiently.

- **Binning**: Always perform binning to reduce memory footprint.
  `sequenza-utils seqz_binning -s sample.seqz.gz -w 50 -o sample_binned.seqz.gz`
- **Merging**: If chromosomes were processed separately, merge them.
  `sequenza-utils seqz_merge -1 part1.seqz.gz -2 part2.seqz.gz -o merged.seqz.gz`

## Expert Tips & Best Practices
- **Compression**: Always use the `.gz` extension in your output filenames; `sequenza-utils` detects this and applies gzip compression automatically.
- **Genotype Thresholds**: 
  - Use `--hom` (default 0.9) to adjust the threshold for homozygous positions.
  - Use `--het` (default 0.25) to adjust the threshold for heterozygous positions.
- **Parallelization**: For large genomes, use the `-C` flag to process specific chromosomes or regions individually, then merge.
- **Quality Filtering**: Use `-q` (default 20) to set the minimum nucleotide quality score. If using older Illumina data, ensure you set `-f illumina` to handle the quality offset correctly.
- **External Dependencies**: Ensure `samtools` and `tabix` are in your system PATH, as `sequenza-utils` calls these binaries for indexing and pileup generation.



## Subcommands

| Command | Description |
|---------|-------------|
| sequenza-utils bam2seqz | Convert BAM files to Sequenza's .seqz format. |
| sequenza-utils gc_wiggle | Generates a wiggle file with GC content information for each bin. |
| sequenza-utils pileup2acgt | Converts a pileup file to ACGT format. |
| sequenza-utils seqz_binning | Binning of the genome based on allele frequencies. |
| sequenza-utils seqz_merge | Merge multiple Sequenza .seqz files into a single file. |
| sequenza-utils snp2seqz | Convert SNP-calling results to seqz format |

## Reference documentation
- [Command line interface](./references/sequenza-utils_readthedocs_io_en_latest_commands.html.md)
- [User cookbook](./references/sequenza-utils_readthedocs_io_en_latest_guide.html.md)
- [API library interface](./references/sequenza-utils_readthedocs_io_en_latest_api.html.md)