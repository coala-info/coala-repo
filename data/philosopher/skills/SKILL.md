---
name: philosopher
description: Philosopher is a high-performance toolkit for the downstream analysis, validation, and reporting of shotgun proteomics data. Use when user asks to initialize workspaces, manage UniProt databases, validate peptide-spectrum matches, perform protein inference, apply FDR filtering, or generate quantification reports.
homepage: https://github.com/Nesvilab/philosopher
---


# philosopher

## Overview
Philosopher is a high-performance toolkit designed for the downstream analysis of shotgun proteomics data. It serves as both a standalone suite and a dependency-free wrapper for the Trans-Proteomic Pipeline (TPP), integrating tools like PeptideProphet, iProphet, and ProteinProphet into a cohesive command-line interface. It is the engine behind the FragPipe GUI but can be used independently to automate database management, FDR control, and multi-level reporting.

## Core Workflow and CLI Patterns

### 1. Workspace Initialization
Before running any analysis, initialize a workspace to manage metadata and temporary files.
```bash
philosopher workspace --init
```

### 2. Database Management
Download and prepare protein sequence databases directly from UniProt.
```bash
# Download UniProt database for a specific organism (e.g., human)
philosopher database --uniprot human --contam

# Format an existing FASTA file for use with search engines
philosopher database --custom your_database.fasta
```

### 3. Validation and Inference
Process search results (pepXML/protXML) through the TPP modules.
```bash
# Validate peptide-spectrum matches
philosopher peptideprophet --database your_db.fasta --nonparam [files.pepXML]

# Combine multiple runs and refine probabilities
philosopher iprophet [files.pepXML]

# Perform protein inference
philosopher proteinprophet [files.pepXML]
```

### 4. FDR Filtering
Apply False Discovery Rate (FDR) filtering at the PSM, peptide, and protein levels. Philosopher supports a "picked" FDR approach for more accurate estimation.
```bash
# Apply 1% FDR at all levels
philosopher filter --psm 0.01 --peptide 0.01 --protein 0.01 --database your_db.fasta [files]
```

### 5. Quantification
Philosopher handles both label-free (MS1 intensity/spectral counting) and label-based (TMT/iTRAQ) workflows.
```bash
# Label-free quantification (LFQ)
philosopher freequant --dir .

# TMT/isobaric labeling quantification
philosopher labelquant --isobaric TMT10 --dir .
```

### 6. Reporting
Generate comprehensive TSV reports for downstream statistical analysis.
```bash
philosopher report
```
This produces several files, including:
- `psm.tsv`: Detailed PSM information including localization scores and probabilities.
- `peptide.tsv`: Unique peptide sequences and their associated metadata.
- `protein.tsv`: Protein groups, coverage, and quantification values.

## Expert Tips
- **Sequential FDR**: For extremely large datasets, use the sequential FDR estimation feature to maintain sensitivity while controlling for false positives across multiple filtered lists.
- **Two-Dimensional Filtering**: Use the `filter` command to simultaneously control PSM and Protein FDR levels, which is more robust than filtering them independently.
- **PTM Localization**: When working with modified peptides, ensure `ptmprophet` is run before `filter` to include site localization scores in your final `psm.tsv` report.
- **Clean Up**: Use `philosopher workspace --clean` to remove intermediate files after a successful pipeline run to save disk space.

## Reference documentation
- [Philosopher GitHub Repository](./references/github_com_Nesvilab_philosopher.md)
- [Philosopher Wiki and Command Overview](./references/github_com_Nesvilab_philosopher_wiki.md)
- [Bioconda Package Information](./references/anaconda_org_channels_bioconda_packages_philosopher_overview.md)