---
name: bcbio-variation-recall
description: bcbio-variation-recall is a specialized framework for combining and refining genomic variant calls.
homepage: https://github.com/chapmanb/bcbio.variation.recall
---

# bcbio-variation-recall

## Overview

bcbio-variation-recall is a specialized framework for combining and refining genomic variant calls. It addresses the "missing data" problem in multi-sample cohorts by providing a mechanism to "square off" calls—re-evaluating raw sequence data (BAM/CRAM) at positions where a variant was found in one sample but not others. It also supports ensemble calling to increase precision by finding consensus across different variant calling algorithms. The tool is designed for efficiency, automatically splitting inputs into genomic regions to enable parallel processing across multiple cores.

## Command Line Usage

### Parallel Merging
Use the `merge` command to combine multiple VCF files into a single output. This process is parallelized by genomic region.

```bash
bcbio-variation-recall merge -c [CORES] out.vcf.gz ref.fa sample1.vcf sample2.vcf
```

*   **Input**: VCF files can be listed individually or provided as a text file containing paths.
*   **Optimization**: Use the `-r` flag to limit processing to a specific region (e.g., `chr1:100-200`) or a BED file.

### Squaring Off (Joint Recalling)
Use the `square` command to resolve "no-calls" by recalling at identified genomic positions across a cohort. This ensures that every sample has either a variant call or a confirmed reference call at every position found in the cohort.

```bash
bcbio-variation-recall square -c [CORES] -m [CALLER] out.vcf.gz ref.fa sample1.vcf sample1.bam sample2.vcf sample2.bam
```

*   **Critical Requirement**: Sample names in the VCF must exactly match the Read Group (`RG`) names in the BAM/CRAM files.
*   **Callers**: Supported calling methods for the `-m` option include `freebayes` (default), `samtools`, and `platypus`.
*   **Input Handling**: You can provide a text file containing the list of VCF and BAM/CRAM files if the command line becomes too long.

### Ensemble Calling
Use the `ensemble` command to create a consensus callset from multiple different variant callers (e.g., GATK, FreeBayes, and Platypus) run on the same sample.

```bash
bcbio-variation-recall ensemble -c [CORES] -n [NUMPASS] out.vcf.gz ref.fa caller1.vcf caller2.vcf caller3.vcf
```

*   **Consensus Logic**: Use `-n` (default: 2) to specify how many callers must agree for a variant to pass into the final set.
*   **Preference**: The order of input VCFs determines which caller's representation (genotype/attributes) is preferred in the final output.
*   **Filtering**: Use `--nofiltered` to ignore variants that have already been marked as filtered in the input VCFs.

## Expert Tips and Best Practices

*   **Resource Management**: Always specify the `-c` (cores) parameter to match your environment, as the tool is built specifically to leverage parallelization.
*   **Region-Based Processing**: For large genomes, use the `-r` option with a BED file to process specific targets (like exome baits) to significantly reduce runtime.
*   **Dependency Check**: Ensure that the underlying algorithm tools (freebayes, samtools, bcftools, etc.) are in your system PATH. If using the `bcbio-nextgen` pipeline, these are typically managed automatically.
*   **File Formats**: While the tool accepts standard VCFs, using bgzipped and tabix-indexed VCFs is recommended for performance and compatibility with the parallelization engine.

## Reference documentation
- [bcbio-variation-recall Overview](./references/anaconda_org_channels_bioconda_packages_bcbio-variation-recall_overview.md)
- [bcbio-variation-recall GitHub Documentation](./references/github_com_bcbio_bcbio.variation.recall.md)