cwlVersion: v1.2
class: CommandLineTool
baseCommand: chamois_explain
label: chamois_explain
doc: "Explain which domains contribute to a class prediction.\n\nTool homepage: https://chamois.readthedocs.io/"
inputs:
  - id: mode
    type: string
    doc: "Specify the explanation mode: 'class', 'feature', or 'cluster'."
    inputBinding:
      position: 1
  - id: model
    type:
      - 'null'
      - string
    doc: The path to an alternative model to extract weights from.
    default: None
    inputBinding:
      position: 102
      prefix: --model
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
stdout: chamois_explain.out
