---
name: mirdeep2
description: miRDeep2 is a bioinformatics suite used to discover and quantify microRNAs from high-throughput sequencing data. Use when user asks to map reads to a reference genome, identify novel or known miRNAs, or quantify miRNA expression levels.
homepage: https://www.mdc-berlin.de/8551903/en/research/research_teams/systems_biology_of_gene_regulatory_elements/projects/miRDeep
metadata:
  docker_image: "quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2"
---

# mirdeep2

## Overview
The `mirdeep2` suite is a specialized bioinformatics pipeline designed for the discovery and quantification of microRNAs from high-throughput sequencing data. It utilizes a probabilistic model to score the compatibility of sequenced RNAs with the biological signature of miRNA biogenesis (e.g., Dicer processing, hairpin stability). This skill provides the essential command-line workflows for mapping reads, running the core prediction algorithm, and generating comprehensive reports.

## Core Workflow and CLI Patterns

### 1. Preprocessing and Mapping
Before prediction, reads must be collapsed and mapped to a reference genome. The `mapper.pl` script handles these tasks.

```bash
# Collapse reads, clip adapters, and map to genome
mapper.pl reads.fastq -e -h -m -p genome_index -s reads_collapsed.fa -t reads_mapped.arf
```
- `-e`: Input is fastq format.
- `-h`: Parse to fasta format and discard reads with non-canonical characters.
- `-m`: Collapse identical reads.
- `-p`: Genome index (Bowtie).
- `-s`: Output file for processed reads.
- `-t`: Output file for mapped reads in ARF format.

### 2. miRNA Prediction and Discovery
The main module, `miRDeep2.pl`, identifies novel and known miRNAs.

```bash
miRDeep2.pl reads_collapsed.fa genome.fa reads_mapped.arf mature_ref.fa other_mature.fa precursors.fa -t Species
```
- `mature_ref.fa`: Mature miRNA sequences for the species being analyzed (from miRBase).
- `other_mature.fa`: Mature miRNA sequences from related species.
- `precursors.fa`: Precursor sequences for the species being analyzed.
- `-t`: Specify the species (e.g., Mouse, Human) to filter results.

### 3. Quantification
To quantify expression of known miRNAs without running the full discovery pipeline, use `quantifier.pl`.

```bash
quantifier.pl -p precursors.fa -m mature.fa -r reads_collapsed.fa -t Species
```

## Expert Tips
- **ARF Format**: Ensure your mapping output is in `.arf` format, which is specific to miRDeep2. If using external mappers, you must convert the output.
- **Read Length**: miRDeep2 performs best with reads between 18-25 nucleotides. Use the `mapper.pl` filtering options (`-l`) if your library contains significant noise.
- **Species Specificity**: Always provide the most closely related species' mature miRNAs in the `other_mature.fa` file to improve the log-odds scoring for novel miRNA candidates.
- **Output Inspection**: The primary output is an HTML report (`result.html`). Check the "miRDeep2 score" – higher scores (typically >10) indicate high-confidence miRNA candidates with strong structural and processing evidence.



## Subcommands

| Command | Description |
|---------|-------------|
| mirdeep2_mapper.pl | Processes reads and/or maps them to the genome index. |
| mirdeep2_quantifier.pl | The module maps the deep sequencing reads to predefined miRNA precursors and determines the counts for the respective mature miRNAs, star and loop sequences. |

## Reference documentation
- [N. Rajewsky Lab - Systems Biology of Gene Regulatory Elements](./references/www_mdc-berlin_de_n-rajewsky.md)