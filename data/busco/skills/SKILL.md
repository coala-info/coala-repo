---
name: busco
description: BUSCO is a core bioinformatics tool used to provide a quantitative measure of biological sequence completeness.
homepage: https://busco.ezlab.org
---

# busco

## Overview
BUSCO is a core bioinformatics tool used to provide a quantitative measure of biological sequence completeness. Unlike technical metrics like N50 which focus on continuity, BUSCO evaluates whether expected "core" genes are present, fragmented, or missing based on evolutionary expectations. It is essential for validating new assemblies, comparing different assembly pipelines, and ensuring that downstream analyses (like phylogenomics or gene functional annotation) are based on high-quality data.

## Core Command Line Usage

### Mandatory Arguments
Every BUSCO run requires an input file and a specific analysis mode:
- `-i [FILE/FOLDER]`: Path to the input sequence file (FASTA format) or a folder containing multiple files.
- `-m [MODE]`: The type of data being analyzed. Options are `genome`, `transcriptome`, or `protein`.

### Recommended Configuration
- `-o [NAME]`: Name for the output folder.
- `-l [LINEAGE]`: Specify the lineage dataset (e.g., `bacteria_odb10`, `mammalia_odb10`). If omitted, BUSCO v4+ can attempt to auto-select the best lineage.
- `-c [INT]`: Number of CPU cores/threads to utilize.
- `-f`: Force overwrite of an existing output directory of the same name.

### Dataset Management
BUSCO automatically downloads required datasets by default.
- `busco --list-datasets`: View all available lineage datasets.
- `--download [DATASET]`: Pre-download specific datasets (e.g., `eukaryota`, `all`).
- `--offline`: Run without internet access (requires datasets to be pre-downloaded to the `--download_path`).

## Analysis Pipelines
Depending on the target organism and data type, you can specify different search tools:

### Eukaryotic Genomes
- `--miniprot`: The default and recommended pipeline for eukaryotic genomes in v6.0.0.
- `--augustus`: Invokes the BLAST/Augustus pipeline.
  - `--augustus_species [SPECIES]`: Use a specific species model for gene prediction.
  - `--long`: Performs Augustus self-training (optimization mode), which increases runtime but improves accuracy.

### Prokaryotic Genomes
- `--metaeuk`: The default pipeline for prokaryotic (bacterial/archaeal) genomes.

## Expert Tips and Best Practices
- **Lineage Specificity**: Always use the most specific lineage available for your organism to get the most accurate completeness score. For example, use `primates_odb10` rather than `eukaryota_odb10` for a human assembly.
- **Restarting Runs**: If a run is interrupted, use the `-r` flag to attempt to restart from the last checkpoint.
- **Batch Processing**: You can point `-i` to a directory of FASTA files to run BUSCO on all of them sequentially, which is useful for large-scale comparative genomics.
- **Interpreting Results**:
  - **Complete (C)**: Genes found with lengths within the expected range.
  - **Fragmented (F)**: Only partial sequences found. High fragmentation often indicates assembly issues or poor sequencing coverage.
  - **Missing (M)**: Genes not found. This may indicate a truly incomplete assembly or that the chosen lineage is too distant from the target organism.

## Reference documentation
- [BUSCO Overview and Installation](./references/anaconda_org_channels_bioconda_packages_busco_overview.md)
- [BUSCO User Guide and CLI Reference](./references/busco_ezlab_org_assets_js_15.d4879376.js.md)
- [BUSCO Homepage and Dataset Information](./references/busco_ezlab_org_index.md)