---
name: mirfix
description: MIRfix is a bioinformatics pipeline that curates microRNA datasets by refining precursor alignments and ensuring consistent mature sequence annotations. Use when user asks to curate miRNA datasets, improve miRNA precursor alignments, or refine mature miRNA annotations across families.
homepage: https://github.com/Bierinformatik/MIRfix
---

# mirfix

## Overview

MIRfix is a specialized bioinformatics pipeline designed to automatically curate microRNA (miRNA) datasets. It improves the quality of miRNA precursor alignments and ensures that the annotations for mature miR and miR* sequences are consistent across different families. By refining these datasets, MIRfix facilitates more accurate comparative genomics and quantitative analyses. This skill provides the necessary command-line patterns and parameter configurations to execute the pipeline effectively.

## Installation and Environment

The recommended way to run MIRfix is via a Conda environment to manage its dependencies (such as dialign2).

```bash
# Create and activate the environment
conda create -n mirfix mirfix
conda activate mirfix
```

## Command Line Usage

MIRfix can be executed either through a Bash wrapper script or by calling the Python script directly.

### Using the Bash Wrapper
The wrapper `runMIRfix.sh` simplifies the execution by handling directory paths and core allocation.

**Pattern:**
`bash runMIRfix.sh <LOCATION> <CORES> <EXTENSION>`

*   **LOCATION**: The working directory containing subdirectories for input, output, family sequences, genomes, and mapping files.
*   **CORES**: Number of CPU cores for parallel processing.
*   **EXTENSION**: Number of nucleotides to extend or trim the precursor from the genomic sequence.

### Direct Python Execution
For more granular control, use `MIRfix.py` directly.

**Pattern:**
`python MIRfix.py <cores> <outdir> <familydir> <family_list> <genomes> <mapfile> <matfile> <flank> [<matrices>]`

*   **cores**: Number of parallel processes.
*   **outdir**: Path to the output directory.
*   **familydir**: Directory containing FASTA files of the miRNA families.
*   **family_list**: A text file listing the specific families to analyze.
*   **genomes**: Path to the genome files used for flanking region extraction.
*   **mapfile**: File mapping individual miRNAs to their respective families.
*   **matfile**: FASTA file containing mature miRNA sequences.
*   **flank**: Number of flanking nucleotides to consider (standard value is 10).
*   **matrices**: (Optional) Directory for dialign2 matrices. This is typically handled automatically in Conda installations.

## Expert Tips and Best Practices

*   **Directory Structure**: When using the Bash wrapper, ensure your `LOCATION` directory is well-organized. The script expects to find family sequences, mapping files, and genome data within this path.
*   **Flanking Sequences**: A `flank` value of 10 is the standard used in the original MIRfix study for optimal precursor definition.
*   **Parallelization**: MIRfix supports multi-core processing. Always match the `<cores>` parameter to your available hardware to significantly reduce alignment time for large datasets.
*   **Testing**: Before running on a full dataset, use the provided test script:
    ```bash
    cd examples
    bash testMIRfix.sh
    ```
*   **Output Overwriting**: Recent versions include a force flag or check for existing output directories. Ensure the output path is clear or that you have permission to overwrite to avoid execution halts.



## Subcommands

| Command | Description |
|---------|-------------|
| MIRfix.py | MIRfix automatically curates miRNA datasets by improving alignments of their precursors, the consistency of the annotation of mature miR and miR* sequence, and the phylogenetic coverage. MIRfix produces alignments that are comparable across families and sets the stage for improved homology search as well as quantitative analyses. |
| mirfix_runMIRfix.sh | Running MIRfix with 1 cores, 10nt extension at --help |
| mirfix_testMIRfix.sh | Running MIRfix with 1 cores, 10nt extension |

## Reference documentation
- [MIRfix Repository Overview](./references/github_com_Bierinformatik_MIRfix.md)
- [MIRfix README and CLI Documentation](./references/github_com_Bierinformatik_MIRfix_blob_master_README.md)