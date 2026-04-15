---
name: segway
description: Segway is a genomic segmentation tool that uses Dynamic Bayesian Networks to transform multiple tracks of functional genomics data into discrete annotations. Use when user asks to train a model on chromatin data, identify genomic segments like enhancers or promoters, or calculate posterior probabilities for label assignments.
homepage: http://segway.hoffmanlab.org/
metadata:
  docker_image: "quay.io/biocontainers/segway:3.0.4--pyh7cba7a3_1"
---

# segway

## Overview

Segway is a genomic segmentation tool that utilizes Dynamic Bayesian Networks (DBNs) to transform multiple tracks of continuous functional genomics data into discrete, interpretable annotations. Unlike many other methods, Segway can operate at 1-bp resolution and handles heterogeneous patterns of missing data effectively. It is primarily used to identify recurring patterns in chromatin structure—such as enhancers, promoters, and repressed regions—across the genome.

## Core Workflow

The Segway workflow typically follows a three-step process: data preparation (via Genomedata), model training, and segment identification.

### 1. Training the Model
Training discovers patterns in your data. Because DBN training can be sensitive to initial conditions, it is standard practice to run multiple "instances" with different random seeds.

```bash
# Basic training with 10 labels and 10 random starts
segway train --num-labels=10 --num-instances=10 <input.genomedata> <traindir>
```

### 2. Identifying Segments
Once trained, use the best parameters to annotate the genome.

```bash
# Generate the segmentation (Viterbi decoding)
segway identify <input.genomedata> <traindir> <identifydir>
```

### 3. Posterior Probabilities (Optional)
To see the confidence or "soft" assignment of labels at each position:

```bash
segway posterior <input.genomedata> <traindir> <posteriordir>
```

## Command-Line Best Practices

### Data Selection and Filtering
*   **Track Subset**: Use `--track` multiple times to limit the analysis to specific signals.
    `segway train --track H3K4me3 --track H3K27ac ...`
*   **Region Filtering**: Use `--include-coords` or `--exclude-coords` with BED files to focus training on specific regions (e.g., ENCODE pilot regions) or mask out repetitive elements/blacklisted regions.
*   **Minibatch Training**: For large genomes, use `--minibatch-fraction=0.01` to speed up training iterations by using a random subset of the genome for each round.

### Performance and Resolution
*   **Resolution**: Use `--resolution=<bp>` (e.g., 10 or 100) to downsample data for faster processing. **Warning**: You must use the same resolution for both `train` and `identify`.
*   **Local Execution**: Force local execution on a single machine by setting the environment variable:
    `SEGWAY_CLUSTER=local segway train ...`
*   **Parallelism**: Control local concurrency with `SEGWAY_NUM_LOCAL_JOBS`.

### Model Customization
*   **Label Count**: If the resulting segmentation is too granular, decrease `--num-labels`. If distinct biological states are merged, increase it.
*   **Mixture Components**: Increase Gaussian mixture components for complex signal distributions:
    `--mixture-components=3`
*   **Validation**: Use `--validation-fraction=0.05` to hold out data and select the parameter set that maximizes likelihood on unseen data.

## Interpreting Results

*   **segway.bed.gz**: The standard BED file where each line is a segment. Best for computational analysis.
*   **segway.layered.bed.gz**: A "layered" BED file designed for genome browsers (UCSC/Ensembl). It uses thick/thin lines to represent segment presence, making it easier to visualize multiple labels simultaneously.
*   **Mnemonics**: Segway labels are initially numeric (0, 1, 2...). You must typically correlate these with known biological markers (e.g., Label 5 is high in H3K4me3, suggesting it represents a TSS).



## Subcommands

| Command | Description |
|---------|-------------|
| segway annotate | Annotates genomic data using a trained model. |
| segway posterior | Compute posterior probabilities for Segway segmentation. |
| segway train | Train a Segway model. |

## Reference documentation
- [Quickstart Guide](./references/segway_hoffmanlab_org_doc_3.0.4_quick.html.md)
- [Segway 3.0.4 Overview](./references/segway_hoffmanlab_org_doc_3.0.4_segway.html.md)
- [Mnemonic Assignments Example](./references/segway_hoffmanlab_org_2011_mnemonics.20110125.tab.md)