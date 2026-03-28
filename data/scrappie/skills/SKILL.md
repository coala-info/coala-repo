---
name: scrappie
description: Scrappie is a research-oriented basecaller that converts raw electrical signal data from Oxford Nanopore devices into DNA sequences. Use when user asks to perform basecalling on raw fast5 files, call bases from event data, or predict squiggles from sequences.
homepage: https://github.com/nanoporetech/scrappie
---


# scrappie

think thoughtfully.name: scrappie
description: A technology demonstrator for Oxford Nanopore basecalling algorithms. Use this skill when you need to perform basecalling on Nanopore sequencing data, specifically for calling bases from raw signal (fast5) or events, or when predicting squiggles from sequences.

## Overview
Scrappie is a research-oriented basecaller developed by Oxford Nanopore Technologies. While it has been largely superseded by newer tools like Bonito and Guppy for production environments, it remains a vital tool for algorithm research, technology demonstration, and specific legacy workflows. It excels at converting raw electrical signal data from Nanopore devices into DNA sequences (FASTA/SAM) and provides utilities for signal segmentation and event detection.

## Core CLI Operations

### Basecalling from Raw Signal
The most common use case is calling bases directly from raw fast5 files.
```bash
# Call a directory of reads
scrappie raw path/to/reads/ > basecalls.fa

# Call specific fast5 files
scrappie raw read1.fast5 read2.fast5 > basecalls.fa

# Specify a specific model (e.g., rgrgr_r941)
scrappie raw --model rgrgr_r941 path/to/reads/ > basecalls.fa
```

### Basecalling via Events
Use this mode when working with pre-processed event data rather than raw signal.
```bash
scrappie events path/to/reads/ > basecalls.fa
```

### Performance Optimization
Scrappie uses OpenMP for multi-processing. Proper environment variable configuration is critical for performance.
```bash
# Set threads to match system capacity
export OMP_NUM_THREADS=`nproc`

# Ensure OpenBLAS remains single-threaded to avoid contention
export OPENBLAS_NUM_THREADS=1

# Run scrappie with parallel read processing
scrappie raw --threads ${OMP_NUM_THREADS} path/to/reads/ > basecalls.fa
```

## Expert Tips and Patterns

### Metadata Extraction
You can extract read metadata into a TSV format by piping the output and using the provided helper scripts.
```bash
scrappie raw --threads 1 path/to/reads/ | tee basecalls.fa | grep '^>' | cut -d ' ' -f 2- | python3 misc/json_to_tsv.py > meta_data.tsv
```

### Handling Large Datasets
For very large datasets, use `xargs` to manage the input stream effectively.
```bash
find path/to/reads/ -name "*.fast5" | xargs scrappie raw > basecalls.fa
```

### Common Parameters
- `--format [FASTA|SAM]`: Choose the output format (default is FASTA).
- `--limit [n]`: Limit processing to the first *n* reads for quick testing.
- `--trim [start:end]`: Trim a specific number of events/signals from the beginning or end of the read.



## Subcommands

| Command | Description |
|---------|-------------|
| event_table | Scrappie basecaller -- basecall via events |
| events | Scrappie basecaller -- basecall via events |
| mappy | Scrappie squiggler |
| raw | Scrappie basecaller -- basecall from raw signal |
| scrappie | Scrappie is a technology demonstrator for the Oxford Nanopore Technologies Limited Research Algorithms group. |
| seqmappy | Scrappie seqmappy (local-global) |
| squiggle | Scrappie squiggler |

## Reference documentation
- [Scrappie GitHub Repository](./references/github_com_nanoporetech_scrappie.md)
- [Scrappie README](./references/github_com_nanoporetech_scrappie_blob_master_README.md)
- [Scrappie CMake Configuration](./references/github_com_nanoporetech_scrappie_blob_master_CMakeLists.txt.md)