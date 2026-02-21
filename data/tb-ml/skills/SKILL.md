---
name: tb-ml
description: The `tb-ml` tool provides a unified framework for predicting antimicrobial resistance in *M.
homepage: https://github.com/jodyphelan/tb-ml
---

# tb-ml

## Overview
The `tb-ml` tool provides a unified framework for predicting antimicrobial resistance in *M. tuberculosis* from Whole Genome Sequencing (WGS) data. It addresses the lack of reproducibility in TB machine learning by enforcing a standardized interface for Docker containers. By using `tb-ml`, researchers can easily swap different pre-processing methods (like variant calling or one-hot encoding) and prediction models (neural networks, random forests, etc.) to perform systematic comparisons or clinical predictions.

## Core CLI Usage
The `tb-ml` command operates by taking an arbitrary number of Docker containers and their associated arguments, executing them in the order they are defined.

### Basic Syntax
```bash
tb-ml --container <docker_image_name> "<arguments_for_container>"
```

### Chaining Multiple Containers
To build a pipeline, repeat the `--container` flag. Data is passed between containers via files written to the local working directory.

```bash
tb-ml \
  --container <image_1> "<args_to_produce_file_A>" \
  --container <image_2> "<args_using_file_A_to_produce_file_B>" \
  --container <image_3> "<args_using_file_B>"
```

## Standard Workflow Example
A typical TB-ML pipeline involves identifying target genomic loci, extracting features from raw reads, and running the prediction model.

1. **Identify Loci**: Query the prediction container for the specific genomic regions it requires.
2. **Pre-process**: Use a processing container to extract sequences or variants from FASTQ/BAM files based on those loci.
3. **Predict**: Feed the processed features into the prediction container.

**Example Command:**
```bash
# Define images
PROC_CONT="julibeg/tb-ml-one-hot-encoded-seqs-from-raw-reads:v0.2.0"
PRED_CONT="julibeg/tb-ml-neural-net-from-one-hot-encoded-seqs-13-drugs:v0.7.0"

# Execute pipeline
tb-ml \
  --container $PRED_CONT "--get-target-loci -o target-loci.csv" \
  --container $PROC_CONT "-r target-loci.csv -o features.csv read1.fastq.gz read2.fastq.gz" \
  --container $PRED_CONT "features.csv"
```

## Container Integration Best Practices
When selecting or building containers for use with `tb-ml`, adhere to these functional standards:

*   **Output Handling**: 
    *   Any data intended for the **final report** or user visibility must be printed to `STDOUT`.
    *   Any data intended for **downstream containers** must be written to a file (ideally in CSV format).
*   **Separation of Concerns**: Prediction containers should strictly perform inference. They should not perform raw genomic pre-processing (e.g., mapping or variant calling) internally.
*   **Metadata Methods**: Prediction containers should implement helper flags (like `--get-target-loci` or `--get-variants`) to export the feature schema required for their models.
*   **Docker Environment**: Ensure Docker is configured to run without `sudo` privileges, as `tb-ml` interacts with the Docker API directly.

## Reference documentation
- [tb-ml GitHub Repository](./references/github_com_jodyphelan_tb-ml.md)
- [tb-ml Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tb-ml_overview.md)