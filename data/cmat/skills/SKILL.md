---
name: cmat
description: CMAT processes ClinVar XML data to map clinical variants to genes, transcripts, and functional consequences while standardizing clinical traits to ontology terms. Use when user asks to annotate ClinVar variants, generate curation spreadsheets for unmapped traits, or export manual curation results into a master mapping file.
homepage: https://github.com/EBIvariation/CMAT
---

# cmat

## Overview

CMAT (ClinVar Mapping and Annotation Toolkit) is a specialized suite of tools designed to process ClinVar's XML data. It automates the enrichment of clinical variant records by mapping them to specific genes, transcripts, and functional consequences. Additionally, it provides a structured workflow for mapping clinical traits to standardized ontology terms (such as EFO, HPO, or Mondo), which is essential for downstream analysis in platforms like Open Targets. The toolkit supports both automated pipelines and a manual curation loop to ensure high-quality data mapping.

## Installation and Setup

CMAT requires Python 3.8+ and Nextflow 21.10+.

### Environment Configuration
Before running pipelines, define the following environment variables for convenience:
```bash
export CODE_ROOT=/path/to/CMAT
export LATEST_MAPPINGS=${CODE_ROOT}/mappings/latest_mappings.tsv
```

If starting a new project without an existing mapping file, initialize a TSV file with the appropriate ontology header:
```bash
echo "#ontology=<ontology_code>" > latest_mappings.tsv
```

## Core CLI Workflows

CMAT can be invoked directly via the `cmat` command (if installed via Conda) or by running the Nextflow scripts.

### 1. Variant Annotation
Annotate ClinVar variants with gene information, functional consequences, and ontology terms.

**Standard Annotation:**
```bash
cmat annotate \
  --clinvar input_clinvar.xml.gz \
  --mappings ${LATEST_MAPPINGS} \
  --output_dir ./output_dir
```

**Detailed Transcript Annotation:**
Add the `--include_transcripts` flag to include specific transcript-level functional consequences.

### 2. Trait Curation Workflow
This is a two-step process to handle new or unmapped traits in ClinVar.

**Step A: Generate Curation Spreadsheet**
Identifies unmapped traits and prepares a table for manual review.
```bash
cmat generate-curation \
  --curation_root ./curation_work \
  --mappings ${LATEST_MAPPINGS} \
  --comments curator_comments.txt
```
*Note: This produces `google_sheets_table.tsv`, which should be pasted into the CMAT curation template.*

**Step B: Export Manual Curation**
After manual review is complete and saved as a CSV, incorporate the new mappings back into the master mapping file.
```bash
cmat export-curation \
  --input_csv finished_curation.csv \
  --curation_root ./curation_work \
  --mappings ${LATEST_MAPPINGS}
```

## Expert Tips and Best Practices

- **Nextflow Resumption**: Always use the `-resume` flag when running pipelines. This allows the toolkit to skip successfully completed steps if a previous run was interrupted or failed.
- **Conda vs. Source**: If using the Conda installation, use the `cmat <command>` syntax. If running from a git clone, use `nextflow run ${CODE_ROOT}/pipelines/<pipeline_name>.nf`.
- **SSL Security Levels**: If encountering SSL errors when connecting to Ensembl servers during annotation, ensure your environment's OpenSSL security level is set to 1 (standard in the provided CI configurations).
- **Python Executable**: Ensure the `PYTHON_BIN` variable is correctly set in the `nextflow.config` file within the pipelines directory to point to your active environment's Python path.



## Subcommands

| Command | Description |
|---------|-------------|
| run | Execute a pipeline project |
| run | Execute a pipeline project |
| run | Execute a pipeline project |

## Reference documentation
- [CMAT Main README](./references/github_com_EBIvariation_CMAT_blob_master_README.md)
- [Bioconda CMAT Overview](./references/anaconda_org_channels_bioconda_packages_cmat_overview.md)