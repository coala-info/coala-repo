cwlVersion: v1.2
class: CommandLineTool
baseCommand: pygrgl
label: pygrgl
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://aprilweilab.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygrgl:2.5--py39h475c85d_0
stdout: pygrgl.out
