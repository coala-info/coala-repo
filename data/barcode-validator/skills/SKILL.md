---
name: barcode-validator
description: The `barcode-validator` skill provides a specialized workflow for the quality control of DNA barcode data.
homepage: https://github.com/naturalis/barcode_validator
---

# barcode-validator

## Overview

The `barcode-validator` skill provides a specialized workflow for the quality control of DNA barcode data. It automates the verification of sequence integrity—such as identifying protein-coding markers via HMM-based alignment and stop codon analysis—and validates taxonomic assignments using external services like BOLD or Galaxy BLAST. Use this skill when you need to triage multiple assembly attempts, filter valid sequences for downstream analysis, or generate detailed validation reports for biodiversity genomics projects.

## Installation and Setup

The tool requires `blast` and `hmmer` for full functionality.

```bash
# Recommended installation via Bioconda
conda install -c bioconda barcode-validator blast hmmer

# Alternative installation via pip
pip install barcode-validator
```

## Common CLI Patterns

The tool is executed as a Python module: `python -m barcode_validator [options]`.

### 1. Structural Validation Only
Use this to check sequence length, ambiguous bases, and stop codons without querying external databases.
```bash
python -m barcode_validator \
  --input-file sequences.fasta \
  --mode structural \
  --marker COI-5P \
  --output-fasta valid_struct.fasta \
  --output-tsv report.tsv
```

### 2. Taxonomic Validation (BOLD Service)
Validate existing taxonomic assignments against the BOLD ID service.
```bash
python -m barcode_validator \
  --input-file sequences.fasta \
  --mode taxonomic \
  --marker COI-5P \
  --taxon-validation method=bold rank=family min_identity=0.8 \
  --output-tsv taxon_report.tsv
```

### 3. Combined Validation with BOLD Spreadsheet
Integrate metadata from a BOLD Excel spreadsheet (Lab Sheet/Taxonomy tabs) to resolve process IDs and expected taxonomy.
```bash
python -m barcode_validator \
  --input-file sequences.fasta \
  --mode both \
  --marker COI-5P \
  --input-resolver format=bold file=bold_data.xlsx \
  --output-fasta final_validated.fasta \
  --output-tsv full_report.tsv
```

### 4. Assembly Triage (BGE Use Case)
When multiple assembly attempts exist for a single specimen, use triage to select the "best" valid sequence.
```bash
python -m barcode_validator \
  --input-file assemblies.fasta \
  --mode structural \
  --triage-config group_id_separator=_ \
  --triage-config group_by_sample=true \
  --output-fasta triaged_best.fasta
```

## Expert Tips

*   **Galaxy API Credentials**: When using `method=galaxy` for taxonomic validation, ensure `GALAXY_API_KEY` and `GALAXY_DOMAIN` are exported in your environment.
*   **Marker Selection**: Ensure the `--marker` matches your data (e.g., `COI-5P` for animals, `rbcL` for plants). The tool uses specific HMM profiles based on this flag.
*   **Log Levels**: Use `--log-level INFO` for detailed progress or `ERROR` for clean output when piping results.
*   **Input Resolvers**: The `format=bold` resolver is highly effective for matching FASTA headers to BOLD process IDs found in Excel spreadsheets.
*   **Identity Thresholds**: Adjust `min_identity` (0.0 to 1.0) based on the expected divergence for the taxonomic rank you are validating.

## Reference documentation
- [Standardized validation of DNA barcodes](./references/github_com_naturalis_barcode_validator.md)
- [barcode-validator - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_barcode-validator_overview.md)