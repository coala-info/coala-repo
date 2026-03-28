---
name: glimpse-bio
description: GLIMPSE2 recovers high-density genotype and haplotype information from low-coverage sequencing data. Use when user asks to impute genotypes, phase haplotypes, define imputation chunks, prepare binary reference panels, or ligate processed genomic chunks.
homepage: https://odelaneau.github.io/GLIMPSE/
---

# glimpse-bio

## Overview

GLIMPSE2 (Genotype Likelihoods IMputation and PhaSing mEthod) is a specialized suite of tools designed to recover high-density genotype and haplotype information from low-coverage sequencing data. It is particularly optimized for modern reference panels containing hundreds of thousands of samples and excels at imputing rare variants. 

The toolset follows a modular workflow:
1. **Chunking**: Dividing chromosomes into manageable overlapping windows.
2. **Reference Splitting**: Converting reference panels into a fast-loading binary format for specific windows.
3. **Phasing**: The core HMM-based imputation engine.
4. **Ligation**: Stitching phased chunks back into a single chromosome-wide file.

## Core Workflow and CLI Patterns

### 1. Defining Imputation Chunks
Use `GLIMPSE2_chunk` to define regions. Providing a genetic map is highly recommended for accurate window placement.

```bash
GLIMPSE2_chunk --input reference_sites.vcf.gz \
               --region chr22 \
               --sequential \
               --map genetic_map_chr22.gmap.gz \
               --output chunks_chr22.txt
```
*   **Expert Tip**: Use `--sequential` (recommended) to ensure windows are balanced by variant count or genetic distance.

### 2. Preparing Binary Reference Panels
`GLIMPSE2_split_reference` converts a standard VCF/BCF reference panel into a binary format (`.bin`) that `GLIMPSE2_phase` can load near-instantaneously.

```bash
GLIMPSE2_split_reference --reference reference_panel.bcf \
                         --map genetic_map_chr22.gmap.gz \
                         --input-region chr22:10000-20000 \
                         --output-region chr22:12000-18000 \
                         --output bin_ref_prefix
```
*   **Note**: The `input-region` includes the buffer, while `output-region` is the target imputation window.

### 3. Imputation and Phasing
`GLIMPSE2_phase` is the primary tool. It can take BAM/CRAM files directly or VCF files containing genotype likelihoods (GL).

**Directly from BAM:**
```bash
GLIMPSE2_phase --bam-file sample.bam \
               --reference bin_ref_chr22_chunk1.bin \
               --output sample_imputed_chunk1.bcf \
               --threads 4
```

**From Genotype Likelihoods (VCF):**
```bash
GLIMPSE2_phase --input-gl sample_gls.vcf.gz \
               --reference bin_ref_chr22_chunk1.bin \
               --output sample_imputed_chunk1.bcf
```

### 4. Ligating Chunks
After all chunks for a chromosome are processed, use `GLIMPSE2_ligate` to merge them.

```bash
# Create a list of files in genomic order
ls -1v *_chunk*.bcf > chunk_list.txt

GLIMPSE2_ligate --input chunk_list.txt \
                --output sample_chr22_final.bcf
```

## Expert Parameters and Best Practices

### Handling Ploidy
For sex chromosomes or haploid organisms, use a samples file to specify ploidy:
*   `--samples-file ploidy_info.txt` (Format: `SampleID [1 or 2]`)
*   GLIMPSE2 does not automatically infer sex from BAM headers; ploidy must be explicit.

### Rare Variant Settings
*   `--sparse-maf [float]`: Sets the threshold for rare variants (default 0.001). Adjust this if working with extremely large reference panels where rare variant density is high.

### Input Optimization
*   **BCF over VCF**: Always prefer BCF format for reference panels and intermediate files to significantly reduce I/O overhead.
*   **CRAM Requirements**: When using CRAM input, you must provide the reference genome fasta using `-F` or `--fasta`.

### Quality Control
Use `GLIMPSE2_concordance` to validate imputation accuracy if you have high-coverage "truth" data for a subset of samples.
*   Requires a file listing: `region`, `frequencies`, `validation_vcf`, and `imputed_vcf`.
*   Use `--min-val-dp` to filter validation sites by depth to ensure the "truth" set is reliable.



## Subcommands

| Command | Description |
|---------|-------------|
| glimpse-bio_GLIMPSE2_chunk | Split chromosomes into chunks |
| glimpse-bio_GLIMPSE2_ligate | Ligate multiple output files into chromosome-wide files |
| glimpse-bio_GLIMPSE2_phase | [GLIMPSE2] Phase and impute low coverage sequencing data |
| glimpse-bio_GLIMPSE2_split_reference | Split reference panel into binary GLIMPSE2 files |

## Reference documentation
- [GLIMPSE2 Documentation Overview](./references/odelaneau_github_io_GLIMPSE_docs_documentation.md)
- [GLIMPSE2_chunk Manual](./references/odelaneau_github_io_GLIMPSE_docs_documentation_chunk.md)
- [GLIMPSE2_phase Manual](./references/odelaneau_github_io_GLIMPSE_docs_documentation_phase.md)
- [GLIMPSE2_split_reference Manual](./references/odelaneau_github_io_GLIMPSE_docs_documentation_split_reference.md)
- [GLIMPSE2_ligate Manual](./references/odelaneau_github_io_GLIMPSE_docs_documentation_ligate.md)
- [Tutorial: Getting Started](./references/odelaneau_github_io_GLIMPSE_docs_tutorials_getting_started.md)