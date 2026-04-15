---
name: xpore
description: xpore is a statistical framework for identifying and quantifying differential RNA modifications from Oxford Nanopore direct RNA sequencing data. Use when user asks to identify RNA modification sites, estimate modification rates, or perform differential epitranscriptomic analysis between different biological conditions.
homepage: https://github.com/GoekeLab/xpore
metadata:
  docker_image: "quay.io/biocontainers/xpore:2.1--pyh5e36f6f_0"
---

# xpore

## Overview

xpore is a powerful Python-based statistical framework designed for the epitranscriptomics field. It enables the identification of RNA modifications by analyzing the raw signal (current) from Oxford Nanopore Technologies (ONT) direct RNA sequencing. Unlike tools that require a completely unmodified control, xpore uses a mixture model to estimate modification rates across different conditions. It is specifically optimized for "differential" analysis, allowing researchers to pinpoint exactly where and how much the RNA modification landscape changes between samples, such as a wild-type versus a knockdown.

## Data Preparation Workflow

Before running xpore, you must align your raw Nanopore signals to a reference transcriptome using `nanopolish eventalign`.

### 1. Data Preparation (`xpore dataprep`)
The `dataprep` command converts the large, verbose output from nanopolish into a structured format (HDF5) that xpore can process efficiently.

**Common CLI Pattern:**
```bash
xpore dataprep --eventalign eventalign.txt --out_dir ./prepared_data --readcount_min 20
```

**Key Parameters:**
- `--eventalign`: The output file from `nanopolish eventalign`.
- `--out_dir`: Directory where the processed data and index files will be stored.
- `--readcount_min`: Filters out transcripts with low coverage early to save processing time.
- `--skip_eventalign_indexing`: Use this flag if you have already generated an index for your eventalign file to speed up the process.

### 2. Differential Modification Analysis (`xpore diffmod`)
The `diffmod` command performs the actual statistical testing. It compares the signal distributions at each k-mer position across the transcriptome.

**Execution Pattern:**
```bash
xpore diffmod --config config.ini
```

**Expert Tips for Analysis:**
- **K-mer Model**: xpore relies on a pre-trained k-mer model (typically `model_kmer.csv`). Ensure this file is correctly referenced if not using the default bundled version.
- **Filtering Results**: After the run, focus on the `diffmod_table.csv`. High-confidence sites typically have a high absolute `diff_mod_rate` and a low `p_value_adjusted`.
- **Replicates**: xpore natively handles biological replicates. Ensure your configuration groups replicates under the same condition name to improve statistical power.

## Best Practices and Troubleshooting

- **Memory Management**: `dataprep` can be memory-intensive for very large eventalign files. Consider splitting your eventalign files by chromosome or using high-memory nodes.
- **Transcriptome Versioning**: Ensure the reference transcriptome used for `nanopolish` is identical to the one used in any downstream functional analysis to avoid coordinate mismatches.
- **Minimum Coverage**: For reliable differential modification calls, a minimum coverage of 15-20 reads per site per condition is generally recommended. Sites with lower coverage often result in high variance and unreliable p-values.
- **Output Interpretation**: 
    - `mod_rate`: The estimated fraction of modified reads at a specific site.
    - `z_score`: Indicates the direction and significance of the change between condition A and condition B.



## Subcommands

| Command | Description |
|---------|-------------|
| xpore postprocessing | Performs postprocessing steps for xpore-diffmod output. |
| xpore_dataprep | Prepares data for xpore analysis. |
| xpore_diffmod | Performs differential modification analysis. |

## Reference documentation
- [xPore Quickstart Guide](./references/xpore_readthedocs_io_en_latest_quickstart.html.md)
- [Command Line Interface Reference](./references/xpore_readthedocs_io_en_latest_cmd.html.md)
- [Data Preparation Details](./references/xpore_readthedocs_io_en_latest_preparation.html.md)
- [xPore GitHub Repository](./references/github_com_GoekeLab_xpore_blob_master_README.md)