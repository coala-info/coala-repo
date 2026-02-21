cwlVersion: v1.2
class: CommandLineTool
baseCommand: abismal
label: abismal
doc: "A fast and memory-efficient mapper for bisulfite sequencing reads.\n\nTool homepage:
  https://github.com/smithlabcode/abismal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abismal:3.3.0--h077b44d_0
stdout: abismal.out
