cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrtk
label: lrtk
doc: "LRTK (Long-read ToolKit) is a tool for processing and analyzing long-read sequencing
  data. Note: The provided text contains system error logs and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/ericcombiolab/LRTK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
stdout: lrtk.out
