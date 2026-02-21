cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kpop
  - KPopCountDB
label: kpop_KPopCountDB
doc: "KPopCountDB tool (Note: The provided help text contains only system error logs
  and no usage information.)\n\nTool homepage: https://github.com/PaoloRibeca/KPop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
stdout: kpop_KPopCountDB.out
