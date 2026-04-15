---
name: tidk
description: The Telomere Identification toolKit identifies, searches for, and visualizes telomeric repeat patterns in genomic assemblies or raw reads. Use when user asks to discover unknown telomeric repeats, calculate repeat density across a genome, or generate SVG plots of telomere locations.
homepage: https://github.com/tolkit/telomeric-identifier
metadata:
  docker_image: "quay.io/biocontainers/tidk:0.2.65--h3dc2dae_0"
---

# tidk

## Overview
The Telomere Identification toolKit (`tidk`) is a specialized suite of tools designed to detect and analyze telomeric repeat patterns in genomic data. It is particularly useful for assessing the completeness of chromosomal assemblies and identifying the orientation of scaffolds. The toolkit provides a full workflow: from de novo discovery of the repeat unit to window-based density calculations and final SVG visualization.

## Core Workflows

### 1. Database Initialization
Before using clade-based searches, you must initialize the local telomeric repeat database.
```bash
tidk build
```

### 2. Discovering Unknown Repeats
If the telomeric repeat of an organism is unknown, use the `explore` module. It searches for tandemly repeating kmers within a specified size range.
*   **Standard Genome:** Searches the ends of sequences (default 1% distance).
*   **Raw Reads (PacBio HiFi):** Use `--distance 0.5` to search the entire length of the reads.

```bash
# Search for repeats between 5bp and 12bp
tidk explore --minimum 5 --maximum 12 input.fa > potential_repeats.tsv
```

### 3. Mapping Known Repeats
Once the repeat sequence is known, use `find` (for clade-specific defaults) or `search` (for custom strings) to calculate repeat density in windows across the genome.

**Using Clade Defaults:**
```bash
# List available clades
tidk find --print

# Search using a specific clade (e.g., Lepidoptera)
tidk find --clade Lepidoptera --window 10000 --output lepid_telos input.fa
```

**Using a Custom String:**
```bash
tidk search --string TTAGG --window 5000 --output custom_search --dir output_dir input.fa
```

### 4. Visualization
The `plot` module converts the CSV/TSV output from the `find` or `search` commands into an SVG visualization.
```bash
tidk plot --csv lepid_telos.csv --output telomere_plot.svg
```

## Expert Tips and Best Practices
*   **Canonical Forms:** `tidk` reports repeats in their canonical form (e.g., TTAGG is often reported as its reverse complement AACCT depending on the strand).
*   **Window Size:** For highly contiguous chromosomal assemblies, a window size of 10kb to 50kb is usually sufficient. For fragmented assemblies or raw reads, smaller windows may be necessary to see local density spikes.
*   **Thresholding:** In `explore`, the `--threshold` parameter (default 100) controls how many sequential occurrences are needed to report a repeat. Increase this if you are getting too much noise from microsatellites.
*   **Distance Parameter:** The `--distance` flag in `explore` is a proportion (0 to 0.5). Setting it to `0.01` (default) focuses on the terminal 1% of each scaffold, which is where telomeres are expected in chromosomal-level assemblies.



## Subcommands

| Command | Description |
|---------|-------------|
| tidk explore | Use a range of kmer sizes to find potential telomeric repeats. One of either length, or minimum and maximum must be specified. |
| tidk find | Supply the name of a clade your organsim belongs to, and this submodule will find all telomeric repeat matches for that clade. |
| tidk_plot | SVG plot of TSV generated from tidk search. |
| tidk_search | Search the input genome with a specific telomeric repeat search string. |

## Reference documentation
- [A Telomere Identification toolKit (README)](./references/github_com_tolkit_telomeric-identifier_blob_main_README.md)
- [tidk Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_tidk_overview.md)