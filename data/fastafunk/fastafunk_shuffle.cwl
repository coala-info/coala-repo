cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastafunk shuffle
label: fastafunk_shuffle
doc: "Shuffle FASTA sequences based on metadata.\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: in_metadata
    type: File
    doc: CSV or TSV of metadata
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file to use (otherwise uses stdout, or stderr if out-fasta to 
      stdout)
    inputBinding:
      position: 101
      prefix: --log-file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Run with high verbosity (debug level logging)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_metadata
    type: File
    doc: CSV or TSV of metadata
    outputBinding:
      glob: $(inputs.out_metadata)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0
