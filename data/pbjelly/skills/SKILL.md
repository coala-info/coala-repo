---
name: pbjelly
description: PBJelly is a specialized pipeline designed to improve genome assemblies by filling "N" gaps with long-read data.
homepage: https://github.com/esrice/PBJelly
---

# pbjelly

## Overview
PBJelly is a specialized pipeline designed to improve genome assemblies by filling "N" gaps with long-read data. It automates the process of mapping reads to gap regions, extracting supporting sequences, performing local de novo assemblies for each gap, and integrating the new sequences into the final scaffold. This specific version is a fork optimized for compatibility with modern environments (Python 2.7, blasr 5.3.2, and networkx 2.2).

## Core Workflow
The pipeline must be executed sequentially. Each stage depends on the successful completion of the previous one.

1.  **setup**: Identifies gaps in the reference and prepares the directory structure.
    `Jelly.py setup Protocol.xml`
2.  **mapping**: Aligns long reads to the reference using `blasr`.
    `Jelly.py mapping Protocol.xml`
3.  **support**: Analyzes alignments to identify reads that span or anchor into gaps.
    `Jelly.py support Protocol.xml`
4.  **extraction**: Groups reads by the specific gap they support.
    `Jelly.py extraction Protocol.xml`
5.  **assembly**: Performs local assembly for each gap region.
    `Jelly.py assembly Protocol.xml`
6.  **output**: Generates the final upgraded fasta file.
    `Jelly.py output Protocol.xml`

## CLI Patterns and Tips

### Passing Stage-Specific Parameters
Use the `-x` flag to pass additional arguments directly to the underlying modules. Ensure parameters are enclosed in double quotes.
*   **Example (Support stage)**: To ignore inter-scaffold gaps and require high mapping quality:
    `Jelly.py support Protocol.xml -x "--capturedOnly --minMapqv=250"`

### Data Preparation Requirements
*   **File Extensions**: Input reads must be in `.fasta` or `.fastq` format. The reference must be `.fasta`.
*   **Quality Files**: Every `.fasta` file (reference or reads) requires a matching `.qual` file in the same directory.
*   **Qual Format**: Use Phred scores (0-93) as raw numbers, not encoded characters. If missing, use the provided utility:
    `fakeQuals.py <your_file.fasta>`
*   **Naming**: Sequence names in files cannot contain spaces.

### Protocol.xml Configuration
The `Protocol.xml` is the central configuration file. Key elements include:
*   `<reference>`: Full path to the reference genome.
*   `<outputDir>`: Path for intermediate and final results.
*   `<inputs>`: Contains the `baseDir` attribute and `<input>` tags for each read file.
*   `<blasr>`: Parameters for the mapper (e.g., `-minMatch 8 -minPctIdentity 70`).

### Performance Optimization
*   **Parallelization**: PBJelly submits one job per input sequence file during the mapping and support stages. To increase speed, split large read files into multiple smaller files before starting the pipeline.
*   **Cluster Integration**: If using a job scheduler (like MOAB/LSF), define the `<cluster>` tag in the protocol to allow PBJelly to manage job submissions automatically.

## Troubleshooting
*   **Environment**: Ensure `blasr` is in the system PATH and the environment is set to Python 2.7.
*   **Setup Script**: Always source the `setup.sh` file (after editing `$SWEETPATH`) to ensure the `pbsuite` modules are correctly imported.
*   **Resuming**: If a stage fails, you can usually re-run that specific stage after fixing the underlying issue (e.g., path errors in the XML) without restarting the entire pipeline.

## Reference documentation
- [PBJelly Main Documentation](./references/github_com_esrice_PBJelly.md)