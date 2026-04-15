---
name: vcfpy
description: vcfpy is a Python 3 library for programmatically handling VCF files. Use when user asks to read VCF files, write VCF files, modify variant records, or add new fields to VCF headers.
homepage: https://github.com/bihealth/vcfpy
metadata:
  docker_image: "quay.io/biocontainers/vcfpy:0.14.2--pyhdfd78af_0"
---

# vcfpy

## Overview
vcfpy is a Python 3 library designed to provide a robust and "pythonic" interface for handling VCF files. Unlike older libraries such as PyVCF, vcfpy uses a dictionary-based approach for INFO and FORMAT fields, which simplifies the process of updating record metadata and per-sample data. It is the preferred tool when your workflow involves complex modifications to variant records or requires native support for reading and jumping within BGZF-compressed files.

## Core Usage Patterns

### Reading VCF Files
To read a VCF file, use the `vcfpy.Reader` class. It handles both plain text and compressed (.gz, .bgz) files automatically.
- Use `vcfpy.Reader.from_path('filename.vcf')` to initialize.
- Iterate over the reader object to process `vcfpy.Record` objects sequentially.
- Access header information via `reader.header`.

### Writing VCF Files
When creating or modifying VCFs, use the `vcfpy.Writer` class.
- Initialize with `vcfpy.Writer.from_path('output.vcf', reader.header)`.
- Use the `write_record(record)` method to output variants.
- Ensure the header is correctly defined, as vcfpy enforces consistency between the header and the records being written.

### Modifying Records
The primary advantage of vcfpy is its dict-based interface for metadata.
- **INFO fields**: Access and modify via `record.INFO['KEY']`.
- **Genotype data**: Access sample-specific information through `record.calls`. Each call object contains the sample's genotype and FORMAT field data.
- **Adding Fields**: To add a new FORMAT or INFO field, you must first add the corresponding header line to the `vcfpy.Header` object before initializing the Writer.

### Working with Compressed Files
vcfpy has built-in support for BGZF (Blocked GNU Zip Format).
- It can read and write `.vcf.gz` and `.bgz` files directly.
- For random access (jumping to specific coordinates), ensure the VCF is indexed (e.g., using tabix) and use the appropriate fetch methods if available in the environment.

## Expert Tips and Best Practices
- **Python 3 Only**: vcfpy is built specifically for Python 3. Do not attempt to use it in legacy Python 2 environments.
- **Memory Efficiency**: When processing large VCFs, always iterate through the Reader rather than loading all records into a list to keep the memory footprint low.
- **Header Consistency**: If you are adding new attributes to your variants (like annotation scores), always update the `vcfpy.Header` object with `add_info_line` or `add_format_line` to prevent errors during writing.
- **Attribute Access**: Use the uppercase attributes (e.g., `record.CHROM`, `record.POS`, `record.REF`) for standard VCF columns to ensure code readability and consistency with the VCF specification.

## Reference documentation
- [vcfpy GitHub Repository](./references/github_com_bihealth_vcfpy.md)
- [vcfpy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vcfpy_overview.md)