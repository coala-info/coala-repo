---
name: pacu_snp
description: PACU is a bioinformatics pipeline for generating phylogenetic trees from Illumina and ONT sequencing data through variant calling and filtering. Use when user asks to map reads to a reference genome, call and filter SNPs, mask recombination regions, or infer phylogenetic relationships.
homepage: https://github.com/BioinformaticsPlatformWIV-ISP/PACU
metadata:
  docker_image: "quay.io/biocontainers/pacu_snp:1.0.0--pyhdfd78af_0"
---

# pacu_snp

## Overview
PACU (Prokaryotic Awesome variant Calling Utility) is a comprehensive bioinformatics workflow for generating phylogenies from raw or mapped sequencing data. It excels at handling multi-platform datasets, allowing users to combine Illumina and ONT reads in a single analysis. The tool automates the complex process of variant calling, filtering out low-quality SNPs, masking recombination events, and inferring phylogenetic relationships using established engines like IQ-TREE or MEGA.

## Installation and Setup
PACU is best managed via Conda or Pixi to handle its extensive dependency list (bcftools, samtools, iqtree, gubbins, etc.).

```bash
# Recommended installation via Pixi
pixi add pacu_snp

# Or via Conda
conda install -c bioconda -c conda-forge pacu_snp
```

## Core CLI Patterns

### 1. Read Mapping (PACU_map)
Before running the SNP workflow, reads must be mapped to a reference genome. PACU provides a helper script for this.

**Illumina (Paired-end):**
```bash
PACU_map --ref-fasta reference.fasta --read-type illumina --fastq-illumina R1.fastq.gz R2.fastq.gz --output sample_mapped.bam --threads 8
```

**ONT (Long-reads):**
```bash
PACU_map --ref-fasta reference.fasta --read-type ont --fastq-ont reads.fastq.gz --output sample_ont_mapped.bam --threads 8
```

### 2. Phylogenetic Workflow (PACU)
Once BAM files are organized into directories, run the main pipeline.

```bash
PACU --ilmn-in ./bam_illumina/ --ont-in ./bam_ont/ --ref-fasta reference.fasta --output ./results/ --threads 16
```

## Expert Tips and Best Practices

### Improving Tree Accuracy
*   **Phage Masking:** Use the `--ref-bed` option to provide a BED file of known phage regions or repetitive elements. PACU will exclude these from the SNP analysis, reducing "noise" caused by horizontal gene transfer.
*   **Recombination Filtering:** By default, PACU runs Gubbins to detect and mask recombinant regions. If you are analyzing extremely divergent samples where recombination detection is not applicable, use `--skip-gubbins`.
*   **Reference Inclusion:** Use `--include-ref` to see exactly where the reference genome sits on the tree relative to your isolates.

### Variant Filtering Heuristics
*   **Allele Frequency:** The default `--min-snp-af` is usually sufficient, but for samples with potential contamination or mixed populations, increasing this value (e.g., to 0.9) ensures only fixed mutations are used.
*   **Global Depth:** Use `--min-global-depth` to ensure that a position is only considered if *all* samples have sufficient coverage there. This prevents false-positive SNP calls in low-coverage regions.
*   **SNP Density:** If you notice clusters of SNPs that might indicate poorly mapped regions, increase `--min-snp-dist` (default is often 0) to filter out SNPs that are too close to each other.

### Performance and Output
*   **Phylogeny Engine:** IQ-TREE is the default and generally recommended for its speed and accuracy. Only use `--use-mega` if you have a specific requirement for MEGA10 and have it manually installed in your PATH.
*   **Visualization:** The workflow generates an HTML report (`--output-html`). This is the fastest way to perform initial QA on mapping statistics and tree topology.



## Subcommands

| Command | Description |
|---------|-------------|
| PACU | PACU SNP analysis pipeline |
| PACU_map | Map sequencing reads to a reference genome. |

## Reference documentation
- [PACU README](./references/github_com_BioinformaticsPlatformWIV-ISP_PACU_blob_main_README.md)
- [PACU Project Configuration](./references/github_com_BioinformaticsPlatformWIV-ISP_PACU_blob_main_pyproject.toml.md)