---
name: manta
description: Manta identifies structural variants and indels from paired-end sequencing reads using an integrated discovery, assembly, and scoring workflow. Use when user asks to detect large-scale structural variants, call germline or somatic indels, or analyze genomic rearrangements in tumor-normal pairs.
homepage: https://github.com/Illumina/manta
---


# manta

## Overview
Manta is a specialized tool designed to identify structural variants and indels from paired-end sequencing reads. It integrates discovery, assembly, and scoring into a single efficient workflow, making it one of the fastest SV callers available for standard compute hardware. It is highly effective for detecting large-scale SVs, medium-sized indels, and large insertions. Manta is optimized for both germline variation and cancer applications, providing specific scoring models for diploid germline samples and matched tumor/normal pairs.

## Core Workflow
Manta operates in two distinct stages: a configuration step that generates a workflow script, and an execution step that runs the actual analysis.

### 1. Configuration Stage
Use `configManta.py` to define your input files, reference genome, and analysis type. This script creates an output directory containing a `runWorkflow.py` script.

**Germline Analysis:**
```bash
configManta.py \
    --bam sample1.bam \
    --bam sample2.bam \
    --referenceFasta genome.fa \
    --runDir ./manta_germline_output
```

**Somatic (Tumor/Normal) Analysis:**
```bash
configManta.py \
    --normalBam normal.bam \
    --tumorBam tumor.bam \
    --referenceFasta genome.fa \
    --runDir ./manta_somatic_output
```

### 2. Execution Stage
Navigate to the output directory and execute the generated Python script.

```bash
python ./manta_output/runWorkflow.py -m local -j 20
```
*   `-m local`: Runs the workflow on the local machine.
*   `-j <int>`: Specifies the number of parallel threads/cores to use.

## Common CLI Options
*   `--exome`: Essential for Whole Exome Sequencing (WES) or other targeted capture data. It adjusts depth filters that would otherwise discard high-coverage regions.
*   `--callRegions <BED.gz>`: Limits analysis to specific genomic regions. The BED file must be tabix-indexed (e.g., `regions.bed.gz.tbi`).
*   `--referenceFasta`: Path to the reference genome FASTA file. The file must be indexed (`.fai`).

## Expert Tips and Best Practices
*   **Input Requirements**: All input BAM or CRAM files must be coordinate-sorted and indexed.
*   **Memory Management**: Manta is designed for speed but can be memory-intensive. If running on a cluster, ensure memory allocation scales with the number of threads (`-j`).
*   **VCF Outputs**: Manta produces several VCF files in the `results/variants` directory:
    *   `candidateSV.vcf.gz`: All SV candidates before final scoring.
    *   `diploidSV.vcf.gz`: Scored germline variants.
    *   `somaticSV.vcf.gz`: Scored somatic variants (in tumor/normal mode).
*   **Small Indels**: While Manta calls indels, it is often used in conjunction with a dedicated small variant caller (like Strelka2) for a comprehensive variant profile.
*   **Unmatched Tumors**: For tumor samples without a matched normal, Manta has experimental support. Use the `--tumorBam` flag without a `--normalBam` flag during configuration.

## Reference documentation
- [Manta Structural Variant Caller](./references/github_com_Illumina_manta.md)
- [Manta Issues and CLI usage notes](./references/github_com_Illumina_manta_issues.md)
- [Bioconda Manta Overview](./references/anaconda_org_channels_bioconda_packages_manta_overview.md)