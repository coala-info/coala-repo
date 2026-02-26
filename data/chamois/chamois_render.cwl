cwlVersion: v1.2
class: CommandLineTool
baseCommand: chamois_render
label: chamois_render
doc: "Render probabilities from a predictor.\n\nTool homepage: https://chamois.readthedocs.io/"
inputs:
  - id: color
    type:
      - 'null'
      - boolean
    doc: Use colored input in pager.
    default: false
    inputBinding:
      position: 101
      prefix: --color
  - id: input
    type: string
    doc: The input probabilites obtained from the predictor.
    inputBinding:
      position: 101
      prefix: --input
  - id: model
    type:
      - 'null'
      - string
    doc: The path to an alternative predictor with classes metadata.
    default: None
    inputBinding:
      position: 101
      prefix: --model
  - id: pager
    type:
      - 'null'
      - boolean
    doc: Use the given pager to display results.
    default: false
    inputBinding:
      position: 101
      prefix: --pager
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
stdout: chamois_render.out
