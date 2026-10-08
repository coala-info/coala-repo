cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastafunk
  - count
label: fastafunk_count
doc: "Counts the number in each group, defined by a number of metadata columns\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: in_metadata
    type: {type: array, items: File}
    doc: "One or more CSV or TSV tables of metadata"
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: group_column
    type: {type: array, items: string}
    doc: "Column(s) in the metadata file to define groupings"
    inputBinding:
      position: 101
      prefix: --group-column
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
  - id: log_file
    type: ['null', File]
    doc: Log file.
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
stdout: fastafunk_count.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
