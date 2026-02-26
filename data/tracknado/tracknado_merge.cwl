cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tracknado
  - merge
label: tracknado_merge
doc: "Merge tracknado configurations or data\n\nTool homepage: https://pypi.org/project/tracknado/"
inputs:
  - id: input_configs
    type:
      type: array
      items: File
    doc: Input configuration files to merge
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracknado:0.3.1--pyhdfd78af_0
stdout: tracknado_merge.out
