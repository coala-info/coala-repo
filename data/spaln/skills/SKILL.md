---
name: spaln
description: spaln performs high-efficiency spliced alignments of cDNA, EST, or protein sequences to a reference genome. Use when user asks to map transcriptomic data to a genome, align protein sequences to genomic DNA, or identify exon-intron structures for genome annotation.
homepage: http://www.genome.ist.i.kyoto-u.ac.jp/~aln_user/spaln/
metadata:
  docker_image: "quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1"
---

# spaln

## Overview
The `spaln` skill provides specialized procedures for performing high-efficiency spliced alignments. It is the primary tool for researchers needing to map transcriptomic data (cDNA/EST) or protein sequences back to a reference genome. It excels at identifying exon-intron structures and handling large-scale genomic mapping in a single job, offering a stand-alone alternative to complex alignment pipelines.

## Common CLI Patterns

### Basic cDNA/EST to Genome Alignment
To map a set of cDNA sequences to a genome file:
```bash
spaln -g genome.fa -d cDNA_queries.fa > alignment.out
```

### Protein to Genome Alignment
When aligning protein sequences to a genomic sequence, use the `-t` flag to specify the query type:
```bash
spaln -tP -g genome.fa -d protein_queries.fa > protein_alignment.out
```

### Output Formats
`spaln` supports various output formats via the `-O` flag. Common options include:
- `-O0`: Default alignment format.
- `-O4`: GFF3 compatible output (useful for genome annotation).
- `-O12`: BED format.

Example for GFF3 output:
```bash
spaln -O4 -g genome.fa -d queries.fa > results.gff3
```

## Expert Tips
- **Memory Efficiency**: `spaln` is designed to be space-efficient. For very large genomes, ensure the genome index is pre-built using `sort-gff` or the included indexing utilities if the raw FASTA loading is too slow.
- **Species-Specific Parameters**: Use the `-S` flag to specify a species-specific parameter file (e.g., `-S human`) to improve splice site recognition accuracy based on known donor/acceptor consensus sequences.
- **Recursive Search**: For high-sensitivity mapping of distant homologs, consider adjusting the recursive search depth and gap penalties using the `-W` and `-Q` parameters.

## Reference documentation
- [spaln Overview](./references/anaconda_org_channels_bioconda_packages_spaln_overview.md)