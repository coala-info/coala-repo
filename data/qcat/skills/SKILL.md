---
name: qcat
description: qcat is a command-line utility used to demultiplex and sort Oxford Nanopore reads into separate files based on detected barcodes. Use when user asks to demultiplex FASTQ files, sort ONT reads by barcode, or replicate EPI2ME demultiplexing logic locally.
homepage: https://github.com/nanoporetech/qcat
---


# qcat

## Overview
qcat is a command-line utility designed to sort Oxford Nanopore Technologies (ONT) reads. It accepts basecalled FASTQ files and splits them into individual files according to the barcodes detected. It is specifically useful for researchers who need to replicate the EPI2ME demultiplexing logic locally on pre-existing FASTQ files. Note that this tool is archived and ONT generally recommends using the integrated demultiplexing features within modern basecallers (like Guppy or Dorado) for current sequencing runs.

## Installation
The most reliable way to install qcat is via Bioconda:
```bash
conda install -c bioconda qcat
```

## Common CLI Patterns

### Basic Demultiplexing
To process a single FASTQ file and output results to a specific directory:
```bash
qcat -f input_reads.fastq -b /path/to/output_folder
```

### Processing Multiple Files
qcat expects a single input stream. If you have multiple FASTQ files from a sequencing run, pipe them into the tool:
```bash
cat folder_with_fastqs/*.fastq | qcat -b output_folder
```

### Dual/Combinatorial Barcoding
For datasets using dual barcoding kits, use the `--dual` flag to ensure correct identification:
```bash
qcat --dual -f input_reads.fastq -b output_folder
```

### Kit Selection
While qcat can auto-detect kits, you can specify a kit to improve accuracy or speed:
```bash
qcat -f input.fastq -b output_folder --kit RBK004
```
Supported kits include: `RBK001`, `RBK004`, `NBD103/NBD104`, `NBD114`, `PBC001`, `PBC096`, and `RPB004/RLB001`.

## Expert Tips and Best Practices

### Handling "Hanging" Executions
If qcat is started without the `-f` flag and no data is piped in, it will wait indefinitely for input from standard in (stdin). If the process appears stuck, ensure you have provided an input file or a pipe.

### Verification of Results
Always review the command-line summary provided after execution. It displays the percentage of reads assigned to specific barcodes versus those labeled as "none." A high "none" count may indicate an incorrect kit selection or poor sequencing quality at the adapter regions.

### Trimming Behavior
qcat automatically performs adapter and barcode trimming during the demultiplexing process. The resulting FASTQ files in the output folder are ready for downstream analysis without requiring additional trimming steps for these specific ONT sequences.

### Performance Note
For large datasets, piping (`cat *.fastq | qcat ...`) is often more efficient than concatenating files into a single massive disk-bound FASTQ file before processing.

### Deprecation Warning
This tool is archived. If you are working with modern ONT kits or R10.4.1 flow cells, prefer using `guppy_barcoder` or the demultiplexing options in `dorado`, as qcat may not support the latest barcode sequences or chemistry improvements.

## Reference documentation
- [qcat Overview](./references/anaconda_org_channels_bioconda_packages_qcat_overview.md)
- [qcat GitHub Repository](./references/github_com_nanoporetech_qcat.md)