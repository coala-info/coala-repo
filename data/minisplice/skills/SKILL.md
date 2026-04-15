---
name: minisplice
description: minisplice evaluates the probability of potential splice sites using a convolutional neural network to improve the accuracy of genomic alignments. Use when user asks to predict splice site scores, train custom splice signal models, or calibrate models for specific organisms.
homepage: https://github.com/lh3/minisplice
metadata:
  docker_image: "quay.io/biocontainers/minisplice:0.4--h577a1d6_0"
---

# minisplice

## Overview

minisplice is a specialized genomic utility designed to enhance the accuracy of protein-to-genome and RNA-to-genome alignments. By employing a 1D convolutional neural network (1D-CNN), it evaluates the probability of potential splice sites being biologically active. The tool outputs 2log2-scaled odds ratios, which represent the likelihood of a site being a real donor or acceptor relative to a null model. These scores are particularly valuable when working with distant homologs where standard splice signal models lose predictive power.

## Core Workflows

### Predicting Splice Scores
To generate splice scores for a target genome using a pre-trained model (e.g., for vertebrates or insects):

```bash
./minisplice predict -t 16 -c model.kan.cali model.kan genome.fa.gz > scores.tsv
```

*   **-t**: Number of threads.
*   **-c**: Path to the calibration file (translates raw model output to empirical probability).
*   **Output**: A TSV containing contig, offset, strand, type (D/A), and the score.

### Training a Custom Model
If pre-trained models are unsuitable for your target organism, follow this sequence:

1.  **Prepare Training Data**: Convert GTF/GFF3 to BED12 (using `minigff.js`) and generate training sequences.
    ```bash
    ./minisplice gentrain anno-long.bed.gz genome-odd.fa.gz | gzip > train.txt.gz
    ```
2.  **Train the CNN**:
    ```bash
    ./minisplice train -t 16 -o model.kan train.txt.gz
    ```
3.  **Calibrate the Model**: Use a separate set of chromosomes (e.g., even) to compute empirical odds-ratio scores.
    ```bash
    ./minisplice predict -t 16 -b anno-all.bed.gz model.kan genome-even.fa.gz > model.cali
    ```

### Integration with Aligners
The generated `scores.tsv` can be passed directly to compatible aligners to resolve ambiguous junctions:

*   **miniprot**: `miniprot --spsc=scores.tsv genome.fa proteins.faa > align.gff`
*   **minimap2**: `minimap2 -cxsplice:hq --spsc=scores.tsv genome.fa rna-seq.fq > align.paf`

## Expert Tips and Best Practices

*   **Model/Cali Pairing**: Ensure the `.kan` (model) and `.cali` (calibration) files match. Recent versions of minisplice attempt to load the `.cali` file automatically if it shares the same base name as the model file.
*   **Data Partitioning**: For robust training, always train on one set of chromosomes (e.g., odd) and calibrate on another (e.g., even) to avoid over-fitting the splice scores.
*   **Score Filtering**: minisplice (v0.4+) suppresses scores of -6 or lower by default. This significantly reduces file size (approx. 30%) without impacting the accuracy of downstream tools like miniprot.
*   **Multi-Species Training**: You can combine training data from multiple distantly related species by concatenating `gentrain` outputs before running the `train` command. Use `script/merge-cali.js` to combine the resulting calibration files.



## Subcommands

| Command | Description |
|---------|-------------|
| minisplice gentrain | Generate training data for minisplice |
| minisplice predict | Predict splice sites |
| minisplice_train | Train a model for minisplice |

## Reference documentation
- [minisplice README](./references/github_com_lh3_minisplice_blob_master_README.md)
- [minisplice NEWS](./references/github_com_lh3_minisplice_blob_master_NEWS.md)