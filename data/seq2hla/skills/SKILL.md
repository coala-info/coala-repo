---
name: seq2hla
description: seq2HLA is an automated pipeline that leverages RNA-Seq sequence reads to provide comprehensive HLA profiling.
homepage: https://github.com/TRON-Bioinformatics/seq2HLA
---

# seq2hla

## Overview
seq2HLA is an automated pipeline that leverages RNA-Seq sequence reads to provide comprehensive HLA profiling. It maps reads against a specialized Bowtie index of HLA alleles to identify the most likely genotypes for both classical and non-classical HLA loci. This skill should be used in bioinformatics workflows where immune profiling or histocompatibility analysis is required from standard transcriptomic data, eliminating the need for dedicated HLA sequencing.

## Usage and Command Line Patterns

The primary interface is the `seq2HLA.py` script. It requires paired-end FASTQ files and a run name prefix.

### Basic Command
```bash
python seq2HLA.py -1 <readfile1.fastq> -2 <readfile2.fastq> -r "<runname>"
```

### Advanced Options
- **Parallelization**: Use `-p <int>` to specify the number of Bowtie search threads. The default is 6. Increasing this can significantly reduce processing time on high-core systems.
- **Quality Trimming**: Use `-3 <int>` to trim a specific number of bases from the low-quality (3') end of each read.
- **Compressed Inputs**: The tool supports both uncompressed and gzipped (`.gz`) FASTQ files.

### Input Requirements
- **Paired-end reads**: The tool is designed specifically for paired-end data.
- **Reference Directory**: Ensure the `references/` folder containing the Bowtie index files is located in the same directory as the script or is correctly mapped, as the tool expects these indices to be present for mapping.

## Interpreting Results

The tool generates several output files using the `<runname>` (prefix) provided:

- **4-Digit Genotypes**: `<prefix>-ClassI.HLAgenotype4digits` and `<prefix>-ClassII.HLAgenotype4digits`. These are the primary results for high-resolution typing.
- **2-Digit Genotypes**: `<prefix>-ClassI.HLAgenotype2digits` and `<prefix>-ClassII.HLAgenotype2digits`. Useful for broader serological group identification.
- **Expression Data**: `<prefix>-ClassI.expression` and `<prefix>-ClassII.expression`. Provides digital expression levels for the identified alleles.
- **Ambiguity Reports**: `<prefix>.ambiguity`. Check this file if the typing result suggests multiple equally likely allele solutions.

## Best Practices and Tips
- **Path Recognition**: In version 2.2 and later, the tool supports automatic path recognition, allowing it to be invoked from any directory as long as the dependencies are in the environment.
- **Read Length**: Modern versions automatically detect read length, so the `-l` parameter used in older versions is no longer required.
- **Cleanup**: Version 2.3+ automatically deletes intermediate files after execution to save disk space.
- **Loci Coverage**: Note that version 2.3 expanded support to include HLA II loci (DRA, DPA1, DPB1) and non-classical HLA I alleles (e.g., HLA-G).

## Reference documentation
- [seq2HLA GitHub Repository](./references/github_com_TRON-Bioinformatics_seq2HLA.md)