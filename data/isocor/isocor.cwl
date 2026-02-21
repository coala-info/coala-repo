cwlVersion: v1.2
class: CommandLineTool
baseCommand: isocor
label: isocor
doc: "No description available: The provided text contains container runtime error
  messages rather than tool help text.\n\nTool homepage: https://github.com/MetaSys-LISBP/IsoCor/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isocor:2.2.2--pyhdfd78af_0
stdout: isocor.out
