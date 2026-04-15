---
name: smudgeplot_rn
description: smudgeplot_rn analyzes heterozygous kmer pairs to visualize genome structure and estimate ploidy levels. Use when user asks to disentangle genome structure, identify ploidy levels, detect genome duplications, or generate a smudgeplot from kmer counts.
homepage: https://github.com/RNieuwenhuis/smudgeplot
metadata:
  docker_image: "quay.io/biocontainers/smudgeplot:0.5.3--py314h577a1d6_0"
---

# smudgeplot_rn

## Overview

`smudgeplot_rn` is a bioinformatic tool designed to disentangle genome structure by analyzing heterozygous kmer pairs. By comparing the sum of kmer pair coverages (CovA + CovB) against their relative coverage (CovB / (CovA + CovB)), it generates a "smudgeplot" where distinct "smudges" represent different haplotype structures (e.g., AB, AAB, AAAB). This is essential for identifying ploidy levels and detecting genome duplications in non-model organisms.

## Core Workflow

The standard pipeline requires kmer counts (typically from KMC) and follows these sequential steps:

### 1. Kmer Counting and Histogram Generation
Use KMC to count kmers and generate a histogram.
```bash
# Count kmers (k=21, 16 threads, 64G RAM)
kmc -k21 -t16 -m64 -ci1 -cs10000 @files_list kmcdb tmp_dir

# Generate histogram
kmc_tools transform kmcdb histogram kmcdb_k21.hist -cx10000
```

### 2. Threshold Estimation
Determine the lower (L) and upper (U) coverage thresholds for genomic kmers.
```bash
L=$(smudgeplot.py cutoff kmcdb_k21.hist L)
U=$(smudgeplot.py cutoff kmcdb_k21.hist U)
```
*Note: L typically ranges from 20-200; U ranges from 500-3000. Always verify these values are sane.*

### 3. Extracting Heterozygous Kmer Pairs
There are three primary methods to extract pairs. Choose based on available resources:

**Option A: Memory Efficient (Recommended with tbenavi1/KMC)**
```bash
kmc_tools transform kmcdb -ci"$L" -cx"$U" reduce kmcdb_reduced
smudge_pairs kmcdb_reduced coverages.tsv pairs.tsv > familysizes.tsv
```

**Option B: Fast (Standard Python implementation)**
```bash
kmc_tools transform kmcdb -ci"$L" -cx"$U" dump -s kmcdb.dump
smudgeplot.py hetkmers -o kmcdb_output < kmcdb.dump
```

**Option C: Parallel (Fastest for large genomes)**
```bash
# Run for each position in kmer (e.g., k=21)
parallel -j 21 smudgeplot.py hetkmers -o kmcdb_pos --pos {} kmcdb.dump ::: {0..20}
smudgeplot.py aggregate --infile kmcdb.dump -o kmcdb_final --index_files kmcdb_pos*_indices.tsv
```

### 4. Generating the Smudgeplot
Generate the final visualization using the extracted coverages.
```bash
smudgeplot.py plot kmcdb_coverages.tsv
```

## Expert Tips & Best Practices

- **1n Coverage Estimation**: For the most accurate results, provide the haploid kmer coverage (1n) estimated by GenomeScope using the `-n` parameter in `smudgeplot.py plot`.
- **Input Quality**: Smudgeplots are highly sensitive to kmer quality. Always use trimmed reads to reduce noise from sequencing errors.
- **Kmer Length**: A kmer length of 21 is standard for most eukaryotic genomes, but consider increasing it for highly repetitive genomes.
- **Interpretation**: The "heat" of a smudge indicates the frequency of that specific haplotype structure. A dominant smudge at the "AB" position suggests diploidy, while strong signals at "AAB" or "ABB" suggest triploidy.
- **Memory Management**: If `hetkmers` crashes due to memory limits, switch to the `smudge_pairs` C++ implementation or the parallel `--pos` approach.

## Reference documentation
- [Smudgeplot GitHub Repository](./references/github_com_RNieuwenhuis_smudgeplot.md)
- [Bioconda smudgeplot_rn Overview](./references/anaconda_org_channels_bioconda_packages_smudgeplot_rn_overview.md)