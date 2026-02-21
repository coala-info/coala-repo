---
name: tksm
description: `tksm` (Taksim) is a modular toolkit designed to simulate the complexities of long-read RNA sequencing.
homepage: https://github.com/vpc-ccg/tksm
---

# tksm

## Overview

`tksm` (Taksim) is a modular toolkit designed to simulate the complexities of long-read RNA sequencing. Instead of a single monolithic process, `tksm` breaks the sequencing workflow into discrete, pipeable modules. These modules communicate using the Molecule Description Format (MDF), allowing you to chain biological processes (transcription, polyA tailing) and technical artifacts (truncation, PCR errors, sequencing noise) into a custom pipeline. It is particularly useful for benchmarking isoform detection, single-cell transcriptomics, and error-correction tools.

## Core CLI Usage and Best Practices

### The Piping Philosophy
The primary way to use `tksm` is by piping modules together using standard Unix pipes. This avoids large intermediate files and allows for streaming data processing.

**Basic Pattern:**
```bash
tksm [entry_module] [args] | tksm [core_module] [args] | tksm [exit_module] [args] > output.fasta
```

### Module Categories

1.  **Entry-Point Modules**: Start the simulation.
    *   `Tsb` (Transcriber): Generates molecules from a GTF and expression data.
    *   `Mrg` (Merge): Combines multiple MDF streams.
2.  **Core Modules**: Modify molecules in the MDF stream.
    *   `plA`: Adds polyA tails (e.g., `--normal=15,7.5`).
    *   `Trc`: Simulates molecule truncation.
    *   `Tag`: Adds specific sequences to 5' or 3' ends (useful for adapters).
    *   `PCR`: Simulates PCR amplification cycles.
    *   `SCB`: Adds cell barcodes.
    *   `Flp`: Flips molecule strand probability.
3.  **Exit Modules**: Convert MDF to final sequences.
    *   `Seq`: Uses models (like Badread) to generate reads with errors.

### Common CLI Patterns

*   **Simulating Bulk RNA-seq**:
    Chain transcription, truncation, polyA tailing, and sequencing.
    ```bash
    tksm Tsb --molecule-count 1000000 -g genes.gtf -e abundance.tsv | tksm Trc | tksm plA | tksm Seq -m model_path > reads.fq
    ```

*   **Simulating Single-Cell Barcodes**:
    Use the `Tag` and `SCB` modules to simulate 10x-style or custom barcoding.
    ```bash
    tksm Tsb ... | tksm Tag --format3 [BARCODE_PATTERN] | tksm SCB | tksm Seq ...
    ```

*   **Applying PCR Amplification**:
    Simulate the expansion of the molecule pool.
    ```bash
    tksm ... | tksm PCR --cycles 5 --molecule-count 5000000 | tksm Seq ...
    ```

### Expert Tips

*   **MDF Format**: Remember that `tksm` modules output and expect MDF by default. Only the `Seq` module produces standard FASTA/Q.
*   **Parameter Tuning**:
    *   Use `Flp -p 0.5` to simulate non-strand-specific libraries.
    *   Use `Tag --format5 [SEQ]` to simulate 5' adapters or TSO (Template Switching Oligos).
*   **Performance**: Since `tksm` is modular and uses pipes, you can utilize multi-threading at the OS level by running these pipes; however, ensure your `Seq` module parameters (like `--skip-qual-compute`) are set if you need to prioritize speed over quality score accuracy.
*   **Model Dependencies**: Modules like `Tsb` and `Seq` often require pre-built models (Expression models or Sequencing error models). Ensure these are generated using the utility modules (`Exprs`, `Badread`, `KDE`) before running the main pipeline.

## Reference documentation
- [tksm GitHub Repository](./references/github_com_vpc-ccg_tksm.md)
- [tksm Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tksm_overview.md)