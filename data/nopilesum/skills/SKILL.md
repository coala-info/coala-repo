---
name: nopilesum
description: nopilesum performs allele counting on genomic alignments against known variant sites to produce summaries similar to GATK4's GetPileupSummaries. Use when user asks to summarize genomic alignments, count alleles at known variant sites, or perform lightweight pileup summaries with low memory usage.
homepage: https://github.com/blachlylab/nopilesum
metadata:
  docker_image: "quay.io/biocontainers/nopilesum:1.1.2--h5884fcd_0"
---

# nopilesum

## Overview
nopilesum is a specialized tool written in D that performs allele counting to produce results similar to GATK4's GetPileupSummaries. Its primary advantage is a significantly lower memory footprint, achieved by avoiding traditional pileup operations. Use this tool when GATK4's memory usage is incompatible with your system or when you require a faster, lightweight approach to summarizing genomic alignments against known variant sites.

## Usage Instructions

### Basic Command Line
The tool requires an alignment file (BAM/SAM) and a variant file (VCF/BCF). It outputs the summary to stdout.

```bash
nopilesum <input.bam> <input.vcf> > summary.txt
```

### Filtering by Allele Frequency
You can control which VCF records are used for the summary by setting allele frequency (AF) thresholds. This is useful for focusing on common or rare variants depending on your study.

- **Exclude high-frequency variants**: Use `--max-af` (default is 0.2).
- **Exclude low-frequency variants**: Use `--min-af` (default is 0.01).

Example:
```bash
nopilesum --min-af 0.05 --max-af 0.15 sample.bam variants.vcf > filtered_summary.txt
```

### Handling Different File Types
nopilesum natively supports several file formats and compression types:
- **Alignments**: BAM or SAM.
- **Variants**: VCF or BCF.
- **Compression**: Automatically resolves and opens gzipped and bgzipped files.
- **Remote Access**: Capable of opening remote files directly via URL.

### Troubleshooting and Debugging
If you encounter discrepancies or need to verify the tool's logic:
- Use `-v` or `--verbose` to see warnings during execution.
- Use `--debug` to output extra information regarding the internal processing steps.

## Best Practices
- **Memory Constraints**: Use nopilesum as your default for pileup summaries on cloud instances or local machines with less than 8GB of RAM, where GATK4 often fails.
- **Validation**: While nopilesum aims for parity with GATK4, the author notes occasional discrepancies where nopilesum may actually be more accurate (validated via IGV). If results differ significantly, use the `--debug` flag to inspect the allele counting logic.
- **Installation**: For most users, installation via Bioconda is recommended for dependency management: `conda install bioconda::nopilesum`.

## Reference documentation
- [nopilesum GitHub Repository](./references/github_com_blachlylab_nopilesum.md)
- [nopilesum Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_nopilesum_overview.md)