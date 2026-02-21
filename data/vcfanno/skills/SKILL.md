---
name: vcfanno
description: vcfanno is a fast, flexible tool written in Go for annotating VCF files.
homepage: https://github.com/brentp/vcfanno
---

# vcfanno

## Overview

vcfanno is a fast, flexible tool written in Go for annotating VCF files. It allows you to integrate information from an unlimited number of source files into a query VCF's INFO field. Unlike many annotators that are restricted to specific databases, vcfanno uses a simple configuration file to map source fields to the output. It supports various "operations" to handle multiple overlaps (such as mean, max, or concatenation) and features a powerful post-annotation system using Lua for custom calculations like allele frequency or ID field manipulation.

## Command Line Usage

The basic syntax for running vcfanno is:

```bash
vcfanno [flags] config.toml query.vcf.gz > annotated.vcf
```

### Common Flags
- `-p <int>`: Number of processes to use (default is 1). Increasing this significantly improves speed on multi-core systems.
- `-lua <file.lua>`: Path to a custom Lua script containing functions for complex annotations or post-annotation logic.
- `-ends`: Annotate the left and right ends of a variant in addition to the interval itself. This is critical for Structural Variants (SVs) and CNVs.
- `-permissive-overlap`: By default, vcfanno requires variants to share the same position and alleles. Use this flag to allow annotations based on coordinate overlap alone.

## Configuration (TOML)

vcfanno uses TOML for configuration. Each source file is defined in an `[[annotation]]` block.

### Annotation Block Fields
- `file`: Path to the source file (VCF, BED, or BAM). Can be a local path or a URL.
- `fields`: (VCF only) The INFO fields to pull from the source. Special values include `ID` and `FILTER`.
- `columns`: (BED only) The 1-based column numbers to pull.
- `names`: The names of the new INFO fields in the output VCF.
- `ops`: The operation to apply to the data.

### Supported Operations
- `self`: Pulls directly from the source (best for VCF-to-VCF matching).
- `concat`: Comma-delimited list of all overlapping values.
- `uniq`: Comma-delimited list of unique overlapping values.
- `count`: Number of overlapping features.
- `sum`, `mean`, `min`, `max`: Mathematical reductions for numeric data.
- `first`: Takes only the first overlapping value.
- `flag`: Sets a VCF flag if an overlap exists.
- `by_alt`: Matches annotations to specific alleles (Number=A).
- `lua:<expression>`: Applies a custom Lua function to the values.

## Post-Annotation

`[[postannotation]]` blocks allow you to perform logic on the INFO fields *after* all primary annotations are complete.

**Example: Calculating Allele Frequency**
```toml
[[postannotation]]
fields = ["AC", "AN"]
op = "lua:AC / AN"
name = "AF"
type = "Float"
```

## Expert Tips and Best Practices

### Typecasting
By default, operations like `mean` or `max` result in Float types, while `self` inherits the source type. To force a specific type in the output, append `_int` or `_float` to the field name in the `names` array. vcfanno will parse the suffix, set the VCF header type accordingly, and then remove the suffix from the final field name.

### BAM File Annotation
vcfanno can pull data directly from BAM files. Supported fields include:
- `depth` (use `count` op)
- `mapq` (use `mean` op)
- `seq` (use `concat` op)

### Structural Variants (SVs)
When using the `-ends` flag, vcfanno automatically creates `left_` and `right_` prefixed versions of your defined names. This allows you to see the genomic context at both breakpoints of a large deletion or inversion.

### Performance
For maximum throughput:
1. Ensure all source files are indexed (using `tabix` for VCF/BED or `samtools index` for BAM).
2. Use the `-p` flag to match the available CPU cores on your server.
3. Use `bgzip` compressed input VCFs.

## Reference documentation
- [vcfanno Main Documentation](./references/github_com_brentp_vcfanno.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_vcfanno_overview.md)