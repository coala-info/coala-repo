cwlVersion: v1.2
class: CommandLineTool
baseCommand: terrace
label: terrace
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/Shao-Group/TERRACE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/terrace:1.1.2--he153687_0
stdout: terrace.out
