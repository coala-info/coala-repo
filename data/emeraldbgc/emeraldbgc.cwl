cwlVersion: v1.2
class: CommandLineTool
baseCommand: emeraldbgc
label: emeraldbgc
doc: "EmeraldBGC is a tool for identifying Biosynthetic Gene Clusters (BGCs). Note:
  The provided help text contains only system error messages regarding container execution
  and does not list specific command-line arguments.\n\nTool homepage: https://github.com/Finn-Lab/emeraldBGC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emeraldbgc:0.2.4.1--pyhdfd78af_0
stdout: emeraldbgc.out
