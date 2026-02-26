---
name: snpsplit
description: "SNPsplit sorts aligned reads into allele-specific categories based on known SNP positions. Use when user asks to categorize reads into genome-specific groups, perform allele-specific sorting, or prepare N-masked reference genomes for bioinformatics pipelines."
homepage: https://www.bioinformatics.babraham.ac.uk/projects/SNPsplit/
---


# snpsplit

## Overview
SNPsplit is a specialized tool for allele-specific bioinformatics pipelines. It processes alignment files to categorize reads into three groups: Genome 1-specific, Genome 2-specific, or Unassigned. This is essential for studying genomic imprinting, allelic expression bias, or homologous chromosome interactions. The tool requires reads to be aligned to an "N-masked" reference genome where SNP positions are replaced with the ambiguity code 'N'.

## Core Workflow

### 1. Genome Preparation
Before alignment, you must prepare the N-masked genome and a SNP annotation file.
```bash
SNPsplit_genome_preparation --vcf_file all_snps.vcf.gz --reference_genome /path/to/GRCm38/ --strain CAST_EiJ
```
*   **Dual Hybrid Mode:** Use `--dual_hybrid` if neither strain is the reference (e.g., 129S1 vs CAST_EiJ).
*   **Output:** Generates an N-masked FASTA file and a `.txt.gz` SNP file required for the sorting step.

### 2. Allele-Specific Sorting
After aligning your reads to the N-masked genome using an N-aware aligner (like Bowtie2, STAR, or HISAT2), run SNPsplit:

**Standard SE/PE Sorting:**
```bash
SNPsplit --snp_file all_SNPs_CAST_EiJ_GRCm38.txt.gz input_file.bam
```

**Bisulfite-Seq (Bismark) Sorting:**
```bash
SNPsplit --bisulfite --snp_file all_SNPs_CAST_EiJ_GRCm38.txt.gz bismark_alignment.bam
```

## Expert Tips and Best Practices
*   **Aligner Choice:** Only use aligners that handle 'N' characters correctly. Bowtie2 is the recommended default.
*   **CIGAR Support:** SNPsplit handles M (match), D (deletion), I (insertion), and N (skipped regions/splicing). Ensure your aligner doesn't produce unsupported CIGAR operations that might lead to skipped reads.
*   **Memory Management:** For very large BAM files, ensure `samtools` is in your PATH, as SNPsplit relies on it for efficient stream processing and sorting.
*   **Chromosome Naming:** A common failure point is a mismatch between VCF chromosome names (e.g., "1") and genome FASTA names (e.g., "chr1"). Use `SNPsplit_genome_preparation` to validate these before starting long alignment runs.
*   **Paired-End Data:** SNPsplit automatically detects PE files. If your BAM is not positionally sorted, use the `--no_sort` flag to save time, though sorting is generally recommended for downstream analysis.

## Reference documentation
- [Babraham Bioinformatics - SNPsplit Project Page](./references/www_bioinformatics_babraham_ac_uk_projects_SNPsplit.md)
- [SNPsplit Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_snpsplit_overview.md)