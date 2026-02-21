---
name: mmlong2
description: `mmlong2` is a comprehensive Snakemake-based pipeline designed to transform raw long-read metagenomic data into analyzed, high-quality metagenome-assembled genomes (MAGs).
homepage: https://github.com/Serka-M/mmlong2
---

# mmlong2

## Overview
`mmlong2` is a comprehensive Snakemake-based pipeline designed to transform raw long-read metagenomic data into analyzed, high-quality metagenome-assembled genomes (MAGs). It automates the entire process from assembly and misassembly curation to binning and taxonomic classification. The tool is specifically optimized for complex microbial communities and includes specialized features like circular genome extraction and eukaryotic contig removal, making it a robust choice for researchers working with Oxford Nanopore or PacBio HiFi data.

## Core CLI Usage

### Initial Setup
Before running the workflow for the first time, you must install the necessary taxonomic and annotation databases.
```bash
mmlong2 --install_databases --database_dir /path/to/db_folder
```

### Basic Execution Patterns
The workflow requires specifying the read type (Nanopore or PacBio) and an output directory.

**Nanopore Reads (using metaFlye default):**
```bash
mmlong2 -np reads.fastq.gz -o output_dir -p 16
```

**PacBio HiFi Reads (using metaMDBG):**
```bash
mmlong2 -pb reads.fastq.gz -o output_dir -p 16 -dbg
```

### Execution Control
You can limit the workflow to specific stages using the `-run` flag. Common stages include: `assembly`, `curation`, `filtering`, `binning`, `taxonomy`, `annotation`, and `extraqc`.
```bash
# Run only until binning is complete
mmlong2 -np reads.fastq.gz -o output_dir -run binning
```

## Expert Tips and Best Practices

### Assembler Selection
*   **metaFlye (`-fly`)**: The default assembler, generally robust for most Nanopore datasets.
*   **metaMDBG (`-dbg`)**: Highly recommended for PacBio HiFi data due to its efficiency and performance.
*   **myloasm (`-myl`)**: A specialized option for high-complexity samples or specific assembly needs.

### Improving MAG Recovery
*   **Binning Modes**: Use `-bin extended` for an iterative ensemble binning strategy that maximizes the recovery of prokaryotic genomes, though it increases computation time.
*   **Differential Coverage**: If you have multiple related datasets, use the `-cov` flag to provide a CSV of additional reads to improve binning resolution.
    ```bash
    mmlong2 -np sample1.fq.gz -cov NP,/path/to/sample2.fq.gz -o output_dir
    ```
*   **Polishing**: For Nanopore data, always consider enabling Medaka polishing with `-med` to improve consensus accuracy. Ensure the correct model is selected with `-mm`.

### Resource Management
*   **Threading**: Always specify the number of processes with `-p` to match your hardware capabilities.
*   **Temporary Files**: Metagenomic assembly is IO-intensive. Use `-tmp` to point to a fast local SSD (e.g., `/scratch` or `$TMPDIR`) to speed up processing.
*   **Cleanup**: By default, the workflow keeps intermediate files. Use `-scl` (skip cleanup) if you need to manually inspect intermediate steps, or omit it to save disk space in production runs.

### Quality and Classification
*   **Contig Length**: The default minimum contig length for binning is 3000bp (`-mcl 3000`). Increase this for cleaner bins if you have high-depth data.
*   **Eukaryotic Filtering**: The tool uses Tiara by default to remove eukaryotic contamination. If you prefer Whokaryote, use the `-who` flag.

## Reference documentation
- [mmlong2 GitHub Repository](./references/github_com_Serka-M_mmlong2.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_mmlong2_overview.md)