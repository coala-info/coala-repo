---
name: perl-bio-bpwrapper
description: Perl-bio-bpwrapper provides command-line utilities that expose BioPerl functionality for rapid biological data processing and file manipulation. Use when user asks to convert sequence formats, extract genomic features, manipulate multiple sequence alignments, prune phylogenetic trees, or parse search results from BLAST and HMMER.
homepage: http://metacpan.org/pod/Bio::BPWrapper
metadata:
  docker_image: "quay.io/biocontainers/perl-bio-bpwrapper:1.15--pl5321hdfd78af_0"
---

# perl-bio-bpwrapper

## Overview
The `perl-bio-bpwrapper` package provides a set of powerful command-line utilities that expose BioPerl's functionality through a consistent, Unix-style interface. It is best used for rapid data processing in pipelines where you need to transform biological file formats, extract specific features from genomic records, or manipulate multiple sequence alignments (MSA) using simple flags rather than complex scripts.

## Core Utilities and Usage Patterns

The suite is organized into several primary commands based on the data type:

### 1. bio-seq (Sequence Manipulation)
Use for single or multiple sequence files (FASTA, GenBank, EMBL).
- **Format Conversion**: `bio-seq -i input.gb -f fasta > output.fa`
- **Filtering by Length**: `bio-seq -i input.fa --length ">1000"`
- **Feature Extraction**: Extract specific tags (e.g., gene, CDS) from GenBank files:
  `bio-seq -i input.gb --extract "gene"`
- **Slicing**: `bio-seq -i input.fa --slice "100..500"`

### 2. bio-aln (Alignment Processing)
Use for multiple sequence alignments (Clustal, PHYLIP, Stockholm).
- **Format Conversion**: `bio-aln -i input.aln -f phylip > output.phy`
- **Slicing Columns**: `bio-aln -i input.aln --slice "10..50"`
- **Removing Gaps**: `bio-aln -i input.aln --remove-gaps`
- **Consensus Sequence**: `bio-aln -i input.aln --consensus`

### 3. bio-tree (Phylogenetic Trees)
Use for Newick or Nexus tree files.
- **Format Conversion**: `bio-tree -i input.tre -f nexus`
- **Node Manipulation**: Rename nodes or prune specific taxa.
- **Statistics**: Get basic tree metrics like number of leaves or branch lengths.

### 4. bio-search (Search Result Parsing)
Use for BLAST, HMMER, or Exonerate output.
- **Filtering Hits**: Filter results by E-value or bit score.
- **Tabular Output**: Convert complex search reports into easy-to-parse TSV/CSV formats.

## Best Practices
- **Input/Output**: Most tools use `-i` for input and standard output for results. Always specify the input format if the file extension is non-standard using the `-f` flag.
- **Piping**: These tools are designed to work in pipes. You can pipe the output of `bio-seq` (as FASTA) directly into `bio-aln` or other CLI tools.
- **Help**: Use `--help` with any sub-command (e.g., `bio-seq --help`) to see the full list of available attributes and filtering options, as the suite is highly modular.

## Reference documentation
- [Bio::BPWrapper Documentation](./references/metacpan_org_pod_Bio__BPWrapper.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-bpwrapper_overview.md)