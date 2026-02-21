---
name: viralflye
description: viralFlye is a specialized bioinformatics pipeline designed to extract and polish viral sequences from complex metagenomic assemblies.
homepage: https://github.com/Dmitry-Antipov/viralFlye/
---

# viralflye

## Overview
viralFlye is a specialized bioinformatics pipeline designed to extract and polish viral sequences from complex metagenomic assemblies. It specifically works with outputs from metaFlye (v2.9+) to recover high-quality viral genomes that might otherwise be fragmented or misassembled. The tool categorizes viral sequences into circular and linear components and includes a dedicated workflow for matching these viruses to their microbial hosts using CRISPR spacer analysis.

## Installation and Setup
The most reliable way to install viralFlye is via Bioconda:

```bash
conda install bioconda::viralflye
```

Alternatively, for a local installation from source:
1. Clone the repository: `git clone https://github.com/Dmitry-Antipov/viralFlye`
2. Run the installation script: `./install.sh` (this creates a `viralFlye` conda environment).

### Required Database
You must have the Pfam HMM database for viral genome identification. If not present, download it:
```bash
wget http://ftp.ebi.ac.uk/pub/databases/Pfam/releases/Pfam34.0/Pfam-A.hmm.gz
```

## Core Workflow

### 1. Viral Genome Recovery
To run the main pipeline, you need the directory of a completed metaFlye assembly (run with the `--meta` option) and the original long reads used for that assembly.

```bash
conda activate viralFlye
./viralFlye.py --dir [flye_assembly_dir] --hmm [path_to_Pfam-A.hmm.gz] --reads [path_to_reads] --outdir [output_dir]
```

**Key Outputs:**
- `circulars_viralFlye.fasta`: High-confidence circular viral genomes.
- `linears_viralFlye.fasta`: Identified linear viral sequences.
- `components_viralFlye.fasta`: Viral components identified within the assembly graph.

### 2. CRISPR Host Matching
To predict hosts for the recovered viruses, use the `crispr_host_match.py` script. This script matches predicted viruses against CRISPR spacers found in the metagenome.

```bash
python crispr_host_match.py --dir [flye_assembly_dir] --outdir [output_dir]
```
The results are stored in `blast.out` (BLAST format 6) within the output folder.

## Expert Tips and Best Practices
- **Assembly Requirement**: viralFlye is strictly dependent on metaFlye v2.9 or higher. Ensure the assembly was generated using the `--meta` flag, as the pipeline relies on the specific graph structure and metadata produced in metagenomic mode.
- **Input Reads**: Use the same set of long reads (PacBio or Oxford Nanopore) that were used for the initial assembly to ensure consistency during the polishing and verification stages.
- **Resource Management**: The pipeline utilizes several heavy dependencies (minimap2, samtools, freebayes). Ensure your environment has sufficient memory, especially when processing large metagenomic datasets with high depth of coverage.
- **Pfam Version**: While newer versions of Pfam exist, the documentation specifically references Pfam 34.0. If you encounter identification issues, revert to this specific version.

## Reference documentation
- [viralFlye GitHub Repository](./references/github_com_Dmitry-Antipov_viralFlye.md)
- [Bioconda viralflye Overview](./references/anaconda_org_channels_bioconda_packages_viralflye_overview.md)