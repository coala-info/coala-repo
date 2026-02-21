---
name: craq
description: CRAQ (Clipping Reveals Assembly Quality) is a specialized tool for assessing the accuracy of genome assemblies without requiring a reference genome.
homepage: https://github.com/JiaoLaboratory/CRAQ
---

# craq

## Overview
CRAQ (Clipping Reveals Assembly Quality) is a specialized tool for assessing the accuracy of genome assemblies without requiring a reference genome. By integrating mapping signals from both short-read (NGS) and long-read (SMS) data, it identifies precise locations of regional and structural errors. It provides a standardized scoring system (AQI) to classify assembly quality and can automatically correct chimeric contigs by breaking them at identified conflict points.

## CLI Usage Patterns

### Standard Evaluation (Raw Reads)
When providing raw sequencing data, specify the mapping preset based on the long-read technology.
```bash
craq -g assembly.fa \
     -sms SMS_reads.fq.gz \
     -ngs NGS_R1.fq.gz,NGS_R2.fq.gz \
     -x map-hifi \
     -t 16
```
*Note: `-x` supports `map-hifi` (default), `map-pb` (PacBio CLR), and `map-ont` (Nanopore).*

### Optimized Evaluation (Pre-aligned BAMs)
For large genomes or repeated runs, providing sorted and indexed BAM files is highly recommended to save time and resources.
```bash
craq -g assembly.fa -sms SMS_sorted.bam -ngs NGS_sorted.bam
```
*Requirement: BAM files must be sorted and have corresponding `.bai` indices in the same directory.*

### Assembly Correction
To generate a corrected assembly by breaking contigs at detected structural error (CSE) breakpoints:
```bash
craq -g assembly.fa -sms SMS_sorted.bam -ngs NGS_sorted.bam --break T
```
*Output: The corrected sequences will be saved in `out_correct.fa`.*

## Quality Metrics (AQI)
CRAQ classifies assemblies based on the Assembly Quality Index (AQI):
- **AQI > 90**: Reference quality
- **AQI 80-90**: High quality
- **AQI 60-80**: Draft quality
- **AQI < 60**: Low quality

## Key Parameters & Best Practices
- **Thread Management**: Use `-t` to specify CPU cores (default is 10).
- **Heterozygous Variants**: CRAQ distinguishes between true errors and heterozygous variants (CRHs/CSHs). Use `--report_SNV T` to include small-scale variants, though this increases resource consumption.
- **Clipping Thresholds**: Adjust `--ngs_clip_coverRate` (default 0.75) and `--sms_clip_coverRate` (default 0.75) if the assembly has unusual coverage depth or error profiles.
- **Plotting**: Set `--plot T` to generate a circos visualization (`out_circos.pdf`). This requires `pycircos` to be installed.
- **Output Directory**: Use `-D` to specify a custom output directory (default is `./Output/`).

## Important Output Files
- `out_final.Report`: Summary of R-AQI and S-AQI metrics.
- `locER_out/out_final.CRE.bed`: Coordinates of regional errors.
- `strER_out/out_final.CSE.bed`: Coordinates of structural breakages.
- `out_correct.fa`: The corrected assembly (if `--break T` was used).

## Reference documentation
- [CRAQ GitHub Repository](./references/github_com_JiaoLaboratory_CRAQ.md)
- [CRAQ Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_craq_overview.md)