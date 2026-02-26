---
name: reffinder
description: reffinder is a stream-oriented utility for rapidly extracting bases and genomic regions from indexed FASTA files. Use when user asks to extract reference alleles at specific coordinates, retrieve nucleotide sequences for genomic ranges, or convert PLINK files to TPED format.
homepage: https://github.com/ANGSD/refFinder
---


# reffinder

## Overview
reffinder is a lightweight, stream-oriented utility designed for the rapid extraction of bases from genomic reference files. It utilizes htslib-based indexing to allow efficient random access to FASTA files without loading the entire sequence into memory. It is specifically optimized for bioinformatics workflows that require mapping coordinates to reference alleles, supporting both individual position lookups and bulk processing via piped input.

## Usage Patterns

### Basic Position Lookup
To extract a single base at a specific coordinate, pipe the chromosome and position (1-indexed) into the tool:
```bash
echo "chr7 10010" | reffinder hg19.fa.gz
```

### Extracting Genomic Regions
To extract a range of nucleotides, use the standard "chr:start-end" format:
```bash
echo "chr7:100-150" | reffinder hg19.fa.gz
```

### PLINK to TPED Conversion
reffinder can process PLINK .bim files to generate .tped files by extracting the reference bases for every SNP listed in the bim file:
```bash
cat data.bim | reffinder reference.fa plink full > output.tped
```

## Best Practices
- **Indexing**: Ensure your FASTA file is indexed (e.g., using `samtools faidx`). reffinder relies on these indexes for fast retrieval.
- **Compression**: Use bgzipped FASTA files (.fa.gz) to save disk space while maintaining random access capabilities.
- **Streaming**: Always prefer piping input (using `cat`, `head`, or `echo`) into reffinder rather than creating intermediate coordinate files, as the tool is optimized for stream processing.
- **Case Sensitivity**: The tool includes functionality to handle case conversion (toupper), ensuring consistent output regardless of the reference file's original formatting.

## Reference documentation
- [reffinder - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_reffinder_overview.md)
- [ANGSD/refFinder: Program/lib to extract bases from positions in fastafiles](./references/github_com_ANGSD_refFinder.md)