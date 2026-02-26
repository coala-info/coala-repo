---
name: seqprep-data
description: SeqPrep trims adapter sequences from paired-end reads and merges overlapping reads into single, higher-quality sequences. Use when user asks to trim adapters from sequencing data, merge overlapping paired-end reads, or handle read-through in short DNA fragments.
homepage: https://github.com/jstjohn/SeqPrep
---


# seqprep-data

## Overview
SeqPrep is a specialized utility designed to handle the "read-through" problem in paired-end sequencing. When a DNA fragment is shorter than the number of cycles sequenced, the machine reads into the adapter sequence. SeqPrep identifies these adapters, trims them, and uses the resulting overlap to merge the two reads into a single, higher-quality long read. It can also be used strictly for adapter trimming without merging. This skill provides the procedural knowledge to configure SeqPrep's alignment parameters and validate adapter sequences for optimal data cleaning.

## Installation and Setup
SeqPrep is most easily managed via Bioconda.
```bash
conda install -c bioconda seqprep
```

## Core Command Line Usage
The tool requires four primary file arguments and an optional fifth for merged output. Note that all outputs are automatically gzip-compressed.

### Basic Trimming and Merging
```bash
SeqPrep -f input_R1.fastq.gz -r input_R2.fastq.gz -1 output_R1.fastq.gz -2 output_R2.fastq.gz -s merged.fastq.gz
```

### Key Parameters
- **Input/Output**: `-f` (forward input), `-r` (reverse input), `-1` (forward output), `-2` (reverse output).
- **Merging**: `-s` (filename for merged reads). If this is omitted, the tool only performs trimming.
- **Quality Format**: Use `-6` if the input is in Phred+64 (older Illumina) format. The output will always be Phred+33.
- **Filtering**:
  - `-L <int>`: Minimum length of a read to keep it in the output (default: 30).
  - `-q <int>`: Quality score cutoff for mismatches in the overlap (default: 13).

## Adapter Trimming Best Practices
SeqPrep searches for adapter sequences exactly as they appear in the data. It does not automatically reverse-complement them.

### 1. Validate Adapters with Grep
Before running SeqPrep, verify your adapter sequences against your raw data to ensure they are present and correctly oriented.
```bash
# Check forward adapter hits
zcat input_R1.fastq.gz | head -n 1000000 | grep "YOUR_ADAPTER_SEQ" | wc -l

# Check reverse adapter hits
zcat input_R2.fastq.gz | head -n 1000000 | grep "YOUR_ADAPTER_SEQ" | wc -l
```
*Expert Tip: Use approximately 20bp of the adapter sequence for these checks.*

### 2. Common Adapter Parameters
If using standard Illumina adapters, you may need to override the defaults:
- `-A GATCGGAAGAGCACACG`: Forward read adapter.
- `-B AGATCGGAAGAGCGTCGT`: Reverse read adapter.
- `-O <int>`: Minimum overlap required with the adapter to trigger trimming (default: 10).

## Advanced Merging Logic
SeqPrep is designed for high specificity to prevent false merges in libraries where few reads are expected to overlap.

- **Mismatch Control**: 
  - `-M <float>`: Maximum fraction of mismatching bases allowed for adapter overlap (default: 0.02).
  - `-m <float>`: Maximum fraction of mismatching bases allowed for read merging (default: 0.02).
- **Overlap Requirements**:
  - `-o <int>`: Minimum base pair overlap required to merge R1 and R2 (default: 15).
- **Visual Inspection**:
  - Use `-E <filename>` to write "pretty" alignments to a text file. This is highly recommended during initial parameter tuning to verify that the merging logic is behaving as expected.
  - `-x <int>`: Limit the number of pretty alignments generated (default: 10000).

## Troubleshooting and Tips
- **Empty Merged File**: If the `-s` file is empty or very small, check if your insert sizes are actually shorter than your read lengths. If fragments are long, there is no overlap to merge.
- **Binary-like Quality Strings**: If the output quality scores look like garbled binary, you likely have a Phred+33/64 mismatch. Toggle the `-6` flag.
- **Masking vs. Trimming**: If you prefer to keep the read length constant but hide adapter sequences, use the `-z` flag to replace adapters with 'N' characters instead of clipping them.
- **Different Read Lengths**: If R1 and R2 were sequenced with different cycle counts, use the `-g` flag to print the overhang when adapters are stripped.

## Reference documentation
- [SeqPrep GitHub Repository](./references/github_com_jstjohn_SeqPrep.md)
- [Bioconda SeqPrep Overview](./references/anaconda_org_channels_bioconda_packages_seqprep_overview.md)