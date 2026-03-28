---
name: commec
description: Commec is a bioinformatics suite that screens DNA sequences to identify biosecurity risks and sequences of concern. Use when user asks to screen sequences for pathogenicity, identify sequences on international control lists, summarize screening results, or split multi-FASTA files.
homepage: https://github.com/ibbis-screening/common-mechanism
---

# commec

## Overview

The `commec` (Common Mechanism) package is a specialized bioinformatics suite designed for DNA sequence screening. It identifies sequences of concern that contribute to pathogenicity or are listed on international control lists (like the Australia Group). The tool operates through a tiered pipeline: first, a fast HMM-based biorisk search; second, a detailed taxonomy search using protein (BLASTX/DIAMOND) and nucleotide (BLASTN) homology; and finally, a "low concern" filter to clear common or conserved sequences that do not pose a biosecurity risk.

## Core Workflows

### 1. Database Initialization
Before screening, you must download the required reference databases.
- **Interactive Setup**: `commec setup`
- **Non-interactive/Automated**: `commec setup --auto`

### 2. Sequence Screening (`screen`)
The `screen` command is the primary analysis tool. It requires a database directory and an input FASTA file.

- **Lightweight/Fast Screening**: Skips heavy taxonomy searches. Suitable for laptops or quick checks.
  `commec screen -d /path/to/databases --skip-tx input.fasta`

- **High-Performance Full Analysis**: Uses DIAMOND for faster protein searches and multiple threads.
  `commec screen -d /path/to/databases -p diamond -t 8 input.fasta`

- **Custom Output and Cleanup**: Directs results to a specific folder and removes intermediate files.
  `commec screen -d /path/to/databases -o ./results/my_run --cleanup input.fasta`

### 3. Result Summarization (`flag`)
After running `screen` on multiple files, use `flag` to aggregate the `.output.json` results into a single CSV for interpretation.
- **Recursive Summary**: `commec flag -r /path/to/results_dir/ -o summary_report`

### 4. Data Preparation (`split`)
`commec` often performs best when processing individual records. Use `split` to break a multi-record FASTA into individual files.
- **Split Multi-FASTA**: `commec split multi_record.fasta`

## Expert Tips and Best Practices

- **Resource Management**: Full taxonomy screening is RAM-intensive. While core biorisk searches (`--skip-tx`) need <2GB, a full search against NCBI `nr` or `nt` databases typically requires 20GB to 100GB of RAM and significant disk space (275GB+).
- **Search Tool Selection**: Use `-p diamond` instead of the default `blastx` when processing large batches or long sequences to significantly reduce compute time.
- **Handling False Positives**: If a sequence is flagged but known to be safe (e.g., a vaccine strain), you can extend the local database by adding the Taxon ID to `vax_taxids` in the `biorisk_db` folder.
- **Resuming Interrupted Runs**: Use the `-R` or `--resume` flag to pick up where a previous `screen` command left off without re-calculating completed steps.
- **Output Interpretation**:
    - `.output.json`: The primary data file containing all hits.
    - `_summary.html`: A visual report highlighting flagged regions.
    - `.screen.log`: A human-readable table of the final outcomes.



## Subcommands

| Command | Description |
|---------|-------------|
| commec flag | Parse all .screen, or .json files in a directory and create CSVs of flags raised |
| commec screen | Run Common Mechanism screening on an input FASTA. |
| commec_setup | This script will help download the mandatory databases required for using Commec Screen, and requires a stable internet connection, wget, and update_blastdb.pl. This setup is split over 3 steps: 1. Specify download location. 2. Choose which databases to download. 3. Confirm and start downloads. |
| commec_split | Split a multi-record FASTA file into individual files, one for each record |

## Reference documentation
- [Command Line Usage](./references/github_com_ibbis-bio_common-mechanism_wiki_Command-Line-Usage.md)
- [Installation Guide](./references/github_com_ibbis-bio_common-mechanism_wiki_Install.md)
- [Extending Databases](./references/github_com_ibbis-bio_common-mechanism_wiki_Extending-with-Your-Own-Databases.md)
- [Transitioning to v1.0](./references/github_com_ibbis-bio_common-mechanism_wiki_Transition.md)