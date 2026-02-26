---
name: nextdenovo
description: NextDenovo is a specialized assembler designed to perform de novo assembly of long-read sequencing data using a correct-then-assemble strategy. Use when user asks to assemble long-read sequences, perform de novo genome assembly, or generate high-quality contigs from PacBio and Oxford Nanopore data.
homepage: https://github.com/Nextomics/NextDenovo
---


# nextdenovo

## Overview
NextDenovo is a specialized assembler designed to handle the high error rates of long-read sequencing data through a "correct-then-assemble" strategy. While it functions similarly to assemblers like Canu, it is optimized for significantly lower computational overhead and storage requirements. For PacBio HiFi reads, it can bypass the correction phase entirely. The tool produces high-quality contigs with per-base accuracy typically ranging from 98% to 99.8%, which can be further refined using polishing tools like NextPolish.

## Installation and Setup
NextDenovo can be installed via Bioconda or by downloading the pre-compiled binaries.

**Conda installation:**
```bash
conda install bioconda::nextdenovo
```

**Manual installation:**
```bash
wget https://github.com/Nextomics/NextDenovo/releases/latest/download/NextDenovo.tgz
tar -vxzf NextDenovo.tgz
cd NextDenovo
```

## Core Workflow
The primary interface for NextDenovo is a configuration file (typically named `run.cfg`) that defines the input data, resource allocation, and assembly parameters.

1.  **Prepare Input:** Create a file containing the full paths to your fasta/fastq files (one per line). This is often referred to as a `fofn` (file of filenames).
2.  **Configure:** Edit the `run.cfg` file to point to your input list and set parameters for the `raw_align` and `assemble` steps.
3.  **Execute:** Run the assembler using the config file:
    ```bash
    nextDenovo run.cfg
    ```

## Configuration Best Practices
The `run.cfg` file is divided into sections. Key parameters to tune include:

### [General] Section
- `job_type`: Set to `local` for a single machine or `sge/pbs` for clusters.
- `parallel_jobs`: Number of tasks to run simultaneously.
- `submit`: The command used to submit jobs (e.g., `sh` for local).

### [Correct_Option] Section
- `read_type`: Specify `clr`, `ont`, or `hifi`.
- `seed_depth`: Controls the depth of long reads used for correction. Setting this appropriately (e.g., 30-45x) prevents excessive computation on redundant data.
- **Note:** For HiFi reads, the correction step is generally skipped as the reads are already high-accuracy.

### [Assemble_Option] Section
- `minimap2_options_raw`: Tuning parameters for initial overlaps.
- `nextgraph_options`: Use `-a 1` or `-a 3` if you require a GFA (Graphical Fragment Assembly) output for graph visualization.

## Expert Tips and Troubleshooting
- **Resource Management:** NextDenovo is designed to be memory efficient, but for large human-sized genomes, ensure you have sufficient disk space for the `01.raw_align` and `02.ctg_graph` directories, which store intermediate alignment data.
- **Stuck Jobs:** If the assembly appears stuck in the `raw_align` phase, check the task logs in the working directory. This is often caused by a mismatch between the `parallel_jobs` setting and available system threads.
- **Improving Contiguity:** If the N50 is lower than expected, consider lowering the `min_read_len` in the assembly options to include more reads, or adjusting the `seed_depth` to ensure better coverage during the correction phase.
- **Output Files:** The final assembly is typically found in the `03.ctg_align` directory as `nd.asm.fasta`. Always check `nd.asm.fasta.stat` for a summary of the assembly metrics (N50, total length, contig count).

## Reference documentation
- [NextDenovo GitHub Repository](./references/github_com_Nextomics_NextDenovo.md)
- [Bioconda NextDenovo Overview](./references/anaconda_org_channels_bioconda_packages_nextdenovo_overview.md)
- [NextDenovo Issues and Troubleshooting](./references/github_com_Nextomics_NextDenovo_issues.md)