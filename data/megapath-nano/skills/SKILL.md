---
name: megapath-nano
description: MegaPath-Nano performs taxonomic profiling and antimicrobial resistance detection for ultra-long Oxford Nanopore metagenomic sequencing data. Use when user asks to perform compositional analysis, identify strains in metagenomic reads, detect drug-level AMR markers, or preprocess and filter ONT fastq files.
homepage: https://github.com/HKU-BAL/MegaPath-Nano
metadata:
  docker_image: "quay.io/biocontainers/megapath-nano:2--hee3b9ab_0"
---

# megapath-nano

## Overview

MegaPath-Nano is a comprehensive compositional analysis tool designed specifically for ultra-long Oxford Nanopore (ONT) metagenomic sequencing data. It addresses the high error rates of ONT reads by performing global optimization on multiple alignments to reassign misplaced reads, ensuring accurate taxonomic profiling down to the strain level. Additionally, it utilizes a consensus-based approach—incorporating multiple databases and software—to provide refined drug-level antimicrobial resistance (AMR) detection. The tool handles the entire workflow from raw read cleansing to final reporting within a single execution.

## Core CLI Usage

The primary entry point is `megapath_nano.py`. Ensure your environment is activated (e.g., `conda activate mpn`) before execution.

### 1. Full Metagenomic Workflow
To perform data cleansing, taxonomic profiling, and AMR detection in one step:
```bash
python megapath_nano.py --query input.fastq --output_prefix sample_01 --output_folder ./results
```

### 2. Modular Execution
If only specific components of the pipeline are required, use the following flags:

*   **Taxonomic Analysis Only:**
    ```bash
    python megapath_nano.py --query input.fastq --taxon_module_only
    ```
*   **AMR Detection Only (from FASTQ/FASTA):**
    ```bash
    python megapath_nano.py --query input.fastq --AMR_module_only
    ```
*   **AMR Detection Only (from BAM):**
    Use the specialized AMR script for pre-aligned data:
    ```bash
    python megapath_nano_amr.py --query_bam input.bam --output_folder ./amr_results --taxon Escherichia
    ```
*   **Preprocessing/Filtering Only:**
    Performs adaptor trimming, quality filtering, and human/decoy removal:
    ```bash
    python megapath_nano.py --query input.fastq --filter_fq_only
    ```

## Expert Tips and Best Practices

### Performance Optimization
*   **Threading:** Use `--max_aligner_thread` to control CPU usage. The tool defaults to 64, but it will automatically scale down to the available number of cores.
*   **Memory Management:** The tool uses `/run/shm` (RAM disk) by default for temporary files to speed up I/O. Ensure your system has sufficient RAM if processing large datasets.

### Quality Control Tuning
Adjust these parameters in the `megapath_nano.py` command to handle low-quality runs:
*   **Read Length:** Increase `--min_read_length` (default 500) to improve alignment specificity.
*   **Read Quality:** Adjust `--min_read_quality` (default 7.0) if the flowcell performance was sub-optimal.
*   **Alignment Scoring:** Use `--human_filter_alignment_score_threshold` (default 1000) to be more or less aggressive in removing host contamination.

### Database Maintenance
MegaPath-Nano relies on several external databases. Ensure these are initialized before the first run:
*   **AMR Databases:** Run `rgi load --card_json bin/amr_db/card/card.json` and `amrfinder -u` to ensure the latest resistance markers are available.
*   **Custom Decoys:** If working with specific contaminants, add them using `python addDecoyDB.py --decoy_fasta custom.fasta`.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/runMegaPath-Nano-Amplicon.sh | Runs the MegaPath-Nano amplicon pipeline. |
| megapath_nano.py | MegaPath-Nano: Compositional Analysis |
| megapath_nano_amr.py | MegaPath-Nano: AMR Detection |

## Reference documentation
- [MegaPath-Nano README](./references/github_com_HKU-BAL_MegaPath-Nano_blob_master_README.md)
- [MegaPath-Nano Detailed Usage Guide](./references/github_com_HKU-BAL_MegaPath-Nano_blob_master_docs_Usage.md)