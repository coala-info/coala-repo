cwlVersion: v1.2
class: CommandLineTool
baseCommand: kpop_KPopTwist
label: kpop_KPopTwist
doc: "K-mer based Population structure analysis tool (Note: The provided help text
  contains system error messages and does not list available arguments).\n\nTool homepage:
  https://github.com/PaoloRibeca/KPop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
stdout: kpop_KPopTwist.out
