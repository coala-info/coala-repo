---
name: svdss
description: SVDSS detects structural variants in high-accuracy long reads by identifying sample-specific strings relative to a reference genome. Use when user asks to index a reference, smooth BAM files, extract sample-specific strings, call structural variants, or genotype variants using the SVDSS workflow.
homepage: https://github.com/Parsoa/SVDSS
metadata:
  docker_image: "quay.io/biocontainers/svdss:2.1.0--h9013031_0"
---

# svdss

## Overview
SVDSS is a specialized tool for detecting structural variants using the concept of Sample-specific Strings (SFS). It is optimized for high-accuracy long reads, such as PacBio HiFi data. The tool works by identifying the shortest substrings unique to a sample relative to a reference genome, anchoring potential SV sites, and using local assembly to generate precise variant calls. This skill provides guidance on the multi-step workflow required to move from raw alignments to a genotyped VCF.

## Core Workflow
The standard SVDSS pipeline consists of five sequential steps. While a wrapper script `run_svdss` exists, manual execution allows for better control over intermediate files and parameters.

### 1. Indexing the Reference
Build the FMD index required for SFS searching. This is a one-time cost per reference genome.
```bash
SVDSS index -t <threads> -d <reference.fa> > <reference.fa.fmd>
```

### 2. BAM Smoothing
Smoothing is critical as it removes SNPs, small indels, and sequencing errors, which significantly reduces noise and improves SFS relevance.
```bash
SVDSS smooth --reference <reference.fa> --bam <input.bam> --threads <threads> > smoothed.bam
samtools index smoothed.bam
```

### 3. SFS Extraction
Search for sample-specific strings using the FMD index and the smoothed BAM.
```bash
SVDSS search --index <reference.fa.fmd> --bam smoothed.bam > specifics.txt
```

### 4. SV Calling
Perform local partial-order-assembly (POA) to call variants.
```bash
SVDSS call --reference <reference.fa> --bam smoothed.bam --sfs specifics.txt --threads <threads> > calls.vcf
```

### 5. Genotyping
Use `kanpig` to genotype the discovered variants.
```bash
kanpig -r <reference.fa> -v calls.vcf -b <input.bam> > genotyped.vcf
```

## Expert Tips and Best Practices

### Parameter Tuning
- **Minimum Cluster Weight (`--min-cluster-weight`)**: This is the primary lever for balancing precision and recall. 
  - For **30x diploid coverage**, use a value of **2**.
  - For higher coverage or to increase precision, increase this to **3 or 4**.
- **SV Length (`--min-sv-length`)**: Default is typically 50bp. Adjust this if you are specifically looking for smaller or larger structural events.
- **Mapping Quality (`-q`)**: The default is 20. If working with repetitive regions, consider increasing this to reduce false positives from misaligned reads.

### Data Requirements
- **Read Type**: SVDSS is designed for **accurate** long reads (PacBio HiFi). Using it with high-error data like standard ONT reads may result in significant inaccuracies.
- **Reference Selection**: Ensure the reference genome does not include ALT contigs if you are not interested in them, as they can interfere with the uniqueness of SFS.

### Performance
- **Threading**: Most subcommands support the `--threads` or `-t` flag. Smoothing and Calling are the most computationally intensive steps.
- **Index Reuse**: The `.fmd` index is sample-independent. Always store and reuse it for different samples aligned to the same reference version.



## Subcommands

| Command | Description |
|---------|-------------|
| run_svdss | Run SVDSS for structural variant detection. |
| svdss_SVDSS | SVDSS [index\|smooth\|search\|call] |

## Reference documentation
- [SVDSS README](./references/github_com_Parsoa_SVDSS_blob_master_README.md)
- [SVDSS Snakefile (Workflow Logic)](./references/github_com_Parsoa_SVDSS_blob_master_Snakefile.md)