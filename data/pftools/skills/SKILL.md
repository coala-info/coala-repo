---
name: pftools
description: pftools is a suite of programs for sensitive protein and nucleic acid sequence motif discovery and analysis using generalized profiles. Use when user asks to search sequence databases for motifs, scan sequences against profile libraries, or calibrate profile scores for statistical significance.
homepage: https://web.expasy.org/pftools/
---


# pftools

## Overview

The `pftools` package is a specialized suite of programs designed for sensitive protein and nucleic acid sequence motif discovery and analysis. It implements the "generalized profile" method, which allows for position-specific scoring of amino acids or nucleotides, including sophisticated gap penalties. 

Use this skill to:
- Search large sequence databases for specific motifs using `pfsearchV3`.
- Scan a single sequence against a library of profiles using `pfscanV3`.
- Calibrate profile scores to provide statistical significance (E-values) using `pfcalibrateV3`.
- Convert between different motif formats and manage profile-based bioinformatics pipelines.

## Core CLI Patterns

### Searching Databases (pfsearchV3)
Use `pfsearchV3` when you have a profile and want to find all occurrences in a database (e.g., UniProt).

```bash
# Basic search with a profile against a FASTA database
pfsearchV3 -f profile.txt database.fasta > results.txt

# Search using a specific cutoff value
pfsearchV3 -f profile.txt -C 8.5 database.fasta

# Use multiple threads for faster processing
pfsearchV3 -t 8 -f profile.txt database.fasta
```

### Scanning Sequences (pfscanV3)
Use `pfscanV3` when you have a sequence and want to identify which motifs from a profile library (e.g., PROSITE) are present.

```bash
# Scan a sequence against a profile library
pfscanV3 -f sequence.fasta profile_library.txt

# Output results in a specific format (e.g., PSA format)
pfscanV3 -f sequence.fasta -out format=psa profile_library.txt
```

### Profile Calibration (pfcalibrateV3)
Before using a profile for production searches, it should be calibrated to ensure scores are statistically meaningful.

```bash
# Calibrate a profile using a random sequence database
pfcalibrateV3 profile.txt
```

## Expert Tips

- **Version Selection**: Prefer the `V3` versions of tools (e.g., `pfsearchV3` instead of `pfsearch`) as they are optimized for modern 64-bit architectures and support multi-threading via OpenMP.
- **Score Interpretation**: Generalized profiles use normalized scores. Always check if your profile has been calibrated; if not, raw scores may not be comparable across different motifs.
- **Memory Management**: When working with extremely large profile libraries in `pfscanV3`, ensure your system has sufficient RAM, as the library is typically loaded into memory for speed.
- **Regular Expressions**: If `pftools` was compiled with PCRE2 support, you can leverage advanced pattern matching within your profile definitions.



## Subcommands

| Command | Description |
|---------|-------------|
| pfscanV3 | Scan a protein sequence with a profile library |
| pfsearchV3 | Scan a protein sequence library for profile matches |

## Reference documentation

- [github_com_sib-swiss_pftools3.md](./references/github_com_sib-swiss_pftools3.md)
- [github_com_sib-swiss_pftools3_blob_main_README.md](./references/github_com_sib-swiss_pftools3_blob_main_README.md)
- [github_com_sib-swiss_pftools3_blob_main_INSTALL.md](./references/github_com_sib-swiss_pftools3_blob_main_INSTALL.md)