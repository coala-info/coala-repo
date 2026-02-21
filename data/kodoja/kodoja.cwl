cwlVersion: v1.2
class: CommandLineTool
baseCommand: kodoja
label: kodoja
doc: "Kodoja is a tool for taxonomic assignment of metagenomic sequencing data, particularly
  for virus identification.\n\nTool homepage: https://github.com/abaizan/kodoja/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kodoja:0.0.10--0
stdout: kodoja.out
