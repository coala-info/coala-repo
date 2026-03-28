---
name: fastaq
description: fastaq is a suite of Python scripts designed for the rapid manipulation, reformatting, and analysis of common biological sequence formats. Use when user asks to reverse complement sequences, translate nucleotides to protein, interleave or deinterleave FASTQ files, filter sequences by ID, or convert between file formats like FASTA, FASTQ, and GenBank.
homepage: https://github.com/sanger-pathogens/Fastaq
---


# fastaq

## Overview
The `fastaq` tool is a versatile suite of Python scripts designed for the rapid manipulation of common biological sequence formats. It is particularly useful for cleaning up sequence data, reformatting files for downstream pipelines, and performing basic sequence analysis like counting or sorting. It handles compressed files automatically and supports piping, making it an ideal utility for command-line sequence processing workflows.

## Usage Patterns and Best Practices

### Core CLI Syntax
All operations are performed through a single entry point:
```bash
fastaq <command> [options]
```

### File Handling and Formats
- **Auto-detection**: The tool automatically detects input formats (FASTA, FASTQ, GFF3, EMBL, GBK, Phylip).
- **Compression**: Input and output files are assumed to be gzipped if the filename ends in `.gz`.
- **Piping**: Use a hyphen `-` as a filename to read from `stdin` or write to `stdout`. This allows for efficient command chaining without creating intermediate files.

### High-Utility Command Examples

#### Sequence Transformation
- **Reverse Complement**: `fastaq reverse_complement in.fastq out.fastq`
- **Translation**: Translate nucleotide sequences to protein: `fastaq translate in.fasta out.fasta`
- **Clean Sequences**: Replace all non-ACGTN characters with N: `fastaq acgtn_only in.fasta out.fasta`
- **Trim Ends**: Remove a fixed number of bases from the start or end: `fastaq trim_ends <in_file> <out_file> <start_trim> <end_trim>`

#### File Conversion and Reformatting
- **Standardize to FASTA**: Convert various formats (GBK, EMBL, etc.) to clean FASTA: `fastaq to_fasta in.gbk out.fasta`
- **Interleave/Deinterleave**: 
  - Combine two files into one interleaved file: `fastaq interleave fwd.fastq rev.fastq out.interleaved.fastq`
  - Split an interleaved file: `fastaq deinterleave interleaved.fastq fwd.fastq rev.fastq`
- **Sort Sequences**: Organize files by sequence length: `fastaq sort_by_size in.fasta out.sorted.fasta`

#### Analysis and Filtering
- **Count Sequences**: Quickly get the number of records: `fastaq count_sequences in.fastq`
- **Filter by ID**: Extract specific sequences using a list of IDs: `fastaq filter --id_list ids.txt in.fasta out.filtered.fasta`
- **Get IDs**: Extract only the headers/names from a file: `fastaq get_ids in.fasta ids.txt`

### Expert Tips
- **Chaining Commands**: To reverse complement and then translate in a single line:
  `fastaq reverse_complement in.fastq - | fastaq translate - out.fasta`
- **Scaffold Processing**: Use `scaffolds_to_contigs` to break sequences at gap locations (Ns) into individual contigs.
- **Quality Score Mocking**: If a tool requires FASTQ but you only have FASTA, use `to_fake_qual` to generate a dummy quality score file.



## Subcommands

