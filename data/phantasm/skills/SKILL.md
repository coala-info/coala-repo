---
name: phantasm
description: PHANTASM automates microbial phylogenomic workflows including core gene identification, phylogenomic tree construction, and the calculation of overall genome-related indices. Use when user asks to verify the taxonomic placement of a microbial strain, identify phylogenetic markers, or perform comparative genomics for systematic purposes.
homepage: https://github.com/dr-joe-wirth/phantasm
metadata:
  docker_image: "quay.io/biocontainers/phantasm:1.1.3--pyhdfd78af_0"
---

# phantasm

## Overview
PHANTASM (PHylogenomic ANalyses for the TAxonomy and Systematics of Microbes) is a specialized tool designed to automate the complex workflows required for modern microbial taxonomy. It streamlines the process of identifying phylogenetic markers, calculating overall genome-related indices (OGRI), and constructing phylogenomic trees. Use this skill when you need to verify the taxonomic placement of a microbial strain, identify core genes across a set of genomes, or perform comparative genomics for systematic purposes.

## Usage and CLI Patterns

### Initial Setup and Verification
Before running analyses, ensure the environment is correctly configured. PHANTASM relies on several external binaries (BLAST+, MUSCLE, FastTree, IQTree).

- **Check Dependencies**: Verify that all external software and paths are correctly configured.
  ```bash
  phantasm check
  ```
- **Check Version**: Ensure you are using the expected version of the tool.
  ```bash
  phantasm version
  ```

### Core Workflow Commands
PHANTASM operations are organized into specific tasks. You can access help for any specific task to see required inputs.

- **General Help**:
  ```bash
  phantasm help
  ```
- **Task-Specific Help**:
  ```bash
  phantasm <TASK> --help
  ```
  *Common tasks include: `analyzeGenomes`, `getPhyloMarker`, `rankPhyloMarkers`, and `knownPhyloMarker`.*

### Execution Modes
- **Conda/Docker**: If installed via Bioconda or running in the official Docker container, use the `phantasm` command directly.
- **Native/Source**: If running from a cloned repository, call the script via Python:
  ```bash
  python3 path/to/phantasm.py <TASK> [options]
  ```

## Expert Tips and Best Practices

- **Numerical Stability**: When dealing with complex datasets that might cause calculation errors, use the `-safe` flag to prevent numerical underflow during tree construction or index calculations.
- **NCBI Communication**: PHANTASM uses Biopython's `Bio.Entrez` for certain tasks. While some newer tasks like `analyzeGenomes` may not strictly require it, it is best practice to have an email address configured in your environment for NCBI API etiquette.
- **Configuration Management**: For native installations, the `param.py` file is the source of truth for tool paths. If you encounter "command not found" errors during a `phantasm check`, verify the absolute paths for `BLASTPLUS_DIR`, `MUSCLE_EXE`, `FASTTREE_EXE`, and `IQTREE_EXE` in that file.
- **Input Preparation**: Ensure your genome files are properly formatted (GenBank or FASTA) as required by the specific task. PHANTASM is designed to handle the heavy lifting of core gene extraction once the inputs are provided.
- **Phylogenetic Markers**: If you are unsure which markers to use for a specific taxon, use the `rankPhyloMarkers` task to identify the most informative genes for your specific group of microbes.

## Reference documentation
- [PHANTASM GitHub Repository](./references/github_com_dr-joe-wirth_phantasm.md)
- [PHANTASM Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_phantasm_overview.md)