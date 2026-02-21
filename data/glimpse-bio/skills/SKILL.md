---
name: glimpse-bio
description: GLIMPSE2 is a specialized suite of tools designed for population-scale genetics.
homepage: https://odelaneau.github.io/GLIMPSE/
---

# glimpse-bio

## Overview
GLIMPSE2 is a specialized suite of tools designed for population-scale genetics. It excels at "imputation-from-reads," allowing researchers to infer missing genotypes and phase haplotypes directly from low-coverage data (often <1x coverage) by leveraging large reference panels (e.g., UK Biobank). The workflow typically involves defining genomic chunks, preparing a binary reference panel, performing the actual phasing/imputation, and ligating the results back into chromosome-wide files.

## Core Workflow and CLI Patterns

### 1. Chunking the Genome
Before processing, the chromosome must be split into manageable windows with overlapping buffers to ensure consistency across boundaries.

```bash
GLIMPSE2_chunk --input target_chr20.bcf \
               --map chr20.gmap.gz \
               --region chr20 \
               --sequential \
               --output chunks_chr20.txt
```
*   **Best Practice**: Use `--sequential` for most standard WGS/WES datasets.
*   **Parameters**: `--window-cm` (default 4.0) and `--buffer-cm` (default 0.5) control the size of the imputation windows and their overlaps.

### 2. Preparing the Reference Panel
GLIMPSE2 uses a specific binary format for the reference panel to minimize memory usage and speed up loading.

```bash
GLIMPSE2_split_reference --reference reference_panel.bcf \
                         --map chr20.gmap.gz \
                         --input-region chr20:7702567-12266861 \
                         --output-region chr20:7952603-12016861 \
                         --output binary_reference_panel
```
*   **Note**: The `input-region` should include the buffer, while `output-region` is the core window defined in the chunking step.

### 3. Phasing and Imputation
This is the main computational step. It can take BAM/CRAM files directly or VCF files containing genotype likelihoods (GL).

**From BAM/CRAM list:**
```bash
GLIMPSE2_phase --bam-list bams.txt \
               --reference binary_reference_panel_chr20.bin \
               --map chr20.gmap.gz \
               --input-region chr20:7702567-12266861 \
               --output-region chr20:7952603-12016861 \
               --output imputed_chunk.bcf \
               --threads 8
```

**From Genotype Likelihoods (VCF):**
```bash
GLIMPSE2_phase --input-gl target_gls.vcf.gz \
               --reference binary_reference_panel_chr20.bin \
               --output imputed_chunk.bcf
```

### 4. Ligation
After all chunks for a chromosome are processed, ligate them to restore the full chromosome phase.

```bash
# Create a list of files in genomic order
ls -1v chr20/*.imputed.bcf > list_chunks.txt

GLIMPSE2_ligate --input list_chunks.txt \
                --output ligated_chr20.bcf
```

## Expert Tips
*   **Memory Management**: Always use the binary reference format (`split_reference`) when working with large panels (thousands of samples) to avoid massive RAM consumption.
*   **CRAM Files**: When using CRAM input, you must provide the reference genome fasta using `-F` or `--fasta`.
*   **Ploidy**: For sex chromosomes, use `--samples-file` to specify ploidy (1 for males on X/Y, 2 for females on X). GLIMPSE assumes diploid (2) by default.
*   **Rare Variants**: The `--sparse-maf` parameter (default 0.001) is an expert setting that controls the threshold for rare variant handling in the model.

## Reference documentation
- [GLIMPSE2 Home](./references/odelaneau_github_io_GLIMPSE.md)
- [Chunking Documentation](./references/odelaneau_github_io_GLIMPSE_docs_documentation_chunk.md)
- [Phasing Documentation](./references/odelaneau_github_io_GLIMPSE_docs_documentation_phase.md)
- [Ligation Documentation](./references/odelaneau_github_io_GLIMPSE_docs_documentation_ligate.md)
- [Split Reference Documentation](./references/odelaneau_github_io_GLIMPSE_docs_documentation_split_reference.md)