---
name: hydra-multi
description: Hydra-multi detects structural variants by integrating paired-end read signals across multiple genomic samples. Use when user asks to identify structural variant breakpoints, run the automated hydra-multi pipeline, or manually extract and cluster discordant alignments.
homepage: https://github.com/arq5x/Hydra
metadata:
  docker_image: "quay.io/biocontainers/hydra-multi:0.5.4--py27h5ca1c30_4"
---

# hydra-multi

## Overview
Hydra-multi is a specialized bioinformatics tool designed to detect structural variants by integrating signals from paired-end reads across hundreds of genomic samples. It is particularly effective at identifying breakpoints in both unique and repetitive/duplicated regions of the genome. Use this skill to navigate the multi-step pipeline required to transform raw alignments into finalized SV calls, whether using the automated wrapper or manual execution for fine-grained control.

## Environment Setup
Before running Hydra-multi, ensure the system environment is configured to handle a large number of simultaneous file operations.
- **System Limits**: Set `ulimit -f 16384`. This is required because the tool opens multiple file handles for chromosome-chromosome combinations.
- **Dependencies**: Ensure `samtools` and `pysam` are installed and available in the PATH.

## Core Workflows

### 1. Automated Execution
The simplest way to run the pipeline is using the `hydra-multi.sh` wrapper.

**Initialization**: Create a "stub" file (e.g., `config.stub.txt`) listing sample names and absolute paths to their respective BAM files:
```bash
sample1 /path/to/sample1.pos.bam
sample2 /path/to/sample2.pos.bam
```

**Execution**:
```bash
./hydra-multi.sh run -t <threads> -p <punt_parameter> -o <output_prefix> config.stub.txt
```
- `-t`: Number of threads (Default: 2).
- `-p`: Punt parameter (max read depth allowed for assembly; Default: 10).

### 2. Manual Step-by-Step Pipeline
Manual execution is preferred for troubleshooting or when specific steps need custom parameters.

1.  **Generate Configuration**:
    ```bash
    python scripts/make_hydra_config.py -i config.stub.txt > config.hydra.txt
    ```
2.  **Extract Discordant Alignments**:
    Run for each sample listed in the config:
    ```bash
    python scripts/extract_discordants.py -c config.hydra.txt -d <sample_name>
    ```
3.  **Route Alignments**:
    Groups alignments by chromosome/orientation:
    ```bash
    hydra-router -config config.hydra.txt -routedList routed-files.txt
    ```
4.  **Assemble Clusters**:
    ```bash
    sh scripts/assemble-routed-files.sh routed-files.txt config.hydra.txt <threads>
    ```
5.  **Merge and Finalize**:
    Combine the individual assembly files and run the final prediction scripts:
    ```bash
    sh scripts/combine-assembled-files.sh /path/to/assembled/files/ all.assembled
    python scripts/forceOneClusterPerPairMem.py -i all.assembled -o all.sv-calls
    ```

## Expert Tips & Best Practices
- **BAM Requirements**: Input BAM files should contain "positional" or discordant reads. The tool relies on paired-end mapping distance and orientation anomalies.
- **Memory Management**: The `forceOneClusterPerPairMem.py` script is memory-intensive. Ensure the execution environment has sufficient RAM for the number of assembled clusters.
- **Breakpoint Refinement**: After generating the frequency file (`.freq`), use `scripts/hydraToBreakpoint` to convert footprint intervals into precise breakpoint intervals for downstream analysis.
- **Punt Parameter**: If you are working with high-coverage data or regions with high mapping ambiguity, increase the `-p` (punt) parameter to avoid losing valid signals, though this will increase computation time.

## Reference documentation
- [Hydra GitHub Repository](./references/github_com_arq5x_Hydra.md)
- [Bioconda Hydra-multi Overview](./references/anaconda_org_channels_bioconda_packages_hydra-multi_overview.md)