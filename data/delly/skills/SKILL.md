---
name: delly
description: Delly is an integrated structural variant prediction method that identifies deletions, duplications, inversions, and translocations at single-nucleotide resolution. Use when user asks to call structural variants, identify somatic or germline mutations, genotype SVs across multiple samples, or detect copy-number variants using short-read or long-read sequencing data.
homepage: https://github.com/dellytools/delly
---


# delly

## Overview
Delly is an integrated structural variant prediction method that achieves single-nucleotide resolution by combining paired-end mapping, split-read analysis, and read-depth information. It is designed to process sorted, indexed, and duplicate-marked BAM files against a reference genome. This skill provides the necessary command-line patterns for executing standard discovery, genotyping, and filtering workflows for both germline and somatic research.

## Core CLI Usage

### Basic SV Calling
For a single sample, use the `call` command. Delly requires an indexed reference genome.
```bash
delly call -g reference.fa input.bam > output.vcf
```
*Note: Using BCF format (`-o output.bcf`) is recommended for better performance in multi-sample workflows.*

### Somatic SV Workflow
Somatic calling requires a tumor sample and a matched control.

1.  **Discovery**: Call variants using both BAMs. Use an exclusion file (`-x`) to skip telomeric and centromeric regions for better accuracy.
    ```bash
    delly call -x hg38.excl -g hg38.fa -o tumor_discovery.bcf tumor.bam control.bam
    ```
2.  **Pre-filtering**: Filter for somatic candidates using a sample description file (TSV: `sample_id [tumor|control]`).
    ```bash
    delly filter -f somatic -o tumor_pre_filter.bcf -s samples.tsv tumor_discovery.bcf
    ```
3.  **Genotyping**: Re-genotype the candidates across the tumor and control (and optionally a panel of normals).
    ```bash
    delly call -g hg38.fa -v tumor_pre_filter.bcf -o genotyped.bcf -x hg38.excl tumor.bam control.bam
    ```
4.  **Post-filtering**: Apply final somatic filters.
    ```bash
    delly filter -f somatic -o final_somatic.bcf -s samples.tsv genotyped.bcf
    ```

### Germline SV Workflow (Multi-sample)
1.  **Per-sample Call**: Run `delly call` on each sample individually.
2.  **Merge Sites**: Combine discovery sites into a unified list.
    ```bash
    delly merge -o sites.bcf sample1.bcf sample2.bcf ... sampleN.bcf
    ```
3.  **Genotype**: Run `delly call` using the merged sites as a template (`-v`) for every sample.
    ```bash
    delly call -g ref.fa -v sites.bcf -o s1.geno.bcf sample1.bam
    ```
4.  **Merge and Filter**: Use `bcftools merge` to combine genotyped files, then apply the germline filter (requires at least 20 unrelated samples for optimal performance).
    ```bash
    delly filter -f germline -o final_germline.bcf merged_samples.bcf
    ```

### Long-Read SV Calling
Use the `lr` command for PacBio or Oxford Nanopore data.
```bash
# For Nanopore
delly lr -y ont -g ref.fa -o output.bcf input.bam

# For PacBio
delly lr -y pb -g ref.fa -o output.bcf input.bam
```

### Copy-Number Variant (CNV) Calling
CNV calling requires a mappability map.
```bash
delly cnv -g ref.fa -m mappability.map -c coverage.cov.gz -o cnv_output.bcf input.bam
```

## Best Practices and Expert Tips
*   **Input Preparation**: Always ensure BAM files are sorted, indexed (`samtools index`), and have duplicates marked (`picard MarkDuplicates` or `samtools markdup`).
*   **Exclusion Maps**: Always use an exclusion file (`-x`) for human data to ignore high-coverage/repetitive regions (e.g., centromeres, telomeres, and unplaced contigs). This significantly reduces false positives and runtime.
*   **Memory Management**: For very large cohorts, process chromosomes in parallel to manage memory and compute time.
*   **Inter-chromosomal Translocations**: Delly uses the `CHR2` INFO tag for the second chromosome in translocations. To convert these to the standard BND (breakend) format, use the provided helper script:
    ```bash
    python scripts/delly2bnd.py -v input.bcf -r ref.fa -o output.bnd.bcf
    ```
*   **Filtering**: The `QUAL` field in Delly VCFs is a useful proxy for confidence. For high-quality sets, consider filtering for `PASS` variants or applying a minimum `QUAL` threshold (e.g., `QUAL >= 300`).

## Reference documentation
- [Delly GitHub Repository](./references/github_com_dellytools_delly.md)
- [Bioconda Delly Overview](./references/anaconda_org_channels_bioconda_packages_delly_overview.md)