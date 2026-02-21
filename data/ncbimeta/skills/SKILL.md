---
name: ncbimeta
description: `ncbimeta` is a command-line suite designed to streamline the acquisition of metadata from the National Centre for Biotechnology Information (NCBI).
homepage: https://github.com/ktmeaton/NCBImeta
---

# ncbimeta

## Overview
`ncbimeta` is a command-line suite designed to streamline the acquisition of metadata from the National Centre for Biotechnology Information (NCBI). Unlike the NCBI web browser, which is limited for bulk analysis, `ncbimeta` allows users to create a local, searchable database of records based on custom search criteria. It supports the retrieval of metadata into SQLite or text formats, enabling computational biologists to perform large-scale record filtering, project discovery, and meta-analyses.

## Command-Line Operations

### 1. Metadata Retrieval
The primary command fetches metadata based on a predefined configuration.
- **Basic Execution**: `NCBImeta --config path/to/config.yaml`
- **Organization**: Use the `--flat` flag to prevent the creation of sub-directories in the output folder, keeping all results in the top-level directory.
- **Authentication**: Override configuration settings for faster or authenticated access using `--email USEREMAIL` and `--api USERAPI`.
- **Rate Limiting**: If encountering 429 errors, use `--force-pause-seconds` to manually set the delay between NCBI requests.

### 2. Annotating the Database
Add custom metadata or experimental observations to an existing `ncbimeta` database.
- **Command**: `NCBImetaAnnotate --database db.sqlite --annotfile data.txt --table BioSample`
- **Requirement**: The first column of the annotation file must contain a unique identifier (e.g., Accession number) that matches the database.
- **Appending Data**: By default, annotation replaces existing values. Use the `--concatenate` flag to append new metadata to existing cells, separated by a semi-colon.

### 3. Joining NCBI Tables
Merge disparate tables (e.g., BioSample and SRA) into a single master table for comprehensive analysis.
- **Command**: `NCBImetaJoin --database db.sqlite --final MasterTable --anchor BioSample --accessory "SRA BioProject Assembly" --unique "BioSampleAccession"`
- **Logic**: The "anchor" table provides the primary rows, while "accessory" tables provide additional columns linked by unique accession numbers.

### 4. Exporting Data
Convert the local SQLite database into portable text files.
- **Command**: `NCBImetaExport --database db.sqlite --outputdir ./export_folder`
- **Output**: Each table in the database is saved as an individual tab-separated (.txt) file.

## Best Practices and Tips
- **API Keys**: Always use an NCBI API key via the `--api` flag to increase the allowed request rate and prevent connection timeouts during large builds.
- **Database Exploration**: For quick inspection of the SQLite output, use tools like "DB Browser for SQLite" or export to TSV for use in spreadsheet software.
- **Column Naming**: When annotating, ensure the headers in your annotation file exactly match the column names in the target database table.
- **Quiet Mode**: Use the `--quiet` flag during large-scale automated runs to suppress console logging for every individual record.

## Reference documentation
- [NCBImeta Main Documentation](./references/github_com_ktmeaton_NCBImeta.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ncbimeta_overview.md)