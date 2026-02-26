cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cvbio
  - UpdateContigNames
label: cvbio_UpdateContigNames
doc: "Update contig names in delimited data using a name mapping table.\n\nTool homepage:
  https://github.com/clintval/cvbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    default: false
    inputBinding:
      position: 101
      prefix: --async-io
  - id: columns
    type:
      - 'null'
      - type: array
        items: int
    doc: The column names to convert, 0-indexed.
    default: 0
    inputBinding:
      position: 101
      prefix: --columns
  - id: comment_chars
    type:
      - 'null'
      - type: array
        items: string
    doc: Directly write-out lines that start with these prefixes.
    default: '#'
    inputBinding:
      position: 101
      prefix: --comment-chars
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    default: 5
    inputBinding:
      position: 101
      prefix: --compression
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The input file data delimiter.
    default: ' '
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: input_file
    type: File
    doc: The input file.
    inputBinding:
      position: 101
      prefix: --in
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    default: Info
    inputBinding:
      position: 101
      prefix: --log-level
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: A two-column tab-delimited mapping file.
    inputBinding:
      position: 101
      prefix: --mapping
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 101
      prefix: --sam-validation-stringency
  - id: skip_missing
    type:
      - 'null'
      - boolean
    doc: Skip (ignore) records which do not have a mapping.
    default: true
    inputBinding:
      position: 101
      prefix: --skip-missing
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cvbio:3.0.0--0
