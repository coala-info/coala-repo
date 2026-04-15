---
name: livekraken
description: LiveKraken performs real-time metagenomic taxonomic classification by monitoring Illumina sequencer output directories. Use when user asks to classify reads during a sequencing run, monitor taxonomic composition in real-time, or generate Sankey diagrams of classification results.
homepage: https://gitlab.com/SimonHTausch/LiveKraken
metadata:
  docker_image: "quay.io/biocontainers/livekraken:1.0--pl5321h9948957_12"
---

# livekraken

## Overview

LiveKraken is a specialized metagenomic classifier optimized for the Illumina sequencing ecosystem. It extends the core functionality of the Kraken taxonomic classification system by enabling "live" analysis. Instead of processing static FASTQ files, LiveKraken monitors the sequencer's output directory and classifies reads in real-time. This allows researchers to monitor the taxonomic composition of a sample while the sequencing run is still in progress, facilitating rapid decision-making and early detection of pathogens or contaminants.

## Installation and Setup

LiveKraken is available via Bioconda. It is recommended to install it in a dedicated environment to manage dependencies.

```bash
conda install -c bioconda livekraken
```

**Note on Binary Names**: To avoid collisions with standard Kraken installations, LiveKraken binaries are prefixed with `live`. Use `livekraken` and `livekraken-build` instead of the standard `kraken` commands.

## Common CLI Patterns and Parameters

### Real-Time Classification
The primary use case involves pointing the tool at an active Illumina run folder.

*   **Incremental Output (`-a`)**: Use the `-a` flag to enable incremental output. This ensures that as new tiles are processed, the results are appended or updated without double-counting previously classified reads.
*   **BCL Configuration**: LiveKraken includes flags for BCL (Base Call) configuration to correctly interpret the raw sequencer output.

### Data Filtering and Selection
Because real-time processing can be computationally intensive, you can limit the scope of the analysis:

*   **Tile Selection**: Use `--max-tile` to specify the maximum number of tiles to process. This is useful for getting a representative snapshot of the run without processing every single tile.
*   **Lane Selection**: You can specify individual lanes to focus the classification on specific flowcell areas.

### Visualization
LiveKraken includes a visualization script for generating Sankey diagrams, which are effective for representing the hierarchical nature of taxonomic classifications.

*   **Sankey Diagrams**: Use the provided visualization script (often found in the installation directory) to convert classification results into interactive or static Sankey plots.
*   **Node Compression**: When visualizing, use the option to "compress" unclassified nodes to make the diagram more readable by focusing on the identified taxa.

## Expert Tips

*   **Avoid Path Collisions**: Always verify you are calling `livekraken` rather than `kraken`. If you have both installed, the `live` prefix is the definitive way to ensure you are using the real-time version.
*   **Shebang Maintenance**: If running the Perl scripts directly from the source, ensure the shebang lines point to `/usr/bin/env perl` for maximum portability across different Linux and macOS environments.
*   **Memory Management**: Like Kraken, LiveKraken relies on a database loaded into memory. Ensure your system has sufficient RAM to hold the specific Kraken database you are using (e.g., Standard, Minikraken) alongside the overhead of the real-time BCL processing.

## Reference documentation
- [LiveKraken Overview](./references/anaconda_org_channels_bioconda_packages_livekraken_overview.md)
- [LiveKraken Commit History and Flags](./references/gitlab_com_SimonHTausch_LiveKraken_-_commits_master.md)
- [LiveKraken Project Metadata](./references/gitlab_com_SimonHTausch_LiveKraken.md)