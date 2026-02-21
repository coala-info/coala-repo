cwlVersion: v1.2
class: CommandLineTool
baseCommand: gerpcol
label: gerp_gerpcol
doc: "GERP++ (Genomic Evolutionary Rate Profiling) tool for calculating site-specific
  conservation scores. Note: The provided help text contains a fatal system error
  (no space left on device) and does not list command-line arguments.\n\nTool homepage:
  http://mendel.stanford.edu/SidowLab/downloads/gerp/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gerp:2.1--hfc679d8_0
stdout: gerp_gerpcol.out
