---
name: nda-tools
description: The `nda-tools` package provides a command-line interface for interacting with NDA web services.
homepage: https://github.com/NDAR/nda-tools
---

# nda-tools

## Overview
The `nda-tools` package provides a command-line interface for interacting with NDA web services. It streamlines the process of validating data against NDA data dictionaries, packaging files for submission, and downloading large datasets. It is the primary tool for ensuring that research data meets the National Institute of Mental Health (NIMH) standards before and after submission.

## Authentication and Setup
Before using the tools, you must configure your NDA credentials. The tool uses the `keyring` package to store credentials securely in your operating system's credential manager.

- **Initial Login**: The client will prompt for your NDA username and password on the first run.
- **Manual Credential Storage**:
  ```bash
  python -c "import keyring; keyring.set_password('nda-tools', 'your-username', 'your-password')"
  ```
- **Configuration File**: Custom endpoints and file locations can be modified in `~/.NDATools/settings.cfg`.

## Data Validation and Submission (vtcmd)
The `vtcmd` (Validation Tool Command) is used to validate CSV files against NDA data structures and upload them.

- **Basic Validation**:
  ```bash
  vtcmd <path_to_csv_file>
  ```
- **Best Practices**:
  - **Full Paths**: Always provide the full absolute path to the CSV files to avoid path resolution errors during the validation process.
  - **Argument Order**: Place the list of files to validate as the first argument, as it does not have a specific command-line switch and can be misinterpreted if placed after other flags.
  - **Quoting**: Use double-quotes (`" "`) on Windows and single-quotes (`' '`) on Mac/Linux for paths containing spaces or special characters.

## Data Downloading (downloadcmd)
The `downloadcmd` is used to retrieve data associated with NDA packages or specific data structures.

- **View Options**:
  ```bash
  downloadcmd -h
  ```
- **Download via S3 Links**: Use a text file containing a list of S3 links to download specific files.
- **Resuming Downloads**: The tool supports resuming partially downloaded files. If a download is interrupted, re-running the command will typically pick up where it left off.
- **SSL Errors**: If you encounter SSL errors, ensure the `requests[secure]` package is installed:
  ```bash
  pip install requests[secure]
  ```

## Expert Tips
- **Validation Results**: Check the `Files` section in `settings.cfg` to define where validation results and logs are stored.
- **Dependency Issues**: If you encounter `ModuleNotFoundError: No module named 'pkg_resources'`, install setuptools: `python -m pip install setuptools`.
- **Headless Environments**: On Linux servers without a GUI, you may need to install a backend for keyring: `pip install secretstorage keyrings.alt`.

## Reference documentation
- [NDA Tools GitHub Repository](./references/github_com_NDAR_nda-tools.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_nda-tools_overview.md)