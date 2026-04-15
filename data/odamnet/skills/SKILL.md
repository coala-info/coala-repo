---
name: odamnet
description: odamnet identifies and quantifies molecular links between environmental chemicals and rare diseases by integrating chemical-gene interactions with biological networks and disease pathways. Use when user asks to perform overlap analysis, identify active modules using DOMINO, conduct random walk with restart analysis, or create and download biological networks.
homepage: https://pypi.org/project/ODAMNet/1.1.0/
metadata:
  docker_image: "quay.io/biocontainers/odamnet:1.1.0--pyhdfd78af_0"
---

# odamnet

## Overview
ODAMNet is a bioinformatics package designed to identify and quantify the molecular links between environmental factors (chemicals) and rare diseases. It automates the process of fetching chemical-gene interactions from the Comparative Toxicogenomics Database (CTD) and rare disease pathways from WikiPathways. By integrating these data sources with biological networks, it allows researchers to explore direct overlaps or more complex network-based proximities.

## Command Line Usage

### 1. Overlap Analysis
Use this for finding direct associations where chemical target genes are explicitly part of rare disease pathways.
```bash
odamnet overlap --chemicalsFile <path_to_chemicals_list>
```

### 2. Active Module Identification (AMI)
Use this to identify "active modules" within a Protein-Protein Interaction (PPI) network using the DOMINO algorithm, then check for overlaps with disease pathways.
```bash
odamnet domino --chemicalsFile <path_to_chemicals_list> --networkFile <path_to_ppi_network>
```

### 3. Random Walk with Restart (RWR)
Use this for measuring the proximity of nodes in a multilayer network. This is the most complex approach, requiring a specific directory structure and configuration.
```bash
odamnet multixrank \
    --chemicalsFile <path_to_chemicals_list> \
    --configPath <path_to_config_json_or_yaml> \
    --networksPath <path_to_networks_dir> \
    --seedsFile <path_to_seeds_file> \
    --sifFileName <output_filename>
```

### 4. Network Management
Before running RWR, you often need to create the disease-specific network layer or download PPI networks.

**Create Disease Network and Bipartite:**
```bash
odamnet networkCreation --networksPath <output_dir> --bipartitePath <output_bipartite_path>
```

**Download from NDEx:**
```bash
odamnet networkDownloading --netUUID <NDEx_UUID> --networkFile <output_filename>
```

## Best Practices
- **Chemical Input**: Ensure your chemicals file contains identifiers compatible with CTD (typically chemical names or MeSH IDs).
- **Network Selection**: For `domino`, a high-quality PPI network is critical. You can use the `networkDownloading` function to pull validated networks from NDEx.
- **RWR Configuration**: The `multixrank` approach requires a configuration file that defines the multilayer layout. Ensure your `--networksPath` contains the subdirectories expected by the multiXrank package.
- **Automated Retrieval**: Remember that ODAMNet automatically handles the SPARQL queries to WikiPathways and API calls to CTD, so an active internet connection is required for the initial data gathering.



## Subcommands

| Command | Description |
|---------|-------------|
| odamnet domino | Perform Active module identification analysis between genes targeted by   chemicals and rare diseases pathways using DOMINO. |
| odamnet multixrank | Performs a Random Walk with Restart analysis using multiXrank with genes and diseases multilayers. |
| odamnet networkCreation | Creates network (GR format) from WikiPathways request or pathways of interest given in GMT file. |
| odamnet networkDownloading | Download networks from NDEx using the UUID network. Create SIF (3 columns   with header) or GR (2 columns without header) network |
| odamnet_overlap | Perform Overlap analysis between genes targeted by chemicals and rare diseases pathways. |

## Reference documentation
- [ODAMNet Repository Overview](./references/github_com_MOohTus_ODAMNet_blob_main_README.md)
- [Project Dependencies and Metadata](./references/github_com_MOohTus_ODAMNet_blob_main_pyproject.toml.md)