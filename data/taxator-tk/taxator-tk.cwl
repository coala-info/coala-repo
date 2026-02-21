cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxator-tk
label: taxator-tk
doc: "A toolkit for taxonomic analysis of nucleotide sequences.\n\nTool homepage:
  https://github.com/fungs/taxator-tk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxator-tk:1.3.3e--0
stdout: taxator-tk.out
