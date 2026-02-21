cwlVersion: v1.2
class: CommandLineTool
baseCommand: loompy
label: loompy
doc: "The provided text does not contain help information or usage instructions. It
  consists of system logs and a fatal error indicating a failure to build the container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/linnarsson-lab/loompy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/loompy:2.0.16--py_0
stdout: loompy.out
