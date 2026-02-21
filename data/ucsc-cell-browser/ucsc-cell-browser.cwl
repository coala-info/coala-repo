cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-cell-browser
label: ucsc-cell-browser
doc: "UCSC Cell Browser\n\nTool homepage: http://cells.ucsc.edu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-cell-browser:1.2.16--pyhdfd78af_0
stdout: ucsc-cell-browser.out
