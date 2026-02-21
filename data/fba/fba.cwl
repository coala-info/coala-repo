cwlVersion: v1.2
class: CommandLineTool
baseCommand: fba
label: fba
doc: "Flux Balance Analysis tool (Note: The provided text contains container runtime
  error messages rather than tool help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/jlduan/fba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fba:0.0.13--pyhdfd78af_0
stdout: fba.out
