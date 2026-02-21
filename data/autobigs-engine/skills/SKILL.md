---
name: autobigs-engine
description: The autobigs-engine is a specialized bioinformatics tool designed for high-throughput MLST profiling.
homepage: https://github.com/RealYHD/autoBIGS.engine
---

# autobigs-engine

## Overview
The autobigs-engine is a specialized bioinformatics tool designed for high-throughput MLST profiling. It streamlines the process of comparing genomic sequences against established disease databases to determine sequence types (ST) and allelic profiles. Use this skill to automate the retrieval of MLST data, manage disease-specific schemas, and process sequence batches efficiently.

## Installation
The engine is primarily distributed via Bioconda. Ensure your environment is configured with the bioconda channel.

```bash
conda install -c bioconda autobigs-engine
```

## Core Usage Patterns
The tool is typically used to query sequence data against MLST databases. While specific subcommands depend on the version, the general workflow follows these patterns:

### Database Initialization
Before running queries, ensure the local engine has access to the latest MLST schemas for the target organism.
- Use the update or fetch commands to synchronize with public MLST repositories.
- Specify the organism or disease type to limit the scope of the download.

### Sequence Profiling
To identify the MLST profile of a sequence:
- Provide the input file (typically in FASTA or FASTQ format).
- Define the target scheme (e.g., *Neisseria meningitidis*, *Streptococcus pneumoniae*).
- The engine will perform an alignment or k-mer based search to identify alleles at each locus.

### Batch Processing
For large-scale surveillance:
- Point the engine to a directory of genomic assemblies.
- Use the output flags to generate summary tables (CSV/TSV) for downstream epidemiological analysis.

## Best Practices
- **Database Currency**: Always run a database update check before starting a new analysis to ensure you are using the most recent allelic definitions.
- **Input Quality**: Ensure input sequences are of sufficient length and quality; fragmented assemblies may result in "partial" or "novel" allele designations.
- **Organism Specificity**: Double-check the scheme name against the official PubMLST nomenclature to avoid "scheme not found" errors.

## Reference documentation
- [autobigs-engine Overview](./references/anaconda_org_channels_bioconda_packages_autobigs-engine_overview.md)