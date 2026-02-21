---
name: svdss
description: SVDSS (Structural Variant Discovery from Sample-specific Strings) is a specialized tool designed to identify structural variants in high-accuracy long reads.
homepage: https://github.com/Parsoa/SVDSS
---

# svdss

## Overview

SVDSS (Structural Variant Discovery from Sample-specific Strings) is a specialized tool designed to identify structural variants in high-accuracy long reads. It operates on the principle of "sample-specific strings" (SFS)—the shortest substrings found in a target sample that are unique relative to a reference genome. The tool uses these strings to anchor potential SV sites and performs local partial-order assembly (POA) to produce precise variant predictions. While optimized for PacBio HiFi data, it can be applied to other technologies like ONT, though accuracy may vary.

## Installation and Environment

SVDSS is most easily managed via Bioconda.

```bash
conda create -n svdss -c conda-forge -c bioconda svdss
conda activate svdss
```

## Core Workflow

The SVDSS pipeline consists of four primary stages. For a streamlined execution, a wrapper script `run_svdss` is available, but manual execution allows for better control over intermediate files.

### 1. Indexing the Reference
Build an FMD index of the reference genome. This index can be reused for any number of samples compared against the same reference.

```bash
SVDSS index -t 16 -d reference.fa > reference.fa.fmd
```

### 2. Read Smoothing
Smoothing is a critical step that removes SNPs, small indels, and sequencing errors. This reduces noise and ensures that extracted SFS are highly relevant to actual structural variants.

```bash
SVDSS smooth --reference reference.fa --bam sample.bam --threads 16 > smoothed.bam
samtools index smoothed.bam
```

### 3. SFS Search
Extract the sample-specific strings from the smoothed BAM file using the FMD index.

```bash
SVDSS search --index reference.fa.fmd --bam smoothed.bam > specifics.txt
```

### 4. SV Calling
Generate the final VCF output by assembling superstrings from the SFS clusters.

```bash
SVDSS call --reference reference.fa --bam smoothed.bam --sfs specifics.txt --threads 16 > calls.vcf
```

## Expert Tips and Best Practices

- **Reference Selection**: Use a reference genome that matches your analysis goals. If you are not interested in alternative contigs, filter them out of the FASTA before indexing to avoid "diluting" the specificity of the strings.
- **BAM Indexing**: Always run `samtools index` on the `smoothed.bam` file before proceeding to the `call` step. The `call` command requires an indexed BAM to function correctly.
- **Filtering Results**: Use the `--min-sv-length` (default 50) and `--min-cluster-weight` (minimum support) options during the `call` phase to reduce false positives.
- **Haplotagging**: By default, SVDSS considers haplotagging information. If your BAM is not phased or you wish to ignore this data, use the `-t` flag in the wrapper or appropriate flags in the subcommands.
- **Resource Management**: The `index` and `smooth` steps are computationally intensive. Ensure you allocate sufficient threads (`-t` or `--threads`) and memory for these operations.

## Common CLI Patterns

**Using the Wrapper Script:**
For a quick, end-to-end run with default parameters:
```bash
run_svdss -w ./output_dir -@ 16 reference.fa sample.bam
```

**Adjusting Sensitivity:**
If you are getting too few calls, consider lowering the mapping quality threshold or the minimum support:
```bash
SVDSS call --reference ref.fa --bam smoothed.bam --sfs specifics.txt --min-support 1 --min-sv-length 30 > sensitive_calls.vcf
```

## Reference documentation
- [SVDSS GitHub Repository](./references/github_com_Parsoa_SVDSS.md)
- [SVDSS Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_svdss_overview.md)