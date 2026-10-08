cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastafunk
  - shuffle
label: fastafunk_shuffle
doc: "Shuffles lines of a metadata file\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: in_metadata
    type: File
    doc: "CSV or TSV of metadata"
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: out_metadata_path
    type: string
    doc: "CSV or TSV of metadata"
    inputBinding:
      position: 101
      prefix: --out-metadata
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
    doc: "CSV or TSV of metadata"
    outputBinding:
      glob: $(inputs.out_metadata_path)
  - id: log_file
    type: ['null', File]
    doc: Log file.
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
stdout: fastafunk_shuffle.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
