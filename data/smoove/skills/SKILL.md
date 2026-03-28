---
name: smoove
description: "smoove simplifies structural variant calling and genotyping by orchestrating tools like lumpy and svtyper into a streamlined workflow. Use when user asks to call structural variants, genotype samples, or perform joint calling on large cohorts."
homepage: https://github.com/brentp/smoove
---

# smoove

## Overview

smoove is a powerful orchestration tool that simplifies the complex process of structural variant (SV) calling and genotyping. It acts as a high-performance wrapper around established tools like `lumpy`, `svtyper`, and `duphold`, while implementing additional filtering logic to remove spurious alignment signals that often lead to false positives. By automating the extraction of split and discordant reads and parallelizing genotyping, smoove transforms a multi-tool pipeline into a streamlined workflow suitable for both individual samples and massive cohorts.

## Core Workflows

### Small Cohorts (n < 40)
For small groups, you can perform joint calling and genotyping in a single command.

```bash
smoove call \
    --name my-cohort \
    --fasta $reference_fasta \
    --exclude $problematic_regions_bed \
    --genotype \
    -x \
    -p $threads \
    /path/to/*.bam
```

### Population-Scale Calling (Large Cohorts)
For large cohorts, use a multi-step approach to maintain computational efficiency:

1.  **Per-Sample Calling**: Run on each sample (most efficient at 1-3 threads).
    ```bash
    smoove call --outdir results-smoove/ --name $sample --fasta $fasta --genotype $sample.bam
    ```
2.  **Merge Sites**: Create a union of all discovered variants.
    ```bash
    smoove merge --name merged-sites --fasta $fasta --outdir ./ results-smoove/*.genotyped.vcf.gz
    ```
3.  **Genotype**: Genotype each sample at the merged sites (use `-d` for duphold depth annotations).
    ```bash
    smoove genotype -d -x --name $sample-joint --outdir results-genotyped/ --fasta $fasta --vcf merged-sites.vcf.gz $sample.bam
    ```
4.  **Paste**: Combine individual VCFs into a single "squared" joint-called VCF.
    ```bash
    smoove paste --name $cohort_name results-genotyped/*.vcf.gz
    ```

## Expert Tips and Best Practices

*   **Exclude Regions**: Always use an exclusion BED file (e.g., ENCODE blacklisted regions or telomere/centromere masks) via the `--exclude` flag. This significantly reduces false positives and prevents the tool from wasting cycles on uninformative, high-coverage regions.
*   **Genotype Quality (SHQ)**: When using `smoove annotate`, look for the `SHQ` (Smoove Het Quality) tag in the FORMAT field. A value of **4** indicates a high-quality call, while lower values suggest potential noise.
*   **Resource Management**: For large cohorts, parallelize by sample (Step 1) across different machines rather than increasing threads (`-p`) on a single sample. `smoove` is most efficient when processing many samples in parallel with low thread counts per process.
*   **Duphold Integration**: Use the `-d` flag during the `genotype` step to include `duphold` annotations. This adds depth-based evidence (DHFFC) to the VCF, which is invaluable for downstream filtering of deletions and duplications.
*   **Output Handling**: `smoove` does not output to STDOUT. Always specify an `--outdir` or check the current directory for the `.genotyped.vcf.gz` files.



## Subcommands

| Command | Description |
|---------|-------------|
| smoove | GFF3 annotation files can be downloaded from Ensembl: ftp://ftp.ensembl.org/pub/current_gff3/homo_sapiens/ ftp://ftp.ensembl.org/pub/grch37/release-84/gff3/homo_sapiens/ |
| smoove | Runs lumpy and sends output to {outdir}/{name}-smoove.vcf.gz if --genotype is requested, the output goes to {outdir}/{name}-smoove.genotyped.vcf.gz |
| smoove | Call germline structural variants from sequencing data. |
| smoove | Call genotypes for a given set of BAM files. |
| smoove | Call STRs in BAM files |
| smoove | Merge VCF files from smoove runs. |
| smoove | square VCF files from different samples with the same number of records |
| smoove_plot-counts | Generate an HTML report of counts from smoove |

## Reference documentation
- [smoove README](./references/github_com_brentp_smoove_blob_master_README.md)
- [smoove History and Versioning](./references/github_com_brentp_smoove_blob_master_HISTORY.md)