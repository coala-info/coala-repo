cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextpolish
label: nextpolish
doc: "NextPolish is a tool for fast and read-depth independent genome polishing. (Note:
  The provided help text contains only system error messages and no usage information.)\n
  \nTool homepage: https://github.com/Nextomics/NextPolish"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextpolish:1.4.1--heebf65f_5
stdout: nextpolish.out
