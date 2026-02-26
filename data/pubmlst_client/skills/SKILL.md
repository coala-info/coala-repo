---
name: pubmlst_client
description: The pubmlst_client tool programmatically interfaces with pubMLST and BIGSDB-compatible servers to identify and retrieve MLST schemes. Use when user asks to list available MLST schemes, filter schemes by organism name, or download sequence data and profiles for bacterial strain characterization.
homepage: https://github.com/Public-Health-Bioinformatics/pubmlst_client
---


# pubmlst_client

## Overview

The `pubmlst_client` is a specialized command-line tool designed to interface with the pubMLST database and other BIGSDB-compatible servers. It provides a streamlined way to programmatically identify and retrieve MLST schemes, which are essential for bacterial strain characterization and genomic epidemiology. By using this tool, you can avoid manual downloads from web interfaces and ensure you are using the most up-to-date typing definitions for your bioinformatics pipelines.

## Listing Available Schemes

Use `pubmlst_list` to browse the available schemes on a server.

- **Basic listing**: Run `pubmlst_list` to see a table of all schemes including their IDs, descriptions, and record counts.
- **Filter by name**: Use a regex pattern to find specific organisms.
  ```bash
  pubmlst_list --pattern "salmonella"
  ```
- **Exclude specific types**: Use `--exclude_pattern` to filter out unwanted schemes (e.g., excluding core-genome MLST).
  ```bash
  pubmlst_list --exclude_pattern "cgMLST"
  ```
- **Scripting mode**: Use `--names_only` or `-n` to output only the scheme names, which is ideal for piping into other tools or loops.

## Downloading Schemes

Use `pubmlst_download` to fetch the actual sequence data and profiles.

- **Standard download**: You must provide the scheme name.
  ```bash
  pubmlst_download --scheme_name "abaumannii"
  ```
- **Specify Scheme ID**: If multiple schemes exist for the same name (e.g., Oxford vs. Pasteur), specify the ID.
  ```bash
  pubmlst_download --scheme_name "abaumannii" --scheme_id 2
  ```
- **Set output directory**: By default, files are saved to the current directory. Use `-o` to organize your data.
  ```bash
  pubmlst_download -s "nmeningitidis" -o ./mlst_data/
  ```

## Expert Tips and Best Practices

- **Alternative Databases**: While it defaults to pubMLST.org, you can target other BIGSDB instances like the Pasteur Institute database using the `--base-url` or `-b` flag.
  - Pasteur API: `https://bigsdb.pasteur.fr/api/db`
  - Example: `pubmlst_list -b https://bigsdb.pasteur.fr/api/db`
- **Handling Rate Limits**: When downloading multiple schemes in a loop, it is best practice to add a small sleep interval between commands to avoid being throttled by the REST API.
- **Data Verification**: Always check the `last_updated` column in the list output to ensure you are working with the latest version of a scheme, especially for rapidly evolving pathogens.

## Reference documentation
- [pubmlst_client GitHub Repository](./references/github_com_Public-Health-Bioinformatics_pubmlst_client.md)
- [pubmlst_client Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pubmlst_client_overview.md)