| Command | Description |
|---------|-------------|
| acgtn_only | Replaces any character that is not one of acgtACGTnN with an N |
| add_indels | Deletes or inserts bases at given position(s) |
| deinterleave | Deinterleaves sequence file, so that reads are written alternately between two output files |
| fastaq | A collection of commands for manipulating DNA/RNA sequences. |
| fastaq capillary_to_pairs | Given a file of capillary reads, makes an interleaved file of read pairs (where more than read from same ligation, takes the longest read) and a file of unpaired reads. Replaces the .p1k/.q1k part of read names to denote fwd/rev reads with /1 and /2 |
| fastaq count_sequences | Prints the number of sequences in input file to stdout |
| fastaq enumerate_names | Renames sequences in a file, calling them 1,2,3... etc |
| fastaq expand_nucleotides | Makes all combinations of sequences in input file by using all possibilities of redundant bases. e.g. ART could be AAT or AGT. Assumes input is nucleotides, not amino acids |
| fastaq fasta_to_fastq | Convert FASTA and .qual to FASTQ |
| fastaq filter | Filters a sequence file by sequence length and/or by name matching a regular expression |
| fastaq get_ids | Gets IDs from each sequence in input file |
| fastaq merge | Converts multi sequence file to a single sequence |
| fastaq sequence_trim | Trims sequences off the start of all sequences in a pair of sequence files, whenever there is a perfect match. Only keeps a read pair if both reads of the pair are at least a minimum length after any trimming |
| fastaq sort_by_name | Sorts sequences in lexographical (name) order |
| fastaq sort_by_size | Sorts sequences in length order |
| fastaq split_by_base_count | Splits a multi sequence file into separate files. Does not split sequences. Puts up to max_bases into each split file. The exception is that any sequence longer than max_bases is put into its own file. |
| fastaq translate | Translates all sequences in input file. Output is always FASTA format |
| fastaq trim_contigs | Trims a set number of bases off the end of every contig, so gaps get bigger and contig ends are removed. Bases are replaced with Ns. Any sequence that ends up as all Ns is lost |
| fastaq_caf_to_fastq | Converts CAF file to FASTQ format |
| fastaq_chunker | Splits a multi sequence file into separate files. Splits sequences into chunks of a fixed size. Aims for chunk_size chunks in each file, but allows a little extra, so chunk can be up to (chunk_size + tolerance), to prevent tiny chunks made from the ends of sequences |
| fastaq_interleave | Interleaves two files, output is alternating between fwd/rev reads |
| fastaq_scaffolds_to_contigs | Creates a file of contigs from a file of scaffolds - i.e. breaks at every gap in the input |
| fastaq_search_for_seq | Searches for an exact match on a given string and its reverse complement, in every sequence of input sequence file. Case insensitive. Guaranteed to find all hits |
| fastaq_to_boulderio | Converts input sequence file into "Boulder-IO" format, which is used by primer3 |
| fastaq_to_fake_qual | Make fake quality scores file |
| fastaq_to_fasta | Converts a variety of input formats to nicely formatted FASTA format |
| fastaq_to_mira_xml | Create an xml file from a file of reads, for use with Mira assembler |
| fastaq_to_orfs_gff | Writes a GFF file of open reading frames from a sequence file |
| fastaq_to_perfect_reads | Makes perfect paired end fastq reads from a sequence file, with insert sizes sampled from a normal distribution. Read orientation is innies. Output is an interleaved FASTQ file. |
| fastaq_to_random_subset | Takes a random subset of reads from a sequence file and optionally the corresponding read from a mates file. Output is interleaved if mates file given |
| fastaq_to_tiling_bam | Takes a sequence file. Makes a BAM file containing perfect (unpaired) reads tiling the whole genome |
| fastaq_to_unique_by_id | Removes duplicate sequences from input file, based on their names. If the same name is found more than once, then the longest sequence is kept. Order of sequences is preserved in output |
| fastaq_trim_ends | Trim fixed number of bases of start and/or end of every sequence |
| freq make_random_contigs | Makes a multi-FASTA file of random sequences, all of the same length. Each base has equal chance of being A,C,G or T |
| get_seq_flanking_gaps | Gets the sequences flanking gaps |
| replace_bases | Replaces all occurrences of one letter with another |
| reverse_complement | Reverse complement all sequences |
| strip_illumina_suffix | Strips /1 or /2 off the end of every read name |

## Reference documentation
- [Fastaq GitHub Repository](./references/github_com_sanger-pathogens_Fastaq.md)