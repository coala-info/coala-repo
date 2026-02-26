---
name: ega2
description: The ega2 tool downloads files from the European Genome-phenome Archive. Use when user asks to download EGA files, especially those ending in .gpg.
homepage: https://ega-archive.org/download/downloader-quickguide-v2
---


# ega2

yaml
name: ega2
description: |
  The EGA download client v2 (ega2) for downloading files from the European Genome-phenome Archive (EGA).
  Use this skill when you need to download specific EGA files, especially those ending in .gpg,
  which might not be fully supported by other clients like pyega3.
  This skill provides access to the v2 Java client for more comprehensive EGA downloads.
```

## Overview

The `ega2` skill provides a command-line interface for downloading files from the European Genome-phenome Archive (EGA). It is particularly useful for downloading files that use the `.gpg` extension, which may not be fully supported by newer clients like `pyega3`. This skill essentially wraps the v2 Java EGA download client, making it more accessible for direct command-line usage.

## Usage Instructions

The `ega2` tool is designed for direct command-line interaction. The primary command is `ega2`, followed by options and arguments to specify the download.

### Core Command Structure

The general structure for downloading a file is:

```bash
ega2 --user <username> --password <password> --input <input_file> --output <output_directory>
```

### Key Options and Arguments

*   `--user <username>`: Your EGA username.
*   `--password <password>`: Your EGA password.
*   `--input <input_file>`: A file containing the list of EGA file IDs to download. Each file ID should be on a new line.
*   `--output <output_directory>`: The local directory where the downloaded files will be saved.

### Example Usage

1.  **Downloading files listed in an input file:**

    First, create an input file (e.g., `files_to_download.txt`) with one EGA file ID per line:

    ```
    EGAF00000000001
    EGAF00000000002
    ```

    Then, run the `ega2` command:

    ```bash
    ega2 --user your_ega_username --password your_ega_password --input files_to_download.txt --output ./downloads
    ```

    This will download the specified files into the `./downloads` directory.

### Expert Tips

*   **Secure Password Handling**: Avoid hardcoding your password directly in scripts. Consider using environment variables or a secure credential management system.
*   **Input File Management**: For large numbers of files, break them down into smaller input files to manage downloads more effectively and to easily re-run specific sets if a download fails.
*   **Output Directory**: Ensure the output directory exists before running the command, or `ega2` might encounter errors.
*   **Error Handling**: Monitor the output for any error messages. The `.gpg` extension often indicates encrypted files, and successful decryption might require separate tools after download.

## Reference documentation

*   [EGA download client v2 Overview](./references/anaconda_org_channels_bioconda_packages_ega2_overview.md)