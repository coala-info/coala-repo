---
name: aquamis
description: AQUAMIS (Assembly-based QUality Assessment for Microbial Isolate Sequencing) is a robust Snakemake-based pipeline designed for the routine processing of microbial isolate sequencing experiments.
homepage: https://gitlab.com/bfr_bioinformatics/AQUAMIS
---

# aquamis

## Overview
AQUAMIS (Assembly-based QUality Assessment for Microbial Isolate Sequencing) is a robust Snakemake-based pipeline designed for the routine processing of microbial isolate sequencing experiments. It streamlines the workflow from raw reads to high-quality assemblies, providing a centralized environment for quality assessment. It is particularly useful in public health or clinical microbiology settings where standardized, reproducible results and comprehensive QC reports are required for large batches of samples.

## Installation and Setup
Install the pipeline via Bioconda:
```bash
conda install bioconda::aquamis
```

Before running the pipeline for the first time, use the setup script to manage dependencies and databases:
```bash
aquamis_setup.sh
```

## Core Usage Patterns

### Primary Execution
The main entry point for the pipeline is `aquamis.py`. It typically requires a sample sheet and a defined working directory.

```bash
aquamis.py --sample_sheet samples.csv --workdir ./results
```

### Common CLI Flags
- `--no_assembly`: Run the pipeline without performing new assemblies (useful for re-running QC on existing assemblies).
- `--fix_fails`: Attempt to re-run only the samples that failed in a previous execution.
- `--version`: Check the current version of the AQUAMIS installation.
- `--help`: Display all available parameters, including Shovill and Snakemake-specific options.

### Working with Results
AQUAMIS generates several key output files in the specified working directory:
- `Assembly/[SampleID]/`: Contains the Shovill assembly results.
- `post_assembly/[SampleID].aquamis.json`: A comprehensive JSON file aggregating all QC metrics for a sample.
- `report.tsv`: A summary table of the run.
- `pipeline_status.txt`: A log file indicating the success or failure of specific pipeline steps.

## Expert Tips and Best Practices
- **Sample Sheet Management**: Ensure your sample sheet does not use "NA" as a string if working in single-end mode, as some versions may interpret this as a null value.
- **Database Integrity**: If Mash or Kraken2 steps fail, verify the database paths. AQUAMIS relies on `mash_best.dist` located within the `mash` subfolder of the assembly directory to validate taxonomic hits.
- **Memory Allocation**: For large batches, monitor Java heap space (Xmx) settings, especially during the assembly and QC phases, as these are the most resource-intensive.
- **GFF Formatting**: When using custom reference genomes, ensure GFF files are properly formatted with 9 columns. AQUAMIS includes internal fixes for malformatted NCBI GFFs (removing stray "--" lines), but manual verification prevents `KeyError: '# genomic features'` during the reporting phase.
- **Contamination Checks**: Pay close attention to the ConFindr results integrated into the final report to identify potential cross-contamination or mixed cultures before proceeding with downstream analysis.

## Reference documentation
- [AQUAMIS Overview](./references/anaconda_org_channels_bioconda_packages_aquamis_overview.md)
- [AQUAMIS GitLab Repository](./references/gitlab_com_bfr_bioinformatics_AQUAMIS.md)
- [AQUAMIS Tags and Releases](./references/gitlab_com_bfr_bioinformatics_AQUAMIS_-_tags.md)