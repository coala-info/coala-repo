---
name: perl-sanger-cgp-allelecount
description: This tool generates coverage counts for each allele at specific genomic locations from BAM or CRAM files. Use when user asks to count allele frequencies at specific loci, generate input for copy number algorithms like AscatNGS or Battenberg, or convert allele counts to JSON format.
homepage: https://github.com/cancerit/alleleCount
---


# perl-sanger-cgp-allelecount

## Overview

The `alleleCount` package is a specialized utility designed to generate coverage counts for each allele (A, C, G, and T) at specific genomic locations. It is primarily used as a support tool for copy number algorithms such as AscatNGS and Battenberg. The package provides both a high-performance C implementation (`alleleCounter`) and a Perl wrapper (`alleleCounter.pl`) that maintains compatibility with legacy workflows while utilizing the speed of the C backend. It is essential for transforming raw alignment data (BAM/CRAM) into the allele-specific frequency tables required for downstream genomic analysis.

## Usage Patterns

### C Implementation (alleleCounter)
The C version is the preferred tool for performance. It accepts a loci file and a BAM/CRAM file to generate a TSV output.

**Basic Command:**
```bash
alleleCounter --l <loci_file> --b <input_file> --o <output_file> [options]
```

**Key Parameters:**
- `-l, --loci`: Path to the tab-separated loci file.
- `-b, --hts-file`: Path to the input BAM or CRAM file.
- `-o, --output`: Path for the output TSV file.
- `--min-base-qual`: Minimum base quality to include a read (default is often 20).
- `--dense-snps`: Optimized mode for processing a high density of SNPs.

### Perl Implementation (alleleCounter.pl)
The Perl version provides additional flexibility for specific input/output types, such as SNP6 loci files.

**Basic Command:**
```bash
alleleCounter.pl --l <loci_file> --b <input_file> --o <output_file> [options]
```

### JSON Conversion
For workflows requiring JSON formatted genotypes, use the conversion utility:
```bash
alleleCounterToJson.pl <alleleCounter_output> <output_json>
```

## Best Practices and Expert Tips

### Parameter Syntax
When using the C version (`alleleCounter`), long-form parameter names require an equals sign (`=`) to assign values.
- **Correct:** `--min-base-qual=10`
- **Incorrect:** `--min-base-qual 10`

### Loci File Preparation
The input loci file must be a simple tab-formatted file containing the chromosome and 1-based positions:
```text
<CHR>   <POS>
1       10045
1       10230
```

### Dense SNP Mode
If you are using the `--dense-snps` flag in the C version, the loci file **must** be sorted numerically by chromosome and then by position. Use the following command to ensure correct sorting:
```bash
sort -k1,1 -n -k2,2n loci_unsorted.tsv > loci_sorted.tsv
```

### SNP6 Loci (Perl Only)
The Perl version supports a more complex SNP6 loci format which includes reference alleles and IDs:
` <CHR> <tab> <POS> <tab> <REF_ALL> <tab> <ID> <tab> <ALLELE_A> <tab> <ALLELE_B> `
This format is specifically used for workflows involving Affymetrix SNP6.0 arrays.

### Performance
As of version 4.0, the Perl code acts as a wrapper for the C implementation. If you are experiencing performance bottlenecks in a custom Perl script, ensure you are using v4+ to benefit from the underlying C speed.

## Reference documentation
- [alleleCount GitHub Repository](./references/github_com_cancerit_alleleCount.md)
- [Bioconda perl-sanger-cgp-allelecount Overview](./references/anaconda_org_channels_bioconda_packages_perl-sanger-cgp-allelecount_overview.md)