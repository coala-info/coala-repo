---
name: mist_typing
description: MiST is a bioinformatics tool designed for rapid allele identification and multilocus sequence typing in bacterial assemblies. Use when user asks to index MLST schemes, call alleles from genome assemblies, or assign sequence types to bacterial isolates.
homepage: https://github.com/BioinformaticsPlatformWIV-ISP/MiST
metadata:
  docker_image: "quay.io/biocontainers/mist_typing:1.2.0--pyhdfd78af_0"
---

# mist_typing

## Overview

MiST is a high-performance bioinformatics tool designed for the rapid identification of alleles in bacterial assemblies. It streamlines the MLST workflow by combining sequence clustering (via CD-HIT), alignment (via Minimap2), and a hashing-based lookup system to ensure both speed and accuracy. Use this skill to manage the end-to-end process of characterizing bacterial isolates, from initial scheme preparation to interpreting complex JSON and TSV outputs for phylogenetic analysis.

## Installation and Setup

Install MiST via Bioconda to ensure all dependencies (like Minimap2 and CD-HIT) are correctly configured:

```bash
conda install bioconda::mist_typing
```

Verify the installation:
```bash
mist --version
```

## Core Workflow

### 1. Scheme Preparation
MiST does not come with pre-installed schemes. You must obtain locus FASTA files and profile TSV files from public repositories like PubMLST, EnteroBase, or cgMLST.org.

### 2. Indexing a Scheme
Before calling alleles, you must create a searchable database index. This step clusters sequences and identifies representative "typing alleles."

**Basic Indexing:**
```bash
mist index locus1.fasta locus2.fasta locus3.fasta -o my_mlst_db
```

**Indexing with Profiles:**
If you have a profile definitions file (linking allele combinations to Sequence Types), include it to enable ST assignment:
```bash
mist index *.fasta --profiles profiles.tsv -o my_mlst_db
```

### 3. Calling Alleles
Once the index is created, you can query your draft genome assemblies (FASTA format).

**Standard Call:**
```bash
mist call --db my_mlst_db --fasta assembly.fasta --out-tsv results.tsv
```

**High-Performance Call:**
For large assemblies or core-genome schemes, use multi-threading and specify an output directory for detailed logs:
```bash
mist call --db my_mlst_db \
  --fasta assembly.fasta \
  --out-dir output_folder/ \
  --out-tsv output_folder/results.tsv \
  --threads 8 \
  --log output_folder/run.log
```

## Expert Tips and Best Practices

- **Intermediate Files**: Use the `--keep-minimap2` flag if you need to inspect the raw alignments. This is helpful for troubleshooting "novel allele" detections or low-quality matches.
- **Novel Alleles**: If MiST detects a sequence that does not exactly match the database, it will export the sequence to a `novel_alleles/` subdirectory. Always inspect these if you suspect a new strain variant.
- **Memory Management**: When indexing very large cgMLST schemes (thousands of loci), ensure your environment has sufficient RAM, as the clustering step can be resource-intensive.
- **Output Formats**: 
    - `mist.json`: The primary output containing full metadata, best matches, and allele hashes.
    - `results.tsv`: A simplified table ideal for quick review or input into downstream R/Python scripts.

## Reference documentation
- [MiST Wiki - Getting Started and Usage](./references/github_com_BioinformaticsPlatformWIV-ISP_MiST_wiki.md)
- [Bioconda mist_typing Overview](./references/anaconda_org_channels_bioconda_packages_mist_typing_overview.md)
- [MiST GitHub Repository](./references/github_com_BioinformaticsPlatformWIV-ISP_MiST.md)