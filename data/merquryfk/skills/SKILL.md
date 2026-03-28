---
name: merquryfk
description: MerquryFK is a high-performance k-mer analysis toolkit used for reference-free assembly evaluation and quality assessment. Use when user asks to determine consensus quality, evaluate k-mer completeness, identify artificial duplications, or perform trio-based phasing and assembly visualization.
homepage: https://github.com/thegenemyers/MERQURY.FK
---


# merquryfk

## Overview

MerquryFK is a high-performance refactoring of the original Merqury k-mer analysis toolkit. It replaces the `meryl` k-mer counter with `FastK`, providing a suite of UNIX-style command-line tools that are significantly faster and easier to invoke. It is primarily used for reference-free assembly evaluation, allowing researchers to determine consensus quality (QV), k-mer completeness, and the presence of artificial duplications or collapsed repeats.

## Core Workflow and CLI Usage

### 1. Prerequisite: FastK Tables
Before using MerquryFK tools, you must generate k-mer tables using `FastK`. 
*   **Critical**: Tables must be produced with the `-t` or `-t1` option so that all k-mers occurring 1 or more times are included.
*   **Convention**: Suffix extensions (like `.fasta`, `.fastq`, `.ktab`) are optional in MerquryFK commands; the tools will automatically look for the appropriate files.

### 2. Trio Phasing with HAPmaker
If maternal and paternal data are available, use `HAPmaker` to identify hap-mers (parent-specific k-mers inherited by the child).

```bash
HAPmaker [-v] [-T<threads>] <mat>[.ktab] <pat>[.ktab] <child>[.ktab]
```
*   **Output**: Generates `<mat>.hap.ktab` and `<pat>.hap.ktab`.
*   **Reliability**: The tool automatically infers "solid" k-mer thresholds to filter out sequencing errors.

### 3. Copy-Number Spectra (CNplot)
Use `CNplot` to visualize how k-mers in the raw reads are represented in the assembly. This helps identify missing content or over-represented (duplicated) sequences.

```bash
CNplot [-pdf] [-w<width>] [-h<height>] <reads>[.ktab] <asm>.fasta <out_prefix>
```
*   **Flags**: 
    *   `-pdf`: Output as PDF (default is PNG).
    *   `-z`: Plot counts of k-mers unique to the assembly.
    *   `-l`, `-f`, `-s`: Choose between line, fill, or stack plots (default is all).

### 4. Assembly Spectra (ASMplot)
Compare k-mer distributions between two different assemblies or a diploid assembly against raw reads.

```bash
ASMplot [-pdf] <reads>[.ktab] <asm1>.fasta [<asm2>.fasta] <out_prefix>
```

### 5. Hap-mer Blob Plots (HAPplot)
For trio-binned or phased assemblies, use `HAPplot` to visualize the distribution of maternal and paternal hap-mers.

```bash
HAPplot [-pdf] <mat>.hap <pat>.hap <asm1>.fasta [<asm2>.fasta] <out_prefix>
```

### 6. Comparative Analysis (KatComp & KatGC)
MerquryFK includes tools inspired by the KAT suite for comparing k-mer content between two datasets or analyzing GC content.

```bash
KatComp <source1>.ktab <source2>.ktab <out_prefix>
KatGC <source>.ktab <out_prefix>
```

## Expert Tips and Best Practices

*   **Flexible Argument Order**: Options (starting with `-`) can be placed anywhere in the command line, even after the primary arguments.
*   **Thread Management**: Use the `-T` flag to specify the number of threads (default is usually 4). For large genomes, increasing this significantly speeds up the `Logex` and `FastK` operations underlying the plots.
*   **Temporary Files**: Use `-P <dir>` to specify a directory for temporary files if your `/tmp` or `$TMPDIR` has limited space.
*   **Plot Customization**: Use `-w` and `-h` to set the dimensions (in inches) of the output plots directly from the CLI.
*   **Re-plotting**: If you use the `-k` (keep) flag, the tool saves the plotting data (e.g., `.asmi`, `.cni`, `.hpi`). You can later run the plot command with just the output file to regenerate plots with different dimensions or formats without re-calculating the k-mer distributions.



## Subcommands

| Command | Description |
|---------|-------------|
| ASMpLot | Plots assembly statistics |
| CNpLot | Plots k-mer counts for sequence data. |
| HAPmaker | HAPmaker |
| HAPplot | Plots HAP data |
| KatComp | Compare k-mer counts between two sources and generate plots. |
| KatGC | Plots KatGC results |

## Reference documentation
- [MerquryFK & KatFK: Fast & Simple](./references/github_com_thegenemyers_MERQURY.FK_blob_main_README.md)
- [ASMplot.c Source](./references/github_com_thegenemyers_MERQURY.FK_blob_main_ASMplot.c.md)
- [CNplot.c Source](./references/github_com_thegenemyers_MERQURY.FK_blob_main_CNplot.c.md)
- [HAPmaker.c Source](./references/github_com_thegenemyers_MERQURY.FK_blob_main_HAPmaker.c.md)
- [HAPplot.c Source](./references/github_com_thegenemyers_MERQURY.FK_blob_main_HAPplot.c.md)
- [KatComp.c Source](./references/github_com_thegenemyers_MERQURY.FK_blob_main_KatComp.c.md)