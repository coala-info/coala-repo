cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet-seqstat
  - validate
label: biopet-seqstat_validate
doc: "Validate a seqstat schema file\n\nTool homepage: https://github.com/biopet/seqstat"
inputs:
  - id: input_file
    type: File
    doc: File to validate schema
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-seqstat:1.0.1--0
stdout: biopet-seqstat_validate.out
