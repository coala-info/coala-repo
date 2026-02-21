cwlVersion: v1.2
class: CommandLineTool
baseCommand: mustang
label: mustang
doc: "MUltiple STructural AligNment AlGorithm (MUSTANG) is a tool for the alignment
  of multiple protein structures.\n\nTool homepage: http://lcb.infotech.monash.edu.au/mustang/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mustang:3.2.4--h9948957_0
stdout: mustang.out
