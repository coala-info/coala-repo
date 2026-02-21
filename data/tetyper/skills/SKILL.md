---
name: tetyper
description: TETyper is a specialized bioinformatics pipeline designed to characterize a specific transposable element of interest using high-throughput sequencing reads.
homepage: https://github.com/aesheppard/TETyper
---

# tetyper

## Overview
TETyper is a specialized bioinformatics pipeline designed to characterize a specific transposable element of interest using high-throughput sequencing reads. Unlike general variant callers, it combines mapping-based SNV detection with assembly-based structural variant analysis and flanking sequence extraction. Use this skill when you need to determine the exact "type" of a TE (e.g., Tn4401 or IS26) and identify where it has inserted into a genome by analyzing its flanking regions.

## Installation and Environment
TETyper requires several bioinformatics dependencies including BWA, SAMtools, BCFtools, SPAdes, and BLAST+. It is best managed via Conda:

```bash
conda install -c bioconda tetyper
```

## Core CLI Usage

### Basic Typing Workflow
To run a standard analysis, provide the reference sequence of the TE and your paired-end reads:

```bash
TETyper.py --ref TE_reference.fasta \
           --fq1 reads_R1.fastq.gz \
           --fq2 reads_R2.fastq.gz \
           --outprefix sample_output \
           --flank_len 50
```

### Using Profile Files
For automated classification into known variants, use structural and SNP profile files.
- **Structural Profiles**: Tab-separated file (Name | Deletion_Ranges). Ranges format: `start-end|start-end`.
- **SNP Profiles**: Tab-separated file (Name | Homozygous_SNPs | Heterozygous_SNPs). SNP format: `refPOSalt` (e.g., `C8015T`).

```bash
TETyper.py --ref TE_ref.fasta \
           --fq1 r1.fq.gz --fq2 r2.fq.gz \
           --outprefix sample_typing \
           --struct_profiles struct_profiles.txt \
           --snp_profiles snp_profiles.txt \
           --flank_len 20
```

### Optimization and Performance
- **Pre-mapped Reads**: If you have already mapped reads to the TE reference, provide the BAM file to skip the BWA step:
  `--bam alignment.bam`
- **Existing Assembly**: If you have already performed a de novo assembly, provide it to skip the SPAdes step:
  `--assembly assembly.fasta`
- **SPAdes Customization**: Pass specific flags to the internal SPAdes assembler:
  `--spades_params " --cov-cutoff auto --only-assembler"`

## Interpreting Results
The primary output is `[prefix]_summary.txt`. Key columns include:
- **Deletions**: Lists identified sequence gaps.
- **SNP_variant**: Matches identified SNPs against your `--snp_profiles`.
- **Left/Right_flanks**: The sequences immediately adjacent to the TE insertion site.
- **Left/Right_flank_counts**: The number of high-quality reads supporting each flanking sequence, useful for identifying multiple insertion sites or sub-populations.

## Expert Tips
- **Flank Length**: Set `--flank_len` based on the repeat content of your organism. Shorter lengths (e.g., 20bp) are easier to match but less specific; longer lengths (e.g., 100bp) provide better context for insertion site identification.
- **Heterozygosity**: TETyper reports heterozygous SNPs using IUPAC ambiguity codes (M, R, W, S, Y, K). This is particularly useful for identifying mixed bacterial populations or multi-copy TEs with slight variations.
- **Region Presence**: Use `--show_region X-Y` to get a binary (1/0) presence/absence call for a specific internal segment of the TE, which is helpful for tracking the loss of specific cargo genes (like antibiotic resistance genes) within a transposon.

## Reference documentation
- [TETyper GitHub Repository](./references/github_com_aesheppard_TETyper.md)
- [Bioconda TETyper Overview](./references/anaconda_org_channels_bioconda_packages_tetyper_overview.md)