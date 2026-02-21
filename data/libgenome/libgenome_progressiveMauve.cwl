cwlVersion: v1.2
class: CommandLineTool
baseCommand: progressiveMauve
label: libgenome_progressiveMauve
doc: "The provided text is a system error message indicating a failure to build a
  container image due to lack of disk space, rather than the help text for the tool.
  Consequently, no arguments or tool descriptions could be extracted.\n\nTool homepage:
  http://darlinglab.org/mauve/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libgenome:1.3.1--h9f5acd7_4
stdout: libgenome_progressiveMauve.out
