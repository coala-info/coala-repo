cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-objectstore
label: galaxy-objectstore
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error messages regarding a failure to build a SIF image due to
  insufficient disk space.\n\nTool homepage: https://galaxyproject.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-objectstore:25.0.4--pyhdfd78af_0
stdout: galaxy-objectstore.out
