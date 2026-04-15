---
name: mdasim
description: MDAsim simulates whole genome amplification of DNA sequences using Multiple Displacement Amplification. Use when user asks to simulate MDA for a DNA sequence, model its effects on genome coverage, or generate simulated amplified DNA data.
homepage: https://sourceforge.net/projects/mdasim/
metadata:
  docker_image: "quay.io/biocontainers/mdasim:2.1.1--hf316886_7"
---

# mdasim

yaml
name: mdasim
description: Simulates whole genome amplification of DNA sequences using Multiple Displacement Amplification (MDA). Use when you need to model the MDA process for a given DNA sequence, understand its effects on genome coverage, or generate simulated amplified DNA data.
```
## Overview
MDAsim is a tool designed to simulate the process of whole genome amplification (WGA) using Multiple Displacement Amplification (MDA) on a DNA sequence. It allows researchers to model how MDA affects DNA sequences, predict amplification outcomes, and generate synthetic data for downstream analyses. This is particularly useful for understanding biases introduced by MDA and for testing analytical methods on simulated data.

## Usage Instructions

MDAsim is a command-line tool. The primary function is to simulate MDA on a given DNA sequence.

### Basic Simulation

The core command involves specifying the input DNA sequence file and an output file for the simulated amplified DNA.

```bash
mdasim <input_fasta_file> <output_fasta_file>
```

**Example:**
To simulate MDA on `genome.fasta` and save the output to `amplified_genome.fasta`:

```bash
mdasim genome.fasta amplified_genome.fasta
```

### Key Parameters and Options

While the basic usage is straightforward, MDAsim offers parameters to control the simulation. The exact parameters and their default values are crucial for accurate simulation. Refer to the tool's documentation or help output for a comprehensive list.

**Common simulation parameters might include:**

*   **Sequence Input:** The FASTA file containing the DNA sequence to be amplified.
*   **Output File:** The FASTA file where the simulated amplified DNA sequence will be written.
*   **Amplification Parameters:** These can significantly influence the simulation. Examples might include:
    *   **Primer concentration:** Affects the density of primer binding sites.
    *   **Enzyme activity/kinetics:** Simulates the rate and processivity of the polymerase.
    *   **Incubation time:** Determines the extent of amplification.
    *   **Random priming:** Whether primers bind randomly or with specific biases.
    *   **Fragment length distribution:** Controls the size of amplified DNA fragments.

**To get detailed information on available options and parameters, use the help flag:**

```bash
mdasim --help
```

### Best Practices and Tips

*   **Input Sequence Quality:** Ensure your input FASTA file is correctly formatted and represents the DNA sequence accurately. Errors in the input can lead to unexpected simulation results.
*   **Parameter Tuning:** Experiment with different amplification parameters to understand their impact on the simulated output. The choice of parameters should ideally reflect experimental conditions if you are trying to mimic a specific MDA protocol.
*   **Citation:** Always cite the MDAsim tool in your publications. For MDAsim 2+, cite:
    *   Tagliavi Z, Draghici S. MDAsim: A multiple displacement amplification simulator. 2012 IEEE International Conference on Bioinformatics and Biomedicine (BIBM). 2012. pp. 1–4. doi:10.1109/BIBM.2012.6392622
    *   A citation for MDAsim 2+ will be provided when available.
*   **Version Compatibility:** Be aware of the version of MDAsim you are using, as functionality and parameters may change between versions. The bioconda channel provides versions like 2.1.1, 2.1.0, etc.

## Reference documentation
- [MDAsim Overview (bioconda)](./references/anaconda_org_channels_bioconda_packages_mdasim_overview.md)
- [MDAsim Project Page (SourceForge)](./references/sourceforge_net_projects_mdasim.md)
- [MDAsim File Downloads (SourceForge)](./references/sourceforge_net_projects_mdasim_files.md)