cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - handyreadgenotyper
  - classify
label: handyreadgenotyper_classify
doc: "HandyReadGenotyper classification tool (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  https://github.com/AntonS-bio/HandyReadGenotyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/handyreadgenotyper:0.1.24--pyhdfd78af_0
stdout: handyreadgenotyper_classify.out
