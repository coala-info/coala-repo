---
name: allelecodes
description: "A tool for standardizing allele codes (Note: The provided help text contains only system error logs and no usage information)."
homepage: https://github.com/ncezid-biome/AlleleCodes
---

# allelecodes

## Overview
The `allelecodes` tool implements a hierarchical assignment algorithm for core genome Multilocus Sequence Typing (cgMLST) schemes. It compares new allele profiles against a database of legacy profiles to determine the appropriate nomenclature code based on organism-specific distance thresholds. This is essential for public health genomics workflows where consistent, standardized naming of genomic clusters is required for surveillance and outbreak investigation.

## CLI Usage and Patterns

The primary script for modern environments is `assignAlleleCodes_py3.6.py`.

### Basic Command Structure
```bash
assignAlleleCodes_py3.6.py \
  --alleles <input_profiles.tsv> \
  --config <core_loci.txt> \
  --datadir <database_folder> \
  --prefix <organism_prefix> \
  --output <results.tsv>
```

### Required Arguments
- **--alleles (-a)**: A TSV file where column 1 is the Sample ID/Key, and subsequent columns are locus names with allele integers.
- **--config (-c)**: A headerless text file listing the names of core loci (one per line) to be included in the distance calculation.
- **--datadir (-d)**: The directory containing the reference nomenclature data (tree files and legacy profiles).
- **--prefix (-p)**: The organism-specific prefix (e.g., `CAMP` for Campylobacter) used to locate subfolders and format the output codes.

### Common Workflow Patterns

**1. Standard Assignment with File Output**
To assign codes and save the results to a specific file (format determined by extension):
```bash
assignAlleleCodes_py3.6.py -a BN.tsv -c coreLoci.txt -d nomenclature_db -p CAMP --output results.csv
```

**2. Dry Run / Terminal Only**
If you want to check assignments without updating the local database or saving tree files:
```bash
assignAlleleCodes_py3.6.py -a BN.tsv -c coreLoci.txt -d nomenclature_db -p CAMP --nosave
```

**3. Debugging and Logging**
Use `--verbose` to mirror log file entries to the terminal, which is helpful for tracking how the algorithm navigates the single-linkage tree:
```bash
assignAlleleCodes_py3.6.py -a BN.tsv -c coreLoci.txt -d nomenclature_db -p CAMP --verbose
```

## Expert Tips and Best Practices

- **Input Formatting**: Ensure your allele profile headers exactly match the locus names provided in your config file. Discrepancies will lead to incorrect distance calculations.
- **Data Directory Structure**: The tool expects a specific internal structure within the `--datadir`. It looks for `<prefix>_nomenclature_srcfiles/` containing `allele_calls` and `tree` subdirectories.
- **Hierarchical Logic**: The tool follows a specific logic:
    - If a single reference remains within the threshold, the code is retained.
    - If multiple references remain, it may trigger a code merge or reassessment.
    - If no reference remains, a new integer is assigned at that hierarchical level.
- **Output Interpretation**: The main output file contains the sample ID and the assigned code (e.g., `CAMP2.1-3.1.15.1.1.1`). Check the `change_log` directory within your data folder to see if any existing codes were modified during the run due to new genomic links.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_ncezid-biome_AlleleCodes.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_allelecodes_overview.md)