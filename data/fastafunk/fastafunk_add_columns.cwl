cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastafunk
  - add_columns
label: fastafunk_add_columns
doc: "Add columns to a metadata file from row matches in another file\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: in_metadata
    type: File
    doc: "ONE CSV table of metadata"
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: in_data
    type: File
    doc: "One CSV table of additional data. Must have --index-column in common with metadata"
    inputBinding:
      position: 101
      prefix: --in-data
  - id: index_column
    type: string
    doc: "Column in the metadata files used to match rows"
    inputBinding:
      position: 101
      prefix: --index-column
  - id: join_on
    type: string
    doc: "Column in the data file used to match rows"
    inputBinding:
      position: 101
      prefix: --join-on
  - id: new_columns
    type: ['null', {type: array, items: string}]
    doc: "Column(s) in the in_data file to add to the metadata, if not provided, all columns added"
    inputBinding:
      position: 101
      prefix: --new-columns
  - id: out_metadata_path
    type: string
    doc: "A metadata file to write"
    inputBinding:
      position: 101
      prefix: --out-metadata
  - id: where_column
    type: ['null', {type: array, items: string}]
    doc: "Additional matches to columns e.g. if want to rename, as <column>=<regex>"
    inputBinding:
      position: 101
      prefix: --where-column
  - id: force_overwrite
    type: ['null', boolean]
    doc: "Overwrite even if new data is blank/None"
    inputBinding:
      position: 101
      prefix: --force-overwrite
  - id: log_file_path
    type: ['null', string]
    doc: "Log file to use (otherwise uses stdout, or stderr if out-fasta to stdout)"
    inputBinding:
      position: 101
      prefix: --log-file
  - id: verbose
    type: ['null', boolean]
    doc: "Run with high verbosity (debug level logging)"
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout_output
    type: stdout
    doc: Standard output (FASTA or table when no output file is given, and log messages).
  - id: out_metadata
    type: File
    doc: "A metadata file to write"
    outputBinding:
      glob: $(inputs.out_metadata_path)
  - id: log_file
    type: ['null', File]
    doc: Log file.
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
stdout: fastafunk_add_columns.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
