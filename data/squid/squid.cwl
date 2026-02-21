cwlVersion: v1.2
class: CommandLineTool
baseCommand: squid
label: squid
doc: "SQUID is a tool designed to detect both fusion genes and non-fusion structural
  variations from RNA-seq data.\n\nTool homepage: https://github.com/Kingsford-Group/squid"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/squid:1.5--hd6d6473_10
stdout: squid.out
