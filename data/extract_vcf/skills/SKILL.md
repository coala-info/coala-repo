---
name: extract_vcf
description: `extract_vcf` is a Python tool designed to standardize the extraction of information from VCF files, which often contain inconsistent or complex annotation formats.
homepage: https://github.com/moonso/extract_vcf
---

# extract_vcf

## Overview

`extract_vcf` is a Python tool designed to standardize the extraction of information from VCF files, which often contain inconsistent or complex annotation formats. Instead of writing custom regex for every field, you define extraction logic in a simple `.ini` configuration file. The tool creates "plugins" based on these rules to handle data typing (float, int, str, flag) and multi-value resolution (e.g., taking the maximum CADD score from a comma-separated list).

## Configuration Patterns

The core of `extract_vcf` is the `.ini` configuration file. Every config must include a `[Version]` section followed by individual plugin sections.

### Mandatory Version Section
```ini
[Version]
version = 0.1
name = my_extraction_profile
```

### Plugin Definitions
Each plugin represents a specific field or annotation you want to extract.

| Field | Description | Options |
|-------|-------------|---------|
| `field` | The VCF column to target | `ID`, `FILTER`, `QUAL`, `INFO` |
| `data_type` | The Python type to return | `float`, `int`, `str`, `flag` |
| `record_rule` | Logic for multiple values | `min`, `max`, `eq` |
| `separators` | Character used to split values | Usually `','` |
| `info_key` | The key inside the INFO column | Required if `field = INFO` |

### Example: Extracting Allele Frequency and Impact Scores
```ini
[ExAC_AF]
field = INFO
info_key = AF
data_type = float
record_rule = max
separators = ','

[CADD_Score]
field = INFO
info_key = CADD
data_type = float
record_rule = max
separators = ','

[Is_DBSNP]
field = ID
data_type = flag
```

## Python API Usage

To use the skill in a script, initialize the `ConfigParser` and apply plugins to variant lines.

```python
import extract_vcf

# 1. Load the configuration
configs = extract_vcf.ConfigParser("my_config.ini")

# 2. Process VCF lines (skipping headers)
with open("input.vcf", 'r') as f:
    for line in f:
        if line.startswith('#'):
            continue
        
        # The tool expects the raw variant line
        variant = line.strip()
        
        # 3. Extract values using defined plugins
        for name, plugin in configs.plugins.items():
            value = plugin.get_value(variant)
            print(f"Plugin: {name}, Value: {value}")
```

## Expert Tips

*   **Handling Flags**: Use `data_type = flag` for fields that either exist or don't (like `PASS` in FILTER or a specific ID). The plugin will return a boolean.
*   **Multi-allelic Sites**: When a VCF line has multiple alternative alleles, annotations are often comma-separated. Use `record_rule = max` for deleterious scores (to find the most severe) or `min` for frequencies (to find the rarest).
*   **Raw Data Access**: If you need the unparsed string before the `record_rule` is applied, use `plugin.get_entry(variant)` instead of `get_value()`. This returns a list of all values found.
*   **Missing Data**: If a field or `info_key` is missing for a specific variant, `get_value()` returns `None`. Always include null-handling logic in your downstream processing.

## Reference documentation
- [Extract VCF GitHub Overview](./references/github_com_moonso_extract_vcf.md)
- [Bioconda extract_vcf Package](./references/anaconda_org_channels_bioconda_packages_extract_vcf_overview.md)