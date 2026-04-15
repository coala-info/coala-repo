---
name: repeatmasker
description: RepeatMasker identifies and masks transposable elements and repetitive DNA sequences within genomic data. Use when user asks to mask a genome, identify repeat families, or prepare sequences for downstream gene prediction and alignment.
homepage: https://www.repeatmasker.org/RepeatMasker
metadata:
  docker_image: "quay.io/biocontainers/repeatmasker:4.2.2--pl5321hdfd78af_0"
---

# repeatmasker

## Overview
RepeatMasker is the industry-standard tool for "masking" genomes—identifying transposable elements and repetitive regions to prevent them from interfering with downstream analyses like gene prediction or sequence alignment. It utilizes a sequence search engine to compare input DNA against a database of known repeat families. This skill helps you navigate the command-line interface, manage the transition to the HDF5-based FamDB library format, and optimize search parameters for different taxa.

## Common CLI Patterns

### Basic Masking
Mask a genome using the default search engine and the Dfam library for a specific species:
```bash
RepeatMasker -species human genome.fa
```

### Using Custom Libraries
If you have a specific set of consensus sequences (e.g., from RepeatModeler), use the `-lib` flag:
```bash
RepeatMasker -lib custom_repeats.fasta genome.fa
```

### High-Sensitivity Search
For older or less-characterized genomes, increase sensitivity (at the cost of speed):
```bash
RepeatMasker -s -species "Drosophila melanogaster" genome.fa
```

### Parallel Processing
RepeatMasker supports multi-core execution to speed up large genome processing:
```bash
RepeatMasker -pa 8 -species mouse genome.fa
```

### Soft-Masking
To keep the original sequence but change repeats to lowercase (useful for some aligners):
```bash
RepeatMasker -xsmall -species human genome.fa
```

## Expert Tips & Best Practices

- **Library Configuration**: Modern versions (4.2+) use `famdb` (HDF5 format). Ensure your `Libraries/famdb` directory contains the root partition (`dfam39_full.0.h5`) and any relevant taxa partitions.
- **Search Engines**: 
  - **RMBlast**: The recommended default for most general purposes.
  - **HMMER**: Use for profile HMM searches (often more sensitive for divergent repeats).
  - **Cross_Match**: The legacy standard, slower but highly accurate for specific alignments.
- **Output Files**:
  - `.out`: A table of all repeat annotations.
  - `.masked`: The FASTA file with repeats replaced by 'N' (default) or lowercase (if `-xsmall` is used).
  - `.tbl`: A summary report of the repeat content by class/family.
- **Handling Compressed Files**: Version 4.2.3+ supports BGZIP files. You no longer need to manually decompress input files as the program handles them in-place without overwriting the original.
- **Memory Management**: For large chromosomal assemblies, RepeatMasker now streams annotations sequence-by-sequence to reduce the memory footprint of `ProcessRepeats`.

## Reference documentation
- [RepeatMasker Home and Documentation](./references/www_repeatmasker_org_RepeatMasker.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_repeatmasker_overview.md)