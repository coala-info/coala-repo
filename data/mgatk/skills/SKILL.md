---
name: mgatk
description: mgatk processes mitochondrial reads from single-cell or bulk sequencing data to generate variant-by-cell matrices and identify heteroplasmic mutations. Use when user asks to process 10x Genomics mitochondrial data, call variants from barcoded BAM files, or identify large mitochondrial deletions.
homepage: https://github.com/caleblareau/mgatk
---

# mgatk

## Overview
The `mgatk` (Mitochondrial Genome Analysis ToolKit) is a Python-based command-line interface designed to handle the unique challenges of mitochondrial genetics. It is particularly optimized for single-cell genomics data (like mtscATAC-seq) but is applicable to any assay producing mitochondrial reads. The tool streamlines the transition from aligned `.bam` files to a finalized variant-by-cell matrix, enabling the discovery of subclonal structures and lineage tracing through mitochondrial mutations.

## Core CLI Patterns

### Primary Execution Modes
`mgatk` operates in several distinct modes depending on the input data structure:

- **tenx**: Optimized for 10x Genomics datasets. Requires a single `.bam` file and a barcode file.
- **bcall**: Used for barcoded `.bam` files where multiple samples are contained in one file.
- **call**: Used for a directory containing multiple individual `.bam` files (one per sample/cell).

### Common Command Examples

**Processing 10x Genomics Data:**
```bash
mgatk tenx -i input.bam -n sample_name -b barcodes.txt -o output_dir -m chrM -c 12
```

**Processing a Folder of BAM Files:**
```bash
mgatk call -i ./bam_folder -n project_name -o output_dir -m chrM
```

**Calling Large Deletions:**
```bash
mgatk del -i input.bam -n sample_name -o output_dir -m chrM
```

## Expert Tips and Best Practices

### Handling Reference Genomes
- **Mitochondrial Contig Name**: Ensure the `-m` or `--mito-genome` flag matches the exact string in your BAM header (e.g., `chrM` vs `MT`).
- **Custom Genomes**: If using a non-standard or non-human genome, provide the fasta file using the `-g` flag.

### Performance Optimization
- **Parallelization**: Use the `-c` flag to specify the number of cores. For `tenx` mode, `mgatk` typically produces the same number of intermediate files as cores available.
- **Memory Management**: If encountering "Too many open files" errors, increase the system limit using `ulimit -n 1024` before running the command, or use the `--nsamples` flag to process samples in smaller batches.

### Alignment Considerations
- **Circular Genome**: While mtDNA is circular, standard aligners like `bwa` (used in CellRanger) are generally sufficient because they use soft-clipping at the junction. Only switch to specialized aligners like `GSNAP` if your variants of interest are specifically located at the D-loop junction (positions ~1-20 or ~16549-16569).
- **Filtering**: `mgatk` performs internal filtering, but ensuring high-quality alignments (properly paired, high mapping quality) upstream improves heteroplasmy estimation.

## Troubleshooting Common Errors

| Error | Cause | Solution |
| :--- | :--- | :--- |
| `No samples for genotyping` | Mismatch between mode and input or wrong `-m` flag. | Verify if input is a file vs. folder; check BAM header for MT contig name. |
| `OSError: [Errno 24]` | System file descriptor limit reached. | Run `ulimit -n 2048` or use `tenx` mode with fewer cores. |
| `Missing .A.txt files` | Pipeline interrupted or permission issues. | Check write permissions in the output directory and ensure disk space is available. |



## Subcommands

| Command | Description |
|---------|-------------|
| mgatk bcall | mgatk: a mitochondrial genome analysis toolkit. bcall mode is used for mitochondrial genome analysis from single-cell data (e.g., with barcodes). |
| mgatk call | mgatk: a mitochondrial genome analysis toolkit. Mitochondrial genome analysis for 'call' mode. |
| mgatk check | mgatk: a mitochondrial genome analysis toolkit. check mode. |
| mgatk remove-background | mgatk: a mitochondrial genome analysis toolkit. remove-background mode. |
| mgatk support | mgatk: a mitochondrial genome analysis toolkit. Support mode for mitochondrial genome analysis. |
| mgatk tenx | mgatk: a mitochondrial genome analysis toolkit. Mode: tenx. |

## Reference documentation
- [An overview of mgatk's modes](./references/github_com_caleblareau_mgatk_wiki_Modes.md)
- [Understanding the main output files](./references/github_com_caleblareau_mgatk_wiki_Outputs.md)
- [Trouble shooting common errors](./references/github_com_caleblareau_mgatk_wiki_Common-errors.md)
- [User-specified options in processing](./references/github_com_caleblareau_mgatk_wiki_User-options.md)
- [Large mtDNA deletions](./references/github_com_caleblareau_mgatk_wiki_Large-deletion-calling-and-heteroplasmy-estimation.md)