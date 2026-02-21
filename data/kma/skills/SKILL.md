---
name: kma
description: KMA (k-mer alignment) is a specialized mapping tool designed to handle the challenges of redundant databases.
homepage: https://bitbucket.org/genomicepidemiology/kma
---

# kma

## Overview
KMA (k-mer alignment) is a specialized mapping tool designed to handle the challenges of redundant databases. Unlike traditional aligners that may struggle with multi-mapping reads in highly homologous gene families, KMA uses a seed-and-extend approach combined with a unique scoring system to accurately assign reads to the most likely template. It is particularly effective for identifying genes in raw data without the need for prior assembly.

## Core Workflows

### 1. Database Indexing
Before mapping, you must index your reference sequences (Fasta format).
```bash
kma index -i references.fasta -o database_name
```
*   **Tip**: For very large databases, ensure you have sufficient RAM or use the `-sparse` option to reduce the memory footprint of the index.

### 2. Mapping Raw Reads
Map single-end or paired-end reads against the indexed database.

**Single-end reads:**
```bash
kma -i reads.fastq.gz -o output_prefix -t_db database_name
```

**Paired-end reads:**
```bash
kma -ipe read1.fq read2.fq -o output_prefix -t_db database_name
```

### 3. Common CLI Patterns & Best Practices
*   **Handling Redundancy**: KMA's default behavior is optimized for redundant sets. If you are getting too many low-template-coverage hits, use `-mrs` (minimum relative score) to increase stringency (e.g., `-mrs 0.75`).
*   **Performance Tuning**: Use `-t` to specify the number of threads. For high-speed mapping on systems with limited RAM, consider using `-mem_mode` to load the index into memory once.
*   **Metagenomics**: When mapping against a large database like Silva or a custom species database, use `-md` to provide a minimum depth of coverage for a template to be reported.
*   **Output Interpretation**:
    *   `.res`: The primary results file showing template identification, coverage, and identity.
    *   `.mapstat`: Detailed statistics on the mapping process.
    *   `.aln`: The actual alignments (if requested).

### 4. Expert Tips
*   **CIGAR strings**: If you need standard BAM/SAM output for downstream tools, use the `-sam` flag, but note that KMA's native `.res` format is often more informative for gene-level identification.
*   **Quality Filtering**: While KMA is robust, trimming adapters and low-quality bases from raw reads before mapping can significantly improve the accuracy of identity calculations.
*   **Consensus Sequences**: KMA can produce a consensus sequence of the mapped reads using the `-bc` (base calling) flag, which is useful for variant calling within the identified templates.

## Reference documentation
- [kma - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_kma_overview.md)
- [genomicepidemiology / kma - Bitbucket](./references/bitbucket_org_genomicepidemiology_kma.md)