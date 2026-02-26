# metacortex CWL Generation Report

## metacortex

### Tool Description
MetaCortex v0.4

### Metadata
- **Docker Image**: quay.io/biocontainers/metacortex:0.5.1--h7b50bb2_3
- **Homepage**: https://github.com/SR-Martin/metacortex
- **Package**: https://anaconda.org/channels/bioconda/packages/metacortex/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metacortex/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SR-Martin/metacortex
- **Stars**: N/A
### Original Help Text
```text
MetaCortex v0.4
Compiled on Dec 14 2024 at 05:38:03 

Command: metacortex --help 
Unit size: 40
Node size: 40

usage: metacortex [-h] [--input file_of_files] [--mem_height n] [--dump_binary bin_output] [--input_format fastq|fasta|binary] [--output_contigs contigs.fa] 

   [-h|--help] = This help screen.
   [-a|--remove_bubbles] = Removes the bubbles in the graph.
   [-A|--algorithm ALG] = Traversal algorithm for contigs (MCC | SW | PP | GS).
   [-b|--mem_width INT] = Size of hash table buckets (default 100).
   [-c|--tip_clip INT] = Clips the tips in the graph, the argument defines the max length for the tips.
   [-C|--high_confidence INT] = Only outputs contigs which have no nodes with coverage below THESHOLD.
   [-e|--output_coverages] = Print coverages for contigs/supernodes in a different file with _cov suffix.
   [-d|--ouput_contigs FILENAME] = Fasta file with all the contigs (after applying all specified actions on graph).
   [-f|--ouput_supernodes FILENAME] = Fasta file with all the supernodes (after applying all specified actions on graph).
   [-g|--min_contig_length INT] = minimum contig length produced.
   [-G|--gfa] = Output gfa2 and fastg sequence files.
   [-i|--input FILENAME] = File of filenames to be processed (start and end read is optional, format <filename>  <start read index>  <end read index> ).
   [-k|--kmer_size INT] = Kmer size (default 21), it has to be an odd number.
   [-M|--multiple_subgraph_contigs] = Find multiple contigs for each disconnected subgraph during MCC.
   [-n|--mem_height INT] = Number of buckets in hash table in bits (default 10, this is a power of 2, ie 2^mem_height).
   [-o|--dump_binary FILENAME] = Dump binary for graph in file (after applying all specified actions on graph).
   [-O|--hash_output_file ] = Dumps the whole graph into a file. Read with the input_format hash. The file stores the information required to restore the hash table, hence mem_height and mem_width don't have any effect.   [-p|--quality_score_offset] = Fastq quality offset. Default 33. Use 63 for illumina.
   [-q|--quality_score_threshold INT] = Filter for quality scores in the input file, any k-mer wiht a base with quality in the threshold or smaller is not considered (default 0).
   [-q|--quality_score_threshold ] = The minimiun phred value for a base to be considered in an assembly.
   [-t|--input_format FORMAT] = File format for input (binary | fasta | fastq | hash ).
   [-u|--remove_seq_errors] = remove sequence of kmers induced by errors. Equivalent to --remove_low_coverage_kmers 1
   [-W|--SW_delta FLOAT] = minimum normalised coverage difference for SW.
   [-z|--remove_low_coverage_kmers INT] = Filter for kmers with coverage in the threshold or smaller.
   [-Z|--max_read_len] = Maximum read length over all input files.
	[--max_db_mem] = Maximum memory to be allocated for db-graph, in bytes or with K|M|G|T appended.
```


## Metadata
- **Skill**: generated
