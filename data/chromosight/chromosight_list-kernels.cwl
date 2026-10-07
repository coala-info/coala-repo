cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chromosight
  - list-kernels
label: chromosight_list-kernels
doc: "Prints information about available kernels.\n\nTool homepage: https://github.com/koszullab/chromosight"
inputs:
  - id: long
    type:
      - 'null'
      - boolean
    doc: Show default parameters in addition to kernel names.
    inputBinding:
      position: 1
      prefix: --long
  - id: mat
    type:
      - 'null'
      - boolean
    doc: Prints an ascii representation of the kernel matrix.
    inputBinding:
      position: 1
      prefix: --mat
  - id: name
    type:
      - 'null'
      - string
    doc: 'Only show information related to a particular kernel. [default: all]'
    inputBinding:
      position: 1
      prefix: --name
outputs:
  - id: stdout
    type: stdout
    doc: Kernel information
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosight:1.6.3--pyhdfd78af_0
stdout: chromosight_list-kernels.out
