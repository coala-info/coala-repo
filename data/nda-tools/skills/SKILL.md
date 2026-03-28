---
name: nda-tools
description: The nda-tools package provides a command-line interface for validating, submitting, and downloading research data from the National Institute of Mental Health Data Archive. Use when user asks to validate data against NDA schemas, package files for submission, upload data to NDA, or download data packages using the command line.
homepage: https://github.com/NDAR/nda-tools
---

# nda-tools

## Overview

The `nda-tools` package is a Python-based command-line suite designed for researchers and data managers interacting with the National Institute of Mental Health Data Archive (NDA). It provides a programmatic interface to NDA's web services, allowing users to validate data against required schemas, package files for submission, and perform high-volume uploads or downloads. By using this tool, users ensure their data meets the strict formatting standards required for NIMH-funded research sharing.

## Authentication and Setup

Before performing data operations, ensure your environment is configured:

1. **Credential Storage**: The tool uses the `keyring` library to securely store NDA credentials in your OS credential manager.
2. **Verification**: Run `vtcmd -h` to verify the installation and view available validation options.
3. **Configuration**: User settings are typically stored in a `settings.cfg` file, which is automatically generated or updated upon first run.

## Data Validation and Submission (vtcmd)

The `vtcmd` (Validation Tool Command) is the primary utility for preparing data for the NDA.

### Common Patterns

- **Basic Validation**: Validate a data file against NDA structures.
  `vtcmd <path_to_data_file.csv>`
- **Handle Large Files**: For large CSVs that may trigger timeouts, increase the limit.
  `vtcmd --validation-timeout 600 <path_to_file.csv>`
- **Fix QA Errors**: Use the `-rs` flag to resume a session and address Quality Assurance errors identified by the service.
  `vtcmd -rs <uuid>`
- **Skip Local Checks**: If you have already verified that associated files exist and are readable, skip the local filesystem check to save time.
  `vtcmd --skipValidation <path_to_file.csv>`
- **Resume Uploads**: The tool supports resuming partially uploaded files by checking which parts are already present in the NDA S3 buckets.

### Expert Tips for vtcmd

- **Memory Management**: Recent versions of `vtcmd` use a refactored approach to reduce memory footprints during large submissions by scrolling through associated files rather than loading all credentials at once.
- **Log Management**: Use the `--log-dir` argument to specify a custom location for generated log files, which is helpful for auditing automated pipelines.
- **Verbose Debugging**: If a submission fails without a clear error, use the `--verbose` flag to enable debug-level logging of network requests and service responses.

## Data Downloading (downloadcmd)

The `downloadcmd` utility is used to retrieve data packages from the NDA.

- **Batch Processing**: The tool automatically requests pre-signed S3 URLs in batches (typically 50 at a time) to optimize download speed and handle credential expiration.
- **Resuming Downloads**: If a download is interrupted, the tool can parse existing download logs to pick up where it left off.
- **Unique Metadata**: Package metadata files are named uniquely per package to prevent collisions when downloading multiple datasets to the same directory.

## Troubleshooting

- **ModuleNotFoundError**: If you encounter errors regarding `pkg_resources`, ensure `setuptools` is installed: `pip install setuptools`.
- **Expired Tokens**: The tool is designed to catch expired token errors and automatically request new credentials during long-running uploads or downloads.
- **Case Sensitivity**: Note that usernames are now treated as case-insensitive in the latest versions of the tool.



## Subcommands

| Command | Description |
|---------|-------------|
| downloadcmd | This application allows you to download files from an NDA package. Tutorials for creating packages can be found on the website (links provided below). Information for packages, including package-ids, are displayed on the packages dashboard page (https://nda.nih.gov/user/dashboard/packages.html). Users can only download data from "personal" type packages. To download files from a "shared" package you need to convert it to a "personal" package first, which can be done by clicking the "Add to my data packages" button in the actions dropdown.  Links: 	video tutorial - https://nda.nih.gov/tutorials/nda/accessing_files_in_the_cloud.html?chapter=creating-a-package  pdf - https://ndar.nih.gov/ndarpublicweb/Documents/Accessing+Shared+Data+Sept_2021-1.pdf |
| vtcmd | This application allows you to validate files and submit data into NDA. You Must enter a list of at least one file to be validated. If your data contains manifest files, you must specify the location of the manifests. If your data also includes associated files, you must enter a list of at least one directory where the associated files are saved. Alternatively, if any of your data is stored in AWS, you must provide your account credentials, the AWS bucket, and a prefix, if it exists. Any files that are created while running the client (ie. results files) will be downloaded in your home directory under NDAValidationResults. If your submission was interrupted in the middle, you may resume your upload by entering a valid submission ID. |

## Reference documentation

- [NDA Tools README](./references/github_com_NDAR_nda-tools_blob_main_README.md)
- [NDA Tools Changelog](./references/github_com_NDAR_nda-tools_blob_main_CHANGELOG.md)