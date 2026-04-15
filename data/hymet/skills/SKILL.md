---
name: hymet
description: HYMET is a bioinformatics pipeline designed for high-accuracy taxonomic classification of metagenomic data using a hybrid screening and alignment approach. Use when user asks to classify metagenomic sequences, perform taxonomic assignment, or identify candidate genomes in large datasets.
homepage: https://github.com/inesbmartins02/HYMET
metadata:
  docker_image: "quay.io/biocontainers/hymet:1.3.0--hdfd78af_0"
---

# hymet

## Overview

HYMET (Hybrid Metagenomic Tool) is a specialized bioinformatics pipeline designed for high-accuracy taxonomic classification of metagenomic data. It utilizes a multi-stage workflow: first screening sequences against large-scale databases (RefSeq, GTDB, and custom sets) using Mash to identify candidate genomes, and then performing precise alignment via Minimap2. This hybrid strategy allows for efficient processing of large datasets while maintaining the sensitivity required for detailed taxonomic assignment.

## Installation and Setup

### Environment Preparation
The most reliable way to deploy HYMET is via Bioconda or the provided Docker container to ensure all dependencies (Perl, Python 3.8, Mash, Minimap2, and BioPython) are correctly versioned.

```bash
# Conda installation
conda install -c bioconda hymet

# Docker deployment
docker build -t hymet .
docker run -it hymet
```

### Database Configuration
HYMET requires specific reference sketched databases that must be downloaded manually before the first run.
1. Download `sketch1.msh.gz`, `sketch2.msh.gz`, and `sketch3.msh.gz` from the project's provided data repository.
2. Place them in the `data/` directory.
3. Decompress the files: `gunzip data/*.gz`.
4. Run the configuration utility to fetch NCBI taxonomy files:
   ```bash
   hymet-config
   ```

## Usage Patterns

### Standard Execution
HYMET typically operates in an interactive mode or via the main wrapper script. Ensure your input files are in FASTA format (`.fna` or `.fasta`).

```bash
# Start the classification pipeline
hymet
```
When prompted, provide the full path to the directory containing your input sequences.

### Input Requirements
* **Format**: FASTA (`>sequence_id`)
* **Directory Structure**: All sample files should be grouped in a single input directory.
* **Permissions**: If running from a cloned repository, ensure scripts are executable: `chmod +x main.pl config.pl scripts/*`.

### Output Interpretation
The primary output is `output/classified_sequences.tsv`, which includes:
* **Query**: The original sequence identifier.
* **Lineage**: The full taxonomic path.
* **Taxonomic Level**: The specific rank assigned (e.g., species, genus).
* **Confidence**: A score from 0 to 1 indicating classification reliability.

## Expert Tips and Best Practices

### Performance Tuning
If running HYMET from the source code, you can optimize performance by editing `main.pl`:
* **Parallelization**: Increase `$classification_processes` (default is 8) to match your system's available CPU cores.
* **Sensitivity**: Adjust `$mash_threshold_refseq`, `$mash_threshold_gtdb`, or `$mash_threshold_custom` (default 0.90). Lowering these thresholds may increase sensitivity for novel or divergent sequences but may increase false positives and processing time.

### Troubleshooting Data Issues
* **Missing Taxonomy**: If classifications return empty lineages, ensure `hymet-config` completed successfully and that `data/taxonomy_hierarchy.tsv` exists.
* **Memory Management**: For very large metagenomes, ensure the `data/downloaded_genomes` directory has sufficient disk space, as the tool downloads candidate reference genomes during Step 4 of the pipeline.



## Subcommands

| Command | Description |
|---------|-------------|
| hymet artifacts | Show commands without executing them |
| hymet truth | Build Zymo mock community truth tables |
| hymet_ablation | Ablate samples using HYMET |
| hymet_bench | Run the HYMET benchmark pipeline. |
| hymet_case | Run a case study with HYMET. |
| hymet_init | Initialize hymet project |
| hymet_run | Run HYMET with specified inputs and options. |
| perl /usr/local/share/hymet/main.pl | HYMET now ships with a unified CLI (bin/hymet). For batch runs try:        bin/hymet run --contigs /path/to/sample.fna --out /path/to/out --threads 8        bin/hymet bench --manifest bench/cami_manifest.tsv |

## Reference documentation
- [HYMET README](./references/github_com_inesbmartins02_HYMET_blob_main_README.md)
- [Main Pipeline Script](./references/github_com_inesbmartins02_HYMET_blob_main_main.pl.md)
- [Configuration Script](./references/github_com_inesbmartins02_HYMET_blob_main_config.pl.md)
- [Environment Specification](./references/github_com_inesbmartins02_HYMET_blob_main_environment.yml.md)