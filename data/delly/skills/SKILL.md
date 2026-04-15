---
name: delly
description: Delly is an integrated structural variant discovery tool that identifies genomic rearrangements using paired-end mapping, split-read analysis, and read-depth information. Use when user asks to discover germline structural variants, identify somatic mutations in tumor-normal pairs, call long-read variants, or detect copy-number variations.
homepage: https://github.com/dellytools/delly
metadata:
  docker_image: "quay.io/biocontainers/delly:1.7.2--h4d20210_0"
---

# delly

## Overview

Delly is an integrated structural variant discovery tool that leverages paired-end mapping, split-read analysis, and read-depth information to identify genomic rearrangements at single-nucleotide resolution. It is designed to process high-throughput sequencing data to delineate complex variants across the genome. Use this skill to execute standard workflows for germline SV calling, somatic mutation discovery in tumor-normal pairs, and long-read SV detection.

## General Requirements

*   **Input Files**: Requires sorted, indexed, and duplicate-marked BAM or CRAM files.
*   **Reference**: An indexed FASTA reference genome is mandatory for split-read analysis.
*   **Output Format**: Prefers BCF (Binary Variant Call Format) for performance, though VCF is supported.

## Common CLI Patterns

### Basic SV Calling
To discover SVs in a single sample:
```bash
delly call -g reference.fa -o output.bcf input.bam
```

### Somatic SV Workflow
Somatic calling requires a tumor sample and a matched control.

1.  **Discovery**:
    ```bash
    delly call -x hg38.excl -g hg38.fa -o tumor_discovery.bcf tumor.bam control.bam
    ```
2.  **Pre-filter**:
    Requires a `samples.tsv` (Column 1: Sample ID, Column 2: "tumor" or "control").
    ```bash
    delly filter -f somatic -o filtered.bcf -s samples.tsv tumor_discovery.bcf
    ```
3.  **Genotype**:
    Genotype the filtered sites across the tumor and control (and optionally a panel of normals).
    ```bash
    delly call -g hg38.fa -v filtered.bcf -o genotyped.bcf tumor.bam control.bam
    ```
4.  **Post-filter**:
    ```bash
    delly filter -f somatic -o final_somatic.bcf -s samples.tsv genotyped.bcf
    ```

### Germline SV Workflow (Multi-sample)
1.  **Call**: Run `delly call` on each sample individually.
2.  **Merge**: Combine sites from all samples.
    ```bash
    delly merge -o merged_sites.bcf sample1.bcf sample2.bcf sampleN.bcf
    ```
3.  **Genotype**: Re-run `delly call` using the merged sites as a template (`-v`).
    ```bash
    delly call -g ref.fa -v merged_sites.bcf -o sample1.geno.bcf sample1.bam
    ```
4.  **Filter**: Merge genotyped files with `bcftools merge` and apply the germline filter.
    ```bash
    delly filter -f germline -o final_germline.bcf merged_samples.bcf
    ```

### Long-Read SV Calling (PacBio/ONT)
Use the `lr` command specifically for long-read data.
```bash
# For Oxford Nanopore
delly lr -y ont -g ref.fa -o output.bcf input.bam

# For PacBio
delly lr -y pb -g ref.fa -o output.bcf input.bam
```

### Copy-Number Variant (CNV) Calling
Requires a mappability map.
```bash
delly cnv -g ref.fa -m mappability.map -c coverage.cov.gz -o cnv_calls.bcf input.bam
```

## Expert Tips and Best Practices

*   **Exclusion Regions**: Always use the `-x` (or `--exclude`) flag with a BED file of telomeric, centromeric, and heterochromatic regions to reduce false positives and improve runtime.
*   **BCF vs VCF**: Always output to BCF (`-o file.bcf`) for multi-step workflows. Use `bcftools view` only when a human-readable VCF is needed for final inspection.
*   **Translocations**: Delly uses the `CHR2` INFO tag for the second chromosome in inter-chromosomal translocations. To convert these to standard BND (breakend) format, use the provided `delly2bnd.py` script in the Delly scripts directory.
*   **Filtering**: For germline SVs, the `delly filter -f germline` command typically requires at least 20 unrelated samples to be effective at frequency-based filtering.
*   **Memory Management**: For very high-coverage samples, consider using the `-m` flag in `delly cnv` to adjust the window size if memory usage becomes an issue.



## Subcommands

| Command | Description |
|---------|-------------|
| delly call | Compute structural variants |
| delly filter | Filter SV calls in a BCF file |
| delly merge | Merge SV BCF files |

## Reference documentation
- [Delly GitHub Repository](./references/github_com_dellytools_delly.md)