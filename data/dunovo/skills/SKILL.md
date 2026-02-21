---
name: dunovo
description: Du Novo is a specialized bioinformatics pipeline designed to extract high-fidelity genetic information from duplex sequencing libraries.
homepage: https://github.com/galaxyproject/dunovo
---

# dunovo

## Overview

Du Novo is a specialized bioinformatics pipeline designed to extract high-fidelity genetic information from duplex sequencing libraries. It works by grouping reads derived from the same original DNA molecule into "families" using random barcodes. By comparing these reads, it filters out PCR and sequencing errors to produce highly accurate consensus sequences. It is particularly useful in low-frequency variant detection where reference genomes are unavailable or where heteroduplex formation in ampliconic templates might bias results.

## Core Workflow

The standard Du Novo pipeline follows a linear progression from raw FASTQ files to consensus sequences.

### 1. Family Formation
Group reads by their barcodes and strip the barcode/linker sequences.
```bash
make-families.sh reads_1.fastq reads_2.fastq > families.tsv
```
*   **Note**: Input FASTQ files must have exactly 4 lines per read.
*   **Customization**: Use `-t [length]` to change the barcode length (default 12) and `-i [length]` for the constant linker sequence (default 5).

### 2. Barcode Error Correction (Optional)
Correct PCR or sequencing errors within the barcodes themselves to prevent family fragmentation.
```bash
baralign.sh families.tsv refdir barcodes.sam
correct.py families.tsv refdir/barcodes.fa barcodes.sam | sort > families.corrected.tsv
```

### 3. Multiple Sequence Alignment (MSA)
Align the reads within each family. This is the most computationally intensive step.
```bash
align-families.py families.tsv > families.msa.tsv
```
*   **Aligner Choice**: Use `--aligner mafft` for higher accuracy if MAFFT is installed; otherwise, it defaults to the internal kalign.

### 4. Consensus Generation
Build the final Duplex Consensus Sequences (DCS).
```bash
make-consensi.py --fastq-out 40 families.msa.tsv --dcs1 duplex_1.fq --dcs2 duplex_2.fq
```
*   **Parameters**: `--fastq-out` sets the minimum base quality for the output.
*   **SSCS Output**: Use `--sscs` if you need Single Strand Consensus Sequences, which are useful for analyzing ampliconic templates where heteroduplexes might exist.

## Expert Tips and Best Practices

*   **Resource Management**: `align-families.py` can take a significant amount of time (hours to days depending on depth). Ensure you are running in an environment that can handle long-running processes.
*   **Filtering Ambiguity**: Du Novo may insert IUPAC ambiguity codes (N, R, Y, etc.) where a majority rule consensus cannot be reached. Use a sequence content trimmer or filter after consensus generation to remove reads with high N-content before downstream variant calling.
*   **Minimum Family Size**: For reliable error correction, a minimum of 3 reads per family is standard. This can be tuned in `make-consensi.py` using `--min-reads`.
*   **Reference-Free Advantage**: Because the pipeline is reference-free, it is ideal for de novo assembly of high-accuracy reads or for samples with heavy structural variation compared to a reference.

## Reference documentation
- [Du Novo GitHub README](./references/github_com_galaxyproject_dunovo.md)
- [Du Novo Wiki - Galaxy/ABL1 Example](./references/github_com_galaxyproject_dunovo_wiki.md)
- [Bioconda dunovo Package](./references/anaconda_org_channels_bioconda_packages_dunovo_overview.md)