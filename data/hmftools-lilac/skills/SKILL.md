---
name: hmftools-lilac
description: hmftools-lilac performs high-resolution HLA Class I typing and detects somatic mutations or Loss of Heterozygosity within the HLA region using whole genome sequencing data. Use when user asks to determine 4-digit HLA genotypes, detect HLA Loss of Heterozygosity, or analyze tumor-immune interactions in genomic data.
homepage: https://github.com/hartwigmedical/hmftools/blob/master/lilac/README.md
---


# hmftools-lilac

## Overview
LILAC is a specialized tool developed by the Hartwig Medical Foundation for high-resolution HLA Class I typing. It is designed to work with Whole Genome Sequencing (WGS) data to provide accurate 4-digit HLA genotypes. Beyond simple typing, LILAC is uniquely capable of detecting somatic mutations and Loss of Heterozygosity (LOH) within the HLA region, which are critical factors in understanding tumor-immune interactions and immunotherapy response.

## Common CLI Patterns

### Basic HLA Typing
To run LILAC for a single sample to determine HLA types:

```bash
java -jar lilac.jar \
    -sample <SAMPLE_NAME> \
    -reference <REF_GENOME_FASTA> \
    -bam <INPUT_BAM> \
    -output_dir <OUTPUT_DIRECTORY> \
    -resource_dir <LILAC_RESOURCES_DIR>
```

### Tumor-Normal Analysis (LOH Detection)
When analyzing paired cancer samples to detect HLA LOH, provide both BAM files:

```bash
java -jar lilac.jar \
    -sample <TUMOR_SAMPLE_NAME> \
    -reference <REF_GENOME_FASTA> \
    -tumor_bam <TUMOR_BAM> \
    -reference_bam <NORMAL_BAM> \
    -output_dir <OUTPUT_DIRECTORY> \
    -resource_dir <LILAC_RESOURCES_DIR>
```

## Expert Tips and Best Practices

- **Resource Directory**: LILAC requires a specific resource directory containing HLA allele sequences and frequency data. Ensure this is correctly downloaded from the Hartwig Medical Foundation repository before running.
- **Memory Allocation**: As a Java-based tool processing large BAM files, ensure sufficient heap space is allocated (e.g., `-Xmx8g` or higher depending on coverage).
- **Input Requirements**: LILAC expects coordinate-sorted and indexed BAM or CRAM files.
- **Output Interpretation**:
    - `.lilac.json`: Contains the primary HLA typing results and LOH status.
    - `.lilac.png`: Provides a visual representation of the HLA locus coverage and B-allele frequency (BAF) to support LOH calls.
- **HLA-A, B, C Focus**: Note that LILAC is optimized for Class I genes. While it provides high accuracy for these, it is not intended for Class II (DR/DQ/DP) typing.

## Reference documentation
- [LILAC Overview](./references/anaconda_org_channels_bioconda_packages_hmftools-lilac_overview.md)
- [LILAC README](./references/github_com_hartwigmedical_hmftools_blob_master_lilac_README.md)