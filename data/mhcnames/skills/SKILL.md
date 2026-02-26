---
name: mhcnames
description: mhcnames is a utility for parsing and standardizing MHC and HLA allele naming conventions. Use when user asks to parse allele names into structured components, compact allele strings for legacy tools, or clean immunological data for MHC binding predictors.
homepage: https://github.com/hammerlab/mhcnames
---


# mhcnames

## Overview
mhcnames is a specialized utility designed to handle the complexities and variations in MHC (specifically HLA) naming conventions. It provides a programmatic way to standardize allele strings, making it easier to process immunological data where naming formats may be inconsistent. While the library is lightweight, it is essential for tasks involving allele identification, data cleaning, and preparing inputs for MHC binding predictors.

## Installation
Install the library via Conda or pip:
```bash
conda install bioconda::mhcnames
# OR
pip install mhcnames
```

## Core Python Usage
The library is primarily used within Python scripts to parse or simplify allele names.

### Parsing Allele Names
Use `parse_allele_name` to break a string into its structured components.
```python
import mhcnames

allele = mhcnames.parse_allele_name("HLA-A0201")
# Result: AlleleName(species='HLA', gene='A', allele_family='02', allele_code='01')

print(allele.gene)          # 'A'
print(allele.allele_family) # '02'
```

### Compacting Allele Names
Use `compact_allele_name` to convert standard or long-form nomenclature into a condensed format often required by legacy tools or specific machine learning models.
```python
import mhcnames

compact = mhcnames.compact_allele_name("HLA-A*02:01")
# Result: 'A0201'
```

## Best Practices and Tips
- **Legacy Support**: mhcnames is highly effective for legacy datasets using the 4-digit naming convention (e.g., A0201).
- **Deprecation Note**: The developers (OpenVax/Hammer Lab) have deprecated this tool in favor of `mhcgnomes`. If you encounter complex alleles that `mhcnames` fails to parse, or if you need support for non-human MHC nomenclature, consider switching to `mhcgnomes`.
- **Data Cleaning**: Always use `compact_allele_name` when preparing CSV or TSV files for MHC-binding affinity predictors (like NetMHCpan) to ensure the allele strings match the expected input format of the predictor.

## Reference documentation
- [mhcnames Overview](./references/anaconda_org_channels_bioconda_packages_mhcnames_overview.md)
- [mhcnames GitHub Repository](./references/github_com_openvax_mhcnames.md)