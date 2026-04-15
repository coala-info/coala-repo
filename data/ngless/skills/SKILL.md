---
name: ngless
description: ngless is a domain-specific language designed to streamline next-generation sequencing analysis through high-level pipelines for quality control, read filtering, and feature counting. Use when user asks to process raw sequencing data, perform read mapping and selection, or generate functional and taxonomic profiles from metagenomic datasets.
homepage: http://ngless.embl.de
metadata:
  docker_image: "quay.io/biocontainers/ngless:1.5.0--h9ee0642_0"
---

# ngless

## Overview
ngless is a domain-specific language (DSL) designed to streamline the initial phases of NGS analysis. It transforms raw sequencing data into annotated results through a high-level, pythonesque syntax that emphasizes reproducibility and ease of use. By abstracting complex bioinformatics tools like bwa, samtools, and megahit, ngless allows for the creation of robust pipelines that handle quality control, read filtering, and feature counting with minimal boilerplate.

## Core CLI Usage

### Running Scripts
The primary way to use ngless is by executing a `.ngl` script:
```bash
ngless script.ngl
```

### One-Liners and Pipes
For quick transformations, use the `-e` (execute) and `-p` (print last expression) flags:
- **Convert SAM to FASTQ**:
  `ngless -pe 'as_reads(samfile("input.sam"))' > output.fq`
- **Extract Mapped Reads**:
  `ngless -pe 'as_reads(select(samfile("input.sam"), keep_if=[{mapped}]))' > mapped.fq`
- **Process from STDIN**:
  `cat input.sam | ngless -pe 'as_reads(samfile(STDIN))' > output.fq`

### Parallel Processing
When processing multiple samples, ngless uses a "lock" mechanism to prevent redundant work:
```bash
ngless script.ngl INPUT_DIR OUTPUT_DIR
```
*Note: Run the command multiple times (or in parallel) to process all samples in a directory.*

## Scripting Best Practices

### 1. Version Declaration
Every script should begin with a version string to ensure backwards compatibility:
```python
ngless "1.5"
```

### 2. Preprocessing Blocks
Use the `preprocess` function with a `using` block for efficient read trimming and filtering:
```python
input = preprocess(input) using |read|:
    read = substrim(read, min_quality=25)
    if len(read) < 45:
        discard
```

### 3. Mapping and Selection
Map reads to built-in references (e.g., `hg19`, `mm10`) or custom FASTA files:
```python
mapped = map(input, reference='hg19')
# Filter to keep only unmapped reads (e.g., removing host contamination)
unmapped = select(mapped, keep_if=[{unmapped}])
```

### 4. Functional Counting
Aggregate alignments into feature counts using the `count` function:
```python
counts = count(mapped, features=['gene'], normalization={scaled})
write(counts, ofile='results.csv')
```

## Expert Tips
- **Memory Management**: For large datasets (like the IGC catalog), ensure the environment has sufficient RAM (e.g., 15GiB+). Use `low memory mode` if available for specific modules.
- **Built-in References**: ngless automatically downloads and manages indices for common organisms (Homo sapiens, Mus musculus, etc.) the first time they are referenced.
- **Metagenomics Profiling**: Use the `motus` module for taxonomic profiling or `igc` for functional profiling of gut metagenomes.
- **Output Handling**: The `write` function defaults to FASTQ for reads and CSV/TSV for tables. Use the `format` argument to specify alternatives.

## Reference documentation
- [NGLess: NGS Processing with Less Work](./references/ngless_embl_de_index.md)
- [NGLess Builtin Functions](./references/ngless_embl_de_index.md)
- [Human Gut Metagenomics Tutorial](./references/ngless_embl_de_tutorial-gut-metagenomics.html.md)
- [NG-meta-profiler Pipelines](./references/ngless_embl_de_ng-meta-profiler.html.md)