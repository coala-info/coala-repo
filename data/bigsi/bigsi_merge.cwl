cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigsi-v0.3.1 merge
label: bigsi_merge
doc: "\nTool homepage: https://github.com/Phelimb/BIGSI"
inputs:
  - id: config
    type: string
    doc: Basic text / string value
    inputBinding:
      position: 1
  - id: merge_config
    type: string
    doc: Basic text / string value
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigsi:0.3.1--py_0
stdout: bigsi_merge.out
