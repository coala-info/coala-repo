---
name: cagecleaner
description: This tool removes genomic redundancy from cblaster hit sets. Use when user asks to filter redundant gene clusters from cblaster results.
homepage: https://github.com/LucoDevro/CAGEcleaner
---


# cagecleaner

A tool to remove genomic redundancy from cblaster hit sets. Use when you have a cblaster session file and need to filter out redundant gene clusters to simplify downstream analysis, visualization, or comparative genomics. This tool helps in identifying representative genomes and retaining diverse gene clusters associated with non-representative genomes.
---
## Overview

CAGEcleaner is a bioinformatics tool designed to reduce redundancy in genomic datasets, specifically for gene cluster mining results obtained from tools like cblaster. It addresses the issue of redundant entries in large target databases that propagate into analysis results, making them difficult to interpret. CAGEcleaner achieves this by dereplicating gene clusters at the genome level, identifying representative assemblies, and optionally retaining gene clusters from non-representative genomes that show divergence. This process streamlines downstream analyses such as visualization and comparative genomics.

## Usage Instructions

CAGEcleaner operates via the command line and requires a cblaster session file as input. It leverages other tools like skDER for genome dereplication.

### Core Functionality

The primary function of CAGEcleaner is to process a cblaster session file and output a filtered session file with reduced redundancy.

### Command-line Usage

The general command structure is as follows:

```bash
cagecleaner --input <input_cblaster_session_file> --output <output_filtered_session_file> [options]
```

### Key Options and Parameters

*   `--input` or `-i`: Path to the input cblaster session file (required).
*   `--output` or `-o`: Path for the output filtered cblaster session file (required).
*   `--mode` or `-m`: Specifies the dereplication mode.
    *   `full_genome`: Dereplicates based on the entire genome assembly. This is the default mode.
    *   `region`: Dereplicates based on a defined genomic region around the gene cluster. This mode requires additional parameters to define the region.
*   `--region_size` or `-rs`: (Required when `--mode region` is used) Defines the size of the genomic region (in base pairs) to extract around each gene cluster for dereplication.
*   `--keep_divergent` or `-kd`: If set, CAGEcleaner will retain hits that are divergent at the gene cluster level but associated with non-representative genomes.
*   `--verbose` or `-v`: Enables verbose output, providing more detailed information during the process.
*   `--threads` or `-t`: Number of threads to use for parallel processing.

### Example Workflows

**1. Basic Redundancy Removal (Full Genome Mode):**

To remove redundancy from a cblaster session file named `cblaster_hits.tsv` and save the filtered results to `filtered_hits.tsv`:

```bash
cagecleaner -i cblaster_hits.tsv -o filtered_hits.tsv
```

**2. Region-based Dereplication:**

To perform dereplication on a 5000 bp region around each gene cluster and keep divergent hits:

```bash
cagecleaner -i cblaster_hits.tsv -o filtered_region_hits.tsv --mode region --region_size 5000 --keep_divergent
```

**3. Using Multiple Threads:**

To speed up processing using 8 threads:

```bash
cagecleaner -i cblaster_hits.tsv -o filtered_hits.tsv -t 8
```

### Important Considerations

*   **Input Format**: CAGEcleaner expects input in the cblaster binary table format.
*   **Dependencies**: CAGEcleaner relies on external tools like `skDER` for genome dereplication. Ensure these are installed and accessible in your environment.
*   **Windows Support**: Native Windows support is not recommended for versions beyond 1.1.0 due to known bugs. Alternative methods for running on Windows may be necessary.
*   **Genome Quality**: The effectiveness of dereplication can be influenced by the quality of the input genome assemblies. Low-quality assemblies might lead to less efficient filtering.

## Reference documentation

- [CAGEcleaner Overview](https://github.com/LucoDevro/CAGEcleaner/wiki)
- [CAGEcleaner GitHub Repository](https://github.com/LucoDevro/CAGEcleaner)