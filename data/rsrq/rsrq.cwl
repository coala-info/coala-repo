cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsrq
label: rsrq
doc: "No description available (provided text was a container build log rather than
  help text).\n\nTool homepage: https://github.com/aaronmussig/rsrq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
stdout: rsrq.out
