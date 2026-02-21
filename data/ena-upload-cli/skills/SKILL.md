---
name: ena-upload-cli
description: The `ena-upload-cli` is a specialized tool designed to streamline the submission of experimental data to the European Nucleotide Archive.
homepage: https://github.com/usegalaxy-eu/ena-upload-cli
---

# ena-upload-cli

## Overview

The `ena-upload-cli` is a specialized tool designed to streamline the submission of experimental data to the European Nucleotide Archive. Instead of manually navigating the Webin web interface, this tool allows users to prepare metadata in familiar spreadsheet formats (TSV or XLSX) and perform bulk uploads. It manages the complex process of generating ENA-compliant XMLs, validating metadata against ENA checklists, and transferring data files via FTP.

## Core Usage Patterns

### Mandatory Arguments
Every command requires three primary components:
- `--action`: The operation to perform (`add`, `modify`, `cancel`, `release`).
- `--center`: Your registered ENA Center name.
- `--secret`: Path to a configuration file containing your Webin-XXXXX credentials.

### Basic Submission Template
To submit a complete set of sequencing data (Study, Sample, Experiment, and Run):
```bash
ena-upload-cli --action add --center "MY_CENTER" --secret .secret.yml \
  --study study.tsv \
  --sample samples.tsv \
  --experiment experiments.tsv \
  --run runs.tsv \
  --data file1.fastq.gz file2.fastq.gz
```

### Using Excel Templates
If metadata is consolidated in a single Excel workbook:
```bash
ena-upload-cli --action add --center "MY_CENTER" --secret .secret.yml --xlsx metadata_template.xlsx
```

## Metadata Configuration

### Sample Checklists
By default, the tool uses the minimum information checklist (`ERC000011`). To use a specific checklist (e.g., for viral pathogens):
- Use `--checklist ERC000033` for the ENA virus pathogen checklist.

### Custom Attributes
You can add non-standard metadata fields to your sample tables by using a specific header format: `sample_attribute[attribute_name]`.
- Example header: `sample_attribute[host_health_status]`
- Example header: `sample_attribute[sequencing_platform_version]`

### Taxonomy Handling
The tool automatically resolves taxonomy. You can provide either `taxon_id` or `scientific_name`. If one is provided, the tool will fetch the corresponding value from the ENA taxonomy service.

### Read Information (FastQ only)
For Run objects, you can specify read details using `read_type` and `read_label` columns. Values should be comma-separated without spaces.
- `read_type`: Use ENA controlled vocabulary (e.g., `paired`, `single`).

## Expert Tips and Best Practices

### Use the Sandbox First
Always test your submission against the ENA development server before submitting to the production archive.
- Add the `-d` or `--dev` flag to your command.
- Check results at the [ENA Dev Webin interface](https://wwwdev.ebi.ac.uk/ena/submit/webin/).

### Secure Credential Management
To avoid leaking passwords in shell history, use the `.secret.yml` file. This file should contain your `username` (Webin-XXXXX) and `password`. Ensure this file has restricted permissions (`chmod 600`).

### Handling Large Data Volumes
- **--no_data_upload**: Use this flag if you have already uploaded your data files to the ENA FTP directory via another method and only need to submit the metadata (RUN object).
- **--draft**: Use this flag to perform a "dry run." The tool will validate your tables and prepare the submission without actually sending it to ENA.

### Post-Submission Workflow
After a successful `add` action, the tool generates new TSV tables. These tables include the assigned ENA accession numbers. Save these files as they are required for future `modify` or `release` actions.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_usegalaxy-eu_ena-upload-cli.md)
- [Tool Actions and CLI Arguments](./references/github_com_usegalaxy-eu_ena-upload-cli_actions.md)