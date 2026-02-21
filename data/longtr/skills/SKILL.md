---
name: longtr
description: LongTR is a specialized tool designed to resolve tandem repeat genotypes from long-read datasets.
homepage: https://github.com/gymrek-lab/LongTR
---

# longtr

## Overview
LongTR is a specialized tool designed to resolve tandem repeat genotypes from long-read datasets. It is a modification of the HipSTR tool, tailored to handle the unique error profiles and increased read lengths of PacBio and Nanopore platforms. It enables researchers to characterize both short (STR) and large (VNTR) repeat regions that are often inaccessible to short-read sequencing. The tool outputs results in a bgzipped VCF format containing detailed quality metrics for downstream filtering.

## Installation and Setup
The most reliable way to install LongTR is via Conda:
```bash
conda install -c conda-forge -c bioconda longtr
```
If building from source, ensure `gcc 7+` and `cmake 3.12+` are available, then run `make` in the repository root to generate the `LongTR` executable.

## Core CLI Usage
The basic command structure requires a reference genome, a set of target regions, and one or more alignment files.

### Standard Genotyping (PacBio HiFi)
For high-fidelity reads, use the following pattern:
```bash
longtr --bams sample1.bam,sample2.bam \
       --fasta reference.fa \
       --regions tr_regions.bed \
       --tr-vcf output_calls.vcf.gz
```

### Phased Analysis
If your BAM files have been happlotagged (e.g., using Whatshap or similar tools), enable haplotype-specific genotyping:
```bash
longtr --bams phased_sample.bam \
       --fasta reference.fa \
       --regions tr_regions.bed \
       --tr-vcf phased_calls.vcf.gz \
       --phased-bam
```

## Expert Parameters and Tuning

### Handling High Error Rates (ONT)
The default alignment parameters are optimized for PacBio HiFi. For noisier reads like Oxford Nanopore, adjust the gap-opening log probabilities (parameters `f` and `g`) to better accommodate InDels:
*   `--alignment-params a,b,c,d,e,f,g`: Custom log probabilities.
*   Increase `f` (Match to insertion) and `g` (Match to deletion) from the default `-10.448` to more permissive values if call rates are low.

### Quality Control and Filtering
LongTR does not automatically discard low-quality calls; you must filter the VCF output based on the following fields:
*   **FORMAT/Q**: The posterior probability of the genotype. This is the most reliable indicator of call quality.
*   **INFO/DP**: Total depth. Low mean coverage (DP / number of samples) often leads to allelic dropout in heterozygotes.
*   **DFLANKINDEL**: If the ratio of `DFLANKINDEL/DP` is high, it suggests an InDel in the flanking region or that the true allele is significantly different from the candidate alleles.

### Performance Optimization
LongTR is single-threaded. To speed up large-scale analyses:
1.  **Chromosome Parallelization**: Use the `--chrom` flag to run separate instances per chromosome (e.g., `--chrom chr1`).
2.  **BED Splitting**: Divide your `tr_regions.bed` into multiple smaller files and run them in parallel across different CPU cores.

## Common CLI Flags
| Flag | Description | Default |
| :--- | :--- | :--- |
| `--min-mapq` | Minimum mapping quality for reads | 20 |
| `--max-tr-len` | Maximum length of TR to genotype | 1000 |
| `--min-reads` | Minimum reads required to call a locus | 10 |
| `--haploid-chrs` | Comma-separated list of haploid chromosomes | All diploid |
| `--indel-flank-len` | BP window around repeat to include InDels | 5 |

## Reference documentation
- [LongTR GitHub Repository](./references/github_com_gymrek-lab_LongTR.md)
- [LongTR Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_longtr_overview.md)