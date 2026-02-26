---
name: shigeifinder
description: ShigEiFinder differentiates between *Shigella* species and enteroinvasive *Escherichia coli* (EIEC) using genomic serotyping and cluster-specific gene profiling. Use when user asks to differentiate *Shigella* from EIEC, serotype assembled genomes, or identify *Shigella* serotypes from raw sequencing reads.
homepage: https://github.com/LanLab/ShigEiFinder
---


# shigeifinder

## Overview

ShigEiFinder is a specialized bioinformatic tool designed to differentiate between Shigella species and EIEC, which are often difficult to distinguish using standard genomic methods. It utilizes a cluster-specific gene approach combined with O-antigen and H-antigen profiling to provide high-resolution serotyping. The tool is essential for clinical microbiology and public health surveillance where precise identification of Shigella serotypes or EIEC clusters is required from either raw sequencing data or finished assemblies.

## Command Line Usage

### Basic Serotyping (Assemblies)
To serotype one or more assembled genomes (FASTA format):
```bash
shigeifinder -i assembly1.fasta [assembly2.fasta ...] --output results.tsv
```

### Serotyping Raw Reads
When using raw Illumina reads, you must include the `-r` flag.
**Paired-end reads:**
```bash
shigeifinder -r -i sample_R1.fastq.gz sample_R2.fastq.gz --output results.tsv
```
**Single-end reads:**
```bash
shigeifinder -r --single_end -i sample.fastq.gz --output results.tsv
```

### Performance and Resource Management
*   **Threading:** Use `-t` to specify CPU cores (default is 4).
*   **Memory Issues:** If the tool runs but reports no genes mapped, it is often a sign of insufficient RAM. Increase the memory allocation for the process.
*   **Temporary Files:** Use `--tmpdir <path>` to specify where intermediate files are stored, especially if the default directory has space constraints.

## Expert Parameters and Tuning

### Depth Thresholds
When working with low-coverage or contaminated read sets, you can tune the sensitivity of gene calls:
*   `--o_depth`: Minimum depth percentage relative to genome average for O-antigen genes (default: 1).
*   `--ipaH_depth`: Minimum depth percentage for the ipaH virulence gene (default: 1).
*   `--depth`: Minimum read depth for other genes (default: 10).

### Advanced Diagnostics
*   `--hits`: Highly recommended for validation. This outputs the specific gene sets used for identification and the raw BLAST/mapping results.
*   `--dratio`: Displays the depth ratio of cluster-specific genes compared to 7 housekeeping (HK) genes. This helps assess the presence of the virulence plasmid or specific genomic clusters relative to the core genome.

## Best Practices
*   **Input Order:** When providing paired-end reads, ensure the forward read (R1) is listed before the reverse read (R2).
*   **Database Updates:** If you manually add new sequences to the internal FASTA database, run with `--update_db` to refresh intermediate index files.
*   **Output Handling:** By default, results are sent to `stdout`. Always use `--output` to save results to a TSV file for downstream analysis in Excel or R.
*   **Dependency Check:** Run `shigeifinder --check` before starting large batches to ensure `bwa`, `blastn`, and `samtools` are correctly configured in your PATH.

## Reference documentation
- [ShigEiFinder GitHub Repository](./references/github_com_LanLab_ShigEiFinder.md)
- [ShigEiFinder Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_shigeifinder_overview.md)