---
name: whatshap
description: WhatsHap is a specialized tool for reconstructing haplotypes from sequencing data.
homepage: https://whatshap.readthedocs.io
---

# whatshap

## Overview
WhatsHap is a specialized tool for reconstructing haplotypes from sequencing data. It determines which alleles belong to the same chromosome by analyzing sequencing reads that span multiple variant sites. It is most effective in a "hybrid" workflow: using high-accuracy short reads (Illumina) for initial variant calling and long reads (PacBio or Oxford Nanopore) for the phasing process.

## Core Workflows and CLI Patterns

### Standard Diploid Phasing
The primary use case involves taking a VCF of discovered variants and a BAM/CRAM file of reads to produce a phased VCF.

```bash
whatshap phase \
    -o phased.vcf \
    --reference reference.fasta \
    input.vcf \
    input.bam
```

### Pedigree-Aware Phasing
If you have sequencing data for related individuals (e.g., a trio), use a PED file to improve phasing accuracy and reduce coverage requirements.

```bash
whatshap phase \
    --ped family.ped \
    -o phased_pedigree.vcf \
    --reference reference.fasta \
    input.vcf \
    input.bam
```

### Polyploid Phasing
For organisms with ploidy > 2, use the `polyphase` subcommand.

```bash
whatshap polyphase \
    -o polyploid_phased.vcf \
    --reference reference.fasta \
    input.vcf \
    input.bam
```

### Haplotagging and Splitting Reads
After phasing, you can tag individual reads in a BAM file with their respective haplotypes (HP tag) and phase sets (PS tag), or split the BAM into separate files per haplotype.

**Tagging:**
```bash
whatshap haplotag \
    --reference reference.fasta \
    -o tagged_reads.bam \
    phased.vcf \
    input.bam
```

**Splitting:**
```bash
whatshap split \
    --output-h1 haplotype1.bam \
    --output-h2 haplotype2.bam \
    tagged_reads.bam
```

### Phasing Statistics
Generate metrics such as N50 phase block length and the number of phased variants.

```bash
whatshap stats --tsv=stats.tsv phased.vcf
```

## Expert Tips and Best Practices

- **Reference Requirement**: Always provide the `--reference` FASTA file. This enables the re-alignment algorithm, which significantly improves phasing accuracy for error-prone long reads (PacBio/ONT) compared to simple edit-distance methods.
- **Sample Name Matching**: Ensure the sample names in the VCF header match the `SM` (Sample) tag in the BAM/CRAM read group (`@RG`) headers. If they do not match, or if read groups are missing, use `--ignore-read-groups` (for single-sample files) or `--sample=NAME` to specify the target.
- **Indel Phasing**: In WhatsHap 2.0+, indel phasing is enabled by default. If using an older version, you must explicitly add the `--indels` flag to include insertions and deletions in the phasing.
- **Multi-Technology Phasing**: You can provide multiple BAM/CRAM files to the `phase` command (e.g., one for Illumina and one for PacBio) to leverage the strengths of both technologies simultaneously.
- **CRAM Files**: When using CRAM input, the reference FASTA is strictly required for decompression and processing.

## Reference documentation
- [WhatsHap User Guide](./references/whatshap_readthedocs_io_en_latest_guide.html.md)
- [WhatsHap Overview](./references/whatshap_readthedocs_io_en_latest.md)
- [Various Notes and Re-alignment Details](./references/whatshap_readthedocs_io_en_latest_notes.html.md)