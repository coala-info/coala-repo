---
name: perl-retroseq
description: RetroSeq discovers and genotypes transposable element insertions by analyzing discordant read pairs and soft-clipped alignments from next-generation sequencing data. Use when user asks to identify non-reference transposable element variants, discover mobile element insertions, or call and genotype retrotransposon breakpoints from BAM files.
homepage: https://github.com/tk2/RetroSeq
metadata:
  docker_image: "quay.io/biocontainers/perl-retroseq:1.5--pl5321h7181c03_3"
---

# perl-retroseq

## Overview

RetroSeq is a specialized tool for the discovery and genotyping of transposable element variants (TEVs) from next-generation sequencing reads. It identifies insertions that are present in the sequenced sample but absent from the reference genome. The tool operates via a two-stage workflow: first, a discovery phase that identifies discordant read pairs and assigns them to specific TE classes; second, a calling phase that clusters these reads, refines breakpoints using soft-clipped information, and outputs calls in VCF format.

## Installation and Dependencies

RetroSeq requires `samtools`, `bedtools`, and `exonerate` to be available in your PATH. It is most reliably used with BAM files produced by BWA or MAQ.

```bash
# Installation via Bioconda
conda install bioconda::perl-retroseq
```

## Phase 1: Discovery

The discovery phase scans the BAM file for discordant mate pairs. You must provide either a library of TE sequences for alignment or a BED file of reference TE locations for faster assignment.

### Using Reference TEs (Fastest)
Use this mode if you have a BED file of known TE locations in the reference genome. This avoids expensive computational alignment.
```bash
retroseq.pl -discover -bam input.bam -output candidates.txt -refTEs te_types_and_locations.tab
```
*Note: The `-refTEs` file should be a tab-delimited file mapping TE types to their respective BED files.*

### Using Alignment Mode
Use this mode to align discordant reads against a library of consensus TE sequences.
```bash
retroseq.pl -discover -bam input.bam -eref te_sequences.tab -output candidates.txt -align
```
*Note: The `-eref` file maps TE types to Fasta files. The `-align` flag triggers the Exonerate alignment step.*

### Key Discovery Parameters
- `-q`: Minimum mapping quality for the anchor read (default: 30).
- `-id`: Minimum percent identity for TE alignment (default: 90).
- `-len`: Minimum length of a hit to the TE reference (default: 36bp).
- `-exd`: Provide a file of BED files (Fofn) to exclude regions like centromeres or simple repeats.

## Phase 2: Calling

The calling phase clusters the candidate reads and performs breakpoint analysis.

```bash
retroseq.pl -call -bam input.bam -input candidates.txt -ref reference.fasta -output final_calls.vcf
```

### Advanced Calling Options
- **Genotyping**: Use `-hets` to attempt to call heterozygous insertions (default is homozygous).
- **Filtering**: Use `-filter` with a tab file of TE types and BED files to ignore calls that overlap known reference elements.
- **Depth Control**: Use `-depth` (default: 200) to set the maximum average depth for a region; regions exceeding this are often repetitive or problematic.
- **Support Threshold**: Adjust `-reads` (default: 5) to change the minimum number of supporting reads required for a call.

## Interpreting Output

The output is a VCF file. Key metadata includes:
- **GQ (Genotype Quality)**: Represents the number of supporting reads.
- **FL (Filter Level)**: A scale from 1-8 indicating breakpoint confidence. 
    - **FL 8**: Highest confidence, meeting all breakpoint criteria (5' and 3' support).
    - **Lower FL**: Indicates missing criteria, such as lack of support on one side of the insertion.

## Common CLI Patterns

### Parallelizing Discovery
You can run the discovery phase on individual chromosomes or read groups and then provide a list of all discovery output files to the calling phase:
```bash
# Calling with multiple discovery inputs
retroseq.pl -call -bam input.bam -input discovery_files.fofn -ref reference.fasta -output combined_calls.vcf
```

### Targeted Calling
To limit calling to a specific genomic region:
```bash
retroseq.pl -call -bam input.bam -input candidates.txt -ref reference.fasta -output region_calls.vcf -region chr1:1000000-2000000
```

## Reference documentation
- [RetroSeq GitHub Repository](./references/github_com_tk2_RetroSeq.md)
- [Bioconda perl-retroseq Overview](./references/anaconda_org_channels_bioconda_packages_perl-retroseq_overview.md)