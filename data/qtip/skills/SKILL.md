---
name: qtip
description: Qtip (Quality Tool for Ion-torrent and Illumina Predictions) is an aligner-agnostic tool designed to fix the often-unreliable mapping quality (MAPQ) scores reported by standard read aligners.
homepage: https://github.com/BenLangmead/qtip
---

# qtip

## Overview

Qtip (Quality Tool for Ion-torrent and Illumina Predictions) is an aligner-agnostic tool designed to fix the often-unreliable mapping quality (MAPQ) scores reported by standard read aligners. It works by simulating "tandem" reads that mimic the characteristics of your input data, aligning them to the reference to see where the aligner fails, and training a machine learning model (Random Forest by default) to predict the true probability of a mapping error. Use this skill to generate more precise MAPQ scores, which are critical for downstream variant calling and genomic analysis.

## Core Usage Patterns

### Basic Execution
To run qtip, you must provide the reference genome, the input reads, and specify the aligner used.

```bash
qtip --ref genome.fa --index genome_index_prefix --aligner bowtie2 -U reads.fastq
```

### Paired-End Reads
For paired-end data, use `--m1` and `--m2`. Ensure the order of files matches between the two flags.

```bash
qtip --ref ref.fa --index idx --aligner bwa-mem --m1 R1.fq --m2 R2.fq
```

### Output Customization
By default, qtip emits SAM output. You can instruct it to include original and predicted MAPQ scores in custom tags.

*   `--write-orig-mapq`: Stores the aligner's original MAPQ in the `Zm:Z` tag.
*   `--write-precise-mapq`: Stores qtip's predicted MAPQ in the `Zp:Z` tag.

## Expert Tips and Best Practices

### Aligner Selection
Qtip supports specific aligners that have been modified to provide the necessary feature data. Specify the path to the executable if it is not in your PATH:
*   `--bt2-exe`: Path to Bowtie 2.
*   `--bwa-exe`: Path to BWA-MEM.
*   `--snap-exe`: Path to SNAP.

### Model Tuning
If the default Random Forest model is not performing optimally, you can switch the model family or adjust the forest size:
*   `--model-family`: Choose between `RandomForest` (default), `ExtraTrees`, or `GradientBoosting`.
*   `--num-trees`: Increase the number of trees (e.g., `--num-trees 50,100`) for potentially better accuracy at the cost of runtime.

### Simulation Control
The accuracy of the model depends on the tandem simulation.
*   **Simulation Size**: Use `--sim-factor` to adjust the number of simulated reads. The default is `45.0` (multiplied by the square root of input reads).
*   **Wiggle Room**: Use `--wiggle` (default 30) to define the distance (in bp) from the true origin that is still considered a "correct" alignment during training.

### Performance and Memory
*   **Subsampling**: For very large datasets, use `--input-model-size` (default 30,000) to limit the number of templates used for building the model.
*   **Temporary Files**: Qtip generates many intermediate files. Use `--temp-directory` to point to a high-speed scratch disk and `--keep-intermediates` only if debugging.

## Reference documentation
- [Qtip GitHub Repository](./references/github_com_BenLangmead_qtip.md)
- [Bioconda Qtip Overview](./references/anaconda_org_channels_bioconda_packages_qtip_overview.md)