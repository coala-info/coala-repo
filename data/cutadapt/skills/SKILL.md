---
name: cutadapt
description: Cutadapt is a specialized bioinformatics tool designed to clean raw sequencing data.
homepage: https://cutadapt.readthedocs.io/
---

# cutadapt

## Overview

Cutadapt is a specialized bioinformatics tool designed to clean raw sequencing data. It identifies and removes known sequences (adapters or primers) from the ends of reads while allowing for a user-defined number of errors (mismatches, insertions, and deletions). Beyond simple trimming, it handles quality-based base removal, length filtering, and complex paired-end data processing. Use this skill to construct precise command-line strings for various sequencing library types, including small RNA, amplicon, and genomic DNA libraries.

## Core Trimming Patterns

### 3' Adapter Trimming (Most Common)
Used when the fragment is shorter than the read length, causing the sequencer to read into the adapter.
```bash
cutadapt -a ADAPTER_SEQ -o output.fastq input.fastq
```

### 5' Adapter Trimming
Used for sequences that start with a known primer or adapter.
```bash
cutadapt -g ADAPTER_SEQ -o output.fastq input.fastq
```

### Anchored Trimming
Force the adapter to be found at the very start (5') or end (3') of the read.
- **5' Anchored:** `-g ^ADAPTER_SEQ` (Must match at the beginning)
- **3' Anchored:** `-a ADAPTER_SEQ$` (Must match at the end)

### Paired-End Trimming
Process R1 and R2 simultaneously to maintain read synchronization.
```bash
cutadapt -a ADAPT1 -A ADAPT2 -o out.1.fastq -p out.2.fastq in.1.fastq in.2.fastq
```
*Note: `-a` and `-g` refer to R1; `-A` and `-G` refer to R2.*

## Advanced Workflows

### Quality and Poly-A Trimming
Combine adapter removal with quality filtering and poly-A tail removal.
```bash
cutadapt -a ADAPTER -q 20 --poly-a -m 30 -o out.fastq in.fastq
```
- `-q 20`: Trims low-quality 3' ends (Phred < 20).
- `--poly-a`: Specifically identifies and removes poly-A tails (faster and more accurate than manual sequence matching).
- `-m 30`: Discards reads that are shorter than 30bp after trimming.

### Linked Adapters
Used when a read is expected to have both a 5' and a 3' adapter (e.g., PCR amplicons).
```bash
cutadapt -a ^FRONT_ADAPTER...BACK_ADAPTER -o out.fastq in.fastq
```
The `...` syntax ensures the 3' adapter is only searched for if the 5' adapter is found.

### Demultiplexing
Split a single file into multiple files based on barcodes.
```bash
cutadapt -g file:barcodes.fasta -o {name}.fastq input.fastq
```
The `{name}` placeholder is replaced by the record IDs found in `barcodes.fasta`.

## Expert Tips & Best Practices

- **Error Rate:** The default error rate is 0.1 (10%). For high-stringency requirements, reduce this using `-e 0.05`.
- **Wildcards:** Use `N` in your adapter sequence to match any base. Enable `--match-read-wildcards` if your reads contain `N`s that should match the adapter.
- **Multi-core Processing:** Speed up execution significantly using `-j 0` to auto-detect and use all available CPU cores.
- **Compression:** Cutadapt automatically detects `.gz` extensions. Use `-Z` (or `--compression-level=1`) for faster processing of intermediate files where disk space is less critical than wall-clock time.
- **Verification:** Always check the "Summary" section of the Cutadapt report to ensure the "Reads with adapters" percentage aligns with your experimental expectations.

## Reference documentation

- [User guide](./references/cutadapt_readthedocs_io_en_stable_guide.html.md)
- [Recipes](./references/cutadapt_readthedocs_io_en_stable_recipes.html.md)
- [Reference guide](./references/cutadapt_readthedocs_io_en_stable_reference.html.md)
- [Algorithm details](./references/cutadapt_readthedocs_io_en_stable_algorithms.html.md)