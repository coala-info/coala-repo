---
name: vartovcf
description: `vartovcf` is a specialized Rust-based utility designed to replace the legacy Perl scripts (like `var2vcf_valid.pl`) bundled with the VarDict variant caller.
homepage: https://github.com/clintval/vartovcf
---

# vartovcf

## Overview

`vartovcf` is a specialized Rust-based utility designed to replace the legacy Perl scripts (like `var2vcf_valid.pl`) bundled with the VarDict variant caller. Its primary purpose is to transform the tabular output of VarDict into a VCF v4.2 or v4.3 compliant file. Unlike its Perl predecessors, `vartovcf` operates using a record-by-record streaming architecture, which ensures a minimal memory footprint and significantly faster processing speeds. It is optimized for modern bioinformatics pipelines where efficiency and VCF specification compliance are critical.

## Installation

The tool is available via Bioconda. It is recommended to use `mamba` for faster dependency resolution:

```bash
mamba install vartovcf
```

## Common CLI Patterns

### Standard Streaming Pipeline
The most common use case involves piping the output of `vardict-java` directly into `vartovcf`. Because `vartovcf` produces unsorted VCF records, you should always pipe the result into `bcftools sort`.

```bash
vardict-java \
  -b input.bam \
  -G reference.fa \
  -N sample_name \
  [other-vardict-options] \
  calling_intervals.bed \
  | vartovcf --reference reference.fa --sample sample_name \
  | bcftools sort -Oz > variants.vcf.gz
```

### Filtering Non-Variants
To reduce the size of the output file and focus only on sites with detected variation, use the `--skip-non-variants` flag (available in version 1.1.0+).

```bash
cat input.var | vartovcf -r ref.fa -s sample_id --skip-non-variants > filtered_variants.vcf
```

## Tool-Specific Best Practices

- **Sorting Requirement**: `vartovcf` does not perform internal sorting of genomic coordinates. Downstream tools (like Tabix or GATK) usually require sorted VCFs. Always follow `vartovcf` with `bcftools sort`.
- **Reference Consistency**: Ensure the FASTA file provided to the `--reference` (or `-r`) argument is the exact same assembly used during the initial VarDict alignment and calling steps to prevent coordinate or header mismatches.
- **Tumor-Only Mode**: Currently, `vartovcf` is optimized for tumor-only workflows (equivalent to `var2vcf_valid.pl`).
- **Performance Monitoring**: The tool utilizes `proglog` for progress logging. When running in an interactive terminal, you will see real-time updates on the number of records processed.

## Expert Tips

- **Memory Efficiency**: Because the tool streams record-by-record, it can handle extremely large variant files (millions of records) without a significant increase in RAM usage, making it suitable for whole-genome sequencing (WGS) data.
- **VCF Compliance**: If you encounter issues with VCF validators on standard VarDict output, switching to `vartovcf` often resolves these as it is strictly compliant with VCF v4.2 and v4.3 specifications.
- **Handling STDIN**: If you are not piping directly from VarDict, you can redirect a saved `.var` file into the tool: `vartovcf -r ref.fa -s sample < input.var`.

## Reference documentation
- [github_com_clintval_vartovcf.md](./references/github_com_clintval_vartovcf.md)
- [anaconda_org_channels_bioconda_packages_vartovcf_overview.md](./references/anaconda_org_channels_bioconda_packages_vartovcf_overview.md)