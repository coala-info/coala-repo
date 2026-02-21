---
name: transannot
description: TransAnnot is a high-performance toolkit designed for the functional characterization of newly sequenced transcriptomes.
homepage: https://github.com/soedinglab/transannot
---

# transannot

## Overview
TransAnnot is a high-performance toolkit designed for the functional characterization of newly sequenced transcriptomes. By leveraging MMseqs2 for rapid sequence-to-profile and sequence-to-sequence searches, it identifies homologs to infer protein functions, structural domains, and orthologous groups. The tool is modular, allowing users to start from raw sequencing reads (using the integrated Plass assembler) or pre-assembled sequences, though it is optimized for amino acid inputs.

## Core Workflows

### 1. Database Preparation
Before running annotations, you must download the required reference databases. This is a one-time setup.

```bash
# Download eggNOG
transannot downloaddb eggNOG <path_to_output>/eggNOGDB <tmp_dir>

# Download Pfam
transannot downloaddb Pfam <path_to_output>/PfamDB <tmp_dir>

# Download SwissProt
transannot downloaddb SwissProt <path_to_output>/SwissProtDB <tmp_dir>
```

### 2. Recommended Workflow (Amino Acid Input)
For maximum efficiency, translate your assembly (e.g., using TransDecoder) into amino acids before running TransAnnot.

1. **Create a Query Database:**
   ```bash
   transannot createquerydb input_proteins.fasta queryDB_name <tmp_dir>
   ```

2. **Run Annotation:**
   ```bash
   transannot annotate queryDB_name Pfam-A.full eggNOG UniProtKB/Swiss-Prot resDB <tmp_dir>
   ```

### 3. One-Step Workflow (Raw Reads)
If starting from raw FASTQ reads, use the `easytransannot` module which handles assembly via Plass and subsequent annotation.

```bash
transannot easytransannot inputReads.fastq Pfam-A.full eggNOG UniProtKB/Swiss-Prot resDB <tmp_dir>
```

## Module Reference
- `assemblereads`: De novo assembly of raw reads into genomic fragments.
- `createquerydb`: Converts FASTA input into memory-efficient MMseqs2 format.
- `downloaddb`: Fetches reference databases (eggNOG, Pfam, SwissProt).
- `annotate`: Performs clustering to reduce redundancy and executes homology searches.
- `easytransannot`: Wraps assembly and annotation into a single command.

## Expert Tips and Best Practices
- **Input Length:** If using the internal Plass assembler via `easytransannot`, ensure your reads are at least 100nt long. For shorter reads, use a nucleotide assembler like Trinity first.
- **Performance:** Always prefer Option C (Amino Acid sequences). Searching against translated nucleotide sequences is significantly slower than direct protein-level searches.
- **Storage Management:** TransAnnot generates large intermediate files. Use the `--remove-tmp-files` parameter to automatically clean the `tmp` folder after execution.
- **Resource Allocation:** When compiling from source on macOS, use `gcc` instead of `clang` for better optimization.
- **Database Paths:** If a database is already available locally in MMseqs2 format, provide the absolute path; otherwise, providing the name (e.g., `eggNOG`) will trigger an automatic download.

## Reference documentation
- [TransAnnot GitHub README](./references/github_com_soedinglab_transannot.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_transannot_overview.md)