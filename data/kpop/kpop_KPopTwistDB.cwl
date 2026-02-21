cwlVersion: v1.2
class: CommandLineTool
baseCommand: kpop
label: kpop_KPopTwistDB
doc: "K-mer based Population structure tool (Note: The provided text is an error log
  and does not contain usage information or argument definitions).\n\nTool homepage:
  https://github.com/PaoloRibeca/KPop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
stdout: kpop_KPopTwistDB.out
