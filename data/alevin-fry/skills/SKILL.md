---
name: alevin-fry
description: Alevin-fry is a high-performance suite of tools for the rapid and memory-efficient processing of single-cell sequencing data. Use when user asks to identify valid cell barcodes, collate read records, or perform gene quantification for single-cell RNA-seq and RNA velocity analysis.
homepage: https://github.com/COMBINE-lab/alevin-fry
---

# alevin-fry

## Overview

Alevin-fry is a high-performance suite of tools designed for the rapid, accurate, and memory-efficient processing of single-cell sequencing data. It serves as the successor to the original `alevin` tool, offering significantly improved speed and reduced memory footprints. The tool operates on Reduced Alignment Data (RAD) files, performing three primary tasks: identifying valid cell barcodes (permit listing), grouping read records by these barcodes (collation), and estimating molecule counts per gene (quantification). It is particularly powerful for "USA mode" quantification, which tracks spliced, unspliced, and ambiguous transcripts separately for RNA velocity and nuclear processing studies.

## Core Workflow and CLI Patterns

The standard pipeline consists of three sequential commands. All commands assume you have already generated a RAD file using `piscem` or `salmon alevin`.

### 1. Generate Permit List
Identify "true" cells from the background noise.

*   **Using a known whitelist (e.g., 10x Genomics):**
    `alevin-fry generate-permit-list --input <alevin_dir> --output-dir <output_dir> --unfiltered-pl <whitelist.txt> --expected-ori fw`
*   **Automatic detection (Knee method):**
    `alevin-fry generate-permit-list --input <alevin_dir> --output-dir <output_dir> --knee-distance --expected-ori fw`
*   **Forced cell count:**
    `alevin-fry generate-permit-list --input <alevin_dir> --output-dir <output_dir> --force-cells 5000 --expected-ori fw`

### 2. Collate
Group the RAD file records by the corrected cellular barcodes determined in the previous step.

`alevin-fry collate -i <output_dir> -r <alevin_dir> -t <threads>`

*   **Expert Tip:** If memory is limited, use `-m <max_records>` to reduce the number of records held in RAM during collation (default is 30M).
*   **Compression:** Use `--compress` to save disk space; it uses Snappy compression and is generally fast enough not to bottleneck the pipeline.

### 3. Quantification
Generate the final count matrix.

`alevin-fry quant -i <output_dir> -m <tg_map.tsv> -t <threads> -r <strategy> -o <quant_dir>`

*   **Resolution Strategies (`-r`):**
    *   `cr-like`: Mimics Cell Ranger (most common).
    *   `cr-like-em`: Uses EM to resolve multi-mapping reads (more accurate for overlapping genes).
    *   `parsimony-gene`: Robust to misannotation; projects transcripts to genes before graph construction.
*   **USA Mode:** To enable Spliced/Unspliced/Ambiguous counting, provide a 3-column `tg_map` (Target, Gene, S/U status). This is required for RNA velocity.

## Expert Tips and Best Practices

*   **Mapper Choice:** Prefer `piscem` over `salmon` for the initial mapping step. It is faster and uses significantly less memory.
*   **Orientation:** Always verify `--expected-ori`. For most 10x Chromium v2/v3 data, this is `fw`.
*   **Output Formats:** Alevin-fry outputs Matrix Market (`.mtx`) files by default. Use the `quants_mat_rows.txt` (barcodes) and `quants_mat_cols.txt` (genes) to label your matrix in downstream tools like Seurat or Scanpy.
*   **scATAC-seq:** Use the `alevin-fry atac` sub-command suite (specifically `generate-permit-list` and `sort`) to process scATAC-seq RAD files into sorted BED files for peak calling.
*   **Bootstrapping:** For differential expression tools that account for mapping uncertainty (like `swish`), use `-b <num_bootstraps>` during the `quant` step.



## Subcommands

| Command | Description |
|---------|-------------|
| alevin-fry atac | subcommand for processing scATAC-seq RAD files |
| alevin-fry collate | Collate a RAD file by corrected cell barcode |
| alevin-fry convert | Convert a BAM file to a RAD file |
| alevin-fry generate-permit-list | Generate a permit list of barcodes from a RAD file |
| alevin-fry infer | Perform inference on equivalence class count data |
| alevin-fry quant | Quantify expression from a collated RAD file |
| alevin-fry view | View the contents of a RAD file |

## Reference documentation

- [Getting Started](./references/alevin-fry_readthedocs_io_en_latest_getting_started.html.md)
- [Quantification Details](./references/alevin-fry_readthedocs_io_en_latest_quant.html.md)
- [Permit List Generation](./references/alevin-fry_readthedocs_io_en_latest_generate_permit_list.html.md)
- [Collation Command](./references/alevin-fry_readthedocs_io_en_latest_collate.html.md)
- [scATAC-seq (atac) Command](./references/alevin-fry_readthedocs_io_en_latest_atac.html.md)