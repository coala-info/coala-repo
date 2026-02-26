---
name: centreseq
description: This tool facilitates the fast generation of a core genome from bacterial strains. Use when user asks to identify and extract the core genome from a set of bacterial strains, analyze conserved regions across multiple bacterial genomes, or prepare data for comparative genomics analyses.
homepage: https://github.com/bfssi-forest-dussault/centreseq
---


# centreseq

centreseq/SKILL.md
---
name: centreseq
description: |
  Facilitates the fast generation of a core genome from bacterial strains.
  Use when Claude needs to:
  - Identify and extract the core genome from a set of bacterial strains.
  - Analyze conserved regions across multiple bacterial genomes.
  - Prepare data for comparative genomics analyses.
---
## Overview

The `centreseq` tool is designed to efficiently determine the core genome from a collection of bacterial strains. This is crucial for comparative genomics, allowing researchers to focus on the conserved genetic material shared by all strains, which is often indicative of essential genes and evolutionary relationships.

## Usage Instructions

### Installation

The recommended installation method is via Conda, specifically from the bioconda channel. Due to potential conflicts with other bioinformatics tools like Prokka, a specific installation sequence is advised:

1.  **Add necessary channels:**
    ```bash
    conda config --add channels defaults
    conda config --add channels bioconda
    conda config --add channels conda-forge
    ```
2.  **Create and activate a dedicated environment:**
    ```bash
    conda create -n centreseq python=3.7
    conda activate centreseq
    ```
3.  **Install `centreseq` and `prokka` with specific configurations:**
    ```bash
    conda install centreseq -c bioconda
    conda uninstall prokka # Uninstall if already present to avoid conflicts
    conda install -c conda-forge -c bioconda -c defaults prokka
    ```
    *Note: A specific version of `mmseqs2` (v9-d36de) is pinned in `meta.yaml` to avoid a bug in v10-6d92c that can cause functional tests to hang. If you encounter issues with Prokka, downgrading Perl might help: `conda install perl=5.22.0`.*

### Core Functionality

`centreseq` operates by taking multiple bacterial genome assemblies as input and identifying the regions that are conserved across all of them, thus defining the core genome.

While specific command-line arguments and detailed usage patterns are not extensively documented in the provided materials, the general workflow involves providing the input genome files to the `centreseq` executable.

**General Command Structure (Illustrative):**

```bash
centreseq --input <path/to/genome1.fasta> --input <path/to/genome2.fasta> ... --output <output_directory>
```

*   `--input`: Specify one or more input genome assembly files (e.g., FASTA format).
*   `--output`: Define the directory where the core genome results will be saved.

**Expert Tips:**

*   **Input Format:** Ensure all input genome files are in a compatible format (typically FASTA).
*   **Strain Selection:** The quality of the core genome heavily depends on the selection of input strains. Choose strains that are representative of the population you are studying.
*   **Computational Resources:** Generating a core genome can be computationally intensive, especially with a large number of strains or very large genomes. Ensure you have adequate CPU and memory resources.
*   **Dependencies:** Be mindful of the specific versions of dependencies like `prokka` and `mmseqs2` as outlined in the installation instructions, as they are critical for stable operation.

## Reference documentation
- [centreseq Overview](./references/anaconda_org_channels_bioconda_packages_centreseq_overview.md)
- [centreseq GitHub Repository](./references/github_com_BFSSI-Bioinformatics-Lab_centreseq.md)
- [centreseq Documentation (GitHub)](./references/github_com_BFSSI-Bioinformatics-Lab_centreseq_tree_master_docs.md)
---