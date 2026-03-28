---
name: sanitizeme
description: SanitizeMe removes unwanted genetic material from sequencing reads by filtering out sequences that align to a provided reference genome. Use when user asks to clean sequencing data, remove host DNA, or sanitize FASTQ files for privacy and signal improvement.
homepage: https://github.com/jiangweiyao/SanitizeMe
---

# sanitizeme

## Overview

SanitizeMe is a specialized bioinformatics pipeline used to clean sequencing reads by removing unwanted genetic material. It works by aligning input FASTQ files against a user-provided reference genome and extracting only the reads that do not map to that reference. This is a critical step in clinical metagenomics and environmental DNA studies to ensure privacy (by removing human DNA) and to improve the signal-to-noise ratio for non-host organisms. The tool provides dedicated scripts for both single-end and paired-end sequencing data.

## CLI Usage Patterns

### Single-End Reads
Use `SanitizeMe_CLI.py` for processing individual FASTQ files.
```bash
SanitizeMe_CLI.py -i /path/to/input_folder -r /path/to/reference.fasta.gz -o /path/to/output_folder
```

### Paired-End Reads
Use `SanitizeMePaired_CLI.py` for paired sequencing data. The tool automatically identifies R1 and R2 pairs recursively within the input directory.
```bash
SanitizeMePaired_CLI.py -i /path/to/input_folder -r /path/to/reference.fasta.gz -o /path/to/output_folder
```

### Key Arguments
- `-i, --InputFolder`: The directory containing your `.fq`, `.fastq`, `.fq.gz`, or `.fastq.gz` files.
- `-r, --Reference`: The host reference file in FASTA format (can be gzipped).
- `-o, --OutputFolder`: Destination for filtered reads. Defaults to `~/dehost_output/` with a timestamp.
- `-t, --threads`: Number of CPU threads to use for alignment (default is 4).
- `--LargeReference`: Required if the reference genome is larger than 4 Gigabases.

## Expert Tips and Best Practices

- **Reference Selection**: For human host removal, the `human_g1k_v37.fasta.gz` reference is standard. Ensure your reference matches the expected host of your sample.
- **Memory Management**: Processing a human-sized reference genome typically requires at least 8GB of available RAM. Using the `--LargeReference` flag for larger genomes will significantly increase memory requirements.
- **Recursive Discovery**: The tool searches the input folder recursively. Ensure the input directory only contains the samples you intend to process to avoid accidental filtering of unrelated data.
- **Verification**: After a run, check the `cmd.log` file generated in the output directory. This log contains the exact Minimap2 and Samtools commands executed, which is useful for troubleshooting or reporting.
- **Performance**: Increase the thread count (`-t`) based on your hardware capabilities to significantly reduce the time taken by the Minimap2 alignment phase.
- **Environment Isolation**: Always run SanitizeMe within its dedicated Conda environment to prevent dependency conflicts with other Samtools or Python versions.



## Subcommands

| Command | Description |
|---------|-------------|
| SanitizeMePaired_CLI.py | Sanitizes paired-end sequencing data by removing host sequences. |
| SanitizeMe_CLI.py | SanitizeMe CLI tool for processing sequencing data. |

## Reference documentation
- [SanitizeMe Main README](./references/github_com_jiangweiyao_SanitizeMe_blob_master_README.MD.md)
- [Paired-End CLI Implementation](./references/github_com_jiangweiyao_SanitizeMe_blob_master_SanitizeMePaired_CLI.py.md)
- [Single-End CLI Implementation](./references/github_com_jiangweiyao_SanitizeMe_blob_master_SanitizeMe_CLI.py.md)