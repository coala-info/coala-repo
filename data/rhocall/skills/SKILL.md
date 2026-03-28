---
name: rhocall
description: "rhocall identifies genomic regions of homozygosity and detects potential uniparental disomy from variant call files. Use when user asks to call regions of homozygosity, annotate VCF files with ROH information, tally chromosome-wide homozygosity for UPD detection, or visualize zygosity plots."
homepage: https://github.com/dnil/rhocall
---

# rhocall

## Overview

rhocall is a specialized bioinformatics utility designed to identify genomic regions of homozygosity (ROH) and provide tentative calls for Uniparental Disomy (UPD). It works by analyzing variant call files (VCF/BCF) to detect stretches of homozygous variants that exceed specific density and length thresholds. The tool is particularly useful in clinical genetics for identifying consanguinity, mapping recessive disease genes, or detecting chromosomal abnormalities like UPD. It integrates with `bcftools roh` outputs but provides additional layers of aggregation, annotation, and visualization.

## Core Workflows

### 1. Standard ROH Calling Pipeline
The most effective way to use rhocall is in conjunction with `bcftools`.

**Step A: Prepare population frequencies**
```bash
bcftools query -f'%CHROM\t%POS\t%REF,%ALT\t%INFO/AF\n' popfreq.vcf.gz | bgzip -c > popfreq.tab.gz
```

**Step B: Generate ROH calls**
```bash
bcftools roh --AF-file popfreq.tab.gz -I sample.bcf > sample.roh
```

**Step C: Annotate the VCF**
For bcftools v1.4+, use the `--v14` flag to handle RG entries:
```bash
rhocall annotate --v14 -r sample.roh -o sample.annotated.vcf sample.bcf
```

### 2. UPD Detection and Tallying
To get a per-chromosome summary and flag potential UPD:
```bash
rhocall tally sample.roh -o sample.tally.tsv
```
*   **Tip**: Use the `-u` or `--flag_upd_at_fraction` option (default 0.3) to adjust the sensitivity of UPD flagging based on the fraction of the chromosome covered by homozygous blocks.

### 3. Visualization
Generate zygosity plots (one per chromosome) to visually inspect ROH regions:
```bash
rhocall viz --rho sample.roh --out_dir plots/ --wig sample.vcf
```
*   **Note**: The `--wig` flag produces a wiggle file for genome browser integration.

## Command Reference & Best Practices

### rhocall call
Used for direct calling from VCF if not using the bcftools workflow.
*   **Heterozygote Tolerance**: Adjust `-m` (max hets per Mb) and `-f` (max het/hom fraction) to account for sequencing noise or "leaky" homozygosity.
*   **Exome vs. Genome**: Adjust `-s` (block_constant) based on the density of your data. Exomes require different constants than WGS due to capture gaps.

### rhocall annotate
*   **Legacy Support**: If using bcftools < 1.4, you must first run `rhocall aggregate` to create a BED file, then annotate using the `-b` flag.
*   **Sample Selection**: In multi-sample VCFs, use `--select-sample` to ensure annotations are applied based on the correct individual's ROH profile.

### rhocall aggregate
*   **Quality Filtering**: Use `-q` (quality_threshold) to ignore low-confidence ROH windows. This prevents small, noisy regions from being merged into larger blocks.

## Expert Tips
*   **Filter First**: Always ensure your input VCF is sorted. rhocall assumes sorted input for its parsing logic.
*   **Avoid bcftools v1.3**: The ROH functionality in bcftools v1.3 is known to be buggy; use v1.2 or v1.4+ for reliable results.
*   **Visualization Parameters**: When using `rhoviz` or `rhocall viz`, if your VCF lacks allele frequency annotations, you **must** set `--minaf 0` to ensure variants are not filtered out of the plots.



## Subcommands

| Command | Description |
|---------|-------------|
| rhocall aggregate | Aggregate runs of autozygosity from rhofile into windowed rho BED file. Accepts a bcftools roh style TSV-file with CHR,POS,AZ,QUAL. |
| rhocall annotate | Markup VCF file using rho-calls. Use BED file to mark all variants in AZ   windows. Alternatively, use a bcftools v>=1.4 file with RG entries to mark   all vars. With the --no-v14 flag, use an older bcftools v<=1.2 style roh TSV   to mark only selected AZ variants. Roh is broken in bcftools v1.3 - do not   use. |
| rhocall call | Call runs of autozygosity. (deprecated: use bcftools roh instead. |
| rhocall tally | Tally runs of autozygosity from rhofile. Accepts a bcftools roh style TSV-file with CHR,POS,AZ,QUAL. |
| rhocall viz | Plot binned zygosity and RHO-regions. |

## Reference documentation
- [rhocall README](./references/github_com_dnil_rhocall_blob_main_README.md)
- [rhocall CLI Source](./references/github_com_dnil_rhocall_blob_main_rhocall.py.md)
- [rhocall Changelog](./references/github_com_dnil_rhocall_blob_main_CHANGELOG.md)