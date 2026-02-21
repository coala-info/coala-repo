---
name: mimi
description: MIMI (Molecular Isotope Mass Identifier) is a specialized bioinformatics tool for processing ultra-high-resolution Fourier Transform Ion Cyclotron Resonance (UHR-FT-ICR) mass spectrometry data.
homepage: https://github.com/NYUAD-Core-Bioinformatics/MIMI
---

# mimi

## Overview
MIMI (Molecular Isotope Mass Identifier) is a specialized bioinformatics tool for processing ultra-high-resolution Fourier Transform Ion Cyclotron Resonance (UHR-FT-ICR) mass spectrometry data. It automates the identification of chemical formulas by comparing observed peaks against theoretical masses from databases like KEGG and HMDB. A key strength of MIMI is its ability to verify assignments using isotopic fine-structure patterns and its support for stable isotope-labeled experiments (e.g., 13C labeling).

## Database Preparation
Before running analysis, you must prepare a compound database.

### Extracting from KEGG
Use `mimi_kegg_extract` to pull compounds within a specific mass range.
```bash
mimi_kegg_extract -l <lower_mass> -u <upper_mass> -o <output_tsv>
```

### Extracting from HMDB
Requires the `hmdb_metabolites.xml` file.
```bash
mimi_hmdb_extract -l <lower_mass> -u <upper_mass> -x <path_to_xml> -o <output_tsv>
```

## Cache Generation
MIMI uses pre-computed cache files to accelerate mass matching. You must create these for each ionization mode and labeling strategy.

### Natural Abundance Cache
```bash
mimi_cache_create -i <pos|neg> -d <compounds.tsv> -c <output_cache_prefix>
```

### Isotope-Labeled Cache
Requires a JSON configuration file defining the isotope enrichment (e.g., 95% 13C).
```bash
mimi_cache_create -i <pos|neg> -l <label_config.json> -d <compounds.tsv> -c <output_cache_prefix>
```

## Mass Analysis
The core analysis command matches sample peaks against the generated caches.

### Basic Usage
```bash
mimi_mass_analysis -p <ppm_threshold> -vp <verification_ppm> -c <cache1> <cache2> -s <sample.asc> -o <results.tsv>
```

### Key Parameters
- `-p`: Mass error threshold (PPM) for initial matching.
- `-vp`: PPM threshold for isotopic pattern verification.
- `-c`: You can provide multiple cache files (e.g., one natural, one labeled) to analyze them side-by-side.
- `-s`: Input peak list. Must be a three-column file: `Mass (m/z)`, `Intensity`, and `Resolution`.

## Best Practices
- **Input Formatting**: Ensure your `.asc` or text input files are tab or space-delimited with exactly three columns. MIMI relies on the Resolution column for fine-structure verification.
- **Batch Processing**: MIMI supports analyzing multiple datasets simultaneously. Provide multiple sample files to generate a comparative output table.
- **Threshold Tuning**: For UHR-FT-ICR data, start with a tight PPM (e.g., 1.0) to minimize false positives. If identification rates are low, check the calibration of the input data before widening the threshold.
- **Labeling**: When working with spike-ins or labeled cultures, always generate a specific cache using the `-l` flag in `mimi_cache_create` to match the experimental enrichment levels.

## Reference documentation
- [MIMI GitHub Repository](./references/github_com_NYUAD-Core-Bioinformatics_MIMI.md)
- [MIMI Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mimi_overview.md)