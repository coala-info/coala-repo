cwlVersion: v1.2
class: CommandLineTool
baseCommand: recontig_conversion-help
label: recontig_conversion-help
doc: "check availiable conversions for a specified build from dpryan79's github\n\n\
  Tool homepage: https://github.com/blachlylab/recontig"
inputs:
  - id: build
    type: string
    doc: Genome build i.e GRCh37 for using dpryan79's files
    inputBinding:
      position: 101
      prefix: --build
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print extra debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: silence warnings
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print extra information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recontig:1.5.0--h9ee0642_0
stdout: recontig_conversion-help.out
