---
name: dunovo
description: The dunovo pipeline transforms raw duplex sequencing reads into high-fidelity consensus sequences by grouping reads into families based on molecular barcodes. Use when user asks to form read families, perform barcode error correction, align read families, or generate duplex consensus sequences.
homepage: https://github.com/galaxyproject/dunovo
---

# dunovo

## Overview

The dunovo pipeline is a reference-free suite of tools designed to transform raw duplex sequencing reads into high-fidelity consensus sequences. By utilizing random molecular barcodes (UMIs) attached to DNA fragments, the tool groups reads into "families" derived from the same original molecule. It performs multiple sequence alignments within these families to distinguish true biological variants from technical artifacts introduced during PCR or sequencing. This skill provides the necessary command-line workflows to move from raw FASTQ files to final Duplex Consensus Sequences (DCS).

## Core Workflow

The standard dunovo workflow consists of four primary stages. Ensure all scripts are in your `$PATH` and C modules are compiled via `make`.

### 1. Family Formation
Group reads by their barcodes and strip the barcode/linker sequences from the reads.
```bash
make-families.sh reads_1.fastq reads_2.fastq > families.tsv
```
*   **Note**: Input FASTQ files must have exactly 4 lines per read.
*   **Options**: Use `-t` to set barcode length (default 12) and `-i` for the constant/linker sequence length (default 5).

### 2. Barcode Error Correction (Optional)
Correct PCR or sequencing errors within the barcodes themselves to prevent family fragmentation.
```bash
# Align barcodes to find related groups
baralign.sh families.tsv refdir barcodes.sam

# Correct the families file
correct.py families.tsv refdir/barcodes.fa barcodes.sam | sort > families.corrected.tsv
```

### 3. Multiple Sequence Alignment (MSA)
Align the reads within each family. This is the most computationally intensive step.
```bash
align-families.py families.tsv > families.msa.tsv
```
*   **Tip**: Use `--aligner mafft` if MAFFT is installed for potentially better results than the default kalign.

### 4. Consensus Generation
Build the final consensus sequences from the aligned families.
```bash
make-consensi.py --fastq-out 40 families.msa.tsv --dcs1 duplex_1.fq --dcs2 duplex_2.fq
```
*   **DCS**: Represents the consensus of both strands of the original DNA molecule.
*   **SSCS**: To output Single Strand Consensus Sequences (useful for ampliconic templates where heteroduplexes form), add the `--sscs` flag.
*   **Filtering**: Use `--min-reads` (default 3) to set the minimum family size required to form a consensus.

## Expert Tips and Best Practices

*   **Handling Heteroduplexes**: In ampliconic sequencing, PCR can cause heteroduplex formation. If `make-consensi.py` produces too many `N` bases in DCS mode, analyze the SSCS output. SSCS will retain the individual strand information which may be more accurate for allele frequency estimation in high-titer amplicon samples.
*   **Memory and Time**: `align-families.py` is a significant bottleneck. For large datasets, ensure you are running on a system with sufficient CPU cores and consider subsetting data if testing parameters.
*   **Sequence Trimming**: If the output consensus sequences contain IUPAC ambiguity codes or `N`s at the ends, use a sequence trimmer to clean the final FASTQ files before downstream mapping or variant calling.
*   **Barcode Identification**: The pipeline assumes barcodes are at the start of the reads. If your library prep places barcodes elsewhere, you must pre-process the reads so the barcodes are at the 5' end before running `make-families.sh`.



## Subcommands

| Command | Description |
|---------|-------------|
| align-families.py | Read in sorted FASTQ data and do multiple sequence alignments of each family. |
| baralign.sh | Aligns barcodes to a reference genome. |
| correct.py | Correct barcodes using an alignment of all barcodes to themselves. Reads the alignment in SAM format and corrects the barcodes in an input "families" file (the output of make-barcodes.awk). It will print the "families" file to stdout with barcodes (and orders) corrected. |
| make-consensi.py | Build consensus sequences from read aligned families. Prints duplex consensus sequences in FASTA to stdout. The sequence ids are BARCODE.MATE, e.g. "CTCAGATAACATACCTTATATGCA.1", where "BARCODE" is the input barcode, and "MATE" is "1" or "2" as an arbitrary designation of the two reads in the pair. The id is followed by the count of the number of reads in the two families (one from each strand) that make up the duplex, in the format READS1/READS2. If the duplex is actually a single-strand consensus because the matching strand is missing, only one number is listed. Rules for consensus building: Single-strand consensus sequences are made by counting how many of each base are at a given position. Bases with a PHRED quality score below the --qual threshold are not counted. If a majority of the reads (that pass the --qual threshold at that position) have one base at that position, then that base is used as the consensus base. If no base has a majority, then an N is used. Duplex consensus sequences are made by aligning pairs of single-strand consensuses, and comparing bases at each position. If they agree, that base is used in the consensus. Otherwise, the IUPAC ambiguity code for both bases is used (N + anything and gap + non-gap result in an N). |
| make-families.sh | Read raw duplex sequencing reads, extract their barcodes, and group them by barcode. Input fastq's can be gzipped. |

## Reference documentation
- [Du Novo GitHub README](./references/github_com_galaxyproject_dunovo.md)
- [Du Novo Wiki: Running Interactively and Background](./references/github_com_galaxyproject_dunovo_wiki.md)