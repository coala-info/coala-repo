---
name: pyfastaq
description: The `pyfastaq` tool is a versatile suite of Python3 scripts designed for the rapid manipulation of common genomic sequence formats.
homepage: https://github.com/sanger-pathogens/Fastaq
---

# pyfastaq

## Overview
The `pyfastaq` tool is a versatile suite of Python3 scripts designed for the rapid manipulation of common genomic sequence formats. It provides a unified command-line interface (`fastaq <command>`) to perform essential sequence processing tasks. Use this skill when you need to perform "Swiss Army knife" operations on sequence data, such as cleaning up contigs, renaming sequences, or preparing data for downstream assembly and analysis.

## Core Usage Patterns

### File Handling and Piping
- **Auto-detection**: `pyfastaq` automatically detects input formats (FASTA, FASTQ, GFF3, EMBL, GBK, Phylip).
- **Compression**: Files ending in `.gz` are automatically handled for both input and output.
- **Streaming**: Use `-` as a filename to read from `stdin` or write to `stdout`.
  ```bash
  # Example: Reverse complement then translate in a single pipeline
  fastaq reverse_complement in.fastq.gz - | fastaq translate - out.fasta
  ```

### Common Sequence Manipulations
- **Reverse Complement**: `fastaq reverse_complement input.fasta output.fasta`
- **Translation**: `fastaq translate input.fasta output.fasta` (translates all sequences to protein).
- **Cleaning Sequences**:
  - `fastaq acgtn_only`: Replaces any non-ACGTN character with an `N`.
  - `fastaq trim_Ns_at_end`: Removes leading and trailing `N`s from sequences.
  - `fastaq strip_illumina_suffix`: Removes `/1` or `/2` from the end of read names.

### Filtering and Sorting
- **Filtering**: Use `fastaq filter` to extract subsets based on length or specific IDs.
- **Sorting**:
  - `fastaq sort_by_size`: Sorts sequences from longest to shortest.
  - `fastaq sort_by_name`: Lexicographical sorting.
- **Deduplication**: `fastaq to_unique_by_id` removes duplicates based on sequence name, keeping the longest version.

### Paired-End Data Management
- **Interleave**: `fastaq interleave forward.fastq reverse.fastq interleaved.fastq`
- **Deinterleave**: `fastaq deinterleave interleaved.fastq forward.fastq reverse.fastq`

### Format Conversion
- **To FASTA**: `fastaq to_fasta input_file output.fasta` (converts various formats to standard FASTA).
- **FASTA to FASTQ**: `fastaq fasta_to_fastq input.fasta input.qual output.fastq` (requires a quality score file).
- **Scaffolds to Contigs**: `fastaq scaffolds_to_contigs input.scaffolds.fasta output.contigs.fasta` (breaks sequences at gaps).

## Expert Tips
- **Counting**: Use `fastaq count_sequences` for a quick tally of records in a file without loading the entire sequence into memory.
- **Random Sampling**: Use `fastaq to_random_subset` to generate a smaller test dataset from a large sequencing run.
- **Search**: `fastaq search_for_seq` is highly efficient for finding exact matches of a specific string (and its reverse complement) across a whole genome.
- **Fake Qualities**: If a tool requires FASTQ but you only have FASTA, use `fastaq to_fake_qual` to generate a dummy quality score file.

## Reference documentation
- [Fastaq GitHub Repository](./references/github_com_sanger-pathogens_Fastaq.md)
- [pyfastaq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pyfastaq_overview.md)