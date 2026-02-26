---
name: cesar
description: CESAR maps known coding sequences from a reference genome onto target genomes while preserving splice site logic and codon structure. Use when user asks to map coding exons across species, identify gene structures in related genomes, or perform structure-aware genomic realignment.
homepage: https://github.com/hillerlab/CESAR2.0
---


# cesar

## Overview
CESAR 2.0 (Coding Exon Structure Aware Realigner) is a specialized tool for comparative genomics that maps known coding sequences from a reference genome onto target genomes. Unlike general-purpose aligners, CESAR is "structure-aware," meaning it incorporates splice site logic and codon preservation into its alignment algorithm. This makes it highly effective for identifying gene structures in related species, even when introns have been deleted or splice sites have shifted. Use this skill to guide the preparation of genomic data (2bit files and bigBed alignments) and the execution of the realignment pipeline.

## Installation and Environment
CESAR can be installed via Bioconda or compiled from source.
- **Conda**: `conda install bioconda::cesar`
- **Source**: Run `make` in the root directory to build the `cesar` binary.
- **Dependencies**: Requires Kent source tools (specifically `mafSpeciesSubset`, `twoBitInfo`, `mafIndex`).
- **Environment**: Ensure the `profilePath` environment variable is set to the CESAR installation directory, as it needs to locate the `extra/tables` directory containing the ETH matrix and HMM profiles.

## Core Workflow
The standard pipeline involves preparing the reference gene annotations, running the realignment, and converting the output back to standard formats.

### 1. Input Preparation
CESAR requires input genes in a specific `genePred` format.
- **Conversion**: Use `gff3ToGenePred` to create the input. 
- **Warning**: Do NOT use `gtfToGenePred`, as it often lacks the CDS annotations strictly required by CESAR.
- **Formatting**: Use the provided helper script to filter and format the transcripts:
  ```bash
  formatGenePred.pl input.gp input.forCESAR discardedTranscripts.txt -longest
  ```

### 2. Genomic Data Requirements
- **2bit Directory**: Create a directory where each subdirectory is named after an assembly (e.g., `hg38/`, `mm10/`). Each must contain the `$assembly.2bit` file and a `chrom.sizes` file.
- **Alignment Index**: Alignments must be in `maf` format and indexed into `bigBed` (.bb) format:
  ```bash
  mafIndex alignment.maf alignment.bb -chromSizes=reference.chrom.sizes
  ```

### 3. Running Realignment
The primary script for realignment is `annotateGenesViaCESAR.pl`. It is typically run per transcript.

**Command Pattern:**
```bash
annotateGenesViaCESAR.pl [transcript_ID] [alignment.bb] [input.forCESAR] [ref_species] [query_species_list] [output_dir] [2bit_dir] [profile_path] -maxMemory [GB]
```

**Key Parameters:**
- `query_species_list`: A comma-separated list of target species (e.g., `mm10,canFam3`).
- `-maxMemory`: Crucial for large genes. 30GB handles most human genes; 50GB is recommended for complete coverage of complex genes.

### 4. Result Processing
After realignment, convert the output exon coordinates into a standard `genePred` file:
```bash
bed2GenePred.pl [species_name] [output_dir] [output_file.gp]
```

## Expert Tips and Best Practices
- **Gene Mode**: CESAR 2.0 supports a "gene mode" that aligns entire genes at once, which is superior for recognizing complete intron deletions.
- **Memory Estimation**: If running on a cluster, estimate memory based on the largest exon in the set. CESAR 2.0 is significantly more memory-efficient than v1 but still scales with exon size.
- **Splice Site Shifts**: If you suspect significant evolutionary distance, CESAR is preferred over standard liftover tools because it can identify splice sites that have shifted over larger distances.
- **Filtering**: When converting results back to `genePred`, it is common practice to filter out 0-bp exons (which represent complete deletions in the query species) using `awk`.

## Reference documentation
- [CESAR 2.0 GitHub Repository](./references/github_com_hillerlab_CESAR2.0.md)
- [Bioconda CESAR Package](./references/anaconda_org_channels_bioconda_packages_cesar_overview.md)