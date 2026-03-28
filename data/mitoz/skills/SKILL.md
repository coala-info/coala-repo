---
name: mitoz
description: MitoZ is a specialized bioinformatic pipeline that performs de novo assembly and annotation of animal mitochondrial genomes from raw sequencing data. Use when user asks to assemble mitochondrial genomes, annotate mitochondrial genes, filter raw reads for mitogenomics, or identify mitochondrial scaffolds from whole genome assemblies.
homepage: https://github.com/linzhi2013/MitoZ
---

# mitoz

## Overview
MitoZ is a specialized bioinformatic pipeline designed to transform raw genomic data into fully annotated animal mitochondrial genomes. It provides a "one-click" solution for the entire workflow—from read filtering and de novo assembly to gene annotation and circularity validation. It is particularly effective for researchers working with mitogenomics, phylogenetics, and biodiversity studies where high-quality mitochondrial assemblies are required from NGS data.

## Core Workflows

### The "One-Click" Assembly and Annotation
The `all` subcommand executes the entire pipeline (filter -> assemble -> findmitoscaf -> annotate -> visualize).

```bash
mitoz all --fq1 sample_1.fq.gz --fq2 sample_2.fq.gz \
          --outprefix sample_id \
          --thread_number 8 \
          --clade Chordata \
          --genetic_code 2 \
          --assembler megahit
```

### Targeted Subcommands
If you already have an assembly or specific intermediate files, use the modular subcommands:
- `filter`: Pre-process raw FastQ reads.
- `assemble`: Perform de novo mitochondrial assembly.
- `findmitoscaf`: Identify mitochondrial scaffolds from a larger assembly (e.g., a whole genome assembly).
- `annotate`: Annotate Protein-Coding Genes (PCGs), tRNAs, and rRNAs on a FASTA file.
- `visualize`: Generate circular maps from GenBank files.

## Expert Tips and Best Practices

### Data Volume Optimization
A common pitfall is using too much raw data. Using excessive data (e.g., >12 Gbp) can lead to fragmented or non-circular assemblies.
- **Recommendation**: Start with a subset of data (approx. 0.3 Gbp to 1.0 Gbp). This is often sufficient for mitochondrial genomes, runs significantly faster (approx. 10 mins), and increases the likelihood of obtaining a circularized result.

### Assembler Selection
MitoZ supports multiple assemblers via the `--assembler` flag:
- `megahit`: Generally faster and memory-efficient.
- `mitoassemble` (based on SOAPdenovo-Trans): The original default.
- `spades`: Often provides high-quality results for complex datasets.

### Environment Requirements
- **Shell**: Ensure your default shell is `bash`. Using other shells (like `zsh` or `dash`) can cause failures in tRNA annotation modules (specifically `cmsearch`).
- **Clade Specificity**: Always specify the correct `--clade` (e.g., Chordata, Arthropoda) and `--genetic_code` to ensure accurate gene prediction and HMM profile matching.

### Batch Processing
For multiple samples, you can automate the workflow using a simple loop. For the `annotate` subcommand specifically, you can pass multiple files directly:
```bash
mitoz annotate --fastafiles sample1.fa sample2.fa --outprefix batch_run --clade Chordata
```

## Utility Tools (`mitoz tools`)
MitoZ includes a suite of auxiliary commands for post-processing:
- `circle_check`: Verify if the assembled sequence is circular.
- `bold_identification`: Compare sequences against the BOLD database for taxonomic identification.
- `gbseqextractor`: Extract specific gene sequences (PCGs, rRNA, tRNA) from GenBank files.
- `msaconverter`: Convert between different Multiple Sequence Alignment formats.



## Subcommands

| Command | Description |
|---------|-------------|
| mitoz all | Run all steps for mitochondrial genome anlysis from input fastq files. |
| mitoz annotate | Annotate PCGs, tRNA and rRNA genes. |
| mitoz assemble | Mitochondrial genome assembly from input fastq files. |
| mitoz visualize | Visualize input GenBank file. |
| mitoz_filter | Filter input fastq reads. |
| mitoz_findmitoscaf | Search for mitochondrial sequences from input fasta file. |

## Reference documentation
- [MitoZ Wiki Home](./references/github_com_linzhi2013_MitoZ_wiki.md)
- [The 'all' subcommand](./references/github_com_linzhi2013_MitoZ_wiki_The--all--subcommand.md)
- [Batch processing guide](./references/github_com_linzhi2013_MitoZ_wiki_Batch-processing-of-many-samples.md)
- [MitoZ Tools Overview](./references/github_com_linzhi2013_MitoZ_wiki_Overview_3A-The--mitoz-tools--command.md)