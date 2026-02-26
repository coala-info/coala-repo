---
name: mercat2
description: MerCat2 is a k-mer counter and diversity estimator that performs database-independent property analysis for multi-omic datasets. Use when user asks to count k-mers, estimate sequence diversity, calculate physicochemical properties of proteins, or perform PCA on metagenomic and proteomic data.
homepage: https://github.com/raw-lab/mercat2
---


# mercat2

## Overview

MerCat2 is a versatile k-mer counter and diversity estimator designed for multi-omic analysis. It performs Database Independent Property Analysis (DIPA), allowing for the characterization of metagenomic, metatranscriptomic, and proteomic datasets based on their k-mer composition rather than alignment to reference databases. It is particularly effective for identifying functional or structural properties of sequences, such as GC content for nucleotides or hydrophobicity and molecular weight for proteins.

## Usage Instructions

### Basic Command Structure
The primary script is `mercat2.py`. It requires an input (file or folder) and a k-mer length.

```bash
mercat2.py -i <input_file> -k <kmer_length> [options]
```

### Common CLI Patterns

**1. Analyzing Protein Sequences (.faa)**
For amino acid files, MerCat2 calculates k-mer counts along with pI, Molecular Weight, and Hydrophobicity metrics.
```bash
mercat2.py -i sample.faa -k 3 -c 10
```

**2. Analyzing Nucleotide Sequences (.fa, .fna, .fasta)**
For nucleotide files, it calculates k-mer counts and GC content.
```bash
mercat2.py -i sample.fna -k 4 -n 8
```

**3. Processing Raw Reads (.fastq)**
When provided with FASTQ files, MerCat2 automatically performs quality trimming (via fastp/fastqc) before k-mer counting.
```bash
mercat2.py -i sample.fastq -k 3 -skipclean  # Use -skipclean if already trimmed
```

**4. Batch Processing and Visualization**
To process an entire directory and generate an interactive PCA plot (requires at least 4 samples):
```bash
mercat2.py -f /path/to/inputs -k 3 -pca -o results_dir
```

### Functional Annotation Options
MerCat2 can call Open Reading Frames (ORFs) before counting k-mers:
*   **-prod**: Runs Prodigal (optimized for bacteria/archaea).
*   **-fgs**: Runs FragGeneScanRS (optimized for eukaryotes or general applications).

```bash
mercat2.py -i contigs.fasta -k 3 -prod
```

### Memory and Performance Optimization
K-mer counting is memory-intensive, especially as `k` increases.
*   **Chunking (-s)**: Split large files into smaller chunks (e.g., `-s 100` for 100MB chunks) to process data within RAM limits. Note: Very small chunks (<1MB) may lose rare k-mers.
*   **Cores (-n)**: Specify the number of CPUs. Reducing this can also lower peak memory usage.
*   **Low Memory Flag (-lowmem)**: Use incremental PCA if system memory is constrained.

### Output Interpretation
Results are saved in the specified output folder (default: `mercat_results`):
*   **report/**: Contains `report.html` with interactive Plotly figures and PCA plots.
*   **tsv/**: Contains tab-separated tables of k-mer counts and physicochemical properties.
*   **prodigal/ / fgs/**: Contains predicted amino acid files if ORF calling was enabled.

## Expert Tips
*   **K-mer Selection**: For most DIPA applications on proteins, a k-mer length of 3 is standard. For nucleotides, k=4 is a common starting point.
*   **Input Detection**: MerCat2 relies on file extensions. Ensure your files end in `.faa` for proteins or `.fna`/`.fasta`/`.fastq` for nucleotides to trigger the correct processing logic.
*   **Diversity Metrics**: While MerCat2 provides various Alpha (Shannon, Simpson, Chao1) and Beta (Bray-Curtis, Jaccard, Euclidean) diversity metrics, these are currently experimental.
*   **Case Sensitivity**: Use the `-toupper` flag if your input sequences contain mixed-case characters to ensure consistent k-mer counting.

## Reference documentation
- [MerCat2 GitHub README](./references/github_com_raw-lab_mercat2.md)
- [MerCat2 Wiki](./references/github_com_raw-lab_mercat2_wiki.md)