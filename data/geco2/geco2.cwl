cwlVersion: v1.2
class: CommandLineTool
baseCommand: geco2
label: geco2
doc: "The provided text does not contain help information or usage instructions for
  geco2. It contains container runtime error messages related to a failure to build
  a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/cobilab/geco2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geco2:1.1--h7b50bb2_5
stdout: geco2.out
