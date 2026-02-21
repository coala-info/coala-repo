cwlVersion: v1.2
class: CommandLineTool
baseCommand: evofr
label: evofr
doc: "A tool for evolutionary fitness and growth rate estimation (Note: The provided
  help text contains only system error messages and no usage information).\n\nTool
  homepage: https://github.com/blab/evofr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evofr:0.2.0--pyhdfd78af_0
stdout: evofr.out
