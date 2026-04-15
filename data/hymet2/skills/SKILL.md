---
name: hymet2
description: HYMET2 is a specialized pipeline for the taxonomic classification of metagenomic data using hybrid sequence analysis methods. Use when user asks to classify metagenomic sequences, identify the taxonomic lineage of FASTA files, or perform origin identification for environmental or clinical samples.
homepage: https://github.com/inesbmartins02/HYMET2
metadata:
  docker_image: "quay.io/biocontainers/hymet2:1.0.0--hdfd78af_0"
---

# hymet2

## Overview
HYMET2 (Hybrid Metagenomic Tool) is a specialized pipeline for the taxonomic classification of metagenomic data. It achieves high accuracy by integrating multiple sequence analysis methods, including Mash for sketching, Mashmap for fast mapping, and Minimap2 for alignment. The tool processes FASTA-formatted sequences and outputs a detailed taxonomic lineage with associated confidence scores, making it ideal for researchers needing reliable origin identification for environmental or clinical metagenomic samples.

## Installation and Setup
The most efficient way to deploy HYMET2 is via Bioconda.

```bash
# Install via Conda
conda install -c bioconda hymet2
```

### Database Preparation
HYMET2 requires reference sketched databases to function. These must be manually retrieved and placed in the project structure.
1. Download the required sketch files: `sketch1.msh.gz`, `sketch2.msh.gz`, and `sketch3.msh.gz`.
2. Place them in the `data/` directory.
3. Decompress the files:
   ```bash
   gunzip data/sketch1.msh.gz data/sketch2.msh.gz data/sketch3.msh.gz
   ```
4. Run the configuration utility to prepare taxonomy hierarchies:
   ```bash
   hymet-config
   ```

## Command Line Usage
Once configured, the tool can be executed using the primary wrapper or the direct Perl scripts.

### Running the Pipeline
The tool processes all FASTA files (`.fna` or `.fasta`) located in the input directory defined within the configuration.

```bash
# Standard execution for Conda installations
hymet

# Manual execution if running from source
./main.pl
```

### Input Requirements
*   **Format**: FASTA (`.fasta`, `.fna`).
*   **Headers**: Must contain a unique `sequence_id`.
*   **Structure**:
    ```text
    >sequence_id metadata_info
    ATGC...
    ```

## Output Interpretation
Results are saved to `output/classified_sequences.tsv`. The output contains four critical columns:
1.  **Query**: The original sequence identifier from the input file.
2.  **Lineage**: The full taxonomic path identified for the sequence.
3.  **Taxonomic Level**: The specific rank of the classification (e.g., species, genus).
4.  **Confidence**: A value between 0 and 1 indicating the reliability of the assignment.

## Expert Tips and Best Practices
*   **Permissions**: If running from a cloned repository, ensure all helper scripts in the `scripts/` directory have execution permissions (`chmod +x scripts/*.sh scripts/*.py`).
*   **Memory Management**: Since HYMET2 utilizes Minimap2 and Mashmap, ensure the system has sufficient RAM to load the reference sketches and perform alignments, especially for large metagenomic datasets.
*   **Data Verification**: Always verify that `data/taxonomy_hierarchy.tsv` exists after running `hymet-config`, as the classification scripts depend on this file for lineage mapping.
*   **Custom Datasets**: For replicating specific studies, use the scripts in the `testdataset/` folder to map Genome Collection Files (GCF) to sequence identifiers.

## Reference documentation
- [HYMET2 GitHub Repository](./references/github_com_inesbmartins02_HYMET2.md)
- [Bioconda hymet2 Package Overview](./references/anaconda_org_channels_bioconda_packages_hymet2_overview.md)