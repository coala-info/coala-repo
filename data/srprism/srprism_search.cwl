cwlVersion: v1.2
class: CommandLineTool
baseCommand: srprism
label: srprism_search
doc: "Fast Short Read Aligner\n\nTool homepage: https://github.com/ncbi/SRPRISM"
inputs:
  - id: cmd
    type: string
    doc: 'Action to perform. Possible values are: help, search, mkindex.'
    inputBinding:
      position: 1
  - id: batch
    type:
      - 'null'
      - int
    doc: Process input in batches of at most this many queries.
    inputBinding:
      position: 102
      prefix: --batch
  - id: batch_end
    type:
      - 'null'
      - int
    doc: Last batch to process.
    inputBinding:
      position: 102
      prefix: --batch-end
  - id: batch_start
    type:
      - 'null'
      - int
    doc: First batch to process.
    inputBinding:
      position: 102
      prefix: --batch-start
  - id: errors
    type:
      - 'null'
      - int
    doc: Search for alignments with at most this many errors.
    default: 0
    inputBinding:
      position: 102
      prefix: --errors
  - id: extra_tags
    type:
      - 'null'
      - string
    doc: String (normally fixed extra tags) to add to each SAM output record.
    default: ''
    inputBinding:
      position: 102
      prefix: --extra-tags
  - id: index
    type: string
    doc: Base name for database index files.
    inputBinding:
      position: 102
      prefix: --index
  - id: input
    type:
      type: array
      items: File
    doc: Specifies the source of the queries. The exact format depends on the 
      value of "--input-format" option. If the input format allows for just one 
      input stream, then the queries can be read from standard input, in the 
      case this option is not present.
    inputBinding:
      position: 102
      prefix: --input
  - id: input_compression
    type:
      - 'null'
      - string
    doc: Compression type used for input. The possible values are "auto" 
      (default), "none", "gzip", and "bzip2". If the value given is "auto" then 
      the type of compression is guessed from the file extension.
    default: auto
    inputBinding:
      position: 102
      prefix: --input-compression
  - id: input_format
    type:
      - 'null'
      - string
    doc: The input format name. The possible values are "fasta", "fastq", 
      "cfasta", "cfastq", "sam". See the software documentation for the details 
      of different supported input formats.
    default: fasta
    inputBinding:
      position: 102
      prefix: --input-format
  - id: log_file
    type:
      - 'null'
      - File
    doc: File for storing diagnostic messages. Default is standard error.
    inputBinding:
      position: 102
      prefix: --log-file
  - id: max_query_length
    type:
      - 'null'
      - int
    doc: Maximum query length. Queries longer than the value specified by this 
      parameter will be truncated.
    default: 112
    inputBinding:
      position: 102
      prefix: --max-query-length
  - id: memory
    type:
      - 'null'
      - int
    doc: Do not use more than this many megabytes of memory for internal dynamic
      data structures. This number does not include the footprint of the 
      executable code, static data, or stack.
    default: 2048
    inputBinding:
      position: 102
      prefix: --memory
  - id: mode
    type:
      - 'null'
      - string
    doc: Search mode; possible values are "min-err", "bound-err", "sum-err", 
      "partial".
    default: min-err
    inputBinding:
      position: 102
      prefix: --mode
  - id: no_qids
    type:
      - 'null'
      - boolean
    doc: Do not report ids for queries. Use their ordinal number instead.
    inputBinding:
      position: 102
      prefix: --no-qids
  - id: no_sids
    type:
      - 'null'
      - boolean
    doc: Do not report ids for database sequences. Use their ordinal number 
      instead.
    inputBinding:
      position: 102
      prefix: --no-sids
  - id: output_format
    type:
      - 'null'
      - string
    doc: The output format name. The possible values are "tabular", "sam". See 
      the software documentation for the details of different supported output 
      formats.
    default: tabular
    inputBinding:
      position: 102
      prefix: --output-format
  - id: pair_distance
    type:
      - 'null'
      - int
    doc: For paired search, the target distance between pair alignments in 
      bases.
    default: 200
    inputBinding:
      position: 102
      prefix: --pair-distance
  - id: pair_distance_fuzz
    type:
      - 'null'
      - int
    doc: Maximum acceptable radius (in bases) around the target distance between
      paired alignments. If d is the value of "--pair-distance" option and f is 
      the value of the "--pair-distance-fuzz" option than the distance between 
      the alignments in a pair should be in the interval [d-f,d+f] for the pair 
      to be reported.
    default: 100
    inputBinding:
      position: 102
      prefix: --pair-distance-fuzz
  - id: paired
    type: string
    doc: If "true", force paired search; if "false", force unpaired search.
    inputBinding:
      position: 102
      prefix: --paired
  - id: plog
    type:
      - 'null'
      - File
    doc: File name where the ordinal ids of queries participating in paired 
      search passes are written.
    inputBinding:
      position: 102
      prefix: --plog
  - id: repeat_threshold
    type:
      - 'null'
      - int
    doc: Process queries that start with 16-mers that appear at most this many 
      times in the database.
    default: 0
    inputBinding:
      position: 102
      prefix: --repeat-threshold
  - id: result_conf
    type:
      - 'null'
      - string
    doc: Select which paired result configurations should be reported. Selection
      is specified as a sequence of 4 digits from {0,1}, where i-th digit is 1 
      if the i-th configuration is selected. Configurations are encoded by the 
      second mate direction and position in the result relative to the first 
      mate, assuming that the first mate is matched in forward direction.
    default: '0100'
    inputBinding:
      position: 102
      prefix: --result-conf
  - id: results
    type:
      - 'null'
      - int
    doc: Maximum number of results to report per query.
    default: 10
    inputBinding:
      position: 102
      prefix: --results
  - id: sa_end
    type:
      - 'null'
      - int
    doc: Make sure that the seeding area is selected so that it ends at or 
      before this query position.
    default: 8096
    inputBinding:
      position: 102
      prefix: --sa-end
  - id: sa_start
    type:
      - 'null'
      - int
    doc: Make sure that the seeding area is selected so that it starts at or 
      after this query position.
    default: 1
    inputBinding:
      position: 102
      prefix: --sa-start
  - id: sam_header
    type:
      - 'null'
      - File
    doc: Append the content of the file as header to SAM output.
    default: ''
    inputBinding:
      position: 102
      prefix: --sam-header
  - id: skip_unmapped
    type:
      - 'null'
      - boolean
    doc: If "true", do not generate records for unmapped queries in SAM output.
    default: true
    inputBinding:
      position: 102
      prefix: --skip-unmapped
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Directory to store temporary files.
    default: .
    inputBinding:
      position: 102
      prefix: --tmpdir
  - id: trace_level
    type:
      - 'null'
      - string
    doc: Minimum message level to report to the log stream. Possible values are 
      "debug", "info", "warning", "error", "quiet".
    default: warning
    inputBinding:
      position: 102
      prefix: --trace-level
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: File name for program output. By default the standard output stream 
      will be used.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srprism:2.4.24--hd6d6fdc_6
