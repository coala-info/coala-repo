---
name: pb-falcon-phase
description: pb-falcon-phase phases diploid genome assemblies by using Hi-C data to assign haplotigs to their corresponding primary contigs. Use when user asks to improve diploid assemblies, phase maternal and paternal haplotypes, or unzip genomic sequences using Hi-C read pairs.
homepage: https://github.com/PacificBiosciences/pb-falcon-phase
---


# pb-falcon-phase

## Overview
The `pb-falcon-phase` tool provides a computational pipeline to improve diploid genome assemblies. By using Hi-C read pairs as a physical map, it assigns haplotigs (secondary contigs) to their respective primary contigs, effectively "unzipping" the assembly into phased maternal and paternal haplotypes. This process is critical for creating high-quality, diploid-aware assemblies where traditional long-read assembly alone might result in chimeric or collapsed sequences.

## Pre-processing and Header Cleaning
Before running the phasing pipeline, you must standardize the FASTA headers of your FALCON-Unzip assembly. The pipeline expects a specific format and a mapping file between primary contigs and haplotigs.

1. **Clean Headers**: Use the provided Perl script to remove "|arrow" suffixes and other metadata that interfere with mapping.
   ```bash
   scrub_names.pl p-contigs.fa h-contigs.fa > name_mapping.txt
   ```
   This command generates `.cleaned` versions of your FASTA files and creates the `name_mapping.txt` file required for the downstream Snakemake DAG.

2. **Verify Mapping**: Ensure `name_mapping.txt` correctly associates each haplotig with its primary contig (e.g., `000000F 000000F_002`).

## Pipeline Execution
The tool is primarily orchestrated via Snakemake. Ensure your environment has BWA, Mummer 4, BEDTools, and SAMtools available in the PATH.

1. **Configuration**: The pipeline requires a `config.json` file defining paths to binaries and input data. Key parameters include:
   - `output_format`: Choose "unzip" or "pseudohap".
   - `min_aln_len`: Minimum alignment length (default 3000).
   - `iter`: Number of MCMC iterations (10^7 recommended for production).
   - `enzyme`: The restriction enzyme used for Hi-C (e.g., GATC).

2. **Run the Pipeline**:
   Execute the workflow from the pipeline directory:
   ```bash
   snakemake -s snakefile --verbose -p
   ```

## Best Practices and Constraints
- **Heterozygosity Limits**: The tool is optimized for organisms with < 5% divergence. If heterozygosity is too high, determining homology between haplotypes becomes unreliable.
- **Assembly Quality**: If the total length of your haplotigs is significantly smaller than your primary contigs, the utility of `pb-falcon-phase` will be limited as there is little "unzipped" content to phase.
- **Hi-C Coverage**: Aim for at least 100 million read pairs per 1 Gb of genome length for robust phasing.
- **Binary Paths**: When configuring the pipeline, use `which <tool>` (e.g., `which bwa`) to get absolute paths for the `config.json` to avoid environment resolution errors during cluster execution.

## Reference documentation
- [github_com_PacificBiosciences_pb-falcon-phase.md](./references/github_com_PacificBiosciences_pb-falcon-phase.md)
- [anaconda_org_channels_bioconda_packages_pb-falcon-phase_overview.md](./references/anaconda_org_channels_bioconda_packages_pb-falcon-phase_overview.md)