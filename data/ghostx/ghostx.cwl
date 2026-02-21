cwlVersion: v1.2
class: CommandLineTool
baseCommand: ghostx
label: ghostx
doc: "GhostX is a homology search tool for searching similar sequences from a large
  database. (Note: The provided help text contains only system error messages and
  no usage information; therefore, no arguments could be extracted.)\n\nTool homepage:
  http://www.bi.cs.titech.ac.jp/ghostx/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ghostx:1.3.7--h503566f_2
stdout: ghostx.out
