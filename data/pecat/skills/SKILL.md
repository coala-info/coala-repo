---
name: pecat
description: PECAT is a bioinformatics pipeline designed for the error correction and diploid assembly of long-read sequencing data. Use when user asks to assemble diploid genomes, perform haplotype-aware error correction, or generate primary and alternate contigs from long reads.
homepage: https://github.com/lemene/PECAT
---


# pecat

## Overview
PECAT is a specialized bioinformatics pipeline designed for the assembly of diploid genomes using long-read sequencing technologies. It excels at distinguishing between haplotypes during the error correction and assembly phases, making it particularly effective for heterozygous samples. Use this skill to guide the configuration and execution of the PECAT workflow, from initial read correction to final polishing.

## Core Workflow
The PECAT pipeline is driven by a central configuration file and the `pecat.pl` wrapper script.

### 1. Initialization
Generate a template configuration file to define your project parameters.
```bash
pecat.pl config cfgfile
```

### 2. Configuration Essentials
Edit the generated `cfgfile`. At minimum, you must define:
- `project`: Name of the output directory.
- `reads`: Path to input FASTA/FASTQ files (supports `.gz`).
- `genome_size`: Estimated size of the genome (e.g., `3000000000` for human).
- `technology`: Sequencing platform (e.g., `ont` or `clr`).

### 3. Execution
Run the full "unzip" assembly pipeline, which performs correction, trimming, and diploid assembly.
```bash
pecat.pl unzip cfgfile
```

## Expert Tips and Best Practices

### Managing Disk Space
PECAT generates significant intermediate data. To prevent storage exhaustion:
- Set `cleanup=1` in the config file to delete temporary files after successful steps.
- For large genomes, ensure the output directory is on a filesystem with several terabytes of free space.

### Handling Repetitive Genomes
When working with large or highly repetitive genomes (e.g., human, cattle), the overlap step can become a bottleneck.
- Add `-f 0.005` or `-f 0.002` to `corr_rd2rd_options` and `align_rd2rd_options`.
- This instructs the underlying `minimap2` to filter out the top fraction of repetitive minimizers, significantly reducing disk usage and runtime.

### Polishing with Medaka and Clair3
If high-accuracy polishing is required, PECAT can integrate with Medaka and Clair3.
- If local installation conflicts occur, use the containerized versions by setting the following in the config:
  - `phase_clair3_command = docker run -i -v $(pwd):/mnt hkubal/clair3:latest /opt/bin/run_clair3.sh`
  - `polish_medaka_command = docker run -i -v $(pwd):/mnt ontresearch/medaka:v1.7.2 medaka`
- To skip these steps for a faster, draft-quality assembly, set `phase_method=0` and `polish_medaka=0`.

## Key Outputs
Results are organized within the project directory:
- **Corrected Reads**: `[project]/1-correct/corrected_reads.fasta`
- **Primary/Alternate Contigs**: `[project]/6-polish/racon/primary.fasta` and `alternate.fasta`
- **Haplotype-Specific Contigs**: `[project]/6-polish/racon/haplotype_1.fasta` and `haplotype_2.fasta`

## Reference documentation
- [GitHub - lemene/PECAT](./references/github_com_lemene_PECAT.md)
- [pecat - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pecat_overview.md)