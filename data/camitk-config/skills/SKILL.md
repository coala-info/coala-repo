---
name: camitk-config
description: This tool configures camitk for various bioinformatics tasks. Use when user asks to set up or modify camitk configurations.
homepage: https://anaconda.org/channels/bioconda/packages/camitk-config/overview
metadata:
  docker_image: "biocontainers/camitk-config:v4.1.2-3-deb_cv1"
---

# camitk-config

camitk-config/
├── SKILL.md
└── references/
    └── anaconda_org_channels_bioconda_packages_camitk-config_overview.md
```yaml
name: camitk-config
description: Configure camitk for various bioinformatics tasks. Use when Claude needs to set up or modify camitk configurations, especially for specific biological data types or analysis pipelines, by interacting with its command-line interface.
```
## Overview
This skill provides guidance on configuring the `camitk-config` tool, a command-line utility for setting up and managing configurations for the Cambridge Medical Imaging and Genomics Toolkit (camitk). It is designed to help users tailor `camitk` for specific bioinformatics workflows, data types, and analysis pipelines.

## Usage Instructions

The `camitk-config` tool is primarily used via its command-line interface. The general pattern involves specifying a configuration file and then applying specific settings or profiles.

### Basic Configuration

To apply a default configuration, you might use a command like:

```bash
camitk-config --config <path/to/config.json> --apply
```

### Specifying Profiles

`camitk-config` often supports predefined profiles for common use cases. To apply a specific profile:

```bash
camitk-config --profile <profile_name> --apply
```

For example, to apply a profile for medical imaging analysis:

```bash
camitk-config --profile medical_imaging --apply
```

### Customizing Settings

You can also override specific settings within a configuration or profile:

```bash
camitk-config --config <path/to/config.json> --set <setting_key>=<value> --apply
```

Or, when using a profile:

```bash
camitk-config --profile <profile_name> --set <setting_key>=<value> --apply
```

### Listing Available Options

To see available profiles or configuration options, use the `--list` flag:

```bash
camitk-config --list-profiles
camitk-config --list-settings --profile <profile_name>
```

### Advanced Tips

*   **Understand your data**: Before configuring, ensure you understand the type of biological data you are working with (e.g., medical images, genomic sequences) and the specific analysis you intend to perform. This will guide your choice of profiles and settings.
*   **Iterative configuration**: For complex pipelines, it's often best to start with a known profile and then iteratively adjust specific settings using the `--set` option.
*   **Consult documentation**: Always refer to the official `camitk` documentation for the most up-to-date information on available profiles, settings, and their implications.

## Reference documentation
- [Overview of camitk-config on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_camitk-config_overview.md)