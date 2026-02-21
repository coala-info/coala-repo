---
name: lrtk
description: LRTK is a unified platform for processing linked-read data from both human genomes and metagenomes.
homepage: https://github.com/ericcombiolab/LRTK
---

# lrtk

## Overview
LRTK is a unified platform for processing linked-read data from both human genomes and metagenomes. This skill assists in executing the end-to-end workflow—from raw FASTQ processing and barcode-aware alignment to downstream genomic variant detection and phasing. It is particularly useful for researchers working with long-fragment information derived from short-read sequencing technologies.

## Core Commands and Workflows

### 1. Data Preparation and Simulation
*   **Simulation (MKFQ):** Generate synthetic linked-reads for testing.
    `lrtk MKFQ -CF <config_dir> -IT <10x|stLFR>`
*   **Barcode Correction (FQCONVER):** Standardize FASTQ formats across different platforms.
    `lrtk FQCONVER -I1 <R1.fq> -I2 <R2.fq> -IT <10x|stLFR|TELLSeq> -O1 <out1.fq> -O2 <out2.fq> [-B <whitelist>]`
    *   *Note:* TELL-Seq requires an index file (`-ID`).

### 2. Alignment and Fragment Reconstruction
*   **Barcode-Aware Alignment (ALIGN):** Map reads while preserving barcode information.
    `lrtk ALIGN -FQ1 <R1.fq> -FQ2 <R2.fq> -R <ref.fa> -O <out.bam> -RG "@RG\tID:ID\tSM:Sample" -P <platform> -A <ema|lariat>`
*   **Fragment Reconstruction (RLF):** Identify the original long DNA fragments from the alignment.
    `lrtk RLF -B <in.bam> -D <distance_threshold> -O <fragments.txt>`
    *   *Tip:* The default distance (`-D`) is often 200,000 bp.

### 3. Variant Analysis
*   **Small Variant Calling (SNV):** Detect SNVs and INDELs.
    `lrtk SNV -B <in.bam> -R <ref.fa> -A <FreeBayes|Samtools|GATK> -O <out.vcf>`
*   **Structural Variation (SV):** Detect large-scale variations.
    `lrtk SV -B <in.bam> -R <ref.fa> -A <Aquila|LinkedSV|VALOR2> -O <out.vcf>`
*   **Phasing (PHASE):** Phase germline variations into haplotypes.
    `lrtk PHASE -V <in.vcf> -B <in.bam> -R <ref.fa> -O <phased.vcf>`

### 4. Metagenomics and Pipelines
*   **Metagenome Assembly (ASSEMBLY):** Perform read-cloud based assembly.
    `lrtk ASSEMBLY -FQ1 <R1.fq> -FQ2 <R2.fq> -O <out_dir>`
*   **Automated Pipelines:** Use `WGS` for human genome analysis or `MWGS` for metagenome analysis to run the full pipeline from raw data to variants.

## Expert Tips
*   **Platform Specifics:** Always specify the correct platform (`-IT` or `-P`) as barcode structures differ significantly between 10x, stLFR, and TELL-Seq.
*   **Dependencies:** Ensure external tools like `Aquila`, `LinkedSV`, or `VALOR2` are installed manually if they are not included in the base Bioconda environment.
*   **Reference Data:** Use the recommended GRCh38 reference for human data to ensure compatibility with barcode-aware aligners.

## Reference documentation
- [LRTK GitHub Repository](./references/github_com_ericcombiolab_LRTK.md)
- [LRTK Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_lrtk_overview.md)