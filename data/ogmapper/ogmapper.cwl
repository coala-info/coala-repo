cwlVersion: v1.2
class: CommandLineTool
baseCommand: ogmapper
label: ogmapper
doc: "Orthologous Group Mapper (Note: The provided text is a system error log regarding
  container execution and does not contain usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/vtrevino/ogmapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ogmapper:1.0.0--h077b44d_0
stdout: ogmapper.out
