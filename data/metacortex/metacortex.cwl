cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacortex
label: metacortex
doc: "MetaCortex v0.4\n\nTool homepage: https://github.com/SR-Martin/metacortex"
inputs:
  - id: SW_delta
    type:
      - 'null'
      - float
    doc: minimum normalised coverage difference for SW
    inputBinding:
      position: 101
      prefix: --SW_delta
  - id: algorithm
    type:
      - 'null'
      - string
    doc: Traversal algorithm for contigs (MCC | SW | PP | GS)
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: gfa
    type:
      - 'null'
      - boolean
    doc: Output gfa2 and fastg sequence files
    inputBinding:
      position: 101
      prefix: --gfa
  - id: hash_output_file
    type:
      - 'null'
      - boolean
    doc: Dumps the whole graph into a file. Read with the input_format hash. The
      file stores the information required to restore the hash table, hence 
      mem_height and mem_width don't have any effect.
    inputBinding:
      position: 101
      prefix: --hash_output_file
  - id: high_confidence
    type:
      - 'null'
      - int
    doc: Only outputs contigs which have no nodes with coverage below THESHOLD
    inputBinding:
      position: 101
      prefix: --high_confidence
  - id: input_files
    type:
      - 'null'
      - File
    doc: File of filenames to be processed (start and end read is optional, 
      format <filename>  <start read index>  <end read index> )
    inputBinding:
      position: 101
      prefix: --input
  - id: input_format
    type:
      - 'null'
      - string
    doc: File format for input (binary | fasta | fastq | hash )
    inputBinding:
      position: 101
      prefix: --input_format
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size (default 21), it has to be an odd number
    default: 21
    inputBinding:
      position: 101
      prefix: --kmer_size
  - id: max_db_mem
    type:
      - 'null'
      - string
    doc: Maximum memory to be allocated for db-graph, in bytes or with K|M|G|T 
      appended
    inputBinding:
      position: 101
      prefix: --max_db_mem
  - id: max_read_len
    type:
      - 'null'
      - boolean
    doc: Maximum read length over all input files
    inputBinding:
      position: 101
      prefix: --max_read_len
  - id: mem_height
    type:
      - 'null'
      - int
    doc: Number of buckets in hash table in bits (default 10, this is a power of
      2, ie 2^mem_height)
    default: 10
    inputBinding:
      position: 101
      prefix: --mem_height
  - id: mem_width
    type:
      - 'null'
      - int
    doc: Size of hash table buckets (default 100)
    default: 100
    inputBinding:
      position: 101
      prefix: --mem_width
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: minimum contig length produced
    inputBinding:
      position: 101
      prefix: --min_contig_length
  - id: multiple_subgraph_contigs
    type:
      - 'null'
      - boolean
    doc: Find multiple contigs for each disconnected subgraph during MCC
    inputBinding:
      position: 101
      prefix: --multiple_subgraph_contigs
  - id: output_coverages
    type:
      - 'null'
      - boolean
    doc: Print coverages for contigs/supernodes in a different file with _cov 
      suffix
    inputBinding:
      position: 101
      prefix: --output_coverages
  - id: quality_score_offset
    type:
      - 'null'
      - boolean
    doc: Fastq quality offset. Default 33. Use 63 for illumina.
    inputBinding:
      position: 101
      prefix: --quality_score_offset
  - id: quality_score_threshold
    type:
      - 'null'
      - int
    doc: Filter for quality scores in the input file, any k-mer wiht a base with
      quality in the threshold or smaller is not considered (default 0)
    default: 0
    inputBinding:
      position: 101
      prefix: --quality_score_threshold
  - id: remove_bubbles
    type:
      - 'null'
      - boolean
    doc: Removes the bubbles in the graph.
    inputBinding:
      position: 101
      prefix: --remove_bubbles
  - id: remove_low_coverage_kmers
    type:
      - 'null'
      - int
    doc: Filter for kmers with coverage in the threshold or smaller
    inputBinding:
      position: 101
      prefix: --remove_low_coverage_kmers
  - id: remove_seq_errors
    type:
      - 'null'
      - boolean
    doc: remove sequence of kmers induced by errors. Equivalent to 
      --remove_low_coverage_kmers 1
    inputBinding:
      position: 101
      prefix: --remove_seq_errors
  - id: tip_clip
    type:
      - 'null'
      - int
    doc: Clips the tips in the graph, the argument defines the max length for 
      the tips
    inputBinding:
      position: 101
      prefix: --tip_clip
outputs:
  - id: dump_binary
    type:
      - 'null'
      - File
    doc: Dump binary for graph in file (after applying all specified actions on 
      graph)
    outputBinding:
      glob: $(inputs.dump_binary)
  - id: output_contigs
    type:
      - 'null'
      - File
    doc: Fasta file with all the contigs (after applying all specified actions 
      on graph)
    outputBinding:
      glob: $(inputs.output_contigs)
  - id: ouput_contigs
    type:
      - 'null'
      - File
    doc: Fasta file with all the contigs (after applying all specified actions 
      on graph)
    outputBinding:
      glob: $(inputs.ouput_contigs)
  - id: ouput_supernodes
    type:
      - 'null'
      - File
    doc: Fasta file with all the supernodes (after applying all specified 
      actions on graph)
    outputBinding:
      glob: $(inputs.ouput_supernodes)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacortex:0.5.1--h7b50bb2_3
