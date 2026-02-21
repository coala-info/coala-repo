---
name: secapr
description: SECAPR (SEquence CApture PRocessor) is a specialized bioinformatic pipeline designed to transform raw FASTQ data from sequence capture protocols into phylogenetically informative alignments.
homepage: https://github.com/AntonelliLab/seqcap_processor
---

# secapr

## Overview

SECAPR (SEquence CApture PRocessor) is a specialized bioinformatic pipeline designed to transform raw FASTQ data from sequence capture protocols into phylogenetically informative alignments. It automates the transition from raw reads to final datasets by integrating quality control, de novo assembly, and target locus identification. A key strength of the tool is its ability to handle diploid data through allele phasing, which provides a more accurate representation of genetic variation for downstream phylogenetic and phylogenomic analyses.

## Installation and Environment

The most reliable way to use secapr is through a dedicated Conda environment to manage its numerous third-party dependencies.

```bash
# Create and activate a dedicated environment
conda create -n secapr_env bioconda::secapr
conda activate secapr_env
```

**Note for Apple Silicon (M1/M2) Users:**
If you encounter compatibility issues on newer macOS hardware, force the environment to use the `osx-64` architecture:
```bash
conda activate secapr_env
conda config --env --set subdir osx-64
```

## Core Workflow Commands

The pipeline is modular. You can run individual steps or the full workflow. Use `secapr <command> -h` for detailed parameter descriptions.

### 1. Quality Control and Trimming
Clean raw reads by removing adapters and low-quality sequences.
```bash
secapr clean_reads --input path/to/raw_fastq --output path/to/cleaned_reads
```

### 2. De Novo Assembly
Assemble the cleaned reads into contigs for each sample.
```bash
secapr assemble_reads --input path/to/cleaned_reads --output path/to/assembled_contigs --assembler trinity
```

### 3. Target Identification
Identify which assembled contigs match your target enrichment probes (reference library).
```bash
secapr find_target_contigs --contigs path/to/assembled_contigs --reference probes.fasta --output path/to/target_contigs
```

### 4. Locus Selection and Alignment
Extract the identified sequences and align them across samples.
```bash
secapr locus_selection --input path/to/target_contigs --output path/to/selected_loci
secapr align_sequences --input path/to/selected_loci --output path/to/alignments
```

### 5. Allele Phasing
Map reads back to the assembled contigs to identify heterozygous sites and phase alleles.
```bash
secapr reference_assembly --reads path/to/cleaned_reads --reference path/to/selected_loci --output path/to/mapped_reads
secapr phase_alleles --input path/to/mapped_reads --output path/to/phased_alleles
```

## Expert Tips and Best Practices

- **Resource Management**: Assembly (`assemble_reads`) and mapping are computationally intensive. Always use the `--cores` flag to utilize multi-threading where available.
- **Input Organization**: Ensure your FASTQ files follow a consistent naming convention (e.g., `SampleName_R1.fastq.gz`) as secapr relies on pattern matching to pair reads.
- **Validation**: Always run `secapr quality_check` on your raw data before starting the pipeline to identify potential library prep issues.
- **Paralog Detection**: Pay close attention to the output of `find_target_contigs`. If multiple contigs match a single reference probe with high similarity, it may indicate a paralogous locus that should be excluded from phylogenetic analysis.
- **Phasing Benefits**: For samples with high heterozygosity, always perform the phasing step. Using consensus sequences (which collapse heterozygotes into ambiguity codes) can lead to "branch length attraction" artifacts in phylogeny.

## Reference documentation
- [SECAPR Main Repository](./references/github_com_AntonelliLab_seqcap_processor.md)
- [SECAPR Workflow Documentation](./references/github_com_AntonelliLab_seqcap_processor_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_secapr_overview.md)