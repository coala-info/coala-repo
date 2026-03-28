---
name: fermikit
description: FermiKit is a de novo assembly-based pipeline for identifying SNPs, short indels, and complex structural variants from high-depth Illumina data. Use when user asks to assemble reads into unitigs, call variants against a reference genome, or detect large deletions and novel insertions.
homepage: https://github.com/lh3/fermikit
---


# fermikit

## Overview

FermiKit is a specialized pipeline designed for high-depth Illumina data that utilizes de novo assembly rather than simple mapping to identify genetic variations. By assembling reads into unitigs before mapping, it excels at detecting complex structural variants, long deletions, and novel insertions that traditional mapping-based pipelines might miss. It is highly efficient, capable of processing a 30x human genome in approximately 24 hours on a 16-core machine.

## Installation and Setup

To build FermiKit from source, ensure `zlib` is installed on your system:

```bash
git clone --recursive https://github.com/lh3/fermikit.git
cd fermikit
make
```

The build process creates a `fermi.kit` directory containing all necessary executables. You can move this directory to any location and call the tools using their relative or absolute paths.

## Core Workflow

### 1. Assembly into Unitigs
The first step generates a Makefile to manage the assembly process. You must provide the estimated genome size (`-s`) and the read length (`-l`).

```bash
# Generate the makefile
fermi.kit/fermi2.pl unitig -s3g -t16 -l150 -p prefix reads.fq.gz > prefix.mak

# Execute the assembly
make -f prefix.mak
```

### 2. Variant Calling
Once the assembly (`prefix.mag.gz`) is generated, use `run-calling` to identify variants against a BWA-indexed reference genome.

```bash
fermi.kit/run-calling -t16 bwa-indexed-ref.fa prefix.mag.gz | sh
```

**Outputs:**
*   `prefix.flt.vcf.gz`: Filtered SNPs and short INDELs.
*   `prefix.sv.vcf.gz`: Structural variations (long deletions, novel insertions, translocations).

## Advanced CLI Patterns

### Pre-processing with Adapter Trimming
If your raw data contains adapters, you can pipe trimmed reads directly into the assembly command using `seqtk` and `trimadap-mt`:

```bash
fermi.kit/fermi2.pl unitig -s3g -t16 -l150 -p prefix \
  "fermi.kit/seqtk mergepe r1.fq r2.fq | fermi.kit/trimadap-mt -p4" > prefix.mak
```

### Multi-sample Pileup
To call variants across multiple samples simultaneously and produce a joint VCF:

```bash
# Generate raw multi-sample VCF
fermi.kit/htsbox pileup -cuf ref.fa sample1.srt.bam sample2.srt.bam > out.raw.vcf

# Filter and summarize
fermi.kit/k8 fermi.kit/hapdip.js vcfsum -f out.raw.vcf > out.flt.vcf
```

## Expert Tips and Limitations

*   **Memory Management**: While generally efficient (~85GB RAM for human 30x), the error correction phase (BFC) may spike in RAM usage if the input data has an unusually high error rate.
*   **Deterministic Behavior**: Running the pipeline twice on the same data may result in slightly different assemblies due to multi-threading randomness in the BFC and unitig construction phases. However, variant calls from the same assembly remain consistent.
*   **Paired-End Data**: FermiKit treats reads as single-end during assembly. For modern Illumina data with overlapping pairs, it is recommended to merge them before assembly to improve results.
*   **Genome Size**: Always specify an accurate genome size with the `-s` flag (e.g., `3g` for human, `100m` for C. elegans) to ensure proper k-mer counting and error correction.



## Subcommands

| Command | Description |
|---------|-------------|
| fermi2.pl | fermi2.pl is a Perl script for de novo genome assembly using the Fermi assembler. |
| fermitool | A tool for adapter trimming. |
| htsbox | A collection of htslib-based tools for sequence data manipulation. |
| run-calling | Calling |
| seqtk | A toolkit for processing sequences. |

## Reference documentation
- [FermiKit GitHub Repository](./references/github_com_lh3_fermikit.md)