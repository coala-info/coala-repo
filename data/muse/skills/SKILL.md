---
name: muse
description: MuSE (Mutation Somatic Evolution) is a specialized tool designed to identify somatic point mutations by accounting for tumor heterogeneity through a sample-specific error model.
homepage: http://bioinformatics.mdanderson.org/main/MuSE
---

# muse

## Overview
MuSE (Mutation Somatic Evolution) is a specialized tool designed to identify somatic point mutations by accounting for tumor heterogeneity through a sample-specific error model. It is optimized for speed and accuracy, particularly in version 2.0 which utilizes multi-core parallel computing. The workflow requires indexed reference genomes, tumor-normal BAM pairs processed according to GATK Best Practices, and a dbSNP VCF file.

## Usage Patterns

### Step 1: MuSE call
The first step calculates the post-probability of all possible site-specific substitution types.

```bash
./MuSE call -f <reference.fa> \
            -O <output_prefix> \
            -n <threads> \
            <tumor.bam> <normal.bam>
```

**Best Practices:**
- **Input Prep**: Ensure BAM files are marked for duplicates, jointly realigned, and base quality scores are recalibrated (BQSR) following GATK Best Practices.
- **Reference**: The reference FASTA must be indexed (`samtools faidx`).
- **Parallelization**: Use the `-n` flag to specify CPU cores. MuSE 2.0 scales efficiently; 80 cores can process WES in ~5 minutes and WGS in ~50 minutes.

### Step 2: MuSE sump
The second step applies the sample-specific error model to convert the preliminary output into a final VCF.

**For Whole-Exome Sequencing (WES):**
```bash
./MuSE sump -I <output_prefix>.MuSE.txt \
            -O <output.vcf> \
            -E \
            -n <threads> \
            -D <dbsnp.vcf.gz>
```

**For Whole-Genome Sequencing (WGS):**
```bash
./MuSE sump -I <output_prefix>.MuSE.txt \
            -O <output.vcf> \
            -G \
            -n <threads> \
            -D <dbsnp.vcf.gz>
```

**Critical Parameters:**
- **-E**: Use this flag specifically for WES data.
- **-G**: Use this flag specifically for WGS data.
- **-D**: The dbSNP VCF must be bgzip compressed and tabix indexed. It must also use the same reference genome build as the input BAMs.

## Troubleshooting and Tips
- **Platform Support**: MuSE 2.0 is natively supported on Linux (requires gcc >= 7.0). For macOS users, MuSE 1.0 is the last supported version.
- **Memory**: MuSE 2.0 features improved memory allocation over 1.0, making it suitable for high-depth WGS on standard HPC nodes.
- **Output Interpretation**: The final VCF contains the somatic variants. Ensure you check the filter column for PASS variants to identify high-confidence mutations.

## Reference documentation
- [MuSE Overview and Documentation](./references/bioinformatics_mdanderson_org_public-software_muse.md)
- [Bioconda MuSE Package Details](./references/anaconda_org_channels_bioconda_packages_muse_overview.md)