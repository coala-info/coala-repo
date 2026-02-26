---
name: irida-linker
description: The irida-linker tool automates the retrieval and organization of genomic data from the IRIDA platform into a structured local directory. Use when user asks to link or download IRIDA project data, retrieve specific samples or assemblies, and synchronize local folders with the IRIDA archive.
homepage: https://github.com/phac-nml/irida-linker
---


# irida-linker

## Overview
The `irida-linker` (NGS Archive Linker) is a specialized tool for bioinformaticians and genomic researchers who need to bridge the gap between the IRIDA web platform and command-line analysis environments. It automates the retrieval of data by creating a standardized directory hierarchy: `[output_directory]/[project_name]/[sample_name]/[files]`. 

Use this skill when you need to:
- Organize IRIDA project data into a local folder structure for downstream analysis.
- Retrieve specific samples from a large project without manual downloading.
- Switch between soft-linking (for local filesystem access) and full downloads (for remote or cloud environments).
- Synchronize local data with IRIDA by skipping existing files or handling naming conflicts.

## Configuration
Before running the tool, ensure a configuration file exists at `$HOME/.irida/ngs-archive-linker.conf`.

```ini
[apiurls]
BASEURL = http://your-irida-instance/api

[credentials]
CLIENTID = your_client_id
CLIENTSECRET = your_client_secret
USERNAME = your_username
PASSWORD = your_password
```

## Common CLI Patterns

### Linking an Entire Project
To create soft links for every sample in a project (e.g., Project ID 4) into a directory named `data`:
```bash
ngsArchiveLinker.pl --projectId 4 --output data
```

### Linking Specific Samples
To isolate specific samples (e.g., IDs 101 and 102) from a project:
```bash
ngsArchiveLinker.pl -p 4 -s 101 -s 102 -o data
```

### Retrieving Assemblies
By default, the tool links FASTQ files. To retrieve assembly files instead:
```bash
ngsArchiveLinker.pl -p 4 --type assembly -o data
```
*Note: You can request both using `--type fastq,assembly`.*

### Handling Updates and Conflicts
- **Incremental Updates**: Use `--ignore` to skip files that are already present in your local directory, which is ideal for "topping up" a project with new sequencing runs.
- **Version Handling**: Use `--rename` to add a numeric suffix to existing files if you need to keep multiple versions of the same filename.
- **Flat Structure**: Use `--flat` if your downstream pipeline requires all files in a single directory rather than nested sample folders.

### Downloading vs. Soft-linking
- **Soft-linking (Default)**: Best when the IRIDA storage is mounted on the same filesystem as your compute nodes. It consumes negligible disk space.
- **Downloading**: Use the `--download` flag if you are working on a different server or in a cloud environment (AWS/Azure) where the IRIDA storage is not directly accessible.

## Expert Tips
- **Security**: If you prefer not to store your password in the config file, omit the `PASSWORD` field; the tool will prompt you securely at runtime.
- **API Overrides**: Use the `-b` or `--baseURL` flag to quickly point the tool to a different IRIDA instance (e.g., a staging server) without modifying your global config file.
- **Verification**: Always use the `-v` (verbose) flag during your first run or when troubleshooting connection issues to see the exact REST API calls being made.

## Reference documentation
- [NGS Archive Linker Overview](./references/github_com_phac-nml_irida-linker.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_irida-linker_overview.md)