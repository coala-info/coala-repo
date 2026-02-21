cwlVersion: v1.2
class: CommandLineTool
baseCommand: dx
label: dxpy_dx
doc: "DNAnexus Command Line Interface (Note: The provided text contains system error
  logs regarding container image retrieval and does not list specific tool arguments
  or help documentation.)\n\nTool homepage: https://github.com/dnanexus/dx-toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
stdout: dxpy_dx.out
