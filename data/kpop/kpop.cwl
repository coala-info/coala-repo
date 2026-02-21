cwlVersion: v1.2
class: CommandLineTool
baseCommand: kpop
label: kpop
doc: "No description available. The provided text contains system logs and error messages
  related to a container runtime failure rather than tool help text.\n\nTool homepage:
  https://github.com/PaoloRibeca/KPop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
stdout: kpop.out
