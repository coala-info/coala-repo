---
name: minisplice
description: "minisplice scores canonical splice sites using a convolutional neural network to improve the accuracy of spliced alignments. Use when user asks to predict splice site scores, train custom splice site models, or refine alignments for miniprot and minimap2."
homepage: https://github.com/lh3/minisplice
---


# minisplice

## Overview
minisplice is a specialized tool designed to improve the accuracy of spliced alignments by scoring canonical donor (GT) and acceptor (AG) splice sites. It employs a 1D convolutional neural network (1D-CNN) to estimate the odds-ratio scores of these sites. This is particularly valuable when working with distant homologs where standard alignment heuristics often fail to resolve ambiguous splice junctions. The tool is designed to work as a pre-processor for aligners like `miniprot` and `minimap2`.

## Installation
The easiest way to install minisplice is via Bioconda:
```bash
conda install bioconda::minisplice
```

## Prediction with Pre-trained Models
If your target genome is a vertebrate or insect, use the pre-trained models (e.g., `vi2-7k`) to save time.

1. **Run Prediction**:
   ```bash
   minisplice predict -t 16 -c vi2-7k.kan.cali vi2-7k.kan genome.fa.gz > score.tsv
   ```
   *   `-t`: Number of threads.
   *   `-c`: Calibration data file (translates model output to empirical probability).
   *   `.kan`: The pre-trained model file.

2. **Output Format**:
   The resulting TSV contains: `contig`, `offset`, `strand`, `type` (D for donor, A for acceptor), and the `score` (2log2-scaled odds ratio).

## Integration with Aligners
Once you have generated a `score.tsv`, pass it to your aligner to refine the results.

### Using with miniprot (v0.16+)
```bash
miniprot -Iut16 --gff -j2 --spsc=score.tsv genome.fa.gz proteins.faa > align.gff
```

### Using with minimap2 (r1285+)
```bash
minimap2 -cxsplice:hq -t16 --spsc=score.tsv genome.fa.gz rna-seq.fq > align.paf
```

## Custom Model Training Workflow
If pre-trained models are unsuitable for your species, you can train a custom model using annotated data.

1. **Prepare Training Data**:
   Convert GFF3/GTF to BED12 (using `minigff`) and generate training sequences:
   ```bash
   minisplice gentrain anno-long.bed.gz genome-odd.fa.gz | gzip > train.txt.gz
   ```

2. **Train the Model**:
   ```bash
   minisplice train -t 16 -o model.kan train.txt.gz
   ```

3. **Calibrate the Model**:
   Compute empirical odds-ratio scores using a separate set of chromosomes (e.g., even chromosomes):
   ```bash
   minisplice predict -t 16 -b anno-all.bed.gz model.kan genome-even.fa.gz > model.cali
   ```

4. **Final Prediction**:
   Use the new model and calibration file on your target genome:
   ```bash
   minisplice predict -t 16 -c model.cali model.kan genome.fa.gz > score.tsv
   ```

## Expert Tips
*   **Data Splitting**: For the most robust custom models, train on "odd" chromosomes and calibrate on "even" chromosomes to avoid overfitting.
*   **Version Sensitivity**: Ensure you are using `miniprot` v0.16 or later; earlier versions supporting the `--spsc` flag may trigger assertion failures.
*   **Multi-Species Training**: You can combine training data from multiple distantly related species by concatenating the `gentrain` outputs before running the `train` command.
*   **Subsampling**: If training on multiple large genomes, subsample the training data to reduce computation time without significantly impacting model power.

## Reference documentation
- [minisplice GitHub Repository](./references/github_com_lh3_minisplice.md)
- [Bioconda minisplice Overview](./references/anaconda_org_channels_bioconda_packages_minisplice_overview.md)