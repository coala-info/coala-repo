---
name: marker-magu
description: Marker-MAGu is a trans-kingdom marker gene pipeline optimized for human-derived metagenomic samples.
homepage: https://github.com/cmmr/Marker-MAGu
---

# marker-magu

## Overview
Marker-MAGu is a trans-kingdom marker gene pipeline optimized for human-derived metagenomic samples. It leverages the MetaPhlAn4 strategy and database but significantly expands its capabilities by adding tens of thousands of phage markers. This allows researchers to quantify phages, bacteria, and archaea with balanced sensitivity and specificity. Use this skill to guide the execution of the pipeline, manage database environments, and adjust detection thresholds for specific research needs.

## Environment Setup
Marker-MAGu requires specific environment variables to locate its databases. Ensure these are set before execution:

- **MARKERMAGU_DB**: Path to the marker gene database directory (e.g., `v1.1`).
- **MARKERMAGU_FILTER**: Path to the directory containing `filter_seqs.fna` (used for host/spike-in removal).

If using Conda, you can persist these variables:
```bash
conda env config vars set MARKERMAGU_DB=/path/to/DBs/v1.1
conda env config vars set MARKERMAGU_FILTER=/path/to/filter_seqs
```

## Common CLI Patterns

### Basic Taxonomic Profiling
Run a standard analysis on a single FASTQ file:
```bash
markermagu -r reads.fastq -s SampleID -o output_dir
```

### Processing Multiple Files
Marker-MAGu does not use paired-end information explicitly but can process multiple files (or wildcards) as a single sample:
```bash
markermagu -r R1.fastq R2.fastq -s SampleID -o output_dir
# OR
markermagu -r /path/to/reads/*.fastq -s SampleID -o output_dir
```

### Quality and Host Filtering
To enable integrated quality control (via fastp) and host/spike-in removal (via minimap2), use the `-q` and `-f` flags:
```bash
markermagu -r reads.fastq -s SampleID -o output_dir -q True -f True
```
*Note: Host filtering requires a pre-formatted `filter_seqs.fna` file in the directory pointed to by `MARKERMAGU_FILTER`.*

### Adjusting Detection Sensitivity
The `--detection` parameter significantly impacts results:
- **default**: Requires 75% of marker genes for detection. Higher specificity, lower sensitivity.
- **relaxed**: Requires 33% of marker genes for detection. This setting makes bacterial/archaeal abundance highly similar to MetaPhlAn4 default output.

```bash
markermagu -r reads.fastq -s SampleID -o output_dir --detection relaxed
```

## Expert Tips and Best Practices
- **OS Constraints**: The Conda installation is Linux-only. For macOS or Windows, use the Docker/Singularity container (`quay.io/biocontainers/marker-magu`).
- **Resource Allocation**: The tool defaults to 48 CPUs. Always adjust the `-t` parameter to match your environment's available cores to avoid resource contention.
- **Database Integrity**: When setting up the database, verify the v1.1 tarball with `md5sum` (expected: `e0947cb1d4a3df09829e98627021e0dd`) before decompression.
- **Output Management**: The output directory can be shared across multiple samples; the tool uses the `-s` (sample name) argument to prevent file collisions.

## Reference documentation
- [Marker-MAGu GitHub Repository](./references/github_com_cmmr_Marker-MAGu.md)
- [Marker-MAGu Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_marker-magu_overview.md)