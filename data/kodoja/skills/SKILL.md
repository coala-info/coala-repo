---
name: kodoja
description: Kodoja is a specialized pipeline that detects viral pathogens in plant samples by combining nucleotide and protein-level sequence matching. Use when user asks to search for viruses in sequencing data, build custom viral databases, or retrieve specific viral sequences for downstream analysis.
homepage: https://github.com/abaizan/kodoja/
metadata:
  docker_image: "quay.io/biocontainers/kodoja:0.0.10--0"
---

# kodoja

## Overview
Kodoja is a specialized pipeline designed to detect viral pathogens in plant samples. It leverages a dual-tool approach: Kraken for nucleotide-level k-mer profiling and Kaiju for protein-level sequence matching. This combination increases sensitivity and reliability in identifying known and divergent viruses. The workflow typically follows a three-step process: building or obtaining a database, searching sequencing reads against that database, and retrieving specific sequences of interest for downstream analysis.

## Core Workflows

### 1. Searching for Viruses
Use `kodoja_search.py` to classify raw sequencing data. This script automatically handles quality control (FastQC) and adapter trimming (Trimmomatic) before classification.

**Basic Command (Paired-end):**
```bash
kodoja_search.py -r1 reads_1.fastq -r2 reads_2.fastq \
                 --kraken_db path/to/krakenDB \
                 --kaiju_db path/to/kaijuDB \
                 -o output_directory \
                 --threads 8
```

**Key Parameters:**
- `--data_format`: Specify `fasta` or `fastq` (default).
- `--host_subset`: Provide the NCBI TaxID of the host to filter out host reads from the final summary table.
- `--trim_minlen`: Minimum read length to keep after trimming (default: 50).
- `--kaiju_mismatch`: Number of mismatches allowed (default: 1).

### 2. Building Custom Databases
Use `kodoja_build.py` to create specialized databases containing specific host genomes or additional viral sequences.

**Standard Build (All Viruses):**
```bash
kodoja_build.py -o custom_db_dir --all_viruses --threads 4
```

**Including a Specific Host (e.g., Arabidopsis - TaxID 3702):**
```bash
kodoja_build.py -o custom_db_dir -p 3702
```

**Adding Local Genomes (Non-RefSeq):**
```bash
kodoja_build.py -o custom_db_dir -e local_genome.fna -x 267555
```

### 3. Retrieving Viral Reads
After a search, use `kodoja_retrieve.py` to extract the actual sequences assigned to a specific virus for assembly or verification.

**Extracting a Specific Virus (by TaxID):**
```bash
kodoja_retrieve.py --file_dir search_output_dir \
                   -r1 original_1.fastq -r2 original_2.fastq \
                   -t 322019 \
                   -o subset_output
```

**Advanced Retrieval:**
- `--stringent`: Only extract reads where both Kraken and Kaiju agree on the identification.
- `--genus`: Include all reads classified at the genus level for the specified TaxID.

## Expert Tips
- **Database Location**: Do not place your input sequencing data inside the output directory, as this can cause execution errors.
- **Memory Management**: Kraken and Kaiju databases are memory-intensive. Ensure the system has enough RAM to load the `.kdb` and `.fmi` files.
- **Low Complexity Filtering**: Always use the `-x` parameter for Kaiju (enabled via the wrapper logic) to filter low-complexity regions and reduce false positives.
- **Conda Environments**: Because Kodoja relies on specific versions of Jellyfish (1.1.12) and other tools, always run it within a dedicated Conda environment to avoid version conflicts.



## Subcommands

| Command | Description |
|---------|-------------|
| kodoja_build.py | Kodoja Build creates a database for use with Kodoja Search. |
| kodoja_retrieve.py | Kodoja Retrieve is used with the output of Kodoja Search to give subsets of your input sequencing reads matching viruses. |
| kodoja_search.py | Kodoja Search is a tool intended to identify viral sequences in a FASTQ/FASTA sequencing run by matching them against both Kraken and Kaiju databases. |

## Reference documentation
- [Kodoja Manual](./references/github_com_abaizan_kodoja_wiki_Kodoja-Manual.md)
- [GitHub Repository Overview](./references/github_com_abaizan_kodoja.md)