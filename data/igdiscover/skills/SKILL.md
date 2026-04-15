---
name: igdiscover
description: IgDiscover analyzes antibody repertoire sequencing data to identify personalized germline V, D, and J gene databases. Use when user asks to identify novel alleles, process raw FASTQ reads for repertoire analysis, or create a customized germline database from NGS data.
homepage: https://igdiscover.se/
metadata:
  docker_image: "quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2"
---

# igdiscover

## Overview
IgDiscover is a specialized pipeline designed for the analysis of antibody repertoires. It excels at identifying personalized germline V-gene databases from NGS data, which is critical for accurate mutation analysis. Use this tool when you need to process raw sequencing reads (FASTQ) to produce a high-quality set of V, D, and J genes specific to the individual being studied, rather than relying solely on generic public databases like IMGT.

## Core Workflow and CLI Patterns

### 1. Project Initialization
Every analysis must start with the creation of a project directory. This sets up the required folder structure and a default configuration file.
```bash
igdiscover init --database /path/to/germline/database/ --reads /path/to/reads.fastq.gz my_project
```
*Tip: The database directory should contain V.fasta, D.fasta, and J.fasta files.*

### 2. Configuration Tuning
Before running the pipeline, edit `igdiscover.yaml` in the project directory. Key parameters to consider:
- `forward_primers` / `reverse_primers`: Ensure these match your library preparation.
- `race_g`: Set to `true` if using 5' RACE protocol.
- `barcode_length`: Specify if using UMIs to reduce PCR bias.

### 3. Running the Pipeline
Execute the full discovery process using the `run` command. This is a wrapper that handles alignment, filtering, and allele discovery.
```bash
cd my_project
igdiscover run
```
*Note: This process is computationally intensive. Use `-j N` to specify the number of CPU cores.*

### 4. Common Command Patterns
- **Inspect Results**: Check `final/database/` for the discovered V, D, and J genes.
- **Quality Control**: Review `stats/` for information on read filtering and alignment rates.
- **Manual Discovery**: Use `igdiscover discover` to re-run the allele discovery step with different thresholds without re-aligning all reads.

## Expert Tips
- **Input Quality**: IgDiscover performs best with high-quality, long reads (e.g., MiSeq 2x300bp) that cover the entire VDJ region.
- **Novel Alleles**: The tool identifies "candidate" novel alleles. Always validate these by checking the `v_germline.tab` file for the number of unique CDR3s supporting the new variant; higher diversity indicates a true genomic variant rather than a PCR artifact.
- **Iterative Refinement**: For complex samples, consider running the pipeline once, taking the discovered V genes as the new starting database, and running it again to improve alignment sensitivity.



## Subcommands

| Command | Description |
|---------|-------------|
| igdiscover augment | Augment AIRR-formatted IgBLAST output with extra IgDiscover-specific columns |
| igdiscover clonoquery | Query a table of assigned sequences by clonotype |
| igdiscover clonotypes | Group assigned sequences by clonotype |
| igdiscover clusterplot | Plot a clustermap of all sequences assigned to a gene |
| igdiscover commonv | Find common V genes between two different antibody libraries. |
| igdiscover config | Configure igdiscover |
| igdiscover count | Compute expression counts |
| igdiscover dbdiff | Compare two FASTA files based on sequences |

## Reference documentation
- [IgDiscover Documentation Index](./references/igdiscover_se_index.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_igdiscover_overview.md)