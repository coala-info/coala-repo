---
name: gbmunge
description: `gbmunge` is a high-performance C tool designed to "munge" GenBank flat files into formats suitable for bioinformatics analysis.
homepage: https://github.com/sdwfrost/gbmunge
---

# gbmunge

## Overview
`gbmunge` is a high-performance C tool designed to "munge" GenBank flat files into formats suitable for bioinformatics analysis. It extracts core attributes—including accession numbers, sequence lengths, submission dates, host information, and collection dates—while simultaneously cleaning the data. Its primary value lies in its ability to reformat non-standard GenBank dates into a sortable YYYY-MM-DD format and resolve varied geographic strings into standardized ISO3 country codes.

## Usage Patterns

### Basic Extraction
To extract all sequences and their associated metadata into separate files:
`gbmunge -i sequence.gb -f sequences.fasta -o metadata.tsv`

### Preparing for Phylodynamic Analysis (BEAST/Nextstrain)
Use the `-t` flag to filter for records that contain collection dates. This also renames the FASTA headers to the `{accession}_{collection_date}` format, which is the standard requirement for many molecular clock tools.
`gbmunge -i sequence.gb -f timed_sequences.fasta -o metadata.tsv -t`

### Including Sequences in Metadata
If you require the raw sequence strings to be included as a column within the tab-delimited metadata file, use the `-s` flag.
`gbmunge -i sequence.gb -f sequences.fasta -o metadata_with_seqs.tsv -s`

## Expert Tips
- **Date Standardization**: `gbmunge` automatically converts GenBank's `DD-MON-YYYY` format to `YYYY-MM-DD`. If a date is only partially provided (e.g., just the year), it preserves the available precision (e.g., `2012-04`).
- **Geographic Cleaning**: The tool checks both `/country` and `/geo_loc_name` qualifiers. It is highly effective at stripping sub-national information (e.g., "United Kingdom: England" becomes "United Kingdom" with an ISO3 code of "GBR").
- **Input Handling**: The tool expects a standard GenBank flat file. If you have multiple accessions, ensure they are concatenated into a single `.gb` file before processing.
- **Output Columns**: The metadata file includes `name`, `accession`, `length`, `submission_date`, `host`, `country_original`, `country`, `countrycode`, and `collection_date`.

## Reference documentation
- [gbmunge GitHub Repository](./references/github_com_sdwfrost_gbmunge.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_gbmunge_overview.md)