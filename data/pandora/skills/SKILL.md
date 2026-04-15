---
name: pandora
description: Pandora performs nucleotide-resolution bacterial pangenomics by mapping reads to a pangenome reference graph to identify loci and call variants. Use when user asks to index a pangenome reference graph, map long or short reads to a graph, compare multiple samples to generate a pangenome matrix, or discover novel variants.
homepage: https://github.com/rmcolq/pandora
metadata:
  docker_image: "quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0"
---

# pandora

## Overview

Pandora is a specialized bioinformatics tool designed for nucleotide-resolution bacterial pangenomics. Unlike traditional mappers that align reads to a single linear reference, Pandora uses a Pangenome Reference Graph (PanRG)—a collection of local graphs representing orthologous regions (genes, intergenic regions, etc.). This approach mitigates reference bias and allows for more accurate genotyping in highly diverse bacterial populations.

## Core Workflows

### 1. Indexing the PanRG
Before mapping, you must index the PanRG file (typically a fasta-like file containing graph markers).
```bash
pandora index -t <threads> <panrg.fa>
```
*Note: This generates a `.zip` index and a directory of GFA files in the same location as the input.*

### 2. Single Sample Analysis (map)
Use `map` to identify which loci are present and infer their sequences.
```bash
# For Nanopore reads
pandora map <panidx.zip> <reads.fq.gz>

# For Illumina reads (genotyping enabled)
pandora map --genotype --illumina <panidx.zip> <reads.fq.gz>
```

### 3. Multi-sample Comparison (compare)
Use `compare` to generate a pangenome matrix and a multisample VCF.
```bash
# Requires a tab-delimited read_index.tab (SampleID\tPathToReads)
pandora compare --genotype --illumina --max-covg 30 <panidx.zip> <read_index.tab>
```

### 4. Novel Variant Discovery (discover)
Use `discover` to find variation not present in the initial PanRG by using Racon to polish inferred sequences.
```bash
pandora discover <panidx.zip> <reads.fq.gz>
```

## Expert Tips and Best Practices

- **Input Preparation**: Pandora does not have a native paired-end mode for Illumina. Concatenate `R1` and `R2` files into a single fastq before processing.
- **Coverage Limits**: Pandora stops reading input files once a global coverage threshold is reached (default 300X). If your fastq is sorted by genomic position, this may result in missing data at the end of the genome. Ensure reads are randomized or adjust `--max-covg`.
- **VCF Reference**: The VCF output is relative to an "inferred" reference path through the graph (found in `*_multisample.vcf_ref.fa`) designed to minimize the distance to your samples. Do not assume it matches a standard NCBI reference.
- **GAPS Field**: In Pandora VCFs, the `GAPS` field indicates the fraction of kmers covering an allele that had zero coverage. High GAPS values suggest the called allele may be incorrect or absent.
- **Memory/Performance**: Use the `-t` flag to specify threads during indexing and mapping. For large pangenomes, ensure sufficient RAM is available for the graph structures.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/pandora compare | Quasi-map reads from multiple samples to an indexed PRG, infer the sequence of present loci in each sample, and call variants between the samples. |
| /usr/local/bin/pandora discover | Quasi-map reads to an indexed PRG, infer the sequence of present loci in the sample and discover novel variants. |
| /usr/local/bin/pandora random | Outputs a fasta of random paths through the PRGs |
| /usr/local/bin/pandora walk | Outputs a path through the nodes in a PRG corresponding to the either an input sequence (if it exists) or the top/bottom path |
| pandora get_vcf_ref | Outputs a fasta suitable for use as the VCF reference using input sequences |
| pandora index | Index population reference graph (PRG) sequences. |
| pandora map | Quasi-map reads to an indexed PRG, infer the sequence of present loci in the sample, and optionally genotype variants. |
| pandora merge_index | Allows multiple indices to be merged (no compatibility check) |
| pandora seq2path | For each sequence, return the path through the PRG |

## Reference documentation
- [Usage Guide](./references/github_com_iqbal-lab-org_pandora_wiki_Usage.md)
- [FAQ](./references/github_com_iqbal-lab-org_pandora_wiki_FAQ.md)
- [Exploring Output Files](./references/github_com_iqbal-lab-org_pandora_wiki_Exploring-pandora-extra-files.md)