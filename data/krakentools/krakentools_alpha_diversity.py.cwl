cwlVersion: v1.2
class: CommandLineTool
baseCommand: alpha_diversity.py
label: krakentools_alpha_diversity.py
doc: "Calculate an alpha diversity value from a Bracken file with species abundance estimates.\n\nTool homepage: https://github.com/jenniferlu717/KrakenTools"
inputs:
  - id: filename
    type: File
    doc: "Bracken file with species abundance estimates"
    inputBinding:
      position: 1
      prefix: -f
  - id: alpha
    type:
      - 'null'
      - string
    doc: "Type of alpha diversity to calculate: Sh, BP, Si, ISi, F [default: Sh]"
    inputBinding:
      position: 101
      prefix: -a
outputs:
  - id: diversity
    type: stdout
    doc: "Alpha diversity value printed by the tool"
stdout: alpha_diversity.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
