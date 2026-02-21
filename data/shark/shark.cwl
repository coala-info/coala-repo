cwlVersion: v1.2
class: CommandLineTool
baseCommand: shark
label: shark
doc: "The provided text is an error log from a container build process and does not
  contain help information or a description of the tool's functionality.\n\nTool homepage:
  https://algolab.github.io/shark/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shark:1.2.0--h9a82719_1
stdout: shark.out
