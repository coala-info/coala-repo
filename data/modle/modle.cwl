cwlVersion: v1.2
class: CommandLineTool
baseCommand: modle
label: modle
doc: "High-performance stochastic modeling of DNA loop extrusion (Note: The provided
  text contains container runtime error logs rather than the tool's help documentation,
  so arguments could not be extracted).\n\nTool homepage: https://github.com/paulsengroup/MoDLE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/modle:1.1.0--h63853f4_0
stdout: modle.out
