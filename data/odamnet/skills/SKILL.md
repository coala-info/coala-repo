---
name: odamnet
description: "ODAMNet analyzes molecular relationships between chemicals and rare diseases. Use when user asks to analyze chemical-disease associations using overlap, active module identification, or random walk approaches."
homepage: https://pypi.org/project/ODAMNet/1.1.0/
---


# odamnet

A Python package for studying molecular relationships between chemicals and rare diseases.
  Use when Claude needs to analyze chemical-disease associations using overlap, active module identification, or random walk approaches.
  This skill is suitable for researchers and bioinformaticians working with chemical and disease data.
body: |
  ## Overview
  ODAMNet is a Python tool designed to investigate the molecular connections between environmental chemicals and rare diseases. It offers three primary analytical approaches: overlap analysis to find direct associations between chemical targets and disease pathways, active module identification (AMI) using DOMINO to uncover functional modules within biological networks, and random walk with restart (RWR) via multiXrank to measure proximity within a multilayer network. This skill enables users to leverage these methods for in-depth biological relationship studies.

  ## Usage Instructions

  ODAMNet can be installed via pip or conda.

  **Installation:**
  *   **pip:** `python3 -m pip install odamnet`
  *   **conda:** `conda install bioconda::odamnet`

  **Core Command Structure:**
  The general command structure is:
  `odamnet [command] [ARGS]`

  **Available Commands:**
  *   `overlap`: Computes the overlap between chemical target genes and rare disease pathways.
  *   `domino`: Performs Active Module Identification (AMI) using the DOMINO tool.
  *   `multixrank`: Executes Random Walk with Restart (RWR) using the multiXrank package.
  *   `networkCreation`: Creates a rare disease pathways network and its corresponding disease-gene bipartite.
  *   `networkDownloading`: Downloads biological networks from NDEx using a network UUID.

  **Detailed Command Examples:**

  ### Overlap Analysis
  This approach identifies direct associations by finding chemical target genes within rare disease pathways.

  ```bash
  odamnet overlap --chemicalsFile <path/to/your/chemicals.txt>
  ```
  *   `--chemicalsFile`: Path to a file containing the list of chemicals.

  ### Active Module Identification (AMI)
  Uses DOMINO to find active modules in a biological network based on chemical targets and then overlaps these modules with rare disease pathways.

  ```bash
  odamnet domino --chemicalsFile <path/to/your/chemicals.txt> --networkFile <path/to/your/network.sif>
  ```
  *   `--chemicalsFile`: Path to a file containing the list of chemicals.
  *   `--networkFile`: Path to the biological network file (e.g., PPI network).

  ### Random Walk with Restart (RWR)
  Measures the proximity of genes and diseases to target genes within a multilayer network.

  ```bash
  odamnet multixrank --chemicalsFile <path/to/your/chemicals.txt> --configPath <path/to/config.ini> --networksPath <path/to/networks/directory> --seedsFile <path/to/seeds.txt> --sifFileName <output_network_name>
  ```
  *   `--chemicalsFile`: Path to a file containing the list of chemicals.
  *   `--configPath`: Path to the multiXrank configuration file.
  *   `--networksPath`: Path to the directory containing network files.
  *   `--seedsFile`: Path to the file containing target genes (seeds).
  *   `--sifFileName`: Name for the output network file.

  ### Network Creation
  Generates a rare disease pathway network and its disease-gene bipartite, useful for RWR.

  ```bash
  odamnet networkCreation --networksPath <path/to/save/networks/> --bipartitePath <path/to/save/bipartite/>
  ```
  *   `--networksPath`: Directory to save the generated disease network.
  *   `--bipartitePath`: Directory to save the generated disease-gene bipartite.

  ### Network Downloading
  Downloads biological networks from NDEx.

  ```bash
  odamnet networkDownloading --netUUID <network_uuid> --networkFile <output_network_name.sif>
  ```
  *   `--netUUID`: The unique identifier for the network on NDEx.
  *   `--networkFile`: The desired name for the downloaded network file.

  ## Expert Tips
  *   Ensure your chemical lists and network files are correctly formatted as per the ODAMNet documentation.
  *   For RWR, carefully configure the `config.ini` file to match your network structure and analysis goals. Refer to the ODAMNet documentation for details on the configuration file.
  *   Rare disease pathways are automatically retrieved from WikiPathways.
  *   Chemical target genes are automatically retrieved from the Comparative Toxicogenomics Database (CTD).

  ## Reference documentation
  - [ODAMNet Usage and Installation Details](./github_com_MOohTus_ODAMNet.md)
  - [ODAMNet Overview and Installation](./anaconda_org_channels_bioconda_packages_odamnet_overview.md)
  - [ODAMNet PyPI Information](./pypi_org_project_ODAMNet_1.1.0.md)