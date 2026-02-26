cwlVersion: v1.2
class: CommandLineTool
baseCommand: tb-ml
label: tb-ml
doc: "TB-ML: A framework for comparing AMR prediction in M. tuberculosis. Provide
  Docker image names and arguments like so: --container CONTR_NAME_1 \"ARG_1 ARG_2\"\
  \ --container CONTR_NAME_2 \"ARG_3\" --container CONTR_NAME_3 \"ARG_4 ARG_5\" ...\n\
  \nTool homepage: https://github.com/jodyphelan/tb-ml"
inputs:
  - id: container
    type:
      type: array
      items: string
    doc: Name of Docker image and corresponding extra arguments
    inputBinding:
      position: 101
      prefix: --container
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-ml:0.1.1--pyh7cba7a3_0
stdout: tb-ml.out
