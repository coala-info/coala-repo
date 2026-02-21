---
name: amdirt
description: The AncientMetagenomeDir Toolkit (`amdirt`) is a specialized Python-based utility designed for researchers working with ancient DNA (aDNA) and metagenomics.
homepage: https://github.com/SPAAM-community/AMDirT
---

# amdirt

## Overview
The AncientMetagenomeDir Toolkit (`amdirt`) is a specialized Python-based utility designed for researchers working with ancient DNA (aDNA) and metagenomics. It serves as the primary interface for the AncientMetagenomeDir repository, a community-curated collection of metadata for ancient metagenomic samples. This skill enables the automated retrieval of sequencing data, ensures metadata compliance through validation tools, and streamlines the transition from metadata discovery to computational analysis by generating pipeline-ready samplesheets.

## Installation and Setup
The tool is available via Bioconda or PyPI. It is recommended to use a dedicated environment to avoid dependency conflicts.

```bash
# Installation via Conda (Recommended)
conda create -n amdirt -c bioconda amdirt
conda activate amdirt

# Installation via Pip
pip install amdirt
```

## Core Functionalities
While specific subcommand flags vary by version, the toolkit follows a standard CLI pattern for the following tasks:

### 1. Metadata Exploration and Download
Use `amdirt` to query the repository and fetch raw sequencing data (FASTQ files) based on specific project IDs or sample metadata.
- **Best Practice**: Always verify the available disk space before initiating downloads, as ancient metagenomic datasets can be extremely large.
- **Tip**: Use the tool to filter for specific types of ancient data (e.g., host-associated vs. environmental) before committing to a full download.

### 2. Submission Validation
For researchers contributing to the AncientMetagenomeDir project, the toolkit provides validation scripts to ensure that new metadata entries meet the community's schema requirements.
- **Workflow**: Run the validation command on your local metadata files before submitting a Pull Request to the SPAAM-community repository.

### 3. Samplesheet Generation
One of the most powerful features of `amdirt` is its ability to transform repository metadata into formatted samplesheets for downstream bioinformatic pipelines (such as nf-core/eager).
- **Expert Tip**: Ensure your local file paths are correctly mapped if you have already downloaded data manually; otherwise, let `amdirt` handle the pathing during the generation process.

## Expert Tips
- **Development Version**: If you require the latest features or bug fixes not yet in the stable release, install directly from the development branch:
  `pip install --upgrade git+https://github.com/SPAAM-community/amdirt.git@dev`
- **Documentation Access**: For detailed subcommand help, use the standard `--help` flag at any level of the CLI:
  `amdirt --help` or `amdirt [subcommand] --help`

## Reference documentation
- [AncientMetagenomeDir Toolkit Overview](./references/github_com_SPAAM-community_amdirt.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_amdirt_overview.md)