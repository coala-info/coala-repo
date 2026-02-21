---
name: isorefiner
description: IsoRefiner is a bioinformatics tool designed to improve the accuracy of transcript isoform identification.
homepage: https://github.com/rkajitani/IsoRefiner
---

# isorefiner

## Overview
IsoRefiner is a bioinformatics tool designed to improve the accuracy of transcript isoform identification. By integrating long-read data with reference genomes and annotations, it reconciles outputs from various identification algorithms (such as Bambu, StringTie2, and IsoQuant) to produce a high-quality, refined GTF dataset. It is optimized for Oxford Nanopore cDNA reads but is compatible with other long-read technologies.

## Command Line Usage

### End-to-End Workflow
The most efficient way to use IsoRefiner is through the `trans_struct_wf` subcommand, which automates trimming, mapping, and multi-tool integration.

```bash
isorefiner trans_struct_wf \
  -r reads.fastq \
  -g genome.fasta \
  -a ref_annot.gtf \
  -t 32 \
  -o isorefiner_refined.gtf
```

### Step-by-Step Execution
For granular control over specific stages, use individual subcommands. This is recommended when you need to pass specific flags to underlying tools like Minimap2 or Porechop_ABI.

1.  **Trim Adapters**:
    ```bash
    isorefiner trim -r reads.fastq -t 8 -p "--check_reads 1000"
    ```
2.  **Map Reads**:
    ```bash
    isorefiner map -r trimmed.fastq -g genome.fasta -t 16 -m "-x splice -ub"
    ```
3.  **Run Identification Tools**:
    Execute specific tools supported by IsoRefiner:
    - `run_bambu`: Mapping-based identification.
    - `run_isoquant`: High-precision isoform quantification.
    - `run_stringtie`: Transcript assembly.
    - `run_espresso`: Error-corrected isoform identification.
    - `run_rnabloom`: Assembly-based identification.

### Handling Multiple Input Files
When working with multiple sequencing runs or samples, provide them as a space-delimited string within quotes:
```bash
isorefiner trans_struct_wf -r "sample1.fq sample2.fq sample3.fq" -g genome.fasta -a ref.gtf
```

## Best Practices and Expert Tips

- **Thread Allocation**: Use the `-t` flag across all subcommands to maximize parallelization, especially during the `map` and `trans_struct_wf` stages.
- **Memory Management**: When running the `map` subcommand, use the `-s` option to pass memory limits to `samtools sort` (e.g., `-s "-m 4G"`) to prevent OOM (Out of Memory) errors on large datasets.
- **Tool Customization**: Use the `-m` (Minimap2 options) and `-p` (Porechop_ABI options) flags to pass tool-specific parameters that are not exposed directly by the IsoRefiner CLI.
- **Working Directories**: By default, IsoRefiner creates directories named `isorefiner_{command}_work`. Use the `-d` flag to specify a custom directory to keep your workspace organized when running multiple iterations.
- **Input Formats**: IsoRefiner accepts FASTQ or FASTA files, and they can be gzipped (`.gz`).

## Reference documentation
- [IsoRefiner GitHub Repository](./references/github_com_rkajitani_IsoRefiner.md)
- [IsoRefiner Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_isorefiner_overview.md)