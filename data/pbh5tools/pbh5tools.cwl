cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbh5tools
label: pbh5tools
doc: "The provided text is an error log indicating that the executable 'pbh5tools'
  was not found in the system PATH. No help text or argument information was available
  to parse.\n\nTool homepage: https://github.com/zkennedy/pbh5tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
stdout: pbh5tools.out
