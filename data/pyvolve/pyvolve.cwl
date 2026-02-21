cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyvolve
label: pyvolve
doc: "A Python package for simulating sequences along phylogenies. (Note: The provided
  text contains container runtime error logs rather than tool help text; no arguments
  could be extracted from the input.)\n\nTool homepage: https://github.com/sjspielman/pyvolve"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyvolve:1.1.0--pyhdfd78af_0
stdout: pyvolve.out
