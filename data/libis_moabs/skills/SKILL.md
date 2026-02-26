---
name: libis_moabs
description: LiBis is a specialized alignment suite that uses dynamic clipping and remapping to process low-input bisulfite sequencing data into methylation calls. Use when user asks to align fragmented DNA reads, perform methylation calling, rescue unmapped reads, or generate visualization reports for bisulfite sequencing.
homepage: https://github.com/Dangertrip/LiBis
---


# libis_moabs

## Overview
LiBis (Low input Bisulfite sequencing) is a specialized alignment suite designed to address the low mapping ratios typically encountered when working with nanogram-scale, fragmented DNA. Unlike standard aligners that may discard short or damaged reads, LiBis utilizes a dynamic clipping and remapping strategy to rescue informative fragments. It integrates several bioinformatics tools—including FastQC, Trim Galore, and MOABS—into a unified pipeline for processing raw FASTQ files into methylation calls and visual reports.

## Installation and Environment
The tool is primarily distributed via Bioconda. Ensure that dependencies like `samtools` (specifically version 1.1 is recommended in documentation), `bedtools`, and `moabs` are available in your path.

```bash
conda install -c bioconda libis_moabs
```

## Common CLI Patterns

### Basic Alignment and Methylation Calling
To run a standard pipeline on paired-end data including methylation calling and report generation:
```bash
LiBis -n sample_R1.fq.gz,sample_R2.fq.gz -r reference.fa -g hg38 -mcall -plot
```

### Processing Multiple Samples
Separate paired-end mates with a comma and separate distinct samples with a space:
```bash
LiBis -n s1_R1.fq,s1_R2.fq s2_R1.fq,s2_R2.fq -r reference.fa -l Label1 Label2
```

### Rescuing Reads with Clipping
The "Clip Mode" is the core feature of LiBis. It is enabled by default (`-c 1`). You can tune the sensitivity using the window and step parameters:
- `-w`: Window length for clipping (default: 40).
- `-s`: Step size for clipping (default: 5).
- `-ft`: Minimal length for recombined reads (default: 46).

### Using Pre-aligned BAM Files
If you have already performed an initial alignment with BSMAP and want to use LiBis to rescue the remaining unmapped reads:
```bash
LiBis -bam sample.bam -bu -n sample_R1.fq,sample_R2.fq -r reference.fa
```
*Note: The `-bu` flag indicates the provided BAM contains unmapped reads.*

## Parameter Reference and Best Practices

| Parameter | Usage | Tip |
| :--- | :--- | :--- |
| `-f 0` | Parameter mode | Use `0` to pass arguments via CLI; use `1` with `-sf` for a config file. |
| `-mcall` | Methylation calling | Always include this if you need CpG methylation frequencies. |
| `-plot` | Visualization | Generates a final report; requires `-g` (e.g., hg38, mm10) to be set. |
| `-t 1` | Trimming | If using Clip Mode (`-c 1`), manual trimming is often unnecessary. |
| `-p` | Parallelization | Set based on available CPU cores; note that underlying BSMAP calls use significant resources. |
| `-module` | MOABS Integration | Only use this flag when LiBis is being called as a sub-module within a larger MOABS workflow. |

## Expert Tips
- **Memory Management**: LiBis can be resource-intensive during the remapping phase. Ensure your environment has sufficient RAM for the reference genome index.
- **Read Names**: LiBis modifies read names to track clipping coordinates (adding 4 fields divided by `_`). Avoid using FASTQ files with complex custom headers that might conflict with this naming convention.
- **Temporary Files**: Use `--fullmode` if you need to debug the intermediate clipping steps, otherwise, the tool cleans up large temporary files to save space.
- **Gzip Support**: Use the `-gz` flag if your intermediate temporary files should be compressed to save disk I/O and space.

## Reference documentation
- [LiBis GitHub Repository](./references/github_com_Dangertrip_LiBis.md)
- [Bioconda libis_moabs Overview](./references/anaconda_org_channels_bioconda_packages_libis_moabs_overview.md)