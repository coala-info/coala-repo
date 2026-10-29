cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_suggest_tvalue
label: relion_relion_suggest_tvalue
doc: "Suggest a regularisation T-value for focussed classification or refinement from the power in a masked\
  \ region.\n\nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: map
    type: File
    doc: Consensus map
    inputBinding:
      position: 101
      prefix: --map
  - id: mask
    type: File
    doc: Mask used for focussed classification/refinement
    inputBinding:
      position: 101
      prefix: --mask
  - id: tvalue
    type:
      - 'null'
      - float
    doc: 'Standard T-value (RELION default: 4)'
    inputBinding:
      position: 101
      prefix: --T
  - id: random_tries
    type:
      - 'null'
      - int
    doc: 'Number of times to position mask randomly to find a high-power density area (RELION default:
      10)'
    inputBinding:
      position: 101
      prefix: --try
outputs:
  - id: report
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_suggest_tvalue.out
