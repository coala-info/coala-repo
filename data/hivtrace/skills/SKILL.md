---
name: hivtrace
description: HIV-TRACE identifies transmission clusters in HIV sequence data by calculating genetic distances and inferring molecular networks. Use when user asks to identify transmission clusters, calculate pairwise genetic distances using the TN93 model, or perform molecular epidemiology for public health surveillance.
homepage: https://github.com/veg/hivtrace
metadata:
  docker_image: "quay.io/biocontainers/hivtrace:1.5.0--py_0"
---

# hivtrace

## Overview
HIV-TRACE (TRAnsmission Cluster Engine) is a specialized molecular epidemiology tool used to identify potential transmission clusters within HIV sequence data. It processes nucleotide sequences (typically in FASTA format) by aligning them to a reference, calculating pairwise genetic distances using the TN93 substitution model, and inferring a network where nodes are sequences and edges represent genetic links below a specific distance threshold. This skill enables the automation of sequence curation, alignment, and network inference for public health surveillance and outbreak investigation.

## Installation and Setup
The tool requires `python3` and the `tn93` binary. It can be installed via pip or conda:

```bash
# Via pip
pip3 install hivtrace

# Via bioconda
conda install bioconda::hivtrace
```

## Common CLI Patterns

### Standard Cluster Analysis
To run a standard analysis on a protease/reverse transcriptase (PRRT) dataset with ambiguity resolution and comparison to the LANL database:
```bash
hivtrace -i sequences.fasta -a resolve -r HXB2_prrt -t 0.015 -m 500 -g 0.05 -c -o results.json
```

### Working with Pre-aligned Sequences
If sequences are already aligned and do not require the internal alignment step (note: this disables LANL comparison):
```bash
hivtrace -i aligned.fasta --skip-alignment -t 0.015 -m 500 -o results.json
```

### Filtering Spurious Connections
To remove transitive connections (triangles) that may be phylogenetically independent:
```bash
hivtrace -i sequences.fasta -r HXB2_pol -t 0.015 -f remove
```

### Masking Drug Resistance Mutations (DRAMs)
To prevent drug-selected convergent evolution from creating false genetic links, mask known DRAM positions:
```bash
# Using Lewis et al. positions
hivtrace -i sequences.fasta -r HXB2_prrt -t 0.015 -s lewis

# Using Wheeler et al. positions
hivtrace -i sequences.fasta -r HXB2_prrt -t 0.015 -s wheeler
```

## Parameter Guidance

### Ambiguity Handling (`-a`)
*   `resolve`: (Recommended) Counts resolutions that match as a perfect match. Use with `-g` to limit resolution to sequences with low ambiguity fractions.
*   `average`: Averages all possible resolutions.
*   `skip`: Ignores positions with ambiguities.
*   `gapmm`: Treats gaps as 4-way mismatches.

### Reference Sequences (`-r`)
Common presets include:
*   `HXB2_prrt`: Protease and Reverse Transcriptase (standard for resistance testing data).
*   `HXB2_pol`: The entire pol gene (PR, RT, and Integrase).
*   `HXB2_env`: Envelope glycoprotein.
*   `Path/to/file`: You can provide a custom FASTA file as a reference.

### Thresholds and Overlaps
*   **Threshold (`-t`)**: For HIV-1, `0.015` (1.5%) is the standard threshold for identifying recent transmission links in the PRRT region.
*   **Minimum Overlap (`-m`)**: Ensure sequences overlap by enough characters to make the distance estimate reliable. A rule of thumb is to have at least `2 / threshold` aligned characters (e.g., 133bp for a 0.015 threshold).

## Output and Visualization
The primary output is a JSON file containing the network structure, cluster assignments, and metadata.
*   **Local Visualization**: Use the command `hivtrace_viz results.json`.
*   **Web Visualization**: Upload the JSON file to [https://veg.github.io/hivtrace-viz/](https://veg.github.io/hivtrace-viz/).

## Reference documentation
- [HIV-TRACE GitHub Repository](./references/github_com_veg_hivtrace.md)
- [Bioconda hivtrace Overview](./references/anaconda_org_channels_bioconda_packages_hivtrace_overview.md)