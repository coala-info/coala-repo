---
name: mtbl-labs-uploader
description: The MetaboLights Labs Uploader is a specialized tool designed to streamline the deposition of metabolomics datasets.
homepage: https://github.com/phnmnl/container-mtbl-labs-uploader
---

# mtbl-labs-uploader

## Overview
The MetaboLights Labs Uploader is a specialized tool designed to streamline the deposition of metabolomics datasets. It handles the transmission of experimental metadata and associated data files to the MetaboLights Labs infrastructure. This skill provides the necessary command-line patterns to execute uploads via Docker, ensuring that study components like ISA-Tab archives and spectral data are correctly mapped and transferred.

## Command Line Usage

The tool is primarily distributed as a Docker container. Use the following patterns to perform uploads.

### Authentication
All commands require a MetaboLights Labs API key (token).
- Flag: `-t "your_api_key"`

### Pattern 1: Uploading Individual Files
Use the `--i` flag to specify a list of individual files (e.g., metadata archives and data bundles).

```bash
docker run -v $PWD:/data container-registry.phenomenal-h2020.eu/phnmnl/mtbl-labs-uploader \
  -t "YOUR_API_KEY" \
  --i /data/isa_metadata.zip /data/raw_data.tar /data/metabolite_assignments.zip \
  -n -s
```

### Pattern 2: Uploading a Directory
Use the `--I` flag (capital 'i') to point the tool to a directory containing all relevant study files and ISA-Tab documents.

```bash
docker run -v $PWD:/data container-registry.phenomenal-h2020.eu/phnmnl/mtbl-labs-uploader \
  -t "YOUR_API_KEY" \
  --I /data/study_folder/ \
  -n -s
```

## Best Practices and Tips

- **Volume Mapping**: Always map your local data directory to a container volume (e.g., `-v $PWD:/data`) so the tool can access your files.
- **File Formats**: Ensure your metadata follows the ISA-Tab standard. The tool is optimized for `.zip` and `.tar` archives containing these files.
- **Execution Flags**:
  - `-n`: Typically used to initialize a new upload or entry.
  - `-s`: Triggers the synchronization/submission process.
- **Data Types**: The uploader supports various metabolomics data types, including Mass Spectrometry (MS) and Nuclear Magnetic Resonance (NMR), as well as isotopic labelling analysis.

## Reference documentation
- [MetaboLights Labs Uploader README](./references/github_com_phnmnl_container-mtbl-labs-uploader_blob_master_README.md)
- [Main Repository Overview](./references/github_com_phnmnl_container-mtbl-labs-uploader.md)