cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - moss
  - tabix
label: moss_tabix
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/elkebir-group/Moss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moss:0.1.1--h84372a0_6
stdout: moss_tabix.out
