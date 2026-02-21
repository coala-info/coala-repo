---
name: hulk
description: HULK is a specialized bioinformatics tool designed to generate fixed-size "histosketches" from microbiome sequencing data.
homepage: https://github.com/will-rowe/hulk
---

# hulk

## Overview

HULK is a specialized bioinformatics tool designed to generate fixed-size "histosketches" from microbiome sequencing data. It is optimized for speed and low memory usage, making it ideal for processing large metagenomic datasets or real-time data streams. By approximating k-mer spectra using minimizers and jump hashing, HULK allows for rapid similarity searches and dissimilarity analysis without the computational overhead of full k-mer counting.

## Installation

The most efficient way to install HULK is via Bioconda:

```bash
conda install -c bioconda hulk
```

For the latest version (>=1.0.0), ensure you are using the updated repository logic which outputs sketches in JSON format.

## Core Workflows

### 1. Sketching Samples
The `sketch` command processes sequencing data (FASTQ) to create a compact representation. HULK is designed to work with data streams.

**Basic Sketching:**
```bash
# Process a gzipped FASTQ file via STDIN
gunzip -c sample.fq.gz | hulk sketch -o sketches/sample_output
```

**Key Parameters for Sketching:**
- `-o`: Specify the output prefix (HULK will create a `.json` file).
- HULK 1.0.0+ automatically determines spectrum size based on k-mer size; user configuration of Epsilon and Delta is no longer required.

### 2. Comparing Sketches (Smashing)
The `smash` command calculates the similarity between multiple sketches and generates a distance matrix.

**Generate Similarity Matrix:**
```bash
hulk smash -k 31 -m weightedjaccard -d ./sketches_dir -o similarity_matrix.csv
```

**Key Parameters for Smashing:**
- `-k`: K-mer size (must match the size used during sketching).
- `-m`: Metric to use (e.g., `weightedjaccard`).
- `-d`: Directory containing the `.json` sketches to compare.
- `-o`: Output filename for the resulting CSV matrix.

## Expert Tips and Best Practices

- **Streaming Efficiency**: Always prefer piping data into `hulk sketch` (e.g., using `cat` or `gunzip -c`). This avoids writing large intermediate files and leverages HULK's streaming architecture.
- **K-mer Selection**: While k=31 is a common default for metagenomics, ensure consistency across your entire project. You cannot "smash" sketches that were created with different k-mer sizes.
- **Output Handling**: In version 1.0.0+, HULK outputs sketches in JSON format by default, similar to `sourmash`. This makes the sketches highly portable and human-readable for debugging.
- **Machine Learning Integration**: HULK sketches are fixed-size vectors. This makes them directly compatible as input features for Machine Learning classifiers (like BANNER) to predict sample origins or phenotypes.
- **Memory Management**: HULK is designed to run on standard laptops. If processing extremely high-depth samples, the fixed-size array and jump-hash approach will maintain a stable memory footprint compared to traditional k-mer counters.

## Reference documentation
- [HULK Main Repository and Usage](./references/github_com_will-rowe_hulk.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hulk_overview.md)