cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa
label: autometa_autometa-binning-summary
doc: "Describe Autometa citation & version. No arguments will list the available autometa
  commands, docs and code information\n\nTool homepage: https://github.com/KwanLab/Autometa"
inputs:
  - id: citation
    type:
      - 'null'
      - boolean
    doc: Print autometa citation (APA and BibTex)
    inputBinding:
      position: 101
      prefix: --citation
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
stdout: autometa_autometa-binning-summary.out
