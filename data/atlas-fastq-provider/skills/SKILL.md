---
name: atlas-fastq-provider
description: The atlas-fastq-provider is a suite of shell scripts designed to automate the retrieval and validation of genomic sequencing data from sources like ENA and the Human Cell Atlas. Use when user asks to download FASTQ files, validate remote file existence, fetch entire ENA libraries, or symlink local sequencing data into a project structure.
homepage: https://github.com/ebi-gene-expression-group/atlas-fastq-provider
---


# atlas-fastq-provider

## Overview

The `atlas-fastq-provider` is a specialized suite of shell scripts designed to streamline the acquisition of genomic sequencing data for bioinformatics workflows. It acts as a robust abstraction layer for fetching FASTQ files, handling the complexities of ENA directory structures, protocol selection (FTP, HTTP, SSH), and retrieval from the Human Cell Atlas (HCA). Use this skill when you need to programmatically download sequencing data, validate the existence of remote files without downloading them, or symlink local data into a standardized project structure.

## Core CLI Patterns

### Fetching Individual Files
The primary tool is `fetchFastq.sh`. It automatically detects the source type (e.g., ENA identifiers like SRR/ERR/DRR) and selects the best retrieval method.

*   **Basic Download (FTP):**
    `fetchFastq.sh -f <URI_OR_ID> -t <TARGET_PATH>`
*   **Validation Only:** Check if a file exists at the source without downloading (returns exit code 0 if found).
    `fetchFastq.sh -v -f <URI_OR_ID>`
*   **Specific Method:** Force a protocol (ftp, http, ssh, hca, or dir).
    `fetchFastq.sh -m http -f ERR1888646_1.fastq.gz -t output.fastq.gz`
*   **Local Symlinking:** Use a local directory as a source to create a symlink at the target.
    `fetchFastq.sh -s /path/to/local/storage -f file.fastq.gz -t project_data/file.fastq.gz`

### Fetching Entire Libraries
Use `fetchEnaLibraryFastqs.sh` to retrieve all files associated with a specific ENA run or library.

*   **Download All Files:**
    `fetchEnaLibraryFastqs.sh -l <LIBRARY_ID> -d <OUTPUT_DIR>`
*   **Fetch and Unpack SRA:** Retrieve SRA files and convert/unpack them.
    `fetchEnaLibraryFastqs.sh -l ERR1888646 -d output_dir -t srr`
*   **Specify Layout:** Define if the library is SINGLE or PAIRED to guide deinterleaving.
    `fetchEnaLibraryFastqs.sh -l SRR18315788 -d output_dir -n SINGLE`

### Human Cell Atlas (HCA) Retrieval
Retrieve files using HCA pseudo-URIs which are resolved via the Azul service.
`fetchFastq.sh -f hca://<BUNDLE_UUID>/<FILE_NAME> -t <DEST_FILE>`

## Expert Tips and Best Practices

*   **Protocol Probing:** When retrieval method is set to `auto` (default), the tool "probes" ENA endpoints (FTP, SSH, HTTP) to find the fastest available connection. This result is cached in a probe file to speed up subsequent requests.
*   **SSH for EBI Internal Users:** If working within the EBI network, set the `ENA_SSH_USER` environment variable to use SSH for significantly faster data transfers compared to FTP.
*   **Private Data:** For private ArrayExpress or ENA submissions, use the `-p private` flag and ensure `ENA_PRIVATE_SSH_ROOT_DIR` is configured.
*   **Configuration Overrides:** Instead of modifying the global config, pass a custom configuration file using the `-c` flag to manage environment-specific settings (like temporary directories or retry counts).
*   **Deinterleaving:** The tool includes `deinterleave_fastq.sh`. If a paired-end run is downloaded as a single interleaved file, `fetchEnaLibraryFastqs.sh` with `-n PAIRED` will attempt to split it into `_1` and `_2` files automatically.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/fetchEnaLibraryFastqs.sh | Fetches ENA library FASTQ files. |
| /usr/local/bin/fetchFastq.sh | Fetches FASTQ files from various sources. |
| deinterleave_fastq.sh | Deinterleaves paired-end FASTQ files. |

## Reference documentation
- [Main README](./references/github_com_ebi-gene-expression-group_atlas-fastq-provider_blob_develop_README.md)
- [Configuration Defaults](./references/github_com_ebi-gene-expression-group_atlas-fastq-provider_blob_develop_atlas-fastq-provider-config.sh.default.md)
- [Post-Install Test Examples](./references/github_com_ebi-gene-expression-group_atlas-fastq-provider_blob_develop_atlas-fastq-provider-post-install-tests.sh.md)