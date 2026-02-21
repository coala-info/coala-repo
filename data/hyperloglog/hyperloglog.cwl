cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyperloglog
label: hyperloglog
doc: "No description available (the provided text was an error log rather than help
  text).\n\nTool homepage: https://github.com/svpcom/hyperloglog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyperloglog:0.1.5--pyhe75d33f_0
stdout: hyperloglog.out
