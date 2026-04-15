---
name: kmtricks
description: kmtricks is a bioinformatics suite designed to construct and compare k-mer matrices across large-scale sequencing datasets. Use when user asks to construct k-mer count matrices, build Bloom filters for multiple samples, or aggregate k-mer profiles from a file of files.
homepage: https://github.com/tlemane/kmtricks
metadata:
  docker_image: "quay.io/biocontainers/kmtricks:1.5.1--h22625ea_0"
---

# kmtricks

## Overview
kmtricks is a specialized bioinformatics suite designed to handle the complexity of comparing k-mer profiles across hundreds or thousands of sequencing samples. Unlike traditional k-mer counters that focus on single files, kmtricks excels at merging count information and constructing large-scale matrices. It is particularly useful for identifying shared k-mers between samples while filtering out noise, thanks to its "rescue" mechanism that keeps low-frequency k-mers if they are validated by presence in other samples.

## Core Workflow

### 1. Preparing Input (FOF)
kmtricks requires a "File of Files" (FOF) to map sample identifiers to their respective sequence files.
Format: `SampleName: path/to/reads.fq.gz`

Example `samples.fof`:
```text
Sample_A: data/reads_1.fastq.gz
Sample_B: data/reads_2.fastq.gz
```

### 2. Running the Pipeline
The `pipeline` command is the primary entry point for matrix construction.

**Constructing a Count Matrix:**
```bash
kmtricks pipeline --file samples.fof --run-dir ./output --mode kmer:count:bin --hard-min 1 --soft-min 3 --share-min 1 --cpr
```
*   `--mode kmer:count:bin`: Generates a k-mer abundance matrix in binary format.
*   `--hard-min`: Absolute minimum abundance to consider a k-mer during initial counting.
*   `--soft-min`: Threshold for "solid" k-mers.
*   `--share-min`: Rescue k-mers with abundance < `soft-min` if they are "solid" in at least N other samples.
*   `--cpr`: Enables compression of the output partitions.

**Constructing Bloom Filters:**
```bash
kmtricks pipeline --file samples.fof --run-dir ./bf_output --mode bloom:count:bin --k 31
```

### 3. Aggregating Results
After the pipeline completes, results are often stored in partitions. Use `aggregate` to create a single output file.

**Convert binary matrix to text:**
```bash
kmtricks aggregate --matrix kmer --format text --cpr-in --run-dir ./output > final_matrix.txt
```

## Expert Tips and Best Practices
*   **Disk Space:** kmtricks uses significant intermediate disk space (often 20% to 100% of input size). Ensure the `--run-dir` is located on a volume with sufficient quota.
*   **Single vs. Multi-sample:** Do not use kmtricks for simple k-mer counting of a single file; tools like KMC are faster for that specific task. Use kmtricks only when merging across multiple samples.
*   **Memory Management:** If the process is killed, it is likely due to RAM exhaustion. Check `kmtricks infos` to see the environment's capabilities and adjust thread counts if necessary.
*   **Rescue Logic:** To maximize sensitivity for rare variants shared across samples, set a low `--hard-min` (e.g., 1) and a higher `--soft-min` (e.g., 3-5) with `--share-min 1`.
*   **Debugging:** If a run fails, look for `kmtricks_backtrace.log`. Use the `kmtricks-debug` binary (available in conda) for more verbose error reporting.



## Subcommands

| Command | Description |
|---------|-------------|
| kmtricks | Display build and configuration information for kmtricks. |
| kmtricks aggregate | Aggregate partition files. |
| kmtricks combine | Combine kmtricks's matrices (support kmer/hash matrices). |
| kmtricks count | Count k-mers/hashes in partitions. |
| kmtricks dump | Dump kmtricks's files in human readable format. |
| kmtricks filter | Filter existing matrix with a new sample. |
| kmtricks pipeline | run all the steps, repart -> superk -> count -> merge |
| kmtricks superk | Compute super-k-mers. |
| kmtricks_merge | Merge partitions. |
| kmtricks_repart | Compute minimizer repartition. |

## Reference documentation
- [kmtricks GitHub Home](./references/github_com_tlemane_kmtricks.md)
- [Count Matrix Example](./references/github_com_tlemane_kmtricks_wiki_Count-matrix-example.md)
- [Input Data Specifications](./references/github_com_tlemane_kmtricks_wiki_Input-data.md)
- [Pipeline Module Details](./references/github_com_tlemane_kmtricks_wiki_kmtricks-pipeline.md)