cwlVersion: v1.2
class: CommandLineTool
baseCommand: midsv
label: midsv
doc: "MIDSV is a tool for converting SAM/BAM files into MIDSV format (a concise format
  for representing mutations, insertions, deletions, substitutions, and variations).\n
  \nTool homepage: https://github.com/akikuno/mids"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/midsv:0.13.1--pyhdfd78af_0
stdout: midsv.out
