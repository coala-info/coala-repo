cwlVersion: v1.2
class: CommandLineTool
baseCommand: intemap
label: intemap
doc: "Integration of multiple maps for physical mapping.\n\nTool homepage: https://github.com/sinamomken/intemap-installer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intemap:1.0--py27_1
stdout: intemap.out
