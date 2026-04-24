cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pepsirf
  - demux
label: pepsirf_demux
doc: "Peptide-based Serological Immune Response Framework demultiplexing module. This
  module takes parameters and outputs counts for each reference sequence (i.e. probe/peptide)
  for each sample.\n\nTool homepage: https://github.com/LadnerLab/PepSIRF"
inputs:
  - id: concatemer
    type:
      - 'null'
      - string
    doc: Concatenated adapter/primer sequences (optional).
    inputBinding:
      position: 101
      prefix: --concatemer
  - id: fastq_output
    type:
      - 'null'
      - boolean
    doc: Include this to output sample-level fastq files.
    inputBinding:
      position: 101
      prefix: --fastq_output
  - id: fif
    type:
      - 'null'
      - File
    doc: Flexible index file provided as an alternative to --index1 and --index2.
    inputBinding:
      position: 101
      prefix: --fif
  - id: include_toggle
    type:
      - 'null'
      - int
    doc: The position toggling for the indexes (1 for true, 0 for false).
    inputBinding:
      position: 101
      prefix: --include_toggle
  - id: index
    type:
      - 'null'
      - File
    doc: Fasta-formatted file containing forward and (potentially) reverse index sequences.
    inputBinding:
      position: 101
      prefix: --index
  - id: index1
    type:
      - 'null'
      - string
    doc: Positional information for index1 (start, length, mismatches). E.g., '12,12,1'.
    inputBinding:
      position: 101
      prefix: --index1
  - id: index2
    type:
      - 'null'
      - string
    doc: Positional information for index2 (start, length, mismatches).
    inputBinding:
      position: 101
      prefix: --index2
  - id: input_r1
    type: File
    doc: Fastq-formatted file containing reads with DNA tags. Can be uncompressed
      or gzipped if Zlib support is enabled.
    inputBinding:
      position: 101
      prefix: --input_r1
  - id: input_r2
    type:
      - 'null'
      - File
    doc: Optional index-only fastq file. If not supplied, only 'index1' will be used
      to identify samples.
    inputBinding:
      position: 101
      prefix: --input_r2
  - id: library
    type:
      - 'null'
      - File
    doc: Fasta-formatted file containing reference DNA tags. If not included, reference-independent
      demultiplexing is performed.
    inputBinding:
      position: 101
      prefix: --library
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for analyses.
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: phred_base
    type:
      - 'null'
      - int
    doc: Phred base to use when parsing fastq quality scores (33 or 64).
    inputBinding:
      position: 101
      prefix: --phred_base
  - id: phred_min_score
    type:
      - 'null'
      - int
    doc: The minimum average phred-scaled quality score for the DNA tag portion of
      a read.
    inputBinding:
      position: 101
      prefix: --phred_min_score
  - id: read_per_loop
    type:
      - 'null'
      - int
    doc: The number of fastq records read at a time.
    inputBinding:
      position: 101
      prefix: --read_per_loop
  - id: samplelist
    type:
      - 'null'
      - File
    doc: A tab-delimited list of samples with a header row and one sample per line.
    inputBinding:
      position: 101
      prefix: --samplelist
  - id: seq
    type:
      - 'null'
      - string
    doc: Positional information for the DNA tags (start, length, mismatches).
    inputBinding:
      position: 101
      prefix: --seq
  - id: sindex
    type:
      - 'null'
      - string
    doc: Header for the index 1 and additional optional index column names in the
      samplelist.
    inputBinding:
      position: 101
      prefix: --sindex
  - id: sname
    type:
      - 'null'
      - string
    doc: Header for the sample name column in the samplelist.
    inputBinding:
      position: 101
      prefix: --sname
  - id: translate_aggregates
    type:
      - 'null'
      - boolean
    doc: Include this flag to use translation-based aggregation.
    inputBinding:
      position: 101
      prefix: --translate_aggregates
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Name for the output counts file (tab-delimited).
    outputBinding:
      glob: $(inputs.output)
  - id: aa_counts
    type:
      - 'null'
      - File
    doc: Name for an output file that will contain aggregated aa-level counts.
    outputBinding:
      glob: $(inputs.aa_counts)
  - id: diagnostic_info
    type:
      - 'null'
      - File
    doc: Include this flag with an output file name to collect diagnostic information
      on read pair matches.
    outputBinding:
      glob: $(inputs.diagnostic_info)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Designated file to which the module's processes are logged.
    outputBinding:
      glob: $(inputs.logfile)
  - id: replicate_info
    type:
      - 'null'
      - File
    doc: Include this flag with an output file name to provide a summary of replicates.
    outputBinding:
      glob: $(inputs.replicate_info)
  - id: unmapped_reads_output
    type:
      - 'null'
      - File
    doc: Include this flag with a .fastq output file name to create a file containing
      unmapped reads.
    outputBinding:
      glob: $(inputs.unmapped_reads_output)
  - id: trunc_info_output
    type:
      - 'null'
      - Directory
    doc: Name of directory to output truncated sequence information.
    outputBinding:
      glob: $(inputs.trunc_info_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
