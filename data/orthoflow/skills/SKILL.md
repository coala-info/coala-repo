---
name: orthoflow
description: Orthoflow is a streamlined workflow that automates phylogenetic inference from raw genomic data to high-quality trees. Use when user asks to infer orthology, align sequences, reconstruct phylogenetic trees from GenBank or FASTA files, or generate diagnostic reports for genome-scale datasets.
homepage: https://github.com/rbturnbull/orthoflow
metadata:
  docker_image: "quay.io/biocontainers/orthoflow:0.3.4--pyhdfd78af_0"
---

# orthoflow

## Overview
Orthoflow is a streamlined workflow for phylogenetic inference of genome-scale datasets. It automates the transition from raw genomic data—such as annotated GenBank files or FASTA sequences—to high-quality phylogenetic trees. The tool handles orthology inference (using HMM profiles or de novo methods), sequence alignment, filtering, and tree reconstruction via supermatrix or supertree approaches. It is particularly useful for researchers who need a reproducible, "one-command" solution that includes diagnostic reporting and quality verification.

## Input Preparation
The central configuration for an orthoflow run is a CSV file, typically named `input_sources.csv`.

### CSV Structure
The file must contain the following columns:
- **file**: Path to the input file relative to the working directory.
- **taxon_string**: The name of the taxon. This string appears in the output tree. Multiple files can share the same `taxon_string` to group data (e.g., fragmented genomes).
- **data_type**: 
    - `GenBank`: For annotated contigs.
    - `CDS`: For FASTA files containing nucleotide coding sequences.
    - `Protein`: For FASTA files containing amino acid sequences.
- **translation_table**: The NCBI genetic code number (e.g., `1` for Standard, `11` for Bacterial/Archaeal).

### Example input_sources.csv
```csv
file,taxon_string,data_type,translation_table
genome1.gb,Species_A,GenBank,11
seqs_part1.fa,Species_B,CDS,11
seqs_part2.fa,Species_B,CDS,11
protein_data.fasta,Species_C,Protein,1
```

## Command Line Usage
Navigate to the directory containing your `input_sources.csv` and execute the workflow:

```bash
orthoflow
```

### Execution Notes
- **First Run**: The initial execution will be slower as the tool downloads and configures necessary software dependencies.
- **Parallelization**: Orthoflow manages its own resource allocation, but ensure your environment has sufficient threads available for tools like IQ-TREE and OrthoFinder.

## Output Management
All results are organized within a `results/` directory, subdivided by workflow modules.

- **Phylogenetic Trees**: The primary inferred phylogeny is usually found at `results/supermatrix/supermatrix.protein.treefile`.
- **Reports**: Interactive HTML reports providing diagnostics and citations are located at `results/report.cds.html` or `results/report.protein.html`.
- **Logs**: Software logs are stored in the `logs/` directory.

## Expert Tips and Best Practices
- **File System Limits**: Orthoflow can generate hundreds of thousands of intermediate files and logs for large datasets. If running on a system with inode or file count quotas, monitor usage closely.
- **Cleanup**: Once a run is successfully completed and verified, you can safely delete the `logs/` directory to reclaim space.
- **Taxon Naming**: Use underscores instead of spaces in the `taxon_string` column to ensure compatibility with all downstream phylogenetic software and tree viewers (e.g., FigTree).
- **Data Grouping**: If a single taxon's data is spread across multiple GenBank or FASTA files, simply give them the exact same `taxon_string` in the CSV; Orthoflow will automatically aggregate them.

## Reference documentation
- [Orthoflow GitHub Repository](./references/github_com_rbturnbull_orthoflow.md)
- [Bioconda Orthoflow Overview](./references/anaconda_org_channels_bioconda_packages_orthoflow_overview.md)