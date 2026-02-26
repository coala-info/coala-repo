cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ggcat
  - query
label: ggcat_query
doc: "Query a graph with k-mers\n\nTool homepage: https://github.com/algbio/ggcat"
inputs:
  - id: input_graph
    type: File
    doc: The input graph
    inputBinding:
      position: 1
  - id: input_query
    type: File
    doc: The input query as a .fasta file
    inputBinding:
      position: 2
  - id: buckets_count_log
    type:
      - 'null'
      - int
    doc: The log2 of the number of buckets
    inputBinding:
      position: 103
      prefix: --buckets-count-log
  - id: colored_query_output_format
    type:
      - 'null'
      - string
    inputBinding:
      position: 103
      prefix: --colored-query-output-format
  - id: colors
    type:
      - 'null'
      - boolean
    doc: Enable colors
    inputBinding:
      position: 103
      prefix: --colors
  - id: forward_only
    type:
      - 'null'
      - boolean
    doc: Treats reverse complementary kmers as different
    inputBinding:
      position: 103
      prefix: --forward-only
  - id: hash_type
    type:
      - 'null'
      - string
    doc: Hash type used to identify kmers
    default: Auto
    inputBinding:
      position: 103
      prefix: --hash-type
  - id: intermediate_compression_level
    type:
      - 'null'
      - int
    doc: The level of lz4 compression to be used for the intermediate files
    inputBinding:
      position: 103
      prefix: --intermediate-compression-level
  - id: keep_temp_files
    type:
      - 'null'
      - boolean
    doc: Keep intermediate temporary files for debugging purposes
    inputBinding:
      position: 103
      prefix: --keep-temp-files
  - id: kmer_length
    type: int
    doc: Specifies the k-mers length
    inputBinding:
      position: 103
      prefix: --kmer-length
  - id: memory
    type:
      - 'null'
      - float
    doc: Maximum suggested memory usage (GB) The tool will try use only up to 
      this GB of memory to store temporary files without writing to disk. This 
      usage does not include the needed memory for the processing steps. GGCAT 
      can allocate extra memory for files if the current memory is not enough to
      complete the current operation
    default: 2
    inputBinding:
      position: 103
      prefix: --memory
  - id: minimizer_length
    type:
      - 'null'
      - int
    doc: Overrides the default m-mers (minimizers) length
    inputBinding:
      position: 103
      prefix: --minimizer-length
  - id: output_file_prefix
    type:
      - 'null'
      - string
    default: output
    inputBinding:
      position: 103
      prefix: --output-file-prefix
  - id: prefer_memory
    type:
      - 'null'
      - boolean
    doc: Use all the given memory before writing to disk
    inputBinding:
      position: 103
      prefix: --prefer-memory
  - id: step
    type:
      - 'null'
      - string
    default: MinimizerBucketing
    inputBinding:
      position: 103
      prefix: --step
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Directory for temporary files
    default: .temp_files
    inputBinding:
      position: 103
      prefix: --temp-dir
  - id: threads_count
    type:
      - 'null'
      - int
    default: 16
    inputBinding:
      position: 103
      prefix: --threads-count
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggcat:2.0.0--ha96b9cd_0
stdout: ggcat_query.out
