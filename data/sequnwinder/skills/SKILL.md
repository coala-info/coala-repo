---
name: sequnwinder
description: SeqUnwinder is a computational framework designed to find motifs that distinguish between different classes of genomic loci.
homepage: http://mahonylab.org/software/sequnwinder/
---

# sequnwinder

## Overview
SeqUnwinder is a computational framework designed to find motifs that distinguish between different classes of genomic loci. Unlike standard motif discovery tools that compare one set of sequences against a background, SeqUnwinder treats the problem as a multi-label classification task. This allows it to identify motifs associated with specific cell types or conditions even when those sites share overlapping annotations (e.g., a site labeled as both "Enhancer" and "CellType-A"). It uses a multi-class logistic regression model with K-mer features to characterize the sequence signatures of each label.

## Core Command Pattern
The standard execution requires a Java environment (Java 8+) and a significant memory allocation (typically 20GB+ for large datasets).

```bash
java -Xmx20G -jar sequnwinder.jar \
  --out <prefix> \
  --threads <int> \
  --geninfo <genome_info> \
  --seq <fasta_dir> \
  --genregs <regions_file> \
  --mink 4 --maxk 5 \
  --r 10
```

## Input Requirements
- **Genome Info**: A tab-delimited file containing `chrName <tab> chrLength`.
- **Sequence Directory**: A folder containing individual FASTA files for every chromosome named in the genome info file.
- **Genomic Regions (`--genregs`)**: A file where each line contains a coordinate and its labels:
  `chr10:100076604 enhancer;shared`
- **Sequences with Annotations (`--genseqs`)**: Alternatively, provide raw sequences directly:
  `ATTGC...TTA enhancer;shared`

## Expert Tips & Best Practices
- **K-mer Selection**: For most applications, use `--mink 4 --maxk 5`. If you have a very large dataset (tens of thousands of sites), you can increase `--maxk` to 6 or 7 to capture more complex motifs.
- **Regularization (`--r`)**: The default value of 10.0 is a robust starting point for ~20k sites and ~6 labels. If classification accuracy is low, perform a parameter sweep (e.g., 1, 5, 10, 20) to find the optimal value for your specific data density.
- **Handling Small Classes**: By default, subclasses with fewer than 200 sites are removed. Use the `--mergelow` flag to merge these small subclasses into other relevant classes instead of discarding them.
- **MEME Integration**: SeqUnwinder uses MEME for the final motif refinement. Ensure the MEME bin directory is in your `$PATH` or specify it explicitly with `--memepath`.
- **Random Background**: Use `--makerandregs` when providing a genome to automatically generate a "random" outgroup class, which helps the model distinguish regulatory features from general genomic background.
- **Scanning Parameters**: The `--maxscanlen` (default 14) must always be greater than `--mememaxw` (default 13). If you are looking for longer motifs, increase both accordingly.

## Reference documentation
- [SeqUnwinder | Mahony Lab](./references/mahonylab_org_software_sequnwinder.md)
- [sequnwinder - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_sequnwinder_overview.md)