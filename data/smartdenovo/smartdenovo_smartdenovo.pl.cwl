cwlVersion: v1.2
class: CommandLineTool
baseCommand: smartdenovo.pl
label: smartdenovo_smartdenovo.pl
doc: "The provided text contains system error logs related to a container build failure
  and does not contain help documentation for the tool. No arguments could be extracted.\n
  \nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
stdout: smartdenovo_smartdenovo.pl.out
