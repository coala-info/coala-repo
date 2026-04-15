---
name: minute
description: The minute tool automates the processing of MINUTE-ChIP data from raw sequencing reads to normalized genomic tracks. Use when user asks to initialize a project, run the bioinformatics pipeline, demultiplex reads, or generate scaled bigWig files.
homepage: https://github.com/NBISweden/minute/
metadata:
  docker_image: "quay.io/biocontainers/minute:0.12.1--pyhdfd78af_1"
---

# minute

## Overview

The minute tool is a specialized bioinformatics pipeline designed to handle the unique requirements of MINUTE-ChIP data. It automates the transition from raw sequencing reads to normalized genomic tracks by performing demultiplexing, adapter trimming, alignment, and scaling. By leveraging Snakemake, it ensures reproducible results and allows users to skip specific steps (like scaling) or focus on pooled replicates through various target rules.

## Core CLI Commands

### Project Initialization
Use the `init` command to set up the required directory structure and template configuration files.
- Initialize a standard run: `minute init --input <path_to_fastqs> --barcodes <path_to_barcodes_csv>`
- Initialize using an existing configuration: `minute init --config <path_to_minute.yaml>`

### Executing the Workflow
Run the pipeline from within the initialized project directory.
- Execute the default workflow: `minute run`
- Execute with a specific number of cores (via Snakemake): `minute run --cores <number>`

## Workflow Target Rules

Select specific rules to modify the pipeline behavior based on analysis needs:

- **no_scaling**: Skips the scaling process entirely. Use this to generate unscaled bigWig files and a MultiQC report containing only non-scaling metrics.
- **quick**: Produces a minimal set of bigWig tracks. It generates scaled tracks for treatment samples and unscaled tracks for controls.
- **pooled_only**: Skips the generation of individual replicate tracks and only produces bigWig files for replicate pools.
- **pooled_only_minimal**: Generates scaled replicate pools for treatments and unscaled pools for controls.
- **mapq_bigwigs**: Generates additional bigWig files filtered by a specific mapping quality threshold (defined in the configuration).

## Expert Tips and Best Practices

- **Aligner Selection**: While Bowtie2 is the default, you can switch to `strobealign` in the configuration for significantly faster alignment speeds.
- **Quality Filtering**: Use the `mapping_quality` parameter to filter out low-confidence reads. By default, this is set to 0 (keeping all reads).
- **Handling Dropouts**: Check the `stats_summary.txt` file or the MultiQC report to identify barcode dropouts. The pipeline is designed to handle zero-value barcodes without failing the entire run.
- **Resource Management**: Since the workflow is Snakemake-based, you can pass standard Snakemake arguments through the `minute run` command to manage cluster execution or local resource limits.
- **Scaling Verification**: Review the "Scaling info" in the final MultiQC report to see the calculated scale factors applied to the summary bar plots.



## Subcommands

| Command | Description |
|---------|-------------|
| minute download | Downloads libraries from a TSV file. |
| minute init | Create and initialize a new pipeline directory |
| minute run | Run the Minute pipeline |

## Reference documentation
- [minute Changelog](./references/github_com_elsasserlab_minute_blob_main_CHANGES.md)
- [Minute README](./references/github_com_elsasserlab_minute_blob_main_README.md)
- [Environment Specification](./references/github_com_elsasserlab_minute_blob_main_environment.yml.md)