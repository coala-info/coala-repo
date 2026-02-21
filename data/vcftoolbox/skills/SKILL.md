---
name: vcftoolbox
description: vcftoolbox is a specialized Python-based toolkit designed for the programmatic and command-line manipulation of Variant Call Format (VCF) files.
homepage: http://github.com/moonso/vcftoolbox
---

# vcftoolbox

## Overview
vcftoolbox is a specialized Python-based toolkit designed for the programmatic and command-line manipulation of Variant Call Format (VCF) files. It is particularly effective for bioinformaticians who need to parse complex headers, handle VEP (Variant Effect Predictor) or SnpEff annotations, and perform structural edits to VCF INFO fields. While it provides a robust Python API for custom scripting, it also includes built-in utilities for sorting variants and managing genotype information.

## Installation and Setup
Install vcftoolbox via the Bioconda channel:
```bash
conda install bioconda::vcftoolbox
```

## Command Line Usage
The tool provides a basic CLI for common VCF maintenance tasks.

### Sorting VCF Files
Use the sort functionality to ensure variants are ordered correctly by chromosome and position, which is a prerequisite for many downstream analysis tools.
```bash
# Basic sort command pattern
vcftoolbox sort <input.vcf>
```

### Modifying INFO Fields
The toolkit allows for the removal or addition of specific INFO field keys directly from the command line.
- Use the CLI to strip unnecessary metadata to reduce file size.
- Add custom annotations to the INFO column for downstream filtering.

## Python API Best Practices
For complex workflows, use the Python library components directly.

### Header Parsing
The `HeaderParser` class is the core for managing VCF metadata.
- Use it to extract `vep_columns` or `individuals` from the header.
- It supports standard VCF keys: `INFO`, `FILTER`, `FORMAT`, `CONTIG`, and `ALT`.

### Variant Manipulation
- **ID Generation**: Use `get_variant_id(variant_dict)` to create standardized `CHROM_POS_REF_ALT` strings.
- **INFO Parsing**: Use `get_info_dict(info_line)` to transform the semicolon-separated INFO string into a manageable Python dictionary.
- **VEP Annotations**: Use `get_vep_info(vep_string, vep_header)` to parse the CSQ field into a list of dictionaries mapped to the VEP header.

### Genotype Handling
The `Genotype` class provides attributes for quick variant assessment:
- `has_variant`: Boolean check if the sample has a non-reference call.
- `allele_depth`: Access to AD values.
- `homo_alt` / `heterozygote`: Quick zygosity checks.

## Expert Tips
- **Memory Efficiency**: When working with large VCFs, use the utility functions to process files line-by-line rather than loading the entire file into memory.
- **Header Consistency**: Always use the `HeaderParser` to validate that your VCF follows the expected format before performing bulk INFO field replacements.
- **VEP Integration**: When parsing VEP data, ensure you pass the correct `vep_header` list (usually found in the VCF header under the CSQ description) to `get_vep_info` to ensure correct key-value mapping.

## Reference documentation
- [github_com_moonso_vcftoolbox.md](./references/github_com_moonso_vcftoolbox.md)
- [anaconda_org_channels_bioconda_packages_vcftoolbox_overview.md](./references/anaconda_org_channels_bioconda_packages_vcftoolbox_overview.md)
- [github_com_moonso_vcftoolbox_commits_master.md](./references/github_com_moonso_vcftoolbox_commits_master.md)