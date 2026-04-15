---
name: bioconductor-seqbias
description: This tool models and corrects for technical nucleotide sequence bias in high-throughput sequencing data using a Bayesian network. Use when user asks to assess sequence-specific bias, visualize k-mer frequencies near read starts, or normalize BAM read counts based on genomic sequence context.
homepage: https://bioconductor.org/packages/3.8/bioc/html/seqbias.html
---

# bioconductor-seqbias

name: bioconductor-seqbias
description: Assess and adjust for technical nucleotide sequence bias in high-throughput sequencing data (specifically RNA-Seq). Use this skill when you need to model how surrounding genomic sequences affect read distribution, visualize k-mer frequencies relative to read starts, or normalize BAM read counts based on a trained Bayesian network classifier.

# bioconductor-seqbias

## Overview

The `seqbias` package addresses the issue of non-uniform read distribution in high-throughput sequencing caused by protocol-specific biases (e.g., random hexamer priming). It uses a Bayesian network to model the relationship between the genomic sequence surrounding a read's start position and the probability of a read being sequenced. This allows for the calculation of a "bias factor" that can be used to normalize read counts, leading to more accurate quantification.

## Workflow: Assessment

Before correcting data, you should assess if a significant sequence bias exists in your BAM files.

1.  **Load Libraries and Data**:
    ```r
    library(seqbias)
    library(Rsamtools)

    ref_fn <- "path/to/genome.fa"
    reads_fn <- "path/to/reads.bam"
    ref_f <- FaFile(ref_fn)
    open(ref_f)
    ```

2.  **Generate Random Intervals**:
    Sample the genome to get a representative set of sequences.
    ```r
    ref_seqs <- scanFaIndex(ref_f)
    # Generate 5 intervals of 100kb each
    I <- random.intervals(ref_seqs, n = 5, m = 100000)
    ```

3.  **Extract Sequences and Counts**:
    ```r
    seqs <- scanFa(ref_f, I)
    # Handle strand manually for scanFa
    neg_idx <- as.logical(I@strand == '-')
    seqs[neg_idx] <- reverseComplement(seqs[neg_idx])

    # Get binary counts (0 or 1) to avoid outlier dominance
    counts <- count.reads(reads_fn, I, binary = TRUE)
    ```

4.  **Compute and Plot Frequencies**:
    ```r
    freqs <- kmer.freq(seqs, counts)

    # Plotting with ggplot2
    library(ggplot2)
    ggplot(freqs, aes(x = pos, y = freq, color = seq)) +
      geom_line() +
      facet_grid(seq ~ .) +
      theme_bw()
    ```
    *Note: A flat line indicates no bias. Peaks or dips near position 0 indicate sequence-specific bias.*

## Workflow: Compensation (Correction)

If bias is detected, follow these steps to train a model and adjust counts.

1.  **Train the Model**:
    ```r
    # L and R define the window size to the left and right of the read start
    sb <- seqbias.fit(ref_fn, reads_fn, L = 5, R = 15)
    ```

2.  **Predict Bias**:
    Calculate the bias for specific intervals.
    ```r
    bias <- seqbias.predict(sb, I)
    ```

3.  **Adjust Counts**:
    Divide the observed counts by the predicted bias.
    ```r
    # counts and bias are typically lists of vectors
    counts.adj <- mapply(FUN = `/`, counts, bias, SIMPLIFY = FALSE)
    ```

## Model Persistence

Training on large datasets can be slow. Save the model to a YAML file for future use.

```r
# Save
seqbias.save(sb, "model.yml")

# Load (requires the original reference FASTA)
sb <- seqbias.load(ref_fn, "model.yml")
```

## Key Functions

- `random.intervals(ref_lengths, n, m)`: Generates random genomic intervals.
- `count.reads(bam_fn, intervals, binary)`: Extracts read counts per position.
- `kmer.freq(sequences, counts, k)`: Calculates k-mer frequencies relative to read starts.
- `seqbias.fit(ref_fn, bam_fn, L, R)`: Fits the Bayesian network bias model.
- `seqbias.predict(model, intervals)`: Predicts bias factors for given intervals.

## Reference documentation

- [seqbias Overview](./references/overview.md)