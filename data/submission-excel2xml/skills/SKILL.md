---
name: submission-excel2xml
description: The `submission-excel2xml` tool simplifies the DDBJ submission process by allowing users to manage metadata in familiar Excel spreadsheets rather than manual XML.
homepage: https://github.com/ddbj/submission-excel2xml
---

# submission-excel2xml

## Overview

The `submission-excel2xml` tool simplifies the DDBJ submission process by allowing users to manage metadata in familiar Excel spreadsheets rather than manual XML. It provides specialized scripts to parse these spreadsheets, generate multiple linked XML files (Submission, Experiment, Run, Analysis, etc.), and perform preliminary validation against official XSD schemas. This ensures that metadata is structurally sound before it is uploaded to the DDBJ D-way system.

## Installation

Install the tool via Bioconda:

```bash
conda install bioconda::submission-excel2xml
```

## Core CLI Usage

### Generating DRA Metadata
To generate Submission, Experiment, and Run XMLs for the DDBJ Sequence Read Archive (DRA):

```bash
excel2xml_dra -a <account_id> -i <submission_no> -p <bioproject_accession> <excel_file>
```

**Arguments:**
- `-a`: Your D-way account ID.
- `-i`: The submission number (e.g., 0001).
- `-p`: The BioProject accession number (e.g., PRJDB7252).
- `-c`: (Optional) Center name. Required if generating Analysis XMLs for an existing submission.

### Validating DRA Metadata
After generation, validate the XML files against the SRA XSD schemas. Note that XML files must be in the current working directory.

```bash
validate_meta_dra -a <account_id> -i <submission_no>
```

## Workflow Best Practices

1.  **Template Selection**: Use the provided templates in the tool's `example/` directory or the root:
    - `metadata_dra.xlsx` for DRA submissions.
    - `JGA_metadata.xlsx` for JGA/AGD submissions.
2.  **Analysis-Only Submissions**: If adding Analysis XMLs to an existing submission, fill only the 'Analysis' sheet and use the `-c` flag to specify the center name.
3.  **Data Integrity Checks**:
    - **Dates**: Ensure the "Hold Date" (release date) is in the future.
    - **Paired-End Data**: If the library layout is `PAIRED`, ensure the 'Run-file' sheet lists at least two files (e.g., R1 and R2) for each Run.
    - **MD5 Checksums**: Verify that MD5 strings are exactly 32 characters.
4.  **Object Relationships**: Ensure every Experiment is referenced by at least one Run. The tool will throw an error if there are orphaned Experiments or Runs without valid references.

## Common Error Troubleshooting

- **"No such file to open"**: Ensure the Excel file path is correct and the tool has read permissions.
- **Validation Failures**: The `validate_meta_dra` command performs basic XSD validation. If it passes but the D-way web interface rejects the file, check for non-ASCII characters in the Excel sheets or specific DDBJ business logic (like specific attribute requirements) not covered by the XSD.
- **Center Name Mismatch**: When updating existing submissions, the center name provided via `-c` must exactly match the name associated with the original submission.

## Reference documentation
- [Main Tool Documentation and Usage](./references/github_com_ddbj_submission-excel2xml.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_submission-excel2xml_overview.md)