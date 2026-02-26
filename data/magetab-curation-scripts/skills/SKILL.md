---
name: magetab-curation-scripts
description: This package provides a suite of Perl-based tools for validating, processing, and managing MAGE-TAB files and array designs. Use when user asks to validate IDF and SDRF files, check Expression Atlas eligibility, manage Array Design Files, or run automated submission tracking daemons.
homepage: https://github.com/ebi-gene-expression-group/perl-curation-scripts
---


# magetab-curation-scripts

## Overview

The magetab-curation-scripts package provides a suite of Perl-based tools for handling MAGE-TAB (MicroArray Gene Expression Tabular) files. It enables curators to perform rigorous validation of Investigation Description Format (IDF) and Sample and Data Relationship Format (SDRF) files. Beyond simple syntax checking, the toolset evaluates experiments for Expression Atlas eligibility, processes Array Design Files (ADF), and manages automated submission daemons.

## Installation and Environment

The scripts are available via Bioconda and require the `perl-atlas-modules` package to function correctly.

```bash
conda install -c bioconda magetab-curation-scripts
```

**Configuration Requirement:**
Before running validation scripts, the `ArrayExpressSiteConfig.yml` file must be configured. Key parameters include:
- `ADF_CHECKED_LIST` and `ATLAS_EXPT_CHECKED_LIST` for tracking.
- `AUTOSUBS_DSN`, `AUTOSUBS_USERNAME`, and `AUTOSUBS_PASSWORD` for MySQL database interaction.
- `AE2_LOAD_DIR` for specifying the loading directory.

## Common CLI Patterns

### MAGE-TAB Validation

The `validate_magetab.pl` script is the primary tool for checking submissions.

**Full Validation:**
Runs MAGE-TAB format validation, curation checks, data file verification, and Atlas eligibility checks.
```bash
validate_magetab.pl -i path/to/idf.txt -d path/to/sdrf_and_data_dir -c
```

**Loading Check Only:**
Runs only MAGE-TAB format and ArrayExpress (AE) loading checks, skipping data files and Atlas eligibility.
```bash
validate_magetab.pl -i /path/to/idf.txt -d path/to/sdrf_dir -x
```

### Array Design Management

To manually insert a new Array Design File (ADF) into the tracking system and trigger validation:
```bash
magetab_insert_array.pl -f adf_file_name.txt -l <username>
```

### Submission Tracking Daemons

For automated processing of submissions marked as "Waiting" in the tracking database:

**Start a MAGE-TAB checker daemon:**
```bash
launch_tracking_daemons.pl -p MAGE-TAB
```

**Single-run processing:**
Processes all eligible experiments once and then exits without maintaining a persistent daemon instance.
```bash
single_use_tracking_daemon.pl -p MAGE-TAB -s
```

**Stop all daemons:**
```bash
launch_tracking_daemons.pl -k
```

## Expert Tips

- **Eligibility Checks:** Use the `-c` flag in `validate_magetab.pl` specifically when the goal is to determine if an experiment meets the metadata requirements for inclusion in the Expression Atlas.
- **Assay Management:** If specific assays need to be excluded from processing without deleting them from the SDRF, use `comment_out_assays.pl`.
- **Format Conversion:** For legacy formats or specific platforms, utilize `gal2adf.pl` (GenePix Array List) or `nimblegen2adf.pl` to generate standard ADF files.
- **Database Connectivity:** Most scripts interact with a MySQL backend. Ensure your environment has the necessary database drivers and that the credentials in the site configuration have appropriate read/write permissions for the `AUTOSUBS` tables.

## Reference documentation
- [Perl curation scripts README](./references/github_com_ebi-gene-expression-group_perl-curation-scripts_blob_main_README.md)
- [magetab-curation-scripts Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_magetab-curation-scripts_overview.md)