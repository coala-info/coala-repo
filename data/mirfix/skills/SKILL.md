---
name: mirfix
description: MIRfix is an automated curation pipeline that refines microRNA datasets by improving precursor structural alignments and standardizing mature sequence annotations. Use when user asks to refine miRNA datasets, improve structural alignments of miRNA precursors, or standardize mature and star sequence annotations across families.
homepage: https://github.com/Bierinformatik/MIRfix
---


# mirfix

## Overview
MIRfix is an automated curation pipeline designed to refine microRNA (miRNA) datasets. It specializes in improving the structural alignments of miRNA precursors and ensuring that the annotation of mature (miR) and star (miR*) sequences is consistent across different families. By standardizing these datasets, MIRfix facilitates more accurate homology searches and comparative studies across diverse species.

## Installation and Setup
The most reliable way to use MIRfix is via the Bioconda package, which handles all necessary dependencies.

```bash
# Create and activate a dedicated environment
conda create -n mirfix mirfix
conda activate mirfix
```

## Command Line Usage

### Using the Bash Wrapper
The `runMIRfix.sh` script is the recommended entry point for most users as it simplifies parameter handling.

```bash
bash runMIRfix.sh <LOCATION> <CORES> <EXTENSION>
```

*   **LOCATION**: The path to the working directory. This directory must contain your input files (family sequences, mapping files, genomes, etc.).
*   **CORES**: Number of CPU cores for parallel processing.
*   **EXTENSION**: Number of nucleotides to extend or trim the precursor from the genomic sequence.

### Direct Python Execution
For advanced workflows or specific integration needs, you can call the Python script directly. Note that parameters are positional.

```bash
python MIRfix.py <cores> <outdir> <familydir> <family_list> <genomes> <mapfile> <matfile> <flank> [matrices_dir]
```

### Parameter Details
*   **familydir**: Directory containing FASTA files of the miRNA families to be analyzed.
*   **family_list**: A text file listing the specific families to process.
*   **genomes**: Paths to the genomic FASTA files used for extracting flanking regions.
*   **mapfile**: A mapping file correlating specific miRNAs to their respective miR-families.
*   **matfile**: FASTA file containing mature miRNA sequences.
*   **flank**: Number of precursor flanking nucleotides to consider (standard practice is 10nt).
*   **matrices_dir**: (Optional) Path to Dialign2 matrices. If using the Conda installation, this is typically handled automatically.

## Best Practices and Expert Tips
*   **Directory Structure**: When using the bash wrapper, ensure your `<LOCATION>` directory is well-organized. The script expects to find input, output, and reference files within this path.
*   **Flanking Regions**: A flank value of 10 is the standard used in the original MIRfix study for optimal precursor extraction.
*   **Parallelization**: MIRfix supports multi-core processing. Always match the `<CORES>` parameter to your available hardware to significantly reduce runtime on large datasets.
*   **Output Overwriting**: If you need to re-run an analysis, ensure the output directory is clear or use the `-force` flag if available in your specific version to overwrite existing results.
*   **Testing**: Before running a full dataset, use the provided test script in the repository to verify the environment:
    ```bash
    cd examples
    bash testMIRfix.sh
    ```

## Reference documentation
- [The MIRfix pipeline](./references/github_com_Bierinformatik_MIRfix.md)
- [MIRfix - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mirfix_overview.md)