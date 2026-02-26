---
name: octopusv
description: "OctopuSV standardizes, merges, and analyzes structural variant calls from multiple tools into a unified format. Use when user asks to standardize VCF files, merge structural variants across callers or samples, extract somatic variants, or generate structural variant statistics and reports."
homepage: https://github.com/ylab-hi/octopusV
---


# octopusv

## Overview

OctopuSV is a specialized toolkit designed to address the lack of standardization in structural variant (SV) calling. Because different SV callers (e.g., Manta, Sniffles, Delly) often use inconsistent VCF notations and coordinate systems, OctopuSV provides a unified workflow to "correct" these files into a standard intermediate format called SVCF. Once standardized, the tool enables high-precision merging, somatic variant extraction, and benchmarking. Use this skill to streamline the transition from raw caller outputs to filtered, publication-ready results.

## Core Workflow

The standard OctopuSV pipeline follows a three-step process:
1. **Standardization**: Convert caller-specific VCFs to SVCF.
2. **Analysis**: Perform merging, somatic calling, or benchmarking.
3. **Conversion**: Export results back to standard VCF or BED formats.

### 1. Standardizing VCFs (octopusv correct)
Always run this command before any analysis to resolve ambiguous BND (breakend) annotations and apply initial filters.

```bash
# Basic correction
octopusv correct -i input.vcf -o output.svcf

# Advanced filtering during correction
octopusv correct -i input.vcf -o output.svcf \
    --pos-tolerance 5 \
    --min-svlen 50 \
    --max-svlen 100000 \
    --filter-pass
```

### 2. Merging and Integration (octopusv merge)
OctopuSV supports merging across different callers (multi-caller) or different individuals (multi-sample).

*   **Intersection (Consensus)**: Keep SVs found by all callers.
    `octopusv merge -i caller1.svcf caller2.svcf -o intersection.svcf --intersect`
*   **Union**: Keep SVs found by any caller.
    `octopusv merge -i caller1.svcf caller2.svcf -o union.svcf --union`
*   **Boolean Logic**: Use complex expressions for custom filtering.
    `octopusv merge -i A.svcf B.svcf C.svcf --expression "(A AND B) AND NOT C" -o filtered.svcf`
*   **Multi-sample Cohorts**:
    `octopusv merge -i s1.svcf s2.svcf --mode sample --sample-names Patient1,Patient2 --min-support 2 -o cohort.svcf`

### 3. Somatic SV Calling (octopusv somatic)
Extract tumor-specific variants by comparing standardized tumor and normal SVCFs. This works even if the original callers were not designed for somatic analysis.

```bash
octopusv somatic -t tumor.svcf -n normal.svcf -o somatic.svcf \
    --max-distance 100 \
    --min-jaccard 0.8
```

### 4. Statistics and Visualization
Generate interactive reports and plots to evaluate SV distributions.

```bash
# Generate stats and an interactive HTML report
octopusv stat -i input.svcf -o stats.txt --report

# Create plots from the stats file
octopusv plot stats.txt -o project_prefix
```

## Expert Tips and Best Practices

*   **BND to SV Conversion**: OctopuSV automatically attempts to convert paired BND records into standard types (DEL, INV, DUP, TRA). If a rearrangement is too complex, it is preserved as a BND.
*   **Visualizing Overlap**: When merging, use the `--upsetr` flag to automatically generate UpSet plots (advanced Venn diagrams) showing the intersection of different callers.
    `octopusv merge -i a.svcf b.svcf c.svcf -o merged.svcf --intersect --upsetr --upsetr-output overlap_plot.png`
*   **Benchmarking**: Use `octopusv benchmark` to compare your calls against a "truth set" (like GIAB). It calculates precision and recall based on reciprocal overlap and distance thresholds.
*   **Format Conversion**: After analysis, remember to convert back to VCF for downstream tools:
    `octopusv svcf2vcf -i results.svcf -o final.vcf`

## Reference documentation
- [OctopuSV Main Documentation](./references/github_com_ylab-hi_OctopuSV.md)
- [OctopuSV Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_octopusv_overview.md)