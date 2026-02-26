---
name: cmat
description: The ClinVar Mapping and Annotation Toolkit parses, enriches, and standardizes ClinVar XML data by mapping variants to genes and clinical traits to ontology terms. Use when user asks to annotate ClinVar records, generate spreadsheets for manual trait curation, or export curated results back into master mapping files.
homepage: https://github.com/EBIvariation/CMAT
---


# cmat

## Overview

The ClinVar Mapping and Annotation Toolkit (CMAT) is a specialized suite of tools designed to parse, enrich, and standardize ClinVar XML data. It transforms raw ClinVar records into annotated datasets by mapping variants to genes and functional consequences while aligning clinical traits with ontology terms (such as EFO). CMAT supports a complete curation workflow, allowing users to generate automated mappings, export them for manual expert review, and re-integrate curated results back into the master mapping files.

## Installation and Setup

CMAT is primarily distributed via Bioconda.

```bash
# Install via Conda
conda create -n cmat -c conda-forge -c bioconda cmat
conda activate cmat
```

If working from source, ensure Python 3.8+ and Nextflow 21.10+ are installed. Set the following environment variables for convenience:
- `LATEST_MAPPINGS`: Path to your ontology mapping TSV file.
- `CODE_ROOT`: Path to the CMAT repository (if using source).

## Core CLI Commands

### 1. Annotation Pipeline
The primary command for annotating ClinVar XML with gene/consequence data and trait ontology terms.

```bash
cmat annotate \
  --output_dir ./output \
  --mappings ${LATEST_MAPPINGS} \
  --include_transcripts
```
- **Note**: By default, this downloads the latest ClinVar RCV XML dump from the NCBI FTP. To use a local file, add `--clinvar path/to/file.xml.gz`.
- **Tip**: Use `--include_transcripts` to ensure functional consequence annotations include specific transcript details.

### 2. Trait Curation: Generation
Generates a spreadsheet for manual curation when automated mappings are insufficient or new traits appear in ClinVar.

```bash
cmat generate-curation \
  --curation_root ./curation \
  --mappings ${LATEST_MAPPINGS} \
  --comments ./previous_comments.tsv
```
- This produces `google_sheets_table.tsv` in the curation directory.
- Paste the contents into the CMAT curation template starting at the "ClinVar label" column.

### 3. Trait Curation: Export
Imports manually reviewed and finished curation spreadsheets back into the master mapping file.

```bash
cmat export-curation \
  --input_csv ./finished_curation.csv \
  --curation_root ./curation \
  --mappings ${LATEST_MAPPINGS}
```

## Expert Tips and Best Practices

- **Initializing New Ontologies**: If starting a mapping for a new target ontology, create a TSV file containing only the header `#ontology=<code>` (where `<code>` is a supported ontology code). CMAT will populate this file as processing continues.
- **Resuming Pipelines**: If a pipeline fails or is interrupted, CMAT (via Nextflow) supports the `-resume` flag to continue from the last successful process.
- **Mapping File Format**: The mappings file is a TSV. Ensure it is never saved with Excel-style formatting that might corrupt the tab-separation or character encoding.
- **Trait Mapping Database**: Regularly run the curation pipelines to ensure new ClinVar submissions are captured and mapped, preventing "mapping drift" over time.

## Reference documentation
- [CMAT Main Documentation](./references/github_com_EBIvariation_CMAT.md)
- [Bioconda CMAT Overview](./references/anaconda_org_channels_bioconda_packages_cmat_overview.md)