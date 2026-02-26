cwlVersion: v1.2
class: CommandLineTool
baseCommand: pheniqs mux
label: pheniqs_mux
doc: "Multiplex and Demultiplex annotated DNA sequence reads\n\nTool homepage: http://biosails.github.io/pheniqs"
inputs:
  - id: base_input_url
    type:
      - 'null'
      - string
    doc: Base input url
    default: working directory
    inputBinding:
      position: 101
      prefix: --base-input
  - id: base_output_url
    type:
      - 'null'
      - string
    doc: Base output url
    default: working directory
    inputBinding:
      position: 101
      prefix: --base-output
  - id: buffer_capacity
    type:
      - 'null'
      - int
    doc: Feed buffer capacity
    inputBinding:
      position: 101
      prefix: --buffer
  - id: compile_config
    type:
      - 'null'
      - boolean
    doc: Compiled JSON configuration file
    inputBinding:
      position: 101
      prefix: --compile
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to configuration file
    inputBinding:
      position: 101
      prefix: --config
  - id: decoding_threads
    type:
      - 'null'
      - int
    doc: Number of parallel decoding threads
    inputBinding:
      position: 101
      prefix: --decoding-threads
  - id: display_distance
    type:
      - 'null'
      - boolean
    doc: Display pairwise barcode distance during validation
    inputBinding:
      position: 101
      prefix: --distance
  - id: enable_quality_control
    type:
      - 'null'
      - boolean
    doc: Enable quality control
    inputBinding:
      position: 101
      prefix: --quality
  - id: htslib_threads
    type:
      - 'null'
      - int
    doc: Size of htslib thread pool size
    inputBinding:
      position: 101
      prefix: --htslib-threads
  - id: include_job_in_report
    type:
      - 'null'
      - boolean
    doc: Include a copy of the compiled job in the report
    inputBinding:
      position: 101
      prefix: --job
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to an input file. May be repeated.
    default: /dev/stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: leading_segment_index
    type:
      - 'null'
      - int
    doc: Leading read segment index
    inputBinding:
      position: 101
      prefix: --leading
  - id: no_input_npf
    type:
      - 'null'
      - boolean
    doc: Filter incoming QC failed reads.
    inputBinding:
      position: 101
      prefix: --no-input-npf
  - id: no_output_npf
    type:
      - 'null'
      - boolean
    doc: Filter outgoing QC failed reads
    inputBinding:
      position: 101
      prefix: --no-output-npf
  - id: output_compression
    type:
      - 'null'
      - string
    doc: Defult output compression
    inputBinding:
      position: 101
      prefix: --compression
  - id: output_compression_level
    type:
      - 'null'
      - string
    doc: Defult output compression level
    inputBinding:
      position: 101
      prefix: --level
  - id: output_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to an output file. May be repeated.
    default: /dev/stdout
    inputBinding:
      position: 101
      prefix: --output
  - id: output_format
    type:
      - 'null'
      - string
    doc: Defult output format
    inputBinding:
      position: 101
      prefix: --format
  - id: output_precision
    type:
      - 'null'
      - int
    doc: Output floating point precision
    inputBinding:
      position: 101
      prefix: --precision
  - id: output_token
    type:
      - 'null'
      - type: array
        items: string
    doc: Output read token
    inputBinding:
      position: 101
      prefix: --token
  - id: prior_file
    type:
      - 'null'
      - File
    doc: Path to adjusted prior job file
    inputBinding:
      position: 101
      prefix: --prior
  - id: report_file
    type:
      - 'null'
      - File
    doc: Path to report file
    inputBinding:
      position: 101
      prefix: --report
  - id: sense_input
    type:
      - 'null'
      - boolean
    doc: Sense input segment layout
    inputBinding:
      position: 101
      prefix: --sense-input
  - id: sequencing_platform
    type:
      - 'null'
      - string
    doc: Sequencing platform
    inputBinding:
      position: 101
      prefix: --platform
  - id: static_config
    type:
      - 'null'
      - boolean
    doc: Static configuration JSON file
    inputBinding:
      position: 101
      prefix: --static
  - id: thread_pool_size
    type:
      - 'null'
      - int
    doc: Thread pool size
    inputBinding:
      position: 101
      prefix: --threads
  - id: validate_config
    type:
      - 'null'
      - boolean
    doc: Validate configuration file and emit a report
    inputBinding:
      position: 101
      prefix: --validate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pheniqs:2.1.0--py38h1b92da4_7
stdout: pheniqs_mux.out
