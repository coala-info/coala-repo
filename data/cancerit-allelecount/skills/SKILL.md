---
name: cancerit-allelecount
description: This tool extracts allele-specific coverage and nucleotide counts from sequencing alignment files at specified genomic loci. Use when user asks to count alleles at specific positions, extract coverage for copy number analysis, or convert allele counts to JSON format.
homepage: https://github.com/cancerit/alleleCount
metadata:
  docker_image: "quay.io/biocontainers/cancerit-allelecount:4.3.0--h8bd2d3b_7"
---

# cancerit-allelecount

## Overview
The `cancerit-allelecount` skill provides a specialized interface for extracting allele-specific coverage from sequencing alignment files. It is primarily used in cancer genomics to provide the raw data required by copy number algorithms to determine allelic imbalance and clonal architectures. The tool processes a list of genomic coordinates (loci) and a corresponding BAM or CRAM file to produce a table of counts for each nucleotide at those positions, applying user-defined quality filters.

## Command Line Usage

### Basic C Implementation
The C version (`alleleCounter`) is the preferred tool for speed and standard allele counting tasks.

```bash
alleleCounter --locus <loci_file> --bam <input.bam> --ref <reference.fasta> --out <output.tsv>
```

**Key Parameters:**
- `--locus`: Tab-separated file containing chromosome and 1-based positions.
- `--bam` / `--hts-file`: The input BAM or CRAM file.
- `--ref`: The reference genome FASTA file (required for CRAM).
- `--min-base-qual`: Minimum base quality to include a read (default is often 20).
- `--min-map-qual`: Minimum mapping quality of the read.

### Perl Wrapper
The Perl version (`alleleCounter.pl`) provides additional functionality, such as support for SNP6 loci files.

```bash
alleleCounter.pl -l <loci_file> -b <input.bam> -o <output.tsv>
```

### Working with Dense SNPs
When processing a high density of SNPs, use the `--dense-snps` flag in the C version to optimize performance. This requires the input loci file to be strictly sorted.

**Sorting Loci:**
```bash
sort -k1,1 -k2,2n loci_unsrt.tsv > loci_sorted.tsv
```

**Running in Dense Mode:**
```bash
alleleCounter --dense-snps --locus loci_sorted.tsv --bam input.bam --out output.tsv
```

### JSON Conversion
To convert the standard TSV output into a JSON genotype format for downstream tools:

```bash
alleleCounterToJson.pl <alleleCount_output.tsv> <output.json>
```

## Best Practices and Tips
- **Parameter Syntax**: When using long-form parameters in the C version, you must use an equals sign (e.g., `--min-base-qual=10` instead of `--min-base-qual 10`).
- **CRAM Support**: Always provide the reference genome path when working with CRAM files to ensure proper decompression and allele recovery.
- **Filtering**: Adjust `--min-base-qual` and `--min-map-qual` to match the stringency of your variant calling pipeline to ensure consistency between SNV calls and copy number data.
- **Input Validation**: Ensure the chromosome naming convention (e.g., "chr1" vs "1") in your loci file matches the header of your BAM/CRAM file exactly.

## Reference documentation
- [github_com_cancerit_alleleCount.md](./references/github_com_cancerit_alleleCount.md)
- [anaconda_org_channels_bioconda_packages_cancerit-allelecount_overview.md](./references/anaconda_org_channels_bioconda_packages_cancerit-allelecount_overview.md)