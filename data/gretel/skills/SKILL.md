---
name: gretel
description: "Gretel recovers and ranks haplotypes from metagenomic data by reconstructing the most likely sequences of variants from aligned reads. Use when user asks to recover haplotypes from metagenomes, reconstruct strain sequences from BAM and VCF files, or rank genomic variants by likelihood."
homepage: https://github.com/SamStudio8/gretel
---


# gretel

## Overview
Gretel is a bioinformatic tool that recovers haplotypes from metagenomes without requiring a priori knowledge of the number of strains or specific distribution parameters. It works by parsing aligned reads into a "Hansel" matrix and employing an L'th order Markov chain model to probabilistically reconstruct the most likely sequences of variants. Unlike other tools that may produce unranked overlaps, Gretel ranks its output haplotypes by likelihood and is designed to be robust against sequencing errors and misalignment noise.

## CLI Usage and Best Practices

### Core Command Pattern
The primary interface for Gretel requires a sorted BAM file, a compressed and indexed VCF, and specific coordinates for the target contig.

```bash
gretel <bam> <vcf.gz> <contig> -s <start> -e <end> --master <master.fa> -o <outdir>
```

### Input Requirements
*   **BAM File**: Must be sorted and indexed. It should contain reads aligned to a "pseudo-reference" (e.g., a consensus assembly or a known strain reference like HIV-1).
*   **VCF File**: Must be compressed with `bgzip` and indexed with `tabix`. Gretel relies on the VCF to identify variant sites.
*   **Master FASTA**: The reference sequence used for the alignment.
*   **Coordinates**: You must specify the 1-based start (`-s`) and end (`-e`) positions on the contig.

### Workflow Tips
*   **Reference Selection**: If a high-quality reference is unavailable, use a consensus assembly of your metagenomic reads as the pseudo-reference.
*   **Parameter Optimization**: Gretel is designed to be parameter-free. You do not need to provide estimates for the number of haplotypes or allele distributions.
*   **Haplotype Ranking**: Review the output directory for ranked haplotypes. Gretel provides a likelihood score for each reconstructed sequence, allowing you to distinguish between primary and secondary strains.
*   **Handling Large Contigs**: For very large contigs, be aware that Gretel may generate significant temporary files. Ensure your output directory has sufficient disk space.

### Common CLI Flags
*   `-s`, `--start`: 1-based start position on the contig.
*   `-e`, `--end`: 1-based end position on the contig.
*   `-o`, `--outdir`: Directory where results and ranked haplotypes will be stored.
*   `--master`: Path to the FASTA file used as the reference for the BAM/VCF.

## Reference documentation
- [Gretel GitHub Repository](./references/github_com_SamStudio8_gretel.md)
- [Gretel Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gretel_overview.md)