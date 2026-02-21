cwlVersion: v1.2
class: CommandLineTool
baseCommand: musicc
label: musicc
doc: "MUSICC (Marker Genes-based Unsupervised Single-copy Core genes) is a tool for
  normalizing metagenomic data. Note: The provided text contains system error messages
  and does not list specific command-line arguments.\n\nTool homepage: http://elbo.gs.washington.edu/software_musicc.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/musicc:1.0.4--py_0
stdout: musicc.out
