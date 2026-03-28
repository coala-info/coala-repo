---
name: mimi
description: MIMI identifies chemical formulas in metabolomics data by matching mass spectrometry signals against compound databases and verifying isotopic fine-structure patterns. Use when user asks to extract metabolite information from KEGG or HMDB, create pre-computed isotope caches, or perform high-precision mass analysis and formula identification.
homepage: https://github.com/NYUAD-Core-Bioinformatics/MIMI
---


# mimi

## Overview
MIMI (Molecular Isotope Mass Identifier) is a specialized bioinformatics tool for high-precision metabolomics. It automates the identification of chemical formulas by comparing experimental mass spectrometry signals against known compound databases like KEGG and HMDB. The tool is particularly effective for experiments requiring high confidence, as it verifies initial mass matches by searching for specific isotopic fine-structure patterns. It supports batch processing and is optimized for speed through the use of pre-computed cache files.

## Command Line Usage

### 1. Database Preparation
Extract compounds within a specific mass range to create a reference TSV.

**From KEGG:**
```bash
mimi_kegg_extract -l [lower_mass] -u [upper_mass] -o [output_path.tsv]
```

**From HMDB:**
Requires the `hmdb_metabolites.xml` file.
```bash
mimi_hmdb_extract -l [lower_mass] -u [upper_mass] -x [path_to_hmdb.xml] -o [output_path.tsv]
```

### 2. Cache Generation
Creating cache files is a prerequisite for analysis and significantly improves performance.

**Natural Abundance Cache:**
```bash
mimi_cache_create -i [neg|pos] -d [database.tsv] -c [cache_prefix]
```

**Isotope-Labeled Cache (e.g., 95% C13):**
Requires an isotope configuration JSON file.
```bash
mimi_cache_create -i [neg|pos] -l [isotope_config.json] -d [database.tsv] -c [cache_prefix]
```

### 3. Mass Analysis
Perform the final identification and verification.

```bash
mimi_mass_analysis -p [ppm_threshold] -vp [verification_ppm] -c [cache_files...] -s [sample.asc] -o [results.tsv]
```

## Best Practices and Expert Tips
- **Input Format**: Ensure your input peak list (`.asc`) is a three-column tab-delimited file: `Mass (m/z)`, `Intensity`, and `Resolution`.
- **PPM Tuning**: Use the `-p` flag for the initial mass matching threshold and `-vp` for the stricter isotopic pattern verification threshold. For UHR-FT-ICR data, values around 1.0 PPM are standard.
- **Batch Processing**: You can pass multiple cache files to `mimi_mass_analysis` to compare a single sample against multiple isotope profiles (e.g., natural abundance and labeled standards) simultaneously.
- **Ion Mode**: Always specify the correct ionization mode (`neg` or `pos`) during cache creation to ensure theoretical masses are calculated correctly.
- **Memory Management**: For very large databases, ensure the mass range (`-l` and `-u`) is as narrow as your experiment allows to keep cache sizes manageable.



## Subcommands

| Command | Description |
|---------|-------------|
| mimi_cache_create | Molecular Isotope Mass Identifier |
| mimi_hmdb_extract | Extract metabolite information from HMDB XML file |
| mimi_mass_analysis | Molecular Isotope Mass Identifier |

## Reference documentation
- [MIMI GitHub README](./references/github_com_NYUAD-Core-Bioinformatics_MIMI_blob_main_README.md)
- [MIMI Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mimi_overview.md)