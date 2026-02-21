cwlVersion: v1.2
class: CommandLineTool
baseCommand: interproscan
label: interproscan
doc: "InterProScan is a sequence analysis application that allows users to scan protein
  and nucleic acid sequences against InterPro's signatures.\n\nTool homepage: https://github.com/ebi-pf-team/interproscan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/interproscan:5.59-91.0
stdout: interproscan.out
