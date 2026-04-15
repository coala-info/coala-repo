---
name: vcfexpress
description: vcfexpress rapidly manipulates genomic variant files using Lua expressions for advanced filtering, custom output, and on-the-fly modifications. Use when user asks to filter variants, create custom output formats, modify VCF headers, add or modify INFO fields, parse complex INFO fields, or perform sample-level filtering.
homepage: https://github.com/brentp/vcfexpress/
metadata:
  docker_image: "quay.io/biocontainers/vcfexpress:0.3.4--h3ab6199_0"
---

# vcfexpress

## Overview

vcfexpress is a Rust-powered utility designed for rapid manipulation of genomic variant files. By leveraging Lua (specifically Luau) as an expression language, it allows users to write sophisticated filtering logic and custom output templates that execute at speeds comparable to native tools. It is particularly useful for tasks involving complex sample-level filtering, parsing CSQ/ANN fields, and on-the-fly header modification.

## Core Usage Patterns

### Basic Filtering
Filter variants based on standard VCF fields or INFO tags.
```bash
# Filter by ID and output a custom BED format
vcfexpress filter -e "return variant.id == 'rs2124717267'" \
  --template '{variant.chrom}\t{variant.start}\t{variant.stop}' \
  -o var.bed input.vcf

# Filter by INFO field value
vcfexpress filter -e "return variant:info('AN') > 3000" -o high_an.bcf input.vcf
```

### Sample-Level Logic
vcfexpress provides helper functions like `all`, `any`, and `filter` for working with FORMAT fields across samples.
```bash
# Keep variants where ALL samples have DP > 10
vcfexpress filter -e 'return all(function (dp) return dp > 10 end, variant:format("DP"))' \
  -o all-high-dp.bcf input.vcf

# Filter based on a specific sample's genotype and quality
vcfexpress filter -e 's=variant:sample("NA12878"); return s.DP > 10 and s.GQ > 20 and s.GT[1] == 1' \
  input.vcf
```

### Modifying Headers and INFO Fields
Use a "prelude" script to define new header lines, then use `--set-expression` to populate them.

1. Create `pre.lua`:
   ```lua
   header:add_info({ID="AF_COPY", Number=1, Description="Copied AF field", Type="Float"})
   ```
2. Run the command:
   ```bash
   vcfexpress filter -p pre.lua \
     -s 'AF_COPY=return variant:info("AF", 0)' \
     input.vcf > output.vcf
   ```

## Lua API Reference

### Variant Object Attributes
- `variant.chrom`: String
- `variant.pos`: 0-based integer (get/set)
- `variant.id`: String (get/set)
- `variant.REF`: String (get/set)
- `variant.ALT`: Vector of strings (get/set)
- `variant.qual`: Number (get/set)
- `variant.FILTER`: String (first filter reported)

### Variant Methods
- `variant:info("KEY")`: Returns number, string, bool, or vector.
- `variant:format("KEY")`: Returns a vector of values (one per sample).
- `variant:sample("NAME")`: Returns a table of all FORMAT fields for that sample.
- `variant:samples()`: Returns a table keyed by sample name containing all FORMAT fields.

### Header Methods (Prelude only)
- `header:add_info({ID=..., Number=..., Type=..., Description=...})`
- `header:add_format(...)`
- `header:add_filter(...)`

## Expert Tips

- **Performance**: Using `variant:samples()` is more efficient than calling `variant:sample("NAME")` multiple times if you need to access data for many different samples in one expression.
- **Debugging**: Use `pprint(variant:sample("NAME"))` within an expression to see the available fields and structure of a sample's data.
- **Complex Parsing**: For complex fields like VEP/SnpEff `ANN` or `CSQ` tags, move the parsing logic into a separate Lua script and load it with `-p`. This keeps the command line clean and allows for reusable parsing logic.
- **String Interpolation**: The `--template` flag uses Luau string interpolation. You can include any valid Lua expression inside the curly braces `{}`.

## Reference documentation
- [vcfexpress GitHub Repository](./references/github_com_brentp_vcfexpress.md)
- [vcfexpress Lua API Documentation](./references/github_com_brentp_vcfexpress_1.md)