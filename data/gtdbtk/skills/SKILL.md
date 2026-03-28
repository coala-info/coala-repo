---
name: gtdbtk
description: GTDB-Tk assigns taxonomic classifications to prokaryotic genomes by identifying marker genes and placing them into a reference phylogenetic tree. Use when user asks to assign taxonomy to bacterial or archaeal genomes, run the classify_wf pipeline, or perform phylogenetic placement and ANI validation.
homepage: http://pypi.python.org/pypi/gtdbtk/
---

# gtdbtk

## Overview

GTDB-Tk (Genome Database Taxonomy Toolkit) is the industry-standard software for assigning taxonomy to prokaryotic genomes. It works by identifying a set of domain-specific marker genes (120 for Bacteria, 53 for Archaea), aligning them to a reference manifold, and placing the query genomes into a massive reference phylogenetic tree using pplacer. The final classification is refined using Average Nucleotide Identity (ANI) against reference genomes.

This skill provides guidance on executing the standard classification workflows, managing high-memory requirements, and interpreting the resulting summary files.

## Core Workflows

### The Standard Classification Workflow (classify_wf)
The most common use case is running the entire pipeline in one command. This handles identification, alignment, and classification.

```bash
gtdbtk classify_wf --genome_dir <input_dir> --out_dir <output_dir> --extension fa --cpus 16
```

### Step-by-Step Execution
For large datasets or troubleshooting, you can run the stages independently:

1.  **Identify**: Calls genes (Prodigal) and identifies markers (HMMER).
    ```bash
    gtdbtk identify --genome_dir <input_dir> --out_dir <identify_dir> --extension gz --cpus 16
    ```
2.  **Align**: Creates a Multiple Sequence Alignment (MSA) and filters low-quality genomes.
    ```bash
    gtdbtk align --identify_dir <identify_dir> --out_dir <align_dir> --cpus 16
    ```
3.  **Classify**: Performs phylogenetic placement and ANI validation.
    ```bash
    gtdbtk classify --genome_dir <input_dir> --align_dir <align_dir> --out_dir <classify_dir> --cpus 16
    ```

## Expert Tips and Best Practices

### Memory Management
GTDB-Tk is memory-intensive. Version 2.x uses a "divide-and-conquer" approach by default to reduce RAM usage.
- **Default (Split-tree)**: Requires ~55GB RAM. It splits the bacterial tree into class-level subtrees.
- **Full Tree**: Use `--full-tree` if you need placement against the entire reference tree, but be prepared for ~320GB RAM requirements.
- **Pplacer Threads**: If memory is an issue, limit pplacer specifically using `--pplacer_cpus 1`.

### ANI Screening
Since v2.2, GTDB-Tk uses `skani` for rapid ANI pre-screening.
- Use `--mash_db <path>` to provide or generate a sketch database for faster subsequent runs.
- Use `--skip_ani_screen` to force phylogenetic placement for all genomes (slower but more thorough for novel taxa).

### Input Handling
- **Extensions**: Specify the file extension exactly (e.g., `-x fasta` or `-x fa.gz`).
- **Proteins**: If you already have predicted proteins, use `--genes` to skip the Prodigal step. Note that this will skip ANI validation as ANI requires nucleotide sequences.

### Interpreting Results
The primary output is `gtdbtk.bac120.summary.tsv` (or `ar53`).
- **classification**: The full GTDB taxonomy string.
- **fastani_ani**: The ANI to the closest reference genome.
- **status**: Look for "placed" or "assigned". Genomes that fail quality checks (e.g., too few markers) will be marked as "Unclassified".
- **Warnings**: Check `gtdbtk.warnings.log` for genomes filtered out due to low marker count or poor alignment.

## Common Troubleshooting
- **Data Path**: Ensure the environment variable `GTDBTK_DATA_PATH` is set to the directory containing the unarchived GTDB reference data.
- **Check Install**: Run `gtdbtk check_install` to verify that all third-party dependencies (HMMER, pplacer, skani, FastTree) are in your PATH and the reference data is valid.



## Subcommands

| Command | Description |
|---------|-------------|
| gtdbtk ani_rep | Calculate ANI scores between genomes and assign them to species clusters. |
| gtdbtk classify | Classify genomes using GTDB-Tk |
| gtdbtk classify_wf | Classify genomes using GTDB-Tk |
| gtdbtk convert_to_itol | Convert GTDB-Tk trees to iTOL format |
| gtdbtk convert_to_species | Convert a tree to a species-resolved tree. |
| gtdbtk de_novo_wf | De novo workflow for GTDB-Tk |
| gtdbtk decorate | Decorate a tree with GTDB-Tk classifications and custom taxonomy. |
| gtdbtk export_msa | Export MSA from GTDB-Tk |
| gtdbtk identify | Identify GTDB-Tk classifications for genomes. |
| gtdbtk infer | Infer phylogenetic trees for GTDB-Tk |
| gtdbtk infer_ranks | Root the input tree at the specified ingroup taxon and output the rooted tree. |
| gtdbtk remove_labels | Removes labels from a GTDB-Tk tree. |
| gtdbtk trim_msa | Trims an MSA based on a mask file or reference mask. |
| gtdbtk_align | Aligns genomes to create a multiple sequence alignment. |
| gtdbtk_root | Root a tree using a specified outgroup taxon. |

## Reference documentation
- [GTDB-Tk Commands Index](./references/ecogenomics_github_io_GTDBTk_commands_index.html.md)
- [Classify Workflow Example](./references/ecogenomics_github_io_GTDBTk_examples_classify_wf.html.md)
- [GTDB-Tk FAQ](./references/ecogenomics_github_io_GTDBTk_faq.html.md)
- [Installation and Hardware Requirements](./references/ecogenomics_github_io_GTDBTk_installing_index.html.md)