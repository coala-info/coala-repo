---
name: ssuissero
description: ssuissero automates the genomic characterization and serotyping of Streptococcus suis from Nanopore reads or assemblies. Use when user asks to assemble Streptococcus suis genomes, perform serotyping, or resolve highly similar serotypes like 2 versus 1/2.
homepage: https://github.com/jimmyliu1326/SsuisSero
metadata:
  docker_image: "quay.io/biocontainers/ssuissero:1.0.1--hdfd78af_1"
---

# ssuissero

## Overview
The ssuissero skill provides a streamlined workflow for the genomic characterization of *Streptococcus suis*. The underlying pipeline automates several complex bioinformatics steps: it assembles draft genomes using Flye, polishes them with Racon and Medaka, and queries the resulting assembly against the Cps Blast Database. A key feature of this tool is its ability to resolve highly similar serotypes—specifically 2 vs. 1/2 and 1 vs. 14—by employing a targeted variant calling step. Use this skill to move from raw Nanopore reads to a definitive serotype report with minimal manual intervention.

## Command Line Usage

The primary executable is `SsuisSero.sh`.

### Required Arguments
- `-i`: Path to the input file (Nanopore reads).
- `-o`: Path to the output directory where results will be stored.
- `-s`: Sample name (used for naming output files).
- `-x`: Input file format. Must be either `fasta` or `fastq`.

### Optional Arguments
- `-t`: Number of threads to use for computation (Default: 4). Increasing this is recommended for the Medaka and Flye stages if hardware allows.
- `-h`: Display the help message.

### Common Patterns
To run a standard serotyping analysis on a FASTQ file with optimized threading:
```bash
SsuisSero.sh -s MySample_01 -i /path/to/data.fastq -o ./output_dir -x fastq -t 8
```

To process a pre-assembled FASTA file:
```bash
SsuisSero.sh -s MySample_01 -i /path/to/assembly.fasta -o ./output_dir -x fasta
```

## Best Practices and Expert Tips

- **Input Quality**: While the pipeline includes polishing steps (Racon/Medaka), starting with high-quality Nanopore reads will significantly improve the reliability of the Flye assembly and subsequent serotype hits.
- **Serotype Resolution**: If your research specifically targets serotypes 2, 1/2, 1, or 14, ensure you provide the raw reads (FASTQ) rather than just an assembly if possible, as the variant calling step is optimized for these specific distinctions.
- **Resource Allocation**: The Medaka polishing step is computationally intensive. When running on a server, always specify the `-t` flag to match your allocated CPU cores to prevent bottlenecks.
- **Output Interpretation**: The pipeline queries the Cps (Capsular polysaccharide) database. If a sample returns "Nontypeable," it may indicate a novel serotype or insufficient coverage in the capsular locus region.

## Reference documentation
- [SsuisSero GitHub Repository](./references/github_com_jimmyliu1326_SsuisSero.md)
- [Bioconda ssuissero Package Overview](./references/anaconda_org_channels_bioconda_packages_ssuissero_overview.md)