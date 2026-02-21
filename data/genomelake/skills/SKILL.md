---
name: genomelake
description: genomelake is a specialized library designed to provide high-performance, random-access retrieval of genomic data.
homepage: https://github.com/kundajelab/genomelake
---

# genomelake

## Overview

genomelake is a specialized library designed to provide high-performance, random-access retrieval of genomic data. It solves the bottleneck of reading large genomic files during deep learning model training by converting raw formats (FASTA, BigWig) into optimized data structures (using backends like TileDB). This allows researchers to efficiently pull DNA sequences or signal values for specific genomic coordinates (BED intervals) directly into NumPy arrays for use with frameworks like Keras or PyTorch.

## Data Preparation

Before extracting data, you must convert your raw genomic files into a genomelake data source.

### Converting FASTA to Genomelake
This creates a directory containing the optimized genome representation.

```python
from genomelake.backend import extract_fasta_to_file

genome_fasta = "path/to/genome.fa"
output_directory = "./hg38_genomelake"
extract_fasta_to_file(genome_fasta, output_directory)
```

## Data Extraction

The primary interface for retrieving data is the `ArrayExtractor`.

### Basic Extraction Workflow
1. Initialize the `ArrayExtractor` with your data source directory.
2. Pass a list of intervals (typically from `pybedtools`) to the extractor.

```python
import pybedtools
from genomelake.extractors import ArrayExtractor

# Load intervals
bt = pybedtools.BedTool('intervals.bed')
intervals = list(bt)

# Initialize extractor
extractor = ArrayExtractor("./hg38_genomelake")

# Extract data for a batch of intervals
# Returns a NumPy array of shape (batch_size, length, 4) for DNA
data_batch = extractor(intervals[:128])
```

### Handling BigWig Data
Genomelake can also extract continuous signal data from BigWig files.

```python
from genomelake.extractors import BigwigExtractor

# Extract signal from a BigWig data source
bw_extractor = BigwigExtractor("./bigwig_data_source")
signals = bw_extractor(intervals[:128])
```

## Expert Tips and Best Practices

- **Batching for Memory Efficiency**: Always use a generator to batch your intervals. Loading an entire chromosome's worth of sequences into memory at once will likely cause OOM (Out of Memory) errors.
- **Pre-processing**: The extraction to the genomelake format is a one-time cost. Perform this step once per genome/assembly and reuse the resulting directory across all experiments.
- **Coordinate Systems**: Ensure your BED intervals match the assembly used to create the genomelake data source (e.g., don't use hg19 intervals with an hg38 data source).
- **Missing Values**: When using `BigwigExtractor`, be aware that the tool typically converts NaNs in BigWig files to zeros by default to ensure compatibility with neural network inputs.
- **Multiprocessing**: While genomelake is efficient, when using it within a Keras `fit_generator` or PyTorch `DataLoader`, set `num_workers` or `workers` to leverage multiple CPUs for data extraction while the GPU handles the forward/backward pass.

## Reference documentation
- [genomelake GitHub Repository](./references/github_com_kundajelab_genomelake.md)
- [genomelake Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_genomelake_overview.md)