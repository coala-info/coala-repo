---
name: taxator-tk
description: taxator-tk performs taxonomic analysis and classification of genetic sequences using phylogenetic neighborhood inference. Use when user asks to perform taxonomic assignment for environmental samples, classify long-read sequences or contigs, and bin sequences based on phylogenetic relationships.
homepage: https://github.com/fungs/taxator-tk
---

# taxator-tk

## Overview

The taxator toolkit (taxator-tk) is a specialized suite for the taxonomic analysis of genetic sequences, particularly effective for complex environmental samples containing a mixture of taxa. Unlike k-mer based classifiers that rely on exact matches, taxator-tk uses phylogenetic neighborhood inference to handle distant homologs more robustly. It is optimized for longer sequences such as assembled contigs or long-read data (PacBio/Oxford Nanopore) and supports both nucleotide and protein-based workflows.

## Core Workflow

The standard taxator-tk pipeline follows a five-step modular process. You can pipe data between these steps to avoid large intermediate files.

### 1. Alignment
Align your query sequences against a reference database.
- **LAST (Recommended for speed)**: Use for large nucleotide datasets.
- **BLAST+**: Use for sensitive searches or low-memory environments.
- **Protein**: Use `blastx` or `blastp` for amino acid-based classification.

### 2. Conversion
Convert aligner output to the taxator-tk intermediate TAB-separated format.
- **Native BLAST+**: Use `-outfmt '6 qseqid qstart qend qlen sseqid sstart send bitscore evalue nident length'` to skip conversion.
- **LAST**: Use `lastmaf2alignments` on MAF output. **Note**: You must sort the output by query identifier (e.g., `LC_COLLATE=C sort`).

### 3. Filtering (Optional)
Use `alignments-filter` to remove low-quality hits based on e-values or bitscores. This reduces downstream runtime.

### 4. Segment Prediction (`taxator`)
This is the core engine that performs taxonomic assignment for sequence regions.
- **RPA Algorithm**: The default algorithm for high-confidence, conservative assignments.
- **LCA Methods**: Faster, less conservative alternatives similar to MEGAN.
- **Memory Management**: Use `-f` to specify a FASTA index (`.fai`) for the reference database to run on systems with limited RAM.

### 5. Binning (`binner`)
Consolidates segment predictions into whole-sequence assignments.
- **Noise Filtering**: Prunes rare taxa from the sample (similar to min-support).
- **Rank-specific Identity**: Set minimum identity thresholds for specific taxonomic ranks (e.g., requiring 70% identity for species-level assignment).

## Expert Tips and Best Practices

- **Sequence Identifiers**: Ensure FASTA headers do not contain spaces or extra metadata, as many aligners truncate these, causing mismatches in the mapping files. Use `fasta-strip-identifier` if needed.
- **Refpacks**: Always use a comprehensive and recent "refpack" (reference package) containing the database, taxonomy mapping, and tree files.
- **Parallelization**: The `taxator` program is "embarrassingly parallel." For large datasets, split the input sequences into chunks, run `taxator` on each, and concatenate the resulting GFF3 files before the final `binner` step.
- **Short Sequences**: If most assignments are at high ranks (e.g., Phylum), your sequences may be too short or novel. Check the intermediate GFF3 file for lower-confidence assignments that the consensus binner might have filtered out.
- **Disk I/O**: Avoid running taxator-tk on network storage (NFS) if using on-disk FASTA indexing, as latency will significantly degrade performance.



## Subcommands

| Command | Description |
|---------|-------------|
| fasta-strip-identifier | Strips the identifier from FASTA sequences. |
| taxator-tk_taxator | Specify a taxonomy mapping file for the reference sequence identifiers |

## Reference documentation

- [Core Usage Instructions](./references/github_com_fungs_taxator-tk_blob_master_core_USAGE.md)
- [General Project Overview](./references/github_com_fungs_taxator-tk_blob_master_README.md)
- [File Formats Guide](./references/github_com_fungs_taxator-tk_blob_master_doc_fileformats.md)