---
name: sampei
description: SAMPEI performs open modification searching in high-resolution mass spectrometry data using spectral alignment to identify mass-shifted peptides. Use when user asks to identify unknown protein modifications, perform open modification searches, or find similar target spectra using high-confidence query spectra.
homepage: https://github.com/FenyoLab/SAMPEI
metadata:
  docker_image: "quay.io/biocontainers/sampei:0.0.9--py_0"
---

# sampei

## Overview
SAMPEI (Spectral Alignment-based Modified PEptide Identification) is a computational method for "open" modification searching in high-resolution mass spectrometry data. It bypasses the limitations of traditional database searches—which typically require pre-defining a small number of expected modifications—by using high-confidence "query" spectra to find similar "target" spectra that exhibit a mass shift. This allows for the discovery of functional protein signaling modifications and sub-stoichiometric changes without prior knowledge of their chemical nature.

## Installation
Install SAMPEI via Bioconda or Pip:

```bash
# Using Conda
conda install -c bioconda sampei

# Using Pip
pip install sampei
```

## Command Line Usage
The basic syntax for running SAMPEI requires three positional arguments:

```bash
sampei <query_mgf_path> <target_mgf_path> <id_file_path> [flags]
```

### Input File Requirements
1. **MGF Files**: Both query and target files must be in Mascot Generic Format. If using MSConvert to generate these, ensure the "TPP compatibility" feature is **disabled**.
2. **ID File**: A tab-delimited (.tsv) file containing high-confidence identifications (e.g., from X!Tandem). It must contain these exact column headers:
   - `scan`: Integer scan ID.
   - `peptide`: Peptide sequence string.
   - `modifications`: Assigned modifications (must end with a comma; e.g., `57.02147@C4,`).
   - `charge`: Charge state.
   - `proteins`: Protein accession/name.
   - `Filename`: The query MGF filename (excluding extension).

## Search Parameters and Tuning
Fine-tune the alignment sensitivity and specificity using the following flags:

| Flag | Default | Description |
| :--- | :--- | :--- |
| `--error-type` | `ppm` | Mass error unit (ppm or Da). |
| `--fragment-mass-error` | `20` | Tolerance for fragment ion matching. |
| `--matched-peptide-intensity` | `0.5` | Minimum proportion of target MS2 intensity matching the theoretical m/z of the query sequence. |
| `--largest-gap-percent` | `0.4` | Maximum allowable consecutive b/y ion gap as a percentage of peptide length. |

## Expert Tips
- **Query Selection**: For best results, use only the highest confidence identifications (lowest e-values) from your initial database search as queries.
- **Mass Window**: SAMPEI searches within a default mass difference window of +/- 200 Daltons.
- **Sensitivity vs. Specificity**: 
    - To increase **sensitivity** (find more potential modifications), decrease `--matched-peptide-intensity` or increase `--largest-gap-percent`.
    - To increase **specificity** (reduce false positives), increase `--matched-peptide-intensity` or decrease `--largest-gap-percent`.
- **Verification**: Use the "matched query intensity" (proportion of matched MS2 intensity from query over total MS2 intensity) to pre-filter candidates before looking at sequence-specific measures.

## Reference documentation
- [SAMPEI GitHub Repository](./references/github_com_FenyoLab_SAMPEI.md)
- [SAMPEI Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sampei_overview.md)