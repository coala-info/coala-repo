---
name: blobtoolkit
description: BlobToolKit is a suite for the interactive quality assessment and visualization of genome assemblies to identify contaminants and evaluate completeness. Use when user asks to create or populate BlobDirs, add BUSCO or coverage data to an assembly, filter contigs based on metadata, or generate assembly plots and visualizations.
homepage: https://github.com/blobtoolkit/blobtoolkit
---


# blobtoolkit

## Overview
BlobToolKit is a specialized suite for the interactive quality assessment of genome assemblies. It allows researchers to visualize assembly statistics, taxonomic assignments, and read coverage simultaneously to identify potential contaminants or evaluate assembly completeness. This skill facilitates the command-line workflow for managing "BlobDirs"—the standard file-based data structure used by the toolkit—and executing filtering or visualization tasks.

## Core CLI Patterns

### Environment Setup
The recommended environment uses Python 3.9.
```bash
conda create -y -n btk -c conda-forge python=3.9
conda activate btk
pip install "blobtoolkit[full]"
```

### Creating and Populating a BlobDir
BlobToolKit operates on a directory (BlobDir) containing JSON files.
- **Initialize a BlobDir**: Use `blobtools create` with an assembly FASTA.
- **Add Data**: Use `blobtools add` to incorporate external analysis results.
  - **BUSCO**: `blobtools add --busco full_table.tsv BlobDir`
  - **Coverage**: `blobtools add --cov mapping.bam BlobDir`
  - **Hits (BLAST/Diamond)**: `blobtools add --hits results.tab --taxrule bestsumorder --taxdump ./taxdump BlobDir`

### Filtering and Extraction
Filter contigs based on variables (length, GC, coverage) or categories (taxonomic assignment).
- **Generate a filtered table**:
  ```bash
  blobtools filter --param length--Min=1000000 --table output.tsv /path/to/BlobDir
  ```
- **Create a new filtered BlobDir**:
  ```bash
  blobtools filter --param GC--Max=0.5 --output Filtered_BlobDir /path/to/BlobDir
  ```

### Visualization
Generate plots or launch the interactive viewer.
- **Start Local Viewer**: `blobtools view --local BlobDir` (Access via the URL provided in output).
- **Generate Static Snail Plot**:
  ```bash
  blobtools view --view snail --host https://blobtoolkit.genomehubs.org <dataset_id>
  ```
- **Browser Selection**: Use `--driver chromium` if Firefox is not the preferred system driver.

## Expert Tips
- **Data Structure**: A valid BlobDir must contain a `meta.json`. If commands fail, ensure this file exists and is not corrupted.
- **Headless Environments**: When running `blobtools view` on a server to generate images, ensure a web driver (geckodriver/chromedriver) and a display server (like Xvfb or Xquartz on macOS) are available.
- **Memory Management**: For large assemblies, use the `sanger-tol/blobtoolkit` Nextflow pipeline for the initial compute-heavy steps (BLAST/mapping) before using the CLI for downstream filtering and visualization.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_genomehubs_blobtoolkit.md)
- [BlobToolKit Wiki and Getting Started](./references/github_com_genomehubs_blobtoolkit_wiki.md)