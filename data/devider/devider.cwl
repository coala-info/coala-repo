cwlVersion: v1.2
class: CommandLineTool
baseCommand: devider
label: devider
doc: "A tool for processing biological data (description unavailable due to error
  in provided help text)\n\nTool homepage: https://github.com/bluenote-1577/devider"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/devider:0.0.1--ha6fb395_3
stdout: devider.out
