cwlVersion: v1.2
class: CommandLineTool
baseCommand: cascade-reg
label: cascade-reg
doc: "A tool for cascade registration (Note: The provided help text contains only
  system error logs and no usage information).\n\nTool homepage: https://github.com/gao-lab/CASCADE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cascade-reg:0.5.1--pyhdfd78af_0
stdout: cascade-reg.out
