---
name: vawk
description: vawk is a VCF parser that mimics awk's functionality for efficient data extraction and manipulation. Use when user asks to filter, transform, or extract specific fields from VCF files using pattern matching and scripting.
homepage: https://www.gnu.org/software/gawk/
metadata:
  docker_image: "quay.io/biocontainers/vawk:0.0.2--py27_0"
---

# vawk

yaml
name: vawk
description: A VCF (Variant Call Format) parser that mimics awk's functionality for efficient data extraction and manipulation. Use when you need to process VCF files by filtering, transforming, or extracting specific fields using pattern matching and scripting, similar to how you would use awk on text files.
---
## Overview

vawk is a specialized tool designed for parsing and manipulating Variant Call Format (VCF) files. It provides an `awk`-like interface, allowing users to apply powerful text-processing logic to VCF data. This is particularly useful for filtering variants based on specific criteria, extracting particular columns or fields, and reformatting VCF data for downstream analysis or reporting.

## Usage

vawk operates on VCF files, enabling you to process them using `awk`-style commands.

### Basic Filtering and Extraction

You can filter lines or extract specific columns from a VCF file. VCF files have a standard structure with a header (lines starting with `#`) and data lines. vawk can handle both.

**Example: Print all lines from a VCF file (similar to `cat`)**

```bash
vawk '{ print }' input.vcf
```

**Example: Print only the header lines**

```bash
vawk '/^#/' input.vcf
```

**Example: Print only data lines**

```bash
vawk '!/^#/' input.vcf
```

**Example: Extract specific fields (e.g., CHROM, POS, REF, ALT, QUAL)**

VCF fields are tab-separated. vawk uses `$1`, `$2`, etc., to refer to these fields.

```bash
vawk -F'\t' '{ print $1, $2, $3, $4, $5, $10 }' input.vcf
```
*   `-F'\t'` specifies the tab character as the field separator.
*   `$1` is CHROM, `$2` is POS, `$3` is ID, `$4` is REF, `$5` is ALT, and `$10` is the INFO field (which itself is key-value pairs).

**Example: Filter variants with a QUAL score greater than 50**

```bash
vawk -F'\t' '$5 > 50 { print }' input.vcf
```

### Working with the INFO Field

The INFO field (typically `$10`) contains semi-colon separated key-value pairs. You can parse this field further.

**Example: Extract the DP (Depth) value from the INFO field**

This requires more advanced string manipulation within vawk.

```bash
vawk -F'\t' '{
    split($10, info_fields, ";");
    for (i in info_fields) {
        split(info_fields[i], kv, "=");
        if (kv[1] == "DP") {
            print $1, $2, kv[2];
            next; # Move to the next line once DP is found
        }
    }
}' input.vcf
```

### Common CLI Patterns

*   **Piping input**: vawk can read from standard input, making it easy to pipe output from other tools.

    ```bash
    cat input.vcf | vawk '{ print $1 }'
    ```

*   **Redirecting output**: Save the processed output to a new file.

    ```bash
    vawk '/^#/' input.vcf > header.txt
    ```

### Expert Tips

*   **Understand VCF Structure**: Familiarize yourself with the VCF specification, especially the header lines and the INFO field format, to effectively use vawk.
*   **Field Indexing**: Remember that the standard VCF fields are 1-indexed (CHROM is `$1`, POS is `$2`, etc.). The INFO field is `$10`, and the FORMAT and sample columns follow.
*   **String Functions**: Leverage `awk`'s built-in string functions like `split()`, `gsub()`, `sub()`, `index()`, `substr()` for complex parsing of fields, especially the INFO and genotype columns.
*   **Conditional Logic**: Use `if`, `else if`, `else` statements for complex filtering based on multiple criteria.
*   **Loops**: Employ `for` loops to iterate over fields or parsed components of fields.

## Reference documentation

- [vawk - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_vawk_overview.md)
- [Gawk - GNU Project - Free Software Foundation (FSF)](./references/www_gnu_org_software_gawk.md)