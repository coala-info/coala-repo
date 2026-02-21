cwlVersion: v1.2
class: CommandLineTool
baseCommand: squeakr
label: squeakr
doc: "A k-mer counting and querying system based on the quotient filter.\n\nTool homepage:
  https://github.com/splatlab/squeakr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/squeakr:0.8--ha5d29c5_0
stdout: squeakr.out
