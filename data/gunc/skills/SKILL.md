---
name: gunc
description: GUNC assesses the quality of prokaryotic genomes by detecting chimerism and taxonomic contamination. Use when user asks to download reference databases, check environment dependencies, run the analysis pipeline, visualize taxonomic assignments, or rescore existing results.
homepage: https://github.com/grp-bork/gunc
---

# gunc

## Overview

GUNC (Genome Unclutterer) is a diagnostic tool used to assess the quality of prokaryotic genomes by detecting chimerism and taxonomic contamination. It operates by calling genes from input fasta files, mapping them against a reference database using Diamond, and calculating a Closeness Score (CSS). A high CSS indicates that a genome likely contains sequences from multiple distinct taxonomic sources, suggesting it is chimeric or contaminated.

## Core Workflows

### 1. Database Management
Before running an analysis, you must download a reference database.
- **Standard Databases**: `progenomes_3` (default) or `gtdb_214`.
- **Test Data**: Use `test_data` for a minimal set to verify installation.

```bash
gunc download_db --db progenomes_3
```

### 2. Environment Validation
Use the `check` subcommand to validate tool dependencies (Diamond, Prodigal), database integrity, and output directory permissions before starting long-running jobs.

```bash
gunc check --db progenomes_3
```

### 3. Running the Pipeline
The `run` command executes the full pipeline: gene calling, Diamond mapping, and score calculation.

```bash
# Run on a directory of genomes
gunc run --input_dir ./genomes --db progenomes_3 --threads 8

# Run on a single genome file
gunc run --input_fasta genome.fa --db progenomes_3
```

### 4. Visualization
Generate interactive plots to inspect taxonomic assignments across contigs.

```bash
# Plot specific contigs or all contigs
gunc plot --gunc_file GUNC.progenomes_3.maxCSS_level.tsv --plot_all_contigs
```

### 5. Summarization and Rescoring
Use `rescore` (formerly `summarise`) to re-evaluate results or change thresholds without re-running the mapping.

```bash
gunc rescore --gunc_file GUNC.progenomes_3.maxCSS_level.tsv
```

## Expert Tips and Best Practices

- **Chimerism Threshold**: GUNC uses a default CSS chimeric threshold of **0.45**. Genomes exceeding this value are typically flagged as chimeric.
- **Diamond Version**: GUNC strictly enforces Diamond version **2.1.24**. If you must bypass this check, set the environment variable `GUNC_SKIP_DIAMOND_VERSION_CHECK=1`.
- **Custom Taxonomy**: If using a non-standard reference, provide a custom mapping file using `--custom_genome2taxonomy`.
- **Contig Details**: Use the `--contig_taxonomy_output` flag during a run to get a detailed breakdown of taxonomic assignments per contig, which is essential for manual binning refinement.
- **Handling Failures**: In batch mode, GUNC will report the number of failed genomes. Check the logs if genomes fail Diamond mapping or gene calling.



## Subcommands

| Command | Description |
|---------|-------------|
| gunc download_db | Download the GUNC database. |
| gunc merge_checkm | Merge GUNC and CheckM results |
| gunc_plot | Plotting tool for GUNC results. |
| gunc_run | Run GUNC analysis |
| gunc_summarise | Summarize GUNC results. |

## Reference documentation

- [GUNC Main Repository](./references/github_com_grp-bork_gunc_blob_master_README.rst.md)
- [GUNC Changelog and CLI Features](./references/github_com_grp-bork_gunc_blob_master_CHANGELOG.rst.md)