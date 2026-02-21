---
name: galitime
description: The `galitime` skill enables precise performance monitoring of computational experiments.
homepage: https://github.com/karel-brinda/galitime
---

# galitime

## Overview
The `galitime` skill enables precise performance monitoring of computational experiments. It acts as a wrapper around the GNU Time command, ensuring that benchmarking data is collected consistently regardless of the underlying operating system. Use this tool when you need to generate reproducible performance logs for scientific workflows, comparing the resource efficiency of different algorithms or software versions.

## Installation
Galitime can be installed via Bioconda or PyPI:

```bash
# Using Bioconda
conda install -y -c bioconda -c conda-forge galitime

# Using PyPI
pip install galitime
```

## Core CLI Usage
The basic syntax requires a log path and the command to be benchmarked:

```bash
galitime --log <path_to_log> "<command_to_run>"
```

### Key Arguments
- `--log LOG`: Specifies the path to the log file. Galitime will automatically create the parent directory if it does not exist.
- `--experiment NAME`: Attaches a specific label to the benchmark entry. This is essential when appending multiple different tests to the same log file for later analysis.
- `command`: The actual software or script execution string you wish to measure.

### Example: Benchmarking a Bioinformatics Tool
```bash
galitime --log results/benchmarks.log --experiment "alignment_test_v1" "bwa mem ref.fa reads.fq > aln.sam"
```

## Understanding the Output
Galitime produces a log file with the following metrics:
- **real_s**: Wall clock time in seconds.
- **user_s / sys_s**: CPU time spent in user mode and kernel mode, respectively.
- **percent_cpu**: Total CPU usage percentage.
- **max_ram_kb**: Peak Resident Set Size (maximum RAM used) in kilobytes.
- **exit_code**: The return code of the benchmarked command (0 indicates success).
- **fs_inputs / fs_outputs**: Count of file system read and write operations.
- **command**: The exact command string executed.

## Best Practices and Tips
- **Quoting Commands**: Always wrap complex commands (especially those with pipes or redirects) in quotes to ensure `galitime` parses the entire string as the target process rather than interpreting the shell operators itself.
- **Aggregating Results**: Use the same `--log` file across multiple runs with different `--experiment` tags. This creates a single dataset ready for post-processing in R (tidyverse) or Python (pandas).
- **Platform Consistency**: On macOS, `galitime` handles the translation of time metrics automatically, so you do not need to manually install or alias `gtime` as was required in older versions.
- **Exit Code Monitoring**: Always check the `exit_code` column in your logs. A benchmark for a failed process (non-zero exit code) often reports misleadingly low resource usage.

## Reference documentation
- [galitime GitHub Repository](./references/github_com_karel-brinda_galitime.md)
- [Bioconda galitime Overview](./references/anaconda_org_channels_bioconda_packages_galitime_overview.md)