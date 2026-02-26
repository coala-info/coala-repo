---
name: ucsc-newpythonprog
description: This tool generates new Python script templates. Use when user asks to generate a new Python script template or create a new Python script skeleton.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-newpythonprog

## Overview
The `ucsc-newpythonprog` tool is a utility from the UCSC Genome Browser "kent" suite that automates the creation of new Python scripts. Instead of writing a script from scratch, this tool generates a template (skeleton) that includes standard headers, basic argument parsing, and a structured entry point. This ensures consistency across a codebase and saves time on repetitive setup tasks.

## Usage Instructions

### Basic Command
To generate a new Python script template, run the command followed by your desired filename:
```bash
newPythonProg my_new_script.py
```

### Viewing Options
Like most UCSC Genome Browser utilities, running the command without any arguments will display the usage statement and any available flags:
```bash
newPythonProg
```

### Post-Generation Setup
After generating the skeleton, you must update the file permissions to make the script executable:
```bash
chmod +x my_new_script.py
```

## Expert Tips and Best Practices
- **Standardization**: Use this tool whenever starting a new utility intended for the Bioconda or UCSC ecosystem to ensure your script matches the expected directory and coding standards.
- **Environment**: If you encounter a "permission denied" error when trying to run the tool itself after a direct download, ensure the binary has executable permissions (`chmod +x newPythonProg`).
- **Kent Suite Context**: This tool is often used alongside `newProg` (which creates C program skeletons). If you are developing a hybrid C/Python utility, use both to maintain structural harmony.
- **MySQL Connectivity**: If your generated Python script needs to connect to the UCSC public MySQL server, ensure you have an `.hg.conf` file in your home directory as per UCSC requirements.

## Reference documentation
- [ucsc-newpythonprog - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-newpythonprog_overview.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [Index of /admin/exe/macOSX.arm64](./references/hgdownload_cse_ucsc_edu_admin_exe_macOSX.arm64.md)