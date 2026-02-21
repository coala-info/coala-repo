---
name: favites_lite
description: FAVITES-Lite (FrAmework for VIral Transmission and Evolution Simulation) is a streamlined, high-performance tool designed to model viral outbreaks.
homepage: https://github.com/niemasd/FAVITES-Lite
---

# favites_lite

## Overview

FAVITES-Lite (FrAmework for VIral Transmission and Evolution Simulation) is a streamlined, high-performance tool designed to model viral outbreaks. It simplifies the complex process of simulating how a virus spreads through a population while simultaneously evolving. By prioritizing the most common simulation features, it offers a faster and more user-friendly alternative to the original FAVITES framework, making it ideal for large-scale epidemic modeling where computational efficiency is critical.

## Installation and Environment

The most reliable way to use FAVITES-Lite is via Bioconda, as it automatically manages several specialized bioinformatic dependencies.

```bash
# Install via Conda
conda install -c bioconda favites_lite
```

### Core Dependencies
Ensure the following command-line tools are available in your `PATH`, as `favites_lite.py` calls them internally:
- **Transmission Modeling**: `GEMF_FAVITES`, `NiemaGraphGen`
- **Evolution/Phylogeny**: `CoaTran`, `TreeSAP`, `TreeSwift`
- **Sequence Generation**: `Seq-Gen`

## Command Line Usage

The primary interface is the `favites_lite.py` executable. It requires a pre-defined configuration file (JSON format) and an output directory.

### Basic Execution
```bash
python3 favites_lite.py -c config.json -o ./simulation_results
```

### Common Arguments
- `-c, --config`: Path to the JSON configuration file defining simulation parameters.
- `-o, --output`: Path to the directory where results will be stored.
- `--overwrite`: Use this flag if the output directory already exists and you wish to replace it.
- `--quiet`: Suppresses log messages during the run, useful for batch processing.

## Expert Tips and Best Practices

### Configuration Strategy
While FAVITES-Lite uses JSON for configuration, manually authoring these files is error-prone. 
- **Use the Config Designer**: Utilize the official FAVITES-Lite Config Designer web application to generate your `config.json`. It provides documentation for every model choice and parameter.
- **Validation**: Always run a short "pilot" simulation with a small population size to verify that your configuration produces the expected file types before launching large-scale runs.

### Downstream Analysis
The repository includes a `scripts/` directory organized by simulation steps. 
- Check these subdirectories for helper scripts that assist in parsing the simulation output.
- Each script folder typically contains its own README detailing specific analysis capabilities.

### Performance Optimization
- **Lite vs. Full**: If your simulation requires extreme flexibility (e.g., custom modules not present in the Lite version), you may need the original FAVITES. However, for >90% of viral simulation use cases, FAVITES-Lite is significantly faster and recommended.
- **Docker**: For reproducible environments or when encountering dependency conflicts on local machines, use the FAVITES-Lite Docker image.

## Reference documentation
- [FAVITES-Lite GitHub Repository](./references/github_com_niemasd_FAVITES-Lite.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_favites_lite_overview.md)
- [FAVITES-Lite Wiki](./references/github_com_niemasd_FAVITES-Lite_wiki.md)