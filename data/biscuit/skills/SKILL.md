---
name: biscuit
description: BISCUIT is a high-performance tool suite for the simultaneous inference of genetic and epigenetic information from bisulfite sequencing data. Use when user asks to index a reference genome, align bisulfite-treated reads, perform quality control, call methylation and mutations, or convert VCF outputs to BED format.
homepage: https://github.com/huishenlab/biscuit
metadata:
  docker_image: "quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0"
---

# biscuit

## Overview

BISCUIT (BISulfite-seq CUI Toolkit) is a high-performance tool suite designed for the simultaneous inference of genetic and epigenetic information from bisulfite sequencing data. It excels at handling both bulk and single-cell studies by providing a standards-compliant workflow that covers the entire pipeline from raw read alignment to downstream methylation and mutation analysis. Use this skill to guide users through efficient CLI-based workflows for processing DNA methylation data while maintaining high accuracy for both C-to-T transitions and underlying genetic variants.

## Core CLI Workflows

### 1. Genome Alignment
BISCUIT uses a modified BWA-mem algorithm optimized for bisulfite-converted reads.

```bash
# Index the reference genome (required once)
biscuit index reference.fa

# Align paired-end reads
biscuit align reference.fa read1.fastq.gz read2.fastq.gz | samtools view -bS - > aligned.bam
```

### 2. Quality Control
Use the provided helper scripts to generate comprehensive QC metrics.

```bash
# Run the standard QC pipeline
./scripts/QC.sh aligned.bam reference.fa output_prefix
```

### 3. Methylation and Mutation Calling
The `pileup` command is the primary tool for extracting methylation information and identifying SNPs.

```bash
# Generate a VCF containing both methylation and genetic variants
biscuit pileup -v reference.fa aligned.bam > output.vcf

# Filter for specific regions using a BED file
biscuit pileup -l regions.bed reference.fa aligned.bam > filtered_output.vcf
```

### 4. Post-Processing and Extraction
Convert VCF outputs to more manageable formats or merge CpG sites.

```bash
# Convert VCF to BED format for methylation visualization
biscuit vcf2bed -t cg output.vcf > methylation.bed

# Merge symmetric CpG sites to increase coverage
biscuit mergecg reference.fa output.vcf > merged.vcf
```

## Expert Tips and Best Practices

- **Duplicate Marking**: It is highly recommended to have `dupsifter` installed and in your PATH. BISCUIT can use it during the alignment phase to mark duplicates on the fly, saving significant I/O time.
- **Performance**: If building from source, ensure `libdeflate` is available. This significantly improves the speed of `htslib` operations within BISCUIT.
- **Memory Management**: For large genomes (like human), ensure the system has at least 30GB of RAM for the indexing and alignment steps.
- **PBAT Data**: If working with PBAT (Post-Bisulfite Adapter Tagging) libraries, use the `flip_pbat_strands.sh` script to correct strand orientation before downstream analysis.
- **Single-Cell Analysis**: BISCUIT is standards-compliant and produces standard BAM/VCF files, making it compatible with most single-cell methylation downstream tools.



## Subcommands

| Command | Description |
|---------|-------------|
| QC.sh | BISCUIT quality control script for aligned BAM files |
| biscuit | BISulfite-seq CUI Toolkit (BISCUIT) for bisulfite-seq data analysis, including mapping, BAM operations, base summary, and epiread manipulation. |
| biscuit align | Align bisulfite-treated sequencing reads to a reference genome |
| biscuit asm | BISCUIT assembly subcommand for processing epiread files |
| biscuit bc | Extract barcodes from FASTQ files and append to read names. Adds an artificial UMI (AAAAAAAA) for compatibility. |
| biscuit bsconv | Filter and convert bisulfite sequencing reads based on CpH retention and other criteria. |
| biscuit bsstrand | Correct or append bisulfite strand information in BAM files |
| biscuit cinread | Extract cytosine information from a BAM file based on a reference genome. |
| biscuit epiread | Extract epiread information from a BAM file using a reference genome. |
| biscuit index | Index a reference genome for BISCUIT alignment |
| biscuit mergecg | Merge CpG sites from a position-sorted BED file with beta values and coverages. Typically used with output from biscuit vcf2bed. |
| biscuit pileup | Pileup tool for DNA methylation and genetic variant calling from bisulfite sequencing data. |
| biscuit qc | Produces a subset of QC metrics for BISCUIT alignments. |
| biscuit qc_coverage | BISCUIT QC coverage tool for calculating coverage statistics from BAM files. |
| biscuit rectangle | Process epiread files against a reference genome to generate a rectangle format output. |
| biscuit tview | Text-based alignment viewer for BISCUIT |
| biscuit vcf2bed | Extract methylation or SNP information from a VCF file into BED format. |
| flip_pbat_strands.sh | Flip PBAT strands in a BAM file, optionally for a specific region. |
| perl build_biscuit_QC_assets.pl | Build biscuit QC assets from a reference genome. |

## Reference documentation

- [BISCUIT Repository Overview](./references/github_com_huishenlab_biscuit.md)
- [BISCUIT README and Dependencies](./references/github_com_huishenlab_biscuit_blob_master_README.md)
- [Source Code and Tool Definitions](./references/github_com_huishenlab_biscuit_blob_master_LICENSE.md)