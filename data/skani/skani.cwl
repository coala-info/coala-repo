cwlVersion: v1.2
class: CommandLineTool
baseCommand: skani
label: skani
doc: "The provided text is a container runtime error log and does not contain help
  information for the tool 'skani'.\n\nTool homepage: https://github.com/bluenote-1577/skani"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skani:0.3.1--ha6fb395_0
stdout: skani.out
