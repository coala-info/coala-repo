cwlVersion: v1.2
class: CommandLineTool
baseCommand: fast-edit-distance
label: fast-edit-distance
doc: "The provided text does not contain help information or usage instructions for
  the tool; it contains container runtime error messages regarding disk space.\n\n
  Tool homepage: https://github.com/youyupei/fast_edit_distance"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast-edit-distance:1.2.2--py39hff71179_0
stdout: fast-edit-distance.out
