cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - handyreadgenotyper
  - AmpliconTyper
label: handyreadgenotyper_AmpliconTyper
doc: "HandyReadGenotyper AmpliconTyper (Note: The provided help text contains only
  system error messages regarding container execution and does not list available
  command-line arguments).\n\nTool homepage: https://github.com/AntonS-bio/HandyReadGenotyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/handyreadgenotyper:0.1.24--pyhdfd78af_0
stdout: handyreadgenotyper_AmpliconTyper.out
