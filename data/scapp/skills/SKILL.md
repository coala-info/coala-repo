---
name: scapp
description: SCAPP is a specialized pipeline that recovers plasmid sequences from metagenomic assembly graphs by identifying circular paths with plasmid-like characteristics. Use when user asks to identify plasmids in metagenomic samples, configure SCAPP runs, optimize assembly thresholds, or manage the alignment of reads to assembly graphs.
homepage: https://github.com/Shamir-Lab/SCAPP
---


# scapp

## Overview

SCAPP is a specialized pipeline designed to recover plasmid sequences from complex metagenomic samples. Unlike general-purpose assemblers, SCAPP focuses on identifying circular paths within an assembly graph that exhibit plasmid-like characteristics, such as specific read coverage patterns and the presence of plasmid-specific genes. It integrates classification scores from tools like PlasClass or PlasFlow to distinguish plasmid contigs from chromosomal fragments. Use this skill to configure SCAPP runs, optimize assembly thresholds, and manage the alignment of reads to assembly graphs.

## Command Line Usage

### Basic Execution
The standard workflow requires an assembly graph in FASTG format and paired-end reads.

```bash
scapp -g <assembly_graph.fastg> -o <output_directory> -r1 <reads_1.fq> -r2 <reads_2.fq> -k <max_k_value>
```

### Optimization with Pre-aligned Reads
If you have already run the alignment or are re-running SCAPP with different thresholds, use a BAM file to skip the time-consuming BWA alignment step:

```bash
scapp -g <assembly_graph.fastg> -o <output_directory> -b <alignment.bam> -k <max_k_value>
```

### Key Parameters
- `-k / --max_k`: Set this to the maximum k-mer length used by the assembler that generated the FASTG file (Default: 55).
- `-p / --num_processes`: Adjust based on available CPU cores (Default: 16).
- `-l / --min_length`: Minimum length for a sequence to be considered a potential plasmid (Default: 1000bp).

## Expert Tips and Best Practices

### Handling Assembly Graphs
SCAPP is designed to work with FASTG files, typically produced by assemblers like SPAdes or MEGAHIT. Ensure the graph contains the necessary connectivity information; if the graph is highly fragmented, plasmid recovery rates may decrease.

### Improving Classification Accuracy
- **PlasClass Integration**: SCAPP uses PlasClass by default. If you have pre-computed PlasClass scores, provide them via `-pc <plasclass.out>` to save time.
- **PlasFlow Alternative**: To use PlasFlow scores instead of PlasClass, use the `-pf <plasflow.out>` flag. Note that `-pc` and `-pf` are mutually exclusive.
- **Gene Hits**: By default, SCAPP uses plasmid-specific gene hits (`-gh True`). This is critical for identifying plasmids that might otherwise have ambiguous sequence compositions.

### Tuning Thresholds for Specific Samples
- **Coverage Variation**: If your sample has highly uneven coverage, you may need to increase the maximum coefficient of variation (`-m / --max_CV`, default 0.5) to allow for more fluctuation in read depth across a plasmid.
- **Classification Sensitivity**: If you suspect low-abundance plasmids are being filtered out, consider lowering the classification threshold (`-clft`, default 0.5).
- **Long Nodes**: Nodes that are significantly longer than typical plasmids are often treated as chromosomal. Adjust `-cst / --chromosome_score_thresh` (default 0.2) if your target plasmids are unusually large or have chromosome-like sequence signatures.

### Output Management
- **Primary Output**: The file `<prefix>.confident_cycs.fasta` contains the final predicted plasmid sequences.
- **Intermediate Analysis**: Check `intermediate_files/<prefix>_cycs.fasta` to see all cyclic paths identified before filtering. This is useful for troubleshooting why a specific sequence was or was not included in the final output.
- **Logs**: Review `logs/scapp.log` for detailed execution steps and to verify that external dependencies (BWA, BLAST+, samtools) were called correctly.

## Reference documentation
- [SCAPP GitHub Repository](./references/github_com_Shamir-Lab_SCAPP.md)
- [SCAPP Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scapp_overview.md)