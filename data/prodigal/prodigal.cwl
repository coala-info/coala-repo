cwlVersion: v1.2
class: CommandLineTool
baseCommand: prodigal
label: prodigal
doc: "The provided text is a container engine error log and does not contain the help
  documentation for the prodigal tool. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/hyattpd/Prodigal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prodigal:2.60--1
stdout: prodigal.out
