---
name: stream_atac
description: stream_atac is a preprocessing utility that converts sparse scATAC-seq peak data into a dense feature space suitable for trajectory reconstruction.
homepage: https://github.com/pinellolab/STREAM_atac
---

# stream_atac

## Overview

stream_atac is a preprocessing utility that converts sparse scATAC-seq peak data into a dense feature space suitable for trajectory reconstruction. By calculating z-scores for DNA k-mers or known transcription factor motifs, it provides a robust representation of chromatin accessibility changes across cells. This tool handles various input formats, including standard triplet files and 10X Genomics CellRanger outputs, and supports multiple reference genomes.

## Installation and Setup

Install the tool via Bioconda to ensure all dependencies (Python 3 and bioinformatics libraries) are correctly managed:

```bash
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda create -n stream_env python stream_atac
conda activate stream_env
```

## Command Line Usage

### Standard Input (Triplet Format)
To process data where the count file is a tab-delimited triplet (region index, sample index, count):

```bash
stream_atac -c count_file.tsv.gz -r region_file.bed.gz -s sample_file.tsv.gz -g hg19 -f kmer -k 7 --n_jobs 4 -o output_dir
```

### 10X Genomics Data
When working with filtered peak BC matrices from CellRanger, specify the `mtx` format:

```bash
stream_atac -c ./matrix.mtx -r ./peaks.bed -s ./barcodes.tsv --file_format mtx -g hg38 -f motif --n_jobs 8 -o stream_output
```

## Key Parameters and Best Practices

- **Feature Selection (`-f`)**: 
  - Use `kmer` for unbiased discovery of accessibility patterns (default length `k=7`).
  - Use `motif` to project data onto known transcription factor binding profiles.
- **Genome Support (`-g`)**: Ensure the genome matches your alignment. Supported options are `mm9`, `mm10`, `hg19`, and `hg38`.
- **Peak Resizing**: If peaks have inconsistent widths, use `--resize_peak` and `--peak_width` (e.g., 500) to standardize the genomic windows before feature extraction.
- **Performance**: Always set `--n_jobs` to the number of available CPU cores to significantly speed up the k-mer counting and z-score calculation process.
- **Input Requirements**:
  - **Count File**: 1-based indexing for regions and samples.
  - **Region File**: BED format (Chromosome, Start, End). The order must match the indices in the count file.
  - **Sample File**: A single column of cell identifiers matching the indices in the count file.

## Python Integration

For integration into larger computational pipelines, import the preprocessing function directly:

```python
import stream_atac
adata = stream_atac.preprocess_atac(
    file_count='matrix.mtx',
    file_region='peaks.bed',
    file_sample='barcodes.tsv',
    genome='hg38',
    feature='kmer',
    file_format='mtx',
    n_jobs=4,
    workdir='./output'
)
```

## Output Files

The tool generates three primary files in the output folder:
1. `zscores.tsv.gz`: Raw z-scores for the selected features.
2. `zscores_scaled.tsv.gz`: Scaled z-scores, recommended for immediate use in STREAM trajectory analysis.
3. `adata.h5ad`: An AnnData object containing the processed data, compatible with the `stream` Python package.

## Reference documentation
- [STREAM_atac GitHub Repository](./references/github_com_pinellolab_STREAM_atac.md)
- [stream_atac Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_stream_atac_overview.md)