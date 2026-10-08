---
name: elph
description: ELPH (Estimated Locations of Pattern Hits) is a Gibbs sampler that finds the most common motif in a set of DNA or protein sequences, such as ribosome binding sites or exon splicing enhancers. Use when user asks to find a conserved motif of a given length in a multi-FASTA file, build a motif probability matrix, fit a known pattern to sequences, or test whether a motif is more frequent in one sequence set than in another.
homepage: https://ccb.jhu.edu/software/ELPH/
metadata:
  docker_image: "biocontainers/elph:v1.0.1-2-deb_cv1"
---

# elph

## Overview

ELPH is a general-purpose Gibbs sampler for motif finding. It was written at the Center for Bioinformatics and Computational Biology, University of Maryland (Mihaela Pertea). The input is a multi-FASTA file with a few dozen to thousands of sequences. ELPH assumes each sequence holds one copy of the motif and searches for the most common motif of a given length. It reports the background and motif probability matrices and the motif position in every sequence. It can also test the motif's significance against shuffled sequences or against a second sequence set. ELPH was used to find ribosome binding sites (RBSs) and exon splicing enhancers (ESEs).

## Installation and Setup

ELPH is C++ source code; build it with `make` in the `sources` folder. Debian and BioContainers also package it:

```bash
apt-get install elph            # Debian / Ubuntu
docker pull biocontainers/elph:v1.0.1-2-deb_cv1
```

## How the search works

1. ELPH picks a random motif start in each sequence.
2. Predictive update: it takes one sequence out, adds its current motif to the background and rebuilds the motif matrix from the other sequences.
3. Sampling: it scores every possible start in that sequence and draws a new start, weighted by the scores.
4. It repeats steps 2 and 3 until the score stops rising (a local maximum) or `MAXLOOP` is reached.
5. It restarts `ITERNO` times with new random starts. Then it optimizes the best alignment to the maximum a posteriori (MAP) motif.

## Command Line Usage

```text
elph <multi-fasta_file> [options]
elph <multi-fasta_file-1> <multi-fasta_file-2> [-t <matrix>] [options]
```

Options of the form `NAME=n` are written with no spaces and no dash.

### Find a motif

```bash
elph seqs.fasta LEN=6
elph seqs.fasta LEN=6 -s 974 -o motif.txt
```

### Key Arguments
- `LEN=n`: motif length. Always give it. Without it ELPH asks for the length on standard input, which hangs or fails in scripts and containers.
- `ITERNO=n`: number of Gibbs sampler restarts to reach the global maximum (default 10).
- `MAXLOOP=n`: maximum iterations to reach a local maximum (default 500).
- `-p n`: iterations without gain before ELPH decides it reached a local maximum (default 20).
- `-s <seed>`: random seed. Set it for reproducible results.
- `-o <out_file>`: write the result to a file instead of standard output.
- `-b`: brief output; print only the background and motif matrices, not the per-sequence motif positions.
- `-x`: also print, for each sequence, the positions with the highest score under the final matrix.
- `-v`: find the motif deterministically (no Gibbs sampling; faster).
- `-a`: treat the input as amino acid sequences (the default is DNA; the authors mark this option as untested).

### Fit a known pattern
- `-m <motif>`: compute the best-fit matrix for the given pattern, for example `-m TATAAT`.
- `-r`: with `-m`, allow motifs that are not the closest edit distance to the pattern.
- `-l`: with `-m`, compute the Least Likely Consensus (LLC) score. It combines the information content of the motif with how rare it is in the background.

### Test significance
- `-g`: compare motif occurrences in the input with a random file of the same sequence lengths and residue composition. ELPH reports a Wilcoxon paired test (more reliable) and a Student t-test.
- `SGFNO=n`: number of sampling rounds for the significance test (default 1000).
- `-d`: with `-g`, estimate occurrence probabilities directly from the motif matrix instead of running the sampler `SGFNO` times.
- `-n [0..5]`: degree of the Markov chain that generates the random sequences (default 2).

### Compare two sequence sets

```bash
elph positives.fasta negatives.fasta LEN=5 -s 974 -n 3
elph positives.fasta negatives.fasta -t motif_matrix.txt
```

ELPH finds the motif in the first file and tests whether it is more frequent there than in the second file.
- `-t <matrix>`: skip the motif search and test a given motif matrix file.
- `-e`: count only exact matches of the pattern given with `-m` or `-t`.

## Output

- Progress lines such as `[1]3: alignProb=56.81 Info/param=0.00 diff=10.14` (restart number, iteration, score).
- `MAP for motif` and `InfoPar` for the final motif.
- Background probability model and counts for each residue.
- Motif probability model: one column per motif position, one row per residue, and an `Info` row with the information content of each position.
- Motif counts per position.
- A table with one line per sequence: `Seq.no`, `Pos` (1-based start), five flanking residues on each side (lower case) around the motif (upper case), `Prob`, and the sequence ID.

## Expert Tips and Best Practices

- Set `-s` whenever you need the same answer twice. Without a seed the Gibbs sampler gives different results between runs.
- ELPH assumes one motif copy per sequence. Trim sequences to the region where the motif is expected.
- Raise `ITERNO` for long or noisy inputs to lower the risk of a poor local maximum. Use `-v` for a fast deterministic first look.
- Sequences that contain only N are ignored (ELPH 1.0 and later). Motif positions rarely include N (DNA) or X (protein).
- Use `-b` when you only need the matrix; the per-sequence table is long for thousands of sequences.

## Reference documentation
- [ELPH Home Page](./references/ccb_jhu_edu_software_ELPH.md)
- [ELPH Readme, Version History and Debian Package Notes](./references/sources_debian_org_src_elph_Readme.ELPH.md)
