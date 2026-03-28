---
name: philosopher
description: Philosopher is a bioinformatics suite for the post-processing, validation, and quantification of shotgun proteomics data. Use when user asks to initialize a proteomics workspace, manage protein databases, validate peptide-spectrum matches, perform protein inference, filter results by false discovery rate, or generate quantitative reports.
homepage: https://github.com/Nesvilab/philosopher
---

# philosopher

## Overview

Philosopher is a high-performance bioinformatics suite designed for the post-processing of shotgun proteomics data. It provides a streamlined command-line interface for validating peptide-spectrum matches, inferring protein groups, and calculating false discovery rates (FDR). By acting as a dependency-free wrapper for the Trans-Proteomic Pipeline (TPP) and offering its own advanced filtering and reporting algorithms, it enables researchers to move from raw search results to publication-ready quantitative tables.

## Core Workflow and Best Practices

### 1. Workspace Initialization
Always initialize a workspace in the directory containing your MS search results before running other commands. This sets up the local environment and metadata tracking.

- **Initialize**: `philosopher workspace --init`
- **Disable Analytics**: If working in a restricted environment, use `philosopher workspace --init --analytics false` to prevent usage reporting.
- **Clean Workspace**: Use `philosopher workspace --clean` to remove temporary files and reset the state.

### 2. Database Management
Use the `database` command to automate the downloading and formatting of protein sequence databases.

- **Download from UniProt**: `philosopher database --uniprot <species_code> --contam` (e.g., `human` or `mouse`).
- **Add Decoys**: Ensure your FASTA file has decoys. If not, use the `--decoy` flag to generate them using the default `rev_` prefix.

### 3. Validation and Inference
Philosopher wraps TPP tools to validate search engine outputs (pepXML/protXML).

- **PeptideProphet**: Run `philosopher peptideprophet --database <fasta> <pepXML_files>` to calculate PSM probabilities.
- **ProteinProphet**: Run `philosopher proteinprophet <pepXML_files>` to perform protein-level inference.
- **PTMProphet**: Use for site localization of modifications: `philosopher ptmprophet --channel <mod_mass> <pepXML_files>`.

### 4. FDR Filtering
The `filter` command is critical for controlling the quality of your identifications.

- **Standard Filtering**: `philosopher filter --psm 0.01 --peptide 0.01 --protein 0.01` to apply a 1% FDR at all levels.
- **Picked FDR**: Use the `--picked` flag for more accurate protein FDR estimation by treating protein-level decoys and targets as pairs.
- **Sequential FDR**: For very large datasets, use sequential estimation to maintain sensitivity.

### 5. Quantification and Reporting
Generate final tables for downstream statistical analysis.

- **Label-Free (MS1)**: Use `philosopher freequant` to extract intensities from mzML/RAW files.
- **Isobaric Labeling (TMT/iTRAQ)**: Use `philosopher labelquant --unimod <id> <pepXML_files>` to extract reporter ion intensities.
- **Aggregation (Abacus)**: To combine multiple experiments into a single matrix:
  `philosopher abacus --protein --peptide --folders <exp1> <exp2> <exp3>`
- **Final Reports**: Generate TSV files using `philosopher report`. This produces `psm.tsv`, `peptide.tsv`, and `protein.tsv`.

### 6. Automated Pipeline
For standard workflows, use the `pipeline` command to execute the entire process (workspace, database, validation, filtering, and reporting) in a single call.

- **Example**: `philosopher pipeline --config <config_file> <data_directory>`

## Expert Tips
- **Decoy Tagging**: Ensure the `--tag` flag matches your database decoy prefix (default is `rev_`). If your search engine used a different prefix (like `DECOY_`), you must specify it.
- **Memory Management**: For large-scale datasets (thousands of files), ensure you have sufficient RAM, as ProteinProphet and Abacus can be memory-intensive during the grouping phase.
- **Razor Peptides**: When running `abacus`, use the `--razor` flag to assign shared peptides to the protein group with the most evidence, improving quantification accuracy.



## Subcommands

| Command | Description |
|---------|-------------|
| philosopher abacus | Generates abacus reports. |
| philosopher bioquant | Bioquant |
| philosopher comet | Run comet |
| philosopher completion | Generate the autocompletion script for philosopher for the specified shell. |
| philosopher database | Process a database for peptide identification. |
| philosopher filter | Filter peptides and proteins based on FDR levels and other criteria. |
| philosopher freequant | Quantify peaks using free energy calculations. |
| philosopher iprophet | iprophet |
| philosopher labelquant | Quantify isobaric labeling experiments. |
| philosopher msfragger | MSFragger is a fast and accurate mass spectrometry data analysis tool for peptide identification. |
| philosopher peptideprophet | peptideprophet |
| philosopher proteinprophet | Runs ProteinProphet on Philosopher results. |
| philosopher ptmprophet | PTMProphet is a tool for PTM localization. |
| philosopher report | Generate reports from philosopher runs. |
| philosopher slack | Send messages to Slack |
| philosopher tmtintegrator | Integrates TMT quantification results from Philosopher. |
| philosopher workspace | Manage the experiment workspace for the analysis |
| philosopher_pipeline | Executes a pipeline. |

## Reference documentation
- [Philosopher Wiki Home](./references/github_com_Nesvilab_philosopher_wiki.md)
- [Abacus Command Guide](./references/github_com_Nesvilab_philosopher_wiki_Abacus.md)
- [FDR Filter Guide](./references/github_com_Nesvilab_philosopher_wiki_filter.md)
- [Workspace Management](./references/github_com_Nesvilab_philosopher_wiki_workspace.md)
- [Pipeline Automation](./references/github_com_Nesvilab_philosopher_wiki_pipeline.md)