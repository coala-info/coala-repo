---
name: pubmlst_client
description: The pubmlst_client tool interacts with the pubMLST REST API to browse and download genomic typing schemes and allele definitions. Use when user asks to list available typing schemes, filter schemes by organism, or download locus sequences and profiles for species-specific characterization.
homepage: https://github.com/Public-Health-Bioinformatics/pubmlst_client
---

# pubmlst_client

## Overview
The `pubmlst_client` provides a streamlined command-line interface for interacting with the pubMLST REST API. It allows researchers to browse available typing schemes (like MLST, cgMLST, or wgMLST) and download the associated locus sequences and allele definitions. This tool is essential when you need to fetch the latest reference data for species-specific genomic characterization without manual web downloads.

## Listing Available Schemes
Use `pubmlst_list` to discover what schemes are available on a server.

- **Basic list**: `pubmlst_list`
- **Filter by organism**: Use `--pattern` (regex) to find specific species.
  - Example: `pubmlst_list --pattern "abaumannii"`
- **Exclude specific types**: Use `--exclude_pattern` to hide unwanted results.
- **Names only**: Use `-n` or `--names_only` for a clean list of identifiers suitable for piping to other tools.
- **Alternative Servers**: By default, it queries `http://rest.pubmlst.org/db`. To query the Pasteur database, use:
  - `pubmlst_list --base-url https://bigsdb.pasteur.fr/api/db`

## Downloading Schemes
Use `pubmlst_download` to retrieve the actual sequence data and profiles.

- **Standard download**: Requires a scheme name.
  - `pubmlst_download --scheme_name achromobacter --outdir ./achromobacter_scheme`
- **Specific Scheme ID**: If an organism has multiple schemes (e.g., Oxford vs. Pasteur for *A. baumannii*), specify the ID.
  - `pubmlst_download --scheme_name abaumannii --scheme_id 2`
- **Output Structure**: The tool will create a directory containing FASTA files for each locus and a profile (TSV) file mapping allele combinations to Sequence Types (STs).

## Expert Tips
- **API Rate Limiting**: The client includes internal logic to slow down requests; avoid running many instances in parallel to prevent being blocked by the BIGSDB servers.
- **Data Snapshots**: If the API is down, check the `scheme_list_snapshots` directory in the repository for historical TSV lists of available schemes.
- **Verification**: Always check the `locus_count` in the list output before downloading to ensure you are getting the expected level of resolution (e.g., 7 loci for traditional MLST vs. hundreds for cgMLST).



## Subcommands

| Command | Description |
|---------|-------------|
| pubmlst_download | Download schemes from PubMLST API |
| pubmlst_list | List schemes from the PubMLST database with optional filtering |

## Reference documentation
- [pubMLST Client README](./references/github_com_Public-Health-Bioinformatics_pubmlst_client_blob_master_README.md)
- [Tool Setup and Entry Points](./references/github_com_Public-Health-Bioinformatics_pubmlst_client_blob_master_setup.py.md)