---
name: dcc
description: DCC identifies and quantifies circular RNA candidates from next-generation sequencing data by analyzing chimeric junction files. Use when user asks to detect circRNAs, quantify host gene expression, or filter back-splice junctions using repeat masking and replicate integration.
homepage: https://github.com/dieterich-lab/DCC
---


# dcc

## Overview

DCC (Detect circRNA) is a specialized bioinformatic tool designed to identify and quantify circular RNA candidates from next-generation sequencing data. It functions by analyzing chimeric junction files produced by the STAR aligner. The tool is particularly effective because it applies a series of filters—including repeat masking and replicate integration—to distinguish true back-splice junctions from sequencing artifacts or linear splicing events. It can simultaneously quantify circular RNAs and host gene expression to provide a comprehensive view of the transcriptomic landscape.

## STAR Mapping Requirements

DCC relies on specific STAR mapping parameters. For the output to be compatible, you must ensure the following flags are used during the alignment phase:

- **Chimeric Alignment**: Set `--chimSegmentMin` (typically 15 or higher) and `--chimScoreMin` (typically 15) to generate the required `Chimeric.out.junction` files.
- **Overhang Consistency**: Set `--alignSJoverhangMin` and `--chimJunctionOverhangMin` to the same value (e.g., 15) to ensure circRNA and linear gene expression levels are comparable.
- **Output Format**: Use `--outSAMtype BAM SortedByCoordinate`.

## Common CLI Patterns

### Basic circRNA Detection
For single-end data or standard detection using a samplesheet:
```bash
DCC @samplesheet -R repeats.gtf -an annotation.gtf -D
```

### Paired-End Analysis (High Sensitivity)
To maximize sensitivity in paired-end data, map mates jointly and then separately. Provide the separate mate chimeric files to DCC:
```bash
DCC @samplesheet -m1 mate1_samplesheet -m2 mate2_samplesheet -R repeats.gtf -an annotation.gtf -D
```

### Integrated circRNA and Host Gene Quantification
To perform a one-pass analysis of both circular and linear host transcripts:
```bash
DCC @samplesheet -R repeats.gtf -an annotation.gtf -D -G -B @bam_file_list
```

## Expert Tips and Best Practices

- **Samplesheet Format**: The `@samplesheet` file should contain one absolute or relative path to a `Chimeric.out.junction` file per line.
- **Repeat Masking**: Always provide a repetitive region file in GTF format using the `-R` flag. This is critical for reducing false positives. You can obtain these from the UCSC Table Browser (e.g., RepeatMasker tracks).
- **BAM and SJ Files**: DCC assumes `SJ.out.tab` files are in the same directory as your BAM files. If DCC cannot "guess" the location, explicitly provide the BAM list using `-B`.
- **Paired-End Strategy**: While joint mapping is standard, separate mate mapping (using `-m1` and `-m2`) is highly recommended for paired-end data. This allows DCC to recover small circular RNAs where only one mate might contain the chimeric junction point.
- **Pathing**: If the `DCC` binary is not in your PATH after installation, you can run it directly via the source: `python <DCC_directory>/DCC/main.py <options>`.

## Reference documentation
- [DCC GitHub Repository](./references/github_com_dieterich-lab_DCC.md)
- [DCC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dcc_overview.md)