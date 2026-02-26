---
name: riboseed
description: riboSeed is a bioinformatics pipeline that uses reference-guided sub-assemblies to resolve and assemble multiple identical ribosomal RNA operons in bacterial genomes. Use when user asks to assemble rDNA regions, bridge gaps in genomic assemblies, or improve the resolution of rRNA operons using short-read sequencing data.
homepage: https://github.com/nickp60/riboSeed
---


# riboseed

## Overview
riboSeed is a bioinformatics pipeline that addresses the challenge of assembling across multiple, identical ribosomal RNA (rRNA) operons in bacterial genomes. While the rDNA regions themselves are often indistinguishable to short-read sequencers, their flanking genomic regions are typically unique. riboSeed leverages a closely related reference genome to identify these regions and uses the unique flanking sequences to "seed" sub-assemblies, effectively bridging the gaps that standard de novo assemblers often fail to resolve.

## Core Workflow
The primary way to use riboSeed is through the `ribo run` command, which orchestrates the submodules: `scan`, `select`, `seed`, `sketch`, and `score`.

### Basic Usage
To run the full pipeline with paired-end reads:
```bash
ribo run -r reference.fasta -F forward_reads.fastq -R reverse_reads.fastq -o output_directory/
```

To run with single-end reads:
```bash
ribo run -r reference.fasta -S1 single_reads.fastq -o output_directory/
```

### Key Submodules
- **scan**: Annotates rRNAs in the reference genome.
- **select**: Identifies and clusters rDNA operons.
- **seed**: Performs iterative sub-assemblies to bridge the regions.
- **snag**: Extracts and visualizes rDNA regions for inspection.
- **score**: Provides automated scoring to evaluate the quality of the rDNA assembly.

## Expert Tips and Best Practices

### Memory Management
Genome assembly is resource-intensive. If running on a machine with limited RAM (e.g., 4GB or 8GB):
- Use the `--serialize` flag to run sub-assemblies in series rather than in parallel.
- Limit the number of threads using `--cores`.

### Reference Selection
The success of riboSeed depends heavily on the choice of reference.
- Use a reference genome that is as closely related to your isolate as possible.
- If unsure of the best reference, tools like `PlentyOfBugs` or ANI (Average Nucleotide Identity) comparisons are recommended to select the most appropriate candidate.

### Handling Different Kingdoms
By default, riboSeed looks for bacterial rDNA (`-K bac`). If working with other organisms, specify the kingdom:
- `-K euk` (Eukaryotic)
- `-K arc` (Archaeal)
- `-K mito` (Mitochondrial)

### Customizing rDNA Features
If your target organism has a non-standard operon structure (e.g., missing 5S), you can specify the features to target:
```bash
ribo run -r ref.fasta -F r1.fq -R r2.fq -S 16S:23S -o output/
```

### Troubleshooting and Validation
- **Check the Score**: Always review the output from `ribo score` to ensure the sub-assemblies are an improvement over the initial assembly.
- **Visualize**: Use `ribo sketch` or `ribo snag` to visually inspect how the reads are mapping across the rDNA regions.
- **Dependencies**: Ensure `barrnap` and `SPAdes` (the default assembler) are in your PATH, as riboSeed relies on them for annotation and assembly.

## Reference documentation
- [riboSeed Overview](./references/anaconda_org_channels_bioconda_packages_riboseed_overview.md)
- [riboSeed GitHub Repository](./references/github_com_nickp60_riboSeed.md)