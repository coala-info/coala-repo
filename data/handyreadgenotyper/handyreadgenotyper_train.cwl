cwlVersion: v1.2
class: CommandLineTool
baseCommand: handyreadgenotyper_train
label: handyreadgenotyper_train
doc: "HandyReadGenotyper training tool (Note: The provided help text contains only
  system execution errors and no usage information).\n\nTool homepage: https://github.com/AntonS-bio/HandyReadGenotyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/handyreadgenotyper:0.1.24--pyhdfd78af_0
stdout: handyreadgenotyper_train.out
