cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet-bamstats
  - validate
label: biopet-bamstats_validate
doc: "Validate a BamStats file schema.\n\nTool homepage: https://github.com/biopet/bamstats"
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
    dockerPull: quay.io/biocontainers/biopet-bamstats:1.0.1--0
stdout: biopet-bamstats_validate.out
