---
name: kwip
description: "kwip calculates genetic dissimilarity between samples using k-mer weighted inner products from raw sequencing reads. Use when user asks to calculate genetic dissimilarity between samples without a reference genome."
homepage: https://github.com/kdmurray91/kWIP
---


# kwip

kwip/SKILL.md
---
name: kwip
description: |
  Implements a de novo, alignment-free measure of sample genetic dissimilarity using k-mer weighted inner products. Use when you need to calculate genetic dissimilarity between samples from raw sequencing reads without a reference genome or assembly. This is particularly useful for population genetics and comparative genomics where reference genomes are unavailable or unreliable.
---
## Overview

The kWIP tool provides a method for estimating genetic dissimilarity between samples directly from raw sequencing reads. It operates without requiring a reference genome or performing sequence assembly, making it valuable for de novo analyses. kWIP achieves this by decomposing reads into k-mers, hashing them, and then calculating pairwise distances based on these hashes, with a weighting scheme to emphasize informative k-mers and downplay erroneous ones.

## Usage Instructions

kWIP operates by processing sequencing reads to generate a distance matrix between samples. The core functionality involves decomposing reads into k-mers, hashing them, and then calculating a weighted inner product to quantify dissimilarity.

### Core Command Structure

The general command structure for `kwip` involves specifying input files and output options.

```bash
kwip <input_files> -o <output_file> [options]
```

### Input Files

*   **FASTQ/FASTA:** `kwip` accepts compressed or uncompressed FASTQ or FASTA files as input. Multiple files can be provided for a single sample.
*   **Sample Naming:** It's crucial to associate input files with sample names. This is typically handled by providing files in a structured manner or using specific command-line arguments if supported by the tool's interface (though the provided documentation focuses on direct file input).

### Key Options and Parameters

*   **`-o <output_file>` / `--output <output_file>`:** Specifies the output file path for the distance matrix. The output is typically a tab-separated file.
*   **`--ksize <int>`:** Sets the k-mer size. The default is usually 31, but this can be adjusted based on the dataset and research question. Larger k-mer sizes can capture longer-range similarities but may be more sensitive to sequencing errors.
*   **`--num-hashes <int>`:** Determines the number of hash functions to use. More hashes can lead to more accurate dissimilarity estimates but increase computational cost.
*   **`--min-count <int>`:** Filters out k-mers that appear fewer than this number of times within a sample. This helps to remove sequencing errors and very rare k-mers.
*   **`--max-count <int>`:** Filters out k-mers that appear more than this number of times within a sample. This helps to mitigate the impact of highly repetitive sequences or over-represented k-mers.
*   **`--threads <int>`:** Specifies the number of threads to use for parallel processing, significantly speeding up computation on multi-core systems.

### Workflow Example

1.  **Prepare Input Files:** Ensure your sequencing reads are in FASTQ or FASTA format. For multiple samples, organize them logically. For example:
    *   `sample1_R1.fastq.gz`
    *   `sample1_R2.fastq.gz`
    *   `sample2_R1.fastq.gz`
    *   `sample2_R2.fastq.gz`

2.  **Run kWIP:** Execute the `kwip` command, specifying input files and desired options.

    ```bash
    kwip sample1_R1.fastq.gz sample1_R2.fastq.gz sample2_R1.fastq.gz sample2_R2.fastq.gz -o distance_matrix.tsv --ksize 31 --num-hashes 1000 --min-count 2 --threads 8
    ```

    This command will:
    *   Process all four input files.
    *   Generate a distance matrix saved to `distance_matrix.tsv`.
    *   Use k-mers of size 31.
    *   Employ 1000 hash functions.
    *   Ignore k-mers appearing less than 2 times or more than a default maximum count.
    *   Utilize 8 threads for computation.

### Output Interpretation

The output file (`distance_matrix.tsv`) will typically be a square matrix where rows and columns represent samples. The values in the matrix indicate the calculated genetic dissimilarity between pairs of samples. Lower values suggest higher genetic similarity, while higher values indicate greater dissimilarity. This matrix can then be used with downstream tools for clustering, principal component analysis (PCA), or other visualization and analytical methods.

## Expert Tips

*   **k-mer Size Selection:** The optimal `ksize` depends on the organism and the nature of the genetic variation you are investigating. Experiment with different `ksize` values (e.g., 21, 31, 51) to see how it affects your results. Smaller k-mers are more sensitive to single nucleotide polymorphisms (SNPs), while larger k-mers can capture structural variations.
*   **Filtering Parameters (`--min-count`, `--max-count`):** Carefully tune `--min-count` and `--max-count` to remove noise without discarding biologically relevant k-mers. A `--min-count` of 2 or 3 is common for removing sequencing errors. Adjusting `--max-count` can be important for highly repetitive genomes.
*   **Computational Resources:** `kwip` can be computationally intensive, especially with large datasets and high k-mer counts. Utilize the `--threads` option to leverage multi-core processors effectively. For very large datasets, consider running `kwip` on a high-performance computing cluster.
*   **Downstream Analysis:** The output distance matrix is compatible with most standard bioinformatics tools for phylogenetic analysis, population structure analysis (e.g., using R packages like `ape`, `vegan`, or Python libraries like `scikit-learn` for PCA).

## Reference documentation
- [Overview of kWIP](./references/anaconda_org_channels_bioconda_packages_kwip_overview.md)
- [kWIP GitHub Repository](./references/github_com_kdm9_kWIP.md)