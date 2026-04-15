---
name: genclust
description: Genclust is a genetic algorithm for clustering gene expression data. Use when user asks to group genes with similar expression patterns.
homepage: http://www.math.unipa.it/~lobosco/genclust/
metadata:
  docker_image: "quay.io/biocontainers/genclust:1.0--h470a237_0"
---

# genclust

genclust/
├── SKILL.md
└── references/
    └── anaconda_org_channels_bioconda_packages_genclust_overview.md
```

```md
name: genclust
description: |
  A genetic algorithm for clustering gene expression data. Use when you need to group genes with similar expression patterns based on experimental data. This tool is particularly useful for analyzing high-throughput gene expression datasets to identify co-regulated genes or functional modules.
---
## Overview

The `genclust` tool employs a genetic algorithm to cluster gene expression data. It's designed to identify groups of genes that exhibit similar expression profiles across different experimental conditions or time points. This is crucial for understanding gene function, identifying regulatory networks, and discovering biological pathways.

## Usage Instructions

`genclust` is a command-line tool. The primary input is a gene expression matrix, typically in a tab-separated format.

### Basic Usage

The most common way to run `genclust` is by providing an input data file and specifying the number of clusters.

```bash
genclust -i <input_data.txt> -o <output_prefix> -k <number_of_clusters>
```

- `-i <input_data.txt>`: Specifies the path to your gene expression data file. This file should contain genes as rows and samples/conditions as columns, with expression values.
- `-o <output_prefix>`: Sets a prefix for the output files. `genclust` will generate several output files, such as cluster assignments and representative profiles, all starting with this prefix.
- `-k <number_of_clusters>`: Defines the desired number of clusters to partition the genes into.

### Key Parameters and Options

*   **`-i` / `--input`**: (Required) Path to the input gene expression data file.
*   **`-o` / `--output`**: (Required) Prefix for output files.
*   **`-k` / `--clusters`**: (Required) Number of clusters to generate.
*   **`-p` / `--population`**: Controls the size of the population in the genetic algorithm. A larger population may lead to better results but increases computation time. Default is typically 100.
*   **`-g` / `--generations`**: Sets the number of generations for the genetic algorithm to run. More generations allow for more exploration of the solution space. Default is typically 500.
*   **`-m` / `--mutation`**: The mutation rate for the genetic algorithm. Controls the probability of random changes in the gene pool.
*   **`-c` / `--crossover`**: The crossover rate for the genetic algorithm. Controls the probability of combining genetic material from parent solutions.
*   **`-d` / `--distance`**: Specifies the distance metric used for clustering. Common options include `euclidean`, `pearson`, etc. Consult the tool's documentation for a full list.
*   **`-s` / `--seed`**: Sets a random seed for reproducibility.

### Example Workflow

1.  **Prepare your data**: Ensure your gene expression data is in a tab-separated file where rows are genes and columns are samples.
2.  **Run `genclust`**:
    ```bash
    genclust -i my_expression_data.tsv -o clustered_genes -k 10 -p 200 -g 1000
    ```
    This command will attempt to cluster your genes into 10 groups, using a population size of 200 and running for 1000 generations.
3.  **Analyze output**: Examine the files generated with the prefix `clustered_genes`. The primary output file will typically list each gene and its assigned cluster. Other files might provide representative expression profiles for each cluster.

### Expert Tips

*   **Experiment with `-k`**: The optimal number of clusters (`-k`) is often unknown beforehand. Try a range of values and evaluate the biological relevance of the resulting clusters.
*   **Tune GA parameters**: If initial results are not satisfactory, experiment with population size (`-p`), generations (`-g`), mutation rate (`-m`), and crossover rate (`-c`). Be mindful of increased computation time.
*   **Reproducibility**: Always use the `-s` or `--seed` option with a fixed integer value if you need to reproduce your clustering results.
*   **Data normalization**: Ensure your input expression data is properly normalized before running `genclust`. This tool assumes comparable expression values across samples.

## Reference documentation

- [Overview](./references/anaconda_org_channels_bioconda_packages_genclust_overview.md)