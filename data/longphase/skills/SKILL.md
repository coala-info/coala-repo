---
name: longphase
description: LongPhase is a high-performance bioinformatics tool designed to handle the complexity of long-read sequencing data from Oxford Nanopore (ONT) and PacBio platforms.
homepage: https://github.com/twolinin/longphase
---

# longphase

## Overview

LongPhase is a high-performance bioinformatics tool designed to handle the complexity of long-read sequencing data from Oxford Nanopore (ONT) and PacBio platforms. It enables the simultaneous phasing of multiple variant types—including single nucleotide polymorphisms, small insertions/deletions, and large structural variants—alongside DNA methylation patterns. By leveraging the length of ultra-long reads, it can produce nearly chromosome-scale haplotype blocks in a fraction of the time required by traditional phasing algorithms.

## Core Workflows

### 1. SNP and Indel Phasing
To phase SNPs and small indels, provide a VCF containing both variant types and use the `--indels` flag.

```bash
longphase phase \
  -s variants.vcf \
  -b alignment.bam \
  -r reference.fasta \
  -t 16 \
  -o phased_output \
  --indels \
  --ont # Use --pb for PacBio HiFi
```

### 2. Structural Variation (SV) Co-phasing
LongPhase can integrate SVs into the phasing graph. Ensure your SV caller (Sniffles or CuteSV) is configured to output read names.

```bash
longphase phase \
  -s snp.vcf \
  --sv-file sv_calls.vcf \
  -b alignment.bam \
  -r reference.fasta \
  --ont \
  -o phased_sv_result
```

### 3. Methylation (5mC) Phasing
Phasing modifications requires a two-step process: calling modified loci and then co-phasing them with SNPs.

**Step 1: Call modifications**
```bash
longphase modcall -s snp.vcf -b alignment.bam -r reference.fasta > modcall.vcf
```

**Step 2: Co-phase**
```bash
longphase phase \
  -s snp.vcf \
  --mod-file modcall.vcf \
  -b alignment.bam \
  -r reference.fasta \
  --ont \
  -o phased_mod_result
```

### 4. Haplotagging Reads
After phasing, assign individual reads to specific haplotypes (H1 or H2) to create a tagged BAM file.

```bash
longphase haplotag \
  -s phased_result.vcf \
  -b alignment.bam \
  -r reference.fasta \
  -o tagged_reads
```

## Best Practices and Expert Tips

- **Platform Specificity**: Always explicitly define the platform using `--ont` (Oxford Nanopore) or `--pb` (PacBio). The algorithm adjusts its error model and heuristic parameters based on this flag.
- **Input Preparation**:
    - Reference FASTA must be indexed (`samtools faidx`).
    - BAM files must be sorted and indexed (`samtools index`).
    - For SV phasing with Sniffles2, use the `--output-rnames` flag during SV calling to ensure LongPhase can link reads to variants.
- **Performance Tuning**:
    - Use the `-t` parameter to specify threads. LongPhase is highly optimized; a 30x human genome can often be phased in approximately one minute on modern hardware.
    - If memory is a concern during `modcall`, process chromosomes individually.
- **Filtering Parameters**:
    - **Mapping Quality**: Use `-q` (default: 1) to filter out low-quality alignments. Increase this (e.g., `-q 20`) if working in repetitive regions.
    - **Mismatch Rate**: Use `-x` (default: 3) to exclude reads with high divergence from the reference, which often represent chimeric reads or poor alignments.
- **Phasing Connectivity**:
    - The `-d` (distance) parameter controls the maximum distance between variants to be phased (default: 300,000 bp). Increase this if you have ultra-long reads (>100kb) to potentially bridge larger gaps.
    - The `-a` (connectAdjacent) parameter defines how many adjacent SNPs to consider for edge creation (default: 35).

## Reference documentation
- [LongPhase GitHub Repository](./references/github_com_twolinin_longphase.md)
- [Bioconda LongPhase Overview](./references/anaconda_org_channels_bioconda_packages_longphase_overview.md)