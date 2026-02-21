---
name: centrifuger
description: Centrifuger is a high-performance taxonomic classifier designed for metagenomic analysis.
homepage: https://github.com/mourisl/centrifuger
---

# centrifuger

## Overview
Centrifuger is a high-performance taxonomic classifier designed for metagenomic analysis. It excels at mapping sequencing reads to large-scale reference databases by utilizing a novel lossless compression technique. This allows researchers to perform accurate classification against comprehensive datasets—such as the entire RefSeq prokaryotic collection—on standard hardware that might otherwise lack the memory to load uncompressed indices. The workflow typically involves building a compressed index, classifying reads to identify their taxonomic origin, and optionally performing quantification to estimate relative abundances.

## Installation
The most efficient way to install centrifuger is via Bioconda:
```bash
conda install -c conda-forge -c bioconda centrifuger
```

## Core Workflows

### 1. Building an Index
To build a custom index, you need reference FASTA files and NCBI-style taxonomy files (`nodes.dmp` and `names.dmp`).

**Basic Build:**
```bash
centrifuger-build -r references.fa --taxonomy-tree nodes.dmp --name-table names.dmp -o my_index
```

**Memory-Optimized Build:**
For large databases, use `--build-mem` to specify available RAM. Centrifuger will automatically calculate the best block size (`bmax`) and difference cover (`dcv`).
```bash
centrifuger-build -l reference_list.txt --taxonomy-tree nodes.dmp --name-table names.dmp --build-mem 32G -o large_index
```
*Note: The `-l` option expects a file with one sequence file path per row, or two columns: `file_path taxID`.*

### 2. Taxonomic Classification
Classify reads against a pre-built or custom index.

**Paired-End Reads:**
```bash
centrifuger -x my_index -1 reads_1.fq.gz -2 reads_2.fq.gz -t 8 > classification.tsv
```

**Single-End Reads:**
```bash
centrifuger -x my_index -u reads.fq.gz -t 8 > classification.tsv
```

**Key Options:**
- `-k <int>`: Report up to N distinct assignments per read (default is 1).
- `--min-hitlen <int>`: Minimum length of partial hits to consider.
- `--report-kmer-counts`: Useful for specific downstream analysis.

### 3. Quantification (Taxonomic Profiling)
After classification, use the results to estimate the abundance of different taxa.

```bash
centrifuger-quant -x my_index -c classification.tsv > abundance_report.tsv
```

**Output Formats:**
- `--output-format 0`: Standard Centrifuge-style report (default).
- `--output-format 1`: MetaPhlAn-style report.
- `--output-format 2`: CAMI-style report.

## Expert Tips and Best Practices
- **Pre-built Indices**: Before building your own, check for pre-built indices for RefSeq, GTDB, or NCBI core nt. These are often hosted on Zenodo or Dropbox by the maintainers.
- **Checkpointing**: When building massive indices, use the `--checkpoint` flag. This allows you to resume the process if the build is interrupted.
- **Read Merging**: For short-insert paired-end libraries, use `--merge-readpair` during the classification step to improve accuracy by merging overlapping reads.
- **Memory Usage**: Centrifuger's primary advantage is its low memory footprint during classification. For example, the 2023 RefSeq prokaryotic database (~140G nucleotides) can be searched using only ~43 GB of RAM.
- **Taxonomy Mapping**: If your reference FASTA headers do not contain TaxIDs, you must provide a conversion table using `--conversion-table` during the build step.

## Reference documentation
- [Centrifuger GitHub Repository](./references/github_com_mourisl_centrifuger.md)
- [Bioconda Centrifuger Package](./references/anaconda_org_channels_bioconda_packages_centrifuger_overview.md)