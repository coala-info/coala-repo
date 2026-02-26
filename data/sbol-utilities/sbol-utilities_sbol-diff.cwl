cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbol-diff
label: sbol-utilities_sbol-diff
doc: "Compares two SBOL files and reports differences.\n\nTool homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs:
  - id: file1
    type: File
    doc: First Input File
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: Second Input File
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug logging
    default: false
    inputBinding:
      position: 103
      prefix: --debug
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Generate no output, only status
    inputBinding:
      position: 103
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
stdout: sbol-utilities_sbol-diff.out
