---
name: magetab-curation-scripts
description: The magetab-curation-scripts suite provides Perl-based utilities for the validation and curation of functional genomics experiment metadata in MAGE-TAB format. Use when user asks to validate MAGE-TAB files, check array design format files, verify Expression Atlas eligibility, or perform curation tasks for genomics databases.
homepage: https://github.com/ebi-gene-expression-group/perl-curation-scripts
---


# magetab-curation-scripts

## Overview

The `magetab-curation-scripts` suite is a collection of Perl-based utilities specifically designed for the curation and validation of functional genomics experiments. It is primarily used by curators for the ArrayExpress and Expression Atlas databases to ensure that MAGE-TAB (MicroArray Gene Expression Tabular) files—including Investigation Description Format (IDF), Sample and Data Relationship Format (SDRF), and Array Design Format (ADF) files—are structurally sound, internally consistent, and meet the specific requirements for database ingestion.

## Core CLI Patterns

### MAGE-TAB Validation
The primary tool for experiment validation is `validate_magetab.pl`.

*   **Full Validation**: Performs format checks, curation rules, data file existence checks, and Atlas eligibility.
    ```bash
    validate_magetab.pl -i path/to/idf.txt -d path/to/data_dir -c
    ```
*   **Lightweight Validation**: Runs only MAGE-TAB format and ArrayExpress loading checks (skips data files and Atlas checks).
    ```bash
    validate_magetab.pl -i /path/to/idf.txt -d path/to/sdrf_dir -x
    ```

### Array Design (ADF) Checking
Use `adf_checker.pl` to validate array design files for formatting and content errors.

```bash
adf_checker.pl -i <ADF_filename> -o <log_file>
```
*   If `-o` is omitted, the script defaults to `<adf_name>.report`.
*   The script returns exit code 0 for success, 1 for warnings, and 2 for errors.

### Expression Atlas Eligibility
To specifically check if an experiment is suitable for the Expression Atlas:

```bash
check_atlas_eligibility.pl -i <IDF_file> -d <data_dir>
```
*   Use `-v` for verbose output to debug specific eligibility failures.
*   Use `-m` if working with a merged IDF/SDRF file instead of separate files.

### Curation Utilities
*   **Excluding Assays**: To comment out specific assays in an Atlas experiment XML configuration (e.g., due to low quality):
    ```bash
    comment_out_assays.pl -c experiment-configuration.xml -l missing_assays.txt -m "Excluded due to low quality"
    ```
*   **Manual ADF Insertion**: To insert an array design into the tracking database:
    ```bash
    magetab_insert_array.pl -f adf_file.txt -l <username>
    ```

## Expert Tips and Best Practices

*   **Configuration Dependency**: These scripts require `perl-atlas-modules` and a properly configured `ArrayExpressSiteConfig.yml`. Ensure that `ADF_CHECKED_LIST`, `ONTO_TERMS_LIST`, and database connection parameters (`AUTOSUBS_DSN`) are correctly defined in your environment.
*   **Data Directory Resolution**: When running `validate_magetab.pl`, the `-d` flag is critical. If your SDRF and raw data files are not in the same directory as the IDF, you must explicitly point to their location.
*   **Daemon Management**: For high-volume curation environments, use `launch_tracking_daemons.pl -p MAGE-TAB` to start a background process that monitors the submission database for "Waiting" experiments. Use the `-k` flag to safely kill running daemons before updates.
*   **Single-Pass Processing**: If you need to process all pending submissions without leaving a persistent daemon running, use:
    ```bash
    single_use_tracking_daemon.pl -p MAGE-TAB -s
    ```



## Subcommands

| Command | Description |
|---------|-------------|
| gal2adf.pl | Converts a GAL file to an ADF file. |
| magetab_insert_array.pl | You must specify an ADF filename. |
| validate_magetab.pl | Validates MAGE-TAB files. |

## Reference documentation
- [github_com_ebi-gene-expression-group_perl-curation-scripts_blob_main_README.md](./references/github_com_ebi-gene-expression-group_perl-curation-scripts_blob_main_README.md)
- [github_com_ebi-gene-expression-group_perl-curation-scripts_blob_main_validate_magetab.pl.md](./references/github_com_ebi-gene-expression-group_perl-curation-scripts_blob_main_validate_magetab.pl.md)
- [github_com_ebi-gene-expression-group_perl-curation-scripts_blob_main_adf_checker.pl.md](./references/github_com_ebi-gene-expression-group_perl-curation-scripts_blob_main_adf_checker.pl.md)
- [github_com_ebi-gene-expression-group_perl-curation-scripts_blob_main_check_atlas_eligibility.pl.md](./references/github_com_ebi-gene-expression-group_perl-curation-scripts_blob_main_check_atlas_eligibility.pl.md)
- [github_com_ebi-gene-expression-group_perl-curation-scripts_blob_main_comment_out_assays.pl.md](./references/github_com_ebi-gene-expression-group_perl-curation-scripts_blob_main_comment_out_assays.pl.md)