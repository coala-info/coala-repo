---
name: smoove
description: Smoove automates structural variant calling and genotyping by integrating tools like Lumpy and SVTyper into a streamlined workflow. Use when user asks to call structural variants, genotype samples across a cohort, or merge and annotate variant calls.
homepage: https://github.com/brentp/smoove
---


# smoove

## Overview
The `smoove` skill provides a high-level interface for structural variant (SV) analysis. It automates the complex orchestration of extracting split and discordant reads, filtering spurious signals in high-coverage regions, and parallelizing genotyping. By wrapping tools like Lumpy, SVTyper, and Duphold, it improves both the speed and specificity of SV detection while producing well-annotated VCF files.

## Core Workflows

### Small Cohorts (n < 40)
For small groups, you can generate a jointly-called, genotyped VCF in a single step.

```bash
smoove call -x \
    --name my-cohort \
    --exclude $exclude_bed \
    --fasta $reference_fasta \
    -p $threads \
    --genotype /path/to/*.bam
```

### Population Calling (Large Cohorts)
For large cohorts, use a multi-step parallel workflow to ensure scalability and efficiency.

1.  **Per-Sample Calling**: Run on each sample individually. Use `-p 1` as it is most efficient for large-scale parallelization.
    ```bash
    smoove call --outdir results-smoove/ --exclude $exclude_bed --name $sample --fasta $reference_fasta -p 1 --genotype $sample.bam
    ```
2.  **Merge Sites**: Create a union of all discovered sites.
    ```bash
    smoove merge --name merged -f $reference_fasta --outdir ./ results-smoove/*.genotyped.vcf.gz
    ```
3.  **Genotype**: Genotype each sample at the merged sites and add depth annotations via duphold.
    ```bash
    smoove genotype -d -x -p 1 --name $sample-joint --outdir results-genotyped/ --fasta $reference_fasta --vcf merged.sites.vcf.gz $sample.bam
    ```
4.  **Paste**: Combine single-sample VCFs into a single "squared" joint-called file.
    ```bash
    smoove paste --name $cohort_name results-genotyped/*.vcf.gz
    ```

## Expert Tips and Best Practices

### Filtering and Quality Control
*   **Exclude Regions**: Always use the `--exclude` flag with a BED file of problematic regions (e.g., centromeres, telomeres, or high-signal regions). This significantly reduces false positives and processing time.
*   **SHQ Tag**: After running `smoove annotate`, use the `SHQ` (Smoove Het Quality) tag. A value of 4 indicates a high-quality call; 1 is low quality.
*   **MSHQ**: In the INFO field, `MSHQ` (Mean SHQ) represents the average quality across heterozygous samples. Filter for `MSHQ > 3` for high-confidence variants.
*   **Duphold Filtering**: If depth annotations are present, filter deletions with `DHFFC < 0.7` and duplications with `DHFFC > 1.25`.

### Performance Optimization
*   **Thread Management**: For single-sample calling, `smoove` only parallelizes effectively up to 2 or 3 threads. In large clusters, it is better to run many single-threaded jobs.
*   **Temporary Space**: `smoove` writes heavily to the system `TMPDIR`. For large cohorts, ensure this is pointed to a high-capacity disk: `export TMPDIR=/path/to/large/scratch`.
*   **CRAM Support**: Ensure `samtools` is in your PATH for CRAM input support.

### Common Troubleshooting
*   **Header Errors**: If you encounter "Could not parse the header line" or segmentation faults during VCF processing, ensure `bcftools` is version 1.5 or higher.
*   **Missing Dependencies**: Running `smoove` without arguments will list which required tools (Lumpy, gsort, etc.) are missing from your environment.

## Reference documentation
- [smoove GitHub Repository](./references/github_com_brentp_smoove.md)
- [Bioconda smoove Overview](./references/anaconda_org_channels_bioconda_packages_smoove_overview.md)